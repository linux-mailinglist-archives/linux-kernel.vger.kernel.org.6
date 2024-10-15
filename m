Return-Path: <linux-kernel+bounces-365606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC499E4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20CBB2288F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C891E9068;
	Tue, 15 Oct 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azOn6Rif"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D21E04BD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989997; cv=none; b=TCx8OahWpvMLqBiXMSUBKBIVIeqq2SnooM3iQKYweTEQfkFOdPRAo/sHHEDyCrFebFeVTgeM8Iwal96EMSs9PuEydzR6cKtJBMy0UJKTGU6rOCzLZCOdddPNg8sHpTGTZpdTYLOo/S1O5xThGLOJMrwW79iQDzMb0Ue6MUb9ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989997; c=relaxed/simple;
	bh=vvw4Lneim+ntjgIimrMOkUPQPuUv+sqngvDf164H9Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxlH7VA2G18n2ljKhGhgq5xtaTNLVweR1Fus5HAY7HS30vf8dTsDAoiddF8eCsCvC1EWhyUST18tVmwJD4Vt1VGnZpAhpkI9shY/ykQzlVg1YB344BpytxYij7HL7J+2TcRvdMx/Q4z2ymRmOGd3YWGLRPS6fUBzL4rkuUVte1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azOn6Rif; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728989996; x=1760525996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vvw4Lneim+ntjgIimrMOkUPQPuUv+sqngvDf164H9Zo=;
  b=azOn6RifWPYJSQcfkDk8ULdwKpbv/TJa7pFZ/7YU0UL+qPT1kWZuzw/r
   Q+Dv/LaZe3sEMliAqlMw/9Sw/T3a6FZ6XPLvGJmKZfiYJo3KNBnBRIUYK
   qSjiiv0cBA4wK3I2tvv8VPY+1YDV6OboHKn7ldFxK8PN/mjR8vATY91e3
   cC+Mu1SlOn40vNoZWlmXUt8xAv4QEd80WASJ7O6cr/KJkre8cVLpyhmjN
   /qwQqmHJjoTFjTqzp38Gt5y/7v/SocP+vUk+03Gx6hUcLjevqxBB3hJ9u
   0lvbKuirieDojpIEmOOgG1NhAd7fFNNM7qsHXrocP410lpBq+NqfRJ7++
   w==;
X-CSE-ConnectionGUID: l//1osEZSKmzfZ95Xu5Ufw==
X-CSE-MsgGUID: ZEyYKsmSQCmLxtnEAhku9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28565286"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28565286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 03:59:55 -0700
X-CSE-ConnectionGUID: 5iC7KOnRSWKOwIRtXscDAg==
X-CSE-MsgGUID: XzSG62aMSTyj3J/Lji4Ycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82654454"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 03:59:53 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>
Subject: [char-misc-next v2] mei: use kvmalloc for read buffer
Date: Tue, 15 Oct 2024 13:47:45 +0300
Message-ID: <20241015104745.2242190-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read buffer is allocated according to max message size, reported by
the firmware and may reach 64K in systems with pxp client.
Contiguous 64k allocation may fail under memory pressure.
Read buffer is used as in-driver message storage and not required
to be contiguous.
Use kvmalloc to allow kernel to allocate non-contiguous memory.

Reported-by: Rohit Agarwal <rohiagar@chromium.org>
Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
Tested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516..be011cef12e5 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 		return;
 
 	list_del(&cb->list);
-	kfree(cb->buf.data);
+	kvfree(cb->buf.data);
 	kfree(cb->ext_hdr);
 	kfree(cb);
 }
@@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
+	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
-- 
2.43.0


