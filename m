Return-Path: <linux-kernel+bounces-296793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C894195AF36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CD01C2271F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C9183CB7;
	Thu, 22 Aug 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6Osmka2"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B40183061
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311270; cv=none; b=pxhUHlYVaZQZbXANuI5x5hUCaqRCaxZxxp0FdJ5QkW2yqRFZaKgCRDD4675wWpzOt3mRxrvcChvcYlcJMVzRJwk0BUhshBzUXmDF+rE0x8EmJmKVfxcWBpySx2/5Idj1D6Ao2pO4/P5QGNxh539gPG4Qc8iYTUAX0HHZSVDxKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311270; c=relaxed/simple;
	bh=HIEBQW++vDG5a745kTyn+OTlys7QVPwisgFVgoxNyoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFyiuMl7HVYCY2BYaYDpRz/EQr/r4F2LX7BuNK6oc2Zvq73qGBh+FiHm5beAf9fgpg44PL+q3y+GOgaGOYqA0htgf9pepQh9txeO5J00FWrf2BLHlkdM6romNxE7s+zkX2Re85guX6nYT2lLN0r7aKnFKQ4AOewns/JR3wsHgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I6Osmka2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd76b56e59so171706a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724311268; x=1724916068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3scZTUqJnjgMpybUwcFhKq0rNyJDiP6vw8cgGHLTR6o=;
        b=I6Osmka2tQZjmQhHUlUljwklRpsynQR5QkuuF5s+oKA7SK4k0WWNHXKlT836ElgMf+
         zuliiADjygIO97hw1O6wBD0uxlQMJlrbJP8McZPevVSoYH8M8GL3RoGMOAbFNjjSoojg
         LFr1UPlyWdrPmbUrMuBZTq7Y2Whb0s6XS9JHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311268; x=1724916068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3scZTUqJnjgMpybUwcFhKq0rNyJDiP6vw8cgGHLTR6o=;
        b=NQgz7HsjNYmLtjzndODhnVZyHhZzyk7+Ry/G+h6YkX+2+Y+c/UQ6hTpkiuB7BA84pr
         fXIcuOzWgsNCkwY2ffQZieWpxIIrxlaURfMNZu3p8plYJBQ4yPk+V6CDjr7InAfOGk3f
         DN81OEp6yM3/s4jhF8GWjNfPXbNwLg2M07jMNRHdbksiHp3WujjAK7dGjuyjLj8X1lzU
         Xf6RdbVtdR5S7YTJPAszFG8HDQR1bPg9Gva2bWrNPXC9+7JMFeERpt9527TKpnCMWSNy
         dcgSGHoDZSlPG1itIbSxmH2s3Bpfn7RO5QsNTP/wlWasR0fV/1QjkIYidUuZMemsMspe
         y7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWcZsPCQqGUMUBkHGXcxKJ6EZDKHhKKp2MpiOPklfJEcORevTEnxa5urCkEI5Ol9XlzHwjfUV/B8dGue4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHo6H7O1PLYWfzbB7s2sDIDQpn2lPJ/A/fnLe5vOWfAD8iFOp2
	rlacltE+z58UZEp7zH6OwEQyQt/W/LfAR9Fvr21vpruWdtMUIG6gsRxNtMfShEGgh/HbFBoGWIU
	=
X-Google-Smtp-Source: AGHT+IGZC3R+I2VvA89HYxYSg4Ao+WE/aEJPwMMpjyENZGIwsc8WIExLuTmv5nBr89XIrOEWeKGuAg==
X-Received: by 2002:a05:6a20:6f08:b0:1c1:a25c:745e with SMTP id adf61e73a8af0-1cad7f896admr5742758637.17.1724311268106;
        Thu, 22 Aug 2024 00:21:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e8e9sm615901a12.86.2024.08.22.00.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:21:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] regulator: Return actual error in of_regulator_bulk_get_all()
Date: Thu, 22 Aug 2024 15:20:45 +0800
Message-ID: <20240822072047.3097740-3-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240822072047.3097740-1-wenst@chromium.org>
References: <20240822072047.3097740-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If regulator_get() in of_regulator_bulk_get_all() returns an error, that
error gets overridden and -EINVAL is always passed out. This masks probe
deferral requests and likely won't work properly in all cases.

Fix this by letting of_regulator_bulk_get_all() return the original
error code.

Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 03afc160fc72..86b680adbf01 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -777,7 +777,7 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			name[i] = '\0';
 			tmp = regulator_get(dev, name);
 			if (IS_ERR(tmp)) {
-				ret = -EINVAL;
+				ret = PTR_ERR(tmp);
 				goto error;
 			}
 			(*consumers)[n].consumer = tmp;
-- 
2.46.0.184.g6999bdac58-goog


