Return-Path: <linux-kernel+bounces-446578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE19F266C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E99D1884F00
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5511B87F5;
	Sun, 15 Dec 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9WD4jT8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8851D696
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300370; cv=none; b=OYlFkL2d/9YrBdC4X0L+1yka4P1x+4a0AegbNT+QT9aOeBFLIkbZHtYj4pkm52SFMGNXolraKCmtfi8g/mlqKAkJH4WnmQwgOaBr9Yhi/PJo7L3AnthBYxuKlhEQrVhJ3xiSaK/lgdv4/dj7LJ5z1zcFvb3bAsRnqMYgdp0jrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300370; c=relaxed/simple;
	bh=i1lMoc4dH58y+8d7luRWSws20LuMilxHst2/L9mUwNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eov3I0SXPSpBAyuOyoQteRkoI7J8NQvpHQE10kGhFSHMRPLw97g+aopFz3R1ayOBuUbjiSF+uWRHVPA3EZIbYE12lIWd2wUAVzPP0lFQhn3WAY2KMhlQx/1uXgUe/3d8ImoZuYN/Nbznmqm5G+lpvNGon1n0QejDmI5HQLPFKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9WD4jT8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844eb33827eso75810839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734300368; x=1734905168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDIMOewigJmHzzSRfwlsgnwekYZKGWmSYwk2FpU4fjA=;
        b=c9WD4jT8E/dONd8KmbhUSz0bcU4chDXFnFzdJYfVh9MglitubVU74WGluGKKrolx7Z
         L7x38WaWhlPpDhwhq/XQAqYGXi/i0P/bmheoQnORbqN5ZJd2nSxu/ccYybem2YzKiFjk
         JekViw94KEFOtHE3/FGSbtPBcDU6+iIfJoH3Kgca3O+PmB/c+3TGAK1jSQf7AlN2OlYm
         2NG4Mipgv16z7HNzr8fVXRXBzXRLOLVAebLraiJOjx7wvnD1ZswN86s/4RYEHbdok6W4
         Q8C5gMQF6mTIk/W+FNhqpWtTPQys4YLyOAXOlzIyGAeJTF+8BicuoXHPUdYIzfA4Wh5p
         Fc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734300368; x=1734905168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDIMOewigJmHzzSRfwlsgnwekYZKGWmSYwk2FpU4fjA=;
        b=Ff7mrSTs9K7dOxjHXhzLU4snnaPmRefqUl+DfCRihdE7ND4D9C9oAQSSPxMpjGFVEq
         AD2zQWaU6bnlAYr/8/UD3S0MVaC5pHh1J6ZpbeeebVac5p+tN3V3fsGloHcSXFCg3hcr
         crn1QEXYeNShDdlr+FLMBqQX+MTd1ymkCevze0VVZHD1m0JbCfatO+ToDn30MRpbU0uD
         LtVQOg1TXkn0EfN07pXrG621aDmUIcOpSgs3TKBIPHHFFHR0eLNtxbRvXpojinZFzL2G
         xFOIGRQoa0n1HKq6m5LAk7POJzOa6nzKYAEoKWRMrKfxMpX57MFtL9v2uR0kSlwm+VCS
         H88g==
X-Forwarded-Encrypted: i=1; AJvYcCUUplFFSxy6sjx5E9nGGK6QCM7dMkFVgeMxO0S28M3d8mMdd0r83SrY4JKCZL2Hku9vQkQHwYRAxUPe+eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweu5Yu4SpT2u0yBuI9Bs9UMrZW3IFEkfP0JVesfYsmaZzN+bGg
	kxjXXp0OIPo8so1Mt4DDIEL7m+oYa9B6cTmu3ALSu7VsZoeg4jYa
X-Gm-Gg: ASbGncuNe106UCsJpYxyviGJLydOtQlCxJUcWnR0gOruT0qqZ8QSEEdsLSwsM1kX8Mt
	zEM1fWS3aG9Mwf9oZ8Vw3yBwi1Uwxwg9ori2kT0XojHDOWsYhbtpih5R+6QywRcJOgLtsYdrzWM
	Liwc5Xo+ug+Vkw8UhVDo1/MEcOwXmbOc4ofpeZ6q+cf9YjW8H9GfgStLdvOEQUDQBHY18A1wKSl
	m+jsEY3NZFS9Y8uHNeuXWyyd7NzTEZhjdAMWnhew9dCqQ6c4tsKEAhZL4aWjPkkgrAAScu6rVk6
	wd5FGK8x6sxSqrjhgRKfxDa90d20Xis=
X-Google-Smtp-Source: AGHT+IGpINEcA+1pBG6zS0mOq03qQ8d8/19Mh3Uf0RVNgHnIkRC5K4eTEFoLX5i2z93RtAGzoRv2WA==
X-Received: by 2002:a05:6602:1644:b0:83a:b8aa:ec0 with SMTP id ca18e2360f4ac-844e88ef8a1mr832233139f.13.1734300366217;
        Sun, 15 Dec 2024 14:06:06 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e03685ecsm914303173.2.2024.12.15.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:06:05 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: freescale: fsl-samsung-hdmi: Fix 64-by-32 division cocci warnings
Date: Sun, 15 Dec 2024 16:05:55 -0600
Message-ID: <20241215220555.99113-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kernel test robot returns the following warning:
 do_div() does a 64-by-32 division, please consider using div64_ul instead.

To prevent the 64-by-32 divsion, consolidate both the multiplication
and the do_div into one line which explicitly uses u64 sizes.

Fixes: 1951dbb41d1d ("phy: freescale: fsl-samsung-hdmi: Support dynamic integer")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412091243.fSObwwPi-lkp@intel.com/

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 2c8038864357..d3ccf547ba1c 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -424,8 +424,7 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u1
 			 * Fvco = (M * f_ref) / P,
 			 * where f_ref is 24MHz.
 			 */
-			tmp = (u64)_m * 24 * MHZ;
-			do_div(tmp, _p);
+			tmp = div64_ul((u64)_m * 24 * MHZ, _p);
 			if (tmp < 750 * MHZ ||
 			    tmp > 3000 * MHZ)
 				continue;
-- 
2.45.2


