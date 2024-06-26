Return-Path: <linux-kernel+bounces-231425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B977E919891
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC46281A18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F91922FD;
	Wed, 26 Jun 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="IG3BWFnv"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA219149E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431600; cv=none; b=JjUK7T3mhpvGAFgsSHakgyAfAfMu/JkeQQR1+Fiw35CK+227oX/hHanyOQtiyNq2SJQ0BW9i4JghkbctqfRAd8DeasgNHb/Xz8yFN9VniT33ivxoCDzFj39JnLM5AUgp0PfzBTrIS5/rEtZhAtYBK5PRJwWUN73uAQBMrTNl2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431600; c=relaxed/simple;
	bh=1QEh23rhYf4a8TyCjkUO+ENFz49tfP9R+Ny6mFXaNaA=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=FIG3T4rfgFCKZ1fqQD6+OWODrAh7hbF3P5ROVwIwZvGqBlnuUu7Zm32pPdfapx8cznRjLn6SMUORlnM6ApYT1/yUtzGk5bZVOJ66cwx5S7LNethXXs8fyzmAvCMSQ3wiwYWU8pVzThZymP4/B5lnybzUrWab1x02C3rXLmAaxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=IG3BWFnv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c03dbddb8so238356285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1719431597; x=1720036397; darn=vger.kernel.org;
        h=message-id:date:mime-version:subject:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjWXAkAC5kgrEcfNot74i+4PV0JZbnmWscCUYn4GOE0=;
        b=IG3BWFnvYKBmyf3IoPGDHAqmVUvj9Jiu0RSmfnKrKla6EP3xukzMV+qYHf/OajdauE
         su8ladAuS+s/L48zUHQ9SaYy892rPvfooz1STdBx9O09h4vWx349Eg1PC+T3Rmkym9UI
         hH3cxXgXT1U+cu4mWYsBze1hpugpQzvkiIkG9wn7Kr0kMdbD4+sowQxmfDQfuAzcQrVW
         YqfTrRjE6nl7l/+L8Wsw09gEaM3Y86F5zahqYjSukNbtGXX0/qrVYxpPeFZgYNNYJzeB
         aAYNgsRAetyEH1q0oHrD/PuoFpw8xQk0VHTqxTtwG+vPzuEFXXjNwCtzMr2BDroaUDat
         kiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431597; x=1720036397;
        h=message-id:date:mime-version:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjWXAkAC5kgrEcfNot74i+4PV0JZbnmWscCUYn4GOE0=;
        b=bHwRD2DpzXQypKEFKYhzgwBN5Ome2DvfpjOMYJmWda4mJNwgslSt8nyB15ILIrqtL5
         Rwa7uBhtXf8XhoZi71dIlg7HSg4r0DAjZ4EMQpOz6gSwQdON8wfOH4+nQhybZcrZ55/6
         vo6IbpjxPVIUltb+OzZMiqySHwFbhVZdSpMiKnvY7QKV+m1TKuPQnrYVict0MQVLUS2/
         w69H2Oydg6uqCbGq8zf6cgx9Fkepn6uoU65WF1frhrV6LtUn6v0maD/eU8/ZrYbXewfE
         f38vztY6yOf0PzxS9nLcLDUQOCXWgj9UYI7DWHqLE6ExjrsWRA6J86hDPXDjj1Ur1/U5
         UHaA==
X-Gm-Message-State: AOJu0YxR7+/SMs3f3qPdQD9y2aeVSkxmf8rrKJmrwua4w4sXExetyZAl
	QCpwmTfeW0CFQZ8d/ZUMI4cUD2kaIJDQkX9wmaihCCN13jOk1wCQ/YpJCE5fU3RhfjY/9mruy5D
	b
X-Google-Smtp-Source: AGHT+IEBuatCR1C+Go3vew22OjKs+E9r7BqKg/TyOpKmpSRyvzqpOwHQLFX4x2E11Nkyb9X80cgpJQ==
X-Received: by 2002:a05:620a:461f:b0:795:5cfd:81bf with SMTP id af79cd13be357-79be46fcdbdmr1557572285a.30.1719431596394;
        Wed, 26 Jun 2024 12:53:16 -0700 (PDT)
