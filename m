Return-Path: <linux-kernel+bounces-518866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95533A39597
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA43ABBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696222B8C7;
	Tue, 18 Feb 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBI0lgny"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE222B5B5;
	Tue, 18 Feb 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867759; cv=none; b=B7RPv+5TschB4Y/cudasCGvkZu+IqpBMOqNEIZ7qsc4dVODif7Tt1FWwwb3TtX4S6Q8LXijlQOKNnuK3McPQjidT/9XKWo/ysdpPrrc1qNb0tc5BCeHNg01aXftjGnhWa48fnktZZvfMYH41MsdJqwvfg47IuRuUqNV8p05QuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867759; c=relaxed/simple;
	bh=sFfR4eIGWeqHKx7p9Z7iGt8U9lbfIZhokJqUsiq2T+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c4wZpni1u+DnBF+2h8omPUsiiWcPSeC4Ow9U/D2cyUww+G1tiFSXp/JfsgfBfbBlrxk3WmsgN6hI4SHGmvNOfXp9MUHrafS7O0o+IlIruMQYyCeH5I7Ds1d4E63Q9zT//0sNV+HZb11ZxmDPkEPur0XIjBmYeIpX7k3gM18zZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBI0lgny; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d601886fso67179155ad.1;
        Tue, 18 Feb 2025 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867755; x=1740472555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UasE+6v+LUcf32VIrcU6EoAVg1auG4g+9EdoM3brOBo=;
        b=RBI0lgny2etZKy14RL4P4jbdcgoq9dJr6uzCT2VVAVhUDWxS1RI6Dp7oKaQxF4B0Mn
         O/MjK1UXmNPPtMSyjkdmDCopD7o/ir5VyJcXv6mRTv12C7F7mVHFVEshYkWKiEWrVucD
         zwHBeZ298EpUYpA92tuzJy8g+fIbYAwDARX+eKJ/FIwt4SXqazP0Rf7rf4xKMTssKYbs
         s7yqph6AHHnzdmGwFwPlmHu8ndgSTzvILIMrnHtQ/WfqKatE+dJdaUmDXQpiU716cPqr
         HCOd34D43MoR+2MmdIDzy5qslBswxOD+3LX4IOCqCXAawW5YO6IOFdzy2tkiWFZNG0YX
         osQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867755; x=1740472555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UasE+6v+LUcf32VIrcU6EoAVg1auG4g+9EdoM3brOBo=;
        b=nN154iNHcjCfizDnHYxjP7r3PEREfOQnFiS5d5uYgnL4byP4uGoEfWuzmhcqfuCtwE
         xC263KQajc14w7JkZX8ht+PPsZBPdRSm4SNBUUijRYK2N9b4d5eXAG/ryEZXh9lB7gAk
         LgJ5WynnZyWnQ8wSVqDLJUjART80mkcSw/oEB/9w7epSpQIItWrviL8f0FgaicXoscq2
         lHf36vFrT4pdmoC0WRtLDAGd/R+4LZi7L9EXs1+iS1fhjIGbcXnta/Ba/WUvp9n9B5MP
         PeEi3ObuYfJqgIzjBAIaQE5h9VUCwFEoZPuTlCGNfQjZqfFCMpq6t02F/3qmfFdTAdeZ
         FeGw==
X-Forwarded-Encrypted: i=1; AJvYcCUq59epElPHa1auVY/8eZUvkVrzCaHwlR9sZDQVj87x20DyfHBLQ8LURczC2GugShGU/2jufIG7cy9D2Bc=@vger.kernel.org, AJvYcCVPDa9kA8CrWuh3PDg6fpCXUoDGVcO9yqzgdi0slySKSB9S6IMhVe+jRivnO6fYbFKNAeH2F/924i8SKiuO@vger.kernel.org, AJvYcCWyXDcX05MS3oD9McMvZ35jVCJHdUjyGeWZxuipAcoSeYDKBrnvCsPHdqyiK8P72UJiVFvDlR2Rxuqe@vger.kernel.org, AJvYcCXGvkpG3Qm7RwFXmqy8Cl5/T+0yD41hZ4r0wu5R5KZgzjF1MIhzCaLte/s3TcvvO95rNFzOr7D2i89EToc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUfkzKohPVe4DvUQxQJJxpYBHaKjBZhIZ/ykaj2IVTpDsBSEb
	SaptPmzHuXT8/SFbqyFtZWB3hZFprbpS/j+Tlo0HvanOMyvY4QA+EgTtvoIc
X-Gm-Gg: ASbGncvU14apvlqwDD8AuoWw9RuQGvE1/1Yao3gIWa1NTxJp5VlBpFH6UOyVw8CO8Z+
	x0AB0tIfWL/PhpaySFGufw+v2A/Wn1P97Ut3n3jrF0iT1nC3PNsOyK4fZ66WAuPA4NlJALNp6AB
	OleCWY+EgtgditLahGyGM3prpz2zcB07ffTBsP347v2sD/LzUsfPbLoJut5tsMZFjAxIIl/Q/30
	QaDncjhFxsq/zRW69vP1uxX8FTj3Qk60iMGT4lN5ON0HOlbVHsTc1wUBXBxXMouWdEw0cmZeDe8
	lOErEOdnCAOz7Mnl3pjISckTwL992FBNHbis2QvOg4V6IR5ziI7LBGPf2Kgj4AB6opzDM6QG5AR
	TcroYqUpu4A==
