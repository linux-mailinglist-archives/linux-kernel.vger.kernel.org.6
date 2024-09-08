Return-Path: <linux-kernel+bounces-320254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E0970805
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF01C21658
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9AAEACD;
	Sun,  8 Sep 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJXeX0+B"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83329CF7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804877; cv=none; b=d9hM/I+U5rxd2EO8S+smDqWnqpkl0Vb59/LoIop9ompl0hM/WUp07cK+gZ/Z1s7XliwRSPIoBuBelzphNZxiJV4C3N9ifoLjQ0esC7hFWKvN1QY/0BERix9rgfDMVXVztFWuQd4yBzn3XR4bTOEu3QwBz5pd0CyGFu0U77+7DdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804877; c=relaxed/simple;
	bh=pVG0GXqZOUpd40QUu1Jnj0BaAzBx8sg/oLdk6Nts00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/pv6qisAdtqU4USfBLSsYo53cZv+gQ6lzDuPyRnXiSrOpKbUNfMoAhX0IBzMvChJGhu4Hbsqvd0Mj+WiPQKkwNjkr8DJgPmK7PiszMs6s8lk3UkiDSFP7yR8kg4KPE8lPbO1nR3t/pVPSsiPFnKW24rxt7pEWyHQx8x/cNgTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJXeX0+B; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 8 Sep 2024 10:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725804873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFddgAzZNjUy5uTssPOtVJWQ0TFEeB5OYPJI1zXfgGk=;
	b=vJXeX0+BJZ3NH+qYik7gTN8hsHp25uAG/QWXJjIqz7YnU4jz2jfbmLKmNT3OjpM6EJD4Gj
	2bBS1vYkEOUI/Gc/KoYpK6fpdPHXufjjRBwl/xDBMNazl3c2t8JQr0bSfRVtA7enEzFsBF
	ic3VQ5Nzm8H5L0nJWMDGYYA6HkcPmU0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+064ce437a1ad63d3f6ef@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in member_to_text
Message-ID: <rr2rkewhp7c4fcewi5mlpda44cjikwfuycrgaplpk53vgrp5vp@q7sj5mlnkm5c>
References: <hqzhbzxbp3rjbal3z4kdwygvus76h22o2br3iwuzohgniivw5q@etyntoz75vyp>
 <tencent_6FF377237A096263A9C4469779777566C805@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6FF377237A096263A9C4469779777566C805@qq.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 08, 2024 at 08:59:37PM GMT, Edward Adam Davis wrote:
> On Wed, 4 Sep 2024 15:39:37 -0400, Kent Overstreet wrote: 
> > On Tue, Sep 03, 2024 at 10:13:02AM GMT, Edward Adam Davis wrote:
> > > Because the value of m.btree_bitmap_shift is 69 in this case, it cause
> > > shift-out-of-bounds in member_to_text.
> > >
> > > Add a check for btree_bitmap_shift in validate_member, when it bigger than 64
> > > return -BCH_ERR_invalid_sb_members.
> > > Simultaneously adjust the output mode of btree_bitmap_shift in member_to_text.
> > >
> > > #syz test
> > >
> > > diff --git a/fs/bcachefs/sb-members.c b/fs/bcachefs/sb-members.c
> > > index 39196f2a4197..85a4245ea6a3 100644
> > > --- a/fs/bcachefs/sb-members.c
> > > +++ b/fs/bcachefs/sb-members.c
> > > @@ -162,6 +162,12 @@ static int validate_member(struct printbuf *err,
> > >  		return -BCH_ERR_invalid_sb_members;
> > >  	}
> > >
> > > +	if (m.btree_bitmap_shift > 64) {
> > 
> > should be >=, no?
> Yes, you are right, here should be "if (m.btree_bitmap_shift >= 64)"

Send me a proper patch and I'll apply...

