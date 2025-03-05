Return-Path: <linux-kernel+bounces-546653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A892A4FD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F46188A326
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C8241662;
	Wed,  5 Mar 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcLCXESG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D2233705;
	Wed,  5 Mar 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173069; cv=none; b=NSiAYeJriqeATZQUiMXHQI68oEzpsKaMK69Nsx1LVKoD5LAV37MGirsqTP/DFEb4nPDjXgYG8CA08AItqc1/Gqj0Gxkp0y+4wThs8DHIMGKqqLEjR/CUulbD9vkdiD6F2wFfa5ZBTxxG3JpoMfuk+GLKtojOI7w00+wTIgSl6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173069; c=relaxed/simple;
	bh=l/eh5Utgc8Qe7/nVqcNLUCiDiPo0upnh4WR61r3TlFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA0nK2/IZXjJudEr+nn7P3q7/VeL0yBdbL1U43IC4Qtvxme496cC04I+48y2qIRoEmVNMxwPb8XKL8+pGm1Yr2iCn8h28Ed+INYXzplUFGKKOQ8tuDWPSHaPTdKtdw6QQTBmPq9Y9tjoigmLaDOAGOozgV7lFdwYU/6FttZdBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcLCXESG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741173067; x=1772709067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/eh5Utgc8Qe7/nVqcNLUCiDiPo0upnh4WR61r3TlFM=;
  b=WcLCXESGHBBLKkVtHSRNoSxa/ZqQ4VC5LgNWsrE2hDNB3mvZvZY1PlCc
   a2kW1S3o8VjUrFpo1CaammUmuZMt9I8mepDEfB/6fe3y0boLCiRQrGtXE
   CfcL7oPI72KB+F7NCH321LDb9VGLyGSyR+z93N2Y7G7b69Vy8qxLrSVHE
   eTPhIUzQyoBtSUxdoKRcMHlVDRkpK/DX9QMUDFerzgEwC7N2fRqU1H4Ev
   N84H6OuyLNfsiNzcaUPjFtlLGnJLlTcnMA/TxM6DzDEj6CPs+GUwAPved
   lPjYIqKGKy19J4PWYDejScUYr5lH5dWRkEDD0Sw6n0WXFb81yt6nLxZrZ
   Q==;
X-CSE-ConnectionGUID: PBV1g7JZQ1SYNKhxLtL73Q==
X-CSE-MsgGUID: yvGtfI32SqOPaJ/x6pCFyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42257604"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="42257604"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 03:11:06 -0800
X-CSE-ConnectionGUID: Y7uKTVhoRgSqO6Kenuex9Q==
X-CSE-MsgGUID: 95AlKAQtRuqe4PEJ7IhpeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118680317"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 05 Mar 2025 03:11:03 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpmeO-000KsX-2P;
	Wed, 05 Mar 2025 11:10:57 +0000
Date: Wed, 5 Mar 2025 19:10:23 +0800
From: kernel test robot <lkp@intel.com>
To: Kurt Borja <kuurtb@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
Message-ID: <202503051819.bQ9P70Og-lkp@intel.com>
References: <20250225222500.23535-8-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225222500.23535-8-kuurtb@gmail.com>

Hi Kurt,

kernel test robot noticed the following build errors:

[auto build test ERROR on c86e269c4da6dca2beaf99bdc6fd9f0a9f69035f]

