Return-Path: <linux-kernel+bounces-319255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6296F9BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122461C21ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EBF1D47A4;
	Fri,  6 Sep 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJtPFDFg"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAC1D5889
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642433; cv=none; b=BnFtuLNYsfHC7tm82+QpY08r8xMHLuDLAgsp/XX2e+LnkTMkfL34SImh3SZt4tskqwfdGYh+udCbxzI8pioHo+HFW7fhnQu0eDICs+s1q8WpgWl5lmrzzsfF9II2s/WPLueCqh4QR4HviLqSh2midDEdjc0RZOPok0uS9tM/T3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642433; c=relaxed/simple;
	bh=uqVFwUB/0TxQaJs2TOgKnw2jAoMSxxHld8KhtvpAURw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csuC20006wHloBk7zyH0T40XdcGL+5gWoBRwT+t91cIEjs1yNAOHObEeADPUmXo3qTcxVjL7bwMWWpNKd/6xGk7OEPzme/FAK93+gRDv9F6p6VidCatbL8Hj9E9yF5UrrEsQ5N+jyjX/jiyoMdAXnzdju33OAkN7j3Fk3KKvS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJtPFDFg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7163489149eso1848023a12.1;
        Fri, 06 Sep 2024 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725642432; x=1726247232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Awb8QHiwgK4hQKj8EI8RJlryPJ8iCefANxC9lVPtM=;
        b=gJtPFDFg+ynhJOFnJivWHuKpDIzwv+88f6713l78yrlUzmPnTe6xv7IYSbLmX3N3hM
         oTCPfWJvh5gXtyLiWEaz7HJUnk6fMJHbmk5CeIYH/LZWlZv853902bFdzC+V/wpVtAPp
         lGGrCc2IJiLM+G9+OdBe/qzmt8dVykirfUWpzPiIGxZDp07s/cgGKTG+MA9aXprbBwbm
         OLjggzETv4Gw+pvx6+s6Qzx8lXUF8cgFD5t6cEOv/yj3z72xCfnr5BwIe1Nxkc4CUz9d
         3A9sbWZXFr16jRQwbfLfBOWx7b0aKIE5j7Srm74s0sn3ddxC5wQPv3TP6d/pKh9N5rb7
         9NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642432; x=1726247232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2Awb8QHiwgK4hQKj8EI8RJlryPJ8iCefANxC9lVPtM=;
        b=ppgLNsGO0Wn72DA9vTVgRZwhQS9GfkBc1tjEwxWT4R1WFbOP3x4i2JrSiBHL+jdI9V
         7qjZ8iVajw9V68ZCAPXZv871YOnMNagr+CoIVHf4UaudS4O5fiA4b3Nl5s/n30r+6Bjh
         QQpojCX2ZYQ2Kvto9z29EAwMr74LBml94/kBCM48OSqIFWeAvfJhk71VBfIKhPuit/VW
         Rw3c3mmWOADWlUPQ666pRMAOkvs2Uy7upDi+Sz/bgpYV4IGvYbwX7ACqQFrTqJtLJ9Yc
         Kyb6dhqXlrS7P7SGRW+JA4ZXiwkudLQ7nca4rDSufX6DOqfipWvDBLY24/LxWmjKLSEg
         CDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmsOlPVRkbcew3O3YCAs9ej9uwVnkOHMeqhgnGI0muMNpidBhjupIIlrFoPHyGHZgpWMyT7B6n2NqVBRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bQTKYtSpr/zmZoMZsnh9Lw8IGg1hiVLTyTUZ9Nca5ZM68Yor
	QjbTBT+4bLUT3wz5zwubIQwpu4sFVjWOVtxX58g1puF3Vrntgsks
X-Google-Smtp-Source: AGHT+IFzWBC72QoGzj8kbBobKI6Ww4r0XzwjrJiOcmr9ev3ZyRUXQKrGkjvpbp2VTVfHowtN+JDMZQ==
X-Received: by 2002:a17:902:da92:b0:205:6c5f:e3ca with SMTP id d9443c01a7336-206f05faf58mr27842755ad.53.1725642431812;
        Fri, 06 Sep 2024 10:07:11 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae965b58sm45317185ad.118.2024.09.06.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:07:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 2/2] arm64: cpufeature: Pretend that Apple A10(X), T2 does not support 32-bit EL0
Date: Sat,  7 Sep 2024 00:59:39 +0800
Message-ID: <20240906170648.323759-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906170648.323759-1-towinchenmi@gmail.com>
References: <20240906170648.323759-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Apple A10(X), T2 consists of logical cores that can switch
between P-mode and E-mode based on the frequency. However, only
P-mode supported 32-bit EL0.

Trying to support 32-bit EL0 on a CPU that can only execute it in certain
states is a bad idea. The A10(X), T2 only supports 16KB page size anyway so
many AArch32 executables won't run anyways. Pretend that it does not
support 32-bit EL0 at all.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/kernel/cpufeature.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..458bcbc4f328 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3529,6 +3529,29 @@ void __init setup_boot_cpu_features(void)
 	setup_boot_cpu_capabilities();
 }
 
+static void __init bad_aarch32_el0_fixup(void)
+{
+#ifdef CONFIG_ARCH_APPLE
+	static const struct midr_range bad_aarch32_el0[] = {
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR),
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10X_HURRICANE_ZEPHYR),
+		{}
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), bad_aarch32_el0)) {
+		struct arm64_ftr_reg *regp;
+
+		regp = get_arm64_ftr_reg(SYS_ID_AA64PFR0_EL1);
+		if (!regp)
+			return;
+		u64 val = (regp->sys_val & ~ID_AA64PFR0_EL1_EL0_MASK)
+		  | ID_AA64PFR0_EL1_EL0_IMP;
+
+		update_cpu_ftr_reg(regp, val);
+	}
+#endif
+}
+
 static void __init setup_system_capabilities(void)
 {
 	/*
@@ -3562,6 +3585,8 @@ static void __init setup_system_capabilities(void)
 
 void __init setup_system_features(void)
 {
+	bad_aarch32_el0_fixup();
+
 	setup_system_capabilities();
 
 	kpti_install_ng_mappings();
-- 
2.46.0


