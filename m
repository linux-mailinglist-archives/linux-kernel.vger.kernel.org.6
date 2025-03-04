Return-Path: <linux-kernel+bounces-544095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D0A4DD54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4849C177555
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4F20370B;
	Tue,  4 Mar 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JSyVTiO6"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91061202C46
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089625; cv=none; b=GWN/ELgNEd7krCEP1REBXhwU7I/kfTTu0jAiDxjhYVjEAJPKCiRLIZvbKc/mb6XzF2rBW/injBac3Q63thKFi78nXMkdcBVlAa1yTlZUjgpVw8smjPqy83MCHynOSjM76aUKs9TEO4kq52hBX60lAmpAApX3I3NKLvzvx546zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089625; c=relaxed/simple;
	bh=ZYlkgyx4zI7Kcsijhw4F+FJvIMPd6j6bFB1dgFR6pQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAlMoJvq3dG8DPAfhuGusYcWOsMh2DAY7tnTIHOusPyj1Daph3CFPN4bm4iDPJMKJfdQkogqsSPKfNB8bTg6NxZVFMktkulbpocSbyjEgi0n63QRme7Bj49NiLvJPMpltCjA1p76j+qY5bfvnydkGuTLJTlq2r1haR6o6KI+0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JSyVTiO6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e3b3d432so3749932f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089622; x=1741694422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuV5PBYNprCWaplq1fE9KG6ZTDkt+mehdrAbLFdmJ0U=;
        b=JSyVTiO60eUW7U86lAkEvD6cF2MgMFel8AkDQ8lcAs/elGXLIkwZ1gzPUt8wMQ0V8+
         okc5K+N8MNK1oiuG40zJnbDA/6/ZHVOhduCAhjKs/qwvkZlmBjXMMRdaVwk7Ih0iz80O
         jJjOUyv3TrXMvD7VjqVthT9gp+t65LVBTjl1zlw6Qan03cH4jUF2nNjfmpGXTD42Jr7d
         YQZXgi7QVph6/A5O3B6RQOtti1tMsq9QxqdBz8GWiVqIJbgBhWUu5FMVHJPYCeftH9WC
         dQJ0gsCvcV0jewVm4+HPhMJiO51XjcXFHKD6rVnOD863leUxLnTvKszihVsbcQFvpVVv
         yleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089622; x=1741694422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuV5PBYNprCWaplq1fE9KG6ZTDkt+mehdrAbLFdmJ0U=;
        b=N7lw5J63kl4lTmPixAPBLOKL9ssobHJiu5ZE0wcQv56PJzeiow0VSs9mQNsVRIMzIh
         jrdKdNNoHAJs0u8USCyGZE0aN0RR+MkZtPmI2BZmIF3qDPF3bczNHy/Kr+Qaia9f2YNZ
         LJD2/Amn22Pqvs06m1AAagEsH8VjRNpKBN37T67TBqnNj4YN8JA5wSAtXfyhdTgAuy8t
         i8HLLv3yqcxPN23we2elCf9Y5pKQ3psnjHMlBKDIIneuyAjU+ZnDe6earwkeKpz4nJuJ
         6/2bazaiC8oEGp4NeOPCQg4WfmQsfZBEqAkpvlxxe5UBmHdJ2PT62FrODeBpxKwl4cdw
         IYng==
X-Forwarded-Encrypted: i=1; AJvYcCWvoD5uD86c0z71f68FC4zrs5y+1nNso4yRIQ5uLy9VIJhRqDpdCI+fWxYdc7XT4MBJTr4KubwcNmyyNgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaQmjlrolXPJFNyoDQh3+gjQE7BDaadNkkCku5emaY7dqwkZr
	ZD5ir3UarNyZsTi1KyMly0n8fzAO0J4Ok9b09acWszCwe/xqKil3dOa4iUcxpRA=
X-Gm-Gg: ASbGncttuLeKLjH+eyA0dJWyC2PmwauVnJJ5CmEpZtDRmJH+KjxDB/NKVLY4oZ62qB3
	w7mpGwlnrSc8r6ch0s0jIF5QGdCpWjPFNucUf/NY/71PyuTUQWvc/JEhDgcUGtv57wMCselqMFx
	h7UN8qBK6xprxy6k0qr4oxbEJV4KWMOZD+6+YdD8kvMYyWR/dyeuKbNh+onDSs8fHfd+GDoHuRq
	W5U/CputtByp+eTCNWhydH99MXuxZXPy0pNY4o0V7SmdZcG0PblZT+IAXMsMRiw9iMSf7CiYz0S
	CR4c2rDizOxoAjjGLnpMBUq49tzX+ozU
X-Google-Smtp-Source: AGHT+IGcci4G63CqfkUGtRt/jLkQ1vLNMVzi6Jgp49YWUaQ3MwCP8mUgjvhFVQaeb/Hx3FHq79pKNw==
X-Received: by 2002:a05:6000:42c9:b0:38f:43c8:f765 with SMTP id ffacd0b85a97d-390ec7d2e69mr10172733f8f.26.1741089621937;
        Tue, 04 Mar 2025 04:00:21 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844892sm17593655f8f.64.2025.03.04.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:21 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 5/8] riscv: Fix set up of cpu hotplug callbacks
Date: Tue,  4 Mar 2025 13:00:20 +0100
Message-ID: <20250304120014.143628-15-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CPU hotplug callbacks should be set up even if we detected all
current cpus emulate misaligned accesses, since we want to
ensure our expectations of all cpus emulating is maintained.

Fixes: 6e5ce7f2eae3 ("riscv: Decouple emulated unaligned accesses from access speed")
Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/unaligned_access_speed.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 780f1c5f512a..c9d3237649bb 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -247,13 +247,6 @@ static void __init check_unaligned_access_speed_all_cpus(void)
 	/* Check core 0. */
 	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
 
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, riscv_offline_cpu);
-
 out:
 	for_each_cpu(cpu, cpu_online_mask) {
 		if (bufs[cpu])
@@ -383,13 +376,6 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
 {
 	schedule_on_each_cpu(check_vector_unaligned_access);
 
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu_vec, NULL);
-
 	return 0;
 }
 #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
@@ -415,6 +401,19 @@ static int __init check_unaligned_access_all_cpus(void)
 			    NULL, "vec_check_unaligned_access_speed_all_cpus");
 	}
 
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, riscv_offline_cpu);
+#endif
+#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu_vec, NULL);
+#endif
+
 	return 0;
 }
 
-- 
2.48.1


