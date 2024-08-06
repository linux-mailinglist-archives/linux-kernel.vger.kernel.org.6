Return-Path: <linux-kernel+bounces-276873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5A949964
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A1B286DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D25170A28;
	Tue,  6 Aug 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQ2Wgocs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FA15B147
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977048; cv=none; b=W68b0PCwASNs2UEwaFNMyPJlSl+4WHq9a6L2d5UnkcUbIMp2BSbNtqS70bU7Y34TzrJduc9r+Q4QiRcSMsXras0ChZzda7ru+nTCppFtQ59lqwtAsZyAlEvMm1lG8sL0Z1e9YxWUgXfag5+nf8JBEnMh7st1r2vve1PGbJvt4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977048; c=relaxed/simple;
	bh=IutHGMeTkeySW5/QvcVGeAyZEXnmwsngxPhILvafk/4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cF9W/7qYuT2S4+eSvq6WGPnXtE6uEXFFz1TremaxUn2w2WuLKZcPg5ud0ZfQJk97suaANR1rNNsNa2lNwhzIvL37oFkpaY6HjpS5m8rbhGwrseiuMf7KLe8Fx9E0fdziHSF7m2t1J56sigM0ul/1/6YxK8ASmJq4Gn7YpBE1Yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQ2Wgocs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722977046; x=1754513046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IutHGMeTkeySW5/QvcVGeAyZEXnmwsngxPhILvafk/4=;
  b=YQ2Wgocs8g6M0LrgoxN/HKEdevlJKpxfGOGTQGIB1r+s9Z92eq8eSX6H
   pfAIFWXt0qkSdAUXOZx0iHz780Oa53apN3AakgU1/D6KDUGUMSIO1rHT1
   Y+WOpsWJoSBMOV0DfTE/lVaxbgs94IuQ+ZRtor8ZhUw1QFdZ6MFAYH8sa
   efi3m67VROV1cwZ+DWlqfZm1nXJfdkVILcD0cWH6oIzlPAoW65C5q+SGk
   YPX1vWpIbcMwTf8h/om1M8jenm6CucwPtHA7fcEKe8DnnPZhvKhGGF4Om
   pJL73RfL7lhaWzvgeWFEYS2p+RWOtZOGXSOsMB2y+JE7Jt49DFlwfWk4q
   g==;
X-CSE-ConnectionGUID: vNr3D1yJQ5mXh0y2wdmg6A==
X-CSE-MsgGUID: /Zy8rhmXRCOpcfal2cYRcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38526902"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38526902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 13:44:05 -0700
X-CSE-ConnectionGUID: Sg5ZoonVTfqVJDgwVwumdA==
X-CSE-MsgGUID: lVzE3irpQai0H/rfJf9GCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56577988"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2024 13:44:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbR2I-0004pE-13;
	Tue, 06 Aug 2024 20:44:02 +0000
Date: Wed, 7 Aug 2024 04:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
Message-ID: <202408070432.X6n56VaY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kent,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb5e56d1491297e0881c95824e2050b7c205f0d4
commit: 9ae82fe6ace1b267005758ccfb2347a4a6aa4398 bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
date:   10 months ago
config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408070432.X6n56VaY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/pcs/pcs-mtk-lynxi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_synctty.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/dummy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/plip/plip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-qup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/i2c/uda1342.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/au8522_decoder.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/platform/samsung/exynos4-is/exynos-fimc-is.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/platform/samsung/exynos4-is/exynos4-is-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/radio/si470x/radio-si470x-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/blink/leds-bcm63138.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-apple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-belkin.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-dr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-emsff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-evision.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouch.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmouse.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-microsoft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sjoy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-steam.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zpff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mp-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/qcom/interconnect_qcom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/core/snd-pcm-dmaengine.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/soc-topology-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/codecs/snd-soc-wm-adsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/snd-acp-config.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-fiq.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/xilinx/snd-soc-xlnx-i2s.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/xilinx/snd-soc-xlnx-formatter-pcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/ac97_bus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/selftests.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/mrp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_hfsc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_sfq.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_drr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_ets.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_skbprio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/sch_etf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/cls_u32.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/cls_fw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netlink/netlink_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_wlc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ar9331.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_brcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_dsa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_gswip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_hellcreek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ksz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_lan9303.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_mtk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_none.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot_8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_qca.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl8_4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_sja1105.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_trailer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_xrs700x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/8021q/8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xdp/xsk_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/mptcp/mptcp_crypto_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/mptcp/mptcp_token_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/sunrpc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/auth_gss/auth_rpcgss.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/auth_gss/rpcsec_gss_krb5.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/tipc/diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

