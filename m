Return-Path: <linux-kernel+bounces-561182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD2A60EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92675460FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B51F4276;
	Fri, 14 Mar 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/BlHhQI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED311F2B90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947110; cv=none; b=e3j1mP4u1Zrbk053smIZGqF2RVaHR/t95trGrDX62YhVD+BCiDZs9952DkuKDb55KCE0x4S/USJYsOVOfrax6Lb2r/7AP74LOxj0ED41wsTnWdAI/Iepv78yKNRu7FtS+H/InM8eNIxS5xUhvmdXMaxyv4XYnjcX+Tl/0usNj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947110; c=relaxed/simple;
	bh=1Vi0CajOHRKeNKzH6avY9kIwFZ/TezpCqJGypsjuUds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cUwQNQqvoHdGa5IteGxyVerEHLzxgaFXUlgR2OPrpJh/JN6+7RiRSon27cmKeJ6x0BaSgjHIzcoyPe9QlEaNcEkr/1BZoYnGGT1rTdfzSfT5xFaWYAXOV8sutQAUHyRIo0wvc7YqGBQq0SJlJfY6NsgnLW4V9fekugNyGa7Vtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f/BlHhQI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe574976so12086275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947107; x=1742551907; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXrdPdZYVwV2bWnv1UKchMA+tMF9lSgD0HH6znImayo=;
        b=f/BlHhQIdTYqTmPA/b5rXE/Z/Uwi37jn73qTlU30S6DYZNhAu/o5Gbd4w3GHON9ZI/
         fq9Wj4Lt3PLeD4mZKrxRpQghy07pQWxwsGPMEo/P9warcLMx+GcDF5xxbWzDZWEysjyZ
         ljBZzVros80DZIjd65x8TX5sZ8yMHVjOPDJCyXmMJN4YZL5YM01fJoqLOmzb4pWkz1pi
         ipvKJj68NGqq9GRer9n9MXwC5Ou2eQJUEnV0ZmG2oR1eFBftJrtgj7umYfNvFb+mToJk
         42mdbVEhTWL6qkCxmmn+VMF9DydsuAFds1sqUSajijuPmEO4bJf9fUQp87/6SqZS/mZK
         KikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947107; x=1742551907;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXrdPdZYVwV2bWnv1UKchMA+tMF9lSgD0HH6znImayo=;
        b=Hq+YoI4ASYYPlNw9GMzMeNrIpshj1IGpfBSw9aJuSgW0Pnr9YnV6fK4XZVPscCbktY
         f2lk0kJOee6kWYO0dNvO6ucIBi9e7lMRkmwUVGtnFAO8KxlH8kXCKcNoKItPb86yLcJB
         NDNorrKMB/aIyT9OMc+YXQPmrqmWQ6dMq5VdQDhZQZOCOJadueFo2elbGdDUtmiwa+Un
         tVnYg0KgysBySBPn+IDkZ/VDbdOIE33cv2iLZHyIzCTy/LObLNx8PUeyODtjkD2o7I+8
         KvWkNBZhScs/sGsHoxWTQ/qriGAQp0vVJE8IH9zkg20S1WVM4mz1gFTROKU+TjgpeX2X
         1EFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNULXJPiL6QhspMk7A642yQ3GkG3dOr4Onb41H571rYGvwWZ6EduwIeN8++XyowtvSittc9fNG6NLtNkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Oj8YE4ckkHnth96L00H357KGcFotYWOPolObG3qbEyd+BbW+
	MeQwfhPtCS6Z3ZHvYVtd7miL3fgV1YRmrXRwHa7lnNe7Ky3oDJv9fITfJcit7vI=
X-Gm-Gg: ASbGncumuHq+w2hPcS/d49y/mv4i/cdWV+CgPKMeA1r9SF3vNrcoKJUSx4ABasghV53
	ww6ayQcy18Zhvoi2dqLv0Qhl+AA9uKLebSr18QKX0yyReCpt8XmBaUHVPnWnFF6/BvM5BI0kqzp
	ORIwXh786bZJIOh2CLlhXUzBa/pOirErFBEDygHyBIpIBZ49OZx42UidMZ96CiDRy84eNvr8tn5
	hvDH+8iaDUbOQ1qlEnktqP7xn0R+R4hobrqnkchWxJWxZijLjvBJj4WOONiy44g/a392KVbLrTR
	SRusNtSp5Ah41solpqodFdSfIjOK4gNpUhL5ydE6S/dCQSuMew==
X-Google-Smtp-Source: AGHT+IFu33nlZq8eDE9nkYaBwVTjMj37ygSLQh0y3dybArIim3lL6otY1GCHq+RK2eeNyDGoSAttHg==
X-Received: by 2002:a05:600c:3108:b0:43c:fe15:41e1 with SMTP id 5b1f17b1804b1-43d1ec66daamr22153745e9.4.1741947106739;
        Fri, 14 Mar 2025 03:11:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d2010e2a2sm12352535e9.39.2025.03.14.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:46 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:11:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoC: amd: acp: Fix leak in acp_pci_probe()
Message-ID: <3dad80cb-e177-45aa-97ac-df9c98a47d94@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There needs to be some cleanup on this error path.  We can't just
return directly.

Fixes: aaf7a668bb38 ("ASoC: amd: acp: Add new interrupt handle callbacks in acp_common_hw_ops")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 9322379cb36f..123524f90d6c 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -183,7 +183,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 			       IRQF_SHARED, "ACP_I2S_IRQ", chip);
 	if (ret) {
 		dev_err(&pci->dev, "ACP I2S IRQ request failed %d\n", ret);
-		return ret;
+		goto de_init;
 	}
 
 	check_acp_config(pci, chip);
-- 
2.47.2


