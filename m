Return-Path: <linux-kernel+bounces-379132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45C9ADA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF912282EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4415ECD7;
	Thu, 24 Oct 2024 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtwZzlGk"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D6158D92
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729740406; cv=none; b=JEOdaEZi5THiNAtL9DP4p9boeIpxLuK7vixO8OGHVZXx82oq6vy5+tZOi120lh5a73Nq7p8ABk8U6bozjmJHVjBe5KgQQ7hIqSkHFeqyzO4XLzxNMz5sd6uKeynqRShzcz9Hu0IgbDLdt/FlOdpFontZqjOv+fNwhCjPGTv0YFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729740406; c=relaxed/simple;
	bh=4bEL7J6ilGFasVniwtipqtbl1Ltlm+YyKry2kCBtnJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=onlPpsgAP3Znx1KmGe65yt4k04KQpLro7/iJ9rpHIIkAS6yDqVnGD4JYVUFLPvcRmB82zb1XrU/9l5MqwKvcHZ0CgYc81DFzBZtppWHpU/U5K8I1bkI0ZF7oE0ibLt2IbkJ4Z7UDNZ0tAW0B9bKc3hzPmi8eVQ2Y9h7t39fF48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtwZzlGk; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288642376bcso285276fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729740402; x=1730345202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxCczlOkTB9tkKTSKrGgAeYM9SFIi0XskhYj47vLUEU=;
        b=NtwZzlGkc0Fu15rz2exXSri5Ur6+PSEmsPGj57HaJpRcQp2Ilf/NGqDAPuzmIskm5t
         zBbRha5zxIxeXKDNhZP9yRZyeRqs/LHGm3pH9hdR3mPIRwSdEwj/fRtc3TWpHVURYtjO
         XV09MhRm3EKWFEmo71jMpsVYGL0zkuw+oCT0avdBM/ae6Wd2JYXmE4+DvYOOQ3aEQjYt
         v9cLkurksZRPc8QlSMxjbytoKCQvVMT73gaxK8zXWX2yvVgLrZlKD1jX5RLQq99qC8/z
         6pPG8SeTU7EZ73uYzEwqVBdNUarRTk4eHGn2Aqy0SDlVJJ6q0NFHYTJXiDYo+poR00sl
         /0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729740402; x=1730345202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxCczlOkTB9tkKTSKrGgAeYM9SFIi0XskhYj47vLUEU=;
        b=F8hdB5R/Tvr1tYKjigRvazMjDC9LKVwxoQ+Yv6BEC/fAqBWk34vrbCzbVKHu8ypzp5
         XGIOBEK9JaYj7ebSY5ynCTwDJ2vWf0w1ZzEaOY54VRyHeev1zEW8byQxf0Mx2V6xgYg1
         4gbfc4sIuaKAREPbo/RW7F7ZOcfRPN4eJSZXBPvcg1SbFKak/BYF7sjt4FC4L8DwjY27
         ajddlewc0/BC6l1a54YNDcmTjZoLl1/fWFcV7jfKRkd0svLITfu6pSpll+eDx30O3ijF
         LY0sVq0hBXNRSDBm7xrYdzLw5XPDYpV6NAStaHU6a6e8sLO24t1U6xVCuDjt300ErsDF
         0NvA==
X-Gm-Message-State: AOJu0YzC9VXbxrYYgXpbl9QN84KFoX0Z9Ie3J7aBDYSzG9Ltc6hDb06C
	1heSUmPlkcZCqo5OcziEdKsyBmCt64jixzHbXBAt+Wy/yC+9U6IPMmrsWg==
X-Google-Smtp-Source: AGHT+IGavy1MQm3uWcvWOUN7Fr67Chqk42UhozD/D0ebHZKRl0k/UEBi1lVQmiYI+Z54wf3FOuNSSw==
X-Received: by 2002:a05:6870:2045:b0:261:f8e:a37a with SMTP id 586e51a60fabf-28ccb7f3a34mr5057009fac.14.1729740402490;
        Wed, 23 Oct 2024 20:26:42 -0700 (PDT)
