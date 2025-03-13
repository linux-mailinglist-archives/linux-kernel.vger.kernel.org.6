Return-Path: <linux-kernel+bounces-559850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAAA5FA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDEA1896878
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBF269CF4;
	Thu, 13 Mar 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="F2D/GSHd"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078E268FFE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881482; cv=none; b=LDiF58Qn7CazJ0waUR4Gqfdy8OoCw+5gXo0zxmsBnNuu2cayj7/0NN8rQO8EtJge+Wl0QzuuNn1aNqwcSmdRlAiGgCNdE/VXLDHNIIm86rAQ9qnJ5s9O+deK8OgiDVxL2k5B+MS1jg2cFxvAi3/HzjbmxI4d9gBJcVZdRmeUXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881482; c=relaxed/simple;
	bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8dB2v9vHdU64POsMJMPCwB5YyLBJipY+GUioiJwJBV4sksjBbvmUMBLILGa5Uwgy38ZkIocx7h0nrhS5S1ObCTbCsSUMp+jb7UVB/jAXdwJ4z4FjusBk1DWxkLgrnWd1AUo6XUsD9xWy6jfi8PQfKnni/VdpqO7rgbfiYkGP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=F2D/GSHd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741881466;
	bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F2D/GSHdx5G9UuRWeQNrCpRh+YvYneekuD5yCT/iXqeNjYCkue6aM6FD93woVxL2O
	 2l9UXDlwX2uDajBBecDnMR9z4C7W9NYgpeh33lo85WcgwKg/9eoqecZNUhcVyTU7iP
	 OS3v9uc7jjhjVgASva37DcCEn15ZtJ3vduQInegA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Mar 2025 16:57:46 +0100
Subject: [PATCH v2 2/6] sysfs: constify attribute_group::bin_attrs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-sysfs-const-bin_attr-final-v2-2-96284e1e88ce@weissschuh.net>
References: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
In-Reply-To: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741881465; l=1921;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
 b=N+gT16M0u0I9fBqoahXatpwjUHXPpDvgsbfjGN1s5G7OoK/uiUVXjeWXi8UG3VjOuAuMAHx+k
 rlJR9n9wndWDYV9cVyrQdrr8Gw7t7hHmue0VDTfbmEHOKhNM3IcosZ4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All users of this field have been migrated to bin_attrs_new.
It can now be constified.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/group.c      | 6 +++---
 include/linux/sysfs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 8b01a7eda5fb3239e138372417d01967c7a3f122..2d78e94072a0d4ed957560c60cc3c5dd49ab6fb4 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -21,7 +21,7 @@ static void remove_files(struct kernfs_node *parent,
 			 const struct attribute_group *grp)
 {
 	struct attribute *const *attr;
-	struct bin_attribute *const *bin_attr;
+	const struct bin_attribute *const *bin_attr;
 
 	if (grp->attrs)
 		for (attr = grp->attrs; *attr; attr++)
@@ -47,7 +47,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			const struct attribute_group *grp, int update)
 {
 	struct attribute *const *attr;
-	struct bin_attribute *const *bin_attr;
+	const struct bin_attribute *const *bin_attr;
 	int error = 0, i;
 
 	if (grp->attrs) {
@@ -521,7 +521,7 @@ static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
 	}
 
 	if (grp->bin_attrs) {
-		struct bin_attribute *const *bin_attr;
+		const struct bin_attribute *const *bin_attr;
 
 		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
 			kn = kernfs_find_and_get(grp_kn, (*bin_attr)->attr.name);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 576b8b3c60afb382e4ce18247fd5a3d50f08d579..f418aae4f1134f8126783d9e8eb575ba4278e927 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -107,7 +107,7 @@ struct attribute_group {
 					    int);
 	struct attribute	**attrs;
 	union {
-		struct bin_attribute		**bin_attrs;
+		const struct bin_attribute	*const *bin_attrs;
 		const struct bin_attribute	*const *bin_attrs_new;
 	};
 };

-- 
2.48.1


