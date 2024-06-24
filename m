Return-Path: <linux-kernel+bounces-227487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46391521B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8231C21E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7019B5A3;
	Mon, 24 Jun 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LABlbFyf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008A19B590
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242482; cv=none; b=tCqXFrb7oGQipW61iqDfW9rrX0sBgquqfC/6YWz6zPqJiDPlmNRMhqdxw30Fq+UN1PEeo3tvmWgwW5bamFsMerQELrY1XVL1nhdZarZj3Oot17YNJNthM0XgShK9oI9QNTsSex5fG6Hn7btcqxAvSJlOKpdUAt+nbQAXTd0KAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242482; c=relaxed/simple;
	bh=hCnoEuFCTRQR9QbbMC3rjbRc7yr7l2zx0pRkaU7p//4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OVzILUxQ62RsA0OvpOiwSYdm+RTayYO5c7fndWcT0WopLsqQES3DwChlalPmqpVCJ/ZAhRPXm0LDRAC1LwpgYWXY+dZY/56zyHX5D/O4xcrFaAaoG04q5VeGgeC+iEyOjlW4vAGXoWkFPp167CdP59vlCQvJgbYdEUHWT5DhjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LABlbFyf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719242479;
	bh=hCnoEuFCTRQR9QbbMC3rjbRc7yr7l2zx0pRkaU7p//4=;
	h=From:Date:Subject:To:Cc:From;
	b=LABlbFyfHbekXgdIews0D1zN3a6fC1g+d//YZ6fcsS7yuWe2ZkPgZy0RAeLDuWxAn
	 ojN2T4m38/XuGfZAlZuu1BiVpaTj8ORfAREfyiLDELuQvboSPbX/hE1LJxF9qmtTST
	 iw+15h6eCTxXYf+3J5BPJL3hDGXlWWH4Mkvm4vFwLuLlWcU/daWTuz+fk7IJCotePp
	 zNykCG/eq/VOpDAeikOIGHhmYaHni/msXjotmNAdToonE67FxcaTlCed8nxO2oyX10
	 yUKknql+wBDv6IbUD7IhdRUoOvtElPCwH3T8vbqERrmHfbxc5cIs6E6k+A/n/v6Z5y
	 iz+nDLCvvVGcw==
Received: from [192.168.1.28] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0BA2337809D2;
	Mon, 24 Jun 2024 15:21:17 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 24 Jun 2024 11:20:53 -0400
Subject: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
X-B4-Tracking: v=1; b=H4sIANSOeWYC/x3MQQqDMBBG4avIrDsQQ3TRqxQX2vmjQ0siE7CC5
 O4NLr/FexcVmKLQs7vIcGjRnBr6R0fvbU4rWKWZvPPBjT5w/AmOr6YP75YXCKfMMOMwiO8jFjd
 EoVbvhqjnfX5Ntf4BpfuoUmkAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

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
 drivers/base/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..5eaafe3a280c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2187,8 +2187,13 @@ static int fw_devlink_create_devlink(struct device *con,
 		}
 
 		if (con != sup_dev && !device_link_add(con, sup_dev, flags)) {
-			dev_err(con, "Failed to create device link (0x%x) with %s\n",
-				flags, dev_name(sup_dev));
+			if (flags & DL_FLAG_SYNC_STATE_ONLY &&
+			    con->links.status != DL_DEV_NO_DRIVER &&
+			    con->links.status != DL_DEV_PROBING)
+				dev_dbg(con, "Skipping device link creation for probed device\n");
+			else
+				dev_err(con, "Failed to create device link (0x%x) with %s\n",
+					flags, dev_name(sup_dev));
 			ret = -EINVAL;
 		}
 

---
base-commit: b992b79ca8bc336fa8e2c80990b5af80ed8f36fd
change-id: 20240624-fwdevlink-probed-no-err-45d21feb05fd

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


