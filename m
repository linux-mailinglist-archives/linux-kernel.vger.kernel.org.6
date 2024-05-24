Return-Path: <linux-kernel+bounces-188858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B28CE7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472DAB21CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE212DDBB;
	Fri, 24 May 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6PGk05K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334712DDA1;
	Fri, 24 May 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564535; cv=none; b=PVzMVlrUU30swh7FAhv13009TRxyKHhimATKZ2DGYlKyJR3u127w3aWosk+AKzSaHjCShY+rhQ1KviCPgC3Zb5tdptDFmiyNIMK+9jzZCJDIRcvhzhZ+eBxfPPLP18w1Qh6ksgV0EaosYI6pTX9KAI1MAs1rnQPgNSeyotPxh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564535; c=relaxed/simple;
	bh=Kzidk+/X+mIzUstxfR9cNO+dokBt4a9pH1CS92DLEq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfdzaB7QMCinwPqUc66LwxJAkr5iPZnVrv7sIllhKcNQ/fpJxKXGF9eD64ZvYAPSKdmqRTtoLEy7Pm6VtHM24clKgRQ2sgxNhyuTM8nPPNcA5o3xqHBQUfAY4RgRsfqfbtBqpawv/4d21UfDutrrz7m/02WRQB3oIM/xImoAdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6PGk05K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716564534; x=1748100534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kzidk+/X+mIzUstxfR9cNO+dokBt4a9pH1CS92DLEq0=;
  b=A6PGk05KRH1Ho0DT7MUs36sa+k2tBp/HWWLQxaF41u5cYegAjqrkU4U/
   DHmAHXMw3SQfhHDBf1qgxSpiu8jwQUJ07O+nXyxA2jN2YzyfuP1bBoQq+
   xbdwO2jv6SBGbQa9hxi5bnEYrPbdRE6W2CS9Qdg5W52Wa11NUixUNXWAA
   vbqKbws24O6MO48xWbvf0iahj82bFp0temh1kWHHbLKhhBODFOheBypbg
   8FnuNKEpJeLO2DicS0Z/LgTuReDonbX0Vfi4iOqtKs0idPS2Oe2MIkquv
   +k6NTZANc6hO+wwliCP5mmcrj8AeZt66t9Ja/YoePAH9X3EGDNXlAnHZ+
   Q==;
X-CSE-ConnectionGUID: FJtEjP1BSdmPSNxV0jSMsA==
X-CSE-MsgGUID: wr3aM8JSTdWUgV9911AKyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13131703"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="13131703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 08:28:53 -0700
X-CSE-ConnectionGUID: Vw6Y5d2AQFC1tqeJtQt0hQ==
X-CSE-MsgGUID: EWuWvsjtQ7CTXFKCmg9reA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="33981275"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 May 2024 08:28:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAWqd-0005XV-22;
	Fri, 24 May 2024 15:28:47 +0000
Date: Fri, 24 May 2024 23:28:13 +0800
From: kernel test robot <lkp@intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org, jthies@google.com, bleung@chromium.org,
	abhishekpandit@chromium.org, saranya.gopal@intel.com, lk@c--e.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmalani@chromium.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: Re: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
Message-ID: <202405242305.UrCRaTK0-lkp@intel.com>
References: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>

Hi Diogo,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master next-20240523]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Diogo-Ivo/usb-typec-ucsi-Add-new-capability-bits/20240524-190924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240524105837.15342-3-diogo.ivo%40tecnico.ulisboa.pt
patch subject: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240524/202405242305.UrCRaTK0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405242305.UrCRaTK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405242305.UrCRaTK0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/ucsi.c:1686:10: error: use of undeclared identifier 'UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE'
           ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
                   ^
>> drivers/usb/typec/ucsi/ucsi.c:1689:11: error: use of undeclared identifier 'UCSI_ENABLE_NTFY_ATTENTION'
                   ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
                           ^
>> drivers/usb/typec/ucsi/ucsi.c:1692:11: error: use of undeclared identifier 'UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ'
                   ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
                           ^
>> drivers/usb/typec/ucsi/ucsi.c:1695:11: error: use of undeclared identifier 'UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER'
                   ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
                           ^
>> drivers/usb/typec/ucsi/ucsi.c:1698:11: error: use of undeclared identifier 'UCSI_ENABLE_NTFY_SET_RETIMER_MODE'
                   ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
                           ^
   5 errors generated.


vim +/UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE +1686 drivers/usb/typec/ucsi/ucsi.c

  1664	
  1665	static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
  1666	{
  1667		u16 features = ucsi->cap.features;
  1668		u64 ntfy = UCSI_ENABLE_NTFY_ALL;
  1669	
  1670		if (!(features & UCSI_CAP_ALT_MODE_DETAILS))
  1671			ntfy &= ~UCSI_ENABLE_NTFY_CAM_CHANGE;
  1672	
  1673		if (!(features & UCSI_CAP_PDO_DETAILS))
  1674			ntfy &= ~(UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE |
  1675				  UCSI_ENABLE_NTFY_CAP_CHANGE);
  1676	
  1677		if (!(features & UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS))
  1678			ntfy &= ~UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE;
  1679	
  1680		if (!(features & UCSI_CAP_PD_RESET))
  1681			ntfy &= ~UCSI_ENABLE_NTFY_PD_RESET_COMPLETE;
  1682	
  1683		if (ucsi->version <= UCSI_VERSION_1_2)
  1684			return ntfy;
  1685	
> 1686		ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
  1687	
  1688		if (features & UCSI_CAP_GET_ATTENTION_VDO)
> 1689			ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
  1690	
  1691		if (features & UCSI_CAP_FW_UPDATE_REQUEST)
> 1692			ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
  1693	
  1694		if (features & UCSI_CAP_SECURITY_REQUEST)
> 1695			ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
  1696	
  1697		if (features & UCSI_CAP_SET_RETIMER_MODE)
> 1698			ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
  1699	
  1700		return ntfy;
  1701	}
  1702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