Received: from turing-police (c-73-31-28-59.hsd1.va.comcast.net. [73.31.28.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d58a4a443sm31659785a.128.2024.06.26.12.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:53:15 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.8+dev
To: linux-kernel@vger.kernel.org
Subject: next-20240613 system crash in usercopy during ia32 emulation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Jun 2024 15:53:14 -0400
Message-ID: <9847.1719431594@turing-police>

Been a while since I've managed to repeatably crash a linux-next kernel...

Setup:  I found myself needing to build an i686 RPM on a Fedora system. So I
followed the docs, installed mock and tried to run it..

mock -r /etc/mock/fedora-rawhide-i386.cfg /path/to/srpm

And it dies while trying to populate the chroot environment with RPMs, before
it even looks at the srpm. Have triggered it twice, haven't dug in  to see if
it dies at the same RPM, or in more detail what it's doing besides "installing
an i686 rpm".

% zgrep -i ia32 /proc/config.gz 
CONFIG_IA32_FEAT_CTL=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y

but /proc/cmdline does contain  ia32_emulation=1.

Any ideas?

What got left in pstore:

[  863.309804][ T4890] usercopy: Kernel memory overwrite attempt detected to SLUB object 'task_struct' (offset 10880, size 160)!
[  863.391576][ T4890] ------------[ cut here ]------------
[  863.471844][ T4890] kernel BUG at mm/usercopy.c:102!
[  863.552181][ T4890] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  863.632443][ T4890] CPU: 1 PID: 4890 Comm: sh Tainted: G          I     T  6.10.0-rc3-next-20240613 #80 ddf22571ffa7b333da0a09c88396e47266906b78
[  863.712707][ T4890] Tainted: [I]=FIRMWARE_WORKAROUND, [T]=RANDSTRUCT
[  863.792967][ T4890] Hardware name: Dell Inc. Inspiron 5559/052K07, BIOS 1.9.0 09/07/2020
[  863.873227][ T4890] RIP: 0010:usercopy_abort+0x77/0x79
[  863.953494][ T4890] Code: 04 5d 00 90 eb 0e 48 c7 c2 25 9b 02 90 48 c7 c7 18 bc ff 8f 56 48 89 fe 48 c7 c7 f8 44 0a 90 51 48 89 c1 41 52 e8 19 6f ff ff <0f> 0b 48 89 d9 48 2b 08 41 0f b6 d5 4d 89 e0 31 f6 48 c7 c7 2d 3f
[  864.033756][ T4890] RSP: 0000:ffff95380525fbe8 EFLAGS: 00010246
[  864.114016][ T4890] 
[  864.194277][ T4890] RAX: 0000000000000069 RBX: ffff8fdd8214d8c0 RCX: 0000000000000000
[  864.274542][ T4890] RDX: 0000000000000000 RSI: ffffffff8fffa9a5 RDI: 00000000ffffffff
[  864.354809][ T4890] RBP: ffff95380525fc00 R08: 0000000000000000 R09: ffff95380525fa48
[  864.435074][ T4890] R10: ffffffff90b7e028 R11: 0000000000000003 R12: 00000000000000a0
[  864.515370][ T4890] R13: 0000000000000000 R14: ffff8fdd8214d960 R15: ffff8fdd8214d8c0
[  864.595632][ T4890] FS:  0000000000000000(0003) GS:ffff8fe072400000(0063) knlGS:00000000f7f8c900
[  864.675897][ T4890] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  864.756163][ T4890] CR2: 00007fed02b68000 CR3: 0000000196fd0003 CR4: 00000000003706f0
[  864.836442][ T4890] Call Trace:
[  864.916728][ T4890]  <TASK>
[  864.996994][ T4890]  ? show_trace_log_lvl+0x1ff/0x2d0
[  865.077303][ T4890]  ? show_trace_log_lvl+0x1ff/0x2d0
[  865.157570][ T4890]  ? __check_heap_object+0x82/0xa0
[  865.237837][ T4890]  ? show_regs.part.0+0x1d/0x23
[  865.318109][ T4890]  ? __die_body.cold+0x8/0xd
[  865.398383][ T4890]  ? __die+0x29/0x40
[  865.478652][ T4890]  ? die+0x2e/0x50
[  865.558919][ T4890]  ? do_trap+0xb7/0x100
[  865.639188][ T4890]  ? do_error_trap+0x75/0x110
[  865.719518][ T4890]  ? usercopy_abort+0x77/0x79
[  865.799792][ T4890]  ? exc_invalid_op+0x56/0x70
[  865.880055][ T4890]  ? usercopy_abort+0x77/0x79
[  865.960342][ T4890]  ? asm_exc_invalid_op+0x1f/0x30
[  866.040645][ T4890]  ? usercopy_abort+0x77/0x79
[  866.120907][ T4890]  ? usercopy_abort+0x77/0x79
[  866.201167][ T4890]  __check_heap_object+0x82/0xa0
[  866.281490][ T4890]  check_heap_object+0x141/0x160
[  866.361757][ T4890]  __check_object_size.part.0+0x5d/0xc0
[  866.442022][ T4890]  __check_object_size+0x1d/0x30
[  866.522299][ T4890]  copy_from_buffer+0x45/0x70
[  866.602638][ T4890]  copy_uabi_to_xstate+0x12e/0x230
[  866.682907][ T4890]  copy_sigframe_from_user_to_xstate+0x20/0x30
[  866.763183][ T4890]  __fpu_restore_sig+0x303/0x320
[  866.843508][ T4890]  fpu__restore_sig+0x50/0x90
[  866.923798][ T4890]  ia32_restore_sigcontext+0x11c/0x150
[  867.004069][ T4890]  __do_compat_sys_sigreturn+0x8d/0xd0
[  867.084343][ T4890]  ia32_sys_call+0x1a9b/0x23f0
[  867.164608][ T4890]  do_int80_emulation+0x91/0x120
[  867.244874][ T4890]  asm_int80_emulation+0x1f/0x30
[  867.325161][ T4890] RIP: 0023:0xf7f91579
[  867.405501][ T4890] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00
[  867.485772][ T4890] RSP: 002b:00000000ffd5d840 EFLAGS: 00000286
[  867.646290][ T4890] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000ffd5d944
[  867.726585][ T4890] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000583a9e30
[  867.806846][ T4890] RBP: 00000000ffd5d8e8 R08: 0000000000000000 R09: 0000000000000000
[  867.887127][ T4890] R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
[  867.967386][ T4890] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  868.047696][ T4890]  </TASK>
[  868.127955][ T4890] Modules linked in: snd_hrtimer ts_bm nft_limit algif_hash algif_skcipher xt_string af_alg xt_LOG nf_log_syslog nft_compat bnep nf_tables sunrpc amdgpu amdxcp drm_exec gpu_sched binfmt_misc btusb btrtl btintel btbcm intel_rapl_msr rtsx_usb dell_smm_hwmon intel_rapl_common x86_pkg_temp_thermal intel_powerclamp crct10dif_pclmul radeon crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel bluetooth cryptd sha512_ssse3 sha256_ssse3 sha1_ssse3 drm_ttm_helper drm_suballoc_helper intel_pch_thermal fan vfat fat tpm_crb uas joydev serio_raw bfq fuse dmi_sysfs
[  895.745791][ T4890] ---[ end trace 0000000000000000 ]---
[  910.594045][ T4890] RIP: 0010:usercopy_abort+0x77/0x79
[  910.694667][ T4890] Code: 04 5d 00 90 eb 0e 48 c7 c2 25 9b 02 90 48 c7 c7 18 bc ff 8f 56 48 89 fe 48 c7 c7 f8 44 0a 90 51 48 89 c1 41 52 e8 19 6f ff ff <0f> 0b 48 89 d9 48 2b 08 41 0f b6 d5 4d 89 e0 31 f6 48 c7 c7 2d 3f
[  910.774952][ T4890] RSP: 0000:ffff95380525fbe8 EFLAGS: 00010246
[  910.855542][ T4890] 
[  910.935811][ T4890] RAX: 0000000000000069 RBX: ffff8fdd8214d8c0 RCX: 0000000000000000
[  911.016089][ T4890] RDX: 0000000000000000 RSI: ffffffff8fffa9a5 RDI: 00000000ffffffff
[  911.096357][ T4890] RBP: ffff95380525fc00 R08: 0000000000000000 R09: ffff95380525fa48
[  911.176624][ T4890] R10: ffffffff90b7e028 R11: 0000000000000003 R12: 00000000000000a0
[  911.256892][ T4890] R13: 0000000000000000 R14: ffff8fdd8214d960 R15: ffff8fdd8214d8c0
[  911.337181][ T4890] FS:  0000000000000000(0003) GS:ffff8fe072800000(0063) knlGS:00000000f7f8c900
[  911.417466][ T4890] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  911.497743][ T4890] CR2: 00007feedd108640 CR3: 0000000196fd0006 CR4: 00000000003706f0
[  911.578040][ T4890] Kernel panic - not syncing: Fatal exception
[  911.658351][ T4890] Kernel Offset: 0xd000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


