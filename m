Return-Path: <linux-kernel+bounces-383206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D99B1879
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B45B22F69
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05A1D47A3;
	Sat, 26 Oct 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpWrTX/4"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B61B641
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948845; cv=none; b=SUbtSYR0TlIYBSoIeXcTWVE12Efm3yMxohpUOExcH05ysWVsKSzHMwFd5y2itGUs+qdIX0EjU0+XcLF41fkxCIcZNkiS3ZDoO5C/cxUFgwKhSngqG/az9SADDozx5NSJshqqROgssPDYw0v7ONaeJFAhUrzGPNZRlNW+m24/nOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948845; c=relaxed/simple;
	bh=c8+/k7BJNftvRutg/hEb8Mzh/iKaLOW+ZfRh3yWd2xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljYgfQ9qg6T7SPq/O5sBYIoJ/NbZraomM0BUKfqPNVOyT0od6B+ep6OGypfLRtzKRpOU3OK4OsILsq115ntFxgoDQapXWiykrGf6OqgaAfwrFoN9PQvQ2fJZS1OMCIfRqg67u9R+ByBtJieNv76C2Vvy4CckS+AAkuyuwJRQVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpWrTX/4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4613162181dso11096741cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729948842; x=1730553642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZv8I36kWC6/J2DlG1AGKo0oUQ6LOxCOA4JeVAxdYxo=;
        b=YpWrTX/4Z3bxqyMx9A+z9BKP06XWfOjGjYySyt+HfHB913qMQi0Av67H/98/zW8RL0
         7SJ9DuFyhlmaPs9EUcyhorOOMGMvDVCNUqlUbxyYfU4mC4BeojuRfljOly4i4XZLFHiw
         iz12loekDS3tJcAJ2mw4g6kEmE/Gr3vRztoDXp9PrehepkTP1cr82vCsSlF7xs68H52T
         EgFbuvMITukYi9FoXAm5ZzFaImakcllkFrIolBewrDSM8XV1QY5XxHmfXVwLkomMTZ4x
         JdFLl6yJtDmK6B+LqRz7Ufz+MfEIpZmsomk0imTphuDrk9/RzvJYp9bngswVZ7lZmMdd
         WzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948842; x=1730553642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZv8I36kWC6/J2DlG1AGKo0oUQ6LOxCOA4JeVAxdYxo=;
        b=Jp5WLBNnLp0D2/VcUhgv+R08VDvuy2i2kwDhoyTLauCZxrgGSoVWG0eEm3OoPr5gRi
         A/i7eufwlAzQQg+EDa5Am967WzyHS/sQcCtct8Er1VDEr7qe/P3rmFCavUgzfuiX8hvi
         undc8wrtYm0Cg8JrTJSMBdUG9Yvc5kgeT9IpPlO9BcCukA3ssElETv85QqaStmvsAeUE
         bBhSLvRcq1KqRZWKg1nN/sQ3mqbzHyYXfzwnZKg7047yB1Cof0kAtalnjE9ldw8SDFqX
         M6r4HnX1CA/uWaHGZWszX1KwCRQHGVGjVjofhqg5176w8A3/IOTdcNjl91ilsWI2uyAL
         uS7g==
X-Forwarded-Encrypted: i=1; AJvYcCWDhR3iE5077VyR0kJlHG5j1ybe41jfYZi8f7AnA0Yh/2I/trtfWB31Lj8W8nzcCX4vOPliZUEbNcb3qCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEE6kRsmqUSzYm24S9jxaKFVm6sjWLC11zaOvZtdk+qzCb8Yu
	DMjIfITa2SnehSGaGs+QnT5e6Q9IZNFpgXHrBZpKisitUCpOTEIh
X-Google-Smtp-Source: AGHT+IHPI2RVPdbW/ih/p6cee6z8h93uWBx4fzfT592gJDHi3Jb3aeqMbYKbdKADAzmiW3s2JC0xtw==
X-Received: by 2002:ac8:584f:0:b0:460:a730:3176 with SMTP id d75a77b69052e-4613bfb6ce8mr40284151cf.11.1729948842179;
        Sat, 26 Oct 2024 06:20:42 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211a1b2sm16372741cf.12.2024.10.26.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 06:20:41 -0700 (PDT)
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
Subject: [PATCH V2 2/3] phy: freescale: fsl-samsung-hdmi: Stop searching when exact match is found
Date: Sat, 26 Oct 2024 08:19:58 -0500
Message-ID: <20241026132014.73050-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026132014.73050-1-aford173@gmail.com>
References: <20241026132014.73050-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a series of for-loops which check various values of P and S
for the integer divder PLL.  The for loops search all entries and use
the one closest to the nominal, but it continues to searches through
all for loops even after the nominal is achieved.  Ending when the
nominal value is found stops wasting time, since it will not find
a better value than a deviation of 0 Hz.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V2:  No Change
diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 412c03b7dcd6..121f67455cec 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -440,9 +440,13 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u1
 				min_delta = delta;
 				best_freq = tmp;
 			}
+
+			/* If we have an exact match, stop looking for a better value */
+			if (!delta)
+				goto done;
 		}
 	}
-
+done:
 	if (best_freq) {
 		*p = best_p;
 		*m = best_m;
-- 
2.45.2


