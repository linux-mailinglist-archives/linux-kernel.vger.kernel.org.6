Return-Path: <linux-kernel+bounces-249831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C092F077
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C11283EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978C19F468;
	Thu, 11 Jul 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4iTo5Fy"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D3130A46
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730881; cv=none; b=nzcgwMVKlsqHyBg3in51GFvLD5QFest7tm0381BkfKtmd9a9TRuiH4kx4TCXHM/1tiHH4A0ZBxvyQwCSqM7ULa+coaIgBT++vx32/gBBBMLN/mjp8138qTYt9tVlT3Bh6gcqy6y+wAFKGqjWO5lYaDnrQ1nNQF7nuHjrBnhvCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730881; c=relaxed/simple;
	bh=aFDQRF4ylim0CVaguWsGm93vFqd6nUNkM1Ml56cdOXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls657VGU2tW6q561cxa/uQTXbTpVOwYBMaEPaj8FATH+mRexk5D7RGYCKTzihvijvxnt/o+92Gy0GahKe5j39fPoCaRwLVOBgzDjNFQ+V9I0u6ClVi6y64o5VFfgAwyP1rbHw7hsZFkk8nrFqtncqFBAJYBW4vDIR+wHNeUr+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4iTo5Fy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65bceed88a2so12566647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720730877; x=1721335677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yl8dUgw9EdkUkOPq8pdXJ6s8xN0KO2ME19oJSnxlNU=;
        b=h4iTo5FyT9sK7xf6cMjs4yyKYTE3btEUftaMnHNQPQLZILu2EjdjY2T2HN8eQNvyCa
         YjA3obxtyKEu+PRIOH4jqSWtmRKkJg+C3YHN/OPFfMYzcBdSYVPlUUVVFnM6JR5Mcm7c
         5qZjri2RyEQkpQ7OdJmXNlW0/BjXFvH2+7RMlMQCojOi2ztYPuXRSnFsWZRr4OSub/hg
         hHCt+EHEIZbVGQJAuLssjlztNkOfrWR8eE3LXkh1736i6mIAy2Zld1UdcrzyYEnRJWGT
         m2PnmZJW/iukqqA9CZaI/2Vuf4qUlBLmXKM3EifXdRSUMtHJIEM6eakUSR0Go+p9Bd9O
         cFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730877; x=1721335677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yl8dUgw9EdkUkOPq8pdXJ6s8xN0KO2ME19oJSnxlNU=;
        b=Sp99d0xdkdbQO0t/FwF+46goUbiiI5pyPArgB9tveEsFkgfeXs6S1xWk9+bjN8Fc+o
         m361rlUqUwWv/VF1I1yiwr0EUcqMgyByUL4A8DNumkuDWH2bvG/lOlNPioReYmlz98UB
         wCco9g6hozyxU534VawnnD+S6okRZa1pEYIj0sk1YzS4BeNKr9DqqJSRbEJvMcl8j24/
         VeeEfCd68FluL+Vj94Bce+0hadsttPq5tlLVR0R6MXJ8UhV2nzfntrFO8UQh7msWXfBR
         EYwQoWkJ3aNR7T/gDV8c53H1HHJak3Dsxrn3uAzVyvcsavj8DGSJdmCy0d5hZi/fhEyO
         dvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ/ju55TakOKekzgscHPWi/T6DcPdX57O8AdV/p2iqPg2HtzrJr12DSwrhlzBz3M/xFwSmcfn7R0CcLEY7OlO/Jivn7Rs/yGNZL9q
X-Gm-Message-State: AOJu0Ywl/IVt9II396rsC2Vp8JlSpm1z54QZnIXHiTB+7v56oCxwhtDA
	XnLDLHFX/HA3PIvbUdDo2hbHg0x941xec3wT6d3f2g+wVlb1KtrNqROrSlxoZqbg2Ld7FoEYnB5
	Q7nl6z86mOu3l1J8XjH8iomsiF1PnJ6S4jDaD
