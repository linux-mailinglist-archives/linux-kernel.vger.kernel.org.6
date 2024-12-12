Return-Path: <linux-kernel+bounces-443331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE39EED45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10B4285C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513D222D71;
	Thu, 12 Dec 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZTSyhbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42401222D68;
	Thu, 12 Dec 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018208; cv=none; b=UC2gzG/TZx9rI19KUuLdBjeyDrVNXv0t2EdwbDYWY1bpyD97DvldyoMA1mDDzAAd7eSEGzup0KsUCUA/fS0gbQQD8w99ds7lc3xSwxg6ruKNoiKRe3vAwQjKK08x4w6uPWilJ2te72+LzpjawYBPUgo6aqjW0AK8mYfPJqXsHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018208; c=relaxed/simple;
	bh=SxOy+O54beF7mqmszdcpVt9QZurotODus5niEge6VxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3mTvjldnM9i9d9qf4ilwPaHmJkefGsJWmUc6p1Hx3dkP46h+ynzvuDqPcFQ8emuB5ho5NLFejVMjQSJ3JWrjhNP21xSZZZd/AE84k+Pok01ajfOGT5MW7shpd1Qt2CtREwwKFftiCUndu3AWmoVwzLrb4kpMRjIFYhwonhVRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZTSyhbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1DCC4CED4;
	Thu, 12 Dec 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734018206;
	bh=SxOy+O54beF7mqmszdcpVt9QZurotODus5niEge6VxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZTSyhbEdVCOJbNv2/sb2vesrbJH8oYHg2gXpP08DkZcLhj9HBbwCeP7+1FpdwhU3
	 CFEzPxaoudpQTT/ofcE8LuwlgbGFcndjVTcm+96KnCbctN9lAfFYF5U1OA2EBp4Hk4
	 5F8eR/cyk3WUGd7yTljyzy2a6wsKG9eztu+u8mQ5bnUhQ26bdfoeM6dKsOwqB+IU0/
	 c+ay0wfoIw1qn/v6BdUWKvWJSY6qp7Bo6+z9pGqJp+sJH8kWMIkm4xuDbXd8JCaiuQ
	 /UPUFBm5RgX4wHXAH3Fqy//BtvyXp++LblmDgFvnFebxlCb8niSupqjvc6T7CQQ7vw
	 bPaWdn2eihwPA==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: gpib: fix Makefiles
Date: Thu, 12 Dec 2024 16:42:35 +0100
Message-Id: <20241212154245.1411411-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212154245.1411411-1-arnd@kernel.org>
References: <20241212154245.1411411-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Having gpib drivers built-in rather than as loadable modules causes
link failure because the drivers are never actually built:

arm-linux-gnueabi-ld: drivers/staging/gpib/fmh_gpib/fmh_gpib.o: in function `fmh_gpib_t1_delay':
fmh_gpib.c:(.text+0x3b0): undefined reference to `nec7210_t1_delay'
arm-linux-gnueabi-ld: drivers/staging/gpib/fmh_gpib/fmh_gpib.o: in function `fmh_gpib_serial_poll_status':
fmh_gpib.c:(.text+0x418): undefined reference to `nec7210_serial_poll_status'
arm-linux-gnueabi-ld: drivers/staging/gpib/fmh_gpib/fmh_gpib.o: in function `fmh_gpib_secondary_address':
fmh_gpib.c:(.text+0x57c): undefined reference to `nec7210_secondary_address'
arm-linux-gnueabi-ld: drivers/staging/gpib/fmh_gpib/fmh_gpib.o: in function `fmh_gpib_primary_address':
fmh_gpib.c:(.text+0x5ac): undefined reference to `nec7210_primary_address'

