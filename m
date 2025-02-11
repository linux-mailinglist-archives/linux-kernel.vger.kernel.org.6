Return-Path: <linux-kernel+bounces-510160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DBA31904
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C74716768F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A961F3FC1;
	Tue, 11 Feb 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmi/B7Tu"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63844272905;
	Tue, 11 Feb 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314245; cv=none; b=ERdpxricDf7Ih5/QF9ZuGvSq/7zWklSrejcSPjYgYPqHmKJCXotwxB7BOwXrv/p+iRSpHVfThO5qwYkNoPx0VugyVNhUJGyNGWufM6tp7GpbqAPwEthBS6vdxAtyXBhdu+LsUHoX+HPFjN5K9pWrfqokpsDyg1mb4fxX05Yn32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314245; c=relaxed/simple;
	bh=vd7etzFURvjt2qMQWdTlc/0nsCmROUouFpAkB6TyhSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=giokgzDz8mikonExINRlcfUwHRzDxrKv/yulEomAPG8duKEWMagSZZiJPGS6jX0zTL29WYKCmISGqPQzZklvJj2ZqWc4hLhFD+OdzL8eSI6lUPKzAbKHTM38uXf57cxmNck2/SndTEKVbWDW5XhR2dy5o+D91BO5fsSdPLDQQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmi/B7Tu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so394295a12.1;
        Tue, 11 Feb 2025 14:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314242; x=1739919042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkJ255Nz05hMzwYP0ZFP3cQKnCDIXbUqK4zohkcWmek=;
        b=Mmi/B7TuDqYvE1CnfP2oDmfTKo1GRhfD7jXcBg69N8p0sjWithvcK75krCbZL1/Sb3
         QIVTvjoPkSTJUcXNFxT+jzwN95AGOT133MA6wiTBuWWv+SUKfO5mMAIxgSyXgsr6xpXZ
         mrAQTIrcPfOSCc2ccfn6/r+WjB6oen+F8FdiJJ6tyLjKTkhdG/g8Dnlt1sF4utf1GrJO
         15JokGEb7EmoRsEHKsTVsdcUitAQYCVrWarFhicF0tArpdJrk9gGPOCrOD8FxUO5tBJN
         4zjB7P/sUlNG/WoVo2RySjO2wxZuAZeKUI9JRsI+J41cblDqWp7zpzYMt2JpLpLbHNKb
         ntJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314242; x=1739919042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkJ255Nz05hMzwYP0ZFP3cQKnCDIXbUqK4zohkcWmek=;
        b=TW68wF947zmeFO2m9t08noEB+wLmKzDnu81MHpLmNAB9uftFDBbIFR7Wri/cO+szif
         hmqRz6GRalGxHq0dOrgP8oZFpQcS/Cvpa+0397b8zKEiR2WFSwCshk+Ag+Vby8E7GwaE
         i6gQ57kt93ufeu2NSKuXSZreciuCJL3sAnQbsnxqupWgOwSnTarNPInklkE3Azwb0ma3
         phamaMS5yZkLuwoQm1CEe4e5/WPLL5qOJ2Yvv/PaiFpoE7QT1QiujIszDZFlJ42pJKyx
         f3h0Wib0iaygnpbE7wWAXrTCiWdeC1QmR38tO12XxfF9j9F5EgRn1OLF3MgNdl/yUD32
         3QzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY+Rixzi9wyxBw9bIqBai62A71Qqo5ajMlKAAkxZX2xoyByo2HechlT8AHEE6Mc6uPwlK1f/iR7MrXv7U=@vger.kernel.org, AJvYcCXix+c6QA0uwEVLn7LLh8K6o014uHi54/KHbHP48tm5zgr6xeyTYWH79aCMOAmCCNwsFGoiYP4RxtDTeeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY874A6QBvktrrbvVqAMd7GKeifB7itgOvmzaJo5hF/WQ9ZMBt
	W4opO/Pa09zdmS3p/LTN8oD85WAc+wNISTQOPO5RW7tihWOUO8uuQU5rJQ==
X-Gm-Gg: ASbGncs7Z4jp0Vk1xhXf6xFWQhehGcrzY0vLmxAYqfckWTf7GDzQZbJRiMb+86zt76U
	9NtArIeQ7tAgtP1TjWQbHSAR6/zRAmfh1JlCIVYzL47kTkh78VTchDeQ8FkDZMg9BvsCnKyE5Kt
	c/+Bd8I04XZflCVM/JwnU/gOPDZZnG4h+J4Z9tXhGefXZWsqjnOFQJr+U0PsCpXKRPywK7Bnk+Y
	3yjMwwc71gURv+UPZD34sp3RZ5vANYUxL17ueVLMzfGsNP3La65OIv47D2E6IWX596zFf74k14J
	ISGAVxyDjnH087chBieQDJwarLpH8uMV5Ta37pWgfQN9gtxV3wmGvg==
X-Google-Smtp-Source: AGHT+IFxHR7XFUlEo4fGWSQRitORCTM5qncC4QGfswuOZDj8v2uEOoaqSeMx1wpe0vdO9SFp/CqWwg==
X-Received: by 2002:a05:6402:27cc:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5deadd7d39emr2174378a12.11.1739314241317;
        Tue, 11 Feb 2025 14:50:41 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c4316deasm468338866b.10.2025.02.11.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:50:40 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: imx@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after common is alloc'd
Date: Tue, 11 Feb 2025 17:50:18 -0500
Message-Id: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

'imx_unregister_action' uses 'sdev->pdata->hw_pdata' to fetch the pointer
to the common data structure. As such, if 'sdev->pdata->hw_pdata' is not
set before adding 'imx_unregister_action' to the devres list, we risk
derefrencing a NULL pointer if any of the calls between
'devm_add_action_or_reset' and 'sdev->pdata->hw_pdata = common' fails.

Set 'sdev->pdata->hw_pdata' to point to 'common' as soon as 'common' is
allocated.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 sound/soc/sof/imx/imx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 82057af1436c..c3594815e60e 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -378,6 +378,7 @@ static int imx_probe(struct snd_sof_dev *sdev)
 	if (!common)
 		return dev_err_probe(sdev->dev, -ENOMEM,
 				     "failed to allocate common data\n");
+	sdev->pdata->hw_pdata = common;
 
 	common->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
 							PLATFORM_DEVID_NONE,
@@ -436,7 +437,6 @@ static int imx_probe(struct snd_sof_dev *sdev)
 	imx_dsp_set_data(common->ipc_handle, sdev);
 
 	sdev->num_cores = 1;
-	sdev->pdata->hw_pdata = common;
 	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
 	sdev->dsp_box.offset = get_chip_info(sdev)->ipc_info.boot_mbox_offset;
 
-- 
2.34.1


