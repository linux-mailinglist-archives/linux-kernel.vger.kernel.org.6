Return-Path: <linux-kernel+bounces-269450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B5943300
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231A1B2AFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C41BD01E;
	Wed, 31 Jul 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HamQ6Tch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC1758B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438647; cv=none; b=oVofV+aszEMbJP2zapX+pOmj+bqoFBza9RjKP5drZytM8tuXqVSRG5AbwH3cFTV5DSCpTrlfrtON/kHFaxs1WuffjORqV1zQuZ2X25P1mXekHJdr+7lVRidu1zZ8U3oUQNzq9LEMsNa4czwm1QoO61ZJBL3Smf4KTaoRO6M4mHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438647; c=relaxed/simple;
	bh=Pf8EjYSKJ/t5a9MR9XPy+taLRYqkt6RZTuscIRz+QcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUuqxJ3UI2g7zXPTkvIMZZKPKHAZwfwnsbqvXRpY2B2+fP9IErUN6ei7gE9RGv5rJumZRiUIadNx90crH21gkjQmuDV7DDe6WJJDI5SCo+eo+ri1vACKe2PvZpI7MSNEfBWgcvjmGSKEcJ1pZcuW508envLhx/r5FK0YoWlWJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HamQ6Tch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECECC116B1;
	Wed, 31 Jul 2024 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722438646;
	bh=Pf8EjYSKJ/t5a9MR9XPy+taLRYqkt6RZTuscIRz+QcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HamQ6TchVsbV2G8qMAkTEObyvhg84S2XI6zpwTfCO/ak0HJYKBn0zf+CI+HV5Zpm3
	 dmnVZsC8SF0aezKnKu++vvmm4wF+Rh5vksQU2tGldNyJftnfcvl+lja/mXrkiTvTcb
	 hAWsd7AeeojDBHNLaiZ0C3tA4emalOL50S0aRvg3PrEiRgPoxgFoYgAqDNSEdXVR0k
	 v3zTk60rfky45CTKHDf3jOkorj1SsmPLjqbqKrA1nx35c6hs4XT6aBNGLzzOvgh2K7
	 9+v4UIj9ue4p9TO+vZrRAts+Wny2qjIrZTsSJPIkKih2U/pfqIEGQkPiQO93+tv+5B
	 je2MOKc1+Xsbg==
Date: Wed, 31 Jul 2024 17:10:42 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, mhocko@suse.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: vrealloc: properly document __GFP_ZERO behavior
Message-ID: <ZqpT8n3SduevSg7z@pollux>
References: <20240730185049.6244-1-dakr@kernel.org>
 <20240730185049.6244-4-dakr@kernel.org>
 <20240730141953.a30fa50c0ba060fe0a765730@linux-foundation.org>
 <ZqlsdtTWhRahFWmy@pollux.localdomain>
 <4908d9a3-8b04-4808-8190-c1b602cba9dd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4908d9a3-8b04-4808-8190-c1b602cba9dd@suse.cz>

On Wed, Jul 31, 2024 at 04:43:39PM +0200, Vlastimil Babka wrote:
> On 7/31/24 12:43 AM, Danilo Krummrich wrote:
> > On Tue, Jul 30, 2024 at 02:19:53PM -0700, Andrew Morton wrote:
> >> On Tue, 30 Jul 2024 20:49:43 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> >> 
> >> > Properly document that if __GFP_ZERO logic is requested, callers must
> >> > ensure that, starting with the initial memory allocation, every
> >> > subsequent call to this API for the same memory allocation is flagged
> >> > with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> >> > honored by this API.
> >> 
> >> I appear to have just seen this, in a separate mailing.
> > 
> > What you have seen in a separate mail is a similar patch for krealloc() [1].
> > This one is a fixup for vrealloc() from a previous submission you've applied to
> > mm-unstable.
> > 
> >> 
> >> Please, slow down.  We have two months.  Await reviewer feedback, spend
> >> time over those changelogs, value clarity and accuracy and completeness
> >> over hastiness.  The only reason for rushing things is if a patch is
> >> disrupting ongoing testing of the linux-next tree.
> > 
> > There was a discussion in [2], which lead to this fixup series.
> > 
> > In terms of changelogs this series is indeed a bit "lax", since I have
> > recognized that you queue up fixup patches for changes that did already land in
> > mm-unstable to be squashed into the original commits later on.
> 
> Some of the changes in the fixups would however ideally result in udpdates
> to the original changelogs in addition to squashing code. Also with 4 fixups
> to 2 original patches it might be IMHO better to squash on your side and
> resend as a full replacement. Perhaps also together with the other 2 patches
> about __GFP_ZERO for krealloc in a single series. As Andrew mentioned we are
> early in the rc phase to afford this.

(JFYI, Andrew applied the fixups meanwhile.)

I also don't think that they lead to updates of the commit messages.

But yes, we can proceed with:

(1) leave [1] as it is (with the fixups applied to mm-unstable already) and send
    v2 of [2]
(2) send a v3 for [1] that also includes [2]
(3) send a v3 of [1] and a separate v2 for [2]

Just let me know what you prefer. I'm fine with either of those. :)

[1] https://lore.kernel.org/linux-mm/20240722163111.4766-1-dakr@kernel.org/
[2] https://lore.kernel.org/linux-mm/20240730194214.31483-1-dakr@kernel.org/

