Return-Path: <linux-kernel+bounces-379193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6F9ADB45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF277B22568
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6681714C9;
	Thu, 24 Oct 2024 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhdOwCaG"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8ED170822
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746851; cv=none; b=R5IeCAP62jH5UaYjfL90wdpfigjxVXTDTFYF31GLxLDQWy0Jyti1F5ajOINvRv3Xdr5zt1bmw4fwERUO004FMNVpCTYyXdhWMXZU+UduRS5WS8b39vhBYuGMbPnsCVyRgaq5AVnJ8xdjhfcZ+lJbEMgV/YESxWCvCbjQjLbAXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746851; c=relaxed/simple;
	bh=GhML9rM5IjsXSXwX3VDtT8xzuqjnunJLMKI6iaayu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s7dkK2/bw2GFmqXy1SSm7G33OPrUzkMvPsjduGX7lrq+hluufkbzIC3Svgul3WE6lfHiBuo61X5rkd9cE0qUWE4yC5xfCCfM165ADapdHmiZyLjPQjvqUhEloXffZrwXtLcIPJRlyzvCnG2mecmpeu6rpNNHN88MRY+PUSS5CH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhdOwCaG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609beb631aso3166471cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729746847; x=1730351647; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPqQBMMwaSEmbFsEPp8BP7GPHr7y6auO2zPri786Gfw=;
        b=VhdOwCaGezVClN8DK6TNhZhT9r0aTsPZYNazrKkfdRukXnnnfHVc5Bjd1o238AxD/t
         KpfUc9eM6aENSCYoS/O2bm94Y95qd4fd4nyROgWHSUmC5Suw8jdDVJp0e7oek9z4Scwz
         Pd1gRbml5Q1rMfSZzwhihVbBRp6fij/l+LRS4rQSl6rcG1T54BMyiP5KwwBpwM/FBC6o
         1IWWQxUj1Iyh9UfXit1TFtGZkYkZ+wan/iS9JLwE21tQlZkJ4mprdQfBjTahSvdmYagH
         82xeMm5KXLaNyZ5nNXZZgyoef2jbJ35UfFTdflSo/H1IDSLYPqIzIQOXSVPHQydrdsOD
         EvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729746847; x=1730351647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPqQBMMwaSEmbFsEPp8BP7GPHr7y6auO2zPri786Gfw=;
        b=tMdOIEcmGQznm35vdzbbEUcLiiflBo+6vxa6sq8aWW/seDY0GDxRiGCgGF2asyKBqI
         JVeSzJpW44cRI31eWKrOdPELK//PGsDNlB6i1a7LwcqJjE9m37RWHuq3fvwbQa3/fTJ3
         kRYSccfI8AZzaSR3xyGOwpHR4dPXTjfFZIAikjQOY/BoGBHHzQ6mhyhode9CS5XAis6D
         2CgisXZybQToxP0ROxzkubec3VbeqZaFHAgCmy2YmXNVrEiJlqcQiieBLdcjARjTe+f6
         nVDpBtcq0Tpw5L0TYsrgXQZUddMUeJTsA64U9kzD/UmFeOOt13YDih6hTFaYNI1p1rqU
         ibqQ==
X-Gm-Message-State: AOJu0YwBB01qljUBCcxfjcP9/DvqwFfNx/Y8r522VKTDlIZVpdUcqx/z
	wkMwpPaFMGN3L8VLHA1xuLoTTjcUDRmTxKtdLwGBTB00oHDjCTQP4EoSIoy+pLOhm9JNUzWxist
	YGYCok4gNv/xJN0KlPjeYTv57MzwUd3Am
X-Google-Smtp-Source: AGHT+IGGdbZ4LiscJrSCLy8Tw3GalEkgKbRpVgHdmxjuCAWuXkMQsAdZPD7CvH1U/00YgwLRsIOIdzGYaKKY8XA8RR4=
X-Received: by 2002:ac8:5e0e:0:b0:460:946c:9e47 with SMTP id
 d75a77b69052e-461145af602mr63042831cf.10.1729746847091; Wed, 23 Oct 2024
 22:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024032637.34286-1-quake.wang@gmail.com> <CALtW_ajR0hGz9aYdPgqW+TsZJw3QVYvPeA93fEGHKXAdk9RKYQ@mail.gmail.com>
