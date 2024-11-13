Return-Path: <linux-kernel+bounces-407632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390169C709F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37870B27964
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DF1EE010;
	Wed, 13 Nov 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoRYYZfg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B1433CE;
	Wed, 13 Nov 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503291; cv=none; b=aARZLBAFqP3mFYvQoN6GOFdVUmflx5fdmwl49ATlgZzzdfZ6lpoVwkILYtaSiqAZoRs+HlFFCbzgCjChkr2PytycBmiltNINFzJ8SQEudH3IDN6a8RSrN945pY2400W97EZZbAZGd8X7Bem07cUOZ83bHe3H7vPb4PnMEzfBPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503291; c=relaxed/simple;
	bh=2WWRK703YmFJmLzZ2S+UG/8X4WmXCsvMcbUca5/g/z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iD3TWM0kpjZ1glB7JhPqnUvQi/sKxM5E++15x/guA1Kx3OpcffO7tR3bE9yBYQ2WMSsRKwHa6QXgVsNMSwGzGUW6PChFvlzrH1ufdu3jLeHOhmJZDmkHuZlsSqZYln8VHmZxbC0V/Ed9MP6bypN1IrAq17N2K/f9N6g1XoG2dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoRYYZfg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316cce103dso85518555e9.3;
        Wed, 13 Nov 2024 05:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731503288; x=1732108088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2a0NVxNB/W5Csc9TxzF7W/iYXO3VvsRJea43sdbNNNY=;
        b=WoRYYZfgI8uTPueNx8rzbEz9s5CpFjORR/NCD4p6s8x2uniGRioWBA9fSPbJdurOfQ
         muKKJBkbrnlr7k8i9+Gy4dZsXw/8zFK6Db1ov2f1mTgfZQ57hEJlL3/brwrHZSJSlbLW
         k9TCKWy5nuDYPcibQoVLm8O7qOiDVl7U1HTi5jzyTjtNRJnshCKwaJ3VECtQO1pmvrwC
         o2O5F6mg9CscgS8s8iB5MLUPe4i2b8Wo3cyjiyiH7S+iFZylYJ4xfPcKI2XyQ4lNX5SV
         KYK0OWK8dl95+O/OE6mu7lDUwqtdQo198zi1kkJdZv3qWefmJfZUntFf1QipFirgf05Z
         r3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503288; x=1732108088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a0NVxNB/W5Csc9TxzF7W/iYXO3VvsRJea43sdbNNNY=;
        b=tqlvqDMXxI7HpVsTR9KyNprElycEx1FMuvvPJ2aOb1B75rJMC7C3tWo39dnSZ6Glap
         hbvYUfi4LFUyGGg9SqOBboRsJ8bP7ep5g2BsEsjy2KMmbifxu2jnjTLvxseTZpoOOW37
         Cw9skasA25IZXKizxeqDaWC0hiQ7ZLx8hI1VEHzFFv54IB/VfbbpHjk3YNMX/stxelAj
         vKdQARAQwRw3yZestyqn2W0UMUdp7Ji4HCALtVsNzPFuBew7aWj0hS4VPmgl1x4FU+SZ
         BnpABEXSRW+h480Q2L6ajAXPgYFaRz2E7OOGZzmRhXhdqllx/08Q7Fc0VDN1PPmmDMg6
         Xf+w==
X-Forwarded-Encrypted: i=1; AJvYcCUMC9NwRZTUN2rmL+5pjwylhjerUVEBYaZolr8qbdbnoLdocmRhng0CpfzZ/DIelNKG8POyI6uUiaSOluY=@vger.kernel.org, AJvYcCWqTomBGMwHzn80X58I0Zx6jQoaHrotviiTKusbhuc/YWJEDpfRA6HDrWg1exkCccZGpLOOAky5p9MD2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5oKWF54HN+fWBUvsQ6fDopAXKop3p9097YYxm3AD9BvvzZIZ
	obISGxxcwtjefaQwFCNrOhaYkrIlJLbjttm3xahK/m3InZCkZACh
X-Google-Smtp-Source: AGHT+IFCS0AhpP2qyy3IR0ypDlDOr0f3Bs+wNSNJoR+LC9CYkW34Um/O+lusmxIzJqY8AAMjqsNosA==
X-Received: by 2002:a05:6000:18a5:b0:381:d890:b5b7 with SMTP id ffacd0b85a97d-381f1889de6mr24360788f8f.52.1731503287618;
        Wed, 13 Nov 2024 05:08:07 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm18664751f8f.88.2024.11.13.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:08:07 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: ipc4-topology: remove redundant assignment to variable ret
Date: Wed, 13 Nov 2024 13:08:07 +0000
Message-Id: <20241113130807.1386754-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a zero value however the value is
never read because ret is being re-assigned later after the end of
the switch statement. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/sof/ipc4-topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 1fcf4692a21f..b55eb977e443 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -755,7 +755,6 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 			 * It is fine to call kfree(ipc4_copier->copier_config) since
 			 * ipc4_copier->copier_config is null.
 			 */
-			ret = 0;
 			break;
 		}
 
-- 
2.39.5


