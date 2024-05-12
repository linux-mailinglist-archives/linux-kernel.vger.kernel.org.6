Return-Path: <linux-kernel+bounces-176891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17238C36B8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738431F215C1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B012556E;
	Sun, 12 May 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R87KG4lr"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0A1DFFB
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521031; cv=none; b=K4GGnx5WdAjpm861IArmestD2C+GyU8C2aqjln4HNku2YhLGYZSTZv/mlOf7Gaiam1YIMFrXFX9pGBy1orEjKgvvmu00JplBJQYqGLc74pjCEwvumnnDI3RlZbk1IlIW79inOHLIh8mosCEXgIULwJMTVc8/XKIrA/3mJ+cZAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521031; c=relaxed/simple;
	bh=cv755/TBUy+eK17z1DpA1aIpCDafC0jFVSJwC9bv8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSr7u1JLZJb7vw5LcU8u1DMlGk8y/ei2yhKlq/LrnlsUSnl5HcHr7nuRq0h25nCdzWfWmAyaULBkB0xlm8l9fppuKbo3y07kl/Aptj747gydk4kg9O1C3j0VokJF4/bWwRXurVI8RYTqGCQMBRWmDXCWAHXTuejHAFW8cP7fO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R87KG4lr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so3141764b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715521030; x=1716125830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv755/TBUy+eK17z1DpA1aIpCDafC0jFVSJwC9bv8CQ=;
        b=R87KG4lr9abcHAoyJrIawfaBLNFweq9xv4y7eusMPRoa01L4QlV0hior+nsqKxwfJL
         IRo0uJHYyYLdupNXnbE6QFIsbHiW6ad/kvtQdfi0NKBtzJhYU+PhXi22T/6VH/IRdD4K
         Hv8pXiGp1QDb6yZXgauYdUyyGQN8u3tKOjqs8aAA5BNDtQSZAfU6xKbymjEHF7WhBSdq
         psHNz4BGrhuLMIrlTT6BVWEJRdt6FE/q2FEho2LZNFJ2dtGXVdqQKL0pSzIqQbaoRtZl
         QoLe7zPw9IdUgK/boY+Mj7kExhWU6un4VYkE6zfY55oCJLRrYggUvsRvd8amxCkQ7bH4
         6FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715521030; x=1716125830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv755/TBUy+eK17z1DpA1aIpCDafC0jFVSJwC9bv8CQ=;
        b=EW0wEo5WXybqIMCGfe4L/seKYU9JNrnAHSH2PwWs77+aFSDDju2w9vGUOmJc2wcQHX
         RDhdVaKHFAAgxjpoXv6dOGTP8HTU8B95mD5Osr1FNI0O963s4xTZ0c8OQK0zqfIwgNQh
         1Q1XCfSNFvOhF3zAeJAIfgzujZES347/0n3gCPiotNszCFH0dKNZLTZiCEq7py+cTwW/
         4dYrXT9nsHzbIlBJs88vOygeSwOaKuDqW8xsVIDbexeLNuEbmV3uyvm1Vwxhtm/Qb/8E
         vqGjHEs6FV1UsPKtV8Ysvhsk4E4c0Q3jE5sc3+MhaWpgk3Bvpl802WFjIZtD6UBG12Mz
         HBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgdWAclpL+hnP7OZ4BiPncLa6QGP/tn/UfhiBmXBv8ZvrMIV5i3Y9irjKuACm6G3a8qCOTR0om8QaGOsDAaUT1pL+a4XwsubYgwKin
X-Gm-Message-State: AOJu0Yy8f01hrC1ziSQhm2t4nx0xDH0LeqyTiYfD3iQ5sHt/m4E5ZBAM
	JGY6RgiAjA/xzikxTZNHpNmFDp5mWxwdOV360Sq9Yo5mGlYaEcK5OhvHTM3uRunRxEdQu3ftprf
	muuh5Tu6BohQEh5Fq3qGjcSJY5Uc=
