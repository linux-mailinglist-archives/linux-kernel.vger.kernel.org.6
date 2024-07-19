Return-Path: <linux-kernel+bounces-257736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE5937E43
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549A61C21440
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEE149E00;
	Fri, 19 Jul 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qo4TpDYt"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE7A35
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433234; cv=none; b=uqGnv+s3UXypENV9OAz6SePdUJyImuEGPgmcgBMgKYjuWpLmIthjMvJk7o6D1gq2qJOjecGlomCXang3Vf3lUX3igjrSwc+enskWpF6nEHNKVHo3Zv/7y5VcExKHKkpXCWzEcKM4io2SUfXRZ/7MQ2YhMgYCeDN/XaM28cwoxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433234; c=relaxed/simple;
	bh=RDZn9nceSKHWHAEJxopugD/XqHyZGSXq4lGQoM/TFAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G7oJAKohbyeThzeL15wX0+F+7G/WiB0ZkuzkbRTmBg0jN4Ym83LblG3GvGcCnQCF4WZHhva3kkfD4vmjWeYcAby4yqth454LT4Mb/6Yr0F/hCq0eNOG2ZqNS3RxkwBSI0zjfLgV1TUStOnUXLW8n7Svsv5PO4uP3NsX2HLLGSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qo4TpDYt; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9e233873aso1329284b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721433231; x=1722038031; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldzFiam0mujMuq28ca76nisFGKp3WDY0EGEFzIWMbRk=;
        b=Qo4TpDYtQTyxkrWD/tUAJOOSD2PB9SsoODeWPGlDrPseEVxF3Y2EZV/kzdRSqtVVQL
         ByfZgAQG3bMfJjpmAmgCLM8NlLGOpIL3ndErJdWunWOkYjQZXi8sxEbprKxHmaOtMMdR
         lWimbmIb0/cGMPeFXxodRT6WlS8GnDtcfn713pchHIBg2AifrqvR39PIb0F6GOozy0Rc
         yxn7O1y5Po3h7T/+pg2zphJTUwyDsTqBaiJ53thcM2r3wE0JhQwXoxx9fRtIXDZ+JEr9
         xWEE8PC93F81SxruE9aCFy3PWOC79MuXh+qMV1IY2cIZCd31O4qTG2KwwOe1iDVQNwkQ
         F5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433231; x=1722038031;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldzFiam0mujMuq28ca76nisFGKp3WDY0EGEFzIWMbRk=;
        b=frgddRyFv/uaER+BBVxY2DIRN9Pekry2s500dzX3Kt9xddrvdtixgVZFfKEdRzpjN0
         jqhuRDHCHddTKKjoi/Gudt5Wwv82f4br/JXVPS/4nDIV0NYnYxRrLugBi7C13XWv+3AP
         yXeU+12imKD1Sq4PG/cCGnT/ESj+aeNFBL9UceN7iZDNPslyuBbZnRIst8/z+0ghcovL
         vo0hbZlGXqV4+ggI4HfUldaYU3UYhViTZmnMDFZJLPZZkTS1MlSc/bDyd/xXrCzK0U31
         YCheYu3OOXQWSQxZ81KTQIxdcZ06gkAworMvhD6X3OSCY14ZhZkrcI4k2UxZi6MxWQC9
         xI2A==
X-Forwarded-Encrypted: i=1; AJvYcCWGUflGghHO5X22kFk9UIEJQ+LJYxDBuvPU3guGWeFShz6YohVIqRZHv2LF1zAY4KMg25gXPl+KLjTYFUpXE1PJBdBMpyMyhnUjlkEl
X-Gm-Message-State: AOJu0Yx1lmrptZqpCVqTfjufsiNfAEn9MsCMy10PExAIa2gcj7Ildg1z
	be4gHxqIYs+cRj8BPu5ujwtNA8rvqQ2/jPNGdg20GJ7NpsFb70KwshiwfPtYWFptFqhQXLAkaQx
	f
X-Google-Smtp-Source: AGHT+IHqte/qz54f4SL0d75xLOAyVvOPIAw+LbKlNbbM1Lp827319iwrSa6rBuKjQZrpHBI/U5i0og==
X-Received: by 2002:a05:6808:159b:b0:3d6:40fe:d537 with SMTP id 5614622812f47-3dae97c592emr95855b6e.13.1721433231314;
        Fri, 19 Jul 2024 16:53:51 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:739a:b665:7f57:d340])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09ce8d7sm487021b6e.46.2024.07.19.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:53:50 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:53:48 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoc: TAS2781: Fix tasdev_load_calibrated_data()
Message-ID: <18a29b68-cc85-4139-b7c7-2514e8409a42@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function has a reversed if statement so it's either a no-op or it
leads to a NULL dereference.

Fixes: b195acf5266d ("ASoC: tas2781: Fix wrong loading calibrated data sequence")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/tas2781-fmwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 63626b982d04..8f9a3ae7153e 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2162,7 +2162,7 @@ static void tasdev_load_calibrated_data(struct tasdevice_priv *priv, int i)
 		return;
 
 	cal = cal_fmw->calibrations;
-	if (cal)
+	if (!cal)
 		return;
 
 	load_calib_data(priv, &cal->dev_data);
-- 
2.43.0


