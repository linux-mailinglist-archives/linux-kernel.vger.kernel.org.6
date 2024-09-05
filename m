Return-Path: <linux-kernel+bounces-316557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF5C96D135
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79981F23CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7841194152;
	Thu,  5 Sep 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vuRPbqp"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D0193430
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523469; cv=none; b=fGC63CeNcEVMdAcQHpW1Pg1xZuUWW4HRPcrCCfyv6nyRQ6l9vD6zrarFXcOZ0Aht1wUcfoSxKfgIUCz5YdUtaA3b4V0WixDArxzJ5sIvVV3rb+w8AMQPBrA12/M/3c0sMZyHkVi8mOdhkbJ1ukTk66kuYHJJKklbNZ2SLj/1V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523469; c=relaxed/simple;
	bh=nhjzPhbZdOIwhS4V+wg8CJkF4W2mZ8bF0vqcfEg02aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOsRfx5/WIS9uMS5LMYPv+Fg2RiXvuhvJLOkmWSGCqN7y+kN92hhq/UreHeZd8J7QXqGz7V3rTK5++wexoUoKoJ+UzatpZk8Ny6VaZ8b2fTO6aDtacVPllJ5/kHVWMII6c11hp15D4ORxJXj8lCDp4B7lX8rIHuxcO4d/CkYfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vuRPbqp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so407543e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523466; x=1726128266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azQkhYEOWQVBIINHFNC61+ioeVjCS9tbpuO3iLtCThM=;
        b=0vuRPbqpbhkswQRteJAQaG8BjgvALoFw4TV9SgNBFF6MB8HdKTno6oOH2tGv0vHGRQ
         Ddptj2w2PO2foezkY0hjwMZVXLM+JqI96bMVSwRqYg4s1xXz5RyhXLW/uJgxYQH+aMyV
         x4fKcPE3EfcTc/45YEPAO0fwuI67R7mA5dppDTqkjKKHKiCMBBwEXxPEU6XGOfF+20aP
         LyEmLKPP3PCquyOhmdWENvRsYX6kksNMstotKXAyt69u5V20O8siE8EwO4KP4f4VMOdY
         WTnPU/y9onp5ONDlfGnN6qnckqYwC+2MHhNGHCweMDBNruubC7H/03Je8uunuqO02ATv
         mcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523466; x=1726128266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azQkhYEOWQVBIINHFNC61+ioeVjCS9tbpuO3iLtCThM=;
        b=JEVv9at9SBstO5wAEwSLnDlrJ1UWbOImm911NXp3RVRsZCCgfBEWF8hhHE2m5TC/nY
         Uxq9zYmLQ/ejp8pd5tVQR+zaEvzxFst1M6jRQit/xZTek97jHWDkQysz4EOmV/dsNTA3
         GoGifsUc5EWWcjPmX3nP3V95R+2gpJoWS26DJhd/uHBgmimWQldc64A9F2Q2l/O9J9/4
         WmFmme2ORqaP7KZHvFc/ErzqgCR3Yv8G9OzUBQJJnUx97RurKcqwM/c5fmJ4GTHBxqbq
         Fu89M7C2ahU9F13l1jRvdZ5/WSaNkJ75WwTBii3H1dkpaJ2Vb6dTMQdQvVuHuGO3tOHm
         X8fg==
X-Forwarded-Encrypted: i=1; AJvYcCUMvbfen3rsW0ikJYPRkgQS98a56kAhZ4ZFyxkVIx8vTDs/mZf1WAwYIdjvVZG6aBOkggiiCPwe0mgvmcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+W102zaMbpq3hUD3XknAlhqSGvPrqJ5yMPt+D8zoVmFb+X+Kt
	dtI26ADzLzvKntDTaoXLC9iVPpOsvuLFp0J1xbh8os8Er9rWm3WvNR9jcgKROk6XxWSuoL1/64G
	1c/wOwPC+onz9vMRiXYUNQD6s/DSsH7uSzvPr
X-Google-Smtp-Source: AGHT+IHR8HiUyJmdstJJcxGU2MOFKXxOOMDEFMh2vAfGxn+gzsWBtmLSd6+8Sol6Rv06L+OF6VRRSxcZX4WXteQVlew=
X-Received: by 2002:a05:6512:3b2b:b0:533:71f:3a53 with SMTP id
 2adb3069b0e04-53546b053admr17779245e87.19.1725523464706; Thu, 05 Sep 2024
 01:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000083b05a06214c9ddc@google.com> <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
 <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com> <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
In-Reply-To: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 10:04:10 +0200
Message-ID: <CANn89iLfdNpdibU=kWZKgHPAeMSpekePovmBNbaox4d=Zyr+OA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Shoaib Rao <rao.shoaib@oracle.com>
Cc: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>, 
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:35=E2=80=AFAM Shoaib Rao <rao.shoaib@oracle.com> w=
rote:
>

> >
> Hi All,
>
> I am not able to reproduce the issue. I have run the C program at least
> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> intentional or not but no panic. Should I be doing something
> differently? The kernel version I am using is
> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.


Have you selected ASAN in your kernel build ?

CONFIG_KASAN=3Dy
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
CONFIG_KASAN_GENERIC=3Dy
CONFIG_KASAN_INLINE=3Dy
CONFIG_KASAN_STACK=3Dy
CONFIG_KASAN_VMALLOC=3Dy

>
> [rshoaib@turbo-2 debug_pnic]$ gcc cause_panic.c -o panic_sys
> [rshoaib@turbo-2 debug_pnic]$ strace -f ./panic_sys
> execve("./panic_sys", ["./panic_sys"], 0x7ffe7d271d38 /* 63 vars */) =3D =
0
> brk(NULL)                               =3D 0x18104000

