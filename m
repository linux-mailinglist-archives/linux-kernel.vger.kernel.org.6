Return-Path: <linux-kernel+bounces-258900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A6938E11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F281697
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA116CD1A;
	Mon, 22 Jul 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA30prZ6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA117597
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721647830; cv=none; b=uFv2sJMC67rIfOfftpGzy1/5biJXUJOPqFa7GbFbMd3KCEGav3Vioq+BBv3G/zOa1srWjU8f7DtzGGtgc6ISJXtwCP2C2vTzTIwMTjMXHRg7ohKlZ2hlFoEQcergPQeZaP7DeV31P1vmcG4R2R3+L8RZC3AtcKXdMCI70TXXb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721647830; c=relaxed/simple;
	bh=q7StsLuphxPhJ4AMASva4ocwXtY2Zw1h3NSjmCt1LrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2kK/EfsRvVJxRyeu8GXljinpamRQ5mkJE5R4BzngxVwmUQS2LsoQ3BLXMeyZYiFJH92XG+qd+miXh5kG58IgFoN1yarZwRvcBQtfKR2jd/zkwaYg/p951PrwDaZz6+/xik0boZbMN4LoXthbhQMEkO/BuFQ/t9f/8iZmiwV9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA30prZ6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3687ea0521cso2750959f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721647827; x=1722252627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEh+tqEWYYDjNVyznf/QhRyAHWlb696Oo/KgIr0D5+0=;
        b=MA30prZ6UyabWLykPDYVHzfSTQXNbGIi7exvLmmGWlR017lHiM9Q/fNa2Woq05FIDe
         SPwT32f6btSv3s6tUvLlEYlospuPCscePlooVBaLPnlocra3ySr0CVnw7k/1wZYJxb8C
         M7xTsdKNXIJs8YrEO7M3CCbXGCLj30KNkaclXbzrlq3udfpv4cxa78ORuUn5BRQq7WdG
         EOX+l604oeFfToZJwWmhmdZJc6b0cyVTonVV4tlWIEYhKVpewCABRRciFTI2DpQ5lHVV
         Eo5UrGIrcJjvn1voX4tT/IBfU8cfpiA4IfovWBkp+aFKQG5OLHZ/ErPGOphsWrxjcZRQ
         DasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721647827; x=1722252627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEh+tqEWYYDjNVyznf/QhRyAHWlb696Oo/KgIr0D5+0=;
        b=dTP8S5Pfn+ajbb/zfJljCUvwAItopuCiUFH7qvg3Vu2zAqX516IEibE65lPMBxrOZ5
         MyoYjtvG/6rq6npcVXILRbsQqY9iq0/scF/WH5egePZYByIfC/bFH8oeIrW97wPcn42I
         0GcZxh4aJISZ9Q5SYVx36D+Yz1zotuqMvVdoB2CILk55YUSQ78UhdsE5BmDjCPbrSv16
         Jbu8Joq+mrQR6wHMcwYjM5idaN6EG7l3niJlb9SoMW1y9JhppSV/gzumVFHwGvL9HWY1
         CU32JgQEC3p54wDP0MpUUSgZTA6V03Q7Dd2INqt6mOhuGe+G6lbaXcWH4W3G3NwjOou9
         KPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWZP4M7DqlvH5lOX0jl1aZWF1vlh2s4HdRfy6xhKa5gpFnvPjSEWcCXI+9PyiuLzPLZBj2r07O2XZs16BpwTHUrpMPi4HS6N+sEGGRu
X-Gm-Message-State: AOJu0YxOwRRHtYaSVpH/Lti//3cvnuqNVJ5T1Vx2Cuzrk45RjD/CNqLw
	wUZdeBSbNsYU2dW4XiDaWcwqfsIh/Hfy0LKajpOLcyKFJOvRmLFRyQI3L0o9awbHZ9RhVMjRbhK
	DNd+nNcgDVCOVyHU4f4A75p7UIM4ZVUthl3MN
X-Google-Smtp-Source: AGHT+IE4wiTd+0ogT0ruCkeXs/ix2vx2IAFrXiOsLxUjBdueuppp4fcGCjfmHSoj5Vdmb4ZWscdJ0KcwyDotdPwMB+4=
X-Received: by 2002:a5d:5f44:0:b0:368:4e35:76f9 with SMTP id
 ffacd0b85a97d-369bae67d31mr7268607f8f.37.1721647826963; Mon, 22 Jul 2024
 04:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000601513061d51ea72@google.com> <20240716042856.871184-1-cmllamas@google.com>
In-Reply-To: <20240716042856.871184-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jul 2024 13:30:14 +0200
Message-ID: <CAH5fLgj6=6ZcVT13F8kP7g2NnRgBmZn+KKPANt=fSoFEJisi-w@mail.gmail.com>
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org, 
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:29=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
> In commit 15d9da3f818c ("binder: use bitmap for faster descriptor
> lookup"), it was incorrectly assumed that references to the context
> manager node should always get descriptor zero assigned to them.
>
> However, if the context manager dies and a new process takes its place,
> then assigning descriptor zero to the new context manager might lead to
> collisions, as there could still be references to the older node. This
> issue was reported by syzbot with the following trace:
>
>   kernel BUG at drivers/android/binder.c:1173!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 1 PID: 447 Comm: binder-util Not tainted 6.10.0-rc6-00348-g31643d8=
4b8c3 #10
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>   pc : binder_inc_ref_for_node+0x500/0x544
>   lr : binder_inc_ref_for_node+0x1e4/0x544
>   sp : ffff80008112b940
>   x29: ffff80008112b940 x28: ffff0e0e40310780 x27: 0000000000000000
>   x26: 0000000000000001 x25: ffff0e0e40310738 x24: ffff0e0e4089ba34
>   x23: ffff0e0e40310b00 x22: ffff80008112bb50 x21: ffffaf7b8f246970
>   x20: ffffaf7b8f773f08 x19: ffff0e0e4089b800 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002de4aa60
>   x14: 0000000000000000 x13: 2de4acf000000000 x12: 0000000000000020
>   x11: 0000000000000018 x10: 0000000000000020 x9 : ffffaf7b90601000
>   x8 : ffff0e0e48739140 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : ffff0e0e40310b28 x4 : 0000000000000000 x3 : ffff0e0e40310720
>   x2 : ffff0e0e40310728 x1 : 0000000000000000 x0 : ffff0e0e40310710
>   Call trace:
>    binder_inc_ref_for_node+0x500/0x544
>    binder_transaction+0xf68/0x2620
>    binder_thread_write+0x5bc/0x139c
>    binder_ioctl+0xef4/0x10c8
>   [...]
>
> This patch adds back the previous behavior of assigning the next
> non-zero descriptor if references to previous context managers still
> exist. It amends both strategies, the newer dbitmap code and also the
> legacy slow_desc_lookup_olocked(), by allowing them to start looking
> for available descriptors at a given offset.
>
> Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000c1c0a0061d1e6979@google.c=
om/
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

You are changing dbitmap so that BIT(0) is no longer guaranteed to be
set, so you should update this comment:

         /*
          * Note that find_last_bit() returns dmap->nbits when no bits
          * are set. While this is technically not possible here since
          * BIT(0) is always set, this check is left for extra safety.
          */
         if (bit =3D=3D dmap->nbits)
                  return NBITS_MIN;

Otherwise LGTM. With the above comment fixed:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

