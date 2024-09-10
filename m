Return-Path: <linux-kernel+bounces-323883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE4F9744A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B455D1F27046
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325471AB500;
	Tue, 10 Sep 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdqZIi1c"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BC1F951;
	Tue, 10 Sep 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002793; cv=none; b=IGHBE2EB9j5BknUVi4siTNpe34emqvpb4XJK8ZpDURMGqAGx2gPW3XaVUcaKV1CqJOexxKzlPLMi9Z2xStLgVT+f6FRUuY8CKScrW7C5M113D9nFDqw7yzL6hEQ1u4Gj1b1lSxfACz51jUsaz2PZ1/rRmVi/C2KFPltb2EiKFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002793; c=relaxed/simple;
	bh=vDgjIBjhHTJrGIyXLK3F1O9eH8ttQJqEQh1v0D44fkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/mXnLgXxsBMXkXQwDhv6BVmBVp0pKz6QVLhznf5oc5G1k2VYqdv2Z7stKAl0nHeslPBYS/q4RiDyeeP9BELpuQE4K7CIks2S4/hu6Ck5HBGaxcGJH33g0K5hGThrsvt/3/c1jw00I0i9ardeA2AJ4kYmJcU6FtilFTwaiGC3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdqZIi1c; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37747c1d928so3774669f8f.1;
        Tue, 10 Sep 2024 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726002790; x=1726607590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mShm0KIU0OZ83/t9phYF8kP86kSg8BrKV+H1Ffpa/nc=;
        b=KdqZIi1cHKGNj8OdeyCeoofuDUKgGQREHww1bby3ui17q2k9IDs6TUcrghNik0AoCs
         vQ8eiXBikvikn0I9Kglntqlt0y3+1v2f+SGZVA5B9S0WojEj//UfPDsvdINZtT2Hd/8L
         YD26XPeTt9X87TGUe9Kbss1W5Pih9BTsLHA2BWAtgz8CRU6l6QdpinZ+6bYrfkj0LjbF
         xISlXm43ImSbzHtByHpFL5hetpFA9PAneAaj0A7dxl/oHkJyoV6PAlVyKzKS3ILVSZ/u
         ABQ/82dEOt7nlDTKTtLdDYwAfgzcnKzFdriqwzyOfJgm6cY92V/iVoTbSginf67FhJMl
         x8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002790; x=1726607590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mShm0KIU0OZ83/t9phYF8kP86kSg8BrKV+H1Ffpa/nc=;
        b=q0CMwzgx4KLTED5k36l+iRXZ9r7ze3e1X8QBRDm+UpC9m8u2S2o4D5tcrG82lX2COg
         AK82bSi4laOfT0OakfioCfEDw0A9yeHMJAMb/BJvw2rqOJELgGCi1XLu6/lafxUQjXcs
         D9GOsRlBLe9i62rXjU7L3xaiF+9vlwe268X6Q/fOHIiMwHphnQeQDWeXUKLXk48Z6Z5X
         P0ylcsx26DI/uQWeuFVm0OWfXm2S+mKLYJ5goFfOerZYlTqBW2DgoFO7gd95v5eSOX/S
         0/m9ePkmPV96j+gwptpJ18MadS4E+p799vO/eNzbAQ/1U793JNdVpLz4QFp6az9tB6Dz
         Zz0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+MuJv5/F/4WhJzABsHQZyRsP3L46Tf+QFOkL+amBxZ8eegRoZDMFKym51usmyUylccbwL13IxonGpraOMBgQ=@vger.kernel.org, AJvYcCVQsJpBnfugb++Oio+AwkRX/CQiDWWLbJKdZIAx08cT8OSRvibRSMJsALn+oJ6h3HIbpUSVfOX/voe2xgZw@vger.kernel.org, AJvYcCXZQPODkPORY0Q25CsvRjLvSjVWSpHeMhniqlTNvESZ8QErPXVtWj0AkN6PqE+InZ6aL9mIJ53XFMOiOns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLw6tgi8VypSmsdKOXUQYV33DgvD13sxol81W/hB0smy01DyAU
	hfdB2rXUAXFH7BGOOW4MBC+tXe1RFHACG1B1OXkcFcuRYRfiK2rr
X-Google-Smtp-Source: AGHT+IFwmCNPL5aE3FgmJvUfyIwFUQvYFcinWghCIonakDEYeycDzAajn6O7VZPeDDDMSpsKOoIGHw==
X-Received: by 2002:a5d:6aca:0:b0:371:8688:1660 with SMTP id ffacd0b85a97d-378896c800cmr11271977f8f.51.1726002789527;
        Tue, 10 Sep 2024 14:13:09 -0700 (PDT)
Received: from void.void ([188.120.129.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a279sm9879024f8f.9.2024.09.10.14.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:13:09 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] ASoC: tlv320aic31xx: Fix typos
Date: Wed, 11 Sep 2024 00:12:41 +0300
Message-ID: <20240910211302.8909-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7e624c4b77b6..187d68e8688c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -895,7 +895,7 @@ static int aic31xx_setup_pll(struct snd_soc_component *component,
 		dev_err(component->dev,
 			"%s: Sample rate (%u) and format not supported\n",
 			__func__, params_rate(params));
-		/* See bellow for details how fix this. */
+		/* See below for details on how to fix this. */
 		return -EINVAL;
 	}
 	if (bclk_score != 0) {
-- 
2.46.0


