Return-Path: <linux-kernel+bounces-431958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127F9E4324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9FD1681D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F217BB1C;
	Wed,  4 Dec 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYZ2l8gz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACE239190
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336202; cv=none; b=c+1+gSg13gG79WdwM2EQTLpLFenSiMAo8pk0LjEKEDuHWFqkmIzW7x84tqqoR4lvJ2KNnkiSlaaimn9kuHTiSj/tSh2dnG3uLVkyazXetBIxQuDOABAwtkC14XvI1JJ+Q/ujNQ8SoBbsWjwJTPeJaWFUDvIVJGjEsWCNn9mTiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336202; c=relaxed/simple;
	bh=YKOza2Vwkc0Vz8h47QH3KaQnEXcATfJSp4Fyg1Wes4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gDPRVL40EN4jEia0h8mxUrQXOqlaGpDYuqsfWxeRncpj5FPAGIjGDZSKVoZXpal+GNtfA+UnnFDgi+hQD8I4bx+1BajLV9KwN0oli+Kg0mCW2mKBEykWE4B+6e5DBGAnMbh6Va5t7KoQStf2P2hR2cbBRD/ruWr+hsL9GiOnBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYZ2l8gz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733336200; x=1764872200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YKOza2Vwkc0Vz8h47QH3KaQnEXcATfJSp4Fyg1Wes4w=;
  b=jYZ2l8gzqX1ivnQ2dmcO5+XOhbvD6HEidBWYacfNnNs4i2tzLwqdHlDO
   XGHc1ItWh1F8DI0ySzNPlsh5E5AD6jVssVh5uM4tm692/6L76dIOPpyYr
   GGhuiP9tkHfG1jGHbo2oW2/b+xc6tHJPFHIjFF832p+GkjSGKL66PqgPE
   Utd1VwbHLCFlP1KEypFVuoJ9apDzRuhHlTCYTQcnBYjr8eQQl8IyZDcVu
   Yv/8BermZlYp8Z7aFEeJ0mrtyo4AdLKvjARzqcBWQrtvnhN/HFptEWPMd
   3FzAhf7Hjfc+zFv7O5CHfHlr0gI5kcQAQS1UXBc6xDnVToOfuDjahddAi
   g==;
X-CSE-ConnectionGUID: IPUGg9uUQ3OMgmmT8xPt5Q==
X-CSE-MsgGUID: JeyWsuIYQVajeCuRidE74Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32959913"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="32959913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 10:16:40 -0800
X-CSE-ConnectionGUID: +nltSXxHS/yiQLXtLl6WhA==
X-CSE-MsgGUID: ILSiU2pTT/OSFOwDYM9RUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="98818562"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Dec 2024 10:16:38 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tItvP-0003NR-1H;
	Wed, 04 Dec 2024 18:16:35 +0000
Date: Thu, 5 Dec 2024 02:15:36 +0800
From: kernel test robot <lkp@intel.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/usb/renesas_usbhs/mod.c:195:6: warning: variable 'intenb0'
 set but not used
Message-ID: <202412050247.vVthPDpE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lad,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: 22ae6415c702680b1d3170717ce34ee31656f8b6 usb: renesas_usbhs: Use platform_get_irq() to get the interrupt
date:   2 years, 11 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241205/202412050247.vVthPDpE-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050247.vVthPDpE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050247.vVthPDpE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/renesas_usbhs/mod.c:195:6: warning: variable 'intenb0' set but not used [-Wunused-but-set-variable]
     195 |         u16 intenb0, intenb1;
         |             ^
   1 warning generated.


vim +/intenb0 +195 drivers/usb/renesas_usbhs/mod.c

f1407d5c66240b3 Kuninori Morimoto  2011-04-04  190  
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  191  static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  192  				     struct usbhs_irq_state *state)
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  193  {
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  194  	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20 @195  	u16 intenb0, intenb1;
c4d8199ba1a7aa3 Yoshihiro Shimoda  2014-08-22  196  	unsigned long flags;
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  197  
c4d8199ba1a7aa3 Yoshihiro Shimoda  2014-08-22  198  	/********************  spin lock ********************/
c4d8199ba1a7aa3 Yoshihiro Shimoda  2014-08-22  199  	usbhs_lock(priv, flags);
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  200  	state->intsts0 = usbhs_read(priv, INTSTS0);
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  201  	intenb0 = usbhs_read(priv, INTENB0);
88a25e02f35e56a Nobuhiro Iwamatsu  2015-01-09  202  
88a25e02f35e56a Nobuhiro Iwamatsu  2015-01-09  203  	if (usbhs_mod_is_host(priv)) {
88a25e02f35e56a Nobuhiro Iwamatsu  2015-01-09  204  		state->intsts1 = usbhs_read(priv, INTSTS1);
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  205  		intenb1 = usbhs_read(priv, INTENB1);
672bfdaa3100043 Arnd Bergmann      2015-05-22  206  	} else {
672bfdaa3100043 Arnd Bergmann      2015-05-22  207  		state->intsts1 = intenb1 = 0;
88a25e02f35e56a Nobuhiro Iwamatsu  2015-01-09  208  	}
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  209  
5ea68d541df200d Kuninori Morimoto  2011-04-28  210  	/* mask */
5ea68d541df200d Kuninori Morimoto  2011-04-28  211  	if (mod) {
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  212  		state->brdysts = usbhs_read(priv, BRDYSTS);
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  213  		state->nrdysts = usbhs_read(priv, NRDYSTS);
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  214  		state->bempsts = usbhs_read(priv, BEMPSTS);
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  215  
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  216  		state->bempsts &= mod->irq_bempsts;
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  217  		state->brdysts &= mod->irq_brdysts;
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  218  	}
c4d8199ba1a7aa3 Yoshihiro Shimoda  2014-08-22  219  	usbhs_unlock(priv, flags);
c4d8199ba1a7aa3 Yoshihiro Shimoda  2014-08-22  220  	/********************  spin unlock ******************/
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  221  
697d5c004e39010 Shimoda, Yoshihiro 2012-08-20  222  	return 0;
5ea68d541df200d Kuninori Morimoto  2011-04-28  223  }
f1407d5c66240b3 Kuninori Morimoto  2011-04-04  224  

:::::: The code at line 195 was first introduced by commit
:::::: 697d5c004e390102efbf9320a5416873679bea81 usb: renesas_usbhs: modify the irq handler for sharing irq

:::::: TO: Shimoda, Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

