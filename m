Return-Path: <linux-kernel+bounces-320990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D714A971313
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB871F23D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD61B3B00;
	Mon,  9 Sep 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZMifq4+"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840B1B2EF2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873307; cv=none; b=rfegEfILkhrs7aGjEY4xDmgsAq3kvvaVU+3XTTvobNjgGaDVBW0reD7OdJPTO5XRoXBqVyr0k4Q3Z0dqWKu4sXU/cxhXq2Yr3YbcUh/8+XGsg6RrhOizM7N48mzC5ocgvIEb50Dqawk2qYqWwWTbom2XMJ8zW4Pi1HYm701HGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873307; c=relaxed/simple;
	bh=YU6QP8uJtGFoIVYhmGyZCVl9ofUYe6UsMilEzmxLu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuwFDnfiSdZq52LUCvfW5UFoSYObzr4ErR0Hxg7HikNgaBQGRGOoTh8DxbFf1d/lWZiNOmANv0rIXb/kcgJwj9DVcUTkEj2I7lGbFSvXEyrxknj+m5FpH9C/ojgBdProlWPFho91F0Aj+hD14XDo4PwcG0Xtfvd/eq/KwJuANpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZMifq4+; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d30564949so16001055ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873305; x=1726478105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Eo9sJgLOWOaaCnwXfrOB5SuCDRwkFg5JIzaAB99dcs=;
        b=IZMifq4+V7Kz9rY2ArpoLr0CnfTRpTgUQSykvEQ3QB7rJd9LZV4OFlSGmxGzt3tAPu
         wpCOEmYxJnteSJ9fLIgV8TzC/GPSGwdLY5Cbb2KNZnw6+zQWH+AppU/+aIzhbBwzTq0c
         t9Ha99QahVYwnuSPlwG0NuFgjpNixeLQcMDp3Hsetxn8tJOzouFF8a5ycAm5Es9e7p2/
         8T8tjJo6ADj552JLu2XsAbR9a3xVdmURRq4VfjykJUm4JzmPJCOYy+EJpkX/2DcCvcZ5
         tm7FL3H3V8h2cesuWCvFEyOzmOEYM6N8pDNzDpyqVUsHRf/OSLp7IBYwZzNgxk9a7bU0
         PZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873305; x=1726478105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Eo9sJgLOWOaaCnwXfrOB5SuCDRwkFg5JIzaAB99dcs=;
        b=jsZlhULcFsVk1dgtz+MllleEbqA+5LITivCqJdO7c+m7YND3OBvSVl5DpnWS4Krq/G
         WilOSjetJDld72CQP2UC9hfPYwU5I/kztVGmFbzrMwyyu7lsPGYYNsp9kU+eLcM4MdTj
         CQPkom7Y1MPXjs1Wr79smUzJ3yD6SmcpuvA9+ymzg5b774zjB78wt5tPT1fW2kbr0jjg
         RFl+Ofdy1zty3qWy5XGLkIfejlzoDwMPOIO82C89pudoTX5ZuII/oplFEGSgDbCEU7ZQ
         /zHiDGEhiME05ZPS6yG1HyrBsGJMyWksrXmOW0nsG/HPOoN/kiQUW2f8GvA2Pqz9JSQq
         jzWg==
X-Forwarded-Encrypted: i=1; AJvYcCWdL8p+ovzEtcWMqFu5YAq3N8YGsXLbk+Ij8nUuVCIUZCWYaAFUXcPK+Bi9V7A6GhrIYY4Nk0Boz7MY1vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2opVHITD+YkMhKNHkDQ/2wA7EEkpqLdfdF6lL1F0jCX88Htoe
	0Fkkd54KKPcJ+Hr1XuXMcEALABBnjAIEUZZK5r4LeI6DaMg0x/Vo
X-Google-Smtp-Source: AGHT+IGnEFngkTKpjSEMZRiQSYgmD24daAMiIh9huUiLdtNbk1QpHDCyAjGRDBm54VN4JckyYtJAcA==
X-Received: by 2002:a05:6e02:1388:b0:39f:7a74:e6d2 with SMTP id e9e14a558f8ab-3a05685615bmr64866705ab.3.1725873305516;
        Mon, 09 Sep 2024 02:15:05 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596882esm3120689b3a.135.2024.09.09.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:15:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 2/2] arm64: cpufeature: Pretend that Apple A10 family does not support 32-bit EL0
Date: Mon,  9 Sep 2024 17:10:00 +0800
Message-ID: <20240909091425.16258-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909091425.16258-1-towinchenmi@gmail.com>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Apple A10 family consists of physical performance and efficiency
cores, and only one of them can be active at a given time depending on
the current p-state. However, only the performance cores can execute
32-bit EL0. This results in logical cores that can only execute 32-bit
EL0 in high p-states.

Trying to support 32-bit EL0 on a CPU that can only execute it in certain
states is a bad idea. The A10 family only supports 16KB page size anyway
so many AArch32 executables won't run anyways. Pretend that it does not
support 32-bit EL0 at all.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/kernel/cpufeature.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..386698f42172 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3529,6 +3529,31 @@ void __init setup_boot_cpu_features(void)
 	setup_boot_cpu_capabilities();
 }
 
+static void __init bad_aarch32_el0_fixup(void)
+{
+	static const struct midr_range bad_aarch32_el0[] = {
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR),
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10X_HURRICANE_ZEPHYR),
+		{}
+	};
+
+	/*
+	 * The Apple A10 family can only execute 32-bit EL0 when in high
+	 * p-states. Pretend it does not support 32-bit EL0.
+	 */
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
+}
+
 static void __init setup_system_capabilities(void)
 {
 	/*
@@ -3562,6 +3587,8 @@ static void __init setup_system_capabilities(void)
 
 void __init setup_system_features(void)
 {
+	bad_aarch32_el0_fixup();
+
 	setup_system_capabilities();
 
 	kpti_install_ng_mappings();
-- 
2.46.0


