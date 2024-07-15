Return-Path: <linux-kernel+bounces-251978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61620930C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A5A1C209FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D66AC0;
	Mon, 15 Jul 2024 02:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ilj0h5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A973291E;
	Mon, 15 Jul 2024 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009207; cv=none; b=CXlXSdoH0PtgX0nUKVVMUaH6VynlxW14ezPCpb0Ty99qC6+hbjwNZSaELOnQiIsavbdVeQGGICzPsuab8QpY93Q2WMSfiZBPCRyeMIYhxjDsCXu6VctkPRm8UpQMRbKpCQ4h3n+tw1pBUZgmKnxcxt+Lsh36LCDQErpdssq08FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009207; c=relaxed/simple;
	bh=x7vpIAZnmMp42pJsHPWboy7B+F2KkwRLCmm+h+qDv60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U6Ash7Q+q4gf8ed/coBJ3oH3G9Qpy2JX/xQXD4yzqhVVnK3ziSrYN1efhaQWpdwEKw0GbDGyBCtknKacIEpq25NToYSXyEyPVcOVgUZqpyZ8Oj1UA06m3asAcGipkpsU9INf4jzlxopoKVp6OWBRzz1sC1pM5DH+eK8n7YPWCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ilj0h5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-78aeee1068aso1306239a12.2;
        Sun, 14 Jul 2024 19:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721009205; x=1721614005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT3xT6TOmSY7sFiQnSnrJGX8mNO+K8BiXdhqST/uuWs=;
        b=e3ilj0h5bQko2kEzfobuU7b0C331rG5kF72XX/3caLpCZ/beaBDU8NRx9nnOL1ZszL
         Z2Bv+48Kd6/1QLoy6uQ2fgcffayNgy1XgLB1fbCO7SNVevTm9KRul3W2aU1ZahrJS2xM
         J9LgISXUXvLXTnGNC9MsFemz8ZBtVaOq6cncRjTWac/j7hUwKwDoJ4xbW5cdOT0qH7WC
         eiA6SeEy9KavXjlx6thRPLm1pl6Myuc2iCTcHbMbP7USdg4jB8fywohYlvwQwbkSbocR
         aoCLcU3qb8dcjc5kk18KXXvoJwpEEFeZoCPzCtStoWlecn7ggOfCaEYyXkmdqntUWwH3
         cHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721009205; x=1721614005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT3xT6TOmSY7sFiQnSnrJGX8mNO+K8BiXdhqST/uuWs=;
        b=JBXJQHwRFo+AkjguO8TVfUq47oDdFK9HViucEbAUDtQd5pgl56o6d/qS3Ey8UuMiSi
         +k/jmqhHzmn6Cg1mc6W80M0RTjTFdeAOWGdiUD9Io2QHJsEt8yprzQiXLoiA25qHx22E
         3247Tz4+37C7DSuV+6WCVajyU7BZGdu1ZxDg9uUN5ke20TwyAKXpclyFFztd02Rsepka
         SdQCh0koPmiREPIsT7bjKFkOLSmrTD5ZD8D5XSrm1gAWQjFqAg+OYV25l0XpicNsGwGz
         hNhzXte9AtuxH79fNn4WxoRxFIrJRMUN/K5JVrMebzm/SrsqpMTn5rbMQ6o6ANA97yPd
         jR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVG8aKTSFzNHwCXe3wHZt0HXAgD95pvdpf79Vmy0RV0OWx3dxv9jPYxYUlQCg1SV0at48X/uK0jA9izDcqkBghXxWUPgHtZQ4DresejMetLgBA840z6kgcd0h7jCm4XBlLbv/TxA+QL
X-Gm-Message-State: AOJu0YxZJ2IkxNTNvMTHYrXx1e1DKYXv1zEXIizGHsDfpDvJHd1/zSTR
	LXnyLDI/0x0af4CBOMgc6YD51rQsGv5t2Bx1EBZNdPhy/MrEHpxA
X-Google-Smtp-Source: AGHT+IG2ztbx61XE3BW9qucN0c7VQTXpTloWyv04BLVHESTxauojVdBkZLqongwr3D4sNTKcCiEx+Q==
X-Received: by 2002:a05:6a21:3393:b0:1c2:8d22:c6a6 with SMTP id adf61e73a8af0-1c2982158c3mr18450799637.8.1721009204746;
        Sun, 14 Jul 2024 19:06:44 -0700 (PDT)
Received: from embed-PC.. ([122.183.46.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc270f0sm29267445ad.131.2024.07.14.19.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 19:06:44 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	christophe.jaillet@wanadoo.fr,
	Chris.Wulff@biamp.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: u_audio: Use C99 syntax for array initializers
Date: Mon, 15 Jul 2024 07:36:34 +0530
Message-Id: <20240715020634.876011-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert array initializers to C99 syntax by adding the '=' after each
designated initializer. This change resolves warnings from smatch
about obsolete array initializers.

drivers/usb/gadget/function/u_audio.c:1117:20:
warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1124:28:
warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1131:19:
warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1138:27:
warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1145:25:
warning: obsolete array initializer, use C99 syntax

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 89af0feb7512..47a1990743d8 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1114,35 +1114,35 @@ static int u_audio_rate_get(struct snd_kcontrol *kcontrol,
 }
 
 static struct snd_kcontrol_new u_audio_controls[]  = {
-  [UAC_FBACK_CTRL] {
+[UAC_FBACK_CTRL] = {
     .iface =        SNDRV_CTL_ELEM_IFACE_PCM,
     .name =         "Capture Pitch 1000000",
     .info =         u_audio_pitch_info,
     .get =          u_audio_pitch_get,
     .put =          u_audio_pitch_put,
   },
-	[UAC_P_PITCH_CTRL] {
+	[UAC_P_PITCH_CTRL] = {
 		.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
 		.name =         "Playback Pitch 1000000",
 		.info =         u_audio_pitch_info,
 		.get =          u_audio_pitch_get,
 		.put =          u_audio_pitch_put,
 	},
-  [UAC_MUTE_CTRL] {
+[UAC_MUTE_CTRL] = {
 		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name =		"", /* will be filled later */
 		.info =		u_audio_mute_info,
 		.get =		u_audio_mute_get,
 		.put =		u_audio_mute_put,
 	},
-	[UAC_VOLUME_CTRL] {
+	[UAC_VOLUME_CTRL] = {
 		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name =		"", /* will be filled later */
 		.info =		u_audio_volume_info,
 		.get =		u_audio_volume_get,
 		.put =		u_audio_volume_put,
 	},
-	[UAC_RATE_CTRL] {
+	[UAC_RATE_CTRL] = {
 		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 		.name =		"", /* will be filled later */
 		.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
-- 
2.34.1


