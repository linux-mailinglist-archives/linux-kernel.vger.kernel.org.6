Return-Path: <linux-kernel+bounces-411028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2289CF1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5315728C40D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FF1D5174;
	Fri, 15 Nov 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hbI5wds1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C11D61A3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688978; cv=none; b=R3PDO6v0fuYwDMbS6xO5XVufvB3a2iplmKPUihwdjsD1kHkgAw0MXUYwWDuWvfsDuGWzcsKqj8AgEWrsBrPFSSJ8LSzSpRqGkciDf+tTT9NnT+2Swl7zRx1tUByROPt6oY60J3pHjXULd86hkijTSKQO21nR7jxyhzr+U+QhRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688978; c=relaxed/simple;
	bh=sPKD1zDoxHZVvDcgjUz8ZlgiLrqEV9S5l8ikP1NDvkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHIbTd/LvD+Kudzhphxr01As12r0sKNWHSbE/sZbZ8ltU1yxyD1LC0Q+F8SO7iTv+/XzMOxWfVuKrYO0vIzKe6QuG33Eled5jpAkNzZxdTPselKhkZmbeYUk34gWivm13v8dl9ZYgjP26t7cFWKswnoCFtrst/GEWwV8jmATO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hbI5wds1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688975;
	bh=sPKD1zDoxHZVvDcgjUz8ZlgiLrqEV9S5l8ikP1NDvkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbI5wds15w223o1pr/ihfOjY3iljV6c8QwJsy/dJw3jxZELiwSH9MbUQWbkooql29
	 4HXHDWXJB/bczWrKWQ/0Bty6LoGBQ4bxpAdzzdzC+K81yl7PAAu7gnn/qwD15eFAw+
	 o+LHvzsMEilctjTA8JPm9bHZY5KHYs+66rQpOmC4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Nov 2024 17:42:48 +0100
Subject: [PATCH 1/2] sysfs: attribute_group: allow registration of const
 bin_attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-b4-sysfs-const-bin_attr-group-v1-1-2c9bb12dfc48@weissschuh.net>
References: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
In-Reply-To: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731688975; l=1457;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sPKD1zDoxHZVvDcgjUz8ZlgiLrqEV9S5l8ikP1NDvkA=;
 b=9iuUOtjb+ePL1j1lL+sp+67NbdkIfe6YM4jMa1jlzA4hDvke4xIfycrAEilVD+HzcboKU99MX
 N5g00bWE/4YC06GlMrPUn94SN/tiSiUx7V5bgH9CFchXxE0NIoh4uiD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To be able to constify instances of struct bin_attribute it has to be
possible to add them to string attribute_group.
The current type of the bin_attrs member however is not compatible with
that.
Introduce a union that allows registration of both const and non-const
attributes to enable a piecewise transition.
As both union member types are compatible no logic needs to be adapted.

Technically it is now possible register a const struct
bin_attribute and receive it as mutable pointer in the callbacks.
This is a soundness issue.
But this same soundness issue already exists today in
sysfs_create_bin_file().
Also the struct definition and callback implementation are always
closely linked and are meant to be moved to const in lockstep.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d713a6445a6267145a7014f308df3bb25b8c3287..0f2fcd244523f050c5286f19d4fe1846506f9214 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -106,7 +106,10 @@ struct attribute_group {
 					    const struct bin_attribute *,
 					    int);
 	struct attribute	**attrs;
-	struct bin_attribute	**bin_attrs;
+	union {
+		struct bin_attribute		**bin_attrs;
+		const struct bin_attribute	*const *bin_attrs_new;
+	};
 };
 
 #define SYSFS_PREALLOC		010000

-- 
2.47.0


