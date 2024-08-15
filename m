Return-Path: <linux-kernel+bounces-288475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16394953A89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC47B236E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F378C9C;
	Thu, 15 Aug 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feXEh72/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613B2CA5;
	Thu, 15 Aug 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748791; cv=none; b=pggKiFue6JpXvldGln3AJwtJv0zi6L4Tbrj8SVpq99EE/IjIv5+OfhhoONtWvyUZZs0e9L6VfaCuZr1M+XLpGK/ZTCAOrpVitf52Z5DEMncOptofmGbs4fAlzIvgOF8rECN6ebNKJuayoEwSv7Qkey4JZpzkhQS2/49lHfEInL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748791; c=relaxed/simple;
	bh=9J6GsM+bd14SqXRQggU0SepylaEYm30khxqYde2Bceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3a6xkzRxAnYAv+l5E+GPlZX8pdRgbVLqiewEmeDsbfZjqTTjeYp38dMmvYdUbXCBJhc2Fix41MuM32kqr5DtUUWjExC+NU5g5CqXdlzeVd2pe2JndwYFtVis75zCuTxWN5co6SfGg7laH6GFBEK7SAqMvW23AiqD7sVwGH48vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feXEh72/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723748789; x=1755284789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9J6GsM+bd14SqXRQggU0SepylaEYm30khxqYde2Bceg=;
  b=feXEh72/cNOEKBO6CiGDFdwBv3EFz4w/PguIU7R/oLdykkkfDIqnWYGG
   u7m16FizkndAZ4MQU7NOwLhDQ0xBR+qXTVXIf3q1hMuoRsy+KNpNVpB77
   wXsD4U+lAf9TTLgDTA01TUo5iKR93vKGpYBwnfUHHTeGdjFvxYgKrVEuB
   U2S54JNJXgNgeneVJeTXee3CKjpStjo4EL5NBnBRu7QkCKgoSbCDG4p/6
   FTgFxWqW8zEPss30nK13RkcxszMaFlpyCMTi9nRTitwoUNs0FwXyVyI/A
   0NlmJbRLQwdA/x6Y58pMSDnH/mWifBVX56lfVNQpUkBTqXQmlTw5SzkgW
   A==;
X-CSE-ConnectionGUID: 3ENeRenZTtO7ynZkjvELpQ==
X-CSE-MsgGUID: TgaolZoeTm6ekmPxFGPvpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39542142"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="39542142"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 12:00:22 -0700
X-CSE-ConnectionGUID: MIJxZBuHSWyh9SWPkkq8Pg==
X-CSE-MsgGUID: sLSgU85mQiyac1A5VKWpqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="60009556"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 12:00:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sefhp-0005VM-14;
	Thu, 15 Aug 2024 19:00:17 +0000
Date: Fri, 16 Aug 2024 03:00:01 +0800
From: kernel test robot <lkp@intel.com>
To: Matthias Fetzer <kontakt@matthias-fetzer.de>, hmh@hmh.eng.br,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Matthias Fetzer <kontakt@matthias-fetzer.de>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
Message-ID: <202408160253.fMJW95oi-lkp@intel.com>
References: <20240814213927.49075-1-kontakt@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814213927.49075-1-kontakt@matthias-fetzer.de>

Hi Matthias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Fetzer/platform-x86-thinkpad_acpi-Add-Thinkpad-Edge-E531-fan-support/20240815-054239
base:   linus/master
patch link:    https://lore.kernel.org/r/20240814213927.49075-1-kontakt%40matthias-fetzer.de
patch subject: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support
config: i386-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160253.fMJW95oi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/thinkpad_acpi.c: In function 'fan_set_level':
>> drivers/platform/x86/thinkpad_acpi.c:8214:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
    8214 |         int rc;
         |             ^~


vim +/rc +8214 drivers/platform/x86/thinkpad_acpi.c

  8211	
  8212	static int fan_set_level(int level)
  8213	{
> 8214		int rc;
  8215	
  8216		if (!fan_control_allowed)
  8217			return -EPERM;
  8218	
  8219		switch (fan_control_access_mode) {
  8220		case TPACPI_FAN_WR_ACPI_SFAN:
  8221			if ((level < 0) || (level > 7))
  8222				return -EINVAL;
  8223	
  8224			if (tp_features.second_fan_ctl) {
  8225				if (!fan_select_fan2() ||
  8226				    !acpi_evalf(sfan_handle, NULL, NULL, "vd", level)) {
  8227					pr_warn("Couldn't set 2nd fan level, disabling support\n");
  8228					tp_features.second_fan_ctl = 0;
  8229				}
  8230				fan_select_fan1();
  8231			}
  8232			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
  8233				return -EIO;
  8234			break;
  8235	
  8236		case TPACPI_FAN_WR_ACPI_FANS:
  8237		case TPACPI_FAN_WR_TPEC:
  8238			if (!(level & TP_EC_FAN_AUTO) &&
  8239			    !(level & TP_EC_FAN_FULLSPEED) &&
  8240			    ((level < 0) || (level > 7)))
  8241				return -EINVAL;
  8242	
  8243			/* safety net should the EC not support AUTO
  8244			 * or FULLSPEED mode bits and just ignore them */
  8245			if (level & TP_EC_FAN_FULLSPEED)
  8246				level |= 7;	/* safety min speed 7 */
  8247			else if (level & TP_EC_FAN_AUTO)
  8248				level |= 4;	/* safety min speed 4 */
  8249	
  8250			if (tp_features.second_fan_ctl) {
  8251				if (!fan_select_fan2() ||
  8252				    !acpi_ec_write(fan_status_offset, level)) {
  8253					pr_warn("Couldn't set 2nd fan level, disabling support\n");
  8254					tp_features.second_fan_ctl = 0;
  8255				}
  8256				fan_select_fan1();
  8257	
  8258			}
  8259			if (!acpi_ec_write(fan_status_offset, level))
  8260				return -EIO;
  8261			else
  8262				tp_features.fan_ctrl_status_undef = 0;
  8263			break;
  8264	
  8265		case TPACPI_FAN_WR_ACPI_FANW:
  8266			if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
  8267				return -EINVAL;
  8268			if (level & TP_EC_FAN_FULLSPEED)
  8269				return -EINVAL;
  8270	
  8271			if (level & TP_EC_FAN_AUTO) {
  8272				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
  8273					rc = -EIO;
  8274					break;
  8275				}
  8276				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
  8277					rc = -EIO;
  8278					break;
  8279				}
  8280			} else {
  8281				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
  8282					rc = -EIO;
  8283					break;
  8284				}
  8285				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
  8286					rc = -EIO;
  8287					break;
  8288				}
  8289				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level * 100 / 7)) {
  8290					rc = -EIO;
  8291					break;
  8292				}
  8293			}
  8294			break;
  8295	
  8296		default:
  8297			return -ENXIO;
  8298		}
  8299	
  8300		vdbg_printk(TPACPI_DBG_FAN,
  8301			"fan control: set fan control register to 0x%02x\n", level);
  8302		return 0;
  8303	}
  8304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

