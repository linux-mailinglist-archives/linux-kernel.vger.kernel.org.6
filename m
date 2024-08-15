Return-Path: <linux-kernel+bounces-288523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16759953B40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F481C24B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B941448C3;
	Thu, 15 Aug 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh/tyzHb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E910FF;
	Thu, 15 Aug 2024 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752147; cv=none; b=ZoReOqFzXy3Ps0nQ2gLOJnfXOY/3LdXdmAWe0nb80DHWjNEOn4c7gqsSoboP+Lwt135WCsiaFradoQTdm/OMtW/IqrJOOcu2nkcz5kwhJMvKmZ8Da4OT+PAYFbzwB6VrlaIPVXQUBDNxFj3vvljHHbVGTBZSSwwtIQQe6k24gqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752147; c=relaxed/simple;
	bh=Una/csjFvk8Y03/HoOMMntul75tfxF/Fl5iMXVtNLo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEXZ54gA0W/F8ispayzyjg7SOjGnJ5caVnTIFOkNLzsO7nn6wznWnWCnYpMeNuXjqLU8A98slOgDIbACVaszOAt0Su6wpR/42iGWHVrFGfKPkMYDmzqLHTXx5mPSgr1386/YJrtEhfMelfo+ugZWIVTyMNqlLapLQkitIEaLVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eh/tyzHb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723752145; x=1755288145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Una/csjFvk8Y03/HoOMMntul75tfxF/Fl5iMXVtNLo4=;
  b=Eh/tyzHbRy/rMbC9zHkGBeZM2Qkw6bpXAGT5zqbMYeRDDn1svToFZMm7
   M4bfGHWRuBMmdnmjDF2Jh+Y15+7YFhampvwChTqFXnXrrsNw+szDWSJmp
   45s3sW6iOqIhRP/jg3kTKj7Osr7mT34w5SrCdYUgK4x/f824LKen16G30
   n/liakxF4ouqZ313YsxQGdbySYimVaV67v6PrX7D0m9C7n7xLzcaM7ON9
   kg75Ms09OqkhzWWpnZ0z9xzfcJJBQXIkZYbeYzXbRcD0S5eSMDPdQ9S7V
   GsgFSSRjpCYGuiMHA6FsBBDPmlBI0i26ZvRlkA8n9SbGkdG0YH7DZgt+6
   Q==;
X-CSE-ConnectionGUID: +myjxpEkQ7e1YNjfyDl9Yg==
X-CSE-MsgGUID: wfXFJmyVRK6k1Q7aU4mHog==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32605452"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="32605452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 13:02:24 -0700
X-CSE-ConnectionGUID: BQ4Ed6q6Qw2zdK7U38N6BA==
X-CSE-MsgGUID: bpAKtS9nR9ODn/gWIi+NuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59133924"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Aug 2024 13:02:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1segfr-0005YM-0X;
	Thu, 15 Aug 2024 20:02:19 +0000
Date: Fri, 16 Aug 2024 04:01:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: (oxp-sensors) Add support for multiple new
 devices.
Message-ID: <202408160329.TLNbIwRC-lkp@intel.com>
References: <20240815031358.21027-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815031358.21027-2-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/hwmon-oxp-sensors-Add-support-for-multiple-new-devices/20240815-111550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240815031358.21027-2-derekjohn.clark%40gmail.com
patch subject: [PATCH 1/1] hwmon: (oxp-sensors) Add support for multiple new devices.
config: i386-buildonly-randconfig-005-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160329.TLNbIwRC-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160329.TLNbIwRC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160329.TLNbIwRC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/oxp-sensors.c:497:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     497 |                 default:
         |                 ^
   drivers/hwmon/oxp-sensors.c:497:3: note: insert 'break;' to avoid fall-through
     497 |                 default:
         |                 ^
         |                 break; 
   drivers/hwmon/oxp-sensors.c:564:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     564 |                 default:
         |                 ^
   drivers/hwmon/oxp-sensors.c:564:3: note: insert 'break;' to avoid fall-through
     564 |                 default:
         |                 ^
         |                 break; 
   drivers/hwmon/oxp-sensors.c:616:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     616 |                 default:
         |                 ^
   drivers/hwmon/oxp-sensors.c:616:3: note: insert 'break;' to avoid fall-through
     616 |                 default:
         |                 ^
         |                 break; 
   3 warnings generated.


vim +497 drivers/hwmon/oxp-sensors.c

   464	
   465	static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
   466				     u32 attr, int channel, long *val)
   467	{
   468		int ret;
   469	
   470		switch (type) {
   471		case hwmon_fan:
   472			switch (attr) {
   473			case hwmon_fan_input:
   474				switch (board) {
   475				case orange_pi_neo:
   476					return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
   477				case aok_zoe_a1:
   478				case aya_neo_2:
   479				case aya_neo_2s:
   480				case aya_neo_air:
   481				case aya_neo_air_1s:
   482				case aya_neo_air_plus_mendo:
   483				case aya_neo_air_pro:
   484				case aya_neo_flip:
   485				case aya_neo_geek:
   486				case aya_neo_geek_1s:
   487				case aya_neo_kun:
   488				case oxp_mini_amd:
   489				case oxp_mini_amd_a07:
   490				case oxp_2:
   491				case oxp_fly:
   492				case oxp_mini_amd_pro:
   493					return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
   494				default:
   495					break;
   496				}
 > 497			default:
   498				break;
   499			}
   500			break;
   501		case hwmon_pwm:
   502			switch (attr) {
   503			case hwmon_pwm_input:
   504				switch (board) {
   505				case orange_pi_neo:
   506					ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
   507					if (ret)
   508						return ret;
   509					/* scale from range [1-244] */
   510					*val = ((*val - 1) * 254 / 243) + 1;
   511					break;
   512				case aya_neo_2:
   513				case aya_neo_2s:
   514				case aya_neo_air:
   515				case aya_neo_air_1s:
   516				case aya_neo_air_plus_mendo:
   517				case aya_neo_air_pro:
   518				case aya_neo_flip:
   519				case aya_neo_geek:
   520				case aya_neo_geek_1s:
   521				case aya_neo_kun:
   522				case oxp_mini_amd:
   523				case oxp_mini_amd_a07:
   524					ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
   525					if (ret)
   526						return ret;
   527					*val = (*val * 255) / 100;
   528					break;
   529				case aok_zoe_a1:
   530				case oxp_2:
   531				case oxp_fly:
   532				case oxp_mini_amd_pro:
   533				default:
   534					ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
   535					if (ret)
   536						return ret;
   537					break;
   538				}
   539				return 0;
   540			case hwmon_pwm_enable:
   541				switch (board) {
   542				case orange_pi_neo:
   543					return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
   544				case aok_zoe_a1:
   545				case aya_neo_2:
   546				case aya_neo_2s:
   547				case aya_neo_air:
   548				case aya_neo_air_1s:
   549				case aya_neo_air_plus_mendo:
   550				case aya_neo_air_pro:
   551				case aya_neo_flip:
   552				case aya_neo_geek:
   553				case aya_neo_geek_1s:
   554				case aya_neo_kun:
   555				case oxp_mini_amd:
   556				case oxp_mini_amd_a07:
   557				case oxp_2:
   558				case oxp_fly:
   559				case oxp_mini_amd_pro:
   560					return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
   561				default:
   562					break;
   563				}
   564			default:
   565				break;
   566			}
   567			break;
   568		default:
   569			break;
   570		}
   571		return -EOPNOTSUPP;
   572	}
   573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

