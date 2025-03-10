Return-Path: <linux-kernel+bounces-554530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4FA59961
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CC97A6D83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56F22DFED;
	Mon, 10 Mar 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vtPsvtJv"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E7374EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619594; cv=none; b=NqxCuhy/W5ITx5rsxa8Fqdq97BuzHvzeeSaWr5gltFed1vgHRJOFpDAFdESV2fpeyx+QtImrf793h77FrRN8gkPP/KOW7KuKwyJgZYczpz1VVsU4mi58ZghOlzEmAA3J2bXBb6S31+ZCyV8YXrEtykEtoc3CKcmSgpep1sroGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619594; c=relaxed/simple;
	bh=aVEe61tOXVLff3qc/cOHgfOndrydOzgcDh/F/Umx7y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fspBn8R9z1lfSc/Ty7N8MrMJcpxHTFkpfBYU7XSHmMlOQWSIVlmUu5KXHsqRkxCIadaJimei/0gOmlqDWnaPcx1CHAGei9JJNxyF9KM2f95+iK/mScVQS+eabdRA7mRsxC+PBa7PVlVvGUfo57qI3/dgiYa6MzBGxxDjhToDeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vtPsvtJv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22409077c06so11153955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619592; x=1742224392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8ehbEB4G2M6rMKgF63InF+3qW6jpnoI0lm2nt0Msdk=;
        b=vtPsvtJvFkUSdsSzgYc5yD3mkT13eqYS7KFK2pij5UMVP8SRQoVkn3qp5/v5rCePvp
         AMEy7BJLesq1YxJTyep4r70TF15mYcF57FxtSlO+b1LmKe89NW4DIR0ZrwXlbQA2/T89
         qrNaI/imM9qSYBu+WdW7O06/1HMPTaKp0gxRhRfvZRfFZolBdpbq1ALLkrUvC4HHQHHJ
         lQo8hEz5kYBGS5LESlzJtp5EUxJKiawJph0sYg7QLBiCLkmwkHUAytO8OIFYhNHawWSx
         O7dgNBL8UMQfaFTU6cGISU5l5+RIH/rsvfviTellS0ry6Yf8Hr1UpgI50WF370OsYLE1
         D3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619592; x=1742224392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8ehbEB4G2M6rMKgF63InF+3qW6jpnoI0lm2nt0Msdk=;
        b=Xkz4dfpsZlwMXC3ORBUl2qpJs2Ys7qPhZGgSGLWNw2MABTt/xBbDPcRrHqE0a/j2sR
         Zl1HHscmO5eRglOHrWHBJAd9V5K/NJOQF0jxMWo0K72BkbF6FH/fvsSKL/9uCBIfSgda
         Nwb3uXqBg/U9DvdxLxfwqOB5Mhs4cNtLduaI073xXNNXfnqM86DUMKJ9x06yImXTKItP
         BWlsb4jkL6e7ccG2vF4Y0LyWaCDVCP+KQitlk7Jcb9nTaQuheV7O8lMH9RsKlIQj1H8O
         VEckzT4KYIACTtL4dmgNqzeXoztBOW945nHLCsFGEXe2Rt6WOjPqtzXfnntVIGYcZj2N
         pD8g==
X-Forwarded-Encrypted: i=1; AJvYcCWLL2ePxWVuk4d8g0fL5BtVRudEVBqTk7I5blBCPX3jfpyq2Dlht3a9SMiZoQhPRFEsk6kCLhofXf3vbHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkM5fopX0K7/Y2oxHG+eIIyfAqw0N2c7ExIDCAy/xWxzqF/qwM
	xEHr3at30CAncqFd2k/D5K/WJKd4bmpby5QaBdibE1cSePLMvL4la+0MRUYaUOU=
X-Gm-Gg: ASbGncu8y6VI8r8c50eUmDPHt90J+UmFUXpwjHd0rAj1L8p24UrNa5U9St4WW4AAC7Y
	ViH7CgPeOqFBAX0VXdxqeYsgN8g++cWbbSVA9MgkOhY+q59LYHssigxEvUy+D8W9CSZcOgeA4A2
	RDqU7HfKNp44chNMJ+RQ7N8hOXYUC/EuCD34cx0r32DQtQVORbsz1wyriIxNPs720ZiiXhV3EdL
	GCxP8gsQSwHScHHZehStO9LSvpkofhPdUq8zq4QOLt6lDoGD2ZUHBreNid4RufHnJtXkQ5qRHIP
	1/V2Y+RKrl6L5zamCRr0FIc/aI+42wzB52vJlTkfhb/7gA==
X-Google-Smtp-Source: AGHT+IHx06QKyqqktCp5VtJUo5IN0vcBDSsl9L3/ywFUKF9aCYPEgmbUbCQl4AVArEAbrJmDgZ6oCQ==
X-Received: by 2002:a17:903:2405:b0:224:24d5:f20a with SMTP id d9443c01a7336-22428bfdba7mr268684275ad.48.1741619592004;
        Mon, 10 Mar 2025 08:13:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:11 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 03/17] riscv: sbi: add SBI FWFT extension calls
Date: Mon, 10 Mar 2025 16:12:10 +0100
Message-ID: <20250310151229.2365992-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
provided as a separate commit that can be left out if needed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 256910db1307..af8e2199e32d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,9 +299,19 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+static bool sbi_fwft_supported;
+
 int sbi_fwft_get(u32 feature, unsigned long *value)
 {
-	return -EOPNOTSUPP;
+	struct sbiret ret;
+
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_GET,
+			feature, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
 }
 
 /**
@@ -314,7 +324,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
  */
 int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
 {
-	return -EOPNOTSUPP;
+	struct sbiret ret;
+
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
+			feature, value, flags, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
 }
 
 struct fwft_set_req {
@@ -389,6 +407,9 @@ static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
 int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
 			  bool revert_on_fail)
 {
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
 	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
 		return sbi_fwft_set(feature, value, flags);
 
@@ -719,6 +740,11 @@ void __init sbi_init(void)
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
+		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
+		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
+			pr_info("SBI FWFT extension detected\n");
+			sbi_fwft_supported = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.47.2


