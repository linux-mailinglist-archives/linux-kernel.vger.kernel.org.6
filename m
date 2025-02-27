Return-Path: <linux-kernel+bounces-536228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F25A47D03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864023B0F19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243A22B8D6;
	Thu, 27 Feb 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpQRU2F0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73A101FF;
	Thu, 27 Feb 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658134; cv=none; b=TeKCiQbWZgacXOiAXVoFxTM10PsK9ByFTyJ4bPAntJ6AhDCOOL919QiuWvwam30Nsz9xTS4h8vUAAuACe5DYEcbSVglAlDOw+7IGJHC6bE+QzCLEOs+0KFQlQ5D530kAIuK2hU9kSIOMTxv1A22mPA7drvx5d3UHuU39fssskLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658134; c=relaxed/simple;
	bh=tql2RO8GL3XbRYzLyF10LrmaUQUmVqAYtQm0jp7XazI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rhKg1jC6v061UMcWYH1X9X6nsT99xPYUOZrTB45OciNypcOj9zciSqcKTUgw5DbFSItArGqSI/39ZTKMQCnx0dpIZaa/T9Jrtp20xLnUm3pSW4yloSaefRfuLuTUBYuuI72j6psizVtUr4t67tGlKSbjSnKXxOObNeL6H9qn2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpQRU2F0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22185cddbffso33975675ad.1;
        Thu, 27 Feb 2025 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658132; x=1741262932; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgXAyWJlzyUT7W8oT86LCqJbT092n3CAES1oCH+us9Q=;
        b=bpQRU2F02KYDVnGeSXRBP1K9d0T+jI8c2B7ZvDbGsjHfhiTPh254HLopUzbBdQQmtg
         oOiYpik6txxfpJx+uwC9BqYSH9DWRHq0fIDjWKGFd8TklUbCYiBkuSXi0LbWeN2Ut2Dp
         NCNYfAX6LuvydRsgOlPh9r/s8Vjukw4BNkev//ivNLZClXNgjHclr3hC5M27PH3xwPJk
         TOeASV6R5BWZ1JR7QAOFk5Iqsx69zRrUKfA09z64SO6/7g841ituEsmtsuCs5MP0gyJv
         gnka00WaAgZBozK/UR/XHK+V7Nsq5iD6OudjaL1aOKHgvQT5HA8q6vKo9pM0sVKS1czr
         ti0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658132; x=1741262932;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgXAyWJlzyUT7W8oT86LCqJbT092n3CAES1oCH+us9Q=;
        b=GUwg1MMWfFtWtQINB3t0j7afqPOyjzY4g065DwImJdwUQXPM2W9x7ffM2DMJupa3lJ
         nvlhOtzcLCWDIyQoDpLpd872Z90Tztjq1N2HkRjvZqdMsJOHPG5+MXrnm13WPEF/2HB/
         5W2owHeOzp/T3jmhz4NIzX5tZurHg9fqgZ4Zz+I+7GBqjXBoMml5HJrp7jI/5g4SEzKr
         aqJNnbERIAfwrMm+zluSe7dv0qcKd9P3yY3HXIa/MnebA2ohXnA0Mksu09UEhIBW0orW
         Rq+gFfmG0HqzuVv47wJK8vhNXp98LyVnvq2rI4FCrObWNgbBAjZ5haJN4yaLwFWT5yQY
         A8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV5EdCD4WZ2+akNLuP5MD7XcCoz1iq6vyJ2DX2PyrkauCbXGsq6UaZ0RGpaNXPSC9yoG3iem9P9vFUqhn0=@vger.kernel.org, AJvYcCWjxAai77jDy2ukAyV225vsC+9dD33DqjuL92gGJ4te+dmC34Q2/O96GMpx2rLbR9SQxMoKIOJGdjLLDe+Q@vger.kernel.org, AJvYcCXBZuTiutEC3ngL+Y19gi8vW+poWvwukcStge+iWBpwk02eZNAeTj/Efs0YOQRyIdsg3Oqvh3u/8eGY@vger.kernel.org, AJvYcCXUyp3RWDhUwdgP00KXtU4SZB9htcC2d9wwqgU/DxU4VGlbB6T/XZ4Ydm/4k9O2f2VTsOr2dk7XExxzRRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBqknXz1MECn9duYd4KBISr/VnfKerK75puZp/r69nKZvegle
	A1e03wT1OnHIUCbcQjGkg8IPbGrj12oUIvtQqPQlVj0uLqAcnPIr
