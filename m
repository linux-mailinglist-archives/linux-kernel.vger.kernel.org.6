Return-Path: <linux-kernel+bounces-561070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627CA60D38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E9A3AA177
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DC1EDA24;
	Fri, 14 Mar 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GaH0sGeR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE11DE2A5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944389; cv=none; b=t2fVHZRs9M1iAnH/S23CCGsjNLvk/x95fV3499zqOMiuNuJIPKEOVASlXAexQ8CwhZaplTCy+7yUdCKLQft5K6DPMS4OsiTUdvCUpJCzOLQ91IcxrcQs6JvenPuXshYt/yHZ5lMZlZT58wpA6XpG5IejlJlqUANkNFBxXanH9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944389; c=relaxed/simple;
	bh=9KPejcYgPQWoZLY3OvNB6ndV866qO//pAbZhNYYEcVg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Dk0x/xsOnpebJ9EI82bNc8ekBAtriGeYE4PMWCF1sUzNNjCCfXqq2qvnES2GDvKxyNYir7G13RY7TqA/5Htk3kWKYjgvUYhBvf+nk4WnON9He5NkK53SIRj0Hmu77bmgMDj3eVlpAshPvn9KllRAcTXcVp1duSEUh4hTg28tXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GaH0sGeR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso37427345ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741944387; x=1742549187; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIomnUM1ObwovI7+jMPD5tnDDFMcgSa79cSje7Mcl24=;
        b=GaH0sGeRvJJCuQ8fXxw62DvGGnuBYTIkjilct1z36B2CK8UY39JI20yJaK28nZh7cp
         Ew55S6U49j83BAq3r+fJLD/vgeOzoTUvuIGFaLEiZrlTPHTANPgtTsgUvAjrL/e7TJsS
         elU8r4guN9py4+MGLpuXDfPBkqfbq5oXQ2Prfwdz6efzfpMpO0WyUibTJORKSA+RtXjm
         Nrb/ad/kQBp1eRw4vK56Ta5xANJmLJ9WJ5k8YZhsOY7xSUbqWQR8kmftqs6c0tPEiA0O
         zDpsLVSvWl66EyzkSO4MjSFYXxXh0F3YmwJGlZaiBA3yxQjirXDEsVVmRRDUHqi4/s48
         bXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944387; x=1742549187;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIomnUM1ObwovI7+jMPD5tnDDFMcgSa79cSje7Mcl24=;
        b=naMYYOTFPlScaWm1M+jCLpsDp9Uvv5o7tn/FEnBALAmK6aNpr44uDIthL4Jahf1A+8
         3rxgDSJqosdcLwHS6zEU3LtLzMPR9afLV0hbbHd8y5BROJNTaJKbdq/SWNe1efyifpMf
         DnM5+dNgu8AdG2DbnWnVufKyyiUuuCJpf6zMKrqVH81cWZRQui3v/bHu3pJdHvmg+uTg
         Px1W/JIaW3XZ+Jf4HNVnegMxtH9MWuFO6TAxuKOxVNOCn+zZ2eW8Iz5gr2gVgsrDtitN
         NN0lciwd9KuIg2GfXFQhHOJvX3d5fpV8JYuiOTE05Bq4RC//Fvh639Achq9nhOpwQD3K
         bAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPitxlX9IqGj1Xn3SU74ffRlxPOKHghTTuG7NxJdVOCCdEmMD2pOjD2swrVHitA09McKFm82s4WBvlPFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoGGm5Ruo3C8wd5HwFF/hIesGxqNYZUN3koLc9JCedKjrgsPY
	PQE47rzP0YQ4eTfs4zIfYkzT1sDiwL+7OZnQfCchqlZwzGh1acyU0PTCmFCr8ec=
X-Gm-Gg: ASbGncuphxmFrVIzAVkDb65maNP4fHZS74VtEtmNOrbWDAAyVpwBGS0Qfg6U8LTXn0J
	SaMZ4VzkKmxMGhNtxurJkbT/+cjnO8zk7khe6g0140Dw7LncZEWz/EFiAxZwyLRJ/SfDa4zKCiQ
	czaK1re+aaLeBqBnff2EW9WLLS68fG2zrPQORTfuKlPLl7U4olMLR3IB0TlHQaeXgId9SInrt7x
	0kCP4EalQF6wa63JAWbPNswdWoJpNt5AGQQZYw+x+1QUr+Q4DThTxWo2AaRu0i6bTVI2AYKzaAi
	nlw5sTlqv5zLMEs4A5YTTxKGx1ZVD57qBHtGSMRfdgn+abRAxZ/v1mIkaNUFYcdm56o=
X-Google-Smtp-Source: AGHT+IHiGiOU9ohAlsLexvW8pavyjjMgJ95S5cWuBYJBZm1j31219a1vu4hI7Lz1u+vTNN/5fDQ2pg==
X-Received: by 2002:a05:6a21:38c:b0:1f5:769a:a4c0 with SMTP id adf61e73a8af0-1f5c11f2c72mr3167518637.22.1741944386953;
        Fri, 14 Mar 2025 02:26:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e4cd5sm2467828a12.31.2025.03.14.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:26:26 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	debug@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: traps: handle uprobe event in software-check exception
Date: Fri, 14 Mar 2025 17:26:14 +0800
Message-Id: <20250314092614.27372-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Handle the uprobe event first before handling the CFI violation in
software-check exception handler. Because when the landing pad is
activated, if the uprobe point is set at the lpad instruction at
the beginning of a function, the system triggers a software-check
exception instead of an ebreak exception due to the exception
priority, then uprobe can't work successfully.

Co-developed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---

This patch is based on top of the following series
[PATCH v11 00/27] riscv control-flow integrity for usermode

 arch/riscv/kernel/traps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3f7709f4595a..ef5a92111ee1 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -386,9 +386,12 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
-		/* not a cfi violation, then merge into flow of unknown trap handler */
-		if (!handle_user_cfi_violation(regs))
-			do_trap_unknown(regs);
+		/* handle uprobe event frist */
+		if (!probe_breakpoint_handler(regs)) {
+			/* not a cfi violation, then merge into flow of unknown trap handler */
+			if (!handle_user_cfi_violation(regs))
+				do_trap_unknown(regs);
+		}
 
 		irqentry_exit_to_user_mode(regs);
 	} else {
-- 
2.17.1


