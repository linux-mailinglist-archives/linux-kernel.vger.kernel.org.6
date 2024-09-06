Return-Path: <linux-kernel+bounces-319261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B571196F9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBEB1C2270C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DF91D5889;
	Fri,  6 Sep 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sge7ZYHo"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DE1D47CE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642930; cv=none; b=Zf8XmmhGe53bjCUncbxWGeS/tcPwOwefvu2mNzUSEID0prDxOxvZfvaBaOmUmA24MsZYq1+wW/lAAX0HqtoWOtQKRKi6wbnLAFo5FeR1AcNDxDTh5qtIqTg73UvTlRLq0aqaWlEUYWI7q86WUT/j9H8FuL8VugHJ+2+YJVxOo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642930; c=relaxed/simple;
	bh=uqVFwUB/0TxQaJs2TOgKnw2jAoMSxxHld8KhtvpAURw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImuPbRxfrqezJTVPaP85G9nHBeLumuXWsXyRyuvB8gwdZkvFgJFVoibAC2dxnkNWq1dXbOftcnikWwGYhHaiVpOrJ5Qwth0n3tRX4Fm+XWFSnAe9pmb7WO8CE3FafslQZl8BTSG+uXrgZyeD0cuCHOApC8IJigmVQ3yuYMhsmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sge7ZYHo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso1723092a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725642928; x=1726247728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Awb8QHiwgK4hQKj8EI8RJlryPJ8iCefANxC9lVPtM=;
        b=Sge7ZYHoQ2jMS5nwm0oGMpYIECVz4qwjyCt9JXTgQwHi0d2Gz+g6F/93ZBxeyqGgpW
         dXJLw1NJ0Fn33l7fzgfUPQa7kF/tITxLOEkiavpZrtLxVhCZl2HKCv2SgqakZyTsTkIY
         AVIVUv6HB2qt+DcV9O1JwTIC921LSFyqPuPSV+xMV0hLyyJlAcV8oYY4gWrEmt1QJD9C
         clDzigZ5JKy4OrX8o0WLSHQAcqKw2cOv67U7PE68gnEDDMvimZiNLR37euTelI/NBkYF
         8VzHpjf+ZFnYEVfHxsHsp0l0pgvewPlexYJcV5g2rIMAomjsSh7RHZak9l1z5aVF3Eo9
         oxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642928; x=1726247728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2Awb8QHiwgK4hQKj8EI8RJlryPJ8iCefANxC9lVPtM=;
        b=BguI7VVNaObs5pOoahlVlOqEQhOAZzo98BcdhFaJ0OZv4YkUxjnmPD1IDBo6qyhJt/
         PcU9/ZL7+3+jZjWVKlRru/uobnSrH/CHmZCt1OUPpvIAGIOKDlgo9zVQnL9luCILfYiD
         XzkF0O6LKbgJ3pWXFNRevLAu7TIQF4vHB5ZRtm1l/p6Ob1qxmINrzD1mAWhHKP5BKdoE
         +i6TYsBAr0qLRgW/VSSOnz7nHUADzd3Mz2oBbo3JSSVVTtVftYwZ7O4URhQurW+/EIwV
         ZU3Tdxgi1V8mLuZYNU8lFNbNvDmXMx3s1IoXGihvTrk9VU5rBL5KgYRzRxpUcLr7N37W
         vMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrnJBaInSRe1cLt3IjVcJH3UnYV5cbeslbVpKvlY1AF30SCebm4j8/aIONSR/4XptxmaEoE8VWjcTZBgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8yLU7epZ0kjkjnixTDzKIKe2AA4r908q/SBUI9cU/yERX0Lx
	pih+UFqQ1BRq+IIRaMsCOAe8xStMqOJPTiAjDYaEAX1acfgs2iyZ
X-Google-Smtp-Source: AGHT+IEitKjL9pf51BQRfyrnIhp+JSQo2gkjFGgr1MpgdrNgRy39LdtoUZno7Bc9XWCc1kIaXZP2HA==
X-Received: by 2002:a17:90b:68a:b0:2da:6812:c1bd with SMTP id 98e67ed59e1d1-2dafcf1ac51mr112698a91.15.1725642928140;
        Fri, 06 Sep 2024 10:15:28 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dadc10fa99sm1841519a91.39.2024.09.06.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:15:27 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev,
	~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND 2/2] arm64: cpufeature: Pretend that Apple A10(X), T2 does not support 32-bit EL0
Date: Sat,  7 Sep 2024 01:13:26 +0800
Message-ID: <20240906171449.324354-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906171449.324354-1-towinchenmi@gmail.com>
References: <20240906171449.324354-1-towinchenmi@gmail.com>
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


