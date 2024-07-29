Return-Path: <linux-kernel+bounces-265113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5C93ECBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C31C2151A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1F80BF7;
	Mon, 29 Jul 2024 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkXAtN2+"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830F1E49E;
	Mon, 29 Jul 2024 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228844; cv=none; b=VHm5YK09nAULw0IgMoEmKOo8JEO+MPHWK4nB56sOt74JWUV8tqoJ4seITQOAyq3S5Ud+plQEvchg4nqH/p8zyN7r8keSsa20BgAZxXjjRbmzl/wm7NyG3+BZpQuHZQxeXc1CWZ8PgypC11oogYLQbMXaMNw6jJOWf/XVkyPp52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228844; c=relaxed/simple;
	bh=YQY1+EGmU6p1BXm+sXTRYrXdxhhszFQMSs/lDvue4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaieFZ4IZH+F36hqKdGSW3Ij5qdhQSxbeNNtRFyEsC7caFRzlEHdbZ6ZmHNiFemYEiocNkoKuBbSsp69whReqb/sxOiDRRAEV/IBhrB/c15N+x2Nm09zR2ks9PLROGCrPEGVk6ZzOk6RkNmnFgsZ6HUTBr4BbBqDpRXyEeehvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkXAtN2+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5e1c86b83so749344eaf.3;
        Sun, 28 Jul 2024 21:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722228842; x=1722833642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkLKEA2633f1HunNS4eFBTixQIza2jM4pjLFo7cmpNk=;
        b=kkXAtN2+J43aJXno25DIoW2diZo9Au+U8/fOVq/9VwmVIwAK+qu3kAbHy0qAT0D0Kp
         0DlkENo7F73mP1or/Evh0uWLx/eEU6CRf19ng1J9BZioejfLglnRvZWvultcMSPcKaVJ
         dVQ2mY+C3Ds0N8QylbHI4UTMjvJztvMjge2XvRalOHtJogPam5Lio/gq1vf1ooKy+26e
         dUybwiyq+iarL348JRRWYnrCmFrOSS0hIyS6F3dTxZJyebNBVrVu0dRsyg/UrOMY+RkU
         +dTvtHeIB8eh/SmuaSovvMAT8kLgFJ3zYAhwbQGOw/WhKSrPIajVUaWM8M7uzE5wiAsY
         1Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228842; x=1722833642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkLKEA2633f1HunNS4eFBTixQIza2jM4pjLFo7cmpNk=;
        b=XBA0ssD5wARn/D+MyS38KQ+fw/T1wRqGFYbAdEeuOkgGDdtxxbcO/MSCQSO88vkn6I
         xOIjthB09nO2CR0Pww0Hvx0U09c1PUyegcayzvYoxQGhpF18EETHZzBbExyAB34H1wG+
         kp8gwUVJp8sW5GAlGrbpVDGYOf6A/7TBllZkvyT2j++y3k61Kl3jjbpmay2nIh/BwODy
         vWtuUJg8y/5eD8t2Oicx5jMSFGd5awNDTrlcniF4zAPfkWxCiv3+XEKehPm+FEIWBxnJ
         g6D3Y5rioJfVTUAy9qePFd9qHjoxpxANPQnGyp0pUhSxfcKQzBV1BipI7TRihf2cJct0
         OF8w==
X-Forwarded-Encrypted: i=1; AJvYcCWkLOPi2Y08JxaJNhgCRcNz8z0viD1R9aR2Vv6j3qMCEZIyKZ+I3C5uM1lKQ13KOKgfPIo1q6PDf9+ClM7xV9IKmP2MpbhzwughAV3aTW+t6iVQe5tamhJDl0fG1rtmwiUkxD5mQktErUI=
X-Gm-Message-State: AOJu0YwXPgRdbXaOcOs0vyQylvChFTG/fdpsBzXO9/FKLYK63dSLrSmm
	nUW/AtphIb3oRO6rImd9Ad0PeIig6JOvSuQbRh9U/t+MQXxzV/Jh
X-Google-Smtp-Source: AGHT+IHEL5mooUHNR8rrOyElAG+ahbJQ3FyX/143GslHAxjurwtu/L4Sx3VSu5n4H1ILdC3gmNi99A==
X-Received: by 2002:a05:6820:2292:b0:5c6:658c:a9f6 with SMTP id 006d021491bc7-5d5d0d86e0fmr7488061eaf.2.1722228842070;
        Sun, 28 Jul 2024 21:54:02 -0700 (PDT)
Received: from localhost.localdomain ([189.172.173.208])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5b369464fsm1046623eaf.45.2024.07.28.21.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 21:54:01 -0700 (PDT)
From: Bruno Ancona <brunoanconasala@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bruno Ancona <brunoanconasala@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Support mic on HP 14-em0002la
Date: Sun, 28 Jul 2024 22:50:32 -0600
Message-ID: <20240729045032.223230-1-brunoanconasala@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the internal microphone for HP 14-em0002la laptop using
a quirk entry.

Signed-off-by: Bruno Ancona <brunoanconasala@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1769e07e83dc..f4bbfffe9fcb 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -423,6 +423,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B27"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.45.2