Received: from localhost.localdomain ([2400:4070:352:9900:2434:14da:b30e:2e7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ff72sm7043102b3a.58.2024.10.23.20.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 20:26:42 -0700 (PDT)
From: quake <quake.wang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Quake Wang <quake.wang@gmail.com>
Subject: [PATCH] Remove Huawei
Date: Thu, 24 Oct 2024 12:26:37 +0900
Message-Id: <20241024032637.34286-1-quake.wang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Quake Wang <quake.wang@gmail.com>

Remove some entries due to various compliance requirements. They cannot come back in the future as huawei is sanctioned by most freedom countries in the world.
---
 MAINTAINERS | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..400701a58534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -322,7 +322,6 @@ F:	tools/power/acpi/
 
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
-M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3873,7 +3872,6 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
-M:	Yu Kuai <yukuai3@huawei.com>
 L:	linux-block@vger.kernel.org
 S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
@@ -4082,7 +4080,6 @@ X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn@kernel.org>
-R:	Pu Lehui <pulehui@huawei.com>
 R:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
@@ -5697,7 +5694,6 @@ F:	include/linux/compiler_attributes.h
 
 COMPUTE EXPRESS LINK (CXL)
 M:	Davidlohr Bueso <dave@stgolabs.net>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -5712,7 +5708,6 @@ F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/perf/cxl.rst
@@ -8525,7 +8520,6 @@ F:	include/uapi/linux/ext4.h
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.ibm.com>
-M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
@@ -10189,21 +10183,17 @@ F:	net/dsa/tag_hellcreek.c
 
 HISILICON DMA DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
-M:	Jie Hai <haijie1@huawei.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/hisi_dma.c
 
 HISILICON GPIO DRIVER
-M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
 F:	drivers/gpio/gpio-hisi.c
 
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
-M:	Zhiqi Song <songzhiqi1@huawei.com>
-M:	Longfang Liu <liulongfang@huawei.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-hpre
@@ -10212,7 +10202,6 @@ F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
 F:	drivers/crypto/hisilicon/hpre/hpre_main.c
 
 HISILICON HNS3 PMU DRIVER
-M:	Jijie Shao <shaojijie@huawei.com>
 S:	Supported
 F:	Documentation/admin-guide/perf/hns3-pmu.rst
 F:	drivers/perf/hisilicon/hns3_pmu.c
@@ -10226,31 +10215,24 @@ F:	Documentation/devicetree/bindings/i2c/hisilicon,ascend910-i2c.yaml
 F:	drivers/i2c/busses/i2c-hisi.c
 
 HISILICON KUNPENG SOC HCCS DRIVER
-M:	Huisong Li <lihuisong@huawei.com>
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
 HISILICON LPC BUS DRIVER
-M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
-M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
-M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
-M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
@@ -10259,7 +10241,6 @@ F:	drivers/net/ethernet/hisilicon/
 
 HISILICON PMU DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -10268,7 +10249,6 @@ F:	drivers/perf/hisilicon
 
 HISILICON PTT DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
@@ -10279,7 +10259,6 @@ F:	tools/perf/util/hisi-ptt*
 F:	tools/perf/util/hisi-ptt-decoder/*
 
 HISILICON QM DRIVER
-M:	Weili Qian <qianweili@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -10290,7 +10269,6 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	include/linux/hisi_acc_qm.h
 
 HISILICON ROCE DRIVER
-M:	Chengchang Tang <tangchengchang@huawei.com>
 M:	Junxian Huang <huangjunxian6@hisilicon.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
@@ -10298,14 +10276,12 @@ F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
 F:	drivers/infiniband/hw/hns/
 
 HISILICON SAS Controller
-M:	Yihang Li <liyihang9@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 F:	drivers/scsi/hisi_sas/
 
 HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
-M:	Longfang Liu <liulongfang@huawei.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-sec
@@ -10315,7 +10291,6 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
 HISILICON SPI Controller DRIVER FOR KUNPENG SOCS
-M:	Jay Fang <f.fangjian@huawei.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
@@ -10336,18 +10311,15 @@ F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
 
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
-M:	Weili Qian <qianweili@huawei.com>
 S:	Maintained
 F:	drivers/crypto/hisilicon/trng/trng.c
 
 HISILICON V3XX SPI NOR FLASH Controller Driver
-M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
 
 HISILICON ZIP Controller DRIVER
-M:	Yang Shen <shenyang39@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -10504,7 +10476,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/st/sti/hva
 
 HWPOISON MEMORY FAILURE HANDLING
-M:	Miaohe Lin <linmiaohe@huawei.com>
 R:	Naoya Horiguchi <nao.horiguchi@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
@@ -11243,7 +11214,6 @@ F:	drivers/crypto/inside-secure/
 
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
-M:	Roberto Sassu <roberto.sassu@huawei.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
 R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
@@ -12447,7 +12417,6 @@ M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oliver.upton@linux.dev>
 R:	Joey Gouly <joey.gouly@arm.com>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
-R:	Zenghui Yu <yuzenghui@huawei.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.linux.dev
 S:	Maintained
@@ -20497,7 +20466,6 @@ F:	drivers/iio/chemical/ens160.h
 
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
-R:	Jason Yan <yanaijie@huawei.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	Documentation/scsi/libsas.rst
@@ -21303,7 +21271,6 @@ F:	include/linux/property.h
 
 SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Song Liu <song@kernel.org>
-R:	Yu Kuai <yukuai3@huawei.com>
 L:	linux-raid@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-raid/list/
@@ -23549,7 +23516,6 @@ F:	include/uapi/misc/uacce/
 
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
-R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
@@ -23699,7 +23665,6 @@ F:	drivers/ufs/host/ufs-renesas.c
 
 UNSORTED BLOCK IMAGES (UBI)
 M:	Richard Weinberger <richard@nod.at>
-R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/
@@ -23803,7 +23768,6 @@ S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
 
 USB IP DRIVER FOR HISILICON KIRIN 960
-M:	Yu Chen <chenyu56@huawei.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
@@ -24183,8 +24147,6 @@ S:	Orphan
 F:	drivers/vfio/fsl-mc/
 
 VFIO HISILICON PCI DRIVER
-M:	Longfang Liu <liulongfang@huawei.com>
-M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
@@ -24213,7 +24175,6 @@ F:	drivers/vfio/pci/nvgrace-gpu/
 VFIO PCI DEVICE SPECIFIC DRIVERS
 R:	Jason Gunthorpe <jgg@nvidia.com>
 R:	Yishai Hadas <yishaih@nvidia.com>
-R:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
 R:	Kevin Tian <kevin.tian@intel.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
@@ -24395,7 +24356,6 @@ F:	tools/virtio/
 F:	tools/testing/selftests/drivers/net/virtio_net/
 
 VIRTIO CRYPTO DRIVER
-M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux.dev
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -25481,7 +25441,6 @@ F:	drivers/input/misc/yealink.*
 
 Z3FOLD COMPRESSED PAGE ALLOCATOR
 M:	Vitaly Wool <vitaly.wool@konsulko.com>
-R:	Miaohe Lin <linmiaohe@huawei.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/z3fold.c
-- 
2.39.5 (Apple Git-154)