Change this to use the correct Makefile syntax, setting either obj-m or obj-y.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/agilent_82350b/Makefile | 2 +-
 drivers/staging/gpib/agilent_82357a/Makefile | 2 +-
 drivers/staging/gpib/cb7210/Makefile         | 2 +-
 drivers/staging/gpib/cec/Makefile            | 2 +-
 drivers/staging/gpib/common/Makefile         | 2 +-
 drivers/staging/gpib/eastwood/Makefile       | 2 +-
 drivers/staging/gpib/gpio/Makefile           | 2 +-
 drivers/staging/gpib/hp_82335/Makefile       | 2 +-
 drivers/staging/gpib/hp_82341/Makefile       | 2 +-
 drivers/staging/gpib/ines/Makefile           | 2 +-
 drivers/staging/gpib/lpvo_usb_gpib/Makefile  | 2 +-
 drivers/staging/gpib/nec7210/Makefile        | 2 +-
 drivers/staging/gpib/ni_usb/Makefile         | 2 +-
 drivers/staging/gpib/pc2/Makefile            | 2 +-
 drivers/staging/gpib/tms9914/Makefile        | 2 +-
 drivers/staging/gpib/tnt4882/Makefile        | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/Makefile b/drivers/staging/gpib/agilent_82350b/Makefile
index d9236c92e04b..f24e1e713a63 100644
--- a/drivers/staging/gpib/agilent_82350b/Makefile
+++ b/drivers/staging/gpib/agilent_82350b/Makefile
@@ -1,2 +1,2 @@
 
-obj-m += agilent_82350b.o
+obj-$(CONFIG_GPIB_AGILENT_82350B) += agilent_82350b.o
diff --git a/drivers/staging/gpib/agilent_82357a/Makefile b/drivers/staging/gpib/agilent_82357a/Makefile
index 4a1d940fce2b..81a55c257a6e 100644
--- a/drivers/staging/gpib/agilent_82357a/Makefile
+++ b/drivers/staging/gpib/agilent_82357a/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += agilent_82357a.o
+obj-$(CONFIG_GPIB_AGILENT_82357A) += agilent_82357a.o
 
 
diff --git a/drivers/staging/gpib/cb7210/Makefile b/drivers/staging/gpib/cb7210/Makefile
index 22e0214fc17d..cda0725d6487 100644
--- a/drivers/staging/gpib/cb7210/Makefile
+++ b/drivers/staging/gpib/cb7210/Makefile
@@ -1,4 +1,4 @@
 ccflags-$(CONFIG_GPIB_PCMCIA) := -DGPIB_PCMCIA
-obj-m += cb7210.o
+obj-$(CONFIG_GPIB_CB7210) += cb7210.o
 
 
diff --git a/drivers/staging/gpib/cec/Makefile b/drivers/staging/gpib/cec/Makefile
index f4638628ff29..b7141e23d4e0 100644
--- a/drivers/staging/gpib/cec/Makefile
+++ b/drivers/staging/gpib/cec/Makefile
@@ -1,3 +1,3 @@
 
-obj-m += cec_gpib.o
+obj-$(CONFIG_GPIB_CEC_PCI) += cec_gpib.o
 
diff --git a/drivers/staging/gpib/common/Makefile b/drivers/staging/gpib/common/Makefile
index 0c4c77bea75b..460586edb574 100644
--- a/drivers/staging/gpib/common/Makefile
+++ b/drivers/staging/gpib/common/Makefile
@@ -1,5 +1,5 @@
 
-obj-m += gpib_common.o
+obj-$(CONFIG_GPIB_COMMON) += gpib_common.o
 
 gpib_common-objs := gpib_os.o iblib.o
 
diff --git a/drivers/staging/gpib/eastwood/Makefile b/drivers/staging/gpib/eastwood/Makefile
index c74056f959d0..384825195f77 100644
--- a/drivers/staging/gpib/eastwood/Makefile
+++ b/drivers/staging/gpib/eastwood/Makefile
@@ -1,3 +1,3 @@
 
-obj-m += fluke_gpib.o
+obj-$(CONFIG_GPIB_FLUKE) += fluke_gpib.o
 
