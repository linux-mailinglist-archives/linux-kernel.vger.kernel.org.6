Return-Path: <linux-kernel+bounces-212098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD6905B34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B279DB24A59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823C74E0C;
	Wed, 12 Jun 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzRr01nS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB16F073
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217561; cv=none; b=H2/kfv0nRK2hA+xI8dsR5s/tw280mTx/rWdl2c7USTPy5NPfs4QMZSm387AbYD/7h36NGoFIkMkju9j9tWLhGlhS4tfSNu2vVKZdskStYfYcpgibaLOE2ZvXSQZd/YTceL9mY6SfWrd8+euZhVnOPZYjleqBUySjvxmw6mOntGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217561; c=relaxed/simple;
	bh=MJVHRfHxaj60Hxhysjmfq/EOEVzWOTcWYElXRx7ibPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/hjto4uGmGyhPTZt9DGz2fsI+InOFQE/uw9tedjHRIHW6U7Pwu/VbOM3r7FyP/CDk6Z7FyL467tndYqoPdRuVo6ZbPVeXiKmthsRFy3zc1kGTDg76t551XtlOyYJaLQoawiXlg6iOaFAw7DUs0fP9c2bU8cOigS80KMY9/ihNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzRr01nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C51C116B1;
	Wed, 12 Jun 2024 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217560;
	bh=MJVHRfHxaj60Hxhysjmfq/EOEVzWOTcWYElXRx7ibPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzRr01nSYr1S44pbL4683JbDFh4GYvuUS/2Ofesh3Z4B5uaQ+kRkCRG39mDhAn0GI
	 vfVpxlR93ToKvKjsl+r9mJlCqJ7Ee7Pmzsy9tWmXs4MGllFzMegoH4kOcvgTRR+WTL
	 8L0KPjiDxrnjRw9bB97mwfLNL+UTtpXF/77wEYXHZ6wZzh8ShupTgm9XaHTOMDZrNR
	 Vh99JEjgq/ISlIDVzLHIMo3B89SZbLQxU9+TLmmGylhIQzufbHGZ+ppZRAJg0d1IUC
	 HhmV1nbdeMXkwVAGJPJIfHnYZ9HUmx415ClIB4+sR0W5ds5Co16KlV8uRLb4+xvdQU
	 HnVc9gQ1W6qnw==
Date: Wed, 12 Jun 2024 11:39:19 -0700
From: Kees Cook <kees@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <202406121135.A3900578BF@keescook>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
 <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
 <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
 <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
 <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93fc5a6-434f-376c-a819-353124da053d@linux.com>

On Tue, Jun 11, 2024 at 03:52:49PM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 10 Jun 2024, Vlastimil Babka wrote:
> 
> > Even if some security people enable parts of slub debugging for security
> > people it is my impression they would rather panic/reboot or have memory
> > leaked than trying to salvage the slab page? (CC Kees)
> 
> In the past these resilience features have been used to allow the continued
> operation of a broken kernel.
> 
> So first the Kernel crashed with some obscure oops in the allocator due to
> metadata corruption.
> 
> One can then put a slub_debug option on the kernel command line which will
> result in detailed error reports on what caused the corruption. It will also
> activate resilience measures that will often allow the continued operation
> until a fix becomes available.

Sure, as long as it's up to the deployment. I just don't want padding
errors unilaterally ignored. If it's useful, there's the
CHECK_DATA_CORRUPTION() macro. That'll let a deployment escalate the
issue from WARN to BUG, etc.

-- 
Kees Cook

