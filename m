Return-Path: <linux-kernel+bounces-257207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3B9376B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E620282191
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789F83CA1;
	Fri, 19 Jul 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZCVtwrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07A42076
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385545; cv=none; b=ggbLuqIIccD67b/O3hdNBFddy5r1rXBd3BMQmUEy9XscLOAkyIp8EaYg6mOsACIrIVktwqUrUrB+afDjNl0nyw1g0lH4HyXHhUXdTB6eiiGxKc6TZXdRvHsUFnh9hK94HQUuiwX58oAqk4KyXDxXNLKMzd4IsyF5p9OJpHwr06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385545; c=relaxed/simple;
	bh=QFesLS2O5rXs/N1VZ3M0QyMhYMOiUCtsT0sfodgKZxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i6xAjYaZrwfrKi3svLJoZojaDmSaXtBeRzV0svf3BVep1CiSefuiyrSexxdiuLca0v+NPFmv3AKTJ7DgCvUuphgbaGijITPPdu2BOWsnHWoM3w1wSESi5T1MH0I63fYxc9tapOOfqZDf+ovYsN8FNCTbvdhucN37fwlOBEKireU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZCVtwrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC439C4AF09;
	Fri, 19 Jul 2024 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721385545;
	bh=QFesLS2O5rXs/N1VZ3M0QyMhYMOiUCtsT0sfodgKZxs=;
	h=From:To:Cc:Subject:Date:From;
	b=WZCVtwrcfysoH4dYvw1sI7RILTIwDfwJ7/25y8nMLafuHOvJlDuSQE6gvYAkBr06D
	 f3ulHyemsBE7GeOAXh7n7Sa/Mm8YEk1yfzMT5qVyCtqQhF+iuPhkE78oL/fqISics6
	 jfI4I9N4uierqtMvA3uh/9nNqoMfnAcN/1Eg/mV/Ywp5w/g22FOTCCwrJcAv5/qetu
	 o9BaqXvJlQcN4mHljzNxiH7JQe5gceCVvITRTl32xQFEIUoL9/gP9BO0oCdgShfGPP
	 4QZF6K82j1ZRPSrSEIoQSIqgg+d3EK3G+1Tro73YnIwhTmoeZaujy9FF3T0ye5ckQJ
	 UpXGLIciioDlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mrvl-cn10k-dpi: add PCI_IOV dependency
Date: Fri, 19 Jul 2024 12:38:23 +0200
Message-Id: <20240719103858.1292094-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I found one more missing dependency in the new driver: when building
without CONFIG_PCI_IOV, pci_sriov_configure_simple() cannot be
called directly:

drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_remove':
include/linux/stddef.h:9:14: error: called object is not a function or function pointer
    9 | #define NULL ((void *)0)
      |              ^
include/linux/pci.h:2416:41: note: in expansion of macro 'NULL'
 2416 | #define pci_sriov_configure_simple      NULL
      |                                         ^~~~
drivers/misc/mrvl_cn10k_dpi.c:652:9: note: in expansion of macro 'pci_sriov_configure_simple'
  652 |         pci_sriov_configure_simple(pdev, 0);

Add this to the Kconfig file as well.

Fixes: 5f67eef6dff3 ("misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a1ae3f9c0707..b6f5733a6ee2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -589,7 +589,7 @@ config NSM
 
 config MARVELL_CN10K_DPI
 	tristate "Octeon CN10K DPI driver"
-	depends on PCI
+	depends on PCI && PCI_IOV
 	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
 	help
 	  Enables Octeon CN10K DMA packet interface (DPI) driver which
-- 
2.39.2


