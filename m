Return-Path: <linux-kernel+bounces-556537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDDDA5CB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E207F17C025
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DC260A52;
	Tue, 11 Mar 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A2rmn93w"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F09260A54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712398; cv=none; b=mD6u/v8yWJdD3ASSL62qcq93vlouJ+ZRTlAix27lsw6K7eEa4sig4sngTRqEX4JAtSTPRdRRDqYW2JgfZ/5nK2H/Oozeo2G2MaE3+PPrm27fdh1UuMkU95U/h/06nzlMbTx+i96YsFqC6seInOjZxYTzOCNno6JOAkgVzcth29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712398; c=relaxed/simple;
	bh=152+JhKdJURsyIW035cU5ZqaX/06tU57xV2M5Cjl64Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pi6H/MP87ju+8m/pnK5X0z7AwJf4t5vcndesBSfVpOqbafZ1JRAJVYMrFxGHoik+/zBhMvomVsXLDcPFct+zt75woOrsALfMJturO4CN+TN/tLyNzrTZSjJlHKWpFvZ+BKNuYGxeXnr7P/wL8Z7q08NYIVB8x6gmzIJDWuhCKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A2rmn93w; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-726819aa3fcso3124107a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741712395; x=1742317195; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=A2rmn93wxtQJ43UgkZxaODw/TyPkwsKhDBJVK+WN76dU++7buB/cLc3ALDtF6TdrEp
         6vNI+WHkYNziFOoEqyrRnulc6wWspx9XRAL2UBdKk1i4s2DoTDLD+HvSKMIrz8q1GpJU
         nuSE5+hxNDdzEiTnRTreYPmEq8UxWPeS7/8+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712395; x=1742317195;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=f5/tkHUXZgDMIkuKCXmyYyG2k6VvHyVFByMnXr5XnaVuI5naZp8jCkqruy6o0bp90P
         69iPBy5Hc6alHulab8z7IE2u8CjT9jKLCUqNp9jJptpsM5i5WA0ypEkVDXdpTLC8XweV
         DzSHQxo0gH8IjMQ3tw4rnPOiiqHUONfPteyyel0UtX2CA331jPneXh/5+8LdoxzgT+xo
         rxtvfmpeb9uulUFZXsPVGZYFu1hEijQo5VHG+sXL2b1+nFavjYbTEbW0Qt4iLfeAqCA+
         zehwwaLPnwVt0eUaqMyDicnJNv7i4Ept8RM9gtmFpEVjyu1v2dxMQmRG4tUtLvOafa8Z
         zH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSVZThL/owV3C8qzZLqMlcyCqbQb4EfDKdD64T2XdeAiaP9WVD8PLUEP54XKe1dCqdoi54T4sKT1Qf3yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdACWZE25ptgU8I9tjMflmapIuFP6cPMR/0AB2dzz8t5EEWDB
	fvkbSmg6xMKxjeouCr7l3YBbGAGRZ8S3liEi0hC9M/wO1BCuH3A6kjUqwaNEOg==
X-Gm-Gg: ASbGncuPmDezJiweGhDLobLYToG5C+rXf65vwNy3btdGY1S2F7gfZLBxjaPy9wafj8y
	Jbo8t8TTeAik6fkdVzuE5lrfD3d4MlUzLQDcv1shYgQ79OhsR7jvus1KfWMhLq/46QHVnRTLH+F
	ZPfjRgPzU9zbqe+Zh0NjKJPsQV4wNCurOwakGvU+7cUWqBrbLDkrk1hyoegjql76mCs90iLR4Mf
	er7N6vEFKKHXS3qt2lqSrSbeMiHJaWbS6Nxr//zf0kUUOymCtLFa11S2m0lyAou+CcUGXF+HIac
	gCVJyq3Yv3H4c2//DVQ7hB6OFr3sOpkU4MoGkCQ3piQCmLxH/rgd+1t3dLOINTLWMGJhLUGZ1Xw
	3sGYs5qgwHg0ocCQ=
X-Google-Smtp-Source: AGHT+IEo2y1B2P4YlspZf6ieZjf8/Wmas/53NMabqNUKfjrw4XnZraf15n9gzLSdbh8zE4W/K5VXSw==
X-Received: by 2002:a05:6808:1b13:b0:3f7:28ac:8068 with SMTP id 5614622812f47-3f728ac86fcmr6097289b6e.13.1741712395590;
        Tue, 11 Mar 2025 09:59:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm682492b6e.0.2025.03.11.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:59:54 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 12:59:35 -0400
Message-Id: <20250311165946.28190-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..48cdcba0f39c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
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


