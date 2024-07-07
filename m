Return-Path: <linux-kernel+bounces-243742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840319299F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFC02812B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD26A8BE;
	Sun,  7 Jul 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Viub/8Kd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8701400A;
	Sun,  7 Jul 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720390970; cv=none; b=A1eRSxmk7Miuc/g4SpZjE+c39lW022gJV3+olIq+0PicTaa3Zr+qZ/QLI5sNzOE7zthMjbutk14qyNUKK7JDDfkpsXn6VmjBttaI6haFLgEJAnZ7Wy2nUWfbg1HqJDoNjaZKQHa5rW90RBdEyVOejsugOMcLNY0T0CjNRMwII80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720390970; c=relaxed/simple;
	bh=98u504Gu/hQJ3jYkKc4S3uNEBdxO1PKUAZ7U+QLe6Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk5o0ekDO3ouyGiSljjMXSEqYkUWvxQIgfN88sakMCEyaERFicAYw1xO1pwAfzfb1clGkS8BlciXK/6FSgMkTsM62AhmjgvxWYlKYV24mjN+n/4zZrdsp+dFOPKaAbm6SDcra2VNI0UIldfXEfn/Yy+/cPVJxOMD2oUktX2e8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Viub/8Kd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720390968; x=1751926968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98u504Gu/hQJ3jYkKc4S3uNEBdxO1PKUAZ7U+QLe6Fo=;
  b=Viub/8Kd+wjOWR1xkHBGznkVTQj4WDxzfVhHAaMorILYeve8UMgjKa1n
   j2hmvF7oqZEXJvgzzOfWc1NC/wSodrgS2v7BOf8ADIreoNKpQL6sNlwpW
   db8DVruuoouzGVUhGtvtTiTzD39T2tLprLDQ2u3B+3ndr9K23fnt0FOM0
   qt7u7UiGZQARQI2p8AQN3Bed9DfabmWDaYoVA7t+LwpCFFkE+MxuLfL3A
   hIZZ/tHt+19usK9uxZ3pMXy6cSxtRzFL4str6VPYSI+GD6Kv+eXkLuARH
   ap5Dye5hQtcsFX+//GxhrFriJ8elhL1ToUvpIogk8BJz6sEGlOBXeWYOc
   w==;
X-CSE-ConnectionGUID: T7hAbVkdStyiTWcTPeUMKA==
X-CSE-MsgGUID: CauprcroS5KnFvJdrai9Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17399104"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="17399104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 15:22:47 -0700
X-CSE-ConnectionGUID: vKzqC/cNRHyXyqrEBx0YmQ==
X-CSE-MsgGUID: 6eV1rcM4R3y5Yz2/WGI6YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47096845"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jul 2024 15:22:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQaHL-000VJe-2V;
	Sun, 07 Jul 2024 22:22:43 +0000
Date: Mon, 8 Jul 2024 06:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>,
	hdegoede@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	carlosmiguelferreira.2003@gmail.com
Subject: Re: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
Message-ID: <202407080657.XLHI1WRv-lkp@intel.com>
References: <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>

Hi Carlos,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Ferreira/HP-wmi-added-support-for-4-zone-keyboard-rgb/20240708-015808
base:   linus/master
patch link:    https://lore.kernel.org/r/20240707175613.27529-2-carlosmiguelferreira.2003%40gmail.com
patch subject: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
config: i386-randconfig-001-20240708 (https://download.01.org/0day-ci/archive/20240708/202407080657.XLHI1WRv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240708/202407080657.XLHI1WRv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407080657.XLHI1WRv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/hp/hp-wmi.c:1590:28: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1590 |         buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
         |                                   ^
>> drivers/platform/x86/hp/hp-wmi.c:1609:15: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1609 |                 colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
         |                             ^
   2 errors generated.


vim +/FIELD_GET +1590 drivers/platform/x86/hp/hp-wmi.c

  1579	
  1580	static int fourzone_set_colors(u32 color, size_t zone)
  1581	{
  1582		u8 buff[128];
  1583		int ret;
  1584	
  1585		ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
  1586			&buff, sizeof(buff), sizeof(buff));
  1587		if (ret != 0)
  1588			return -EINVAL;
  1589	
> 1590		buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
  1591		buff[25 + zone * 3 + 1] = FIELD_GET(FOURZONE_COLOR_G, color);
  1592		buff[25 + zone * 3 + 2] = FIELD_GET(FOURZONE_COLOR_B, color);
  1593	
  1594		return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
  1595			&buff, sizeof(buff), sizeof(buff));
  1596	}
  1597	
  1598	static int fourzone_get_colors(u32 *colors)
  1599	{
  1600		u8 buff[128];
  1601		int ret;
  1602	
  1603		ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
  1604			&buff, sizeof(buff), sizeof(buff));
  1605		if (ret != 0)
  1606			return -EINVAL;
  1607	
  1608		for (int i = 0; i < 4; i++) {
> 1609			colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
  1610				  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
  1611				  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);
  1612		}
  1613	
  1614		return 0;
  1615	}
  1616	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

