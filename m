Return-Path: <linux-kernel+bounces-383205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E061E9B1878
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AC6B22F66
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B91D414F;
	Sat, 26 Oct 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W85PllWW"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95DB641
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948839; cv=none; b=f4lr4qtj5Vz80qEtRwJJLWPsG1+sVAfEC9I+q2rIL8SAerFmgdf8yGGv85vnIvguLlXzwoKCdYYu3AD4cZfhbdmJlK3kQeSc5b7IRYaVaq782pSISQQ+7zvqM1HLEFaQx+VZMx2kiLakEwU7RHX1thXcSDmxYmgpByRIJiH+Uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948839; c=relaxed/simple;
	bh=w25kIQWiNEHLq3jCKXw2Tpk94ikZJ6aspCavDcQxo5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzHML2aKS9J2WQlYc736BaOK0vSWOGz0E+kkvb+JJ0hVNrzO1dNXB68ZZ3B5Kdhgwm5z7Br0o+Ahsd6NzXu+L86nWx2qcX3vlPv4fjTgqzThOeX+X8+q2IcHKBzx+H/SW0q5lef0v6HdBxj4t5y0W1rqaDeHDu0KpSPsANfyjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W85PllWW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c1ba306bso18724281cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729948836; x=1730553636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uanSZJQklmRmS033W3BHPfWcyF9MpcVddO3gFoIl8So=;
        b=W85PllWW7TF3214na5EX8O6HhVFZvFOvQT5JM7nNJYsJKJT3rH7+YPDgyXHOIQmkIU
         z4+7dcVQPIPpPhPP4uTKaI8YpDuEzHv7NhrV8t4dXA8u9O61V1uWJHcRRXKDscz0Ip8o
         SkJF0f7PbKYEIS68fvUQ09erz5NuES6XbkqMpvSZS0gIWGMHkr9u71SAN0K/Vsaywtpp
         8P+JQWIFKQT2SSmqqlJEYqKeNTp+Bgw60pJ94vlCd1esJagiRRvCjkSu4V759ZQy6+b9
         I15/2BrZ+vJonsKG3z07eYKB/icpoIEtmEHFljFKl/rOdYVRLdSgsrAK8Emna7y4lHg+
         IQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948836; x=1730553636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uanSZJQklmRmS033W3BHPfWcyF9MpcVddO3gFoIl8So=;
        b=LRHg6QXcAW1fhKHAriHGoAF9qqMHoawj3kW//Huj4B2Nl2NRZsyXBDner7Fb5OHlrs
         Lj4H3ySDsOPwCPJCMgtMjQmpNZ+w7vLYzH517pboxejRWJeHAJq5e3jnc1ErTOXGGefe
         ycW7g2i8rJTSQYkGReyIugGC49wFWuWGAT28lDhArvrhkQ9VXPbp4nzCFM99/O0hiHcS
         UyeczeVs9zcEEZg+st/33XtIeQUg32rf0exL4B+AB/ZFzbiUMjlG80at8c2Cfd1G5kWO
         hqP4bmMWv4tqpYcYRZnz5HsNTeazcl2g6/iuKgEP4Sb9Fz1x8um1vIgJUsWPwMyqsvX6
         q6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVuHr6yf2lQNchsp9tH8F7TM/JoDMr7m8CYLdHSxrRnyQOSHlL5ALNEtQ39dOr2Yx5hKdFG206yVFQer6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp15S6IRssdTC/uzKKiOMAulyeoXUu9glLn7ns4teoAWUoI4k0
	pnlZRYxqY1zyLDlN/ggslwaxT6QKVqj2cJvms/sbgQjuZrG8J+oe
X-Google-Smtp-Source: AGHT+IEn9n2HjtCV52Y/1LDU/GvFsvByPZwyUUanUzueyZ+W9E7vF3ceWB70i2LUB7RZuEYbi4EJdA==
X-Received: by 2002:ac8:598f:0:b0:461:18fb:f0a2 with SMTP id d75a77b69052e-4613c1ba78amr42735431cf.52.1729948835938;
        Sat, 26 Oct 2024 06:20:35 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211a1b2sm16372741cf.12.2024.10.26.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 06:20:34 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer divider range
Date: Sat, 26 Oct 2024 08:19:57 -0500
Message-ID: <20241026132014.73050-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Integer divder uses values of P,M, and S to determine the PLL
rate.  Currently, the range of M was set based on a series of
table entries where the range was limited.  Since the ref manual
shows it is 8-bit wide, expand the range to be up to 255.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V2:  Fix typo in comment

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 2c8038864357..412c03b7dcd6 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -406,16 +406,15 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u1
 				continue;
 
 			/*
-			 * TODO: Ref Manual doesn't state the range of _m
-			 * so this should be further refined if possible.
-			 * This range was set based on the original values
-			 * in the lookup table
+			 * The Ref manual doesn't explicitly state the range of M,
+			 * but it does show it as an 8-bit value, so reject
+			 * any value above 255.
 			 */
 			tmp = (u64)fout * (_p * _s);
 			do_div(tmp, 24 * MHZ);
-			_m = tmp;
-			if (_m < 0x30 || _m > 0x7b)
+			if (tmp > 255)
 				continue;
+			_m = tmp;
 
 			/*
 			 * Rev 2 of the Ref Manual states the
-- 
2.45.2


