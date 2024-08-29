Return-Path: <linux-kernel+bounces-306688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA0296421D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC051F236FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE218CBE6;
	Thu, 29 Aug 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRe4Epic"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC1189F58
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928042; cv=none; b=W0siSOdd/crestCNeEtW0qZm7lH7DkQLo8Ihyn51sATadnjgifZleJ3wtnoCFcmA8jQQglpirW24g6NCFthhFdRsk+4FFvljwY8tZa8MV5mOy+wd344dK+NCnnIreyfXcFa/5gQLNXqHPR3TCGyaXKnw9Qbg7PaN7HJ3oUKKpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928042; c=relaxed/simple;
	bh=bjgxWAIrbpBeEP/yKXyhyR1L8zbeQdLVRpO6Kfik8uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=BpaCCo8CoAySZmQngTNCER19fPpGW8YH5D4JGnY1VKJJ4/P/xsLify51AXDmheMckRWCXN8Jc+vYdJQpeyXkAVMlW2XxSVrOnmFFc4sLnB5bDoun3Pi9LCqjZipRWxEn7ZOPC22zHtLJCyWdOEzHajYtjMfHWLq9nwhXA8yZdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRe4Epic; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPYOsq0zNpNDeeF5ErA4dFrCWXZ8cDxv4BVh2lRlYfg=;
	b=bRe4EpicOruKSHwpB5f/TBMrA5AitGgzlCIds3RkASb6UDBsj5dq9+3pHCCHbyktiSrn2w
	L+PeRm2M2zwZd/NfVHCvc8/2n4d415e83AGF7dbqoKgNBj1QHcOZFO7XSzNN3n97NMykhl
	bLQPeZGuKhe5ZqTPcUu8gTgVoiWV6aA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-o2ldxys3ND2PvqLHNLZhHA-1; Thu,
 29 Aug 2024 06:40:36 -0400
X-MC-Unique: o2ldxys3ND2PvqLHNLZhHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837DE19560B4;
	Thu, 29 Aug 2024 10:40:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCEA819560AA;
	Thu, 29 Aug 2024 10:40:30 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
Date: Thu, 29 Aug 2024 18:40:16 +0800
Message-ID: <20240829104016.84139-3-bhe@redhat.com>
In-Reply-To: <20240829104016.84139-1-bhe@redhat.com>
References: <20240829104016.84139-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Recently, it's reported that kdump kernel is broken during bootup on
SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
IMA measurement log on kexec"). Just nobody ever tested it on SME
system when enabling CONFIG_IMA_KEXEC.

--------------------------------------------------
 ima: No TPM chip found, activating TPM-bypass!
 Loading compiled-in module X.509 certificates
 Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
 ima: Allocated hash algorithm: sha256
 Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
 Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
 RIP: 0010:ima_restore_measurement_list+0xdc/0x420
 Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
 RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
 RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
 RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
 R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
 R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
 Call Trace:
  <TASK>
  ? show_trace_log_lvl+0x1b0/0x2f0
  ? show_trace_log_lvl+0x1b0/0x2f0
  ? ima_load_kexec_buffer+0x6e/0xf0
  ? __die_body.cold+0x8/0x12
  ? die_addr+0x3c/0x60
  ? exc_general_protection+0x178/0x410
  ? asm_exc_general_protection+0x26/0x30
  ? ima_restore_measurement_list+0xdc/0x420
  ? vprintk_emit+0x1f0/0x270
  ? ima_load_kexec_buffer+0x6e/0xf0
  ima_load_kexec_buffer+0x6e/0xf0
  ima_init+0x52/0xb0
  ? __pfx_init_ima+0x10/0x10
  init_ima+0x26/0xc0
  ? __pfx_init_ima+0x10/0x10
  do_one_initcall+0x5b/0x300
  do_initcalls+0xdf/0x100
  ? __pfx_kernel_init+0x10/0x10
  kernel_init_freeable+0x147/0x1a0
  kernel_init+0x1a/0x140
  ret_from_fork+0x34/0x50
  ? __pfx_kernel_init+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:ima_restore_measurement_list+0xdc/0x420
 Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
 RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
 RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
 RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
 R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
 R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: disabled
 Rebooting in 10 seconds..

From debugging printing, the stored addr and size of ima_kexec buffer
are not decrypted correctly like:
 ------
 ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
 ------

There are three pieces of setup_data info passed to kexec/kdump kernel:
SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
ima_kexec buffer suffered from the incorrect decryption. After
debugging, it's because of the code bug in early_memremap_is_setup_data()
where checking the embedded content inside setup_data takes wrong range
calculation.

The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
and the length of setup_data is 0x10. When checking if data is inside
the embedded conent of setup_data, the starting address of efi data and
rng_seed happened to land in the wrong calculated range. While the
ima_kexec's starting address unluckily doesn't pass the checking, then
error occurred.

Here fix the code bug to make kexec/kdump kernel boot up successfully.

And also fix the similar buggy code in memremap_is_setup_data() which
are found out during code reviewing.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index f1ee8822ddf1..4cadc7ef1cb4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -657,7 +657,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 		paddr_next = data->next;
 		len = data->len;
 
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) && (phys_addr < (paddr + sd_size + len))) {
 			memunmap(data);
 			return true;
 		}
@@ -721,7 +721,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 		paddr_next = data->next;
 		len = data->len;
 
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) && (phys_addr < (paddr + sd_size + len))) {
 			early_memunmap(data, sizeof(*data));
 			return true;
 		}
-- 
2.41.0


