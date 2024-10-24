Return-Path: <linux-kernel+bounces-379140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6FB9ADA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94191F2270D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968A15A868;
	Thu, 24 Oct 2024 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxUzRsJs"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9E16C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741142; cv=none; b=UhZE2wCgjeM0mlGu31YgT8Va4xo3wu1JW4HawIv2bLhE729AsdGQdO3gYFzigO/XuTuEjgeTXerWDmg/EdCd6wC4HSIngnqwuPudzBJUDZb/JeyYzwGtl64UHRMEgwAsR36jO4V5XHW1jT4EpK8NZL6AHDy99XvquTG51rdB8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741142; c=relaxed/simple;
	bh=MXwxQwrkFUWPhFx5dMQyh5lSb+81wMa4rDZqmWnP2lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMmWfM6Zuh1n3KPnOHzGUBv/bUU5KFh/aQ1XwPnMU/r7y2Zg1cebOgphRPXWKdJOYp7vfmOJRQXQoK0eGFDsbkN3eSiMZ8KF+9lkNTlB8vQuGUuMV+lXUKMBoA0UZHSHkAOlOGBW6O8TzD1KbVpOrSlus6kADyT89/FM8smBXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxUzRsJs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so97423a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729741139; x=1730345939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koBLBiRmNTAmfiLQl4L+XlpoDQYU/HxCgaHEztYLpgw=;
        b=CxUzRsJsSGvK3ln1PeUQD+KN/VPqzrnbN3cyDdb2gVIJsHWsIR0tY4gGwIn0h4M3hi
         HVrEaTSpq8dFYnDb9jEPH1NMiEWWL6Dccbv25QHfYYOUGgRlvsVMl/8u/cxppET+H6Xa
         jA7dSDWQIPlCJWWj31QT9n6l+P6FbTK55xelUgZbYM0zYinVIO554uf0XIMoglXpmDBi
         sc7m0PTch8w0ZRJDV5GHlEY0u4IrpsThKE6tOfAQ/Ml1bfRmB9U2+dyjBnv/KFbDH60P
         xzI18dVFp/8roKDT6tdKMVT9UGVlnik9Xv/HglaoASOLfyEiTbNHNWrahDTLknZrxj0u
         Ak0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729741139; x=1730345939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koBLBiRmNTAmfiLQl4L+XlpoDQYU/HxCgaHEztYLpgw=;
        b=kEhvB4JfP8OtxMCpHTxV+VaQ37qh3DJmTp1soocRLknRrQItQhk59YpEcu1a8WfqYz
         QVt1Zd1EhzoyMLjZ3UTnj5OgdDdtrSX4OZCVHPYerRiLYt60TvytS+W1rSVVplGo26x8
         snqleJb/lwVRY94KLNcg8ByeHZBMjYbxbOQklHIvU+Bhve0lDCw8qnMuwe3ZeZ8762At
         e6ZZ21ZG5VBGSqCuNsVTg5sFNuj/KBz/+NUv9cEmY9nq8sjWadmHBOr12/hzI0PGwuzw
         DDgas0o5qfEL3qtDj5pDeNVNRqIuGNjzhRTNib2zaspsjWQPGBiwtkXA1dm2+33/3BoR
         EXLA==
X-Gm-Message-State: AOJu0YycIKr7oRwUS19tFb+i/Y4rTj2FhDz7woz5KbIDjPY6nxMpW3wp
	hY3aCGj4iUyEKjge7vBDTZtZ8RnJ5CcQ/tGRQX514N7FY0cvn1qJyoF4MRfHScKV8zV3WxQkBu1
	URBievgwboHmq4OfZ5PqA8E4AOVQ=
X-Google-Smtp-Source: AGHT+IH0PNNACkSiDiiyOCT50DA9QU0cdeY86SwS+u7SVwvWDGgSswy26BwOpvrC8ryOEWrjceQld5atHfYXv4UHL34=
X-Received: by 2002:a17:90b:1081:b0:2e5:5a58:630 with SMTP id
 98e67ed59e1d1-2e76b6e5865mr2190495a91.5.1729741137955; Wed, 23 Oct 2024
 20:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024032637.34286-1-quake.wang@gmail.com>
In-Reply-To: <20241024032637.34286-1-quake.wang@gmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 05:38:46 +0200
Message-ID: <CALtW_ajR0hGz9aYdPgqW+TsZJw3QVYvPeA93fEGHKXAdk9RKYQ@mail.gmail.com>
Subject: Re: [PATCH] Remove Huawei
To: quake <quake.wang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The "compliance" purge continues.
BTW strange how those "freedom countries" do not sanction Israel.

