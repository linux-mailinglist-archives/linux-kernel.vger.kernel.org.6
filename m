Return-Path: <linux-kernel+bounces-265440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC293F142
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678962862F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265E78B4E;
	Mon, 29 Jul 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeV6o2wB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A186770E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245773; cv=none; b=VRecGyK9KBmnRBA7tevye4bYAXBf01bEosEV7V/SPNmfDf7vPpJsyI/xvElxrd6IgSBTucsOYzgQ3o7evRk92IfT3mqOnwOwFAOeeDF1OpA8lyXht13bwxFGA62CFdbzDJElAad7ne/Z/sRqVOBOo266y9Umasi3mpJYyOExS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245773; c=relaxed/simple;
	bh=63aU7mj9fqLapM3jDmnSJl5KSiycWwWq22p4OXw3GGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJin5sdbwcv0KvN0VNuHOPSyNYbSgQeHfff1twXSJsTcY2pTONxrJvtNGb2PM8aGPNmh1Y6BZo7zGv9nwsiLtflW5Jn41FAS5fWANh83XCGikg8JksgQJTLQR6HrCoZOoCkgm4h4rDggB0qgQJt5q4gFT16CTQzrCjjiJbH4eKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeV6o2wB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so8948a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722245770; x=1722850570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6d72j4m/DpNbImW85Yz95FX2UHa2MMdK+SLSOWiCuU=;
        b=LeV6o2wBdPKwX29ZkOXNpHt9s8BNVlanxe5Gz8JsMpkbNYh7REQBBI084sns/0saWc
         I04c+yZaNiKJI40k4H8eCoSWOhoXEcwLX8ONGrmQ5FN/vjmBzaIMHQ0yHEsrYauDENt/
         xjHi67D8m3SJzhFfEDkD5I51sJwXcB5fYGKtEZxriX8/1G8z25ijf+pd1DuZT4cS1QSD
         aQyHotEFSzYaUg9c8Kt5agNxhWwGe7E3wha7cbuY/QwlTUN5mHZwXWY3gWjCkIOiWWZc
         6bfz+zsvNAW/uXqJ2y8jneEmh2miAvcH2mQGZJSsQlgOhsLv+p6xbtCm6q7w65d8Hn3I
         6n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245770; x=1722850570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6d72j4m/DpNbImW85Yz95FX2UHa2MMdK+SLSOWiCuU=;
        b=ZsjRew0HIzzV6xTVWLd27u2Mmz1SQlxaf6Xw0Nm6G++jQ8lCMa60BjhS2YuspOurHi
         qqOx9gywuiMduTtL6TDZq5OP8sXVI/iOO/Fk+8rBtoFOP7oF1djnNHv0tOOEP+Q+v9vK
         gWXJPhmZb7fy9BTlZ1FE62eaWiuxHxou9MnbJWvk9O44e2dGX92gurKPlAv7WJbtawgV
         +ahh1ZTPaN19bO3tW2cW9kuy1Uhoh2W5Cp6bf2qqkIEPme1UUxEVUtO0n9gK48kKEX4L
         s4Upk1jMbJO8NFguJL1cn8M6anMtzvW1j9AqJiOCsVFMsVB3s1az0/dPr8N6QJFNSJEP
         KAnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJngSF9un7xcCfPhOfo7psY/UOMuBpjDZjGnce5cUwe/zsXeuPo4T1ryeyW8x8pS/4J6aBPV8Dj37/p4KAQdOf2HD3fwa3bY7uLPVs
X-Gm-Message-State: AOJu0Yx0H819tP/VakofyWH+M50e7o82ANseMpDVltMVMoU8zbn722ST
	TdqfETTFK61Ckh84CHLKcrXadHqUQzlubijMfLcbu+TFEAWdmXvFeC2l/9ePTBwa4zXAVat1gwj
	FUAQJQU9bJDv71kQ9X+NkcgTeWSuJNMax3KNC
