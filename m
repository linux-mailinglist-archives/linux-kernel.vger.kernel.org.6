Return-Path: <linux-kernel+bounces-404421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E649C438C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E241F21523
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35621A9B43;
	Mon, 11 Nov 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1aB2vl0z"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB61A08DF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346008; cv=none; b=OnEJC55vdJzxqOgDvFO/I5dHsRmdbfTj8CUXOcU7mscOj1HguqzsPOy42FSkaF1wxLPaP5hvlAKSklKiFj+uOyVS+2VuRFkU42tFoV/S3tULOmPAn8SoulVWRnobp37pOJrT41YNWj+R1g9Vi2zajZ/BOYQzn9OSkOfeMc/zvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346008; c=relaxed/simple;
	bh=23WrqE374qcPavVAt8ak/FTD8NqfQn53RxX/2JCrZmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ch+VrBYSasjzI3lKYSRVlkqruCM8Ppc6hYJ6hnwuKgj+5Yuijgayn1i9pJaR/6gLCJr7j6p5Wz/e0dhtcZOwSmD0l3Jqj/yNotSXa7omJt8HZNbg55D8FMdRksYRNu776ir43+5Hyx0zcJEVz6bElJBYebtpdK7OeZpbk2e2bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1aB2vl0z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so83577247b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346006; x=1731950806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFNzzBptbqFMn5hbeVzVEvhXPizvBNs5CQtEzxCma9I=;
        b=1aB2vl0zUTiRw/c861HhWUMHfQD0RF/hSG/RUB66+azolO2oKnW4HEkRl0ND8+1nBg
         XHItKAJGGobjimfyhIZeTI21nIgyhzrRkzzdwfUI+pbKxayuZ41c2keaYnYWFfT2bjU0
         kY77QegWCAdIJc+F6NyPMR8jV2DH21jEGgzZK6jMsOy7PvbBSpBH66Yc5P62SFjps1Sy
         xdcr7o+2yd1gDKApwo2DoN9VKsL8OCVjX3XU/M0OC04IBa9Rz5yiFQEGNXFWN6l1ki5E
         6LjC/3kET0ZEm67+KBnmszEuDjGkmHP0fxuZAsT2ioUMc0qbcXwd1u2u2F8YkLDTPgu4
         jBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346006; x=1731950806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFNzzBptbqFMn5hbeVzVEvhXPizvBNs5CQtEzxCma9I=;
        b=X5OOpuGJE6TpaVVOim6PeUlMx7p+V8D29w0Q3UDX/imLYag+lSMOK2RC8kKP+NaBcd
         IuEwR8SEfbKVWCX28BTIDld3Bbhe8bf4hSmNbb3XfKMKVeSFbUH4Dpc8eOWUSgGfYdrh
         ahmgulRLBVHNwHtRw7k9RKmLpkyACU4sztLis2ekBn9B+scMb7eWvL2Pgdcp5gxiW1U9
         jrk+x+vlfA1Ook5Nsc8wh0bc/flSG4RgeF20Nd49LF5uciWoje4BqGGDXZpF4Ly++ni9
         GACpSWrPcV70Uh8FcFSRq4N7zxwKbY9xcdfBo05B3IM+ClzsCUfQOJXKcdq546QLf+OX
         rh6g==
X-Forwarded-Encrypted: i=1; AJvYcCWxkD5kVHlXAVXH9NfwU5ILlRyVgom2oaKoH1I15+s2AuCqVoOj2s8/+AjaF2yCI/1jUIY1E+V2mYKcDkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrInKjq/pJelXIiB0Lr97+VO72vbIJFOck5axov0QYfOmfgHLF
	aw/wJvejiIkeWtyKDlnbzkYXtKTNC1sUzI+gqdHTWCy0uLJbhjq4B/68c0qwTUENDLwG0CSi6Dz
	K1A==
X-Google-Smtp-Source: AGHT+IEImE/FFMrQDP3H8KYOmoDoy1BC8s/LYapy2rg6qs6vaGT8I3mAESoIofDSpW3UbZ66iGTODCiktXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3688:b0:6ea:fa4:a365 with SMTP id
 00721157ae682-6eaddfec9efmr925017b3.8.1731346005823; Mon, 11 Nov 2024
 09:26:45 -0800 (PST)
