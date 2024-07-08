Return-Path: <linux-kernel+bounces-244651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8C92A767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69471F21524
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAB1465BD;
	Mon,  8 Jul 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrmY9lZp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48526145340
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456555; cv=none; b=BDEv/BdhsiTdaWDDRY2no1DaD7jg6UaGycKM4CMEkwNFKyWOiE/CTDH8lr/+wdbW8hshlcpNSvg1C7sXv1ll4bItV8Pw2gvwESAh5bJajETdafaRTYR3HsB5NhlK3sU0j1I7IfILq8l+kQdRbna2OSgv9wEOhEVR5qZXAkn+2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456555; c=relaxed/simple;
	bh=e89ZCR4p+/bslYdqJGw9aLXtpcnCESD0zAJeHjYrztc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aEGDX7so+ZEvBLR+EyDvSjtHpC4QHN2djWJ9Zk9lUINfoegBDJAt72TNCdGeb1mjXmx8DyQXrRY17d/7Z6CpRYO3v3xyheTXyH6BkdGS4pUclZqRS3BGsZeeyuakcA4Q4DVWmdHzPulDeInPE9wVWvROZVEU+VRkycqYqdVw5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrmY9lZp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af2ac7557so2531142b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720456553; x=1721061353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MufHBG91k0euTLH8vv+ydWhS8IA5IkNDBCpKi8qYZ7M=;
        b=NrmY9lZp5ZDdxw7av86lE7cmkB+nM8pGkDj+VwDbLg1VXUMy+h3WB3nHjEcSbO9Oz6
         x9Lz7jvsu4zMx4tH0PvZw0wFzNwewwg172wgGLf/KsLpJ4M0cLEZSMjLVO/yzAoJ4JYl
         gFEC03RUD/IiiUU52MKRythtd9xI9SZ8FludOIjJSzEoGvu1vrJCr4GuQUkQLpXBllrB
         Rk0cz1b15nEl1NKH/xezzvEVi0itn8LPog2l8gqZCqYmx9g/I4HPhTPkpDSR8f6Etw9N
         SUXwXa4oUXvR+XOUYpPiwpGwdIEG66x74Zz6FRtsUuoWGyM471/MT8EWu7PSw39T6Qds
         97XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456553; x=1721061353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MufHBG91k0euTLH8vv+ydWhS8IA5IkNDBCpKi8qYZ7M=;
        b=fofK9VLhpbsAcGQVb8/tVKp47+qp3TjwUiHH94smou34RgJHWylvy7x4d7XE8bP1Wc
         HqoWSIKBPUjqYf4P5uAr7fpBRluVcSDVTs5vFuCHqRmaL3u/vlpJ+UaLw1uiT81S0+Nq
         za+HIKwMSHvDN5qzpuPUIDg+zdhMDDFML1q2ZLCn0UJMveNkn8WALh7YCSre0lTNbI8s
         ovnhq+MYA1sMwOX0/GQgo88xJLMFWOZgS7mkOmkB1sbDsUQPKE64hVjpULzXiZFGj2eV
         F9JygKFNouyRO9Z/jAbJhIc/SAGVvwaD7uHf7Gydp6tHF+kG+7RB48E/gPkAWhR0pUKV
         ghQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdSGMXvyxpVnOx3ik9R1VrDieUqSC9hl56yUEF6Si3dWqYuW8tER7VIqZX64Z/Bhwm7a6Ea6OTf+RZvOCaK2xjh72jR3xXnkO/HzAM
X-Gm-Message-State: AOJu0Yx0GWbSTjUQITqH+q9V32O41JcGvdzkSpxG9dH0KlMC4bfiyIDo
	8VXIkhvAhgc1Mqhgp+MLz37fH2M09nNj78Wlrc7lMcI6EWrsrpHNCcOcvz0GbAFyWbQrfs338LI
	pIA==
X-Google-Smtp-Source: AGHT+IGr1fzhAam8faHVegOoIl0t7Cy5NUfAAF19iuOEyqLl+VdnUW9tyqPO1/G8QwD9q9rqVS34vO8xrjk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:984d:0:b0:704:2cd2:7822 with SMTP id
 d2e1a72fcca58-70b4365f4b3mr1573b3a.4.1720456553533; Mon, 08 Jul 2024 09:35:53
 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:35:51 -0700
In-Reply-To: <000000000000c2a6b9061cbca3c3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000c2a6b9061cbca3c3@google.com>
Message-ID: <ZowVZ-WgT7lgMt-Z@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_recalculate_apic_map
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	mlevitsk@redhat.com, pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 08, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f3a2439f20d9 Merge tag 'rproc-v6.3' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e2d518c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81f5afa0c201c8de
> dashboard link: https://syzkaller.appspot.com/bug?extid=545f1326f405db4e1c3e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b7be60c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a380a8c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0719d575f3ac/disk-f3a2439f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4176aabb67b5/vmlinux-f3a2439f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2b0e3c0ab205/bzImage-f3a2439f.xz
> 
> The issue was bisected to:
> 
> commit 76e527509d37a15ff1714ddd003384f5f25fd3fc
> Author: Sean Christopherson <seanjc@google.com>
> Date:   Fri Jan 6 01:12:52 2023 +0000
> 
>     KVM: x86: Skip redundant x2APIC logical mode optimized cluster setup
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124fbe60c80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=114fbe60c80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=164fbe60c80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
> Fixes: 76e527509d37 ("KVM: x86: Skip redundant x2APIC logical mode optimized cluster setup")

Known bug, I see if my random thought from that thread actually fixes the issue.

https://lkml.kernel.org/r/20240126161633.62529-1-haoyuwu254%40gmail.com

