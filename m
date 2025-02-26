Return-Path: <linux-kernel+bounces-535039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DBA46E14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7609A168A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073926FA7A;
	Wed, 26 Feb 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMyC7EE1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F26E62D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607468; cv=none; b=amI55bc6XITnKncYNbQAKUHMwTTq+opiWUS7XpgC6oeCLTeB3jfm4erm6GO/gQondLvjgLWDhkp5HdC3KwcvPTyCdHeq8ED7ti05GfUnCEuGbXAhh0q8SPqz/ep7EaIXVgqx4NR1hDEoicHoF52qNzsnEzCV3m3rscHQGRy8gdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607468; c=relaxed/simple;
	bh=XD5vHpBRFTxxteEvRZ/Amzm2FaKpvRfB8H6AYjhg1D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8yM1TRpVC3wsLtJluFbammFncC5Na/liCU7mEaBBq4dZPIfQEH0ak6xgeW3aQxuxdZzdl87TIPQHej9NOUmIRnZUfNZDEcrdHnmsHEUC9xQOlt3r+KjFiGhClMAm6BOaNZwEGbbfJoSyxHIAbWm4xEm5QhyMnd8fNEVtMS4f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMyC7EE1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22339936bbfso3756815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740607466; x=1741212266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqQVvrSG700cJ8ivAGfcs4D2QICVIKls7c2wPxYXgmg=;
        b=gMyC7EE1m+EpUlfi8P2iye5nBycYRLvHj9VIhmiUXuRPclAMNWlHaPT+lUwsGDX7sv
         5NjqLMD0lzex16YwaVbx4vmRYlE/jixnnH27RW8cSyeAIDvu7tqGX0q/sTSs2ZalMlWe
         Kd8d0/tZWEEvPj3pMqig19FWyeE7jYEAZm4bB1D24hnchC68Sy4o6/bHgK6EtDJZ11MB
         6aRnggH3QMbOgw7nAisf4dzbEhnds8BWcvWtDK36aGAFj4HV7VH1pap8rP0PCYWXiMTr
         /8DKCwNokHzsYXi6SGVqUL+ZwNwBpwJHzkXR51bVimteJeMCLsqvnL3YC/snskdQLI2H
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607466; x=1741212266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqQVvrSG700cJ8ivAGfcs4D2QICVIKls7c2wPxYXgmg=;
        b=c/g4HkD1rgWvcnWl6HFmuBPUkTykcgt/o+Z4oiuraAzJVCRTtC83uilEGK2cfaiz21
         yI0IteQy/8aIPThmY4fPbf6ZW4+lRRkUe/eabHHummI02Trd5SjyuIs62nCfQDNMjsSo
         5EK+LqDEhVK9cS90IpSk3MsW76CryhV/PPKelHClLrUl1OlL2cf1I7MUkKGVvAy0X9U6
         uNF8pmc3bd76P1UwCMv1h8y36XF2HOe5KVfSlFAj61AOsJxsP2vQXh7D+XQ34H0ITRFW
         O1paFI5VGkixn/J/S2Gepu5r3gwUDA0zfYQqkNKXT5BN87xGZUk/q355xNts61n3bVCE
         YURQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyHBv8bvPGwFZAv/mOSNfqXmuep/rdv2nbr8ZBIqJnwqkADeH7Ci9aEW94IFPKqkxVxdVHc31qL0Ly3Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvtBnrlGPglkuzpVFNOdowbB54+lPw3Zvq2uxSpqpB8JaW/dv
	KXgrjcqnT4H2WuKs5QBBXkxfXy1IuWzykAPZO/xa9Vx5rDWWNLItjzMdBViOQ5U=
X-Gm-Gg: ASbGnctQwTxsr/9eg91jdVdynWiU/INWhbvbs9rkuO0UzKcJckZL4yUih+CdeqDHDW8
	t9knr+B6GDXV4CJcu9MZON1KBfOaPaVXS44BJndP3Lw3dVQd5g+5gx1mAVn5WV0+TmF76YT5Fzu
	siuEF5Fk/D+VFFtKnyO90aaF04j4zU43cdKW4o8RFkubkTTMadsY3l68NiOCtj1DPApzkz7UoWA
	ljylySUazJxkA3rcc9+4m3kpm7NuFJeLFYH4f+yA0pgr9C1+RAEK0yQYzBUAOgddpRjNwJ4N/iB
	2mBeXolE9XXQMVxlndg2xQn03/b8pqx0ysEwEDHjA7vN2bIOs1gHrqD8
X-Google-Smtp-Source: AGHT+IH0ey8eRCvxcHgsNYYNwiwm9i82ds1xLg6pyL6Gx4FmTSqN0nYi+iPEnmvAXppRtAVsCj9cLA==
X-Received: by 2002:a17:902:f68c:b0:223:501c:7576 with SMTP id d9443c01a7336-223501c75e9mr6151485ad.12.1740607466019;
        Wed, 26 Feb 2025 14:04:26 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([104.134.203.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350534004sm1044145ad.252.2025.02.26.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:04:25 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	krzk@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	ebiggers@kernel.org,
	bvanassche@acm.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/6] scsi: ufs: exynos: ensure consistent phy reference counts
Date: Wed, 26 Feb 2025 22:04:11 +0000
Message-ID: <20250226220414.343659-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250226220414.343659-1-peter.griffin@linaro.org>
References: <20250226220414.343659-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ufshcd_link_startup() can call ufshcd_vops_link_startup_notify()
multiple times when retrying. This causes the phy reference count
to keep increasing and the phy to not properly re-initialize.

If the phy has already been previously powered on, first issue a
phy_power_off() and phy_exit(), before re-initializing and powering
on again.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index a00256ede659..943cea569f66 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -962,6 +962,12 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	}
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
+
+	if (generic_phy->power_count) {
+		phy_power_off(generic_phy);
+		phy_exit(generic_phy);
+	}
+
 	ret = phy_init(generic_phy);
 	if (ret) {
 		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
-- 
2.48.1.658.g4767266eb4-goog