X-Google-Smtp-Source: AGHT+IHIalkoSjjp2apZbUL+ktnbNq14bxnRbYJrgr13JMNilJIlYG7fFwHvB01L6Q79TEDXbONhTSJvZffj+lRli98=
X-Received: by 2002:a05:6402:354d:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5b033c83768mr260452a12.3.1722245769876; Mon, 29 Jul 2024
 02:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-2-51c92f8f1101@google.com> <202407291014.2ead1e72-oliver.sang@intel.com>
In-Reply-To: <202407291014.2ead1e72-oliver.sang@intel.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 11:35:32 +0200
Message-ID: <CAG48ez3H8VoesiWPoSzcnHHYEADndmK9Nwae=JL3d6JfdpjNUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:37=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_d=
etected" on:
>
> commit: 17049be0e1bcf0aa8809faf84f3ddd8529cd6c4c ("[PATCH v3 2/2] slub: I=
ntroduce CONFIG_SLUB_RCU_DEBUG")
> url: https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/kasan-catch=
-invalid-free-before-SLUB-reinitializes-the-object/20240726-045709
> patch link: https://lore.kernel.org/all/20240725-kasan-tsbrcu-v3-2-51c92f=
8f1101@google.com/
> patch subject: [PATCH v3 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
[...]
> [  136.014616][    C1] WARNING: possible circular locking dependency dete=
cted

Looking at the linked dmesg, the primary thing that actually went
wrong here is something in the SLUB bulk freeing code, we got multiple
messages like:

```
 BUG filp (Not tainted): Bulk free expected 1 objects but found 2

 --------------------------------------------------------------------------=
---

 Slab 0xffffea0005251f00 objects=3D23 used=3D23 fp=3D0x0000000000000000
flags=3D0x8000000000000040(head|zone=3D2)
 CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0-00002-g17049be0e1bc #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0xa3/0x100
  slab_err+0x15a/0x200
  free_to_partial_list+0x2c9/0x600
[...]
  slab_free_after_rcu_debug+0x169/0x280
[...]
  rcu_do_batch+0x4a4/0xc40
  rcu_core+0x36e/0x5c0
  handle_softirqs+0x211/0x800
[...]
  __irq_exit_rcu+0x71/0x100
  irq_exit_rcu+0x5/0x80
  sysvec_apic_timer_interrupt+0x68/0x80
  </IRQ>
  <TASK>
  asm_sysvec_apic_timer_interrupt+0x16/0x40
 RIP: 0010:default_idle+0xb/0x40
 Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 17 ae 32 00 fb f4 <fa> c3
cc cc cc cc cc 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
 RSP: 0018:ffff888104e5feb8 EFLAGS: 00200282
 RAX: 4c16e5d04752e300 RBX: ffffffff813578df RCX: 0000000000995661
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff813578df
 RBP: 0000000000000001 R08: ffff8883aebf6cdb R09: 1ffff11075d7ed9b
 R10: dffffc0000000000 R11: ffffed1075d7ed9c R12: 0000000000000000
 R13: 1ffff110209ca008 R14: ffffffff87474e68 R15: dffffc0000000000
  ? do_idle+0x15f/0x400
  default_idle_call+0x6e/0x100
  do_idle+0x15f/0x400
  cpu_startup_entry+0x40/0x80
  start_secondary+0x129/0x180
  common_startup_64+0x129/0x1a7
  </TASK>
 FIX filp: Object at 0xffff88814947e400 not freed
```

Ah, the issue is that I'm NULL as the tail pointer to do_slab_free()
instead of passing in the pointer to the object again. That's the
result of not being careful enough while forward-porting my patch from
last year, it conflicted with vbabka's commit 284f17ac13fe ("mm/slub:
handle bulk and single object freeing separately")... I'll fix that up
in the next version.


I don't think the lockdep warning is caused by code I introduced, it's
just that you can only hit that warning when SLUB does printk...

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240729/202407291014.2ead1e72-ol=
iver.sang@intel.com

