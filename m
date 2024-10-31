Return-Path: <linux-kernel+bounces-389892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23AF9B729A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B9C1C22D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774013174B;
	Thu, 31 Oct 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hqz69wnP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE527E59A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342668; cv=none; b=amAxASRh1glpQ9iwo12MaLVTLRt7BRqVeWhDRWKxqNL4SOQUpJX9Y1d7q6wspguX2PudeJl50egghokG1p7gCRzaaBKrzE+j4Ku44BeK9GFBlTQxWqNnmcGVhm1dFFmrTnY7I1fJ7i65KI6ylphn7KsWyj3JTwuJ7egYfkNLddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342668; c=relaxed/simple;
	bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPZ13rBv+5LJPZ6BNA+Cy1Uqe1zthGvY/rD6AWpJNT1EwXEybcN9BkpzG+Wu7sOvDywx1bBMRBcaNV+3TrtFC9SQzTsO8DApd3u/oU4mGv3LoSrHogxi3zR8GFxJ6WnapObnKCyGVRXb9SGLDrzQ8DtA489WhO1jWCmOTu+Qdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hqz69wnP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342661;
	bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hqz69wnPhwAu/R2yl9FafiTmE3ftGMxNvniwFW7b+WBEfEHWJkTJnzfh+AMT4PUcp
	 fxwN6Y33Y4av+3Iz4J1U7oNqe9D66o9anO5fv37wKpz+15Hwya8iTuzvXYMLoZUxq+
	 DYW6C6y2ytQkhHPHsXxZdV1LgEODdSAbEZmKg4Vs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:51 +0000
Subject: [PATCH RFC 02/10] sysfs: introduce callback
 attribute_group::bin_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-2-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=2296;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vzqsMVfnVQ7g+xXQgYvHKh8WFOGMi08tymfd1lvAle8=;
 b=jv82MGxDAxK1IVQpXdQfHZBNa86gVEhZFlqE6iiE9c2P5m+0L+5OaEswu8Yg/0Z7iuTnWkY16
 z1sOpxMuxN0AHDvSH9oXv3mmJPSdJ4XbY6qZXC+cUQTO+BM5yv5JV/V
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Several drivers need to dynamically calculate the size of an binary
attribute. Currently this is done by assigning attr->size from the
is_bin_visible() callback.

This has drawbacks:
* It is not documented.
* A single attribute can be instantiated multiple times, overwriting the
  shared size field.
* It prevents the structure to be moved to read-only memory.

Introduce a new dedicated callback to calculate the size of the
attribute.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/group.c      | 2 ++
 include/linux/sysfs.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 45b2e92941da1f49dcc71af3781317c61480c956..8b01a7eda5fb3239e138372417d01967c7a3f122 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -98,6 +98,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 				if (!mode)
 					continue;
 			}
+			if (grp->bin_size)
+				size = grp->bin_size(kobj, *bin_attr, i);
 
 			WARN(mode & ~(SYSFS_PREALLOC | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c4e64dc112063f7cb89bf66059d0338716089e87..4746cccb95898b24df6f53de9421ea7649b5568f 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -87,6 +87,11 @@ do {							\
  *		SYSFS_GROUP_VISIBLE() when assigning this callback to
  *		specify separate _group_visible() and _attr_visible()
  *		handlers.
+ * @bin_size:
+ *		Optional: Function to return the size of a binary attribute
+ *		of the group. Will be called repeatedly for each binary
+ *		attribute in the group. Overwrites the size field embedded
+ *		inside the attribute itself.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -97,6 +102,9 @@ struct attribute_group {
 					      struct attribute *, int);
 	umode_t			(*is_bin_visible)(struct kobject *,
 						  struct bin_attribute *, int);
+	size_t			(*bin_size)(struct kobject *,
+					    const struct bin_attribute *,
+					    int);
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
 };

-- 
2.47.0


