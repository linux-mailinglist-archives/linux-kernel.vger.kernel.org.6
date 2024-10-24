Return-Path: <linux-kernel+bounces-380703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B214D9AF4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAAD1F22410
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7E1C7281;
	Thu, 24 Oct 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLu5NAAD"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B41B2188
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805817; cv=none; b=JTZKoU7bWkYytn2A+VyeKyqeBtAtcan1e/DRrVX7Jypzcon9/iTlOlbn09lOx9Y/LnLic8j9z1urTRfACLA6gHRtpiJ0qkxSo6WlmleB+8+7+zv2bf8jDIuL0WGMsHQbBbVuWDjhr+jg0GLXCnZxqMJa08tWxFyZiBGWDeiWfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805817; c=relaxed/simple;
	bh=IPAXAFDtWc24F7DwV/zE14Lt1WJ5nYZ7ST8lqpg/f/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgp3KSqxBlqKCujZX8kGbSsfa5fOgG90buLVfeiU2uIdQwR8d1xtxdl7YtNZtmFk/RMoPqcM2sSDzOSWz53r9A/WdsRDcNTD5R4KO1Mo6/1vDTH3vr/1Tls4jbnFUmpxKaeotWxI215BIPOVJ6Rlu6YQf6sYj0ifYZVQhxGFs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLu5NAAD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 17:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729805812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBKRf6RODsyjRB06ptgr/RKZU0dd/jnCg0QdwxvyiVo=;
	b=lLu5NAADLUYY7AXdUTmHjcg+gZkbCBLYlbMtHq+fYZx3mDR0WiOs6XBRXDFsAKIfZ/uP9Q
	Ourt5Z5bskLTWLa8tMHWelVDCIUudNp5fl6IEr36Gfj0oq4b9d15mHU+LT7hFsc8Rs4ml9
	35rrrwwfSRF3/tB5A9FaljqEKD5prOA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: manas18244@iiitd.ac.in, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anup Sharma <anupnewsmail@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "bcachefs: Add asserts to
 bch2_dev_btree_bitmap_marked_sectors()"
Message-ID: <bv4dfgmq4wmfcon2thkvhthqjlrpr5h4nmhfuusj4lh2wrj5ao@ckmvt63s67r6>
References: <20241021-revert-assert-bch2-v1-1-e869c7c55bb6@iiitd.ac.in>
 <rd4maufxfunrcpzkoo2jszorzl256fiktw3p5yfpnjpu2ajh4l@5wvkfxwzajax>
 <26394.37450.21740.720541@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26394.37450.21740.720541@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 02:30:34PM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > On Mon, Oct 21, 2024 at 10:18:57PM +0530, Manas via B4 Relay wrote:
> >> From: Manas <manas18244@iiitd.ac.in>
> >> 
> >> This reverts commit 60f2b1bcf519416dbffee219132aa949d0c39d0e.
> >> 
> >> This syzbot bug[1] is triggered due to the BUG_ON assertions added in
> >> __bch2_dev_btree_bitmap_mark. During runtime, m->btree_bitmap_shift is
> >> 63 '?'. This triggers both the assertions.
> 
> > The BUG_ON() doesn't need to be deleted; we just need to fix the
> > validation so it doesn't fire (it doesn't particularly matter if it's
> > removed or not, ubsan would catch it without the BUG_ON()).
> 
> Shouldn't the BUG_ON() be replaced with making the filesystem readonly
> instead if you're going to keep it?  I'd rather have the filesystem
> still be mounted and able to be read, but not writeable, instead of
> having my system crash before I can do anything.  

Not in this case. In general, if there's a chance of the BUG_ON()
hitting in the wild after the code has passed testing then it shouldn't
be a BUG_ON(), but this is low level validation that we're relying on.

In general higher level code absolutely requires that the low level
validation is correct, because if it's not that will trigger all sorts
of undefined behaviour in the upper layers.

By "low level validation" I mean _only_ the validate functions that
check simple invariants within a single data type that is read or
written atomically to disk - "is data type garbage or not".

If it's an invariant that involves multiple objects - "does this extent
refer to a valid device/snapshot ID" - that's not something we can check
in validate, because then an extent or what have you would become
invalid depending on what happens in the rest of the filesystem. Those
sorts of checks do in fact need proper error paths.