X-Google-Smtp-Source: AGHT+IH5fB277ElcxUlv3MxmnhQEGPYdTaljtEIFKk2nyr1M6yh3VDJvmRqlRtwOeqCu5nI4B5LvJceATIUi9E6D7YU=
X-Received: by 2002:a81:8d51:0:b0:643:9a13:fae2 with SMTP id
 00721157ae682-658ef3419b7mr103695177b3.28.1720730877018; Thu, 11 Jul 2024
 13:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407080044.DWMC9N9I-lkp@intel.com>
In-Reply-To: <202407080044.DWMC9N9I-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 13:47:44 -0700
Message-ID: <CAJuCfpH7TBEwwsLxCuQmhW=mFHWSsPez3e4r84J7=FnF9gtiPw@mail.gmail.com>
Subject: Re: ERROR: modpost: "mem_alloc_profiling_key" [arch/powerpc/kvm/kvm-hv.ko]
 undefined!
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 10:05=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
> commit: d224eb0287fbd84f4f13eca042c7f08f87138f3b codetag: debug: mark cod=
etags for reserved pages as empty
> date:   2 months ago
> config: powerpc64-randconfig-r112-20240707 (https://download.01.org/0day-=
ci/archive/20240708/202407080044.DWMC9N9I-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfd=
cc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20240708/202407080044=
.DWMC9N9I-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp=
@intel.com/

Fix is posted at:
https://lore.kernel.org/all/20240711204626.1669138-1-surenb@google.com/

>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/8250=
/serial_cs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/seri=
al_mctrl_gpio.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/n_gsm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/p=
anel-auo-a030jtn01.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/p=
anel-innolux-ej030na.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/p=
anel-novatek-nt39016.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/p=
anel-orisetech-ota5601a.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/=
lontium-lt9611.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/=
sii9234.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/bo=
chs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_pan=
el_orientation_quirks.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mip=
i_dbi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/reg=
map-slimbus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/reg=
map-sccb.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gp=
io.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/rt4831.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dax/dax.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_co=
re.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/scsi_commo=
n.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/advansys.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/BusLogic.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/elx/efct.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/atp870u.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-fsl-lib=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/char=
lcd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44=
780_common.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line=
-display.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_so=
cket.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-f=
map.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-=
ccgx-ucsi.o
> WARNING: modpost: drivers/media/i2c/et8ek8/et8ek8: section mismatch in re=
ference: et8ek8_i2c_driver+0x10 (section: .data) -> et8ek8_remove (section:=
 .exit.text)
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/td=
a9887.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/platform/=
marvell/mcam-core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core=
/v4l2-async.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core=
/v4l2-fwnode.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-c=
pro.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/cpufreq=
-dt-platdev.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds=
-rt4505.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google=
/coreboot_table.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google=
/framebuffer-coreboot.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google=
/cbmem.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google=
/vpd-sysfs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/atmel-sh=
a204a.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-aureal.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cypress=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-dr.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-emsff.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-elecom.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-vivaldi=
-common.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensing=
ton.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouc=
h.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kye.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lcpower=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmo=
use.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-montere=
y.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ortek.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalyn=
x.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-redrago=
n.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-saitek.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sjoy.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan=
.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-xinmo.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewson=
ic.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-hid.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-power-supply.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-audio-manager.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-gpio.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-spi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus=
/gb-spilib.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_cha=
r.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governo=
r_performance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governo=
r_powersave.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governo=
r_userspace.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-b=
oot-env.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-=
gpio.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/ifcvf/ifcv=
f.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_u=
til.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_c=
mdset_0020.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_fu=
ncs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/core/snd-pcm-dmae=
ngine.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-so=
c-sigmadsp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-so=
c-wm-adsp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/xilinx/snd-so=
c-xlnx-i2s.o
> >> ERROR: modpost: "mem_alloc_profiling_key" [arch/powerpc/kvm/kvm-hv.ko]=
 undefined!
> >> ERROR: modpost: "page_ext_get" [arch/powerpc/kvm/kvm-hv.ko] undefined!
> >> ERROR: modpost: "page_ext_put" [arch/powerpc/kvm/kvm-hv.ko] undefined!
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

