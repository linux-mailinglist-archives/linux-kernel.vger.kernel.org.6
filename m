Return-Path: <linux-kernel+bounces-362792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60999B955
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4384E1C20AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0A13AD0F;
	Sun, 13 Oct 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kORAKsJO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45213CA8A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821144; cv=none; b=dZKLKiPXI/4zWbQ7iGl7bBQHwl6c5TeivPVz8m8VKQ6QiGJ8kWLhCl0tfDQNgFlE15HaLFR3oGQ3Q1WVQIYEM54Xlzb9wrP8o5WGSLvhknaKnkpd+rjBtqlGXOeHgR+XBI4tAW68AQTjFRHDViz06mBiT5CAIfYSVqt10FhT5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821144; c=relaxed/simple;
	bh=qElvBYvdvh63b0QaUbLSHkvcRwJPGeuRnsPnM8j1KKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+Alx1g+cca1uq2EXQ0HOWsd8H8CRMJlRKPhEDm/552yHGGblcIsqhqdQ9B41PxrAMpdgxgTHXOwexiVvwpzJgFqPCZtR7UL7JXv05B17uoYf3u/j3/MLhrM9ZSkTqS4aDiM+BF4iPc1jKoOFHGu6Ss8cD0RBZvIpMKLl1Lfh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kORAKsJO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728821142; x=1760357142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qElvBYvdvh63b0QaUbLSHkvcRwJPGeuRnsPnM8j1KKs=;
  b=kORAKsJOxNgOJycR5NsGzWWSYtos04UI0YggR1scfG2WqppFUDj77eBa
   omwISLDi/K05c27cKBAIO1FQLLINTKtXfziiP3UU3S1HBGbpkeJP9kiEj
   ToHKO9J8LR25OtANcAHzKGwwuJND4jKtD83mSUVkMufLrxRp9utQGQ3x7
   GrFfDttKJ0X6FOLj0fLJCJCSzWWJBiMuS/ZATJVFZEyRjMxTccksufUTK
   PAd40gcI22L57gZllis89HqMTsnLPKYaBfl7nw1zFoj9NM93Hc/L4FtxX
   ymt3lCV8z+XOVWuw11lGIsPeVb8gRlyJAhva38vmwtmmF5oQjX7B5W+eO
   A==;
X-CSE-ConnectionGUID: zBw1/pgASTWvukJXG1AfaQ==
X-CSE-MsgGUID: hwNN0bj4QkGYPuXLXrWQfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28305363"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="28305363"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 05:05:42 -0700
X-CSE-ConnectionGUID: sPXTDB32SxCJyAOpe5loKg==
X-CSE-MsgGUID: 1Ry6qbISTgSHdVD+w0uAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="100652181"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 05:05:40 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [char-misc-next] mei: use kvmalloc for read buffer
Date: Sun, 13 Oct 2024 14:53:14 +0300
Message-ID: <20241013115314.1290051-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read buffer is allocated according to max message size,
reported by the firmware and may reach 64K in systems
with pxp client.
Contiguous 64k allocation may fail under memory pressure.
Read buffer is used as in-driver message storage and
not required to be contiguous.
Use kvmalloc to allow kernel to allocate non-contiguous
memory in this case.

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


