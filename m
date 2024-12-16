Return-Path: <linux-kernel+bounces-446780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673269F2923
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E4E1885081
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DB191F8F;
	Mon, 16 Dec 2024 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lW+vXty2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBA199240
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322074; cv=none; b=j1Cu1vZ5FiPBRDhvpc1ak5DDb/quzkrfzKeHfLuDurzY78XahlsEeq9OJM40nkUcIove+URlPC2aN79sLQ+gRko5q6NVXeHxyNo6yrgUEUEujix61k1LAduIubGAFq8vsjDY/tnVFG2TZtkVxk1WO+Utu81YeQkgOBDogLQVWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322074; c=relaxed/simple;
	bh=UwFlrZoaphbEMf2Wi/FBevBRcRQkiVMw7c3eq5eTCfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPD/SEA+za+m+Eg7dYcETf9ZzpKyPXufxSGfg5YPn0/HHpIBMwC8bo0Ap+pT0g+BYJOs90iF1uXGppKt8Lm9eLXz8st290YxnddlJDgVg/30+CycvM2gsH9CQKlJOSFWC/q7mGKtr42Ml9vRJ7+asypiriiGVwEpDiF0LcYCQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lW+vXty2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322065;
	bh=UwFlrZoaphbEMf2Wi/FBevBRcRQkiVMw7c3eq5eTCfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lW+vXty2mFB0zNdICvad95Ludo+LgrtTfz8STKo9jEiOQ82+B/j8YTemdDpeqKlu2
	 mlSFWQsiVDxdFOe+/cKTkPOZONRC7CgsMd9Jut75CpAGSlTMtNqJ25Uy+C7W5x1aSR
	 kUmqo1bl72QuGhEw0GYvmCYxgvfWRuciuR1MtZOw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 05:07:44 +0100
Subject: [PATCH 2/5] powerpc/secvar: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-2-bbed8906f476@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=2183;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UwFlrZoaphbEMf2Wi/FBevBRcRQkiVMw7c3eq5eTCfk=;
 b=CyAuDv4h7ejzrTBndYz5Dci7CbE7wh32OdcwjNOfWT70ARoUjG9JXQCms//SEBUcPGOHeEDGU
 K+EZ0j7voEtCRKMaq8Rw+vFcxnzP5U9SW2/4qkjKKfRCIZM5Lx+9CSX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/kernel/secvar-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index b7536fbe8c4f43fa0f523c64685167b8b9dfd5ee..afb690a172b4e281830d0dd18785f70e0a967d13 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -52,7 +52,7 @@ static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
 }
 
 static ssize_t data_read(struct file *filep, struct kobject *kobj,
-			 struct bin_attribute *attr, char *buf, loff_t off,
+			 const struct bin_attribute *attr, char *buf, loff_t off,
 			 size_t count)
 {
 	char *data;
@@ -85,7 +85,7 @@ static ssize_t data_read(struct file *filep, struct kobject *kobj,
 }
 
 static ssize_t update_write(struct file *filep, struct kobject *kobj,
-			    struct bin_attribute *attr, char *buf, loff_t off,
+			    const struct bin_attribute *attr, char *buf, loff_t off,
 			    size_t count)
 {
 	int rc;
@@ -104,11 +104,11 @@ static struct kobj_attribute format_attr = __ATTR_RO(format);
 
 static struct kobj_attribute size_attr = __ATTR_RO(size);
 
-static struct bin_attribute data_attr = __BIN_ATTR_RO(data, 0);
+static struct bin_attribute data_attr __ro_after_init = __BIN_ATTR_RO(data, 0);
 
-static struct bin_attribute update_attr = __BIN_ATTR_WO(update, 0);
+static struct bin_attribute update_attr __ro_after_init = __BIN_ATTR_WO(update, 0);
 
-static struct bin_attribute *secvar_bin_attrs[] = {
+static const struct bin_attribute *const secvar_bin_attrs[] = {
 	&data_attr,
 	&update_attr,
 	NULL,
@@ -121,7 +121,7 @@ static struct attribute *secvar_attrs[] = {
 
 static const struct attribute_group secvar_attr_group = {
 	.attrs = secvar_attrs,
-	.bin_attrs = secvar_bin_attrs,
+	.bin_attrs_new = secvar_bin_attrs,
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 

-- 
2.47.1