diff --git a/drivers/staging/gpib/gpio/Makefile b/drivers/staging/gpib/gpio/Makefile
index a31ded6e5924..00ea52abdda7 100644
--- a/drivers/staging/gpib/gpio/Makefile
+++ b/drivers/staging/gpib/gpio/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += gpib_bitbang.o
+obj-$(CONFIG_GPIB_GPIO) += gpib_bitbang.o
 
 
diff --git a/drivers/staging/gpib/hp_82335/Makefile b/drivers/staging/gpib/hp_82335/Makefile
index 8b7a552e9355..305ce44ee48a 100644
--- a/drivers/staging/gpib/hp_82335/Makefile
+++ b/drivers/staging/gpib/hp_82335/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += hp82335.o
+obj-$(CONFIG_GPIB_HP82335) += hp82335.o
 
 
diff --git a/drivers/staging/gpib/hp_82341/Makefile b/drivers/staging/gpib/hp_82341/Makefile
index 1fe7db4f8ca4..21367310a17e 100644
--- a/drivers/staging/gpib/hp_82341/Makefile
+++ b/drivers/staging/gpib/hp_82341/Makefile
@@ -1,2 +1,2 @@
 
-obj-m += hp_82341.o
+obj-$(CONFIG_GPIB_HP82341) += hp_82341.o
diff --git a/drivers/staging/gpib/ines/Makefile b/drivers/staging/gpib/ines/Makefile
index cdcaa59a4e39..6b6e480fd811 100644
--- a/drivers/staging/gpib/ines/Makefile
+++ b/drivers/staging/gpib/ines/Makefile
@@ -1,4 +1,4 @@
 ccflags-$(CONFIG_GPIB_PCMCIA) := -DGPIB_PCMCIA
-obj-m += ines_gpib.o
+obj-$(CONFIG_GPIB_INES) += ines_gpib.o
 
 
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/Makefile b/drivers/staging/gpib/lpvo_usb_gpib/Makefile
index 137511acce63..360553488e6d 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/Makefile
+++ b/drivers/staging/gpib/lpvo_usb_gpib/Makefile
@@ -1,3 +1,3 @@
 
-obj-m += lpvo_usb_gpib.o
+obj-$(CONFIG_GPIB_LPVO) += lpvo_usb_gpib.o
 
diff --git a/drivers/staging/gpib/nec7210/Makefile b/drivers/staging/gpib/nec7210/Makefile
index 8d4d90f21109..64330f2e89d1 100644
--- a/drivers/staging/gpib/nec7210/Makefile
+++ b/drivers/staging/gpib/nec7210/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += nec7210.o
+obj-$(CONFIG_GPIB_NEC7210) += nec7210.o
 
 
diff --git a/drivers/staging/gpib/ni_usb/Makefile b/drivers/staging/gpib/ni_usb/Makefile
index e22b3b21a62c..469c5d16add3 100644
--- a/drivers/staging/gpib/ni_usb/Makefile
+++ b/drivers/staging/gpib/ni_usb/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += ni_usb_gpib.o
+obj-$(CONFIG_GPIB_NI_USB) += ni_usb_gpib.o
 
 
diff --git a/drivers/staging/gpib/pc2/Makefile b/drivers/staging/gpib/pc2/Makefile
index 8148425e0f87..481ee4296e1b 100644
--- a/drivers/staging/gpib/pc2/Makefile
+++ b/drivers/staging/gpib/pc2/Makefile
@@ -1,5 +1,5 @@
 
-obj-m += pc2_gpib.o
+obj-$(CONFIG_GPIB_PC2) += pc2_gpib.o
 
 
 
diff --git a/drivers/staging/gpib/tms9914/Makefile b/drivers/staging/gpib/tms9914/Makefile
index 81b7e3cf104c..4705ab07f413 100644
--- a/drivers/staging/gpib/tms9914/Makefile
+++ b/drivers/staging/gpib/tms9914/Makefile
@@ -1,5 +1,5 @@
 
-obj-m += tms9914.o
+obj-$(CONFIG_GPIB_TMS9914) += tms9914.o
 
 
 
diff --git a/drivers/staging/gpib/tnt4882/Makefile b/drivers/staging/gpib/tnt4882/Makefile
index f767c990db7a..04a4520ed3b7 100644
--- a/drivers/staging/gpib/tnt4882/Makefile
+++ b/drivers/staging/gpib/tnt4882/Makefile
@@ -1,5 +1,5 @@
 ccflags-$(CONFIG_GPIB_PCMCIA) := -DGPIB_PCMCIA
-obj-m += tnt4882.o
+obj-$(CONFIG_GPIB_TNT4882) += tnt4882.o
 
 tnt4882-objs := tnt4882_gpib.o mite.o
 
-- 
2.39.5


