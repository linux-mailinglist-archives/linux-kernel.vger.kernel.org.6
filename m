Return-Path: <linux-kernel+bounces-256612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3974B935110
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934ACB2112E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F621144D38;
	Thu, 18 Jul 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7k+sYjb"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24073144306
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322432; cv=none; b=lwjRayDEwNnqKS5brbPQN9JSPQyDrqQ/dfBa7vXhueYRexlTCw4FM10NLax/pkwow698PuINDATyN1S29e6x9oEGoslM6/p4btUs99QfBvr5JQLEJADY2G6RB133+7wTHuYYRVt09yYxFqWcRHpxFds5RbqdbQJsdp67P14/Szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322432; c=relaxed/simple;
	bh=cjeX1aFyWdBgsxfxbKfPnG9h/qsmn1yS9giF+UQOvt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KPXJvVyNU7DLezixJnHloKMzH+aBdtTr0m1mvxJwkemRMRRzwl7OySSqUPpVU8PCuDxGDrFe56yO3RZhgafS3iKEEpiDSlzU3WE9Xp74R0pjLw6gf4I68IzQCT4DSzTmu4cR6WH0fl2SuZEO9SLUL92kdUnRwubDVLzRGFh1zw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7k+sYjb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so426049a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721322430; x=1721927230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbWG4pqQqIat0xDS0ZVANXGmuhcJIaLuF1t7QxTUgZc=;
        b=m7k+sYjb1rMVAGo464+87Ykc1YRWqFoXtSxbQC1kX59ymqXr0mfiCrAJbMmEVs9jgn
         20SxRBL7mn/iv5AtXEIidk6upCLzOAwt4RJx3aEFT0rFVwtzsgqCz/47fkkQr0M0jFSv
         dnwKaS0XiyXEl9hTK8uDhIdnXtTFfpzhH162HCGykZl0fqoyX5qPlWKFuxXwqnDha0TR
         ECBMwWuzWVoFsq0F9shtBzuyD8F5UBdt96b6BsEmuNpMJDgNSiN+X3TA0Zey2+oeJUn6
         93b521i75fn1S7sHT9eU2C6MQ00Xd29h8vi/7YFz64ffY6lLdGmz094iYZP0SfOLl2Tq
         sSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322430; x=1721927230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbWG4pqQqIat0xDS0ZVANXGmuhcJIaLuF1t7QxTUgZc=;
        b=qmU/z+6ECnM1wBaWTVWf5t1/7C7KNHBspgXWBOhO4C52ZdG42PEzBnUY7wWRrFlM02
         LPRuKE/l6sz7PKJFvC/uxUWVo69FvJSG2V64FLNhGoYW7+oxZF0j/t+tcoBuJc0wQOUv
         tMDWBjOs74QsQnsMeStyIaSNKHOHDLzxxmRqKr8uPAYHLfYOyaO/FrO/RhgVypmJ/MeO
         8wOivZLd5kIhI0+KWd7Bi1krL/5c6dNeoXb54ed3ZKihkFpl9NFoyj2o5lV2C6J3xYNp
         72ilRtn6EwtceHhVXk6x3a7Uim6HTaQtn67CBJXoO34evxlEtnGiokc0jmuZoqSPaT8M
         8IbA==
X-Forwarded-Encrypted: i=1; AJvYcCXNYIAAPK2W2wTanKZZQsqA31dx9Ix5cZkAGEvM1C1w6WR9oTBMw3v37zgXSHIawFVtoN9zQ4Q6htNoCcZnyDwuFKklLyEf47G1hxMA
X-Gm-Message-State: AOJu0YwqTvyiOJKnKcNR2XaF3W5i7vJUqGPQ0BdYgg7C1nqdMafmibja
	0pLl6hU9QXN7lvBChsKdiCq7CYl9wfim/jhdZ7lK0W9fISy4wSF/pFa+xchYRw==
X-Google-Smtp-Source: AGHT+IHzfGYavO6Fs7TNZbgx1Lr2vRkcXC3MMHfexuW7iiUp4F5HrO19UwuxKuf2xwzNcnSQfjNJvg==
X-Received: by 2002:a17:90a:b885:b0:2c9:93a3:1db6 with SMTP id 98e67ed59e1d1-2cb5269443amr4146865a91.11.1721322430332;
        Thu, 18 Jul 2024 10:07:10 -0700 (PDT)
Received: from localhost.localdomain ([120.56.207.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77342dcdsm969962a91.25.2024.07.18.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:07:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anjana Hari <quic_ahari@quicinc.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: ufs: core: Do not set link to OFF state while waking up from hibernation
Date: Thu, 18 Jul 2024 22:36:59 +0530
Message-Id: <20240718170659.201647-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFS link is just put into hibern8 state during the 'freeze' process of the
hibernation. Afterwards, the system may get powered down. But that doesn't
matter during wakeup. Because during wakeup from hibernation, UFS link is
again put into hibern8 state by the restore kernel and then the control is
handed over to the to image kernel.

So in both the places, UFS link is never turned OFF. But
ufshcd_system_restore() just assumes that the link will be in OFF state and
sets the link state accordingly. And this breaks hibernation wakeup:

[ 2445.371335] phy phy-1d87000.phy.3: phy_power_on was called before phy_init
[ 2445.427883] ufshcd-qcom 1d84000.ufshc: Controller enable failed
[ 2445.427890] ufshcd-qcom 1d84000.ufshc: ufshcd_host_reset_and_restore: Host init failed -5
[ 2445.427906] ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: -5
[ 2445.427918] ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_restore returns -5
[ 2445.427973] ufs_device_wlun 0:0:0:49488: PM: failed to restore async: error -5

So fix the issue by removing the code that sets the link to OFF state.

Cc: Anjana Hari <quic_ahari@quicinc.com>
Cc: stable@vger.kernel.org # 6.3
Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9f037a40316a..a9dfa82adac9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10261,9 +10261,6 @@ int ufshcd_system_restore(struct device *dev)
 	 */
 	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
-	/* Resuming from hibernate, assume that link was OFF */
-	ufshcd_set_link_off(hba);
-
 	return 0;
 
 }
-- 
2.25.1


