Return-Path: <linux-kernel+bounces-170113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755C8BD1FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC01F24515
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5F155757;
	Mon,  6 May 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pohQlC9Q"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B28002A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011188; cv=none; b=cwKyAGbYNPnZYRuIRj/EXScZ8CqBlQEv2sV3iwAIuVuPRVjO38D3sA+mwXc/ehnpxdGd4uafo+z2762XsiBYdf+wcuXYNx2sna0om+3Ge6I8rxBCeDi/X+JlJdIKFVo5eFL4l+4+ypvmXC+ZH2fhdmHiFy4X4GEqJnf2lccxABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011188; c=relaxed/simple;
	bh=NWQalUwgvKZ+gYMS5Cl6dnoDKl2lnNy/Vx8YXjT1Dmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHyuV8HdAhZDiZfR7Skga7xe76at6J9Vk4f2zC9rh9XMdTeX8NokyH0EPMx5eCBWjX8FmmCmpP7I9/0DW2TbswmIIwG5GsRdnpHsJsLCo4UiHeiEZzCg+fGUaItX6EXzTOFP1k756JXHzpL+GJmnZEJNvtGGLPXkdVjB8vz/Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pohQlC9Q; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23db0b5dd28so1485857fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715011185; x=1715615985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvzML3HN54hxCFzVP+Buz9BOHRIZhVNBrB1oFonWPC4=;
        b=pohQlC9QRudRBpde5r+UHFe/Wn2Crys/drK1x0Mw5cADBvMnKs6hPu21paIsUEaKlR
         SWGc9ZHbqD3rBQiJxTHam3Ya2r3tcLKwi6/cWuqjasmj/ZrdyBIG3uXwcN7ip/82eTxd
         fCM9UTtIhISjxsMG2oj2s95rwg8vx+cDXiMimAOv9PNzDzvQKNjP/qW2M1SKCNnTZhlo
         RDlIv4vCmVHT7NX0UhzHxShuiSN8MxZp0oqjp62WIp242Dl82GOFUlsPtBNPHy+H271s
         ocSLMFI1o1Wr5TtkmoLvGIhId6GcyhIYZfWyMN1nZJtvCsfp716+6FeJhvHeUM+VmETo
         SJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011185; x=1715615985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvzML3HN54hxCFzVP+Buz9BOHRIZhVNBrB1oFonWPC4=;
        b=mnV7/XgfLfBIkJYhLKof+P+xSzjkON1tgTKNzbaDrlgLJiPHfEUtx6Q9MAb2TiSNkr
         rFg6OHuznDZgSEZ+dW5EvguC39axDB5DpMPN1ZVF6YeOPLeyob5/wAVGdj7wO/EirF/W
         I8+/IUZC1QzRgiWPRDHo///O7ztQdRrfx7WTbs6oiR1JxU0m9xAX39Lu8OBKjdt+Si98
         yeWEyTQJIxl0ddhchm/BCLlJxx3XtR3ASd3nyYxUlyIdI60PRWr+6WZkVwXwSvRVdebh
         v+dtZ7ckrQfA6LLngBY13HKd2Q++chw6eTt+oi+H4HTzYGVmvYF/hKtj7SAT2X1hvlyO
         IClQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2Mlmcy50Whj7+ssmnq/je8typUpYZN9WUacOOFwSqSPHGXIir75tNbXXCcTHp6VFXvq6B1Y30dzRcB1hW+gSveu3Q15oNKpn5xtc
X-Gm-Message-State: AOJu0Yw2B+iZqUJuOaZeoxOZr+h7t1domywjBwfj/C3P0KKSwnMy347y
	P8wMwub3zG2Ph2KeHIXVWBlMPUoWjKficarmEj85lXEpQaSSH3DKreOp/F8vK20=
X-Google-Smtp-Source: AGHT+IHRHaLdY4f1Kvd8SPz1wJzBCQY+/OSJXQdknXR6UC9RXSlBsqZsZGQL72WyxXjhocrMn62CdA==
X-Received: by 2002:a05:6870:6393:b0:239:701f:fc32 with SMTP id t19-20020a056870639300b00239701ffc32mr13019235oap.9.1715011185410;
        Mon, 06 May 2024 08:59:45 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id e17-20020a056870451100b0023c82e5be0fsm1955226oao.7.2024.05.06.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:59:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 0/2] regulator: devm_regulator_get_enable_read_voltage fixes
Date: Mon,  6 May 2024 10:59:14 -0500
Message-ID: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

I was going to send a v3 of [1] with these changes, but v2 was partially
applied so here they are as additional patches.

[1] https://lore.kernel.org/all/20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com/

---
David Lechner (2):
      regulator: devres: fix devm_regulator_get_enable_read_voltage() return
      hwmon: (adc128d818) simplify final return in probe

 drivers/hwmon/adc128d818.c | 4 +---
 drivers/regulator/devres.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 4f6454d1bf73255e49c02d0a7b3bb85146863098
change-id: 20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-b1f2277763fd

