Return-Path: <linux-kernel+bounces-242629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F9928A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC10B27061
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708615216D;
	Fri,  5 Jul 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K8tSCCJu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48D16B39A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189276; cv=none; b=YAwuX6rVIGRlUvWK2P0vJ7HRmlIHa7px1rTKHLtuPOz0EnS1O+44VNHr4n+Mvb/6zBoN12kSZs0oFGDPN+yI3OTf7kkyFK91j+l/w5SMu8yQ3fodBmmqFUXRRtRJA6POD9wqeZGWZrCZCP4jTw8a0LMMbi3t9s7RNNjasCiaLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189276; c=relaxed/simple;
	bh=B6/NKTO7w9GO7UN/5d2CmkHyEASOH44vS00AdEQjRcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4un4uvMMJJWH53m8SpFa1+y+jy+1Bw61zkjXPs5S7GclchCzQv7mQ9IPctl8/B4tf1VypIxZm8teUcQLQmb9+t/4FgZYm9FaMqQm+DAQ9x7udipP8K/gWegAA+ocftdJB43YsPRl+4vCwyJ8yMKRichNqHnBUg9DDoJHE0SbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K8tSCCJu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720189273;
	bh=B6/NKTO7w9GO7UN/5d2CmkHyEASOH44vS00AdEQjRcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8tSCCJuxIigCXGDl9w5gNLpXaP+vfXrDzluqKlAgZ91hsyowCRkGz7DyQLOJfmij
	 kGNeLbeY9ThOM+zLaLPCUkM3f0d5s12hUHhx7oU/G3Qp5+ys1ijsN1yY11hQNXFcw6
	 sFqAx/pJUWdjClpbOkY7GVfVJ8W1dZoE0/SF5/VOjmVyUzoJ/Gho57S4rNa1Xf2qWX
	 3mf/iHcSp8kVANV2GU96IwoJBXTiK6LtB6YDACHfVtITb5fCQPDQi6zMaDVr04oI/P
	 9o4gEvT8ZG30I0LYKaJandy4nPwe9ZsY0nHAxhwOXyjHqvC5L425HCgq6OUh5hCOKl
	 TiwFJOd4PJIyw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E9F037813B9;
	Fri,  5 Jul 2024 14:21:13 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	mingo@kernel.org
