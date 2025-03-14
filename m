Return-Path: <linux-kernel+bounces-561150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A68A60E19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCEB17DAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA851F3FF5;
	Fri, 14 Mar 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXHZ3iY8"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30E1F37BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946484; cv=none; b=DwT6KF2ufpM43A+ArmG4nxeSg0OIShDoH5n8g/6EAcpRr4sWhFTFWoPaSxHR2NzIRonBEcV6MbwbPJ4Ot7/QA+phcx++OokGcViIGqa0JEKKA+FTkqIfPByqWDCLxwNEDGFDVl9upH5Rb8g48mTQXVmJgTizfiTIrv/bopm6duQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946484; c=relaxed/simple;
	bh=jpL7H2rEOd8mfJnn5VtdO8SHZXRMgJyBIOewncmh6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/e1IXGIfIVMDhCaK+yVSZmfJq1cyiPY7PPWd/wHu4kfx36MUO4K9yTZBYiKx0+4DvfWulmIhFza1dYW8kxs//KzVakzeLSrYk7d4K98hq3SyPCfffjNdMV6ahS5Njl6w++uSmwdW0Uhdv85DYtaga7BaWirT5lltfIso6T4s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pXHZ3iY8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307c13298eeso22277571fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946480; x=1742551280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE+q5aCnF90doB2QrACuAQ2CKvBByABqrTNx0sOx31w=;
        b=pXHZ3iY8GcRPvLmwRq4JB+agxDOVFPP3/utpOvNsggUPT/v6kbLQK/RjdBLZgahXI4
         at0BneNBqqgiri0wlYXE35ghozJP2uD6hnERhHIzbEhttpI+M/dLudepknf2cBmfN8Bm
         qvXppwSraIMP3BAaT2iY2dY+D/bmyP1iAGJaga4Ib76qzHgSpJxgyyvM/RRuelcWSQyR
         uy6/E6BvYCiYtUKKORDihai43jI2hblVJIsNKQ3kPjJe65sr+kWOV6JceEy5XaNL37wa
         G7J3NEPFt7Qt96FEVeLKiSvz/GtV2ltLyqABObL6Sl3CPmqbiSA58syXrdr0CjNGp66Q
         usDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946480; x=1742551280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE+q5aCnF90doB2QrACuAQ2CKvBByABqrTNx0sOx31w=;
        b=fRdxQSs3Op3Bt2g8HN7heMOUvp54tNza6TCf/OStDTq5XfSYMx0oXb9zvXmhwgrF0W
         4YsB+EWyhG3Mxm4x3yyonmQ7gWZVRGwpcfhdahknlXpZ/BuPSXll93C/tOMusvw52kzw
         HNwq37fqCapQJQNxJzgFDuXuGB6AFxhwvSgM57vgSoulcSek9dCcqH+vAiyX0C9dsQ5T
         8eligxwc5Wgj6tNvjrrAt/L1NUWMwjZmHBolyEmxi0FA2WA7Ek9CuuwHooUYex64UF3V
         eRR0lpHUsrpFR9JaltMDMr7zRmXmSI4NUBh4fMBX2F6NIW69BEUqyyM4YYL3os5PeEKB
         sGCw==
X-Forwarded-Encrypted: i=1; AJvYcCWro0koinLz5oscfWeAnmrnQxbKLuQNAskr+ycpUy2AMGWbS5MyVXmmRvTX7muHPgtTRFIBgW1swWc4nPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJb1ZprRiXuEUOELSBjjKxpBWhQavU8TIBQu++BX9CziGKstuS
	0iWxUeu8AJD8tz7gFQ7l/OfINHZsgeBta4IiYc1mkeHIXrywBLEgf3oa8OpGY28=
X-Gm-Gg: ASbGncsvtGByMmjwO2SzRfZfGAXnoDyEAwHeoH/yv95fra/nv3s2sU8/moESQB+eCJw
	52OfLOtCdn2DMoeeV8Uy9UpnQR2kNNwIsBWvEnymojrFmjmeSAzwzyENTKTkIniu0ToGKyDdJeL
	cWREwFDur/RGps2LqDlAsQzWJECW7GbFMwyOlKfe/aBYQelSSFB/hBSg+ADMI3U5LWDhCVcxfCr
	WTYIYh154BXXbullb22dKL6LtCwTsrHgXHdG0s1i9CLgVL2RlrV8wboVWn0gTElulIVlo7wbv59
	4GNYpPp6uQkOQxRlzSskhHfi9OzPeVzPb/90GwG7qUZAughXbo1RnrMc5ABmP0CLvpQx2s5yPCE
	C+guY9pxrELvOgVP8j5r4lw09jg6MZA==
X-Google-Smtp-Source: AGHT+IGhYmFMbUeatQB/z6JS0kcTyMcIT1IzBAPuh4fApk2bCc0yDwcZPgTrJD62ufz1WRxkinRL3Q==
X-Received: by 2002:a05:651c:1501:b0:30b:c36c:ba96 with SMTP id 38308e7fff4ca-30c4aa7711fmr7127431fa.1.1741946480268;
        Fri, 14 Mar 2025 03:01:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:19 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpuidle: psci: Move the per CPU variable domain_state to a struct
Date: Fri, 14 Mar 2025 11:00:56 +0100
Message-ID: <20250314100103.1294715-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314100103.1294715-1-ulf.hansson@linaro.org>
References: <20250314100103.1294715-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare to extend the per CPU variable domain_state to include more
data, let's move it into a struct. A subsequent change will add the new
data. This change have no intended functional impact.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index dd8d776d6e39..1aff1ec555d5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -36,19 +36,28 @@ struct psci_cpuidle_data {
 	struct device *dev;
 };
 
+struct psci_cpuidle_domain_state {
+	u32 state;
+};
+
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
-static DEFINE_PER_CPU(u32, domain_state);
+static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
 {
-	__this_cpu_write(domain_state, state);
+	__this_cpu_write(psci_domain_state.state, state);
 }
 
 static inline u32 psci_get_domain_state(void)
 {
-	return __this_cpu_read(domain_state);
+	return __this_cpu_read(psci_domain_state.state);
+}
+
+static inline void psci_clear_domain_state(void)
+{
+	__this_cpu_write(psci_domain_state.state, 0);
 }
 
 static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
@@ -87,7 +96,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	cpu_pm_exit();
 
 	/* Clear the domain state to start fresh when back from idle. */
-	psci_set_domain_state(0);
+	psci_clear_domain_state();
 	return ret;
 }
 
@@ -121,7 +130,7 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	if (pd_dev) {
 		pm_runtime_put_sync(pd_dev);
 		/* Clear domain state to start fresh at next online. */
-		psci_set_domain_state(0);
+		psci_clear_domain_state();
 	}
 
 	return 0;
@@ -147,7 +156,7 @@ static void psci_idle_syscore_switch(bool suspend)
 
 			/* Clear domain state to re-start fresh. */
 			if (!cleared) {
-				psci_set_domain_state(0);
+				psci_clear_domain_state();
 				cleared = true;
 			}
 		}
-- 
2.43.0


