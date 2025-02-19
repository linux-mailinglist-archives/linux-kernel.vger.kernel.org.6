Return-Path: <linux-kernel+bounces-522539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60034A3CB97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E3C3A9D12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D162580F8;
	Wed, 19 Feb 2025 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZvfW1Bj0"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB772580F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000967; cv=none; b=TKw3p4fcJm0gFc99dUrAGIzPOdfmNgZzNpHbCbD8V7npUICaR2QPXCDIvpf/ms0J2Vlh/f2ull5ClNJ/IeoDQpp8C8nHV3/Q6t6IAdwnjXXdPjPKPdCoiJBO3LonV2F3RW6sRSylWGWZiF1Za2Gzuyv5BDP5AwgX9wPwxvL0MQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000967; c=relaxed/simple;
	bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnXiYx9M5SQfatEtQ3JN6SM5G7Ijz8hnZ+JNleJYvbUQgu1Rea+nBJN2uA3WSxRFXBP3MQmbhIhGAi7OZixOTIB+9vNaR7wOGKmMAdJTsoDzgIKZC3P73Mlt7GpgKPPLQmfN3wnoQIq254t1FWrPwUamwe3LAzgrJl++42tj8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZvfW1Bj0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740000960;
	bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZvfW1Bj0R7UgBizBGX7kxmG7O/q6NvCla0YmHwrq25t6SiGZZnvZ40J2DFlrUE0WV
	 o4hidc2H0XAHZvdI30PnnlZ97sPVYs/dKEmGIElf+/v8tmZgzYzg3zqNwDyWU6/7Ou
	 EPChXXgfZrOgqsVQ1PPP6vRbbRmHiNyhp4+TEjbg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Feb 2025 22:34:51 +0100
Subject: [PATCH 2/6] sysfs: constify attribute_group::bin_attrs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-sysfs-const-bin_attr-final-v1-2-02828d86af3c@weissschuh.net>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
In-Reply-To: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740000960; l=1921;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Yd21h06QtpKZ5jDPU1XJdXBSUmnuAlVUN80oCBhEekk=;
 b=YD5xDuyaaHZH64cU/E/gZ7wdbzE9XIpOjLO+36GIMio4S5uQK2OxheiW1qfzQKlWOKFGcY+kl
 7xUc3pCsSmrCnJndbKDqETawF9d/hgoccXJnD8J9A75bvxI75dkQhfZ
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


