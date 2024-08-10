Return-Path: <linux-kernel+bounces-281955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B668A94DD72
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706F72820D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D285160887;
	Sat, 10 Aug 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/9e4t3p"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41022F19;
	Sat, 10 Aug 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723302645; cv=none; b=b8Q2bpKsJgkOrSkQ8Q63xnFRffbrAj28o8myAiKJUuQOdry/SvNeywoYSd8Oqujw/fsnCC1VnltIM4jjRNfgVKR8w5eVyvLo7X3TLvsr/Vos7kuOVcvFWc/ijre9vGocHtWKKM19cerkUFzqP5Cr92hOaGYLkXw0c8gTeDs/Tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723302645; c=relaxed/simple;
	bh=JWCgYbzf+h1KKPwP8jzN/aLLpgY4lR1Jk1TknmNYx+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XO0FvfXycoyfoblGR6ye5wdyI6ikF6VGOKM/drhKl78o/M5YIWq0e3WufVZcBnFJ/QkW4GXQyPWrMtRmWsXbMCBXuflTU96u4Z0r2ZSMxeOU1EwrZ3ZMuyT/wl5a3BIhwCgpBvM5yBOIQE/Rz2nagYxr9OkF/ctjzBkd7wZp5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/9e4t3p; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ef95ec938so3023975e87.3;
        Sat, 10 Aug 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723302642; x=1723907442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBI9gWTu2lk3Xag4H2X6YcQpeUA1X2ClW7QmG/3ro88=;
        b=W/9e4t3p8SP0pSw63wrm4PjPVkxSNXWaeiEp+qH5PLtRzvfY8jE0qBTXoaQx3kI9hj
         plVgmyVC7Oh4QQzalgp5LaK5JFqcjAYYp47YzDS9TNx+Q7Jpkz7Rnx9DFnS9jcdBUDRK
         EewTZXvmRMXYaluIi0l8ZccjtCP89wJe6Qeo3zVUylVuX/7xZzKYVZmBpVJpXsyVyf8+
         PjCazQ3kRcGx0w8Sj2rb/rhnow+lNMM3/HJHmDe6+eSLKrh0JfovkcGnTZqLUgbHaQ67
         GUGuYt2vECdi74ayaOB9JXt8cCjP9kywd75YdXlwiiS6gKd8r6B40ZsIgZYcJEA8T8a4
         cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723302642; x=1723907442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBI9gWTu2lk3Xag4H2X6YcQpeUA1X2ClW7QmG/3ro88=;
        b=nAWKMT5u/pb5aTvxrBSNoBjuPLoXQdm4j05e2cRgFDZdovi2JCV4wJNoOl9RH4v8bf
         eR1TisQt++F5LfNXDEfoJ2M6S5gxgJnK3+xFPEVeQo9RRs4VAsbE/lNM+hZjCz6vqQxO
         fXBmiNtvi+s3Wm2M+flEuxCEAkfl7HOb/LB+68JO46EZR78YXTRiEpBiGpUqu+K9fHAm
         RKLEWtPksNu82GauDUxHd+mDEAjdmgcT0Pu493aVJQoFHfdc6A93K3WhbeEUen44ziKl
         4Xwti6fBX2457jJwY8hsHAXU9bC8fuDvaJSAigMO3sueST2rAyN8XJeeffQfuzSa+XMa
         srCA==
X-Forwarded-Encrypted: i=1; AJvYcCXsOl6ny7krdsRhkeAwtEhGKL8E5Y5Wc4PqxcyKs2ed9EybGaZbCxWlfRjV0Vw5ZrRT/Oy12fUaB1TtXHJz6AdpSZT044E+HCl+1es=
X-Gm-Message-State: AOJu0Yyhr6vsAj+usJNwmQHAnEBgH8qNfa24MhYWdgHwYX3PSR+Iow8y
	cXgK1NqlOJ23t1/7/utVtNZp+kocopU03BSyHfn9jIu0BJC3FMqn3OEhKWdnYIM=
X-Google-Smtp-Source: AGHT+IG5TCKE40kUt0P1iLobUZSwuoIzdW9hTggtrrcpLNOFXb9xiL0/DtrNIHgMemtHLgb24LWEEQ==
X-Received: by 2002:a05:6512:b29:b0:52c:daa7:8975 with SMTP id 2adb3069b0e04-530ee9741d2mr3494982e87.18.1723302641513;
        Sat, 10 Aug 2024 08:10:41 -0700 (PDT)
Received: from localhost.localdomain ([83.121.134.138])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-53200eb4d07sm236304e87.41.2024.08.10.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 08:10:40 -0700 (PDT)
From: Parsa Poorshikhian <parsa.poorsh@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Parsa Poorshikhian <parsa.poorsh@gmail.com>,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	kailang@realtek.com
Subject: [PATCH] ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7
Date: Sat, 10 Aug 2024 18:39:06 +0330
Message-ID: <20240810150939.330693-1-parsa.poorsh@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 70794b9563fe ("ALSA: hda/realtek: Add more codec ID to no shutup pins list")
Fix noise from speakers connected to AUX port when no sound is playing.
The problem occurs because the `alc_shutup_pins` function includes
a 0x10ec0257 vendor ID, which causes noise on Lenovo IdeaPad 3 15IAU7 with
Realtek ALC257 codec when no sound is playing.
Removing this vendor ID from the function fixes the bug.

Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2dbcf8f5bcf..7b593642da99 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,7 +583,6 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
-	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
-- 
2.45.2


