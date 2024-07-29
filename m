Return-Path: <linux-kernel+bounces-266218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452E93FC97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41A51F22E23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374B1741C6;
	Mon, 29 Jul 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK8gALIu"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAA15ECCD;
	Mon, 29 Jul 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275211; cv=none; b=aJf6GyBndIqoCsB711ImTnd2HOIZ9rXFMXxJnGAWlT5CiVMvKk0iJcRiHN/VswHgeyp07T0+6j70asmHTrH4YBNhjGXrHD0I0mBuf1/+hJMCIxUAxO202NY8l5xZSpKkgBjnmtI3FJmxLYj3ZbePlgI4fZV5LribwYMaQ1c0Sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275211; c=relaxed/simple;
	bh=NHpWIQMM4KnFG3Grot6gzP7D8MYKTYzIjdAEdp8aiCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lma0TO8HwKo2qFV9yJhd4jqNSggaCwfEGUd197Fk6y1EZX2nEogXrv0+hXM/f0CKnpLQBG6UzQNHdP/kvQGhzSPYoIKnObQanZGfi2axy+4/rf3wC3fkQqR9YhMJ3ga+JYdZVL2/Njw1Mlw7ApC0Vu5Je0UCb99XRfjnBJphm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK8gALIu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc611a0f8cso21576165ad.2;
        Mon, 29 Jul 2024 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275209; x=1722880009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDMRENFOTmb9Quk1ZGoV/8u9O28UUgs55EcrP9/qbI0=;
        b=PK8gALIufO64Gz7K85iPw7Dd5rzk7h+CzonqHFJM6MjW7fkoqzTvJIU/touuZurXqX
         oKfpM9oYAqoZIiQKQgjiHvv8xdazlojccfDQeNRnHmxPviylLr9QFhnZOKKdpjK/YX/P
         6a184OWkKgfpRdGeedfJalJk0DWipLC+hYl6gaxah1yrNw+ILvg9Z7o6IdXYNnjD9h3O
         AvceEU0jW8rl3KsSz7eaxewQoiVC6Ev4PuyjTxp7BIZ/zZGycBbOSDs9vNV+nCCv3J6y
         HCYyxrL9EmyK8yaD0irxZ7AC46MBA+rT2lmsToAd12G5JZlxYEscMtt8Ben1bknYrT4v
         /88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275209; x=1722880009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDMRENFOTmb9Quk1ZGoV/8u9O28UUgs55EcrP9/qbI0=;
        b=Cfc6Vc1Ju8bYvKoEUCJSGMGrwWnLuETqv70nrBhl+23lnSscTs7Zch7qLXTVHGL0Kk
         SBzGnZGTEdrQYvvHPZIZdq7GzGm531Jez8diF9h4K0+JD6L04n3u6fuScwv9pDODHDC1
         5FCDYsV09HgWVWwFgReL7j9qaZ3on5u0++F3j4fn2OzDsPl1cLmcoF9q3SAgwENrjei/
         /2XqZhTmxpQUpE/aIe/2IEko9jHOesNr55WIY1pPBb7Z1Rj/tVIDaM9oVWTXry89hity
         iRI1tRap8+vBX2+bvf6yja/kyAK0Di9T7JYggYDnMxGfffTTTYIXZEJqah0lHPVAAn2A
         0rVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy77yG3kESoZ7jNrQRHeoEublOReKt4UcVci+q7UZyJM1EBRnItvjlHy0Mah1RK4wjdCPxrl1+UYh8IftV20aWcEMUcyISARYx+P5lQnLX3bIXPSvptZXGnR5qC1R9fphz7m3GLrgR
X-Gm-Message-State: AOJu0YxFF7dJ4QIptiy/Y4u+8Ur2QoqR8+9H6fsPGf5t7oI1ISGEaP+T
	nphiKt8DSGsk5WSP+03HTt3zAWo8ZrNsQJ8FYBnuS9ht0Qgld/vI
X-Google-Smtp-Source: AGHT+IEPbuRb9okWNmz2XKujzM6ZvOBYpgEojc8nnMdhbjBvhCURiHt9M80et6ldWMjh9rgb8Vlw2Q==
X-Received: by 2002:a17:903:2446:b0:1fd:6848:bc2d with SMTP id d9443c01a7336-1ff04810ffcmr65874485ad.20.1722275209046;
        Mon, 29 Jul 2024 10:46:49 -0700 (PDT)
Received: from embed-PC.. ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d28d4dsm85991045ad.101.2024.07.29.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:46:48 -0700 (PDT)
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
Date: Mon, 29 Jul 2024 23:16:39 +0530
Message-Id: <20240729174639.446105-1-abhishektamboli9@gmail.com>
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

drivers/usb/gadget/function/u_audio.c:1117:20:warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1124:28:warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1131:19:warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1138:27:warning: obsolete array initializer, use C99 syntax
drivers/usb/gadget/function/u_audio.c:1145:25:warning: obsolete array initializer, use C99 syntax

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