In-Reply-To: <CALtW_ajR0hGz9aYdPgqW+TsZJw3QVYvPeA93fEGHKXAdk9RKYQ@mail.gmail.com>
From: Quake Wang <quake.wang@gmail.com>
Date: Thu, 24 Oct 2024 14:13:56 +0900
Message-ID: <CAJkr5LPL8K24_-_2NPrEyz=k=BBUM-PUE++eubAfZRWwsmZgVg@mail.gmail.com>
Subject: Re: [PATCH] Remove Huawei
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you haven't heard of huawei sanctions yet, you should try to read
the news some day. And by "news", I don't mean China state-sponsored
spam.



On Thu, Oct 24, 2024 at 12:38=E2=80=AFPM Dragan Milivojevi=C4=87
<d.milivojevic@gmail.com> wrote:
>
> The "compliance" purge continues.
> BTW strange how those "freedom countries" do not sanction Israel.
>
> PS
> For those who are going to complain that this mailing list should be
> free of politics,
> I agree, please direct your complaints to those making "freedom
> countries" remarks.
>
> On Thu, 24 Oct 2024 at 05:26, quake <quake.wang@gmail.com> wrote:
> >
> > From: Quake Wang <quake.wang@gmail.com>
> >
> > Remove some entries due to various compliance requirements. They cannot=
 come back in the future as huawei is sanctioned by most freedom countries =