X-Gm-Gg: ASbGncsCDK9KeqOiOHUev1VX7C+mgckzDEFP6NK+aMl1thRfhj/jg+FQEA2vxEpLCd/
	yz476kxQ/cHAoJ6TT13io2K1L44k7+/+FHWQnBX1PvCWO7L+MfF/AoWkmbA/Y+Jxdvxjca0U3sF
	3oDsQxvrc10IxrCBUrdsqXLl2t8IM0o0MAjdKCheWjt/+0S11l+tTbP39tyhydB7IqBUDEn5PkI
	0zEnJf2nz8j90p1V4qqWY88Ae0FL+NZALW/CG+Wkzylla8/dxsPrzRlnYYsu23OgPPtf0DAQ8Jb
	one/eZBUb2eFPd2mSBjPX7gpLJJw7nchcqpR3BbPToBWz2mb29HtRcrg4oG2KjTj61A7JLKSxzO
	DkHPsoJDcW/ouGRmNSXBi
X-Google-Smtp-Source: AGHT+IGpG3aYl9HWsQOldqhSuN29J84k9WJc0IYy7wzLeHC+7iHr1iy3v7s+wPTT3I+3pe465wAJnA==
X-Received: by 2002:a05:6a21:6f0c:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2e39188d3mr5135935637.19.1740658131652;
        Thu, 27 Feb 2025 04:08:51 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:08:51 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH v3 00/20] ASoC: tas27{64,70}: improve support for Apple
 codec variants
Date: Thu, 27 Feb 2025 22:07:27 +1000
Message-Id: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH9VwGcC/23NwQ6DIAyA4VcxnMcCVWB62nssOyhUJVExsJAtx
 ncfuizx4PFv2q8LCegtBlJlC/EYbbBuSpFfMqL7euqQWpOaAAPBgBe0nucBqXYGNf1tBCpRCmk
 0RygMSZezx9a+d/XxTN3b8HL+sz+JfJv+PXHqRU4ZVZALWTbAG17eu7G2w1W7kWxehKNxOzcgG
 WUOSrLWKGTqaKzr+gVhtMHr+gAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=tql2RO8GL3XbRYzLyF10LrmaUQUmVqAYtQm0jp7XazI=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk84PxRvSj/f26TnMf3zq6hn/pu8Jhf+/um1Z1Pnv
 JNnmAVmdJSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCRrAxGhs6n81dO2fhCyOrF
 IYNyV3fWPwpLSmKXdHeuXqIZqX7m0iqGf1o8rpKShxfdM+A5V2x3RICdK+qU5izu3+ymgTl/L2p
 fYAIA
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
Changes in v3:
- Add Rob's Acked-by to Devicetree compatible additions
- Dropped cherry-picked patches
- Droped abuse of regulator API
- Droped bespoke sysfs interface
- Rationalised temperature reading for hwmon interface
- Set SN012776 device ID with OF match data
- Changed probe ops reliant on device ID to case/switch statement
- Added documentation for new Devicetree properties
- Improved a number of poor quality commit messages
- Documented behaviour of die temperature ADC
- Link to v2: https://lore.kernel.org/r/20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com

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
Hector Martin (5):
      ASoC: tas2764: Enable main IRQs
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
      ASoC: tas2770: Add zero-fill and pull-down controls
      ASoC: tas2770: Support setting the PDM TX slot
      ASoC: tas2770: Set the SDOUT polarity correctly

James Calligeros (6):
      ASoC: dt-bindings: tas27xx: add compatible for SN012776
      ASoC: dt-bindings: tas2770: add compatible for TAS5770L
      ASoC: dt-bindings: tas27xx: document ti,sdout-force-zero-mask property
      ASoC: tas2770: expose die temp to hwmon
      ASoC: tas2764: expose die temp to hwmon
      ASoC: dt-bindings: tas2770: add flags for SDOUT pulldown and zero-fill

Martin Povišer (9):
      ASoC: tas2764: Extend driver to SN012776
      ASoC: tas2764: Add control concerning overcurrent events
      ASoC: tas2770: Factor out set_ivsense_slots
      ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic
      ASoC: tas2764: Reinit cache on part reset
      ASoC: tas2764: Configure zeroing of SDOUT slots
      ASoC: tas2764: Apply Apple quirks
      ASoC: tas2764: Raise regmap range maximum
      ASoC: tas2764: Crop SDOUT zero-out mask based on BCLK ratio

 .../bindings/sound/ti,tas2770.yaml       |  13 ++
 .../bindings/sound/ti,tas27xx.yaml       |   5 +
 sound/soc/codecs/tas2764-quirks.h        | 180 +++++++++++++++++
 sound/soc/codecs/tas2764.c               | 258 ++++++++++++++++++++++++-
 sound/soc/codecs/tas2764.h               |  21 ++
 sound/soc/codecs/tas2770.c               | 240 ++++++++++++++++++++---
 sound/soc/codecs/tas2770.h               |  19 ++
 7 files changed, 706 insertions(+), 30 deletions(-)
---
base-commit: 32adeb9806ac5bf928514b62e6145bba12dfd71a
change-id: 20250214-apple-codec-changes-6e656dc1e24d

Best regards,
-- 
James Calligeros <jcalligeros99@gmail.com>


