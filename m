Return-Path: <linux-kernel+bounces-382759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77219B1304
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34BF1C2298C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB21D3656;
	Fri, 25 Oct 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gif7aYCh"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574842AA4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897354; cv=none; b=nfQxFB8HIk9gk4qKvMDWTDyx1bR9/PhpEtSi2qlZxqI1Y7LjaXqpXm3SIdaAIjnXJyCmyCqE+Xop1tElFFoqqXPm8qoOEDPFL/FdPFs4GNM/KQr5f05M69PQ3ec0HbUJaeGnVicaxCirROI+CFUECP4IBs4PGe1bR5xvqgouqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897354; c=relaxed/simple;
	bh=J90Pj19ccmEPx/0yEfSYXuEQcFsXj7M+RYrcVA5Ty+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb7CHLgimr+uP3akIGY57zJNL/9gBFZGsNyANCbUJPW8nOfP9hwLXdUcfe1A9plmVs2tSZfPVMbuCmZ0Uea0BhrI7txjkG09X4QyT9i7bRFLcQI+Qxq6WbZA/1QP6brrPOkb86aMf8LnFuMD3V7vp9ByaM0bHyA94l4X6uXijkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gif7aYCh; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 19:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729897349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPzsJzIsAez3i0wMGgH+AnxCK9b1hApXiViSv0TBZ1s=;
	b=Gif7aYChJYVH9yw9BpNkBpaw8VEZ9m0IlDUbwdt3Bq/CWwHg+M7ckEvqnqkCmZ4JYkg1VS
	EavXD18x/bjOtIegQezb8eaQmpLOwk3GS5DhhHsJYwNYpXbe869tjF8di41o4tRtRAur5J
	6L5AteU+4TgLthW8tdifU7kYMHAdSFQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: manas18244@iiitd.ac.in, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anup Sharma <anupnewsmail@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "bcachefs: Add asserts to
 bch2_dev_btree_bitmap_marked_sectors()"
Message-ID: <ecj7k7b7buss7f7vhfzzsvnq6hdka3wziytih42g76yt2zgh3j@lo5f2n2lujk3>
References: <20241021-revert-assert-bch2-v1-1-e869c7c55bb6@iiitd.ac.in>
 <rd4maufxfunrcpzkoo2jszorzl256fiktw3p5yfpnjpu2ajh4l@5wvkfxwzajax>
 <26394.37450.21740.720541@quad.stoffel.home>
 <bv4dfgmq4wmfcon2thkvhthqjlrpr5h4nmhfuusj4lh2wrj5ao@ckmvt63s67r6>
 <26396.3323.858567.266417@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26396.3323.858567.266417@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 05:26:19PM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > On Thu, Oct 24, 2024 at 02:30:34PM -0400, John Stoffel wrote:
> >> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> >> 
> >> > On Mon, Oct 21, 2024 at 10:18:57PM +0530, Manas via B4 Relay wrote:
> >> >> From: Manas <manas18244@iiitd.ac.in>
> >> >> 
> >> >> This reverts commit 60f2b1bcf519416dbffee219132aa949d0c39d0e.
> >> >> 
> >> >> This syzbot bug[1] is triggered due to the BUG_ON assertions added in
> >> >> __bch2_dev_btree_bitmap_mark. During runtime, m->btree_bitmap_shift is
> >> >> 63 '?'. This triggers both the assertions.
> >> 
> >> > The BUG_ON() doesn't need to be deleted; we just need to fix the
> >> > validation so it doesn't fire (it doesn't particularly matter if it's
> >> > removed or not, ubsan would catch it without the BUG_ON()).
> >> 
> >> Shouldn't the BUG_ON() be replaced with making the filesystem readonly
> >> instead if you're going to keep it?  I'd rather have the filesystem
> >> still be mounted and able to be read, but not writeable, instead of
> >> having my system crash before I can do anything.  
> 
> > Not in this case. In general, if there's a chance of the BUG_ON()
> > hitting in the wild after the code has passed testing then it
> > shouldn't be a BUG_ON(), but this is low level validation that we're
> > relying on.
> 
> So I'm having a hard time parsing this reply.  And I don't think you
> make a good case for leaving or even having a BUG_ON() here at all.
> If there's a chance of it hitting in the wild, it should be removed.
> But you don't want to remove it because it will never hit?  That's
> just lazy... :-)   I just don't see why a filesystem should have the
> opportunity to kill an entire system because that one filesystem has
> problems.  

No, it's not lazy.

Code with assertions is much more robust and reliable, because bugs
shake out faster. An assertion pop is _much, much_ easier to debug than
wandering off into undefined behaviour land.

Assertions are also documentation that can't go out of date.

They make later refactoring much safer and easier, as well.

