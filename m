Return-Path: <linux-kernel+bounces-237575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6D923B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AA91C21E45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A715748C;
	Tue,  2 Jul 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8bCm87d"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE381534EC;
	Tue,  2 Jul 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914984; cv=none; b=knWy70rQmXHYZnesJFE8Rf4gDU2F1DjMX0nV/Q2D0HvzIQ3h20MweYVlA+ANuAsx+Wj/hMMsiSCUjqGL1cpVLOaCyrVZ/4jcwoU29qPY73LTHQd5XRBEpOy2ZI4Vfmyr+hPKVUd8+96e6F9aMCVdGR8dCDlDoJ24sb51U7mk1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914984; c=relaxed/simple;
	bh=g2HcVrfzUkoc4bMPBDSpk1If8X1nscDfttTqg6/6ETE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jDQmEy2s4taRjmR6N2turztLZoajhDYwmcwA+y3cXSAVMoJbxUJ7ILBqaPZ7I0hRdMwwH5hcARB2fWRJnBYr6KnM/Na5+Or3XiJo6JDbavxMzXHN/f5tJTpfS94g5fSnXiskub2fs/rmGg2guUhgGLzuzeFRVhRK654nbuYsn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8bCm87d; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso39131961fa.2;
        Tue, 02 Jul 2024 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719914980; x=1720519780; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORlm+pvBVTYWDNlelC+yKxdC1S4NZedvbzc98e8A0Zo=;
        b=m8bCm87dwZJmE1orXaKVircMBG5ryJGIXSZ2737wISeT6P4fUrneZIsMMc2BQNC+pe
         ddh+NXKEeMeZmcMDVyHhy6fH2AfZDWORCiMFavjkuNQTDfxEtEQvdk79U/WWef9QEn2G
         pKGQeiwH2bssxRaOmt2Q1dVw9ztBqHJGgup2gw/fsX7B9lxhyO5SrVfhJyKgPEJx326q
         eHyXWpvGcBMu9MP80dhLrqOouwZb0l6AckoOfS4MQtFEjVKRXmy5BLELHQ8pzNry3iHw
         WeBXlT2EJGT7RjbSt8L/a+Gj9x+p0Hdne1c6EwJ7MmakSqaL9AEKjPONnrfdE2MV05ci
         cpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914980; x=1720519780;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORlm+pvBVTYWDNlelC+yKxdC1S4NZedvbzc98e8A0Zo=;
        b=PgWNhQtGFGLQldHamopGXoD2+D0L0AQOFjMxpj43QpUbHDOgXwcNN0qTyeASBx7EwO
         kAtt1HOTIJNCAot4+S/z/JhHogRP29UW6UhaPoZmrN9u1HuIhRIfTML75vRfp0+LOphf
         GSwhsPZilOpSzuXVlx6DBBtvsKruIvQ7wthKUSEargXpABOI9TFKm8khP0S7/ngAAuOQ
         4a9JMNzjUt/KvjAMnRp4R6bcxQEdIhV0Pnyu9Loku+L8WwWh1yZc8+HjtGhjHuTwpVgW
         h1LDuRLNzaftpRYuBXTK+jrrUBG01xHLMnVn3iE49K7YDQ6e6LiST2tHzKC431/Bk/X7
         NoGA==
X-Forwarded-Encrypted: i=1; AJvYcCWo1PcjuZHVlFJIKqQyKaix2StjIRFMUke3KGWTnvdwwoeBGtOicVT11ILX2fxs0k/XpnZrH8FJ6mZ2XHaH5Surk3BZkfG90QmhHWSi
X-Gm-Message-State: AOJu0Yzk26hZDk7ed8G87RgB7Nu2pmpEsm5D2EcDypWq94hI98/BRLUc
	fTw7e9v0ZLPin2CF7Kq6kforQKvHbK8HBNf8jWCuufek4LaSfxTG43lblA==
X-Google-Smtp-Source: AGHT+IEp/60WQQZbuNNOgwwaRD9CX5cVlzlsfNe/G+lFEh773fjrwvCtuPjD24jNmKf9uOkyGmFpCw==
X-Received: by 2002:a05:651c:1a09:b0:2ec:596c:b629 with SMTP id 38308e7fff4ca-2ee5e392b84mr65614661fa.20.1719914980298;
        Tue, 02 Jul 2024 03:09:40 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b06377dsm192630315e9.28.2024.07.02.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:09:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] hwmon: constify struct regmap_config
Date: Tue, 02 Jul 2024 12:09:29 +0200
Message-Id: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANnRg2YC/x3MQQqAIBBA0avErBswE8KuEi1CJ51FKhoVSHdPW
 r7F/xUKZaYCc1ch08WFY2gY+g6M34IjZNsMUkglJiHR30cMaGIoJ2Zyx5ZQWUWjEXqymqCFKdP
 Ozz9d1vf9AAxU/QVkAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Eric Tremblay <etremblay@distech-controls.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719914978; l=806;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=g2HcVrfzUkoc4bMPBDSpk1If8X1nscDfttTqg6/6ETE=;
 b=MeVkxsnF4FlKU7QNrYGmXBIlx5oZCtmdnYhosOHWL9jlRXTanTGSBrF27BRLQaGfantkwKwqY
 kSiZ1K1NPWDD/r7s+xqMAxvVGwN22U6F9IHVJ4GzPCVS48i7w6OU+Wp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_config
structs within the hwmon subsystem that are effectively used as const
(i.e., only read after their declaration), but kept ad writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      hwmon: (ina238) Constify struct regmap_config
      hwmon: (tmp513) Constify struct regmap_config
      hwmon: (tps23861) Constify struct regmap_config

 drivers/hwmon/ina238.c   | 2 +-
 drivers/hwmon/tmp513.c   | 2 +-
 drivers/hwmon/tps23861.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 39b24cced70fdc336dbc0070f8b3bde61d8513a8
change-id: 20240702-hwmon-const-regmap-4d4e3c097d9e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


