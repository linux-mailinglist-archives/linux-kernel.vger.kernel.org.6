Return-Path: <linux-kernel+bounces-403872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9872D9C3C09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66161C217AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555415B554;
	Mon, 11 Nov 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaaX34r0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F2155C9E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321220; cv=none; b=lHRj+A24xuoyTUgCu3kvW05Kj5BBQyOgBarN3ErUrKcitzDJ67MtBLxel75dt46L+cR0QBT3OFdSxIOpyRCuthr0mnNw1OjJWvF9NVwnLfr/0nH3qRYjEzsX7iuuMkl7LKT6VBsLkFoNjGkjb44k8vUllgrvgzodHmoPxMCCwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321220; c=relaxed/simple;
	bh=ANOdJENUCJKn1xcRedyJ5K+RBJ5qt9+JWo/NXTjq0QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jq0o+IGyqfNLyI4AzcpV+rVFfkzWHIDWC0fmv6hoQDNDnyTMQaVq343ecYrrSxYBz2el+uFxZhAwBVaKPuIO4cmazqd9dmxniM+F7johiPiIBhivLC7eX7lNZ6K7MlknqQMe4NUQYmR435paMa+hOXXP63mJ84F+fXXb+uxeZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaaX34r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BFFC4CECF;
	Mon, 11 Nov 2024 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731321218;
	bh=ANOdJENUCJKn1xcRedyJ5K+RBJ5qt9+JWo/NXTjq0QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GaaX34r0ckRSaugHwOWeewv6Bi7hxsFOoFD07JipTamVceJDLZULzDZqaBKLWppwE
	 BeVC7tz8/rneA0YWP8aN/q3iDRSNHD0dYdRoWDqIWsN5F38LRDgoK/NWZuUva3jDn+
	 Qor10e3tvz5pr5EUu2MnYN9yFeHFlaX3VfuLYKJ1EVo6soeo1HknBTAv4mp9+6hV2Q
	 4tmfKXeqkfZwTv7Nv6msD06e/NeylwpzQConxRBF2iHp4l/o+kaQFhm7OgqFlcisQR
	 s14Nl1XH312oJ5+vDoTtMgyocstpC9iXNLz0b8E4FVfs7QgFgxqQ6ka22/bjj17550
	 p6G4gp+2HYg4g==
From: Arnd Bergmann <arnd@kernel.org>
To: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cdx: constify bin_attribute callback
Date: Mon, 11 Nov 2024 11:33:24 +0100
Message-Id: <20241111103333.3355250-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This one was missed in the treewide conversion:

drivers/cdx/cdx.c: In function 'cdx_create_res_attr':
drivers/cdx/cdx.c:773:24: error: assignment to 'int (*)(struct file *, struct kobject *, const struct bin_attribute *, struct vm_area_struct *)' from incompatible pointer type 'int (*)(struct file *, struct kobject *, struct bin_attribute *, struct vm_area_struct *)' [-Wincompatible-pointer-types]
  773 |         res_attr->mmap = cdx_mmap_resource;
      |                        ^

Fixes: 94a20fb9af16 ("sysfs: treewide: constify attribute callback of bin_attribute::mmap()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cdx/cdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..316bd89a95ca 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -707,7 +707,7 @@ static const struct vm_operations_struct cdx_phys_vm_ops = {
  * Return: true on success, false otherwise.
  */
 static int cdx_mmap_resource(struct file *fp, struct kobject *kobj,
-			     struct bin_attribute *attr,
+			     const struct bin_attribute *attr,
 			     struct vm_area_struct *vma)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(kobj_to_dev(kobj));
-- 
2.39.5