in the world.
> > ---
> >  MAINTAINERS | 41 -----------------------------------------
> >  1 file changed, 41 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e9659a5a7fb3..400701a58534 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -322,7 +322,6 @@ F:  tools/power/acpi/
> >
> >  ACPI FOR ARM64 (ACPI/arm64)
> >  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> > -M:     Hanjun Guo <guohanjun@huawei.com>
> >  M:     Sudeep Holla <sudeep.holla@arm.com>
> >  L:     linux-acpi@vger.kernel.org
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > @@ -3873,7 +3872,6 @@ F:        Documentation/filesystems/befs.rst
> >  F:     fs/befs/
> >
> >  BFQ I/O SCHEDULER
> > -M:     Yu Kuai <yukuai3@huawei.com>
> >  L:     linux-block@vger.kernel.org
> >  S:     Odd Fixes
> >  F:     Documentation/block/bfq-iosched.rst
> > @@ -4082,7 +4080,6 @@ X:        arch/riscv/net/bpf_jit_comp64.c
> >
> >  BPF JIT for RISC-V (64-bit)
> >  M:     Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > -R:     Pu Lehui <pulehui@huawei.com>
> >  R:     Puranjay Mohan <puranjay@kernel.org>
> >  L:     bpf@vger.kernel.org
> >  S:     Maintained
> > @@ -5697,7 +5694,6 @@ F:        include/linux/compiler_attributes.h
> >
> >  COMPUTE EXPRESS LINK (CXL)
> >  M:     Davidlohr Bueso <dave@stgolabs.net>
> > -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
> >  M:     Dave Jiang <dave.jiang@intel.com>
> >  M:     Alison Schofield <alison.schofield@intel.com>
> >  M:     Vishal Verma <vishal.l.verma@intel.com>
> > @@ -5712,7 +5708,6 @@ F:        include/uapi/linux/cxl_mem.h
> >  F:     tools/testing/cxl/
> >
> >  COMPUTE EXPRESS LINK PMU (CPMU)
> > -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
> >  L:     linux-cxl@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/admin-guide/perf/cxl.rst
> > @@ -8525,7 +8520,6 @@ F:        include/uapi/linux/ext4.h
> >
> >  Extended Verification Module (EVM)
> >  M:     Mimi Zohar <zohar@linux.ibm.com>
> > -M:     Roberto Sassu <roberto.sassu@huawei.com>
> >  L:     linux-integrity@vger.kernel.org
> >  S:     Supported
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-i=
ntegrity.git
> > @@ -10189,21 +10183,17 @@ F:    net/dsa/tag_hellcreek.c
> >
> >  HISILICON DMA DRIVER
> >  M:     Zhou Wang <wangzhou1@hisilicon.com>
> > -M:     Jie Hai <haijie1@huawei.com>
> >  L:     dmaengine@vger.kernel.org
> >  S:     Maintained
> >  F:     drivers/dma/hisi_dma.c
> >
> >  HISILICON GPIO DRIVER
> > -M:     Jay Fang <f.fangjian@huawei.com>
> >  L:     linux-gpio@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio=
.yaml
> >  F:     drivers/gpio/gpio-hisi.c
> >
> >  HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
> > -M:     Zhiqi Song <songzhiqi1@huawei.com>
> > -M:     Longfang Liu <liulongfang@huawei.com>
> >  L:     linux-crypto@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/ABI/testing/debugfs-hisi-hpre
> > @@ -10212,7 +10202,6 @@ F:      drivers/crypto/hisilicon/hpre/hpre_cryp=
to.c
> >  F:     drivers/crypto/hisilicon/hpre/hpre_main.c
> >
> >  HISILICON HNS3 PMU DRIVER
> > -M:     Jijie Shao <shaojijie@huawei.com>
> >  S:     Supported
> >  F:     Documentation/admin-guide/perf/hns3-pmu.rst
> >  F:     drivers/perf/hisilicon/hns3_pmu.c
> > @@ -10226,31 +10215,24 @@ F:    Documentation/devicetree/bindings/i2c/h=
isilicon,ascend910-i2c.yaml
> >  F:     drivers/i2c/busses/i2c-hisi.c
> >
> >  HISILICON KUNPENG SOC HCCS DRIVER
> > -M:     Huisong Li <lihuisong@huawei.com>
> >  S:     Maintained
> >  F:     Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
> >  F:     drivers/soc/hisilicon/kunpeng_hccs.c
> >  F:     drivers/soc/hisilicon/kunpeng_hccs.h
> >
> >  HISILICON LPC BUS DRIVER
> > -M:     Jay Fang <f.fangjian@huawei.com>
> >  S:     Maintained
> >  W:     http://www.hisilicon.com
> >  F:     Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.y=
aml
> >  F:     drivers/bus/hisi_lpc.c
> >
> >  HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
> > -M:     Jian Shen <shenjian15@huawei.com>
> > -M:     Salil Mehta <salil.mehta@huawei.com>
> > -M:     Jijie Shao <shaojijie@huawei.com>
> >  L:     netdev@vger.kernel.org
> >  S:     Maintained
> >  W:     http://www.hisilicon.com
> >  F:     drivers/net/ethernet/hisilicon/hns3/
> >
> >  HISILICON NETWORK SUBSYSTEM DRIVER
> > -M:     Jian Shen <shenjian15@huawei.com>
> > -M:     Salil Mehta <salil.mehta@huawei.com>
> >  L:     netdev@vger.kernel.org
> >  S:     Maintained
> >  W:     http://www.hisilicon.com
> > @@ -10259,7 +10241,6 @@ F:      drivers/net/ethernet/hisilicon/
> >
> >  HISILICON PMU DRIVER
> >  M:     Yicong Yang <yangyicong@hisilicon.com>
> > -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
> >  S:     Supported
> >  W:     http://www.hisilicon.com
> >  F:     Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> > @@ -10268,7 +10249,6 @@ F:      drivers/perf/hisilicon
> >
> >  HISILICON PTT DRIVER
> >  M:     Yicong Yang <yangyicong@hisilicon.com>
> > -M:     Jonathan Cameron <jonathan.cameron@huawei.com>
> >  L:     linux-kernel@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_p=
tt
> > @@ -10279,7 +10259,6 @@ F:      tools/perf/util/hisi-ptt*
> >  F:     tools/perf/util/hisi-ptt-decoder/*
> >
> >  HISILICON QM DRIVER
> > -M:     Weili Qian <qianweili@huawei.com>
> >  M:     Zhou Wang <wangzhou1@hisilicon.com>
> >  L:     linux-crypto@vger.kernel.org
> >  S:     Maintained
> > @@ -10290,7 +10269,6 @@ F:      drivers/crypto/hisilicon/sgl.c
> >  F:     include/linux/hisi_acc_qm.h
> >
> >  HISILICON ROCE DRIVER
> > -M:     Chengchang Tang <tangchengchang@huawei.com>
> >  M:     Junxian Huang <huangjunxian6@hisilicon.com>
> >  L:     linux-rdma@vger.kernel.org
> >  S:     Maintained
> > @@ -10298,14 +10276,12 @@ F:    Documentation/devicetree/bindings/infin=
iband/hisilicon-hns-roce.txt
> >  F:     drivers/infiniband/hw/hns/
> >
> >  HISILICON SAS Controller
> > -M:     Yihang Li <liyihang9@huawei.com>
> >  S:     Supported
> >  W:     http://www.hisilicon.com
> >  F:     Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
> >  F:     drivers/scsi/hisi_sas/
> >
> >  HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
> > -M:     Longfang Liu <liulongfang@huawei.com>
> >  L:     linux-crypto@vger.kernel.org
> >  S:     Maintained
> >  F:     Documentation/ABI/testing/debugfs-hisi-sec
> > @@ -10315,7 +10291,6 @@ F:      drivers/crypto/hisilicon/sec2/sec_crypt=
o.h
> >  F:     drivers/crypto/hisilicon/sec2/sec_main.c
> >
> >  HISILICON SPI Controller DRIVER FOR KUNPENG SOCS
> > -M:     Jay Fang <f.fangjian@huawei.com>
> >  L:     linux-spi@vger.kernel.org
> >  S:     Maintained
> >  W:     http://www.hisilicon.com
> > @@ -10336,18 +10311,15 @@ F:    Documentation/devicetree/bindings/mfd/h=
isilicon,hi6421-spmi-pmic.yaml
> >  F:     drivers/mfd/hi6421-spmi-pmic.c
> >
> >  HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
> > -M:     Weili Qian <qianweili@huawei.com>
> >  S:     Maintained
> >  F:     drivers/crypto/hisilicon/trng/trng.c
> >
> >  HISILICON V3XX SPI NOR FLASH Controller Driver
> > -M:     Jay Fang <f.fangjian@huawei.com>
> >  S:     Maintained
> >  W:     http://www.hisilicon.com
> >  F:     drivers/spi/spi-hisi-sfc-v3xx.c
> >
> >  HISILICON ZIP Controller DRIVER
> > -M:     Yang Shen <shenyang39@huawei.com>
> >  M:     Zhou Wang <wangzhou1@hisilicon.com>
> >  L:     linux-crypto@vger.kernel.org
> >  S:     Maintained
> > @@ -10504,7 +10476,6 @@ T:      git git://linuxtv.org/media_tree.git
> >  F:     drivers/media/platform/st/sti/hva
> >
> >  HWPOISON MEMORY FAILURE HANDLING
> > -M:     Miaohe Lin <linmiaohe@huawei.com>
> >  R:     Naoya Horiguchi <nao.horiguchi@gmail.com>
> >  L:     linux-mm@kvack.org
> >  S:     Maintained
> > @@ -11243,7 +11214,6 @@ F:      drivers/crypto/inside-secure/
> >
> >  INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
> >  M:     Mimi Zohar <zohar@linux.ibm.com>
> > -M:     Roberto Sassu <roberto.sassu@huawei.com>
> >  M:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> >  R:     Eric Snowberg <eric.snowberg@oracle.com>
> >  L:     linux-integrity@vger.kernel.org
> > @@ -12447,7 +12417,6 @@ M:      Marc Zyngier <maz@kernel.org>
> >  M:     Oliver Upton <oliver.upton@linux.dev>
> >  R:     Joey Gouly <joey.gouly@arm.com>
> >  R:     Suzuki K Poulose <suzuki.poulose@arm.com>
> > -R:     Zenghui Yu <yuzenghui@huawei.com>
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> >  L:     kvmarm@lists.linux.dev
> >  S:     Maintained
> > @@ -20497,7 +20466,6 @@ F:      drivers/iio/chemical/ens160.h
> >
> >  SCSI LIBSAS SUBSYSTEM
> >  R:     John Garry <john.g.garry@oracle.com>
> > -R:     Jason Yan <yanaijie@huawei.com>
> >  L:     linux-scsi@vger.kernel.org
> >  S:     Supported
> >  F:     Documentation/scsi/libsas.rst
> > @@ -21303,7 +21271,6 @@ F:      include/linux/property.h
> >
> >  SOFTWARE RAID (Multiple Disks) SUPPORT
> >  M:     Song Liu <song@kernel.org>
> > -R:     Yu Kuai <yukuai3@huawei.com>
> >  L:     linux-raid@vger.kernel.org
> >  S:     Supported
> >  Q:     https://patchwork.kernel.org/project/linux-raid/list/
> > @@ -23549,7 +23516,6 @@ F:      include/uapi/misc/uacce/
> >
> >  UBI FILE SYSTEM (UBIFS)
> >  M:     Richard Weinberger <richard@nod.at>
> > -R:     Zhihao Cheng <chengzhihao1@huawei.com>
> >  L:     linux-mtd@lists.infradead.org
> >  S:     Supported
> >  W:     http://www.linux-mtd.infradead.org/doc/ubifs.html
> > @@ -23699,7 +23665,6 @@ F:      drivers/ufs/host/ufs-renesas.c
> >
> >  UNSORTED BLOCK IMAGES (UBI)
> >  M:     Richard Weinberger <richard@nod.at>
> > -R:     Zhihao Cheng <chengzhihao1@huawei.com>
> >  L:     linux-mtd@lists.infradead.org
> >  S:     Supported
> >  W:     http://www.linux-mtd.infradead.org/
> > @@ -23803,7 +23768,6 @@ S:      Maintained
> >  F:     drivers/usb/roles/intel-xhci-usb-role-switch.c
> >
> >  USB IP DRIVER FOR HISILICON KIRIN 960
> > -M:     Yu Chen <chenyu56@huawei.com>
> >  M:     Binghui Wang <wangbinghui@hisilicon.com>
> >  L:     linux-usb@vger.kernel.org
> >  S:     Maintained
> > @@ -24183,8 +24147,6 @@ S:      Orphan
> >  F:     drivers/vfio/fsl-mc/
> >
> >  VFIO HISILICON PCI DRIVER
> > -M:     Longfang Liu <liulongfang@huawei.com>
> > -M:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >  L:     kvm@vger.kernel.org
> >  S:     Maintained
> >  F:     drivers/vfio/pci/hisilicon/
> > @@ -24213,7 +24175,6 @@ F:      drivers/vfio/pci/nvgrace-gpu/
> >  VFIO PCI DEVICE SPECIFIC DRIVERS
> >  R:     Jason Gunthorpe <jgg@nvidia.com>
> >  R:     Yishai Hadas <yishaih@nvidia.com>
> > -R:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >  R:     Kevin Tian <kevin.tian@intel.com>
> >  L:     kvm@vger.kernel.org
> >  S:     Maintained
> > @@ -24395,7 +24356,6 @@ F:      tools/virtio/
> >  F:     tools/testing/selftests/drivers/net/virtio_net/
> >
> >  VIRTIO CRYPTO DRIVER
> > -M:     Gonglei <arei.gonglei@huawei.com>
> >  L:     virtualization@lists.linux.dev
> >  L:     linux-crypto@vger.kernel.org
> >  S:     Maintained
> > @@ -25481,7 +25441,6 @@ F:      drivers/input/misc/yealink.*
> >
> >  Z3FOLD COMPRESSED PAGE ALLOCATOR
> >  M:     Vitaly Wool <vitaly.wool@konsulko.com>
> > -R:     Miaohe Lin <linmiaohe@huawei.com>
> >  L:     linux-mm@kvack.org
> >  S:     Maintained
> >  F:     mm/z3fold.c
> > --
> > 2.39.5 (Apple Git-154)
> >
> >