Date: Mon, 11 Nov 2024 09:26:44 -0800
In-Reply-To: <20241111125219.361243118@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111115935.796797988@infradead.org> <20241111125219.361243118@infradead.org>
Message-ID: <ZzI-VHh0GpBUph3l@google.com>
Subject: Re: [PATCH v2 12/12] x86/kvm/emulate: Avoid RET for fastops
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: pbonzini@redhat.com, jpoimboe@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	jthoughton@google.com
Content-Type: text/plain; charset="us-ascii"

KVM: x86:

On Mon, Nov 11, 2024, Peter Zijlstra wrote:
> Since there is only a single fastop() function, convert the FASTOP
> stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
> thunks and all that jazz.
> 
> Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
> which not all of them can trivially do (call depth tracing suffers
> here).

Maybe add an example?  Mostly as a reminder of how to reproduce the call depth
issues.

  E.g. booting with "retbleed=force,stuff spectre_v2=retpoline,generic" causes
  KVM-Unit-Test's "emulator" test to fail due to flags being clobbered.

> Objtool strenuously complains about this:
> 
>  - indirect call without a .rodata, fails to determine JUMP_TABLE,
>    annotate
>  - fastop functions fall through, exception
>  - unreachable instruction after fastop_return, save/restore
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The original patch works, but with the fixup KVM fails emulation of an ADC and
generates:

  ------------[ cut here ]------------
  Unpatched return thunk in use. This should not happen!
  WARNING: CPU: 4 PID: 1452 at arch/x86/kernel/cpu/bugs.c:3063 __warn_thunk+0x26/0x30
  Modules linked in: vhost_net vhost vhost_iotlb tap kvm_intel kvm
  CPU: 4 UID: 1000 PID: 1452 Comm: qemu Not tainted 6.12.0-rc5-22582d7d68a6-rev/fastops-miti #11
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:__warn_thunk+0x26/0x30
  Code: 5e ff 7e 05 0f 1f 44 00 00 80 3d 5d 06 5c 01 00 74 05 e9 bd 7d a0 00 48 c7 c7 10 4a 13 82 c6 05 48 06 5c 01 01 e8 31 48 04 00 <0f> 0b e9 a3 7d a0 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90
  RSP: 0018:ffffc90001743c78 EFLAGS: 00010287
  RAX: 0000000000000000 RBX: ffff88811877a040 RCX: 0000000000000027
  RDX: ffff88846f91b208 RSI: 0000000000000001 RDI: ffff88846f91b200
  RBP: ffffc90001743cc8 R08: ffffffff825195c8 R09: 0000000000000003
  R10: ffffffff824395e0 R11: ffffffff824e95e0 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f3027400700(0000) GS:ffff88846f900000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f3029ba3001 CR3: 000000010cdc0000 CR4: 0000000000352eb0
  Call Trace:
   <TASK>
   ? __warn+0x85/0x120
   ? __warn_thunk+0x26/0x30
   ? report_bug+0x17d/0x190
   ? handle_bug+0x53/0x90
   ? exc_invalid_op+0x14/0x70
   ? asm_exc_invalid_op+0x16/0x20
   ? __warn_thunk+0x26/0x30
   ? __warn_thunk+0x26/0x30
   warn_thunk_thunk+0x16/0x30
   ? __kvm_mmu_topup_memory_cache+0x57/0x150 [kvm]
   init_emulate_ctxt+0xae/0x110 [kvm]
   x86_decode_emulated_instruction+0x25/0x80 [kvm]
   x86_emulate_instruction+0x2cb/0x6f0 [kvm]
   vmx_handle_exit+0x394/0x6e0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xf40/0x1db0 [kvm]
   kvm_vcpu_ioctl+0x2e9/0x870 [kvm]
   ? futex_wake+0x81/0x180
   ? call_depth_return_thunk+0x6c/0x90
   ? call_depth_return_thunk+0x66/0x90
   ? call_depth_return_thunk+0x60/0x90
   ? call_depth_return_thunk+0x5a/0x90
   __x64_sys_ioctl+0x8a/0xc0
   do_syscall_64+0x5b/0x170
   entry_SYSCALL_64_after_hwframe+0x71/0x79
  RIP: 0033:0x7f30290cedeb
  Code: 0f 92 c0 84 c0 75 b0 49 8d 3c 1c e8 ff 47 04 00 85 c0 78 b1 48 83 c4 08 4c 89 e0 5b 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a0 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f30273ff748 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f30290cedeb
  RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000000e
  RBP: 0000555587e2f1e0 R08: 00007f302923fc10 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f3029b90780 R14: 00007ffea5ab9640 R15: 00007f30273ffa00
   </TASK>
  ---[ end trace 0000000000000000 ]---