url:    https://github.com/intel-lab-lkp/linux/commits/Kurt-Borja/platform-x86-alienware-wmi-wmax-Rename-thermal-related-symbols/20250226-063232
base:   c86e269c4da6dca2beaf99bdc6fd9f0a9f69035f
patch link:    https://lore.kernel.org/r/20250225222500.23535-8-kuurtb%40gmail.com
patch subject: [PATCH v2 07/10] platform/x86: alienware-wmi-wmax: Add HWMON support
config: x86_64-randconfig-074-20250305 (https://download.01.org/0day-ci/archive/20250305/202503051819.bQ9P70Og-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503051819.bQ9P70Og-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503051819.bQ9P70Og-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `awcc_platform_profile_init':
>> drivers/platform/x86/dell/alienware-wmi-wmax.c:1096: undefined reference to `devm_platform_profile_register'
   ld: vmlinux.o: in function `awcc_hwmon_init':
>> drivers/platform/x86/dell/alienware-wmi-wmax.c:951: undefined reference to `devm_hwmon_device_register_with_info'


vim +1096 drivers/platform/x86/dell/alienware-wmi-wmax.c

d29a9de20be84d Kurt Borja 2025-02-25   932  
d29a9de20be84d Kurt Borja 2025-02-25   933  static int awcc_hwmon_init(struct wmi_device *wdev)
d29a9de20be84d Kurt Borja 2025-02-25   934  {
d29a9de20be84d Kurt Borja 2025-02-25   935  	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
d29a9de20be84d Kurt Borja 2025-02-25   936  	int ret;
d29a9de20be84d Kurt Borja 2025-02-25   937  
d29a9de20be84d Kurt Borja 2025-02-25   938  	priv->fan_data = devm_kcalloc(&wdev->dev, priv->fan_count,
d29a9de20be84d Kurt Borja 2025-02-25   939  				      sizeof(*priv->fan_data), GFP_KERNEL);
d29a9de20be84d Kurt Borja 2025-02-25   940  	if (!priv->fan_data)
d29a9de20be84d Kurt Borja 2025-02-25   941  		return -ENOMEM;
d29a9de20be84d Kurt Borja 2025-02-25   942  
d29a9de20be84d Kurt Borja 2025-02-25   943  	ret = awcc_hwmon_temps_init(wdev);
d29a9de20be84d Kurt Borja 2025-02-25   944  	if (ret)
d29a9de20be84d Kurt Borja 2025-02-25   945  		return ret;
d29a9de20be84d Kurt Borja 2025-02-25   946  
d29a9de20be84d Kurt Borja 2025-02-25   947  	ret = awcc_hwmon_fans_init(wdev);
d29a9de20be84d Kurt Borja 2025-02-25   948  	if (ret)
d29a9de20be84d Kurt Borja 2025-02-25   949  		return ret;
d29a9de20be84d Kurt Borja 2025-02-25   950  
d29a9de20be84d Kurt Borja 2025-02-25  @951  	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
d29a9de20be84d Kurt Borja 2025-02-25   952  							   &awcc_hwmon_chip_info, NULL);
d29a9de20be84d Kurt Borja 2025-02-25   953  
d29a9de20be84d Kurt Borja 2025-02-25   954  	return PTR_ERR_OR_ZERO(priv->hwdev);
d29a9de20be84d Kurt Borja 2025-02-25   955  }
d29a9de20be84d Kurt Borja 2025-02-25   956  
404d3e186207d4 Kurt Borja 2025-02-25   957  /*
404d3e186207d4 Kurt Borja 2025-02-25   958   * Thermal Profile control
404d3e186207d4 Kurt Borja 2025-02-25   959   *  - Provides thermal profile control through the Platform Profile API
404d3e186207d4 Kurt Borja 2025-02-25   960   */
94b96f340b5e25 Kurt Borja 2025-02-25   961  static int awcc_platform_profile_get(struct device *dev,
8cc2c415d092e1 Kurt Borja 2025-02-07   962  				     enum platform_profile_option *profile)
8cc2c415d092e1 Kurt Borja 2025-02-07   963  {
8cc2c415d092e1 Kurt Borja 2025-02-07   964  	struct awcc_priv *priv = dev_get_drvdata(dev);
8cc2c415d092e1 Kurt Borja 2025-02-07   965  	u32 out_data;
8cc2c415d092e1 Kurt Borja 2025-02-07   966  	int ret;
8cc2c415d092e1 Kurt Borja 2025-02-07   967  
94b96f340b5e25 Kurt Borja 2025-02-25   968  	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFILE,
8cc2c415d092e1 Kurt Borja 2025-02-07   969  				       0, &out_data);
8cc2c415d092e1 Kurt Borja 2025-02-07   970  
8cc2c415d092e1 Kurt Borja 2025-02-07   971  	if (ret < 0)
8cc2c415d092e1 Kurt Borja 2025-02-07   972  		return ret;
8cc2c415d092e1 Kurt Borja 2025-02-07   973  
1dc40c13e81906 Kurt Borja 2025-02-25   974  	switch (out_data) {
1dc40c13e81906 Kurt Borja 2025-02-25   975  	case AWCC_SPECIAL_PROFILE_CUSTOM:
1dc40c13e81906 Kurt Borja 2025-02-25   976  		*profile = PLATFORM_PROFILE_CUSTOM;
1dc40c13e81906 Kurt Borja 2025-02-25   977  		return 0;
1dc40c13e81906 Kurt Borja 2025-02-25   978  	case AWCC_SPECIAL_PROFILE_GMODE:
8cc2c415d092e1 Kurt Borja 2025-02-07   979  		*profile = PLATFORM_PROFILE_PERFORMANCE;
8cc2c415d092e1 Kurt Borja 2025-02-07   980  		return 0;
1dc40c13e81906 Kurt Borja 2025-02-25   981  	default:
1dc40c13e81906 Kurt Borja 2025-02-25   982  		break;
8cc2c415d092e1 Kurt Borja 2025-02-07   983  	}
8cc2c415d092e1 Kurt Borja 2025-02-07   984  
0cc2eb52fa337a Kurt Borja 2025-02-25   985  	if (!is_awcc_thermal_profile_id(out_data))
8cc2c415d092e1 Kurt Borja 2025-02-07   986  		return -ENODATA;
8cc2c415d092e1 Kurt Borja 2025-02-07   987  
94b96f340b5e25 Kurt Borja 2025-02-25   988  	out_data &= AWCC_THERMAL_MODE_MASK;
94b96f340b5e25 Kurt Borja 2025-02-25   989  	*profile = awcc_mode_to_platform_profile[out_data];
8cc2c415d092e1 Kurt Borja 2025-02-07   990  
8cc2c415d092e1 Kurt Borja 2025-02-07   991  	return 0;
8cc2c415d092e1 Kurt Borja 2025-02-07   992  }
8cc2c415d092e1 Kurt Borja 2025-02-07   993  
94b96f340b5e25 Kurt Borja 2025-02-25   994  static int awcc_platform_profile_set(struct device *dev,
8cc2c415d092e1 Kurt Borja 2025-02-07   995  				     enum platform_profile_option profile)
8cc2c415d092e1 Kurt Borja 2025-02-07   996  {
8cc2c415d092e1 Kurt Borja 2025-02-07   997  	struct awcc_priv *priv = dev_get_drvdata(dev);
8cc2c415d092e1 Kurt Borja 2025-02-07   998  
8cc2c415d092e1 Kurt Borja 2025-02-07   999  	if (awcc->gmode) {
8cc2c415d092e1 Kurt Borja 2025-02-07  1000  		u32 gmode_status;
8cc2c415d092e1 Kurt Borja 2025-02-07  1001  		int ret;
8cc2c415d092e1 Kurt Borja 2025-02-07  1002  
94b96f340b5e25 Kurt Borja 2025-02-25  1003  		ret = awcc_game_shift_status(priv->wdev,
94b96f340b5e25 Kurt Borja 2025-02-25  1004  					     AWCC_OP_GET_GAME_SHIFT_STATUS,
8cc2c415d092e1 Kurt Borja 2025-02-07  1005  					     &gmode_status);
8cc2c415d092e1 Kurt Borja 2025-02-07  1006  
8cc2c415d092e1 Kurt Borja 2025-02-07  1007  		if (ret < 0)
8cc2c415d092e1 Kurt Borja 2025-02-07  1008  			return ret;
8cc2c415d092e1 Kurt Borja 2025-02-07  1009  
8cc2c415d092e1 Kurt Borja 2025-02-07  1010  		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
8cc2c415d092e1 Kurt Borja 2025-02-07  1011  		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
94b96f340b5e25 Kurt Borja 2025-02-25  1012  			ret = awcc_game_shift_status(priv->wdev,
94b96f340b5e25 Kurt Borja 2025-02-25  1013  						     AWCC_OP_TOGGLE_GAME_SHIFT,
8cc2c415d092e1 Kurt Borja 2025-02-07  1014  						     &gmode_status);
8cc2c415d092e1 Kurt Borja 2025-02-07  1015  
8cc2c415d092e1 Kurt Borja 2025-02-07  1016  			if (ret < 0)
8cc2c415d092e1 Kurt Borja 2025-02-07  1017  				return ret;
8cc2c415d092e1 Kurt Borja 2025-02-07  1018  		}
8cc2c415d092e1 Kurt Borja 2025-02-07  1019  	}
8cc2c415d092e1 Kurt Borja 2025-02-07  1020  
94b96f340b5e25 Kurt Borja 2025-02-25  1021  	return awcc_thermal_control(priv->wdev,
6b90057f955757 Kurt Borja 2025-02-25  1022  				    priv->supported_profiles[profile]);
8cc2c415d092e1 Kurt Borja 2025-02-07  1023  }
8cc2c415d092e1 Kurt Borja 2025-02-07  1024  
94b96f340b5e25 Kurt Borja 2025-02-25  1025  static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
8cc2c415d092e1 Kurt Borja 2025-02-07  1026  {
8cc2c415d092e1 Kurt Borja 2025-02-07  1027  	enum platform_profile_option profile;
8cc2c415d092e1 Kurt Borja 2025-02-07  1028  	struct awcc_priv *priv = drvdata;
94b96f340b5e25 Kurt Borja 2025-02-25  1029  	enum awcc_thermal_profile mode;
443362838f8842 Kurt Borja 2025-02-25  1030  	u8 id, offset = 0;
8cc2c415d092e1 Kurt Borja 2025-02-07  1031  	u32 out_data;
8cc2c415d092e1 Kurt Borja 2025-02-07  1032  	int ret;
8cc2c415d092e1 Kurt Borja 2025-02-07  1033  
443362838f8842 Kurt Borja 2025-02-25  1034  	/*
443362838f8842 Kurt Borja 2025-02-25  1035  	 * Thermal profile IDs are listed last at offset
443362838f8842 Kurt Borja 2025-02-25  1036  	 *	fan_count + temp_count + unknown_count
443362838f8842 Kurt Borja 2025-02-25  1037  	 */
443362838f8842 Kurt Borja 2025-02-25  1038  	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
443362838f8842 Kurt Borja 2025-02-25  1039  		offset += priv->res_count[i];
8cc2c415d092e1 Kurt Borja 2025-02-07  1040  
443362838f8842 Kurt Borja 2025-02-25  1041  	for (unsigned int i = 0; i < priv->profile_count; i++) {
443362838f8842 Kurt Borja 2025-02-25  1042  		ret = awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
8cc2c415d092e1 Kurt Borja 2025-02-07  1043  		if (ret == -EIO)
8cc2c415d092e1 Kurt Borja 2025-02-07  1044  			return ret;
8cc2c415d092e1 Kurt Borja 2025-02-07  1045  
443362838f8842 Kurt Borja 2025-02-25  1046  		/*
443362838f8842 Kurt Borja 2025-02-25  1047  		 * Some devices report an incorrect number of thermal profiles
443362838f8842 Kurt Borja 2025-02-25  1048  		 * so the resource ID list may end prematurely
443362838f8842 Kurt Borja 2025-02-25  1049  		 */
8cc2c415d092e1 Kurt Borja 2025-02-07  1050  		if (ret == -EBADRQC)
8cc2c415d092e1 Kurt Borja 2025-02-07  1051  			break;
8cc2c415d092e1 Kurt Borja 2025-02-07  1052  
0cc2eb52fa337a Kurt Borja 2025-02-25  1053  		/* Some IDs have a BIT(8) flag that should be ignored */
0cc2eb52fa337a Kurt Borja 2025-02-25  1054  		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
443362838f8842 Kurt Borja 2025-02-25  1055  		if (!is_awcc_thermal_profile_id(id)) {
443362838f8842 Kurt Borja 2025-02-25  1056  			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id);
8cc2c415d092e1 Kurt Borja 2025-02-07  1057  			continue;
443362838f8842 Kurt Borja 2025-02-25  1058  		}
8cc2c415d092e1 Kurt Borja 2025-02-07  1059  
0cc2eb52fa337a Kurt Borja 2025-02-25  1060  		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
94b96f340b5e25 Kurt Borja 2025-02-25  1061  		profile = awcc_mode_to_platform_profile[mode];
6b90057f955757 Kurt Borja 2025-02-25  1062  		priv->supported_profiles[profile] = id;
8cc2c415d092e1 Kurt Borja 2025-02-07  1063  
443362838f8842 Kurt Borja 2025-02-25  1064  		__set_bit(profile, choices);
8cc2c415d092e1 Kurt Borja 2025-02-07  1065  	}
8cc2c415d092e1 Kurt Borja 2025-02-07  1066  
8cc2c415d092e1 Kurt Borja 2025-02-07  1067  	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
8cc2c415d092e1 Kurt Borja 2025-02-07  1068  		return -ENODEV;
8cc2c415d092e1 Kurt Borja 2025-02-07  1069  
8cc2c415d092e1 Kurt Borja 2025-02-07  1070  	if (awcc->gmode) {
6b90057f955757 Kurt Borja 2025-02-25  1071  		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
1dc40c13e81906 Kurt Borja 2025-02-25  1072  			AWCC_SPECIAL_PROFILE_GMODE;
8cc2c415d092e1 Kurt Borja 2025-02-07  1073  
443362838f8842 Kurt Borja 2025-02-25  1074  		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
8cc2c415d092e1 Kurt Borja 2025-02-07  1075  	}
8cc2c415d092e1 Kurt Borja 2025-02-07  1076  
1dc40c13e81906 Kurt Borja 2025-02-25  1077  	/* Every model supports the "custom" profile */
1dc40c13e81906 Kurt Borja 2025-02-25  1078  	priv->supported_profiles[PLATFORM_PROFILE_CUSTOM] =
1dc40c13e81906 Kurt Borja 2025-02-25  1079  		AWCC_SPECIAL_PROFILE_CUSTOM;
1dc40c13e81906 Kurt Borja 2025-02-25  1080  
1dc40c13e81906 Kurt Borja 2025-02-25  1081  	__set_bit(PLATFORM_PROFILE_CUSTOM, choices);
1dc40c13e81906 Kurt Borja 2025-02-25  1082  
8cc2c415d092e1 Kurt Borja 2025-02-07  1083  	return 0;
8cc2c415d092e1 Kurt Borja 2025-02-07  1084  }
8cc2c415d092e1 Kurt Borja 2025-02-07  1085  
8cc2c415d092e1 Kurt Borja 2025-02-07  1086  static const struct platform_profile_ops awcc_platform_profile_ops = {
94b96f340b5e25 Kurt Borja 2025-02-25  1087  	.probe = awcc_platform_profile_probe,
94b96f340b5e25 Kurt Borja 2025-02-25  1088  	.profile_get = awcc_platform_profile_get,
94b96f340b5e25 Kurt Borja 2025-02-25  1089  	.profile_set = awcc_platform_profile_set,
8cc2c415d092e1 Kurt Borja 2025-02-07  1090  };
8cc2c415d092e1 Kurt Borja 2025-02-07  1091  
8cc2c415d092e1 Kurt Borja 2025-02-07  1092  static int awcc_platform_profile_init(struct wmi_device *wdev)
8cc2c415d092e1 Kurt Borja 2025-02-07  1093  {
8cc2c415d092e1 Kurt Borja 2025-02-07  1094  	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
8cc2c415d092e1 Kurt Borja 2025-02-07  1095  
8cc2c415d092e1 Kurt Borja 2025-02-07 @1096  	priv->ppdev = devm_platform_profile_register(&wdev->dev, "alienware-wmi",
8cc2c415d092e1 Kurt Borja 2025-02-07  1097  						     priv, &awcc_platform_profile_ops);
8cc2c415d092e1 Kurt Borja 2025-02-07  1098  
8cc2c415d092e1 Kurt Borja 2025-02-07  1099  	return PTR_ERR_OR_ZERO(priv->ppdev);
8cc2c415d092e1 Kurt Borja 2025-02-07  1100  }
8cc2c415d092e1 Kurt Borja 2025-02-07  1101  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

