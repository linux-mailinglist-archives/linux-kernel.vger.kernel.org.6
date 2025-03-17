Return-Path: <linux-kernel+bounces-564742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7EEA65A23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713A318998FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367D1E5B77;
	Mon, 17 Mar 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RSSH4PMR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775311C8624
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231298; cv=none; b=Ha7NXbhR8K2FvNRDS3YcyKx23b7UgqYI81u5v/v+jPgu5QDiZUMD8TMCqTOnMpq35j4E7w2m8qzsLYATsbY6IVkgHeWR71glBwxeOqRmWhX3vHFNfkTIX/LsiUNLIu2my8s/Fu73LpwcOSFuLaX8HWPgvoIJ7ggkAt98/zTRWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231298; c=relaxed/simple;
	bh=m22pBr3V6eaVlLVIX44rOw00wFDH5N5l1rGKB3m4pxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4dW/xEpLoT9YBpyKp10lNp4OHIAGhwibZv/KKXPi95Gp5/OAE9VRwRxlYVfuB+Gqjxzq8Vj0NMfREwfHBVfIM7lE5+6CJikjoruA0lA/gDzDM/1cT0geFTw9ow55EfYVSBELZKmzxEnceG3wXrV3/PQLNCWNgnEPIxPlbQp6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RSSH4PMR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948021a45so25174755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231294; x=1742836094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjeBRUPbBkNgIlDeDsLglyk/HEJX/vNaDwxAgvCJumI=;
        b=RSSH4PMRsfeCZiWscD1JYj+yEnxbSVZ/bWe7EvT8f5S4lgd00i0g3osurYR7gu0lKS
         1KaI9sbd4XugSVanJWNMV7w1ZTkE3HkmR/Cj1JNB6CsZxXqm1z/y8YJjFF5kmGqCZd4m
         zI61GGTPhlXelbPiO9LekJhFT/0hmhG/LIf0azpeyKuYcEVF3z13ezHEP2QpkzWBbPpF
         76oCXswhS7q0OcxGmFW/Y9tKMbXqKFD+62dPAXNqt35ZODalW92kXYPZbHV4g5ZL6lx3
         5MjfXUMoercuOjOCWWf51HYIaVDvMK5b9kDCjhUd2DH0UBt57xd9vFsnXeE7r1fo/VAv
         ix7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231294; x=1742836094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjeBRUPbBkNgIlDeDsLglyk/HEJX/vNaDwxAgvCJumI=;
        b=i7AjQP/Txmli0ty5+i3iY6eqLomNb08CPgWCIOHShBVWdwb/LnqMrjMjtub/M0VFl1
         K5hqtTd26d/0BTmVpN4oqztXpP8D0lm7z8rrveb1dEH/7YwyR9iD1lfQKalDt4TLP/su
         i3xHD8m9a9eUEq4AZsGfr7nD48FdMf4+3Dzx/tEnzV3Gu1R9n8Dt3imj8f+m9XByJ67I
         7xlmh3WvGofFgxKAOotQ77B4HPD/SpmkAvhSiBanmNyzb8BJg1NKPF6fZtBnoAtRaf9Y
         49NXFH44s1Zxj4fSMGBpnJ7BGeA4JJO82jA4+ZVCqQi6ILNcyfFmf0pcU0/RG+Nt8oeZ
         0aiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi6oZrkt5jmBVM2M261NSTPNYMNNf7ErUKAUgH7qlMZGoO7iNZ86BCwkIJEmiMNaRyeZ9UcCVcJVUMuCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuczkppgycD0LryErHv++j/QH2YDhs/YDZCF616sPIx5+4bpS
	+gMhKAAhSOaOuoUMPIG2Imf3Vot/TCARaxOqPjPg5BPfukTqZ20m+/5zfhYiB8MF64ppp5BO1pq
	Zd2s=
X-Gm-Gg: ASbGncsCiWLNVOXhmdShc5Vv4Mwy7Au0OVyv9B4AwpC+sq+BRBXSl+vWICjqWosfhkR
	IaS/WCrcmY69EXSi3lLpOVuL2BbTwhfpgKLzYdwpWkTm2Dvdz89DSvRTDILDHeljjPAuIVElUHA
	Okb7ABP7wzf/K2vqyVzwnNdq1DNjtW0y7ORLH12WQjE2uUF1BzlaYMEivHtGUgFg6fc89ffN5+P
	LP7NOMiK4HZnQWh6lkkgGcJsh+6UtM7MugGidj37z6DCrzs7vXvgxfRLFxCnlG37apua5RiEkkl
	Q/iv82PlNUWEWv/uFVpEXxm/gkgoNN4qQ5oNpIylWvxZCxkgLlfe+LZh
X-Google-Smtp-Source: AGHT+IEAV1SSYPsskoq8q0qrPU5Tio7ya8gNR4WNeMxWQDKOPXJ0cX+p31upeUPN82mA8abBVPNApw==
X-Received: by 2002:a05:600c:4ed3:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43d1ec80917mr153430805e9.15.1742231293673;
        Mon, 17 Mar 2025 10:08:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 06/18] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
Date: Mon, 17 Mar 2025 18:06:12 +0100
Message-ID: <20250317170625.1142870-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

schedule_on_each_cpu() was used without any good reason while documented
as very slow. This call was in the boot path, so better use
on_each_cpu() for scalar misaligned checking. Vector misaligned check
still needs to use schedule_on_each_cpu() since it requires irqs to be
enabled but that's less of a problem since this code is ran in a kthread.
Add a comment to explicit that.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index fa7f100b95bd..4584f2e1d39d 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -616,6 +616,10 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 		return false;
 	}
 
+	/*
+	 * While being documented as very slow, schedule_on_each_cpu() is used since
+	 * kernel_vector_begin() expects irqs to be enabled or it will panic()
+	 */
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
@@ -636,7 +640,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(void *arg __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -677,7 +681,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	schedule_on_each_cpu(check_unaligned_access_emulated);
+	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
 	for_each_online_cpu(cpu)
 		if (per_cpu(misaligned_access_speed, cpu)
-- 
2.47.2