X-Google-Smtp-Source: AGHT+IHeuxTGA/nGPZugFEXjFB1ya07zjfdJI1He4tlnyA23RjGJu9znXaXAFw27t0wdWgk49v101gjuNZseqmacdnY=
X-Received: by 2002:a05:6a21:c92:b0:1af:881c:e924 with SMTP id
 adf61e73a8af0-1afde20dfd8mr7821651637.62.1715521029528; Sun, 12 May 2024
 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLy5WHJBjk33pzr12w5e7CDGb43LhQ5zQow0on4pCYusjw@mail.gmail.com>
 <20240511233404.2764-1-hdanton@sina.com> <CABOYnLzuu=i42tX-VSbTKJBfU=orsXa3Q5kCELOCsOFZCSdAaQ@mail.gmail.com>
In-Reply-To: <CABOYnLzuu=i42tX-VSbTKJBfU=orsXa3Q5kCELOCsOFZCSdAaQ@mail.gmail.com>
From: lee bruce <xrivendell7@gmail.com>
Date: Sun, 12 May 2024 21:36:56 +0800
Message-ID: <CABOYnLxHfNwD_9WthyVS+9xhczUxFYkpAhRQ0mNugwzqwzZwiw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 kill_orphaned_pgrp (2)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Edward Adam Davis <eadavis@qq.com>, clf700383@gmail.com, michael.christie@oracle.com, 
	mst@redhat.com, luto@kernel.org, peterz@infradead.org, 
	Thomas Gleixner <tglx@linutronix.de>, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

2024=E5=B9=B45=E6=9C=8812=E6=97=A5 09:40=EF=BC=8Clee bruce <xrivendell7@gma=
il.com> =E5=86=99=E9=81=93=EF=BC=9A

Hi.

Hillf Danton <hdanton@sina.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8812=E6=97=A5=
=E5=91=A8=E6=97=A5 07:34=E5=86=99=E9=81=93=EF=BC=9A


On Sat, 11 May 2024 22:45:06 +0800 lee bruce <xrivendell7@gmail.com>

Hello, I found a reproducer for this bug.

Thanks for your report.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: lingfei cheng <clf700383@gmail.com>

I use the same kernel as syzbot instance
Kernel Commit: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803
Kernel Config: https://syzkaller.appspot.com/text?tag=3D3DKernelConfig&x=3D=
3D6d14c12b661fb43
with KASAN enabled

Since the same title bug is triggered in
https://syzkaller.appspot.com/bug?id=3D3D70492b96ff47ff70cfc433be1005861193=
10670b.
I make a simple RCA.
In the old-syzbot instance the bug still trigger the title "KASAN:
slab-use-after-free Read in kill_orphaned_pgrp=3DE2=3D80=3D9D and in the la=
stest
syzbot the bug report as

TITLE: WARNING in signal_wake_up_state
------------[ cut here ]------------
WARNING: CPU: 3 PID: 8591 at kernel/signal.c:762
signal_wake_up_state+0xf8/0x130 kernel/signal.c:762
Modules linked in:
CPU: 3 PID: 8591 Comm: file0 Not tainted 6.9.0-rc7-00012-gdccb07f2914c #6


Could you reproduce it in the next tree, because of d558664602d3 ("vhost_ta=
sk:
Handle SIGKILL by flushing work and exiting") adding reaction to signal?

I test the kernel linux-next: d558664602d3906866e604a618dcf67f66d79967
and comfired reproducer and didn=E2=80=99t trigger any crashes.
I notice maybe this bug is duplicated with
https://syzkaller.appspot.com/bug?extid=3D98edc2df894917b3431f and
https://syzkaller.appspot.com/bug?extid=3Dc6d438f2d77f96cae7c2.
Should we need to close or tag duplicated or fix to them?

Ok, I'll try.

Best Regards,
xingwei lee

