Return-Path: <linux-kernel+bounces-307550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E7964EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF41C22CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD411BA86D;
	Thu, 29 Aug 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="uE4HmyGU";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="JkADrusH"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E1153BEF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959868; cv=none; b=EDMnC/q1IH7ICpV3I/5Zv0W40OrpwIiDAO/+zRngBOqvjxVU9qM1SM2VNZDLStvC3xu7/cYd437hiC1u8EUN7slBRjJYog2Aa0VPFYS09fWLiYTjqLkCFSVp582332kMxlbgT0OLcfopC+3C6Mur3EQHRlhQICOjaeHUODqrYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959868; c=relaxed/simple;
	bh=wl3uXxjsX6/WbbEdlvPAhMe7ckD5aMLXMMBdqeG2kXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEvgo+vW8J+vsznK26oTzO9Kv8k22ZK9X0W32GjxLBqDdVhVY28d3TfAyqowj0z1BnpLBT8a7kj94lPxXEXuPNTYgu4JYFVRw+XGJvdwikyNy09E/GJiMrUkpLXQgLOv1JdBnVPte1YvMWXVgGX+hUc3mvzo7fs5/paD0BIWSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=uE4HmyGU; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=JkADrusH; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724959866; x=1756495866;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=wl3uXxjsX6/WbbEdlvPAhMe7ckD5aMLXMMBdqeG2kXw=;
  b=uE4HmyGU+lCLhGQuBUJLZsECPK+JYG9yjf9yLs1z97EFKtOrr4WTKDSp
   Da0rQX81fHZ/Doar6xk73/U+Nq3CGG6HXhD9qFwGdwqDKWILOm9ETpmIw
   jVRPttumh0mnCCm69foP4c7WzTnXHvOanVdzpGokwxuN01rPQdaSGuW2G
   EAoNeA85gdigQ6XW/lbzxekOoDG27dPBc8k4IjJDdzwv/FLyWffi3Jnah
   OScahd5FFe2WLKw4Y/M+h3qzHhum5cpqpzFN4EGNKYatU6SPcnKH5wwWZ
   KaHfBziM4MSWCulsb7GRDdXZXsmfUxZRCZoOZMYvFTdIv+ZYPEr7zCrWz
   Q==;
X-CSE-ConnectionGUID: 1huVYZbnQdukZUwzV3eAPw==
X-CSE-MsgGUID: jZsymBQsTDKq5ovfsIUiQw==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 12:31:06 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a231e35ddso48773139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724959864; x=1725564664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B6eAyB0rutS0OFlsLM/NeX9TyquXOcwfRJFU97SaWQ=;
        b=JkADrusHArQbHVbZ8Zhx2+uM7dt/IW+XGfHm2AMlOWyKljntWv5WFzOnOHqqIktG6u
         jATR3SxRMIErER+1qBiq9vpBDACO/DfhMRy0rrPy06cHcxyaGWW03j/bm4/trOovRPE8
         rj2OqFQ5l5Ygt5ri+YOzLIxINJnq87xRZCmBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959864; x=1725564664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/B6eAyB0rutS0OFlsLM/NeX9TyquXOcwfRJFU97SaWQ=;
        b=oLiqpxBEWACk9qqNQq0Ep/suZei9igclq2ODV6BDdLb7cNVf9hfC0AJ0JNEVCwLV43
         roLpRB4IfIb7kBNL7I8MXW+lztR8Tgl6YZFHHorGiiKYa37SbJ1exmzxplh2YRajmEch
         McbTZjkDUBfkr8ffW7HmVjBTOhxX7bhKkdPCBBXgBW9qLZPy6C2PaipPha0FuGzCgpw7
         oIfOZ2CViq7slwIC1W2DyZTJ7erbKmChCToMBH+NegGSCHHMMurAwKrhw1yho5tXQmlc
         LDxD9YRVZ9kZE1ItNtsT0ZbtWmOsqPGdMaHItTJcSeojPJ6VDwnjVWPBck7SY7REaZDi
         K74Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe7glEJJnKoQ9C4MgEv/Uj5it6VwJSUMu40teffOkQOCnQl9j7ik7MphluyPpoGkSa0aUP7SH4BNN4HLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31J/EQnrBKqjJCRsttHP1ZGQ+FTzURZliZJ/PaW3/SehV96p0
	5DzqO2ZIUfw0eUJmuIca34rpUY3e0RsorEDI5QUmvScF0FmIUkHtrh6ONAUm58DUP0+zDMrZroa
	jaH1ikie1KKYMOgMNYe2jXKXshUaSHckzjVkfRvvgW1xpU18zmWi8PhI4i0m3lOia/BGOtP2dBd
	HIc2RevzQt3H4VDxkk+JAv50AF0X2BgI+taHV2Ow==
