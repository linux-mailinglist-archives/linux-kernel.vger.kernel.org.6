Return-Path: <linux-kernel+bounces-516232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAADA36E73
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511E97A49B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEC1C6FF3;
	Sat, 15 Feb 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lxUmLtrK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D51A08B8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739625530; cv=none; b=dzDEuEQTCo0NsKO+M8UDUllrimGATLdtD48q92/1TtYXp88/CYHMja70e90Knd/NdW8rIzkP6EuLhXxWNYOoSryq3GN/qkqPh8A2fvnChcaHGIJegR88CCrz8D7koEqa3O9+U47em0BpmvBdYDLNO3TAuwSN/iR8QN76dR9MqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739625530; c=relaxed/simple;
	bh=b6icX88GUI1+i0qFjXdViO6fgfTNslKBapLU99JDsdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toArF/oWvAAjV0JbRo+CJgOvrQC2iAapmOfCsX1dg/roby1b1wJB8BEH2kXrIfR2J4thzWtWYuX2WHfBEqqqhX2UXmzrIXFnJCY7IHUQ/PEtzbpcbhpL2JrOxnVFe1v6I9FaXqF+/cSh153ceV7oO0ad/dci7EF0ed4j4qFbu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lxUmLtrK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so2026093a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739625527; x=1740230327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Soy9HKLDRhtgvZqgnl4BT3HK1yJOBepLUK2HNIXt0=;
        b=lxUmLtrK0jfEmrohvwavhNdbdu6o50Z7gDWlGGq9WHoP8TiZhqQ1tNP8QcC+b/ScoV
         ZJa495btIiL1BKhLn7dxJFo/3ReBfQT7br9U3nm8eXiuZmtm834fP/tSCuEn/5VtPJ8r
         DDkEcz4Mz4rw7itCd7tFLXGfHdZMh7nObp0BTs/gflZMp3zjD25eztSRRM3fLOCG9Dbh
         ycmv3mBHsSKR5yMxZYBnOwFYkjvk2vCE2LYaCPfF9vOqqZ8uTBgEBg7Vy/zIaj7MK9nQ
         IaqnU7vj0UqdtzQpsVN+jl3lo2rbTvMo6cUWyR3CKnzzGSTETNAsViTvJ4fCvokAJbmF
         P3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739625527; x=1740230327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1Soy9HKLDRhtgvZqgnl4BT3HK1yJOBepLUK2HNIXt0=;
        b=IuYIoeJboc7fQerc6HJsE2JX/Hxlzr4EeNX5hW+kcHC/8GOX5Ydg4YTcYCuACxqRfy
         Owa8MQtgTvXb6JaACwOcnrB4UbYDbjmqTonVxae+jw3QjExdT0/Z3WQafTNd5cXXsl5i
         O23sm8MVLtQwPzfRei19Dy6S7KAk65m/cKzFcpXM0NH8aDlP3WIdgHrEw0l/5qTrdZvb
         0TQMPQ0qVRCkS//VBs599tc48A3iAEXtSpsJYLWSABqLiyPQb0mkCKjzcLPZ05872pIF
         nLCYvMadRlA86wbbJJVZoSz9bp076NM/bcAoClpDcrLdzF8W+eOJNp2FDBx414dqLSvX
         h3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUzGcUfevLdraCSGBc1v+tuwTZLKL/+lYrv+qfNPNhqBOt7vfgq44SzrHytOZSLBvYlKdV/dXtm2RgraUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7u6ENj6RzIyh7bpqAl+oUcRBcNnbcwTBa6INCzbQhD4J3o/N
	g5VKbXtM5y1gEILK86pwl5EMvRMGnCcJ4R7hOW8l8+27rHCrX/Pj6+Ry9n0wL3I=
X-Gm-Gg: ASbGncuJqCqrJvTUWuh1r8oFRHgAgdmhfOoNm2mD8MGSsScj4W8GDDb31V+R9keKU4e
	oPpAZ7V3pWvurY+JptDxurrCMMQu0/kr0hPfmmD3QzYrsI9xgTvjA4w+WlVAOyt9gI0/FNqa4ci
	LZVHgt7n55hLhK8Yyr6xPy5pug23PvD42wflGhWAiD4QWpW2gfWiSf+ZGVmXzxvg1fo4Z7hhogW
	Ruu1yGn/TXV6NbpSIAnzp1DyYgKY+g2tadiiDgouK01gwIycSGrsxe3E7I5r8RydAUm+D00900X
	gFlKQIJI8cmCUlHsRzEsakwVIo5PhyTfknVZAqGNyUtEEA==
X-Google-Smtp-Source: AGHT+IFMrBPMiwy4hh2gSuBvAuc2QNDGynYaCQjJMK2b6mLiJrQx4XpH0JunoWzRU7sOAKxbiiK2rQ==
X-Received: by 2002:a05:6402:2114:b0:5de:d226:83b7 with SMTP id 4fb4d7f45d1cf-5e0360419aamr2320384a12.8.1739625526853;
        Sat, 15 Feb 2025 05:18:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3693sm4455433a12.39.2025.02.15.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:18:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	john.madieu.xa@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] soc: renesas: rz-sysc: Suppress binding attributes
Date: Sat, 15 Feb 2025 15:18:43 +0200
Message-ID: <20250215131843.228905-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The matching data for the rz-sysc driver is marked with __initconst, which
means it is discarded after initialization. Because of this, attempting to
unbind/bind the driver through sysfs after system boot can lead to "Unable
to handle kernel paging request at virtual address" errors due to accessing
freed memory.

Since the System Controller (SYSC) is an essential block for Renesas SoCs,
suppress binding attributes to prevent them being exposed in sysfs,
avoiding potential issues.

Fixes: 1660e5ea6a3e ("soc: renesas: Add SYSC driver for Renesas RZ family")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/rz-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 1c98da37b7d1..14db508f669f 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -120,6 +120,7 @@ static int rz_sysc_probe(struct platform_device *pdev)
 static struct platform_driver rz_sysc_driver = {
 	.driver = {
 		.name = "renesas-rz-sysc",
+		.suppress_bind_attrs = true,
 		.of_match_table = rz_sysc_match
 	},
 	.probe = rz_sysc_probe
-- 
2.43.0


