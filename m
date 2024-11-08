Return-Path: <linux-kernel+bounces-402255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E19C2582
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B3A2840BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394FC1AA1DD;
	Fri,  8 Nov 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+uZvfkg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38165233D6B;
	Fri,  8 Nov 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093861; cv=none; b=KkzXx8YzMLQk2PDLIjgRezQjSPKp9JbzQeWI5QdAj/5W8waI84tV/HXUM4JTt0xLODjGImYr0ee+QOV9eDwmX/QQZHWtA8uGkhyXELsNM5hYXRW52++TXhVy9yxP8DYLxZhnFDHbo6i3l5VqrMhNvSOfCAsmvLaKlbAUzupfSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093861; c=relaxed/simple;
	bh=q7ZGc479MBZttina+0alFRyr7wMWF7vN9ddJwSh5FQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tbyxk/OwqqjtLITJDc74WXFpHsZ93HbQ1Z0JhQwMUDokAb/x2nuHDDhExzPDI9qmVhRUjiiAcT2fSTY5ulG/LSPbZ5SMVqTP2sABuP1Zcz7I7AzlGNm4xugMQYCWuiFDO47JLM/3ZBBW0GCjCGgF0r8PnMzO01zbmWdH6uIf+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+uZvfkg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdbe608b3so27357455ad.1;
        Fri, 08 Nov 2024 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731093859; x=1731698659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKffIyY/7SmCgWnQq0g1achquWKvPHPvVC9LDZIXaco=;
        b=c+uZvfkgQvxWg8Q5pNavLZUQ4UFfBuaXqJdmFarE0zLgLs1rmBRxvoU7BS2Xb9qayM
         XpOecL6pjpAHJuERJV0VDv2JP5xulz1twiQtqf50pMABZ9vq/ArOp8J2bkM1vi65yn0J
         Atugx3q1ib+5eWsaygbGtDGutBfVPUuTeV5kTuQkVtpOecoVVU3qoGQOc7/WPv7uhjbq
         DxGmqMmd3j+HfSbD+G44it6n6hI13WTz0+PxIN7fKJhhFYd6zAolRXe0CnliX37lXq41
         TJ8Mm4X70scdSeLj7LcrE2zs8QXP6ADN29D3y/pnPhQiyT0YvGsMzOuSpxu63UnYUB6z
         C6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093859; x=1731698659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKffIyY/7SmCgWnQq0g1achquWKvPHPvVC9LDZIXaco=;
        b=M3usNm0j+KIr8x+blI0pOEyWqSftrhmcc1RxNVm5xVAvb4jWVYAq5tnpDqp6NrQGfe
         pXptk5wZ+SU44ag9JsJIm4EWV6RtHN7r6Wix3YK4T30CjVyNvMgdCLst+bZexne3acQd
         HRm/EKASWavLawj677QP/iKU0+/6PhFsPGJvoqp+OdNKfsbUxmpfVtgx+LYGe5l7cN8R
         GDry+C1PhF0eVcFL9faSOU0imiP/1gd7bt9JXULvuRbugnNerCA5Oz3WrKcLQiS9htgN
         f8XLyEQpb/sCoAUkSwxfipOdUBzFW7xSr/4maG4W1nd+JlGj3ISihTeTgmyVDT+rCvlV
         yAOA==
X-Forwarded-Encrypted: i=1; AJvYcCWjfGWJQ9d70Sra+hLrianpj5HFWoglgvbJWyDhXA+rJie9oMkgTK0H7BsGUATJoW+wtBXWGr5WQDqRLQI=@vger.kernel.org, AJvYcCXZaMNh+PUaWPkYEyUkDPQYhWYUOUlC+OdN8+0bmHtMCNu7lQ59nfhFFPOLH695BxVoYRMLgDqZM1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXXYC5umiXEnztdugiyLqWCsQiiqCuRd01rgvz4CZ3i9a6+E1
	czStrGhDRN0DiMPiJex8Zd8sQl3nSUTgM9/ewyndTuzqHJfsCz2r
X-Google-Smtp-Source: AGHT+IE0z1FmBOzuFCLw52ovVQ929MNg2h9xmryrk7fwh1O7hQFkHO1QBimB1K/uw3LdP75j8JlZJw==
X-Received: by 2002:a17:902:d4cc:b0:211:6b21:5a87 with SMTP id d9443c01a7336-2118360bcccmr40431895ad.56.1731093859417;
        Fri, 08 Nov 2024 11:24:19 -0800 (PST)
Received: from localhost.localdomain ([12.17.209.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177de0453sm34594105ad.107.2024.11.08.11.24.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 11:24:18 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V2] ALSA: machine: update documentation
Date: Fri,  8 Nov 2024 11:24:13 -0800
Message-Id: <20241108192413.10751-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Added clocking details.
2. Updated ways to register the dai's
3. Bit more detail about card registration details.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
V2:
  took care of comments from bagas related to underline
  and making macro as literal code block

 Documentation/sound/soc/machine.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/machine.rst
index 515c9444deaf..9c8e006b1e50 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -71,6 +71,18 @@ struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 	.ops = &corgi_ops,
   };
 
+In the above struct, dai’s are registered using names but you can pass
+either dai name or device tree node but not both. Also, names used here
+for cpu/codec/platform dais should be globally unique.
+
+Additionaly below example macro can be used to register cpu, codec and
+platform dai::
+
+SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
 struct snd_soc_card then sets up the machine with its DAIs. e.g.
 ::
 
@@ -81,6 +93,10 @@ struct snd_soc_card then sets up the machine with its DAIs. e.g.
 	.num_links = 1,
   };
 
+Following this, ``devm_snd_soc_register_card`` can be used to register
+the sound card. During the registration, the individual components
+such as the codec, CPU, and platform are probed. If all these components
+are successfully probed, the sound card gets registered.
 
 Machine Power Map
 -----------------
@@ -95,3 +111,13 @@ Machine Controls
 ----------------
 
 Machine specific audio mixer controls can be added in the DAI init function.
+
+
+Clocking Controls
+—----------------
+
+As previously noted, clock configuration is handled within the machine driver.
+For details on the clock APIs that the machine driver can utilize for
+setup, please refer to Documentation/sound/soc/clocking.rst. However, the
+callback needs to be registered by the CPU/Codec/Platform drivers to configure
+the clocks that is needed for the corresponding device operation.
-- 
2.39.3 (Apple Git-146)


