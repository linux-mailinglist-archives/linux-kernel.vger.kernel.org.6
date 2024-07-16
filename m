Return-Path: <linux-kernel+bounces-253441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A993215E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A41F21D21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78B37143;
	Tue, 16 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEGJZSAj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8D4405
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115726; cv=none; b=HCfd0JZdOHTJ06U5YvQa3GCSNVfpuWZsLrJ7RTEXS6yjcciDdCgHEJmYJMZGENV5kxSKexLSfw2vBWaOWsn52hieP0Qy6zUt5hRhTYsPkqSjRd8nLo+ku1lOOCGgZBksGqZTnJxk3WoMtfJtZBOylUIqdgjXM0c9i1fa9r1Jr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115726; c=relaxed/simple;
	bh=f+wOrf9mtkpOgCQx+nYf5YlwWmfujzURrYhlPbCepsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfCO4c8hbOri0Afo+YnnTi0vhAkgak5DnxbsXC42zIr9MDJ8HtIPcN/QTYf1QqJng6eDXCKd9dk12I4XtfZLzcbjwxJIKzZZbI8mYcFTa/d3PN0R/Up3oy/2YHZRjEXdPZDPahm3Hs3AEaQkFp0Gtl4xt9a1yWqr3FEFW/Sfsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEGJZSAj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9a920e73so5784535e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721115722; x=1721720522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6oQBxZ5QuGyuJ0jlNZgghoqLrDpW/cpGfahJKhccgs=;
        b=ZEGJZSAjAHaak/pAZ5Ao0dFJB0g8p7KAd2+fPoAfFs+gv2dbQ5flUGpRPWXKTtvmLw
         OiC2FQDOA/XknUYatCQKskLgxd2oqEY16YFJFQ0GxB8uUWlIccbq1D7rDv8Y/f5ecojF
         zcnotWGAJIgeU0rPrgXVCkq8tRxBVeWekSnIZBEinFR5NH+2cEqTETz0djsjBSZQi/Rv
         UwZCEUBaZ1hph2C/OFFo5zB/+ocq/zyURRCeBFDxqOhPVUZR3qqYH8QPNLS5iVucAmQT
         gt14rlL1fbLNMufz1dofpFn/VU4MKSALumyN4A43X747awYP1Hn38jQVzHk9ktUbrV5v
         +IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115722; x=1721720522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6oQBxZ5QuGyuJ0jlNZgghoqLrDpW/cpGfahJKhccgs=;
        b=ljkz+mthwaqChP4uJzaTnd+zSBfg4ani6XXf9c/RXswrs7C3KxJyogWgyC3W3TM3zY
         m6+2Ft2zBZYS8EXTiQlzdgm5QBu3GnsUtIDCsbAu8cRNfQyDNT8QQYUytJmob0c1mf3p
         iGYKvdVPoz4gr3zyfkdEa/+4q2cA/9WmzlIoY9mF3BmmsU4ytjvlIbSbJ8IkKXx+Pk2c
         6hz5i9Pwe5mb8KKD3hmuNfViwcvgs3Ean4d3kJs8wlszEWIW3xIm845MV0hgN94k5z9H
         hv4VyvlCxPP07xdfuHPJhUO5aQFBDV58Ula2FL1x+bqAlTcbcPoYv/MFdLPOSDR1B4Kt
         bRbw==
X-Forwarded-Encrypted: i=1; AJvYcCWz2pTYCv2CHlt+6rHvEZchg7WeNopx2yzkg6KWw5ekhVttBXrNuO5+bcMXe/EPFVuRv6A+jMS6vUX8J5ReUXaffr59iQUmc6dvno9u
X-Gm-Message-State: AOJu0YxMIeXonI/qZDgHgNM+9Qy3Pi+62ViR+78MuKcTdAQ6WGA3eJHv
	Dkqm2SRnXL/qPOopiCSTHIoIcVRqZfPmyWYkKOSE+ypLjItYAZTnVrxvjbd3x0KWZsJ5/l5OfUv
	rMZV06+PNK5pcuMbTzBAb864I4Nc=
X-Google-Smtp-Source: AGHT+IE6nggtsGSzuBIDEwpdazMgwsW5mU8I3nuB/Vie0tWToLMI9S7n3vSfyJAKL7D9tQijzO8ujf3ueQ7uutRA8GQ=
X-Received: by 2002:a05:6512:2354:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-52edf01bee2mr815553e87.28.1721115721853; Tue, 16 Jul 2024
 00:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com> <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com> <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
 <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com> <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
In-Reply-To: <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 16 Jul 2024 15:41:50 +0800
Message-ID: <CAGWkznEUAJGzAD5iJ-wrwW=N4tYb1SGQtDZY7hwzwrum5QxGTQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:50=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/7/16 14:46, Gao Xiang wrote:
> >
> >
> > On 2024/7/16 14:43, Zhaoyang Huang wrote:
> >> On Tue, Jul 16, 2024 at 2:20=E2=80=AFPM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>>
> >>>
> >>>
> >
> > ...
> >
> >>>>>
> >>>>> I don't see why it's an atomic context,
> >>>>> so this patch is incorrect.
> >>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
> >>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
> >>>> of page cache during readahead, which will disable preempt.
> >>>
> >>> Why a rwsem sleepable lock disable preemption?
> >> emm, that's the original design of down_read()
> >
> > No.
> >
> >>
> >>> context should be always non-atomic context, which is applied
> >>> to all kernel filesystems.
> >>   AFAICT, filemap_fault/read have added the folios of readahead to pag=
e
> >> cache which means the aops->readahead basically just need to map the
> >> block to this folios and then launch the bio. The erofs is a little
> >> bit different to others as it has to alloc_pages for decompression
> >> when doing this.
> >
> > Interesting.  The whole .readahead is sleepable, including
> > submit block I/Os to storage.
>
> Also, please don't imagine your stack trace if it's a non-upstream
> kernel.
ok, it should be caused by a vendor hook function of the android
system. sorry for interrupting by my stupid.
>
> >
> > Nacked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > Thanks,
> > Gao Xiang

