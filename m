Return-Path: <linux-kernel+bounces-271772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FC945318
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AFBB21FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF41494A5;
	Thu,  1 Aug 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRoPHVoQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5D1E4A6;
	Thu,  1 Aug 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538942; cv=none; b=X/938SEt1/e0TWEZmxXSjfyd+Pb4rJjwA0yx8oeYBJSgRhSZs5uqykKq11h3YoawA4REDAp0kPKBnL4AWjZTuaPu/8Q17nWLrx5EE7yxReXBinNCU1oz5PxfwS+U5o3ANkGVr6kbH0NuMkZ1gf2rMhF+N4njEED6GTOx66MxgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538942; c=relaxed/simple;
	bh=JBYcDTXUAZ7GtFBzcyrKR/jFyrcvkCzGC4wrJZMnvQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OloixFj5tdsAl3CRo+izNjJJL/mDOBCi/OfD4Zh1j8tqK+7xv2Y9AfZFe4bZ8ci3Ug0Gv6on6VCL5FxyS36TcoSNiuCphPaPvnvoxmaIr+OW8MnrjH+pouXum+b3dE2+rdFR8e3uT36dl6W8gUm7nzvKyQh2x7OywPXlNnON/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRoPHVoQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc692abba4so55214625ad.2;
        Thu, 01 Aug 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722538941; x=1723143741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djnV/nh6PubGFMg/Dfw7gNGcoLDjNtVsYJrXgxDiDzU=;
        b=aRoPHVoQMEQqxICEwFcUJahj0Fmq/GzB8YLddMzwSuIg8oWLZbf8jwS3etQsz+mutK
         ZefwZ3aUtsGz8ClIZ27ak3+YOcwarHXrHqT51GWKRrG4Aqvm/Xy9wRi9d3zf6yN6dlOn
         F1gAY8tP2VpP+twPdf4CIvx9CmylhPZ18pO48gO3CSP5Pb0Q26gJR9yCsdt7LOw+LGPN
         sK3syFBSsC48TMspjGT/E7vgi8txE06qluuZ41hRv1g4gepOAlqRsHdFNtykyd+Jun9x
         vdCHk1UHWpIg/Well2xgW1c0UGn2C7VP3wXqpeHLtz8b7LFexUn7q3dsOrdBIfxWOWzO
         wysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538941; x=1723143741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djnV/nh6PubGFMg/Dfw7gNGcoLDjNtVsYJrXgxDiDzU=;
        b=iFcYvRoAHbuAbYcChvPawMXrSI10bMSqD4SgeRDigbliY4V86Dhc5SjKl7GAv75QiC
         X0q7NNFhrr+GXG2ZNXzH7RJOIW7vkWohBEHampQY4xMnHIexXiUYcPEE64LEWPwBln5m
         ONe1v9GdpAmLKrb1F/F9cy45LIrLKqvEHNAcXhNfCnC7Dp0URCYfkRcEEgGFUWCpeVWB
         qDSOWMMkDvYhHbFROGGZu6VyQNE3U9El+zYldL2UEQGQO0ICLXLpWfV0SwmzmhsfM+V3
         g9VVLcR8CNHzs+1gVSWWIYGqEpJ85jTXV8VLW+Z6lo8nKixT9KyC7EV0JdX3T6T1NuTX
         WNkw==
X-Forwarded-Encrypted: i=1; AJvYcCXpU6yG7plO3dfRGwkgI+OBW73k6R+ovtifzhPUTcaBGv0bszjuATvbzXTKnjhoGguzVNtFE2KIsOgGFpLrdSZyvLGgC0iwAjvtvy6mGtQn5CTlSkCkXEcIHk9F2QX/Lc+Fu0zs5lmZ
X-Gm-Message-State: AOJu0YzpfLeuxptEmEWytSb4rVTlfCeCQTiLCaupdU2dUeT/Z9a7WILU
	seupfTLzlxqSVkmdL4m+oyRxyV2N+AHXCtULC+JOwCbO9/kFFOmq
X-Google-Smtp-Source: AGHT+IEjMrueUu0XqT4d5boPbHPBN1hOPXmC681/dUOcxNKgXeGi5+oYbUYMUI/7ToNqPAWYqRl5LQ==
X-Received: by 2002:a17:903:41c9:b0:1fd:70f7:220d with SMTP id d9443c01a7336-1ff57421fd0mr14048625ad.40.1722538940516;
        Thu, 01 Aug 2024 12:02:20 -0700 (PDT)
Received: from embed-PC.. ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176ba2sm2213215ad.209.2024.08.01.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:02:20 -0700 (PDT)
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
Subject: [PATCH v2] usb: gadget: u_audio: Use C99 syntax for array initializers
Date: Fri,  2 Aug 2024 00:32:09 +0530
Message-Id: <20240801190209.500373-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert array initializers to C99 syntax by adding the '=' after
each designated initializer.

Fix the following smatch warnings:

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

Also, fix two checkpatch.pl warnings:

WARNING: please, no spaces at the start of a line
+  [UAC_FBACK_CTRL] = {$

WARNING: please, no spaces at the start of a line
+  [UAC_MUTE_CTRL] = {$

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Wrapped commit log to 75 columns
- Fix checkpatch.pl warnings

 drivers/usb/gadget/function/u_audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 89af0feb7512..0b3b8adf00c0 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1114,35 +1114,35 @@ static int u_audio_rate_get(struct snd_kcontrol *kcontrol,
 }

 static struct snd_kcontrol_new u_audio_controls[]  = {
-  [UAC_FBACK_CTRL] {
+	[UAC_FBACK_CTRL] = {
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
+	[UAC_MUTE_CTRL] = {
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


