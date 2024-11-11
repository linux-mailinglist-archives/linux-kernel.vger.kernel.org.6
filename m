Return-Path: <linux-kernel+bounces-404381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A426B9C4323
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D023B28490
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AE1A3020;
	Mon, 11 Nov 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKC/tGr6"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AC19C569;
	Mon, 11 Nov 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344166; cv=none; b=Em7z6QMxHEs+YNPWbRRhGY+ndt1mxWa1fWtDRiqzEknzF0PLvnTuUQqvIIo9G2gXF+s5bZ0tfeJDg3I51ZT/mh8x0J25f4aL5atsefaER/ok6IKjZxAqtguPuoXJU+VEozK4U8JS9eHZaoJlGNZTCnFSM3I+IR3ONobAd4qBjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344166; c=relaxed/simple;
	bh=K92yUvKG6bNkexeKvclLDYbTcFbU3nDHCbBcWLUUUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr8tTds38liQ16xcTeXmkvOxyxn/pwE92q6Ga1tUd44KTqx2ZZLeAhmB/M03VU4c/IfrPcHtCm/frP5ruQ2w5cv5UeMjOw9vQVUEsuvIdmUQP6rcOT81iV4lRklW3c0HzL9bmM+D4dZrZTZclsF5QPLAP4aZ+KTcnBMJAqmmF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKC/tGr6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53b34ed38easo4728674e87.0;
        Mon, 11 Nov 2024 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731344163; x=1731948963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Exk6mmiqQi1A5uEjYEtmgEMregcS5xH2lmr7GxpUfF0=;
        b=ZKC/tGr6ne5vDEe9yyND27sq1BWQmCxdMrtUv7r5avYeZ37lv+QYfiBTaoibt8CfhE
         SdbSnS+dTed69MoRYbEaDqYNB+bz7V0eDV8kwYjo/NoLZ9gZ9q2HHmsYtDSsbB+oBwU5
         KRuHDhz6VJHxo364bBr5GVod+PY/qAXhtjmkNM3GquV4/v2gz5GHVu/qt/PP0jaZywDy
         Mly/SkrCbqgbZxA2dnFdtFdp2R/0MMxy4TXvhyVnRH6JAD+Xltow3NXYsSoSSf7GS0KF
         Q1X6kGsKCjYxZ7eWFlX/1ZD2EdUUrm6hR3t3k8SZbsH2XDupL1pDzzLDxkm0RpfhxMYN
         JBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344163; x=1731948963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Exk6mmiqQi1A5uEjYEtmgEMregcS5xH2lmr7GxpUfF0=;
        b=uX6rC9Wtf4kjwpagjmAXsORrF/7KgRkaBQVppnAz//d25k4LH8rpVMUBw0x0gdTgFk
         U6eFS/+kzD2IYxvcZYzbv2LriRw+2yfIYg9yZc8VaG15KViFOL3InmCQEXSD+muSFmBj
         bv5bbawnWBwmjbgQKO7Fz37GCXnD2sFEv7lHt9J8mrsS+lmdH3Q+y3bfWVU/xQBdLLTV
         yTbD7qENnlOEJGMY6ykFjgS/wb+Ngya24fEP049ME0I3HP2y0O7CdaaYJ0cvK7ihXDGf
         65dv7SS56fTEycT5UjoEQWEGniBFTAEKPWact3MURPd3U9y8iAIowtZAfk74ba9vel3l
         K0qw==
X-Forwarded-Encrypted: i=1; AJvYcCW54pm8L3/Uz4EmSwpSCQJp5Yr2nisr11/uWtiCaCsPblZ/kJ8S1w13f9+XzVN5nkyXM6CthHZGGYyKQQ4rT1mi@vger.kernel.org, AJvYcCXfTfb4eTLFRv8t07OZfJE2zmsYV4SHzeuzw4ynW3YhNldvqidqrd9oLDrtFcxRu9Hn8y7VkIubloKlUKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwurbYHztS7kyGpx+kveBPXSUCZFgg+Lfv4N2t7kGQnTJ3F85NY
	RpqMoNJTf2Twf0Y/JyMGx3izzfGjZZ2STCwLTpv4hMLKETtUWItHApCmIvrn
X-Google-Smtp-Source: AGHT+IFfvqMK9GbFqDOZdFvb8j2DCucKOk0qdQPlVNUo+VQIMAi19mPFqP3vzp3bFje3LVb4xZypOg==
X-Received: by 2002:a05:6512:2389:b0:539:ebb6:7b36 with SMTP id 2adb3069b0e04-53d862c587dmr6133828e87.25.1731344162409;
        Mon, 11 Nov 2024 08:56:02 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7387sm1624737e87.140.2024.11.11.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:56:01 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	lander@jagmn.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	u.kleine-koenig@baylibre.com,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 0/3] ASoC: sun4i-spdif: Add 24bit support
Date: Mon, 11 Nov 2024 17:55:28 +0100
Message-ID: <20241111165600.57219-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
I've tested this patch series on the Allwinner H3, A64, H6 and H313 SoCs
up to 192KHz.
24bit support is working on my H313 board but 16bit plays a bit slow and
I suspect that there is an issue with the clock setups. This is even
present without this patch stack. I would look to address this asap,
but for now can you please review what's here. 
BR,
CK

George Lander (1):
  ASoC: sun4i-spdif: Add clock multiplier settings

Marcus Cooper (2):
  ASoC: sun4i-spdif: Always set the valid data to be the MSB
  ASoC: sun4i-spdif: Add working 24bit audio support

 sound/soc/sunxi/sun4i-spdif.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.47.0


