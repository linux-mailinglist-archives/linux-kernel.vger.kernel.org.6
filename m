Return-Path: <linux-kernel+bounces-440221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E29EBA68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43671679B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC91226873;
	Tue, 10 Dec 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luzU6aTT"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3C227577
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860576; cv=none; b=pYiJegu3SucZ0m6x5T0y+5TaxvEx2sAtUPAgH6ozdTB5BLDC4wsI1Iu4/La1LnPqC9d+wK9nyzvgaHf14J0XiYQ3nafn43C2TqW3pLl6bFMEm8yHvedfLsZolaVfRySpi1kd/+jRX5PFH3VDjj+k+zRLKP0VCaNrhR+Gnrk96Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860576; c=relaxed/simple;
	bh=sdF7tOeLaLfCdiDlVogKRTgQV5yx9VBAgCr2khnDCdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFLYt0Iy0zgljVLoWRAdTxS81eHABhhITgoIf/R1y6evirx2G5MRsgkredS2ygdY/mwvuF6n6NF1IcQ4OJHK9jvfZi+7e/igUfqnDyhwJ2bRsip4sRsFWM1onEejinOffeLaYcALddaZwW/Ssp3LkfreNmgjVIRuPSsMwdHt0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luzU6aTT; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso1429367241.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860572; x=1734465372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=luzU6aTTSezSex1ALcfr8qm/Cw43J8blTOlKNcRbTvmt2thKSm04esfPknpK/p4PlZ
         lzXIXwS80VEBJYaklDfFc3P70PWXSZiRXWH/+ATNeATzC93i5+9o11+s04HJoVVxLXct
         lg+PTzl62ZYA9JYwTeo2CZIxc5S4oZSVr1tGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860572; x=1734465372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=LXCXr16D+g68ajzFzlQkjHHLD3vmrQRWdlcLZdmLlSv5yC6dgFcAnLZXrocm7QQdss
         J2tEFqKfYU2vIJPb0uAtl0y2PogVF0dqQpbxPtywAwVv75R/c+De67mJFnB9DJ3WZ04z
         Z/jmzJfMY14zxceSxPaN6xjSqcMkTufPdkRHa0wh1IPpJLVUIvScfMaJfOnfx8erz59J
         Aj0FBpVXEPmMfneiqrP6ZTYYe3sU833RjNFiOCgcuZ/oD+nGSziQRBt1JOb0ksM0eXE3
         wCmG5VbAKqrJIHIK1wTLdICZspw2ZQ4WpdhKr+y/zSiXykgqVLKZMfTKl9ATtEB58ggg
         Mnqg==
X-Forwarded-Encrypted: i=1; AJvYcCWl3/bY7lR53senFEPqlryQK7HGCsgYR+pGKRkEVSHGCQDsi3jDMOWVEghUwnIq45R6XkFSKSEw7UlLBTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbfCjxsXf3FV0YY9c+4j1BLhFKAxnWLIOcjvc6qwpGobLOHLY
	dKRcvqqkjxAa9U4zdlkAgtOLoE3mrY8bteC53EalNPZ+MAz4aBeVnRC1Y8aubA==
X-Gm-Gg: ASbGncuHyS/UsmaEAEuaZYlq0RsEd0suVg4Tmozr/5RCsBXea25SsGd2fpARmoo0CnJ
	NQNIB/jA2U9F5hw//gOhPW9x8J7/vOXyMoZgXfdSZlvXsqUMKzB0iCaTMeplHDaD9ggaNbxwpv+
	ETUjTH3yhDG0KMx9r+DilVoJPlVjf6kyeFkEVdzwqEqYPWOlZimZetIVaLBQ5/QlpxKz07EvacM
	R+iHfZ/ANktCB87qYS5qasxSdVuYkUpmAbZr/4Wms15AD33STQDTnZ4G66Wg953grAQlQkeH4WT
	o3D75pGMbm43KGgreEYKXBW00ICW
X-Google-Smtp-Source: AGHT+IFOlLOc71KptU+gM+mbs7OSqZvI0F+Ca1OaQ7iYQclHhw5OIq3pXc1ymxgCi+mj9I6EK0fVEA==
X-Received: by 2002:a05:6102:418b:b0:4b1:1971:383f with SMTP id ada2fe7eead31-4b128fee492mr811079137.8.1733860572588;
        Tue, 10 Dec 2024 11:56:12 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:58 +0000
Subject: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following smatch warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

-- 
2.47.0.338.g60cca15819-goog


