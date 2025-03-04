Return-Path: <linux-kernel+bounces-544093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F5A4DD50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50027177503
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1B1202F76;
	Tue,  4 Mar 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="malMFTyy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6520127D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089624; cv=none; b=eJu7mQb/zgXFByfbuoA0lo3H2cqnyoUCJkW6bhAn61yVtUtMhT3EtdeyFl8mZKeBaIeF8rQcZYF8OhtbkgcJTnP2O+XcPZIQta8p/ajdALD7MnAcPKBk6IZkVa4Fj61dWJQTPMehDHmct5imQmR0HVnLwdySeZCOc71A7FsXPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089624; c=relaxed/simple;
	bh=o9zHYBZOjWU+lYENxdkNUmWAHWMdM0ccAzzowc3/Wqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smq8sfRbCPFXzUWurdQGt3ip3HO9/bCnZ575YO4qFUxU0ytk6ESd+AbEDUpnn8P9cpc9hQpRRahyaL+kZi5UVJABJOgK+CmTKQsHs8ECqCKkXE2cvggCv1zQc7pchbSYh59vAHoQWXPOc0X9G250Msrhb17EDPzzqDIraYixyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=malMFTyy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390eebcc331so2304248f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089620; x=1741694420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL25umXnpXBBzwUoMnOj2fRLliDIrDaDucRmmKK49J0=;
        b=malMFTyyntcxxuOqIPiwXc4Vb6eE5/bdi71u7dZ1a/N1arijWciJP3fRpZGC3gkzPO
         U7X7UjjIUNR9eSt3ZQvRhV2reH1cAnfjntcFR9gG+mEEzsjMeFS+XMaYVEpcz7DLno6b
         iJvpJDprrGQz7hCRuOpX4ACOEuW90GrYGD+RfdRC0Ep/wYRlYjVLpRBKm9cggsQbxJ5/
         F9FQIKDMLyTbGh3WD/8eAC85sK0lJG8CGVs+PF3cIhS9ePR7u78N+eaQ6REmRrcvQG+4
         JWpLZa0VAtlOF6wMuBCoAq9aN5EANkFb1AD3QpZP+2hE56mRvWkK4RIELnP+Rf4XOvNA
         tBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089620; x=1741694420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL25umXnpXBBzwUoMnOj2fRLliDIrDaDucRmmKK49J0=;
        b=c9LAYj71q+6yxMWudaBifewb7B433XpnZoolhYHdoWhAgm2K4xMKUnMsRNAtkwu9JI
         13ZDEzjxb77b37SBpN1a/VsxioLjaxr2X9z93vFXIf0Ia1ZSXWfxNKqfJvPC6KsWdmQP
         /+Fl2v8TK8gIIwFLYF2eX/fSGQNLGpfebi1A6i1tAFtg1NOBr9IbjRp6p9XC8hA9BGgA
         dDkHXuq1WYZvYnwTUvC0TTSS198MAhpd9vtU0//cQHXDcEofODqznzBG1O1ZLOaljWs/
         XHBTxU7WT8RxvDUySi/OHNxjp1hJ8jUndyCgp2/LPstmf2q7Zow/DZcAtnPvkCBDd6M7
         n4bg==
X-Forwarded-Encrypted: i=1; AJvYcCWhmH6Bz9IiyPDcXYso0yt79IbYRuZ1i5bA2bet7jLgf5T5gHPp8LOtk3DIreVVyUx9+nKZMqAz8lYH8zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKQOd1kst7Zo5wrJk0WjHmWQVhCSs9ZRl7+5WfG3DkvKSfZuu
	SCEafbPP80hxO4UnXUCDtvwyN76xP1ODPNrZxpXkiRdA8NGndV1nc1RWykhXbZk=
X-Gm-Gg: ASbGncvAaTTZdmh+Y1KDqgs3LhUN4+lZaxt2E8ftE2DBekVTHbb1PYUQ2FFAK4BBd+S
	p1CRdvKoRFBCPU+zmfJf7TFH3UFoc6kssLTTxdHd6jFrYQtfHwcZiVCqPCi4xavaK6mmxo0xiO2
	uWZpj47N7C3jt2Dc3gKRrUQn3CwDiLh/ToHhdgvDdukrBP9LTxnk2d+zu2OqcPSl4iTbdPBHdLq
	OmaD9kRi+P2z5WXGjGBiXGodxLxQC1kXWPoJsYuXVda+P3OxKl1DEsLc8nyHssg0iP1w2BrQysO
	7zRHMiaVfODHMxNB7SWO+sZ49SyPc9Cm
X-Google-Smtp-Source: AGHT+IHGl4juoP1IGvAETEutihGGilncidBGnRXIsTr2+3oea3NO/pXu/tqvOIeNlFeGq7iMlTLrtA==
X-Received: by 2002:a5d:64e8:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-391154af01cmr2483532f8f.0.1741089619498;
        Tue, 04 Mar 2025 04:00:19 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbdf7a9esm21728565e9.13.2025.03.04.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:19 -0800 (PST)
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
Subject: [PATCH v3 3/8] riscv: Fix check_unaligned_access_all_cpus
Date: Tue,  4 Mar 2025 13:00:18 +0100
Message-ID: <20250304120014.143628-13-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_vector_unaligned_access_emulated_all_cpus(), like its name
suggests, will return true when all cpus emulate unaligned vector
accesses. If the function returned false it may have been because
vector isn't supported at all (!has_vector()) or because at least
one cpu doesn't emulate unaligned vector accesses. Since false may
be returned for two cases, checking for it isn't sufficient when
attempting to determine if we should proceed with the vector speed
check. Move the !has_vector() functionality to
check_unaligned_access_all_cpus() in order for
check_vector_unaligned_access_emulated_all_cpus() to return false
for a single case.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c       |  6 ------
 arch/riscv/kernel/unaligned_access_speed.c | 11 +++++++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index aacbd9d7196e..4354c87c0376 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -609,12 +609,6 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
-	if (!has_vector()) {
-		for_each_online_cpu(cpu)
-			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
-		return false;
-	}
-
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 161964cf2abc..02b485dc4bc4 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -403,13 +403,16 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
 
 static int __init check_unaligned_access_all_cpus(void)
 {
-	bool all_cpus_emulated, all_cpus_vec_unsupported;
+	bool all_cpus_emulated;
+	int cpu;
 
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
-	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
 
-	if (!all_cpus_vec_unsupported &&
-	    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
+	if (!has_vector()) {
+		for_each_online_cpu(cpu)
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
+	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
+		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
 		kthread_run(vec_check_unaligned_access_speed_all_cpus,
 			    NULL, "vec_check_unaligned_access_speed_all_cpus");
 	}
-- 
2.48.1


