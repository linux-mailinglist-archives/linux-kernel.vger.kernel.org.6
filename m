Return-Path: <linux-kernel+bounces-547064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39173A50297
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4D1889AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403424E4D9;
	Wed,  5 Mar 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czkRAAG9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1F1EDA2D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185846; cv=none; b=g2pT6jKwTavuuMRcSJGW9VgeYAil6CjFhNsqQKFokys8o8t2gRoFqvbr7X9zP7F92K+8VSySqpK8B70qDeq2Mmvcwe8w5R5IgYvKsBLaO48v42dINm7xq27kkFQaHic9ydZMPah1mn9V//616E+kJ0m7RjoTQ3DIiLAzn5p1O3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185846; c=relaxed/simple;
	bh=khTfYbS7TTRK0cngWDGo3k7vxdXzMUP1uxbMhY3ktDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gioz6L8iN1orMMY3XdNow9gS2YJgMJqE+kC9dlOM0lT4KDdoH+9BE5KClrgycG6N59CuPxPr20cayZU46OjR+RcONAJD3c4jQ/RI7eYSdO1kJT73kWyTk3t2+oNYuKBz62yKnuS+7gq0QdNj91oh4xuHv3cGVRdojBJerDQe3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czkRAAG9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394036c0efso43967965e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185842; x=1741790642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTXHQ//nEUi07Uq1rIglvGA2poPkXrtAOXEjlPFl8vo=;
        b=czkRAAG9xKXqTKY8d8c1phw5mbrZILIoemBlaxnLFCR2MvrFmA7bftv95XVdFsVQff
         vrdmNYbEcN0lVP2vSHBiUcs0ai5pf9a4vJmNRUNZLjotuZf+1A0GuEV22MF6yjZrwgb1
         DBrg0oTd0vRvKwrtrYoqFlqXcDZkeywX9t79ePFdmGblnxrDy3UnIBlacWAkJ295zN5i
         SCHOUkRW1/LcsXX/PGoQd0Ff+VR8S4Dl3/iPzaUhteJJz4iyKCVZ/8E5Vj2DQ1s0UZdL
         eEA0mQeoaV+m3g0OlGXsBYH3XCgeVNLwassZ0Kvw6usRk3C6wqq01rKfrI6SIO6O1m0+
         I7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185842; x=1741790642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTXHQ//nEUi07Uq1rIglvGA2poPkXrtAOXEjlPFl8vo=;
        b=EGwFGtLWsNcl/+cDZjXF2p8BXbJzqzaQrH2bEOeamyflQHocK/qjYwzVFm97d+UTwK
         4OiXvHJcRF0zzFYxFr2RWWHZR9bdh3m1zPJYZtQhZGjY+xk+fbvM1KETWQkSgpR2OO2w
         EAZkVjAR47N8O58BCiy0HD5Y4ID1emytIMoZnDuyvzgK7Q69kgnFAjtTPfMVYjXiJWK4
         TJPyu2abrHaidfnb1e3wG9EErd2hd1fDW+UhJBqsZ6mGxmAdq+YPuF1KrOrNg90H25xq
         Y7cHeDZugdvUxgwGpSXBNZ2J3cMA8eLhjm6Fk5yMqQj7UzqRvH0PbFW6uFMNNLBb+txN
         NaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFjPzsP7OWUK9iKzhLvtQfINIg3OaCoFrGIFbPQni/hakKmm+e+6k2ZU8uDH7Opb4DGyQmBRlf032MasM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKIBmIeK7XN8nkhgMouPUO1Zqqy4/g6mFj7vGTUhL9pZpL7zm
	6nEHhVT4bTLDuDV4xdM02PIqK8pnSh67u2B4C7tLof5ParDeornF
X-Gm-Gg: ASbGncvSJJhcdo1aC+/wiJ50+9Bngt1ea00fFctL4/3GBMSzX4O2Jz0SNRunP43qLMX
	I8L1rJSNKP7z39pNXzQnN94XCwj+cZEReWyRg21gEut6sVj9k+KgN+RnE7HJiGZ3tMzdk5mmqyn
	fhdt2UknO2idfuFckgKRrOXi7BJ+g+ZxzUBlF3nPR0gzpk6Gaw8VCGShlV/LAvHFu0Ve24FKaYo
	XJYrLayaOi5kftJxkBxKAnGb0eGYwgrlOAGe2g3WkeKqVj1D9cpwjprqrLsAPfMvSij8kx4gbLL
	J7ZiU8kY+vs66sE/vIA7vNs7ifYHv3d4dpoGp1f7XuztswVj
X-Google-Smtp-Source: AGHT+IFGQUVETDs+aLlL7dxjD2415mCZr3U/Vg5NUkmwRGmaxQKvyXyLdfnVx5+BM6nipcBQc1kDzw==
X-Received: by 2002:a05:600c:190c:b0:43b:cf29:b577 with SMTP id 5b1f17b1804b1-43bd2891d64mr30345195e9.0.1741185842329;
        Wed, 05 Mar 2025 06:44:02 -0800 (PST)
Received: from eichest-laptop.. ([178.197.169.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435cd8csm19314375e9.40.2025.03.05.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:44:02 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	tharvey@gateworks.com,
	hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Date: Wed,  5 Mar 2025 15:43:14 +0100
Message-ID: <20250305144355.20364-1-eichest@gmail.com>
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

Changes in v2:
- Remove unnecessary check if perst is not null (Philipp)

Stefan Eichenberger (2):
  phy: freescale: imx8m-pcie: cleanup reset logic
  phy: freescale: imx8m-pcie: assert phy reset and perst in power off

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.45.2


