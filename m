Return-Path: <linux-kernel+bounces-177721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392648C43A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5991C213D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB24C7B;
	Mon, 13 May 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HVLqMfAU"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7B4C6D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612385; cv=none; b=esQHpBe3gnE/+7Ug0rRD4yxpgyxruvymQwj5FJa4GEBNBQkHDd/hveW3BOAoZWEIHByeAT4EwdtsDxw+Z6+c0I95OZI/gdo58fvP1/dODyyntKCPArn1IZJ9bLyHwK2sFYaW9pAedT8Gl129acQzrzTqajeKAZ6jNgAruofqpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612385; c=relaxed/simple;
	bh=NAFNAGZXDH28lYLqiCjV6acOfA/J8mZARBGgABvAM9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deWNWyn1Bc6kJt0FojvH0SnLurc97Ibm7yi5leu9HyWw4O3X5VyofAUueSMp863w5xQ/EJe7QkaZAMW0jWMpl8WFo2xjennCDcPOAX58r08FRfxm4aM5FXwP8CDA/cbLdWlGY0ETbj6dbGDWRN2hPJiMKRjW9nI0nk63ZEDOCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HVLqMfAU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso5120573276.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715612383; x=1716217183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmYZk0kFF6OOGj9czkV32wEYdGGtifIB7+d5SgpETuU=;
        b=HVLqMfAUvFNYcP4pMfnvTJq/1R1Wr5QlEfLvtN/pVkPkHllu5mJDCR0HYKgR47AdYb
         CVLkMJ03uXnKHFnrQx5ugimdxwoCVav4Xm8TLHvkd4NUxHDjaZl5SLDuWntgkhGCo2YL
         VjkdeDB9tBSSxpq7jE+bi/wWCFV9b4Bnck93Rxvp3mfAV7O/4HCOCShEevUvS5CakNg3
         gAnKKcRBPt+ukuSTllH7YdzdZC8ahzNdVlvhyywVBGF2TpQvT2BlcDywzA96IcbAP6S/
         60bwQW5qt1fJo0PpKxbyVX60aSECkEyEGW8QuoqpNRazHcartUYFTxUQl5QVd2PagCdq
         N58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612383; x=1716217183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmYZk0kFF6OOGj9czkV32wEYdGGtifIB7+d5SgpETuU=;
        b=p0ZeT8dYR/1+T/yfKqJ9PXYwQ4MrbSzVO96Lo6IshJWlO3jqbLsT01qGyGxkV3gGlv
         7kmlBKRaw6LrkUmEUxsaDUlAMrIPkkKeH+Ia/ey+aKPIzOS/GP3aLtdeinn8gasA8F3R
         ax8/EVRb7XyGMgR90lTzKJ2pCHZBxUXF4twae/YlGyuE69L2HeuRgbappKQSeeHaVce6
         /LODyGzw3RcxIBFJhNOjp68NLhXQieMXFxoY+7Cob55nVk6D9B28Tq2Xn1oUEVRLw0Mz
         9KuXskG2sGfwOfuDMOK/9VGFgERIL7+PmoSfrooXfJUebPIjj7TQLVRHuOeklUxIRPFa
         G5kA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHORbkD/90fKc6cOZPXzrRNZxheFPPkZsNT+kmrHaGZfQk3YmQ/T5ATkOUDuDBaYDiUqGuV+XXZgO/A8ymmdL8ecvsAiLYGjhGGq+
X-Gm-Message-State: AOJu0YyFwcK7Me9pUaqwvYa+5o6nP9qFvB9ErVdTlGk8idAbbHYjASCV
	rqhnKzqGAXy8/Ty9Izb+HarD+nlDIDuFEaTmZtyox2X6sObc0FnSGbNlpKyFpxnpwBccTCp8o3M
	uoGdh8j9dWMClrXDFeC85KU4oSfpRGv2lcvEkWv4xfLSE2DA=
X-Google-Smtp-Source: AGHT+IFIGLplDoMFraH1zkLAVywXcB6c6GYboq/6d5rFURkDTnzUpiqkAe+TQql/tQILTDNyMfl0quYdML71woeC2Eg=
X-Received: by 2002:a5b:b0d:0:b0:deb:9e90:2f5b with SMTP id
 3f1490d57ef6-dee4f34b10dmr9160333276.29.1715612383406; Mon, 13 May 2024
 07:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f5f83206180101e7@google.com> <CAHC9VhSinu25_9evZZmLaiJL=R-LNOmB+Yz-3NtdMi5b+vQiRg@mail.gmail.com>
 <CANp29Y74qSm4_VTVT-j5n5kwpJaPk1zTMXPRO_xxWViXADUNeg@mail.gmail.com>
In-Reply-To: <CANp29Y74qSm4_VTVT-j5n5kwpJaPk1zTMXPRO_xxWViXADUNeg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 10:59:32 -0400
Message-ID: <CAHC9VhTY47hMxCYbU08aj0VGoPLQviL_6rGfTPyMDe8K36wPkQ@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel NULL pointer
 dereference in kauditd_hold_skb
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:01=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com=
> wrote:
> On Fri, May 10, 2024 at 1:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, May 9, 2024 at 4:14=E2=80=AFAM syzbot
> > <syzbot+8ffdaad8822cadf6ff4e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git=
kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c901b89=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D758bb5b8f=
724c7ba
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8ffdaad8822=
cadf6ff4e
> > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU =
ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ed19b=
8980000
> >
> > Is syzbot no longer providing reproducers in C?  I see the syzbot
> > reproducer but no vanilla C code ...
>
> Syzbot still provides them, but in this particular case when syzbot
> tried to translate the .syz repro to C, it was unable to reproduce the
> problem anymore. So it didn't report it. It usually doesn't stay too
> long like this, in some time it will find a working C reproducer.

Thanks for the explanation.  This failure looks odd enough that I'll
wait for the C reproducer to spend any more time on it.

--=20
paul-moore.com

