Return-Path: <linux-kernel+bounces-330675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ADA97A297
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA7B25D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF611155CA5;
	Mon, 16 Sep 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZnierOp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4A14F9E2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491369; cv=none; b=RZYov7U3d4glGyoULULCR9YkV1Y3Z1s6x7TDeQupoAy8Of9+JIgwWqiSeimwxJvUdRMYJ6EaZc8fGPiT+4YbWxnmZiCWJVGGiAGY+vjVBwyVbGm4lPZ+cgLOFYhne5BsUUJtD3YtCQHA9nvzpDSFz2b2b9OCNpxOyEE7M1HWDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491369; c=relaxed/simple;
	bh=CXR0Aw/mKNiBjS8xTS9DIL/nVCBsiQ4wWbw7avaX9ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrpBoXqM38Zy4/LSEd5MHj6esAvaLvKji6TsPmbY0munSTe7YBnBx1akriqrf7At8vQHOB12YLCtmOm/KIMVNgVSStYqJTq6HS+td4BaMsr+Tckm0w4mUslggLt1MMoHJRdaw4WLZkmTgrPHEk/VZ7y0o0MoO0PX6Q1oMtGpoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZnierOp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso46681451fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726491366; x=1727096166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NSeUiUFmKGhOq9pmPVcCeEzRIWXcgNUtDDtgQEPYlw=;
        b=xZnierOpJme5Z4RvLOz1HE/fb1W/4UvhGScH3MFzUmBAANqxF4pLxZo5wpNqyhJvXH
         lbc9e/QLlQ6wxw4DPM2Tvt2GjYSu+eCnxi4vu9vYt98yJ5rky7jfgMLrxVHii63AOuea
         KrPLPZq6OO401nLQMXhfse/CWX7dyQZE5uquql1jLFw2xwD4GcroTMi+tMT2ewYxL8MM
         5jvb7GKYv1Ca6t6TE2PN4Ou4ivhnpVFU4rBdG0FU9r+7OeSw2rA6EAhxVAEhuKPe0LNe
         Cou3WTRqwpUateGKvBo//imI9EkxPp7nlFKbXqOgDRYXpxMJV0oHzQrjoNYUACiDjiua
         VN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491366; x=1727096166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NSeUiUFmKGhOq9pmPVcCeEzRIWXcgNUtDDtgQEPYlw=;
        b=Za2nl+GJNBmxnAcVmF/QdJT7KNdBA73uuU5oB8wHS9zkASFdvqBclEKGGMPeI4Av56
         L4s41U9LT1cBAd4PPbxYgSombS7K0Wz23dlxYmKZ7DONexx5/Xue8m0Xbu4wTtp7rJZR
         Ig0Hxc+K0R0UEUAoIjuyyMxMS973F+z8XjWS6+7kQcbCaSZzZhK9RxmmhnoLBMG1QUQC
         iB7ObuU3IDnR0F7IRUTkEVx8msxdTOkt1LuYn2fiYQZVzoIqjngovYMLSZwaHSK22E6R
         cj5vLZQmyPpTVjCziPhErMqRHLOujBBtl1TN+6RHs+MOI/tPGD7GmsO+/+sQGnlyUEFf
         vVLg==
X-Forwarded-Encrypted: i=1; AJvYcCVMJdqCVwTZjUE0baUxVheQC2ZayD3/QRVQgsex1Ys/Q1Nh+g0TRGoQzEu31sdP5e2dTMpdChLPRS/4dcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPrDpj+Rq5YBYOTtdGOrsC+0U/BRdb5L/XA4lnfV3JDiCSqL5
	uPf3PYmt7Fpa3eKNl8NewNLv5sodhacVPRTlGxoG+zZZwhRff04lJx3PAKKrsqWzRFCzpWdrdbZ
	6vPAfDs6RxUu8rVHSvIj0G8O4ckcpigTze35n
X-Google-Smtp-Source: AGHT+IHsxgmFPsbk+zKV7E1FWylQDNwbKcBeZz6WaPyXeaqjmrVS2H0Awff6LDdt6poIRtEgVlSg/QBPvJCUWUSpa2c=
X-Received: by 2002:a2e:9017:0:b0:2f5:c13:bd11 with SMTP id
 38308e7fff4ca-2f787dcdaf0mr58662251fa.17.1726491365306; Mon, 16 Sep 2024
 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000ad94305f116ba53@google.com> <Y7A8r4Yo07BnDxYv@debian.me>
In-Reply-To: <Y7A8r4Yo07BnDxYv@debian.me>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 14:55:53 +0200
Message-ID: <CACT4Y+YN8Hfj4SyaDQoWs8DNU9xGt=LawPdBCJhxZ8qkB17rHw@mail.gmail.com>
Subject: Re: [syzbot] net build error (6)
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: syzbot <syzbot+4ca3ba1e3ae6ff5ae0f8@syzkaller.appspotmail.com>, 
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Dec 2022 at 14:44, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Fri, Dec 30, 2022 at 06:46:36PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d3805695fe1e net: ethernet: marvell: octeontx2: Fix uninit..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14f43b54480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4ca3ba1e3ae6ff5ae0f8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4ca3ba1e3ae6ff5ae0f8@syzkaller.appspotmail.com
> >
> > failed to run ["make" "-j" "64" "ARCH=x86_64" "bzImage"]: exit status 2
> >
>
> I think the actual build warnings/errors should be listed here instead
> of only dumping exit status and then having to click the log output.

Agree. I've filed https://github.com/google/syzkaller/issues/5317 for this.
Thanks for bringing this up.

