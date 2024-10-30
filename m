Return-Path: <linux-kernel+bounces-389283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541929B6AED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123D628291E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876C218582;
	Wed, 30 Oct 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQDU5qN8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D46218338;
	Wed, 30 Oct 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308914; cv=none; b=qSQ2VQAja0agJp7sSiq7V9Gw+9YMh0Wl/DylmnAMKJpuWbY7KsASOvJLBT/1rK4rwhnH/x9GYO2iESBHKYNBnElmF9Pm8R8hEj5xdo6VLOlHFKviNgA8BHhihd2IORaLrJfgA51f6qPRoYi/bYAssPtauFDLI2zwnh/8/0OZQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308914; c=relaxed/simple;
	bh=dRU4Z6SU+AD1DSSqSuje13Fzrdgzrq3FixLvFAVYUJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K3GAXx+CKcKw+PYnYoDqq/rhFDiXQmoURTMQps6IAPt8mlKsHByCRuU/jsSkrSumwVTddIt6r7vyL8aWGbv6Vn7n7d3O8UchInABcmUJtwQF1kovWqOTvHTFgD1wV57Tzzs3dh3ALQtpJaAE8rQksLcg8laXXUA3NVP0vDbZeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQDU5qN8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e7e73740so55468e87.3;
        Wed, 30 Oct 2024 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308911; x=1730913711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/5UDsxfPHBMQmeRbidybeu9Vy/Aul+tK+2j7/QBWi4=;
        b=WQDU5qN8uSr3cvml5uu0dkstJfvwb6mvhr01MJtvsxNhibPQ/KtJVQb1CRCsJ+Jrq6
         e++BRc8Vbj1XABhNWJydXgwLetnBGkzTzlgVpYpwWQdPMXSHJZdZ8lDIEElkzQQQX1lZ
         p+yUaY1TqohVQMymzpMUYDTKIvjc1R4/Xqp4vuMHZkBCaL7HXRf4eHEXOHXyjvdo+SyQ
         g1HBNxOVzD4cr7kdkDLq3nLhfdHidh8zJjG4QHIt2/cmjegnOXv1O7x4QIT1OOnU+DKF
         2ks+Y9BD7KRm8BC8f06MZlFtixaaikX7GjM/XrsANDP5JtEDnsqbdLCXOhOUc77XZbbt
         XTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308911; x=1730913711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/5UDsxfPHBMQmeRbidybeu9Vy/Aul+tK+2j7/QBWi4=;
        b=Eu1do4clMfwn5JF/3E//JvFA6gBKTTb9W6Id6IcTC2RF295o/RPzLQlhbZ0F131+9p
         M05s1mPzmvCHYqXY3Amr1tK5cAYbu5B/j7zYh9vz/Wcku18NBZRhLDzMaVJoKmOJZjMP
         y7On2Ss2dN6M/jtoeXD70AEttjAS47KczBs1JG2xLevAZY93/7T66aPeDjHDpRO2glD9
         +Vs/0F96X56l8HGSaJkLgI1Q4WPGRErSeQLbYFdUfdDkEiF6+7iGyB5JrLjJ4F7bsohM
         C7kinmpQTbckJk1GSMTqqKY8p1pq7yqS0OXL31JZl+YpQREKFo0xyK6mG9ivztD4nCFx
         ua7A==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z+tsMX95wk8bvdt2uYUJdkjxsJ5+qgtCMxZiLeiuk+SijnTtM7eNNOPzV1RcQvSHcHlt/htgquLwfVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOo+GaGAdMsHYmMKsox5Ch5XPgQCqNSVuagMuGdI4KiMsZJ9X
	UGvrm/FcWRleEvaYGBdyApFCge64Bt/xiTV1dRYFfrGNa2qU3V2E
X-Google-Smtp-Source: AGHT+IH8B4T5YJk7NrR1WN+mYuaun5JVU0bH5CjIzvYTTJwdWyO9B1X1VXyvCbiFDw/HjK4C971ORQ==
X-Received: by 2002:a05:6512:2393:b0:539:e3d8:fa33 with SMTP id 2adb3069b0e04-53b85e9ca56mr2145315e87.54.1730308910485;
        Wed, 30 Oct 2024 10:21:50 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa611sm27217225e9.34.2024.10.30.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:21:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Joern Engel <joern@lazybastard.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: phram: only call platform_driver_unregister if phram_setup fails
Date: Wed, 30 Oct 2024 17:21:49 +0000
Message-Id: <20241030172149.3101873-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check on ret and call to platform_driver_unregister is only required
in the code path where MODULE is not defined. Fix this by moving this
code into the relevant place after the call to phram_setup.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/devices/phram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index f756c60a4931..b8bbc7ecbe95 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -415,14 +415,14 @@ static int __init init_phram(void)
 		return ret;
 
 #ifndef MODULE
-	if (phram_paramline[0])
+	if (phram_paramline[0]) {
 		ret = phram_setup(phram_paramline);
+		if (ret)
+			platform_driver_unregister(&phram_driver);
+	}
 	phram_init_called = 1;
 #endif
 
-	if (ret)
-		platform_driver_unregister(&phram_driver);
-
 	return ret;
 }
 
-- 
2.39.5


