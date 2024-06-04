Return-Path: <linux-kernel+bounces-201413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC518FBE2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8412846E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351214BFA3;
	Tue,  4 Jun 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cxiG8SdG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E413F441;
	Tue,  4 Jun 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537332; cv=none; b=TRSanqnax7f7R+Pv5/2gQEIEa4Ojm4/Ceu6fw5J+GIuzwgIfvCDFVsKKvi5OQhkudLHMOB2PuvIWAHyYzCEqiqQztk52dgBBjIRI9QDVpUyvBdRKcp0c0oujgHMMuovqQHNj5S7Eq/Yucf6aJjKjV3OCuxvGSOcjrT8U8/e+cP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537332; c=relaxed/simple;
	bh=U+/xP7FPR1Va2ibQtwhUrMiYNd+agEU5mpB8R8Ny1fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pfxub6iJyorr8rs4+7w920lWhIWu7TYsKl+EYF5WtnRIstHiPMwX09KeTy7zZ7tvJlfMfmvAzFo9WDs8F27Q9ZOltwoCBwc+cvoOTc7B0m/ZkvXZKa801w19R5v/fHXz3dCEUEtMNT8qfQ4zqM4WTx5ormclBZZkBwDmnWhxlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cxiG8SdG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717537318;
	bh=U+/xP7FPR1Va2ibQtwhUrMiYNd+agEU5mpB8R8Ny1fM=;
	h=From:Date:Subject:To:Cc:From;
	b=cxiG8SdGbffq0IP/K60LjvQMoZuXfF9VlBHJHBHBimIuC9hX867cyKpeqi/It3YXn
	 Y8DdIfkXCE8v2BEDNJ8LnGEw0pqaifzN2Y7peVU7zw+mUWhHFvdMLQffG0ByYp28wQ
	 ZJC9yLocu0weBORtKEe1B2j61F0NPv4wrGizSe64=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 04 Jun 2024 23:41:24 +0200
Subject: [PATCH] platform/x86: dell-pc: avoid double free and invalid
 unregistration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-dell-pc-double-free-v1-1-6d81255b2a44@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAOKX2YC/x3MOwqAMBBF0a3I1A7EIKJuRSzyedGBoJKgCOLeD
 ZanuPehjCTINFYPJVySZd8Kmroit5ptAYsvJq10qzrVskeMfDj2+2kjOCSA0bugjRmsDpZKeSQ
 Euf/rNL/vB4HNp4BlAAAA
To: Lyndon Sanche <lsanche@lyndeno.ca>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717537318; l=1480;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=U+/xP7FPR1Va2ibQtwhUrMiYNd+agEU5mpB8R8Ny1fM=;
 b=iaB24Nf+P309WK2URNeou3bzhkdXFD0sR5Z+a57xBechbmDCLNNW5r2k/7x1TmJktxxELBvBn
 JZe7ZBueK5/CBJtn7cbLRibvrSAsJUJeW2BF7gv1+XkNwNZ5o+xEsu8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If platform_profile_register() fails it does kfree(thermal_handler) and
leaves the pointer value around.
Any call to thermal_cleanup() will try to kfree(thermal_handler) again.
This will happen right away in dell_init().
In addition, platform_profile_remove() will be called although no
profile is registered.

NULL out the thermal_handler, so thermal_cleanup() avoids the double free.

Fixes: 996ad4129810 ("platform/x86: dell-pc: Implement platform_profile")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Currently the call to thermal_cleanup() in dell_init() is completely
unnecessary. But I guess more functionality will be handled by the
driver and then this structure makes sense.

This is untested.
---
 drivers/platform/x86/dell/dell-pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index dfe09c463d03..972385ca1990 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -261,8 +261,10 @@ static int thermal_init(void)
 
 	/* Clean up if failed */
 	ret = platform_profile_register(thermal_handler);
-	if (ret)
+	if (ret) {
 		kfree(thermal_handler);
+		thermal_handler = NULL;
+	}
 
 	return ret;
 }

---
base-commit: 0da7a954480cc99978e3570c991e3779e56fc736
change-id: 20240604-dell-pc-double-free-e8cf2aa9b2fb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