X-Google-Smtp-Source: AGHT+IFTu0Jt5oOB7cldX3rIsFRKzoyx1f3pziHi+TW8B5xeOECKaq3mlWTAmJ4KLKYw1e8wd/mIAA==
X-Received: by 2002:a62:b403:0:b0:732:6221:edea with SMTP id d2e1a72fcca58-7326221ee7dmr17780715b3a.3.1739867755169;
        Tue, 18 Feb 2025 00:35:55 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:35:54 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH v2 00/29] ASoC: tas27{64,70}: improve support for Apple
 codec variants
Date: Tue, 18 Feb 2025 18:35:34 +1000
Message-Id: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFZGtGcC/22NwQ6CMBBEf4Xs2TV0pTV48j8MB2hX2ARo0xqiI
 fy7FePN45vMvFkhcRROcClWiLxIEj9noEMBdmjnnlFcZqCSdEmqwjaEkdF6xxa/jYSGjTbOKqb
 KQV6GyHd57tZbk3mQ9PDxtZ8s6pP+fPqvb1FY4plO2tQdqU7V135qZTxaP0GzbdsbcCaiMrYAA
 AA=
X-Change-ID: 20250214-apple-codec-changes-6e656dc1e24d
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3697;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=sFfR4eIGWeqHKx7p9Z7iGt8U9lbfIZhokJqUsiq2T+U=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OJnzm4P15/epLjK71BgXt5frehfYvNXmwapilpNS
 Tiw7fyGjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACay4jkjw53uyNUXn0iEmcfq
 8YhF9yi8MQ+XPiPnrd9ycd6aF0yu6owMM9dVnehcscPowLvZ38qUylk3fQniTZZIfXB/sceZ9Cv
 nmQA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Hi all,

This series introduces a number of changes to the drivers for
the Texas Instruments TAS2764 and TAS2770 amplifiers in order to
introduce (and improve in the case of TAS2770) support for the
variants of these amps found in Apple Silicon Macs.

Apple's variant of TAS2764 is known as SN012776, and as always with
Apple is a subtly incompatible variant with a number of quirks. It
is not publicly available. The TAS2770 variant is known as TAS5770L,
and does not require incompatible handling.

Much as with the Cirrus codec patches, I do not
expect that we will get any official acknowledgement that these parts
exist from TI, however I would be delighted to be proven wrong.

This series has been living in the downstream Asahi kernel tree[1]
for over two years, and has been tested by many thousands of users
by this point[2].

[1] https://github.com/AsahiLinux/linux/tree/asahi-wip
[2] https://stats.asahilinux.org/

---
Changes in v2:
- Changed author field of patch to match Martin's Signed-off-by
- Added Neal's Reviewed-by to reviewed patches
- Moved fixes to existing code to the top of the series
- Removed tas2764's explicit dependency on OF
- Removed complicated single-use tas2764 quirks macro and replaced with
  if block
- Added hwmon interface for codec die temp
- Fixed a malformed commit message
- Link to v1: https://lore.kernel.org/r/20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com

---
Hector Martin (14):
      ASoC: tas2764: Fix power control mask
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Enable main IRQs
      ASoC: tas2764: Power up/down amp on mute ops
      ASoC: tas2764: Add SDZ regulator
      ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
      ASoC: tas2764: Mark SW_RESET as volatile
      ASoC: tas2764: Wait for ramp-down after shutdown
      ASoC: tas2770: Add SDZ regulator
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
      ASoC: tas2770: Add zero-fill and pull-down controls
      ASoC: tas2770: Support setting the PDM TX slot
      ASoC: tas2764: Set the SDOUT polarity correctly
      ASoC: tas2770: Set the SDOUT polarity correctly

James Calligeros (4):
      ASoC: dt-bindings: tas27xx: add compatible for SN012776
      ASoC: dt-bindings: tas2770: add compatible for TAS5770L
      ASoC: tas2770: expose die temp to hwmon
      ASoC: tas2764: expose die temp to hwmon

Martin Povišer (11):
      ASoC: tas2764: Extend driver to SN012776
      ASoC: tas2764: Add control concerning overcurrent events
      ASoC: tas2770: Factor out set_ivsense_slots
      ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic
      ASoC: tas2764: Reinit cache on part reset
      ASoC: tas2764: Configure zeroing of SDOUT slots
      ASoC: tas2764: Apply Apple quirks
      ASoC: tas2764: Raise regmap range maximum
      ASoC: tas2770: Export 'die_temp' to sysfs
      ASoC: tas2764: Export 'die_temp' to sysfs
      ASoC: tas2764: Crop SDOUT zero-out mask based on BCLK ratio

 .../bindings/sound/ti,tas2770.yaml       |   1 +
 .../bindings/sound/ti,tas27xx.yaml       |   1 +
 sound/soc/codecs/tas2764-quirks.h        | 180 ++++++++++++
 sound/soc/codecs/tas2764.c               | 368 ++++++++++++++++++++++---
 sound/soc/codecs/tas2764.h               |  29 +-
 sound/soc/codecs/tas2770.c               | 333 ++++++++++++++++++----
 sound/soc/codecs/tas2770.h               |  20 ++
 7 files changed, 839 insertions(+), 93 deletions(-)
---
base-commit: cc7708ae5e2aab296203fcec774695fc9d995f48
change-id: 20250214-apple-codec-changes-6e656dc1e24d

Best regards,
-- 
James Calligeros <jcalligeros99@gmail.com>


