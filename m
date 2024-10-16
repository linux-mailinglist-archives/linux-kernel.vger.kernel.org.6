Return-Path: <linux-kernel+bounces-367854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D69A07A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EB5B23539
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA5206E90;
	Wed, 16 Oct 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4iDWsbg"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5DC206E68;
	Wed, 16 Oct 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075327; cv=none; b=NxheUaGAUYMvlxX0jAP+UVmAemILXlvFVq7dkCjxR6O7QCeZtIxmk7F2+RYpyKNeyen5QzkibdeWE9D6No3PcAuAwUsdP8Hr5syKQq5lkTIckaO0AFd6VeXQ1iFu7GQbXE2Bkce1OhTU7ZwwSHZ1VcI8fRjFhoH0hXYGjstGlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075327; c=relaxed/simple;
	bh=mEq5F6t+xaQeyl3l8j0WFySka0dkQMiC1ioO2fr0s3c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QlYxuUTJid8YV9CGka18lYwTL08a2/Wa7kJ38mqBFNZXZ6eOOvAaijInSwG74CaIoAriQ9eZTHlAXbM1FMnrEUlmYr7sz4L9L99Q+6kzJ4rBvew5VaYHfda8q4m5VBweBHUwjpDZj1Iv5BQJj2l+zurLKNgcZ/NQq53Xvff+zUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4iDWsbg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca7fc4484so32110365ad.3;
        Wed, 16 Oct 2024 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729075326; x=1729680126; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=105FVZgfdYE5ClHoZS1Bc0PBYQU+gjIa+OLFozcjrTU=;
        b=m4iDWsbg6y+6Jm+kSbHNFTY0SeGN461BJTTV038XJCbrfvbAhVZrA60edH8ItrPKqe
         LR1MB8QGfyQoncK6HnOjczXt7rd2SNbFXJKAwqMYB4jQQz14sNNIUgBP+B2IVxalE9Oy
         Me2qvAJbyb95141F3qW2+Jtmjki6kzp0/HI98HVqGk/eil0bIeflrWQRgg9iFfRNZs3x
         wQ2FOkdFgljAwfTcvbKem5o7ojRn2aQz9q4JNJKC0dXbTZ9M/siTmMvcxVV+fMmJ7T/p
         cMbqWw1L9Sc9NXA2guBqWGM8RvuMEzo+8aGEBcHrtVNI6YQrY7q/kcxUc6oMhaSiVS/V
         YvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075326; x=1729680126;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=105FVZgfdYE5ClHoZS1Bc0PBYQU+gjIa+OLFozcjrTU=;
        b=gsNN7AJwCbNmx8Yk4G9owvoNnrxDV05FvY7wBtNelYfY1DTf55avMGVvoercBfULIf
         VR7Vp1cu3/K8BUC168OdOKvsZMxQuqSjR3kyvLJotdgt7zI4B1Pyvl40D1KW6ia+78R7
         zR73qyKQt5l3UY4F4j7ftSGCQDr+QAun1h9KyExSNPXCu/nzWF8c6N23JAe6lGypFAY3
         o7CetL6gG/P8zFbC2mUONcbCch2N4dftc1mKsudSPwy/c1DhhgAS8dNdhw/ERJXcMcjH
         C01UMILqUI1hBy3WDdj+msWrfhbmfEGcF/H0+3TFQqTcQgVxO0g83RXazq0RwY2WDbLS
         kT0g==
X-Forwarded-Encrypted: i=1; AJvYcCWIhvsg+0BGfJ0NSs6i+NhExsRwRj0Y9vKimB/Y3YNs6RvMDo/anuF6AQZrs2eTcXcaa3maL2nGNB55kBj3@vger.kernel.org, AJvYcCWQlD4OzKf3bELAKTzfe2wtoERIhRq405ZIoKzsY8Uj7swT3dyIyd3IDc7Hzs3TlTrJ1oZPcJovJNwrLfk=@vger.kernel.org, AJvYcCWSYoJyF2qfGQP4FG/Cg41QjRj6TxVHUoRdrWdGnB7WHW0ZSwNCLtbR3V3i75peOzLNi7WdI2+rYc4m@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmq1pP0cO2PurWpKvnNfmPeBKPXDPS0PLR2ka2HdzZd12uAjOT
	P7dzgwg4NC738LpL7VkltvE0x16BGR2RwNbS3JX8dfB5IpSJ5o+p
X-Google-Smtp-Source: AGHT+IFYuKRUAQGpZGNW2W3fgGvJ+I+xUzQv4JnkWoD7y5nHrjeFA/KPs9pTVFYfiSBlDtDnKaO8Ng==
X-Received: by 2002:a17:902:f552:b0:20c:862a:fcfc with SMTP id d9443c01a7336-20cbb17d8bfmr254142565ad.6.1729075325233;
        Wed, 16 Oct 2024 03:42:05 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm26319645ad.182.2024.10.16.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:42:04 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH 0/3] ASoC: add CS42L84 codec driver
Date: Wed, 16 Oct 2024 20:40:59 +1000
Message-Id: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADuYD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3eRiE6McCxPdNGMLYxOLFCPDZAsLJaDqgqLUtMwKsEnRsbW1ABB
 aMS1ZAAAA
X-Change-ID: 20241016-cs42l84-f38348d21c88
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=mEq5F6t+xaQeyl3l8j0WFySka0dkQMiC1ioO2fr0s3c=;
 b=kA0DAAoW1DYy0VH3eWAByyZiAGcPmHbIJy19smNGSootjbZYbY0aqkAGCtDav4ojTWY0jLfsH
 Ih1BAAWCgAdFiEEsIISSJsyBtmPFHm91DYy0VH3eWAFAmcPmHYACgkQ1DYy0VH3eWC1qQD/Vf85
 E/CLK3aUekI42LVRO9TqU3Yy1zrsoYg5eG8ZIJMBAMYsRWvrmcFNrGwjWPmc3L+bk60h5APjUsE
 X+460AVwH
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Hi all,

This patch set adds a driver for the Cirrus Logic CS42L84 codec. This chip
is (so far) found only on Apple Silicon Macs. In keeping with proud Apple
tradition, the CS42L84 is essentially just a CS42L42 with a different
regmap and no publicly available datasheet. It may also be missing its
parent's S/PDIF capabilities as none of Apple's devices support S/PDIF out,
however this cannot be positively confirmed.

This driver has lived in the downstream Asahi tree for quite a while now,
and gained some refinements along the way. I have squashed most of these
into the initial driver commit as they were small changes like tweaking
msleep()s or filling out TLVs, but left seperate a larger change to
tip/ring sense IRQ handling as it differs significantly from what is found
in the CS42L42 driver.

---
James Calligeros (1):
      ASoC: cs42l84: leverage ring sense IRQs to correctly detect headsets

Martin Povišer (2):
      dt-bindings: sound: Add CS42L84 codec
      ASoC: cs42l84: Add new codec driver

 Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml |   60 +++++++
 MAINTAINERS                                                 |    2 +
 sound/soc/codecs/Kconfig                                    |    7 +
 sound/soc/codecs/Makefile                                   |    2 +
 sound/soc/codecs/cs42l84.c                                  | 1110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l84.h                                  |  210 +++++++++++++++++++++++++
 6 files changed, 1391 insertions(+)
---
base-commit: 469819cc17368702a6f68cec2148f518d3f3679b
change-id: 20241016-cs42l84-f38348d21c88

Best regards,
-- 
James Calligeros <jcalligeros99@gmail.com>


