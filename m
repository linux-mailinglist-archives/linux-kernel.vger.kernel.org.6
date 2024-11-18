Return-Path: <linux-kernel+bounces-412401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8B9D087C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1783EB213EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A613B58E;
	Mon, 18 Nov 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpZ+sdo/"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCC28E8;
	Mon, 18 Nov 2024 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731905784; cv=none; b=YpO/Afo2Hf3wJNPbvvLG3Q/chYLN6mLBd0TzoVbtLUsMX6MPdcD0ZkUDQz0C8l1XtUyJFQWlJWjNLGilnQAExy0slJcX3jCZzOe6WhyUGFwp9MCrpr0tLN20u4+IzF1gSkc3WIeopVrOyMdgThzuV9FOdtI/iWvcg+pmMy3lDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731905784; c=relaxed/simple;
	bh=lWcnN8ec/LyhSAHqzCFQMl4RjZ1aXYxLSWM9IlmfB8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GK6ZBEHJSSwTQTqHgirV8mwcRlnWuohxQJdYpRKMaVRDFrjaIfvvpazVqnLLL/w3ZJa8RT8cb4KSCtMbFM+rwoDK5+UrlpgsHapFDekE6turv85rrhBsk1he89BBfcpcW7ZV2NZ7RNthUZlBVO1P9h/yKWesAeOw1SLDggjtcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpZ+sdo/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fb632bfc0eso849099a12.0;
        Sun, 17 Nov 2024 20:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731905782; x=1732510582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIzb7uKmpBMgFz+tDnGmizcbHL7RIhkfCyBnVkIL8Ew=;
        b=FpZ+sdo/8oi4kY0xr4sSokX46wHu7Nk+Hg/I/mWwI7p1roz7p14C2pbyaXIn+XoLYy
         c9uy9LL8MvneEtAz3SyWrMEEYfhTa7+hW3PCfeze7Acu/23Y07GX8LNFbajuiK/A9mqg
         Kfx8IU/0W3U47k3xzjhpG0ekTYoEuEhKOys1J82E0gE67Tyl+q4qkuIqr7dpd75rnmPZ
         kd0b9UjHzQWgV6lYfKg2+OUz8CdUx1rbHbiYt6tTSonn7mLazhGhplckboVBxAX+UGt2
         Nit0QpRuGJbitTrkJmvVGfS3MjNpICo1vHfu9cJ3B3gETJJGhW8mgK9CqX0+KHPlUBV4
         sq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731905782; x=1732510582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIzb7uKmpBMgFz+tDnGmizcbHL7RIhkfCyBnVkIL8Ew=;
        b=oPrvnJJonbT73LJxYrJ5YCAqKrQPuMmS3Hpjkrw238q5u6iZlE/3crisHS55MCYSZO
         wRNNk/SmRhYbU2e/QPTwR6dZ8n6v9dfCpfSXL3zIg4d/NEAsSV6pRIRveXVSSetAMxOg
         bAcWIQF/ymhn328Jkjmn21mHtw41eesa27ZvTNx8mdoX86qzUzF+iWz75flO26VK1lNx
         zzJgHKSJVobICfmH8agLqr6YVFRqd0pP76P+2eWFZFxwobbPRQ0SiOwgjqeq9uZLEExS
         ZHnKRc6Wo7YTtALWxHhUxWiJbanxUUhFcBcOmhDv2hMKwWRlDgluI60nlkN196zTkS2d
         or2w==
X-Forwarded-Encrypted: i=1; AJvYcCU67arRc6N2+0ujTb1DPuA3eajtoXKyCc0O8znwKA0RiBAjp5yWeyHgelzXsPogPF3qajxJ3TgrPw5GBvw=@vger.kernel.org, AJvYcCX8sL1HlGC2sWNb94KoERsW8WcCp2NwnsrVwLVfPYyaH/5aufk63MRV8vPdCDpz2QYt3JVyfBQhFv+b+To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hfjK1UBCuP4j1DNWz6VZxsZ6lib02R02HSS8hHCk1tBadzg9
	qameJhq7VHF2vNnx+vFBxs9juJsxrnErNbBWQP4WvkFPi0CVIFwg
X-Google-Smtp-Source: AGHT+IGM5q/XQhELTyhomnrivxdQ/jJhyyr8CxujelNS3o0So9Pf9jvqU/iscpoImttt0BHLahuDBw==
X-Received: by 2002:a05:6a21:7e85:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1dc90b225a2mr11710103637.10.1731905782118;
        Sun, 17 Nov 2024 20:56:22 -0800 (PST)
Received: from HOME-PC ([223.185.133.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c644b1sm5009044a12.42.2024.11.17.20.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:56:21 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: frattaroli.nicolas@gmail.com,
	linux-rockchip@lists.infradead.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	heiko@sntech.de,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCHv2,sound-next] ASoC: rockchip: i2s-tdm: Fix a useless call issue
Date: Mon, 18 Nov 2024 10:26:05 +0530
Message-Id: <20241118045605.48440-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a useless call issue detected by Coverity
(CID 1507978). The call to rockchip_i2s_ch_to_io is unnecessary as its
return value is never checked or used. As a result, the function
definition and call is removed.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 28 ---------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index d1f28699652f..bd0dc586e24a 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -514,33 +514,6 @@ static void rockchip_i2s_tdm_xfer_resume(struct snd_pcm_substream *substream,
 			   I2S_XFER_RXS_START);
 }
 
-static int rockchip_i2s_ch_to_io(unsigned int ch, bool substream_capture)
-{
-	if (substream_capture) {
-		switch (ch) {
-		case I2S_CHN_4:
-			return I2S_IO_6CH_OUT_4CH_IN;
-		case I2S_CHN_6:
-			return I2S_IO_4CH_OUT_6CH_IN;
-		case I2S_CHN_8:
-			return I2S_IO_2CH_OUT_8CH_IN;
-		default:
-			return I2S_IO_8CH_OUT_2CH_IN;
-		}
-	} else {
-		switch (ch) {
-		case I2S_CHN_4:
-			return I2S_IO_4CH_OUT_6CH_IN;
-		case I2S_CHN_6:
-			return I2S_IO_6CH_OUT_4CH_IN;
-		case I2S_CHN_8:
-			return I2S_IO_8CH_OUT_2CH_IN;
-		default:
-			return I2S_IO_2CH_OUT_8CH_IN;
-		}
-	}
-}
-
 static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 				     struct snd_soc_dai *dai)
 {
@@ -577,7 +550,6 @@ static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
-		rockchip_i2s_ch_to_io(val, true);
 	} else {
 		struct snd_pcm_str *capture_str =
 			&substream->pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
-- 
2.34.1


