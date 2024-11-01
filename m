Return-Path: <linux-kernel+bounces-392834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC99B98A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5051C22020
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C451D151F;
	Fri,  1 Nov 2024 19:30:41 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D371CEAB0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489441; cv=none; b=bhyFo2Qeie32E4HjwBibLfIp76sNMeseO/0e5Keapx5X8TrLkWQYN6xiW25GzLUEt3flsrA1kWbMmsvmcWlwK/vHYA3FY5s6itrkLHx5Yg1xuh854y3PseWC8Kmn7mOTsCjdv5B5slLMm/d5fGSkLKk8h5FhOWWF1N3sS6odv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489441; c=relaxed/simple;
	bh=omhhXKt59jMCE7ucHu+mPaaSXRmDsyFYiTxxDpzTFxc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YZQLTasM7yOZ1nLZH4X9Cdr/vmnK+EqddxDUGpQsROuhUZTnJBMkOxC8kDN6cmKIQPqizn/S8Duc5mSMsxawk90l8gX3LmUw/lH7FZEgEvGoMeqHnPcXCFKQ/Z/ZCImI7MfL1Zpr8ywtro5dk72yHxKARkuhsk4wHWR2YjgDdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b7974696so6502405ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489439; x=1731094239;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJs0Tz2ZmpCJLLFV0O8fbCAEbDM0nq3Zbx8X0e7YsxY=;
        b=kqWYUCXvTZ8r6sK8gAnb7P79VbItvUIttZ98ZR3jw1Ta47jtIQG2g/9M4LIlgDLjpM
         /dILbUnFPBNXbBEGg4T0BsfIzLPCi3jcH8vINxVLzhC/Q/3y+PBsGaxoR4foZSZ9K7kL
         eIuWg2/Pvfmq8d8RoHqQbniiebz8H7HxQvwwDrY3TRUnkulWpXLyGbQI+zCvFftQqYIc
         z/w8DvfV1D1Z4hbUdCnrxGT9ic3F2BtEE9Z7roiFVLp02zqhqTTuBU/bpxVRaFChQKEv
         OD9UDWZ2Ac7DHd8jvRSzGccQv4ZrlykbvnTlTRnPhfoM7DwUnWtJxxxnHmya5fygirZi
         xHEg==
X-Gm-Message-State: AOJu0YyyjvbcegAsNn4r3WDSsENA8mZCKEYMwbagwSXLpv66pbTENLnP
	qtyt1Cl//ORncpgcwww6m6EL3X9ikS6yyOL3bKgq/gceK9QRKs/W752KMIKpjOr0PEse3t7plDi
	Y/h8Obe5MJTx8vBCEdHcQ2pyqlIZOE7XFhZrymCFbSddLK6sbNO4CTgg=
X-Google-Smtp-Source: AGHT+IGLQkK+ImSW4aRCVE43kdhZ9ff7mqeO5/NU12OpxhWrzwLdqlL+gvGpz9HxpAUyYoNPIbSGFHJQbTDhqI2xv5PwtSAlgdVQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a6b031a257mr55890595ab.16.1730489437240; Fri, 01 Nov 2024
 12:30:37 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:30:37 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67252c5d.050a0220.35b515.0176.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_ch=
ild()
Author: luiz.dentz@gmail.com

On Fri, Nov 1, 2024 at 1:37=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Dmitry,
>
> On Fri, Nov 1, 2024 at 11:31=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Fri, Nov 1, 2024 at 11:17=E2=80=AFAM Dmitry Antipov <dmantipov@yande=
x.ru> wrote:
> > >
> > > On 11/1/24 6:12 PM, Luiz Augusto von Dentz wrote:
> > >
> > > > There is no Tested-by thus why I assumed it wasn't tested by syzbot=
 yet.
> > >
> > > Ugh. Until today I've assumed that Tested-by: is applicable to human-=
driven
> > > testing only :-).
> >
> > Nope, in fact it is very handy to have syzbot test your changes since
> > it may hit other problems as well.
>
> Looks like this doesn't solve the problem, in fact I think you are
> getting it backwards, you are trying to reparent the parent dev not
> the child and I assume by destroying the parent device there should be
> some way to reset the parent which seems to be the intent the
> following code in hci_conn_del_sysfs:
>
>     while (1) {
>         struct device *dev;
>
>         dev =3D device_find_child(&conn->dev, NULL, __match_tty);
>         if (!dev)
>             break;
>         device_move(dev, NULL, DPM_ORDER_DEV_LAST);
>         put_device(dev);
>     }
>
> But note that it only does that after matching tty, but I guess we
> want to do it regardless otherwise we may have the child objects still
> access it, that said we should probably use device_for_each_child
> though if that is safe to do calls to device_move under its callback.

#syz test

> > > Dmitry
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

