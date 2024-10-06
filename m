Return-Path: <linux-kernel+bounces-352190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F0991B84
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 02:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A54B1C2121C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE754C66;
	Sun,  6 Oct 2024 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="m6Gk5ffH"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BC19A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173775; cv=none; b=UO4fi8zRNs4o+KsAx1mPgeS1bjqhC3448Op+9BCpYMJpt1UtQsFqMtPDlhvmoNeN/yA7LZ+l5Bycd5dXntFINUbk3r+pUyBKul8pVxfAftPJ5qfyWOm84BqRGcY03mmaH78Ho1hSNQ7dEI3A0p7/DZoZPrWFmkNEQI1qKLVpMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173775; c=relaxed/simple;
	bh=SNBxoV1rx6uFdlVgmTwwErdFQ5cAR0hkFCq8CC88gyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fprLfMxaAJxSklRD+oetnMIbQMEbEK6YQs5n8kO9cWr8QS3P6/t4U6pEGxRw58qFoHPpqhC+CfADWuQMf3Yla1vD3ebaiuRcPwjN7tzJy5tMoEz9pn1Km/XCyN+hYOttaflN0V0guwv5LK6itkO9tsZns/23kOvTDaKeEQuMuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=m6Gk5ffH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b01da232aso26146255ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1728173769; x=1728778569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATYw0gTgPQjnSXPvhq4TIhUlRS9Y7ceSuAlHJE+uPHc=;
        b=m6Gk5ffHncL6K+7CCmjEXMlpiH9LU+95M16pnNatwGqiU3JIPzWoAhkKQszAI0SHeL
         01pJ3CBfxRe3BjegiNLk1RR/roZ/06eQfwdFS9QjO6A5iyjEA6hRj8EFXCCePYZkQNP5
         uv/ca0CEmoJc8tcgDr282d/8IHHW7dvOnEsq6EfnHDl+QxSDCx+a6HhHSnesr13rcfAA
         oKQUsvCjAWHkiyKsXlBKImC80OCbU4lYbKw1TxmgE4n3OtqI0YTpIRco0qBPIpeXSdap
         bcX9fnx0ejHFM9BA86YoZ//Aj/Gw9+Ji6GFIeGZURX8KIZX7frj3IE9LFygTa+cXEX0D
         KcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173769; x=1728778569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATYw0gTgPQjnSXPvhq4TIhUlRS9Y7ceSuAlHJE+uPHc=;
        b=bb1vOKvD4B6oAQ7t+3dLFEMzwZmQGBNPd3n3PzCQhjW0NgG9iEJuMH8x6GttgGbJGI
         u+IsZq7v99ff59Th0+h/B2Tl3/EHpm0GzQ4FIjIObjPigHbdhTk/EYPa86ZrkkEHJjck
         E4l1/TtGExSItLkbgKkBVXcaqs83vv6lTls1WV8QApXYg8okxIbk2kQxcZU0wLCXjKLH
         H9KmlWsqtKL3XgmJRlaBQSIp9YMrZTkTVaPrMoGiKGrjHIo5cYT037LviXmyH9ESKwRX
         sqWFlis8Xxz5wSJ9wxoqx5gNWs0YRTWXC1RWv0iG7QoFpeFV5EEat6j3cccQv9WZJmGR
         YBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXPI6j3e4f+fXbqRoJgrmVhDy1MIufBjZ0b877v2wQk6RYujtB22BQPdBLmepTIcF0pzmeXfEHmEu6Hxew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdpNyVf6ViF1gKHDrBE7EFiPxBTTXZObJRSTZz6hN7ktKIChH
	tRDZZZoZs9trNxkE9Je7fLL1kSnuEuWW/NmcoiFfkAPR6YoRDmNPdeo2tq6h
X-Google-Smtp-Source: AGHT+IGGWRUojFmci0UIq/ow6y0T5+wd0QojcdIZhftIf4PjECAcDzsFAmXC8zdXQtzaDdHFCmkqcA==
X-Received: by 2002:a17:902:e751:b0:20b:5e34:1842 with SMTP id d9443c01a7336-20bff5517a5mr114758455ad.25.1728173768654;
        Sat, 05 Oct 2024 17:16:08 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:5ccd:eb23:b5da:b9df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm18231435ad.101.2024.10.05.17.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 17:16:08 -0700 (PDT)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] rtc: rtc-mc146818-lib: Use is_leap_year instead of calculate leap years
Date: Sun,  6 Oct 2024 09:15:53 +0900
Message-ID: <20241006001553.7430-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The is_leap_year() for determining leap year is provided in rtc lib.
This uses is_leap_year() instead of its own leap year determination
routine.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-mc146818-lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 651bf3c279c74..ce4d68de05831 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -232,8 +232,7 @@ int mc146818_set_time(struct rtc_time *time)
 
 #ifdef CONFIG_MACH_DECSTATION
 	real_yrs = yrs;
-	leap_yr = ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
-			!((yrs + 1900) % 400));
+	leap_yr = is_leap_year(yrs + 1900);
 	yrs = 72;
 
 	/*
-- 
2.45.2


