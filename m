Return-Path: <linux-kernel+bounces-208925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA1902AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DCC2821B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D56F311;
	Mon, 10 Jun 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNleXRnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F55588B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055446; cv=none; b=YvqLOIXwtERYbAOZDujwVwk1m9YozVZgKCoJNLluCDcjQiCboT9FFWNiSh2uS9/mak9AqGePZzbpYS79QQXDr4ayDO5bwl1VvHxyphmblc55PqjDXXHW6RgEpdcBCM0vLtNrzb8qJGQYw/uGDxmvese0DjA5uNFM7Zh6wXgeeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055446; c=relaxed/simple;
	bh=mGFu6cSxcGL7BAm7VjvH2ETdU/guKysdduxH3UuB8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDcyeia2hO3RHVE4SA1T8BI5KM4r2T2tIotXyYyK5CcyP4nRbV8O3ZE3IsATLA0NqYLQncYAYU+KKdpyOWh3HcjVXBsKa2rPoVqhCoyG00QtWnsaVx3FO48tLWFMWefZPXQ4aSc9/uVsfd1uy9mFZNiQtJ8/drnW6OOjzVmZt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNleXRnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A5C2BBFC;
	Mon, 10 Jun 2024 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055446;
	bh=mGFu6cSxcGL7BAm7VjvH2ETdU/guKysdduxH3UuB8uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNleXRncGXQ9/iFza5UxOCk38K5FYIdK2YFgojVYExC8X6QPuAmxb4ZgVf6RjyvnW
	 +zMsjl+Xg/vNaNbTT0L2rrNjK4Hg0KV3lL01wIZJNsnguJCbvZRGnkPHHbssdWb1ng
	 7C7M0jTh6mrbXt+rMmit/gOOOcdkX5oDUgJKJtjgy+ph+hLNLgOBl2zR0DsN0Itvw3
	 u9PwKVYsnp1lyH968nXrQLJ4nshr/bp6qZOp4TfjQw07JzsuWSvpsZohBbV+HQnl7r
	 0ZkP5wK/SLdd1DQd6ZxMUhYBcxF/gqqEpgcdj16CDrA+4ZUlAa0qVgIbEpUJtSAl67
	 ugvinssUledtw==
Date: Mon, 10 Jun 2024 14:37:25 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
Message-ID: <202406101435.DFBCA953B@keescook>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
 <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
 <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
 <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>

On Mon, Jun 10, 2024 at 10:54:26PM +0200, Vlastimil Babka wrote:
> On 6/10/24 7:07 PM, Christoph Lameter (Ampere) wrote:
> > On Fri, 7 Jun 2024, Chengming Zhou wrote:
> > 
> >> There are two inconsistencies in check_object(), which are alignment
> >> padding checking and object padding checking. We only print the error
> >> messages but don't return 0 to tell callers that something is wrong
> >> and needs to be handled. Please see alloc_debug_processing() and
> >> free_debug_processing() for details.
> > 
> > If the error is in the padding and the redzones are ok then its likely 
> > that the objects are ok. So we can actually continue with this slab page 
> > instead of isolating it.
> > 
> > We isolate it in the case that the redzones have been violated because 
> > that suggests someone overwrote the end of the object f.e. In that case 
> > objects may be corrupted. Its best to isolate the slab and hope for the 
> > best.
> > 
> > If it was just the padding then the assumption is that this may be a 
> > scribble. So clean it up and continue.

"a scribble"? :P If padding got touched, something has the wrong size
for an object write. It should be treated just like the redzones. We
want maximal coverage if this checking is enabled.

> Hm is it really worth such nuance? We enabled debugging and actually hit a
> bug. I think it's best to keep things as much as they were and not try to
> allow further changes. This e.g. allows more detailed analysis if somebody
> later notices the bug report and decides to get a kdump crash dump (or use
> drgn on live system). Maybe we should even stop doing the restore_bytes()
> stuff, and prevent any further frees in the slab page to happen if possible
> without affecting fast paths (now we mark everything as used but don't
> prevent further frees of objects that were actually allocated before).
> 
> Even if some security people enable parts of slub debugging for security
> people it is my impression they would rather panic/reboot or have memory
> leaked than trying to salvage the slab page? (CC Kees)

Yeah, if we're doing these checks, we should do the checks fully.
Padding is just extra redzone. :)

-- 
Kees Cook

