Return-Path: <linux-kernel+bounces-366722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDA99F910
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07841F23852
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6471FE10F;
	Tue, 15 Oct 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zx1Zwor5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E11FBF62
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027668; cv=none; b=uMfyPSDBuOCHSPn3epDsJDdodDchZPQ1ubJw0U7vuevTMK+L6t1ugjRwl+rxMdj/66ol6ZxsV2CZgkZB/mCjY6FQv1IKGrJgWH4YIaYY/Fv1NkrBL7liXAQabWBxt5TSI1rBHccyEpIorV/J63jVe6z+LnL41NLPOYFPeywH9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027668; c=relaxed/simple;
	bh=Grd/N8W0rev00HUr5dtPwxf3w+rjHgNGnbAvxUJ+X4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bR9Kp/NdZLxQK4dq5dz1KD3kSJ7OgpD97PmfRYjWv17PGnJeJhlLmmdHUrtF9P/v/dS+Wim3bvD2Lq6NWdHSkuHGne3InDqrwpO2TmlphL2JM13HQPcIoX1obG6PJz6w5nmb5m2wSIWtP0zN18e3e0W3UN4k/gakiULU6V6fUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zx1Zwor5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729027665;
	bh=Grd/N8W0rev00HUr5dtPwxf3w+rjHgNGnbAvxUJ+X4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zx1Zwor5URoO04sYFWVQRp6urGyUKgY4X47uyhkAZtvXe3L0wkmLaUYcA0N8hK3wZ
	 gk7R53CKK211eAkhFQ4YXXVbvW8LgoU2xIhs4GwZrvwUl48xLfRB0soiEhZuxvETSE
	 NAZNEg9mcQ2w3fOs8v1+ySf5DGBV1zSCsaG9DLainIdSFvVEs0We+eBh5siX5Lkzk3
	 D4P27vlfJjfhz7J6r3g6dCM8Gdkz/WGn8iWYywS2PpJET/fRgGt8Ec1P+FkqWLCELt
	 F+yTAMZ+pH8WaEzNufTVSth4YaRZE6E0X41qvSh2katFeRbUQ/TOdUHhpN9doccMae
	 ZpkYqW89P/qhg==
Received: from [192.168.1.206] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E9E2E17E374F;
	Tue, 15 Oct 2024 23:27:43 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 15 Oct 2024 17:27:18 -0400
Subject: [PATCH v2 2/2] driver core: Don't log intentional skip of device
 link creation as error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-fwdevlink-probed-no-err-v2-2-756c5e9cf55c@collabora.com>
References: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
In-Reply-To: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 Jon Hunter <jonathanh@nvidia.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
SYNC_STATE_ONLY device links") introduced an early return in
device_link_add() to prevent useless links from being created. However
the calling function fw_devlink_create_devlink() unconditionally prints
an error if device_link_add() didn't create a link, even in this case
where it is intentionally skipping the link creation.

Add a check to detect if the link wasn't created intentionally and in
that case don't log an error.

Fixes: ac66c5bbb437 ("driver core: Allow only unprobed consumers for SYNC_STATE_ONLY device links")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/base/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 88a47a6e26d69aacbaeb094c42be4fcf9dde4a6b..fc992b5a2f295d6bb23f50d32e5fddc59b32b840 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2189,8 +2189,11 @@ static int fw_devlink_create_devlink(struct device *con,
 		}
 
 		if (con != sup_dev && !device_link_add(con, sup_dev, flags)) {
-			dev_err(con, "Failed to create device link (0x%x) with %s\n",
-				flags, dev_name(sup_dev));
+			if (device_link_is_useless(flags, con))
+				dev_dbg(con, "Skipping device link creation for probed device\n");
+			else
+				dev_err(con, "Failed to create device link (0x%x) with %s\n",
+					flags, dev_name(sup_dev));
 			ret = -EINVAL;
 		}
 

-- 
2.47.0


