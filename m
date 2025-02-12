Return-Path: <linux-kernel+bounces-510909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF1DA32380
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B983A22FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B6207A2C;
	Wed, 12 Feb 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JByLCcXF"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F551F9A83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356307; cv=none; b=CmdpzoTh7Ec3dM2/cj6ZY9k3Yvgmnge5Dz3QuRgxBoZt3OhxVlnxzN5B/cdbTtKWNS1yqblTjG+KK8MW+MdwHKiwmjKI1YW85E2qK/wZPb2ojuhqZiZoH4X0TjLbMFxR0+3QUl7OYTeM1/yDxoktbYbpK0weDfk9p3etT/eWPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356307; c=relaxed/simple;
	bh=5W6BzPG2hRZ8COLZEvhH5hJcJ+5oLRg3oJ4rYZ6etPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IWsj57/zBM4IoVIqRVKSEYrLvxg82v+fIVXgEO73bhIJxveLVNS267/jZKrvgHgCx9iHp4BuKmprHAWrRJqXeoSMHnw20hu2PjNf/QagcfPn55yneh8mvZnooqg5UREj7ZjMNiJpJMa9Uert3epl3Bk3R7WMub4Hzp3G8g+Y/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JByLCcXF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D0E643296;
	Wed, 12 Feb 2025 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739356297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cvbObNoOX6mAmPbRVuK/WviLnwkc1Ti/J+blEwh3B7Q=;
	b=JByLCcXFoXuC/pzIL2lObRVhn65JJ2VnVJVzmHdNMcER2v7/skuD8QHDBylxZvCtgfdp5M
	yRJM7xjkhWCLOtxfeb1y3Z72DfHKowZM0F6+bSM6EJFyyv7y8VW4tNco/dq65/oy9pCEYC
	3nOc31POhniwRefqoZgHc91tysMkM4hPcT4LloQKqmXTA+Kfl7wpnvyIAVZw25OKBITNZh
	f7ClcERhcUdO9zcbCY+Dd4YK79UejfKh41g+B5TUYcNTnN63S4JBb6mKWQeaixGW14fc8g
	k9qKqIPhSyPuoN1g/pJ2i9qxTm5+gcRKlKCTNeZk0NstNieYZCIYu9RwPLzPDw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Feb 2025 11:31:34 +0100
Subject: [PATCH] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIV4rGcC/x2N0QrCMAwAf2Xk2UJXNwR/RSSELJ3BWkejc2Ps3
 60+Hgd3G5gUFYNzs0GRWU2fuUJ7aIBvlEdxOlSG4EPvQxtc1AUxfnCQOWm+Y5FEC/LKSQwfaqZ
 5/Ellwen9cscTk/SxI2IPtToVqYn/8XLd9y91Oh9XgQAAAA==
X-Change-ID: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae5f4aac0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeuleetffeutdfhvedvjeffuddtteejtdfhffdvhedvleevteekjeejgfejgfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprhgrfhgrv
 ghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
cycle detection logic") introduced a new struct device *con_dev and a
get_dev_from_fwnode() call to get it, but without adding a corresponding
put_device().

Link: https://lore.kernel.org/all/20241204124826.2e055091@booty/
Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f051981149dc5b5eee4fb69c0ab748a85956d..2fde698430dff98b5e30f7be7d43d310289c4217 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 out:
 	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
 	put_device(sup_dev);
+	put_device(con_dev);
 	put_device(par_dev);
 	return ret;
 }

---
base-commit: 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
change-id: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae5f4aac0

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


