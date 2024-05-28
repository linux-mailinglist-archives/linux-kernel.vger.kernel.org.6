Return-Path: <linux-kernel+bounces-191606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70E8D1164
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA2E1F21935
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB29450;
	Tue, 28 May 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kg+YiZHD"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1E15BB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716859146; cv=none; b=uN4Qp1GSbFla9M/wFD/HYI//le4wox9N5uBCovfK78hzHzcxEmgZbu+jRrpU0zpgvJetovlWHAVOzlZ7a53R76JB3UdXP2CX2Q63rNvGyjSSTu+PUTn+3t2OlDxTh92Tqdkh0BXf31Yr92aq/4YpFg82yDZSjNtUiDeWx98hyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716859146; c=relaxed/simple;
	bh=KnD8oh5qhi7MNuAUkQo6zkbODaVzHZhpYFWBOMojA04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwr++7KIElbINhjN2kr2trISenJWmk9yYEGU2ZN7PBS8jDXvRX/GjHycMiK3eJSejQmGSZSwZaFBgc+4LtEgJWibxz8mr02D2tBtsAe1LceIofDEJA2IWZFNRbAGyw3v22AD3GKgbunNFhWDU58rzpkVA8DZNUbzMgdA7vDgngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kg+YiZHD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sfr@canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716859140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQny9xk+mpw4ER38XcTOmAry5fkOJEKQTjT/GCnCDAU=;
	b=kg+YiZHDZtKT1PpTK8WP/85V2DPaRgezBpSeKZqb95geJo6rIHw2cUFU0SRlHJZ/YNA/Nh
	KNt+9ga3neo1gvfL4Rp4lMSSWZ54q4SDyZmYQu+7kloNg2DyI6mrEluafHFx3VnkSBYRT1
	KqBoPlMkbCYjSeSWpN9hSLD8Qabbq4E=
X-Envelope-To: visitorckw@gmail.com
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: colyli@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-next@vger.kernel.org
X-Envelope-To: matthew@mm12.xyz
X-Envelope-To: akpm@linux-foundation.org
Date: Mon, 27 May 2024 21:18:56 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Coly Li <colyli@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Matthew Mirvish <matthew@mm12.xyz>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: manual merge of the refactor-heap tree with the
 block tree
Message-ID: <xwodecpshjpwgcrrssbmd6zbk6g3ah343t4zjlqdbnpcnc3vkq@k7anzy5e4ek6>
References: <20240509152745.08af752f@canb.auug.org.au>
 <20240528110737.730a8f40@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528110737.730a8f40@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 11:07:37AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 9 May 2024 15:27:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the refactor-heap tree got conflicts in:
> > 
> >   drivers/md/bcache/bset.c
> >   drivers/md/bcache/bset.h
> >   drivers/md/bcache/btree.c
> >   drivers/md/bcache/writeback.c
> > 
> > between commit:
> > 
> >   3a861560ccb3 ("bcache: fix variable length array abuse in btree_iter")
> > 
> > from the block tree and commit:
> > 
> >   afa5721abaaa ("bcache: Remove heap-related macros and switch to generic min_heap")
> > 
> > from the refactor-heap tree.
> > 
> > Ok, these conflicts are too extensive, so I am dropping the refactor-heap
> > tree for today.  I suggest you all get together and sort something out.
> 
> It looks as though the patches from the refactor-heap tree are now being
> carried in the mm-nonmm-unstable branch of the mm tree.  Should I
> rmeove the refactor-heap tree from linux-next?  It *will* be dropped for
> today at least.

Yeah, Andrew's got it