PS
For those who are going to complain that this mailing list should be
free of politics,
I agree, please direct your complaints to those making "freedom
countries" remarks.

On Thu, 24 Oct 2024 at 05:26, quake <quake.wang@gmail.com> wrote:
>
> From: Quake Wang <quake.wang@gmail.com>
>
> Remove some entries due to various compliance requirements. They cannot c=
ome back in the future as huawei is sanctioned by most freedom countries in=
 the world.
> ---
>  MAINTAINERS | 41 -----------------------------------------
>  1 file changed, 41 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3..400701a58534 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -322,7 +322,6 @@ F:  tools/power/acpi/
>
>  ACPI FOR ARM64 (ACPI/arm64)
>  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> -M:     Hanjun Guo <guohanjun@huawei.com>
>  M:     Sudeep Holla <sudeep.holla@arm.com>
>  L:     linux-acpi@vger.kernel.org
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> @@ -3873,7 +3872,6 @@ F:        Documentation/filesystems/befs.rst
>  F:     fs/befs/
>
>  BFQ I/O SCHEDULER
> -M:     Yu Kuai <yukuai3@huawei.com>
>  L:     linux-block@vger.kernel.org
>  S:     Odd Fixes
>  F:     Documentation/block/bfq-iosched.rst
> @@ -4082,7 +4080,6 @@ X:        arch/riscv/net/bpf_jit_comp64.c
>
>  BPF JIT for RISC-V (64-bit)
>  M:     Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> -R:     Pu Lehui <pulehui@huawei.com>
>  R:     Puranjay Mohan <puranjay@kernel.org>
>  L:     bpf@vger.kernel.org
>  S:     Maintained
> @@ -5697,7 +5694,6 @@ F:        include/linux/compiler_attributes.h
>
>  COMPUTE EXPRESS LINK (CXL)
>  M:     Davidlohr Bueso <dave@stgolabs.net>
> -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
>  M:     Dave Jiang <dave.jiang@intel.com>
>  M:     Alison Schofield <alison.schofield@intel.com>
>  M:     Vishal Verma <vishal.l.verma@intel.com>
> @@ -5712,7 +5708,6 @@ F:        include/uapi/linux/cxl_mem.h
>  F:     tools/testing/cxl/
>
>  COMPUTE EXPRESS LINK PMU (CPMU)
> -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
>  L:     linux-cxl@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/admin-guide/perf/cxl.rst
> @@ -8525,7 +8520,6 @@ F:        include/uapi/linux/ext4.h
>
>  Extended Verification Module (EVM)
>  M:     Mimi Zohar <zohar@linux.ibm.com>
> -M:     Roberto Sassu <roberto.sassu@huawei.com>
>  L:     linux-integrity@vger.kernel.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-int=
egrity.git
> @@ -10189,21 +10183,17 @@ F:    net/dsa/tag_hellcreek.c
>
>  HISILICON DMA DRIVER
>  M:     Zhou Wang <wangzhou1@hisilicon.com>
> -M:     Jie Hai <haijie1@huawei.com>
>  L:     dmaengine@vger.kernel.org
>  S:     Maintained
>  F:     drivers/dma/hisi_dma.c
>
>  HISILICON GPIO DRIVER
> -M:     Jay Fang <f.fangjian@huawei.com>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.y=
aml
>  F:     drivers/gpio/gpio-hisi.c
>
>  HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
> -M:     Zhiqi Song <songzhiqi1@huawei.com>
> -M:     Longfang Liu <liulongfang@huawei.com>
>  L:     linux-crypto@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/debugfs-hisi-hpre
> @@ -10212,7 +10202,6 @@ F:      drivers/crypto/hisilicon/hpre/hpre_crypto=
.c
>  F:     drivers/crypto/hisilicon/hpre/hpre_main.c
>
>  HISILICON HNS3 PMU DRIVER
> -M:     Jijie Shao <shaojijie@huawei.com>
>  S:     Supported
>  F:     Documentation/admin-guide/perf/hns3-pmu.rst
>  F:     drivers/perf/hisilicon/hns3_pmu.c
> @@ -10226,31 +10215,24 @@ F:    Documentation/devicetree/bindings/i2c/his=
ilicon,ascend910-i2c.yaml
>  F:     drivers/i2c/busses/i2c-hisi.c
>
>  HISILICON KUNPENG SOC HCCS DRIVER
> -M:     Huisong Li <lihuisong@huawei.com>
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
>  F:     drivers/soc/hisilicon/kunpeng_hccs.c
>  F:     drivers/soc/hisilicon/kunpeng_hccs.h
>
>  HISILICON LPC BUS DRIVER
> -M:     Jay Fang <f.fangjian@huawei.com>
>  S:     Maintained
>  W:     http://www.hisilicon.com
>  F:     Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yam=
l
>  F:     drivers/bus/hisi_lpc.c
>
>  HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
> -M:     Jian Shen <shenjian15@huawei.com>
> -M:     Salil Mehta <salil.mehta@huawei.com>
> -M:     Jijie Shao <shaojijie@huawei.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  W:     http://www.hisilicon.com
>  F:     drivers/net/ethernet/hisilicon/hns3/
>
>  HISILICON NETWORK SUBSYSTEM DRIVER
> -M:     Jian Shen <shenjian15@huawei.com>
> -M:     Salil Mehta <salil.mehta@huawei.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  W:     http://www.hisilicon.com
> @@ -10259,7 +10241,6 @@ F:      drivers/net/ethernet/hisilicon/
>
>  HISILICON PMU DRIVER
>  M:     Yicong Yang <yangyicong@hisilicon.com>
> -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
>  S:     Supported
>  W:     http://www.hisilicon.com
>  F:     Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> @@ -10268,7 +10249,6 @@ F:      drivers/perf/hisilicon
>
>  HISILICON PTT DRIVER
>  M:     Yicong Yang <yangyicong@hisilicon.com>
> -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> @@ -10279,7 +10259,6 @@ F:      tools/perf/util/hisi-ptt*
>  F:     tools/perf/util/hisi-ptt-decoder/*
>
>  HISILICON QM DRIVER
> -M:     Weili Qian <qianweili@huawei.com>
>  M:     Zhou Wang <wangzhou1@hisilicon.com>
>  L:     linux-crypto@vger.kernel.org
>  S:     Maintained
> @@ -10290,7 +10269,6 @@ F:      drivers/crypto/hisilicon/sgl.c
>  F:     include/linux/hisi_acc_qm.h
>
>  HISILICON ROCE DRIVER
> -M:     Chengchang Tang <tangchengchang@huawei.com>
>  M:     Junxian Huang <huangjunxian6@hisilicon.com>
>  L:     linux-rdma@vger.kernel.org
>  S:     Maintained
> @@ -10298,14 +10276,12 @@ F:    Documentation/devicetree/bindings/infinib=
and/hisilicon-hns-roce.txt
>  F:     drivers/infiniband/hw/hns/
>
>  HISILICON SAS Controller
> -M:     Yihang Li <liyihang9@huawei.com>
>  S:     Supported
>  W:     http://www.hisilicon.com
>  F:     Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>  F:     drivers/scsi/hisi_sas/
>
>  HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
> -M:     Longfang Liu <liulongfang@huawei.com>
>  L:     linux-crypto@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/debugfs-hisi-sec
> @@ -10315,7 +10291,6 @@ F:      drivers/crypto/hisilicon/sec2/sec_crypto.=
h
>  F:     drivers/crypto/hisilicon/sec2/sec_main.c
>
>  HISILICON SPI Controller DRIVER FOR KUNPENG SOCS
> -M:     Jay Fang <f.fangjian@huawei.com>
>  L:     linux-spi@vger.kernel.org
>  S:     Maintained
>  W:     http://www.hisilicon.com
> @@ -10336,18 +10311,15 @@ F:    Documentation/devicetree/bindings/mfd/his=
ilicon,hi6421-spmi-pmic.yaml
>  F:     drivers/mfd/hi6421-spmi-pmic.c
>
>  HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
> -M:     Weili Qian <qianweili@huawei.com>
>  S:     Maintained
>  F:     drivers/crypto/hisilicon/trng/trng.c
>
>  HISILICON V3XX SPI NOR FLASH Controller Driver
> -M:     Jay Fang <f.fangjian@huawei.com>
>  S:     Maintained
>  W:     http://www.hisilicon.com
>  F:     drivers/spi/spi-hisi-sfc-v3xx.c
>
>  HISILICON ZIP Controller DRIVER
> -M:     Yang Shen <shenyang39@huawei.com>
>  M:     Zhou Wang <wangzhou1@hisilicon.com>
>  L:     linux-crypto@vger.kernel.org
>  S:     Maintained
> @@ -10504,7 +10476,6 @@ T:      git git://linuxtv.org/media_tree.git
>  F:     drivers/media/platform/st/sti/hva
>
>  HWPOISON MEMORY FAILURE HANDLING
> -M:     Miaohe Lin <linmiaohe@huawei.com>
>  R:     Naoya Horiguchi <nao.horiguchi@gmail.com>
>  L:     linux-mm@kvack.org
>  S:     Maintained
> @@ -11243,7 +11214,6 @@ F:      drivers/crypto/inside-secure/
>
>  INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
>  M:     Mimi Zohar <zohar@linux.ibm.com>
> -M:     Roberto Sassu <roberto.sassu@huawei.com>
>  M:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>  R:     Eric Snowberg <eric.snowberg@oracle.com>
>  L:     linux-integrity@vger.kernel.org
> @@ -12447,7 +12417,6 @@ M:      Marc Zyngier <maz@kernel.org>
>  M:     Oliver Upton <oliver.upton@linux.dev>
>  R:     Joey Gouly <joey.gouly@arm.com>
>  R:     Suzuki K Poulose <suzuki.poulose@arm.com>
> -R:     Zenghui Yu <yuzenghui@huawei.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  L:     kvmarm@lists.linux.dev
>  S:     Maintained
> @@ -20497,7 +20466,6 @@ F:      drivers/iio/chemical/ens160.h
>
>  SCSI LIBSAS SUBSYSTEM
>  R:     John Garry <john.g.garry@oracle.com>
> -R:     Jason Yan <yanaijie@huawei.com>
>  L:     linux-scsi@vger.kernel.org
>  S:     Supported
>  F:     Documentation/scsi/libsas.rst
> @@ -21303,7 +21271,6 @@ F:      include/linux/property.h
>
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:     Song Liu <song@kernel.org>
> -R:     Yu Kuai <yukuai3@huawei.com>
>  L:     linux-raid@vger.kernel.org
>  S:     Supported
>  Q:     https://patchwork.kernel.org/project/linux-raid/list/
> @@ -23549,7 +23516,6 @@ F:      include/uapi/misc/uacce/
>
>  UBI FILE SYSTEM (UBIFS)
>  M:     Richard Weinberger <richard@nod.at>
> -R:     Zhihao Cheng <chengzhihao1@huawei.com>
>  L:     linux-mtd@lists.infradead.org
>  S:     Supported
>  W:     http://www.linux-mtd.infradead.org/doc/ubifs.html
> @@ -23699,7 +23665,6 @@ F:      drivers/ufs/host/ufs-renesas.c
>
>  UNSORTED BLOCK IMAGES (UBI)
>  M:     Richard Weinberger <richard@nod.at>
> -R:     Zhihao Cheng <chengzhihao1@huawei.com>
>  L:     linux-mtd@lists.infradead.org
>  S:     Supported
>  W:     http://www.linux-mtd.infradead.org/
> @@ -23803,7 +23768,6 @@ S:      Maintained
>  F:     drivers/usb/roles/intel-xhci-usb-role-switch.c
>
>  USB IP DRIVER FOR HISILICON KIRIN 960
> -M:     Yu Chen <chenyu56@huawei.com>
>  M:     Binghui Wang <wangbinghui@hisilicon.com>
>  L:     linux-usb@vger.kernel.org
>  S:     Maintained
> @@ -24183,8 +24147,6 @@ S:      Orphan
>  F:     drivers/vfio/fsl-mc/
>
>  VFIO HISILICON PCI DRIVER
> -M:     Longfang Liu <liulongfang@huawei.com>
> -M:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>  L:     kvm@vger.kernel.org
>  S:     Maintained
>  F:     drivers/vfio/pci/hisilicon/
> @@ -24213,7 +24175,6 @@ F:      drivers/vfio/pci/nvgrace-gpu/
>  VFIO PCI DEVICE SPECIFIC DRIVERS
>  R:     Jason Gunthorpe <jgg@nvidia.com>
>  R:     Yishai Hadas <yishaih@nvidia.com>
> -R:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>  R:     Kevin Tian <kevin.tian@intel.com>
>  L:     kvm@vger.kernel.org
>  S:     Maintained
> @@ -24395,7 +24356,6 @@ F:      tools/virtio/
>  F:     tools/testing/selftests/drivers/net/virtio_net/
>
>  VIRTIO CRYPTO DRIVER
> -M:     Gonglei <arei.gonglei@huawei.com>
>  L:     virtualization@lists.linux.dev
>  L:     linux-crypto@vger.kernel.org
>  S:     Maintained
> @@ -25481,7 +25441,6 @@ F:      drivers/input/misc/yealink.*
>
>  Z3FOLD COMPRESSED PAGE ALLOCATOR
>  M:     Vitaly Wool <vitaly.wool@konsulko.com>
> -R:     Miaohe Lin <linmiaohe@huawei.com>
>  L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     mm/z3fold.c
> --
> 2.39.5 (Apple Git-154)
>
>

