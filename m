Return-Path: <linux-kernel+bounces-268116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A3942090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8274BB2300E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545A18C920;
	Tue, 30 Jul 2024 19:26:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E441AA3C5;
	Tue, 30 Jul 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367575; cv=none; b=W4fCVymt2qaY/UaMRZRJSFZkiEm/qoRYUxqmAfgAWiaEdYMot7SmwlZJ0kS1q1gvTquOQSBOgmgHiRzTcJd3GYuDktGMnp8p4np0aW134w75Q9WDiWZ1P1/tqAQl+01m79Ry8h09AKErkmbVgzsbULXw5p9eFsaVAjX2X9F5+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367575; c=relaxed/simple;
	bh=Vqr43TWMp2ey/8RIG6AR6Moccf1jabXlNXNjAQhYzso=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO/pldzawCJgx3C0jH7IP9rICsUndbUL3XWt9cH1zjOS9PWP4pBX5Ic8wpMZ443Z/spQhlgxsHmZQdk5eCAJ8XU2nr0ZHJ3YNoaGc1uObcLVZQoGz7VAQRaresFtTuuMX2reQS23JlkAIv4ID52iESvmqTJ1iVFgRRKYRgHt6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYsTz-000000003DV-18SB;
	Tue, 30 Jul 2024 19:26:03 +0000
Date: Tue, 30 Jul 2024 20:25:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tianling Shen <cnsztl@immortalwrt.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v5 2/4] block: partitions: populate fwnode
Message-ID: <3051ac090ad3b3e2f5adb6b67c923261ead729a5.1722365899.git.daniel@makrotopia.org>
References: <cover.1722365899.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722365899.git.daniel@makrotopia.org>

Assign matching firmware nodes to block partitions in order to allow
them to be referenced e.g. as NVMEM providers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/core.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c3..cd54300e1d621 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,8 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
+#include <linux/property.h>
+
 #include "check.h"
 
 static int (*const check_part[])(struct parsed_partitions *) = {
@@ -281,6 +283,74 @@ static ssize_t whole_disk_show(struct device *dev,
 }
 static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
+static bool part_meta_match(const char *attr, const char *member, size_t length)
+{
+	/* check if length of attr exceeds specified maximum length */
+	if (strnlen(attr, length) == length)
+		return false;
+
+	/* return true if strings match */
+	return !strncmp(attr, member, length);
+}
+
+static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
+{
+	struct fwnode_handle *fw_parts, *fw_part;
+	struct device *ddev = disk_to_dev(bdev->bd_disk);
+	const char *partname, *uuid;
+	u32 partno;
+	bool got_uuid, got_partname, got_partno;
+
+	fw_parts = device_get_named_child_node(ddev, "partitions");
+	if (!fw_parts)
+		return NULL;
+
+	fwnode_for_each_child_node(fw_parts, fw_part) {
+		got_uuid = false;
+		got_partname = false;
+		got_partno = false;
+		/*
+		 * In case 'uuid' is defined in the partitions firmware node
+		 * require partition meta info being present and the specified
+		 * uuid to match.
+		 */
+		got_uuid = !fwnode_property_read_string(fw_part, "uuid", &uuid);
+		if (got_uuid && (!bdev->bd_meta_info ||
+				 !part_meta_match(uuid, bdev->bd_meta_info->uuid,
+						  PARTITION_META_INFO_UUIDLTH)))
+			continue;
+
+		/*
+		 * In case 'partname' is defined in the partitions firmware node
+		 * require partition meta info being present and the specified
+		 * volname to match.
+		 */
+		got_partname = !fwnode_property_read_string(fw_part, "partname",
+							    &partname);
+		if (got_partname && (!bdev->bd_meta_info ||
+				     !part_meta_match(partname,
+						      bdev->bd_meta_info->volname,
+						      PARTITION_META_INFO_VOLNAMELTH)))
+			continue;
+
+		/*
+		 * In case 'partno' is defined in the partitions firmware node
+		 * the specified partno needs to match.
+		 */
+		got_partno = !fwnode_property_read_u32(fw_part, "partno", &partno);
+		if (got_partno && bdev_partno(bdev) != partno)
+			continue;
+
+		/* Skip if no matching criteria is present in firmware node */
+		if (!got_uuid && !got_partname && !got_partno)
+			continue;
+
+		return fw_part;
+	}
+
+	return NULL;
+}
+
 /*
  * Must be called either with open_mutex held, before a disk can be opened or
  * after all disk users are gone.
@@ -355,6 +425,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_put;
 	}
 
+	device_set_node(pdev, find_partition_fwnode(bdev));
+
 	/* delay uevent until 'holders' subdir is created */
 	dev_set_uevent_suppress(pdev, 1);
 	err = device_add(pdev);
-- 
2.45.2

