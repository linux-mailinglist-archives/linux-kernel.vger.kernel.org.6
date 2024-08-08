Return-Path: <linux-kernel+bounces-279046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A894B83E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0FF1C24593
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EE188CB6;
	Thu,  8 Aug 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvBtZR27"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A318801B;
	Thu,  8 Aug 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103430; cv=none; b=K9t8JCyh+6d8wk3buOnLhIDcTxUZqUOfn1Q3kJ0l8IJ/QT8HmNe9XvComMeRQM7Exqd36X3b1f4gruzv+VXGLUyVyYxuPk1pEEPcw0peR/pARi/QIhCekNKLMYpGTHMVWLTfkk2gZ5JPE8nGKmaEofqT0ku5yxRrqNqaTcFEYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103430; c=relaxed/simple;
	bh=cdAcsRX8PzRuhpsVg+nJFD39f1PcfB55FWkob4vmMeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBrpm+CzggDRv/zfQiX/9T7BT0wwk5yXjT+Yz0Ah+6TknUOWtgvH31Br6dZ5GkUp2llDmKQTiSfF5x3DrTwyp4S1JuqxX7HsHoV+z54UgaFvP/3+VZ1cDu3s1QV4Np5o7+LFp/6/g8/jEpJ7ZKen+pmwEoWiZyop0M4n6+cunc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvBtZR27; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103429; x=1754639429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cdAcsRX8PzRuhpsVg+nJFD39f1PcfB55FWkob4vmMeI=;
  b=GvBtZR27LGua0x8Z1bp9h15aB3gOAX203rRv6VuHLg2uhTQAIcAbe92Q
   B9bWefzkQeCykilFR7AByDXkavtLYUbBAA1M4z0FDbsLi7UnawuRz1SVk
   mdj6315Gi/7lQYEBEzobNo24KUfXndjWyTZ4rX7MJRJDLualmNXXRap8k
   OWpLl4BLkoUqYat6fnv9iO5t4Rws9kejObb2XczlP4zLjyoAWqAbee2cy
   vyYYshjqf7l5mTDHAz/90XyX+u2npQVpo2F1VjuFkfsw2vOOuZXGDrl7Q
   xNTs4Yd+quUoISjgUtQ2ko30PUDqI4HZ5a1+t59GzN5xek2kiGOPJv+EC
   g==;
X-CSE-ConnectionGUID: kGZ32MLMSHWgl4t+tx010A==
X-CSE-MsgGUID: 93Qpq/bQQeWrJXKLeWtGsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32618830"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="32618830"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:50:28 -0700
X-CSE-ConnectionGUID: sl/eGk/lTU6IXWw9530OdQ==
X-CSE-MsgGUID: taHcyNrtTbeCc8ReeWS5sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57059517"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 00:50:25 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbxug-00061i-1U;
	Thu, 08 Aug 2024 07:50:22 +0000
Date: Thu, 8 Aug 2024 15:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev
 port features
Message-ID: <202408081557.FiEe9Tzz-lkp@intel.com>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>

Hi Marco,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0c3836482481200ead7b416ca80c68a29cfdaabd]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/usb-hub-add-infrastructure-to-pass-onboard_dev-port-features/20240807-224100
base:   0c3836482481200ead7b416ca80c68a29cfdaabd
patch link:    https://lore.kernel.org/r/20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9%40pengutronix.de
patch subject: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev port features
config: i386-randconfig-141-20240808 (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408081557.FiEe9Tzz-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/usb/core/hub.o: in function `set_port_feature':
>> drivers/usb/core/hub.c:481: undefined reference to `onboard_dev_port_feature'
   ld: drivers/usb/core/hub.o: in function `usb_clear_port_feature':
   drivers/usb/core/hub.c:462: undefined reference to `onboard_dev_port_feature'


vim +481 drivers/usb/core/hub.c

   466	
   467	/*
   468	 * USB 2.0 spec Section 11.24.2.13
   469	 */
   470	static int set_port_feature(struct usb_device *hdev, int port1, int feature)
   471	{
   472		int ret;
   473	
   474		ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
   475			USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
   476			NULL, 0, 1000);
   477		if (ret)
   478			return ret;
   479	
   480		if (!is_root_hub(hdev))
 > 481			ret = onboard_dev_port_feature(hdev, true, feature, port1);
   482	
   483		return ret;
   484	}
   485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