Subject: Re: [REGRESSION] next boot regression caused by RIP: 0010:usercopy_abort+0x74/0x76 kernel panic
Date: Fri,  5 Jul 2024 16:21:30 +0200
Message-Id: <20240705142130.928396-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240607151439.175035-1-laura.nao@collabora.com>
References: <20240607151439.175035-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/7/24 17:14, Laura Nao wrote:
> Hello,
> 
> KernelCI has detected a boot regression affecting all AMD and Intel
> Chromebooks in the Collabora LAVA lab, occurring between next-20240605
> and next-20240606.
> 
> The following kernel panic has been reported in the logs. The trace
> provided below is from an Acer Chromebook 317, with similar traces
> observed on other devices:
> 
> [    5.944268] RIP: 0010:usercopy_abort+0x74/0x76
> [    5.944276] Code: 0f 89 9f 51 48 0f 45 d6 49 c7 c3 ac c1 7c 9f 4c 89 d1 57 48 c7 c6 38 54 7b 9f 48 c7 c7 b5 c1 7c 9f 49 0f 45 f3 e8 b9 8c e4 ff <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
> [    5.944278] RSP: 0000:ffffb01e8001fb90 EFLAGS: 00010246
> [    5.944280] RAX: 0000000000000068 RBX: 0000000000000d80 RCX: 0000000000000000
> [    5.944281] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> [    5.944282] RBP: 0000000000000000 R08: 0000000000000003 R09: 2079726f6d656d20
> [    5.944284] R10: 79706f6372657375 R11: 79706f6372657375 R12: ffff8e7b400a8800
> [    5.944285] R13: 0000000000000d80 R14: 0000000000000000 R15: 00000000ff879a40
> [    5.944286] FS:  0000000000000000(0003) GS:ffff8e7bc0100000(0063) knlGS:00000000eca4d440
> [    5.944288] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [    5.944289] CR2: 00000000080e61d0 CR3: 0000000107002000 CR4: 0000000000350ef0
> [    5.944290] Call Trace:
> [    5.944293]  <TASK>
> [    5.944295]  ? __die_body+0x1b/0x5d
> [    5.944300]  ? die+0x31/0x4b
> [    5.944303]  ? do_trap+0x7c/0xfe
> [    5.944306]  ? usercopy_abort+0x74/0x76
> [    5.944309]  ? usercopy_abort+0x74/0x76
> [    5.944312]  ? do_error_trap+0x6f/0x99
> [    5.944315]  ? usercopy_abort+0x74/0x76
> [    5.944318]  ? exc_invalid_op+0x4e/0x65
> [    5.944321]  ? usercopy_abort+0x74/0x76
> [    5.944324]  ? asm_exc_invalid_op+0x16/0x20
> [    5.944327]  ? usercopy_abort+0x74/0x76
> [    5.944330]  __check_heap_object+0xcb/0x110
> [    5.944334]  __check_object_size+0x181/0x26d
> [    5.944336]  copy_from_buffer+0x43/0x66
> [    5.944340]  copy_uabi_to_xstate+0x113/0x194
> [    5.944343]  __fpu_restore_sig+0x3a3/0x4be
> [    5.944347]  fpu__restore_sig+0x6c/0x83
> [    5.944350]  ia32_restore_sigcontext+0x14e/0x16d
> [    5.944354]  __do_compat_sys_sigreturn+0x7b/0xbc
> [    5.944357]  do_int80_emulation+0xad/0xd3
> [    5.944360]  ? handle_mm_fault+0x10e/0x199
> [    5.944363]  ? exc_page_fault+0x27b/0x42f
> [    5.944365]  ? fpregs_assert_state_consistent+0x22/0x47
> [    5.944368]  ? clear_bhb_loop+0x45/0xa0
> [    5.944370]  ? clear_bhb_loop+0x45/0xa0
> [    5.944372]  ? clear_bhb_loop+0x45/0xa0
> [    5.944374]  ? clear_bhb_loop+0x45/0xa0
> [    5.944375]  ? clear_bhb_loop+0x45/0xa0
> [    5.944377]  ? clear_bhb_loop+0xe/0xa0
> [    5.944379]  asm_int80_emulation+0x16/0x20
> [    5.944382] RIP: 0023:0xeca52579
> [    5.944384] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> [    5.944386] RSP: 002b:00000000ff879cbc EFLAGS: 00000246
> [    5.944387] RAX: 0000000000000060 RBX: 00000000ffffffff RCX: 00000000ff879d08
> [    5.944389] RDX: 0000000000000000 RSI: 0000000009b111a0 RDI: 00000000ff879d08
> [    5.944390] RBP: 00000000080d1801 R08: 0000000000000000 R09: 0000000000000000
> [    5.944391] R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
> [    5.944392] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    5.944393]  </TASK>
> [    5.944394] Modules linked in:
> [    5.944433] ---[ end trace 0000000000000000 ]---
> [    6.287986] RIP: 0010:usercopy_abort+0x74/0x76
> [    6.293033] Code: 0f 89 9f 51 48 0f 45 d6 49 c7 c3 ac c1 7c 9f 4c 89 d1 57 48 c7 c6 38 54 7b 9f 48 c7 c7 b5 c1 7c 9f 49 0f 45 f3 e8 b9 8c e4 ff <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
> [    6.313975] RSP: 0000:ffffb01e8001fb90 EFLAGS: 00010246
> [    6.319810] RAX: 0000000000000068 RBX: 0000000000000d80 RCX: 0000000000000000
> [    6.327780] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> [    6.335744] RBP: 0000000000000000 R08: 0000000000000003 R09: 2079726f6d656d20
> [    6.343710] R10: 79706f6372657375 R11: 79706f6372657375 R12: ffff8e7b400a8800
> [    6.351678] R13: 0000000000000d80 R14: 0000000000000000 R15: 00000000ff879a40
> [    6.359646] FS:  0000000000000000(0003) GS:ffff8e7bc0000000(0063) knlGS:00000000eca4d440
> [    6.368680] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [    6.375098] CR2: 00000000f322e480 CR3: 0000000107002000 CR4: 0000000000350ef0
> [    6.383065] Kernel panic - not syncing: Fatal exception
> [    6.388907] Kernel Offset: 0x1ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> The full kernel log is available on [1]. The config used was the
> upstream x86_64 defconfig with a fragment applied on top [2].
> 
> The issue is still present on next-20240607.
> 
> I'm sending this report to track the regression while a fix is
> identified. I'll investigate the issue/run a bisection and report back
> with the results.
>

Reverting this series fixes the issue first observed in next-20240606
(CC Ingo):
https://lore.kernel.org/all/20240605083557.2051480-1-mingo@kernel.org/

The issue is no longer present as of next-20240703, where the series was
dropped. I'm marking this as resolved for now.

Thanks,

Laura

#regzbot link: https://lore.kernel.org/all/20240605083557.2051480-1-mingo@kernel.org/
#regzbot resolve: not occurring on next-20240703
 

