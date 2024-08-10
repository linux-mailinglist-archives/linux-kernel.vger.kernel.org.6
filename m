Return-Path: <linux-kernel+bounces-282042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5B94DED8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D71C20DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBD1411E3;
	Sat, 10 Aug 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyNgNmY1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9053FBA7;
	Sat, 10 Aug 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326449; cv=none; b=a/PKDl59tTbzY5mJmRR9GmLfRS45jaEFtV6TcCygv70FBL6RzLsYCgJrE0gr8fk0slKOB3ZJcsoExdueiLuDc3NCjgOdvajSBPmE7XfePfV6K8KubTcDt+GCuyaWrY4Ha58A1/BOsF9eK6XguAxi59ZMASi0ni+VYyU9dGqKxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326449; c=relaxed/simple;
	bh=64Kz5nerjw5JoHtlzFnvfP/ze5U+Z0CdoYXAltRn7fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJFVaSaEsONn3jYnFC5GFeKz+XxDHiy+OuBdoI1dEZ4NnqI4SQrqISNUsM8MyZzz40ceUnBbgaXx8f1btRKekUs1uFFgd+7QCYvzqmSVUnw6gRWfsY7J1TlcREPUC0Td+D37XCQT9kzikOzKfBKL5BN2Re0eXoeHctuA4A+sJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyNgNmY1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso4340745a12.1;
        Sat, 10 Aug 2024 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723326446; x=1723931246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHsOZ0YN3St7Rru9LJHWEJIKN37bCHz+NEhkc8Z4w7M=;
        b=QyNgNmY1wJU6N7ykERjVdoXVmUsUAeOJosZhcWi0UTaLa7QHRdoOSKuvttN0tgCaMx
         GO7CCRpIAROiZR4a4k9DnCxeM/1SYFO1MAg2E85XN0ER2d5nFd6Q7T9plsZLT+hLfyJg
         aHm5+D07Coqb2XWY+bZ0YZ3UwS1H51HopujlhlGqyy7nXlmCQ1vNtbFSLsyWLmdSfgON
         QRt4TlYGKwbLUtwgQJZCZxsd5MvZooQ8m5qtgfEx5PUGmHg1fP2utJ8bAb6OJtH/rnwu
         VF8mGkmy55CHKKvbXDA2Aa7HXkbJJANI/BJWNFPNUSt7ZZGbrWqN0mgTeUkMntxyG70B
         ijrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723326446; x=1723931246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHsOZ0YN3St7Rru9LJHWEJIKN37bCHz+NEhkc8Z4w7M=;
        b=hhFh5ZVF/YxdGyLKdUiEsq5RGkgVfJoVobHlJHHfFW8uakG5nV275Y1QIRXXP/5oIF
         YUbPpDiKxIgr9xe1cY7shHt6nboMXS3CRY283lsufY4uWYzuqGAvO7HfQUN6TR9iSPhX
         cwfW43rZfED0w3XH3sNMn6Qg9qYcQS0+geIKTN7IlswvwEdWT1PEIVePLpQ3tJGDw/U6
         x7UrfOWPQ90c4Q7xMcLU+teFZmSwLcNeuWpQ268Ut5mH1DxwSDfWuw7ax7SziPhwQdpg
         chYRXP3VTXjA+V3UhVvews+6FO5Vg0I7DUX65oRPgM176YB2UWLQJiFRx/49KRG8kJWE
         UUbg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5NRkxHNAezp/L52NcwKLp65TrPVG+sfLCJu7iXpb+HpOhgKX7J6Vxv1Z08W9WSt1FfNaXuBjCOQOwaS9UK+kkoDA4DViocSiVMzJPCJE9k4nL06BtLlFZKiwsBpMn8okBSHv6jCRm8Q=
X-Gm-Message-State: AOJu0YwL+PEmouR78T7jBtCvCeRsP3jo1j6YL7zNw/NDdq4UQ2yo4LY4
	7yrm5uriNpM3j6dcogiFnh3LT1VF01gQEilL6S9YbKxpaVe9oQxM
X-Google-Smtp-Source: AGHT+IGrebiM4NpumYdQYX/l0XXeKNpt7pDWZHgC1Jo9RUjo38yaPcFe52XAB7vySQVw/mqDNLdwhg==
X-Received: by 2002:a05:6402:50cd:b0:5a2:fc48:db12 with SMTP id 4fb4d7f45d1cf-5bd0a5767bemr3536948a12.19.1723326445440;
        Sat, 10 Aug 2024 14:47:25 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f33c3sm889156a12.13.2024.08.10.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 14:47:24 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (surface_fan) Change dependency on SURFACE_AGGREGATOR_BUS to 'select'
Date: Sat, 10 Aug 2024 23:47:08 +0200
Message-ID: <20240810214709.425095-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SURFACE_AGGREGATOR_BUS option specifies whether SAM bus support is
build into the SAM controller driver or not. The surface_fan module
requires this, due to which it has a dependency on the option.

However, from an end-user perspective, it makes more sense to
automatically enable the option when choosing to include the fan driver,
rather than requiring the user to know that they have to enable bus
support first before they get shown the option for the fan driver.

Therefore change the 'depends on' to 'select'.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..e4d9a035a57a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2069,7 +2069,7 @@ config SENSORS_SFCTEMP
 config SENSORS_SURFACE_FAN
 	tristate "Surface Fan Driver"
 	depends on SURFACE_AGGREGATOR
-	depends on SURFACE_AGGREGATOR_BUS
+	select SURFACE_AGGREGATOR_BUS
 	help
 	  Driver that provides monitoring of the fan on Surface Pro devices that
 	  have a fan, like the Surface Pro 9.
-- 
2.46.0


