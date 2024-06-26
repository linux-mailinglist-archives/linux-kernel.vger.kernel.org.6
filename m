Return-Path: <linux-kernel+bounces-231106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DB918640
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06485282C39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D218E745;
	Wed, 26 Jun 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo/CKOts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321118A920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417150; cv=none; b=VZJQWMjS9cDG1oV5nfIoMGPfCMyatO1eOM+8aGQFA/r+EjO6brea/djVfvsJ+ed6hznbaruCZIw0HpQgdUkVq25suqT+6wflUsimlTivMy64GevKOVpSXKf43VsYBCKLizYI8X8o2JSMJPgbLNacVHwd2R0ZW8YsXqnDIWE30qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417150; c=relaxed/simple;
	bh=BeSkWC+dMU6fp1LVa5TKfH57qhj1LhEWMP6oz/BjJmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0wGtt6Qq3HLkcKoQogxy77b1N/QRfPuLtYUVLYc4P6CR8pLnkGWa3qoKdztOYwubFGOoCqAs2wZ+fF5ZlfWMFxGGNHyBjAH0IxM10W7qV1XORmDh+J85lfDlQ2kFX0/R94mRLnQTdBSFUBVcn5Ljn552Ns3dfFEt08eIA1t2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo/CKOts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A21C116B1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417149;
	bh=BeSkWC+dMU6fp1LVa5TKfH57qhj1LhEWMP6oz/BjJmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bo/CKOts1skJIZzKhA/3Dr2w2khwRYgflw/FpRZYKfqsh+MmtCQmA6J1nEzNOpD4J
	 khdmbK8XNoyUvh7lcE9dIe73RJ/zXDz9AVnpIMs4tYJ5Vz2UzWeEKFbzaTYEa5/qDq
	 eYWSw/pZool+0WvhOlb2NZyDUdTb29BZr8Otu/OU6Nob0WcSbTee0SpI/FFl2TyxCI
	 6VNWxA+h0V4W24WGRcjByzSRRbjgKS26N25mrKVhhS9+VJvnmdRnNBTVQz/uoeZpdK
	 YzxGQxDw4QgKpfiLeECMut4TTpyBgjWTpIPm3v4Ot8A/pUsETO4gnEvNBR3nlLn4VU
	 2mmje20iL5MCQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso4885465e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:52:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIY6OnQCrGCPa+0VO05bxgdXGgoigW+4e/JnjdCV4zpU7rMF0FHUuL3Z4JSjIvjsfONqca3zy2V9amskiRdjoJH/65ZSZGn7l8YUHr
X-Gm-Message-State: AOJu0YypzlSLt4EJD4DP14JspjDz0csAiAksCaJ8v2HtqsQ0ddYHsRTI
	67vg2PT6zQTtLThxFzxdEv8RpG0iZOw7RLs96GLim8DaChH/2Ynq2+fUpWhnSPOKkFwxFdXfXh2
	1M4JpzBxfW/tlbwBg3YMJHgbZXQ==
X-Google-Smtp-Source: AGHT+IELTgv3Vgj/jRqx/0s22N0SmRMCVO2L7Yk9oAe7phY/30IBoo4NBwmEZaqmKgrROZPDHt49FlgaJ9rQGRVlbe4=
X-Received: by 2002:a05:6512:3988:b0:52d:b1e4:b327 with SMTP id
 2adb3069b0e04-52db1e4b3eamr2198872e87.43.1719417148217; Wed, 26 Jun 2024
 08:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406261035.zMmqCcJd-lkp@intel.com>
