Return-Path: <linux-kernel+bounces-554196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B33A59476
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F4B16CE62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FA22A4DC;
	Mon, 10 Mar 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqc9I92"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1C227567
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609670; cv=none; b=Y7UMbXyS65jV1JBIwmBJm18bb+n+VjDH/Ts15rhaM1O71H8YifpFHfAa2iubTfSY9fJuVzpnfg20jrAPZOBSl63Ibh9YS58O2CeI05+S9yJE+qvpv4SN4j1M+9CncBLC6SzIlASENsda0xAyW0dNCxmGACMj/avGf9kfroe9ffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609670; c=relaxed/simple;
	bh=/GglX1v0AV4sIr5Y7bGG0tbMg9+k7e9ag9LwxmbYDCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqBZlscGt87SSt0pydWMI8+bAIs8tM7WXeHLo0sGQx10TxQ0DWGrt3qf1tSprlirciAvEFmXsulDfSGp8TjfHkhcnjI9FmKUqKgHdxP/6SycPZYzH59lwlukpclbAYxwqOdCr01ETbiQlCbsG0ADc1oyyhvg32dI8LX3NUt+ajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqqc9I92; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so7324055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741609667; x=1742214467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0gVa+47vgpIskiaBk5o99cR3lWwJb6rgWAQDG1BpiA=;
        b=iqqc9I926u8Hl6JHPvn2nvWWSvHqW7JZLznRcooBQQFDwYIHNzRfaYWXuQvEMc0TkI
         QawQzActWKEx5X72pB2trrjDetet1jxfxmDeTmLxACsLJQyNVgcqOybaHyrjf8lMd96d
         DjRhY46gIp9ewcxv8aUEyjf5IKZyEQxFaE2FLcWNxyg9/l5QDuWd9SQTBX3ahVoxWwAj
         qP09q+L9AfCgp8i0lgCrFcm2Jt1PCMMrw7+NrVZkNCoR2ZBGw0vN0F6fXRgBixRbAnBc
         QZzPeDEWG6wLMc+ODiGxGWY9shuadu5GuBmF3/E0xqiRTiRDGmc560lGIUnUkRTn1Jw3
         kXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609667; x=1742214467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0gVa+47vgpIskiaBk5o99cR3lWwJb6rgWAQDG1BpiA=;
        b=VlmnbZfk9HKz6a48cksqeWL7yBMJ6/kPH4v3Iog60fUJ63l8pGWE6ljfVvlNHLg5us
         4KyqXN4W6SRzKOTTKVX9s0RMKOmSz0ctYU1Mj0sdiZdLcjbNtQ3nmnPahLzfvQmS/8x3
         tJU37+OeugUdCPGaeihA3sH4PDe5oAB/YjeCzQeoLetF4dtNYshRpH8lEPwMZIW888AF
         bVEBSkGK2W3qsYusRgeJSjMge222NHH4r7tHNDDb27botJOBOkwBoM2bAMfVmt3q3g1M
         naMMgeu1+4f/vcreRu8tjfWrzNr4fQK0CxqCMmyYjIJ2+oUEc8ZYY5/BNi2PrnoYVaTu
         Y+kw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Zqmwqr2F1886AWFpuwPbQ7yaqbhWWdF2gW3dAvq+RIBYMxiSAnO8GbwCM3YYJLM/EeBhs4f52c4hOQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIzcOP3yU5mkfK6CgWYrY/h9jon7SP26zvpw0RmdvooIvZFld
	KjlbypufPYIrsuZZ1PT5OirS0FSKUnXNazurpMYHmxCSZFKj2f2QlSUYnL0A
X-Gm-Gg: ASbGncsIl0BFPPzNhdL3QPX5dqfPJHcRsIj5UQvOpZkgu8zwGFTmiQMdHu/w0w6q60j
	P7hCGgzA+KKZvCg6t+3Y6KcgaMm805p64Y8WTByqG1Gvkl+bvKVWjQiS4b7RyxNKQ9nJ1BMr7zq
	k6UN1mYuttLrXhlHdj1dp5bRi0PrJA+vloGrk2aFtuu5AUkYMn3rnv9xnSHNxODuicK7sOK5RZ9
	6DwaDnCHscQghC81U83fjQQr5hZT9uEtXi9ZLKqdcZl7NZSp7U42zo3PTK5bj8XVLhpTyXUMOMt
	VdBkm93qcDG0HsHT8Zelw1W06OjVTkaDFekjQQ6uc8NfOnI78Vhu0qUuDEQ3+uBNE4K3EeMeLkZ
	Wc+kYU7U72o2PfQuwCvcglQsuvjE=
X-Google-Smtp-Source: AGHT+IHnfkFyUH7zwhO3UJXB4ON9kY20gf9Xj9a8RVVLTh0OxFR3WRoI6eW5/kVQ7doqUEWryYXkVw==
X-Received: by 2002:a05:600c:4e91:b0:43b:d116:6483 with SMTP id 5b1f17b1804b1-43c6021f13cmr85331995e9.27.1741609667099;
        Mon, 10 Mar 2025 05:27:47 -0700 (PDT)
Received: from eichest-laptop.toradex.int (85-195-230-40.fiber7.init7.net. [85.195.230.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd6530f26sm171963245e9.4.2025.03.10.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:27:46 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	hongxing.zhu@nxp.com,
	tharvey@gateworks.com,
	Frank.Li@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Date: Mon, 10 Mar 2025 13:27:02 +0100
Message-ID: <20250310122745.34947-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx8m-pcie PHY PLL fails to lock under certain conditions when
returning from suspend. This is resolved by asserting the PHY reset when
powering off the PHY during suspend. This ensures that the PHY is
properly reset when powering on again in resume.

Changes in v3:
- Update commit message of cleanup patch (Frank)
- Add Reviewd-by and Acked-by (Frank and Richard)

Changes in v2:
- Remove unnecessary check if perst is not null (Philipp)

Stefan Eichenberger (2):
  phy: freescale: imx8m-pcie: cleanup reset logic
  phy: freescale: imx8m-pcie: assert phy reset and perst in power off

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.45.2


