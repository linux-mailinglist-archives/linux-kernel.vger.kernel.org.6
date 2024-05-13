Return-Path: <linux-kernel+bounces-177777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFB8C4483
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398981C20CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DD15442B;
	Mon, 13 May 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="WDMGE6gS"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE457CA7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615201; cv=none; b=YQmH+CVYLuncCe3JUCATY4447LUqX3uWxWarx677anbEAltG3UlAhXtheq+5d2W3B9zlNKVcSd/ERCaCkYNMwLJWrG1aHvZFdXlwRPLaQ4sXjINncN/q2wWo2DCvbklvFOBRcfmlDlLclIi+u+8MbbFjNKNd9cWnz3m2xB2NRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615201; c=relaxed/simple;
	bh=c+2oQsWNq3Aqv4I7Lpotn6eMagm48oS8hV+rQgU/ngA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M66YTuLX8ywyH8OUHRxrVp/vHZuCi34zCahp1Vy/KZAysIpkI2Nf0F2+4HLkCx/z+ehE9EqzjL0CFclUbEDv/sNpkP4ZljtUhqYfWlv0TYa2V1ofh8EYiMUwFCe+Pbdjec0NcwfylZRFeeykLyhfKy261cDoa0oCqcusWac4YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=WDMGE6gS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e576057c2bso32360331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715615198; x=1716219998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuVG90NynmI1kwhRkYjh8vkQweVo8xcJvLui61n/z84=;
        b=WDMGE6gSOCRZE3Ch5PP7wF1IEl7GFtG+Z9XOjfotk5diWFKgxWXIAWEmblEspOwrWA
         GnLe6p99UA9ugj3SK2Iy0e8vkzfOlAUxHlH7REPp2caHkIg0eFl/sXL/11RVVhcFHVA7
         626HG1S8LTXLbjXvELwP2siqXyn75iuMPKml0lkWZP9OEEQs6S93T9tWx2vLykZ3drKu
         gIVMG25Plg+k1Tx/1oHbEC+Xd5cQ+75BmPVQ42aTvrBrUIuA/Zjqnd323BZqV+M2KNvs
         P+m3EuEpci80HD9fQivDsLXCvgFrzwHm2hC75FVIdG8PhTnc9SmLbLB2o3Hn+gZhan9n
         jhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615198; x=1716219998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuVG90NynmI1kwhRkYjh8vkQweVo8xcJvLui61n/z84=;
        b=HSUF6Krm74FppEl/o+5tEzQwd4ni0kk7RO1LcZsqRKOpTw/Y0WL6O26Xa/bA63Sdk9
         GJvUOCHSStHh8q/VgMgHKCMFjUWlOiY8KRlDObcu4kuXPdKP1BLbIQ9dOldhdtVMoBTe
         pX9xpIOsEVUqz57Nk6bQphIks9Q+78u+hCbLXUxoLQ7ALzpg1BTIXE7NabGIpHQ3gzUc
         smQrtIhTgbLpSmftC4YxGUUgDLC4aCavJ5nt/eWarKg7dK7Htp5HmpDaw8A1Ojq02i5/
         Lkwv49MTWd5m/CejIVU9AEqIwkkDEMv76JtdDIuScZG5N99rJqtK8vw/dEvWUmA9U4Td
         IIEw==
X-Gm-Message-State: AOJu0YwObKu3n02JKwN56u10rL3QbRfNAh8PVSWCMLG1Qlk6yAlRWEmw
	d8n+jvG2fCu+djH0jvN9wC2MAqgHTCmcpsWaMoh6Y5aUkwFj/bZc3uhL7BP4wV4=
X-Google-Smtp-Source: AGHT+IHox5zUZVsU5l4v1h5SltLOyIORY6g5v5FqoUKwpFMQjSqu8Ql3bjmUtKQSYqWeSRsyRa73lA==
X-Received: by 2002:a2e:461a:0:b0:2e5:2414:a205 with SMTP id 38308e7fff4ca-2e52414a255mr70941681fa.27.1715615198036;
        Mon, 13 May 2024 08:46:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5735a2490casm4923002a12.32.2024.05.13.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 08:46:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] w1: Fix number of bytes in error message
Date: Mon, 13 May 2024 17:43:56 +0200
Message-ID: <20240513154354.185974-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the number of bytes that failed to be allocated for a new w1 device.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/w1/w1_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 3a71c5eb2f83..677e7167806c 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -34,7 +34,7 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	dev = kzalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
 	if (!dev) {
 		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
+			sizeof(struct w1_master) + sizeof(struct w1_bus_master));
 		return NULL;
 	}
 
-- 
2.45.0


