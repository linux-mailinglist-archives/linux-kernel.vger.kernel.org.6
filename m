Return-Path: <linux-kernel+bounces-299953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65495DCD5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A747D1C21E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F815445B;
	Sat, 24 Aug 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v4V3aD2T"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671717C64
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486566; cv=none; b=aoRBsPk3j3ClSmZ7pJ+pSSc8BlHqeyDlJH30l5I0FJxIE7fEHtIb1FNvk9cZ1hwmO2Ew/0nslci/DDmybUDSm+Qbnjclok+Sq3BPVF8aQkH1x/ZCpDsMNfUiCf20E3gJQb+OCd9YLqYYr6FPAS1qK+l4hPY+UiVIxdZqZPEVAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486566; c=relaxed/simple;
	bh=Zs5zEuUT/wpDbHNErBoN1MTM30qdodhjvny4v69h7uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0HspEeYZzF5X8mqQG1U6+ovaWY/q7r1BnWrfRl3JgUeGvyv9g5VnUz6urgUtZ21qVcfpK6QUtadIx9y3FRElRH6am6mURQmL1t6Yw2nLyCVhK5f8SwCErpFSA4dYy48eqirNJRPckl9D6UjBlZQd1cRbKrzM5ApoURv94d++8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=v4V3aD2T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so20598605e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724486563; x=1725091363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWSyLwIKFg5VyESF9UUyLnBM3UXt9KpCOL2rqjBUsiU=;
        b=v4V3aD2T3Pqq3poBVS9qEZ18ueNEn/PIHCZF/nugr/dRg4Nb0izTzkc40YJf32IR2U
         WvNwBPLpAkFusmPJ04E2Esd4havfs7mYtEyHowMyMsScNimyWI3awV64ApZjbLmyw6JS
         tnNpzr0UTiopGoaHLfSbt2zLXcD40g/a2HnO1JM9f5XR7IOxJcz6pfY5lBd9nBUoTHsZ
         txcuiXpzjBmRu365LwuSKK1BmII3UBzAplU0Aq+hWGFKzO4nq7Am3Meq94vgVlnO4VDQ
         y3GtmzgBNhqeieXnrxDVmW49hxCW+PhnthEyM1C9y98cV3uA6oYB+tWls518sQj/rVeU
         FLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724486563; x=1725091363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWSyLwIKFg5VyESF9UUyLnBM3UXt9KpCOL2rqjBUsiU=;
        b=lJhALtmOlzFPt//tVxHr6wgsMFZ0IwhoWJtvgK0E1OUcjq6aou7KSPnBlw9SKhTsJH
         bONkRJ+kWIEeih43XMq36jrKzmXSo2ncxX5m+rcjUKab/cQZn/t/6jziUqSfITZ9OtAX
         zwle0Oehe5FyWr/3QGfI+fbgzUCFiUwc0biFyI9MmXZZ7tKA9hQP5aYs9KOqACEX8UID
         g0a5TC9+YvGsPYSdIF3RxmkkD7Uug5UhrUZnpJd9UdoAWE3VG76+iQuS5oTWCDrWQapx
         aNJtZbkWGyneSgFw90UCMNsc3A8ayzv8gkR8TEAEzrfmYNYmM7ltwaBlTEZvlYtqTPI/
         rgCQ==
X-Gm-Message-State: AOJu0YzlOKTBBl85G3P088fqpS7TnOGkJKqINUIJMPZWhkHgViJoQWM3
	/C2Qwn+X1bjzq3hrhP7GUpInsorIR7HiwpFANewgFdysguc1jS9/QtyeTZLbhnU=
X-Google-Smtp-Source: AGHT+IHBItaTBibgncUhmXVrgDs4cMae+YQxCRPKgXSB+v/+rRgykfcscverhueiXFcqDFLhxIx2AQ==
X-Received: by 2002:a5d:528f:0:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-37311858595mr2758576f8f.6.1724486562452;
        Sat, 24 Aug 2024 01:02:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:191f:3b0b:a64d:436d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5dbsm5919454f8f.86.2024.08.24.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 01:02:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] Revert "memory: ti-aemif: don't needlessly iterate over child nodes"
Date: Sat, 24 Aug 2024 10:02:35 +0200
Message-ID: <20240824080235.56472-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit 23a641d5c2bce4c723fff9118a5d865ee6b9d05a.

The first-level children of the aemif node are not the device nodes (ones
containing the 'compatible' property) but the chip-select nodes which
instead have their own children.

of_platform_populate() will skip such nodes so we must indeed iterate
over the direct children of the aemif node. The problem here is that we
never call of_platform_depopulate() as it takes the root device as
argument. We only have an unpopulated chip-select nodes so we will leak
these devices if any of the calls to of_platform_populate() fails.

I don't have a batter idea right now but my patch was not correct so we
need to revert it. While at it: at least use the scoped variant of the
OF node iterator. Down the line, we should find a better solution to fix
this potential resource leak in error path.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/memory/ti-aemif.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 3b546eddf5fe9..d54dc3cfff73c 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -379,9 +379,11 @@ static int aemif_probe(struct platform_device *pdev)
 	 * child will be probed after the AEMIF timing parameters are set.
 	 */
 	if (np) {
-		ret = devm_of_platform_populate(dev);
-		if (ret)
-			return ret;
+		for_each_available_child_of_node_scoped(np, child_np) {
+			ret = of_platform_populate(child_np, NULL, NULL, dev);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.43.0