In-Reply-To: <202406261035.zMmqCcJd-lkp@intel.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jun 2024 09:52:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJc5knXYEcJjf2gP2mw_qLrj-KnekYJUrz=ak2XcatbbA@mail.gmail.com>
Message-ID: <CAL_JsqJc5knXYEcJjf2gP2mw_qLrj-KnekYJUrz=ak2XcatbbA@mail.gmail.com>
Subject: Re: WARNING: modpost: "__udelay" [drivers/char/hw_random/intel-rng.ko]
 has no CRC!
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:09=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Rob,
>
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
> commit: 1ce1cd8208ad6060e4fcf6e09068c8954687c127 hwrng: Enable COMPILE_TE=
ST for more drivers
> date:   11 months ago
> config: sparc-randconfig-001-20240626 (https://download.01.org/0day-ci/ar=
chive/20240626/202406261035.zMmqCcJd-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240626/202406261035.zMmqCcJd-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406261035.zMmqCcJd-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/sit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/atm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/lec.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/mpoa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/smc/smc_diag.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/6lowpan/6lowpan.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
> ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] und=
efined!
> ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] und=
efined!
> ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefin=
ed!
> ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefi=
ned!
> ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefi=
ned!
> ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefi=
ned!
> ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undef=
ined!
> ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
> WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version gener=
ation failed, symbol will not be versioned.
> Is "empty_zero_page" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation f=
ailed, symbol will not be versioned.
> Is "__udelay" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation f=
ailed, symbol will not be versioned.
> Is "__ndelay" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation =
failed, symbol will not be versioned.
> Is "__ashldi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation =
failed, symbol will not be versioned.
> Is "__ashrdi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generatio=
n failed, symbol will not be versioned.
> Is "bzero_1page" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generati=
on failed, symbol will not be versioned.
> Is "__copy_1page" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation f=
ailed, symbol will not be versioned.
> Is "__divdi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version gene=
ration failed, symbol will not be versioned.
> Is "___rw_read_enter" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version gener=
ation failed, symbol will not be versioned.
> Is "___rw_read_exit" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version genera=
tion failed, symbol will not be versioned.
> Is "___rw_read_try" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version gen=
eration failed, symbol will not be versioned.
> Is "___rw_write_enter" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation =
failed, symbol will not be versioned.
> Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation f=
ailed, symbol will not be versioned.
> Is "__muldi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [fs/ext4/ext4.ko] has no CRC!
> WARNING: modpost: "__ashrdi3" [fs/ext4/ext4.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [fs/ext2/ext2.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [fs/jbd2/jbd2.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [fs/afs/kafs.ko] has no CRC!
> WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
> WARNING: modpost: "__lshrdi3" [lib/test_scanf.ko] has no CRC!
> WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
> WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/allwinner/phy-sun6i-mipi-dphy.k=
o] has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] =
has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-ns2-usbdrd.ko]=
 has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-sr-usb.ko] has=
 no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-emmc.ko=
] has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko]=
 has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-mmp3-usb.ko] has no=
 CRC!
> WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-pxa-usb.ko] has no =
CRC!
> WARNING: modpost: "__udelay" [drivers/phy/renesas/r8a779f0-ether-serdes.k=
o] has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsid=
phy.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] =
has no CRC!
> WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko]=
 has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no =
CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/arcfb.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no =
CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/i740fb.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_DAC1064=
.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/riva/rivafb.ko] has no =
CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no=
 CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no=
 CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC=
!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no=
 CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no C=
RC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] h=
as no CRC!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/da8xx-fb.ko] has no CRC=
!
> WARNING: modpost: "__udelay" [drivers/video/fbdev/ssd1307fb.ko] has no CR=
C!
> WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/clk/qcom/clk-qcom.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/clk/qcom/gcc-ipq4019.ko] has no CRC=
!
> WARNING: modpost: "__udelay" [drivers/soc/mediatek/mtk-mutex.ko] has no C=
RC!
> WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
> WARNING: modpost: "___rw_read_exit" [drivers/vdpa/vdpa_user/vduse.ko] has=
 no CRC!
> WARNING: modpost: "__udelay" [drivers/regulator/rk808-regulator.ko] has n=
o CRC!
> WARNING: modpost: "__udelay" [drivers/regulator/ti-abb-regulator.ko] has =
no CRC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_dw.ko] has no =
CRC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/samsung_tty.ko] has no C=
RC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/sh-sci.ko] has no CRC!
> WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/msm_serial.ko] has no CR=
C!
> WARNING: modpost: "__udelay" [drivers/tty/serial/omap-serial.ko] has no C=
RC!
> WARNING: modpost: "__udelay" [drivers/tty/serial/mxs-auart.ko] has no CRC=
!
> >> WARNING: modpost: "__udelay" [drivers/char/hw_random/intel-rng.ko] has=
 no CRC!
> WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no=
 CRC!
> >> WARNING: modpost: "__udelay" [drivers/char/hw_random/geode-rng.ko] has=
 no CRC!

Best I can tell, all these warnings in this report and other similar
ones recently sent out were fixed by commit 839c4dece274 ("sparc32:
Fix version generation failed warnings").

Rob