X-Received: by 2002:a05:6602:619a:b0:804:1579:182c with SMTP id ca18e2360f4ac-82a11011423mr475823039f.5.1724959864554;
        Thu, 29 Aug 2024 12:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh3of6TBdUpZgFiAW8GS9N51uJ2RTZjk6GymkzanvNxcr0pHxLoC/LHxVq76fJThCvbRBXC6sCzPzKIo7e+gI=
X-Received: by 2002:a05:6602:619a:b0:804:1579:182c with SMTP id
 ca18e2360f4ac-82a11011423mr475821539f.5.1724959864181; Thu, 29 Aug 2024
 12:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpfDVGGA+gpRqik5NATXsXUqDa2JAFiVRGCLkPthtq4=Qw@mail.gmail.com>
 <f1bab04f-6e7c-4213-a1ac-ecba95f26b23@acm.org> <CANikGperkKz4=rGrmU4748z8JCTLvURarhmVFN3g-vDzBkZ2Ng@mail.gmail.com>
In-Reply-To: <CANikGperkKz4=rGrmU4748z8JCTLvURarhmVFN3g-vDzBkZ2Ng@mail.gmail.com>
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Thu, 29 Aug 2024 12:30:52 -0700
Message-ID: <CANikGpcm2ytALYjKG9n05Pe2LJJvoYNuMr-bCPFSB7V4twgYdg@mail.gmail.com>
Subject: Re: BUG: corrupted list in dst_init
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: Bart Van Assche <bvanassche@acm.org>, James.Bottomley@hansenpartnership.com, 
	Yu Hao <yhao016@ucr.edu>, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Syzkaller uses `syz-executor` to fuzz, but inside the call trace , the
program that went wrong is  `swapper`.  After checking the reproducer,
the `/dev/sg0` seems the most suspicious one since it provides users
with direct access to hardware.

My hypothesis is such access can somehow tamper the memory without
being caught by KASAN, and it just so happen in this particular case,
the victim is ` ip6_dst_alloc`.

So I feel that maybe sending the mail to SCSI maintainers is the right choi=
ce.

On Thu, Aug 29, 2024 at 11:44=E2=80=AFAM Juefei Pu <juefei.pu@email.ucr.edu=
> wrote:
>
> Syzkaller uses `syz-executor` to fuzz, but inside the call trace , the pr=
ogram that went wrong is  `swapper`.  After checking the reproducer, the `/=
dev/sg0` seems the most suspicious one since it provides user with direct a=
ccess to hardware.
>
> My hypothesis is such access can somehow tamper the memory without being =
caught by KASAN, and it just so happen in this particular case, the victim =
is ` ip6_dst_alloc`.
>
> So I feel that maybe sending the mail to SCSI maintainers is the right ch=
oice.
>
>
> On Thu, Aug 29, 2024 at 4:07=E2=80=AFAM Bart Van Assche <bvanassche@acm.o=
rg> wrote:
> >
> > On 8/29/24 2:31 AM, Juefei Pu wrote:
> > > Call Trace:
> > >   <IRQ>
> > >   __list_add_valid include/linux/list.h:88 [inline]
> > >   __list_add include/linux/list.h:150 [inline]
> > >   list_add include/linux/list.h:169 [inline]
> > >   ref_tracker_alloc+0x1ef/0x480 lib/ref_tracker.c:213
> > >   __netdev_tracker_alloc include/linux/netdevice.h:4038 [inline]
> > >   netdev_hold include/linux/netdevice.h:4067 [inline]
> > >   dst_init+0xea/0x480 net/core/dst.c:52
> > >   dst_alloc+0x157/0x190 net/core/dst.c:93
> > >   ip6_dst_alloc net/ipv6/route.c:344 [inline]
> > >   icmp6_dst_alloc+0x73/0x410 net/ipv6/route.c:3277
> > >   ndisc_send_skb+0x31b/0x11e0 net/ipv6/ndisc.c:489
> > >   addrconf_rs_timer+0x3a3/0x650 net/ipv6/addrconf.c:4039
> > >   call_timer_fn+0xff/0x240 kernel/time/timer.c:1792
> > >   expire_timers kernel/time/timer.c:1843 [inline]
> > >   __run_timers kernel/time/timer.c:2417 [inline]
> > >   __run_timer_base+0x734/0x9a0 kernel/time/timer.c:2428
> > >   run_timer_base kernel/time/timer.c:2437 [inline]
> > >   run_timer_softirq+0xb3/0x160 kernel/time/timer.c:2447
> > >   handle_softirqs+0x272/0x750 kernel/softirq.c:554
> > >   __do_softirq kernel/softirq.c:588 [inline]
> > >   invoke_softirq kernel/softirq.c:428 [inline]
> > >   __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
> > >   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
> > >   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 =
[inline]
> > >   sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1=
043
> > >   </IRQ>
> >
> > I see networking functions in the above call stack. Why has this report
> > been sent to the SCSI maintainers?
> >
> > Thanks,
> >
> > Bart.
> >

