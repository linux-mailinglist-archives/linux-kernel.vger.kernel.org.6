Return-Path: <linux-kernel+bounces-410879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341719CEE97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F21F25351
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD41D5169;
	Fri, 15 Nov 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BgqBMXtN"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B40136E23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684073; cv=none; b=a08MMhAsPlkcynjjgPK+Bp8WdjFM2j5MwaixBQCG+RiVQVdSwgBiQ5Ga4eP4vVGGPgsbyulahfzdNCB6kT2oFLd01uP01jXXL/nAp9KWeXzRwHm4nAu61LSxjnlvOVuW56Xf1Fk2H2r/natGPwEqdDTLYNnH7mzWMRFMQqEUutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684073; c=relaxed/simple;
	bh=izW/hI5oIvsLbStR2agybQPCLVjN36KwUNWd4yWxFHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofyD0iidcv2gFLVTTHp4BJ4TABFajr0e5U61J7scqrOL4CaEwbzbtdYpuMaGXuDyC5EW8RG6yW90FDR5Ajx7uy84jW//tt+oKOPbCV3YAxp0W3hHcQI2FdIo1v4/3PcSOXOXiDWtGkgQS6VUcR3YbLp4FXfpN6GQoWRuLnzrMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BgqBMXtN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=f6mRNT+3cEEBFBqNnfm9nrFBEqUKrx55F3XWxjHMxiY=; b=BgqBMXtNDTMuQkKC
	sV+s8ZTrZbXSIoSC2Eu9uS0ojjn6VNVMK8pFpzkrJpm+fEyl9WDGT54akTB/hJ0d97xnRnKndP+VG
	9JdTQCHTLx7Ti20VYEbjGIiVbqQMHRxEPCBi4CSMa8cChA6vQ6QjBztFTcsTWCk8w087eKJ6Tg8cf
	d1jxWTmKiAijSffIgLcdVRp/e45SfuHZON7mt9iQJDR1DV5PZQZ1pHfwfb9p4CLzTs/AbBxgfcK/I
	kEg9Gzr0mO13y2nmRgC1VV1K1xqiA19UL60ydL4i5qJ0GAlY48oBrcDaEST38lnZKsYaewCTp6kyQ
	4tqXHFCjgZ9FFLWD5Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tBy80-00098y-2k;
	Fri, 15 Nov 2024 15:20:56 +0000
From: linux@treblig.org
To: ioana.ciornei@nxp.com,
	stuyoder@gmail.com,
	christophe.leroy@csgroup.eu
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] bus: fsl-mc: Remove deadcode
Date: Fri, 15 Nov 2024 15:20:55 +0000
Message-ID: <20241115152055.279732-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fsl_mc_allocator_driver_exit() was added explicitly by
commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
but was never used.

Remove it.

fsl_mc_portal_reset() was added in 2015 by
commit 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
but was never used.

Remove it.

fsl_mc_portal_reset() was the only caller of dpmcp_reset().

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/bus/fsl-mc/dpmcp.c            | 22 ----------------------
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  5 -----
 drivers/bus/fsl-mc/fsl-mc-private.h   |  6 ------
 drivers/bus/fsl-mc/mc-io.c            | 20 --------------------
 include/linux/fsl/mc.h                |  2 --
 5 files changed, 55 deletions(-)

diff --git a/drivers/bus/fsl-mc/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
index 5fbd0dbde24a..7816c0a728ef 100644
--- a/drivers/bus/fsl-mc/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -75,25 +75,3 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
-
-/**
- * dpmcp_reset() - Reset the DPMCP, returns the object to initial state.
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPMCP object
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpmcp_reset(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token)
-{
-	struct fsl_mc_command cmd = { 0 };
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPMCP_CMDID_RESET,
-					  cmd_flags, token);
-
-	/* send command to mc*/
-	return mc_send_command(mc_io, &cmd);
-}
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index b5e8c021fa1f..6c3beb82dd1b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -656,8 +656,3 @@ int __init fsl_mc_allocator_driver_init(void)
 {
 	return fsl_mc_driver_register(&fsl_mc_allocator_driver);
 }
-
-void fsl_mc_allocator_driver_exit(void)
-{
-	fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
-}
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index b3520ea1b9f4..e1b7ec3ed1a7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -66,10 +66,6 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token);
 
-int dpmcp_reset(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
 /*
  * Data Path Resource Container (DPRC) API
  */
@@ -631,8 +627,6 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 
 int __init fsl_mc_allocator_driver_init(void);
 
-void fsl_mc_allocator_driver_exit(void);
-
 void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 95b10a6cf307..a0ad7866cbfc 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -263,23 +263,3 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
 	dpmcp_dev->consumer_link = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
-
-/**
- * fsl_mc_portal_reset - Resets the dpmcp object for a given fsl_mc_io object
- *
- * @mc_io: Pointer to the fsl_mc_io object that wraps the MC portal to free
- */
-int fsl_mc_portal_reset(struct fsl_mc_io *mc_io)
-{
-	int error;
-	struct fsl_mc_device *dpmcp_dev = mc_io->dpmcp_dev;
-
-	error = dpmcp_reset(mc_io, 0, dpmcp_dev->mc_handle);
-	if (error < 0) {
-		dev_err(&dpmcp_dev->dev, "dpmcp_reset() failed: %d\n", error);
-		return error;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(fsl_mc_portal_reset);
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index c90ec889bfc2..37316a58d2ed 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -417,8 +417,6 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 
 void fsl_mc_portal_free(struct fsl_mc_io *mc_io);
 
-int fsl_mc_portal_reset(struct fsl_mc_io *mc_io);
-
 int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
 					enum fsl_mc_pool_type pool_type,
 					struct fsl_mc_device **new_mc_adev);
-- 
2.47.0


