Return-Path: <linux-kernel+bounces-556353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D18A5C45F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8F3B29F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131EC25DD00;
	Tue, 11 Mar 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eMAY1ZF0"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258F25DAE5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705310; cv=none; b=kjlmbOc5YKhkiqUe5526eE2e8mvt6MwLRsnc2S09yOSORkdThKJuHQeBArM81dxBQVuDSXkEv+9kBp4WWRVooiEIP47XsOG1XQ1GPFEQ9IrgRBbX6jGDCN9X6S0db1FE4uqV23XyBFPk7BbDtNflNymt7WBgodwvvuhZNYyJ8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705310; c=relaxed/simple;
	bh=Es7Jq+xaUItmnmFx3FliQRRwKbWCSA0oO4kxOs+0tR0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HikR/TUwLTW0qvB07DRJ7gQ1VP3A5BkJwf/5GQAVIbkb1m9LQdKrRZwzUaiJ3QdmzwLUaA0VfUIA0MddYMUCXqnbnyUAkAlFoDpBNJQ2SbbNLoVruffZJ7hfIwCdR33ZDg8wuhsNvMGTlq2JlDW/YfdTAoZOVrYnmRed9E7EMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eMAY1ZF0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fb3f4bf97aso33110b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741705307; x=1742310107; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=eMAY1ZF0lLHPg0dOW/tX9X/on+2/+H3t0pn1rFeX7hOnh11h3we9Zc0jPHORxvcT+i
         VnV/tLSWF2po4TZLDDzSkROkC0gSmE2KuVC4yBvwTT8sVcpe4MUwNuMfkfJPj5/lb3Q8
         JHnd9FFHK1bGv1rpHyrghcmK068GzRqIBUVlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705307; x=1742310107;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=iVqp3zHyAXY89Tr9tgId+r2bHEHXad2tfi3ae27ptS+TOa1XkfAH8BS063FF1RHZ87
         penSexLnWDeSd0KKoUdiY0Z6/aRZHce66T9KtaP1cwWOsMton2skgezMaMkBobI6DrwM
         Gi9lqYYn/hPwndkAOV+92oQ4DSgsQVK/ZJ4X5wxxGykF2gYfOotAYGiWR17lgUoOQ9/S
         q9w9HUnqo2aII4r7Nmk4DZBue0v5doG3UiEzfmfwJ9UC2XVEGAytgoY+LYMLEXAwRl5u
         irmhpiQXRsBTYyZqvR3oWeQhWpkFA+InJf/+ZvBFSdVE2vGCftPoox0AbTXamUJJMxq9
         gf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGjQt41ioh5c0trmCnRXOj8XeRAaTzIzh5oDiCvXIOD8JIeGZFcWiBhb/hDlt5OCi92t9Q7maPtdJ/a+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj44toCrVbsq9VKfREDLnZ/jCtCscuqs+6rWVEH4/wpnoY2l6Y
	HPQgA2AFC5Bgt0QyYbxw04v6QV/k+U0v+rmO/6AIB88SAIz/rLE6dSvHEI7KgQ==
X-Gm-Gg: ASbGncs1+QhfpNh1Ic+DRrtbUa4s06W6VGJPYSkvmuK6mdFqYvo1j68uYnvMF/YdFwF
	BveoZnaG9Tyu/hSXA1ovTNm5KXZ0uO7BfGSgZ9+fgoAsBskMNB2ULQ2ctnCb69EPCRnFWRHYtlx
	XCJLX7J9S/NO4DdrKg6A+0317MUbb0m0lmm1PRlU7VZ/Yd9CWbprvpyX5a+7ma1EZiCWaDCuygw
	QJkARhMWBmTahtcz/K5iBoZ48ZBD0HYgY8xWByArX/jt4JPw5hPokdv/ROb2G0w/P7cIvyN6w5N
	iNbPRESosipI6cdpq9Rc5Ry0O+HPL//pe4dwH8maRoJItC8JDlJbFjgQE+hpKEkxIMb+aMFMAkU
	UotMk
X-Google-Smtp-Source: AGHT+IFdbjAPLkBcT/PdO6aUZ/LPk9p9TaaPPNTQhmFPj4MU5+L0g0wPVorRUgYDuoVha/IN/Ce0Hw==
X-Received: by 2002:a05:6808:151f:b0:3f6:d59c:6a40 with SMTP id 5614622812f47-3fa2b30bb82mr2312809b6e.28.1741705305315;
        Tue, 11 Mar 2025 08:01:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm646247b6e.0.2025.03.11.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:01:44 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 11:01:28 -0400
Message-Id: <20250311150136.46938-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

cqhci timeouts observed on brcmstb platforms during suspend:
  ...
  [  164.832853] mmc0: cqhci: timeout for tag 18
  ...

Adding cqhci_suspend()/resume() calls to disable cqe
in sdhci_brcmstb_suspend()/resume() respectively to fix
CQE timeouts seen on PM suspend.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..bf55a9185eb6 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif
-- 
2.17.1


