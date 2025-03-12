Return-Path: <linux-kernel+bounces-557511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B6A5DA31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D413B9655
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA223CEE7;
	Wed, 12 Mar 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrmyhZBR"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2B23C8B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774188; cv=none; b=dmgWFZv2qC5s0/GCaNy7E3ROsK1J+gX21Yw0dgPaM+uKrYzkB55rJO0PZ1OU1H2PA7dkurFcw9YQMn/RYuOHmug6Z/2dIFaCAnwf2gFI6dC4ms6pis8jNjBvppN8SC7TWUHnp1b9WJJU0E89oCt0iVqE3LWoRMRMvudJDvYiGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774188; c=relaxed/simple;
	bh=yeBvl9NQXB6/tc/9Z2/OzmuKYdFcsirwgsfjsOKJD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JML55l64WBTOEcb9RW4W966E1P7jA9l78tOYSrlwWiBEXla38PL2aba9JJG8cSByqC4XjxdgKrJk931VrFEfLhM6zrMLNL3Yn3lKg6FgcSAWeJ0Ce86jm8y+jH62T3vLWJO4IIbnI9sF6BzflyoMyz0V+3ZVnas16zYyJ/rio2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrmyhZBR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-300f92661fcso4133222a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741774185; x=1742378985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUkmPYNjy0UdU5Zc+KUzHJuQSSwR0lKvxdX/nX9inOM=;
        b=lrmyhZBRvVDIYLln21Gfkieip5pwJo9paRLmoTIQFJUnB47mA1Chn378jVWlOPY8R9
         aTEuURzkIJE23KP0TOkCKRbJBn/3Y+fWboIqTdqoEUULqT9FiXuw8Rgdlek/ZtYjr4LW
         1UcYMbJTkEMyOMRsTNOaVwfRWfdmfLvyl1voFBbWZHCVUUXFuSN/7DAAl59WUQqq3nNi
         WIfHztrYcRGnH+q/VJ9R+dfptsmclpgsat7RTruLVN/wDwwwCizYJ6IG3k/eL84TRjks
         +uektXKi6j8/1wUVRL5ML/VwTXXHBOo9/qXMj5PP9irTXArEbctVsn3OStG/f4U2y94T
         SoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774185; x=1742378985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUkmPYNjy0UdU5Zc+KUzHJuQSSwR0lKvxdX/nX9inOM=;
        b=EmfW/RkTKU++crAko2r7LjIe3zxsL91DVxivlDyaSZPFx1ZR5ZYvYizovXSujHZM5I
         6UFI9eeWSg1i5fRjuuGoWBHpG6La+5l9jZ2uzLJRHlItIeHhdz9pF89VV8qrBfrlQzcR
         RmdF2SlHkP3m35je2jUB30LaHPdRpyzaHcMane9drhqFjQtKhCMgYZTDhTa0o2Mi1hiZ
         AdRJiY/lh6o/i2V1ykmyPUNl9qkJ+7S2acir2EakCQ/i/zZAApavroP/PuNXmQTlD3QC
         zMLfx9HfCJrkW/10s0ArBW0CbIw5VNcsE6BM0B8NJsVdbZzWu52XqBNeL6h+xhca2ng9
         9/GA==
X-Gm-Message-State: AOJu0YyzLK7zoW/uwdxeowuq9Pymu+1WZQ1GqVkeEqFrGZEFab2Y9jOy
	ikIYcQLsHfNr/k0gW2zi4NM36R6bjvnuCw+k4vb0AwdAbOLNA4dhXQT+G3zn
X-Gm-Gg: ASbGncsxfuJcSc4DFNnotWt6jx9Pd05iFKwwIvnBbGT1d85WMgKMn+RfspNscTkAMCG
	MrN3/PmZBbg0vgQdpnuwA5FYtDWqx6YJcgcHXFse7sGr0RRpE8OV5w5jEvmLN7tgh6uJN2FLl02
	OzBcPHjTJ4bj79I53NjKHtOPb2vCaQ+BvttexMm6a29NA+XKOQi3ggGpzvILOnDrJafGZ3hSFeg
	ytjvFzPWhNDLDGTYOfgDeCzDf8Me+74xO9tsOD0ZGQDQbIhU45fj3gS3L2WdW88F8A7tuQDeRPH
	zXzmwrbq6kEuqhVet/vYJ3K7utrIDGX7Q9WZuwaXaHJSkCAcBRF/d733Aq8cNNg9S2bmbnUcs2f
	F7lb3FJBymM72IOJg
X-Google-Smtp-Source: AGHT+IG5W7avSkqFsM0U4VrqHLdYim2Wlk3cNiyBJN+U721KvUWNp1+CxCtYAdKtRAYZKbtMVRGUAQ==
X-Received: by 2002:a17:90b:17d0:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2ff7ce7abc1mr31550232a91.13.1741774185017;
        Wed, 12 Mar 2025 03:09:45 -0700 (PDT)
Received: from suda-ws01.. (p1201013-ipoe.ipoe.ocn.ne.jp. [122.26.46.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm112380335ad.91.2025.03.12.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:09:44 -0700 (PDT)
From: Akihiro Suda <suda.gitsendemail@gmail.com>
X-Google-Original-From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	suda.kyoto@gmail.com,
	regressions@lists.linux.dev,
	aruna.ramakrishna@oracle.com,
	tglx@linutronix.de,
	Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: [PATCH v2] x86: disable PKU when running on Apple Virtualization
Date: Wed, 12 Mar 2025 19:09:26 +0900
Message-ID: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAG8fp8Qdmt9vLk=8ORccY5B+ec1huhazXG4PBaNyLEkq31HDjw@mail.gmail.com>
References: <CAG8fp8Qdmt9vLk=8ORccY5B+ec1huhazXG4PBaNyLEkq31HDjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OSPKE seems broken on Apple Virtualization.

  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
  (...)
  Call Trace:
   <TASK>
   ? get_xsave_addr_user+0x28/0x40
   ? __warn.cold+0x8e/0xea
   ? get_xsave_addr_user+0x28/0x40
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? get_xsave_addr_user+0x28/0x40
   copy_fpstate_to_sigframe+0x1be/0x380
   ? __put_user_8+0x11/0x20
   get_sigframe+0xf1/0x280
   x64_setup_rt_frame+0x67/0x2c0
   arch_do_signal_or_restart+0x1b3/0x240
   syscall_exit_to_user_mode+0xb0/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Tested on macOS 13.5.1 running on MacBook Pro 2020 with
Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
Link: https://github.com/lima-vm/lima/issues/3334
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
v2: check oem_table_id rather than oem_id for better robustness
---
 arch/x86/kernel/cpu/common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..8d78d34cd434 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/acpi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -516,6 +517,21 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
+	/*
+	 * OSPKE seems broken on Apple Virtualization.
+	 * https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
+	 *
+	 * TODO: conditionally enable pku depending on the DMI BIOS version when Apple
+	 * fixes the issue.
+	 *
+	 * However, this would be still not enough because DMI is missing when vmlinuz
+	 * is directly loaded into VM.
+	 */
+	if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
+		pr_info("pku: disabled on Apple Virtualization platform (Intel) due to a bug\n");
+		pku_disabled = true;
+	}
+
 	if (c == &boot_cpu_data) {
 		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
 			return;
-- 
2.45.2


