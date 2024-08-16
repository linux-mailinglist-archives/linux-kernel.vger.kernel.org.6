Return-Path: <linux-kernel+bounces-289739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A0954B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42321C222BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD91BBBF4;
	Fri, 16 Aug 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqjCkjjo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26E817;
	Fri, 16 Aug 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815550; cv=none; b=ndipp+FUE7GKtHKU4JmHg9uoILyw/vzeJcJIt7YE9GgPI/eHzYjrOS/qNNtplKMXxQpxyi86C4qXVkahG9LIqCL+DYPkZ4fP477SpUkrArRGDJpZCEMewdUOgMiy5Jt0BiSaoOKDoaj0MzYAGvPbi36AQphJQ0FOF7KshCMLvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815550; c=relaxed/simple;
	bh=ZS4qHhJRPwMvQ+YJZ6cMAM1yFVN+1KL+5yD9XcWw/bo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l/iukfcxIZ0eK+gh9TJHzO5QvCO94PpLLzqqhIJOGWMEGCR869PIWmeJ6Q7tuKtJ+spUEWt34uH7OSqmeYIJnjcFwFTbCY89GN87VjDba985oOTxx1b2UZfP7+qZ7cPoDcA+wQ3liFiH6z3tOBqtIHuBpl5A3wx5lgHGUqlEMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqjCkjjo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723815549; x=1755351549;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZS4qHhJRPwMvQ+YJZ6cMAM1yFVN+1KL+5yD9XcWw/bo=;
  b=DqjCkjjovxpPF/46jpXKDp+h5gBJtzylkg1cfzhK491PkhGNI2sVwKN6
   4Pz/UyVxRa55QjMCcC22dfwOZ8xEZZw2hWNNW0u7oCWCXAky8PdwWkKfY
   w2Uil1602vXukg5XFg8q3UY6K8DWPdxygvX15AgY39aPKMy2x/mtuzEnE
   RU0xnqeoHbBX0j4Y+CHuPUhOTEtj5KIOV4XhCCeVCMEJLi1jkdEgmBN+p
   aoe53VlntjLEdhlUMplY5sVTD3BWKefHHcDRg3EivGVJ8ogVOHoXQNoaq
   rfoPmURLGVGuhPweJqe4vOaHRXbLqj44OO76D4NtXIQyyldMnt8QHMSPX
   w==;
X-CSE-ConnectionGUID: NA6A6nvbTHq+a0lz2txQYg==
X-CSE-MsgGUID: q/RS1sS4Ti6WuI9ed3A3Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25868752"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="25868752"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:39:08 -0700
X-CSE-ConnectionGUID: rqVYJoWJTkWH1xOlxVQ1HQ==
X-CSE-MsgGUID: dZ2aTJ1tTL29xNVjqXAPCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59698605"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:39:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Aug 2024 16:38:53 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: kernel test robot <lkp@intel.com>, hmh@hmh.eng.br, 
    Hans de Goede <hdegoede@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
In-Reply-To: <d2d7b7ec-c7db-4cde-b669-df727b93748f@matthias-fetzer.de>
Message-ID: <e1fe661c-281d-9d59-be53-968f7a0bc18a@linux.intel.com>
References: <20240814213927.49075-1-kontakt@matthias-fetzer.de> <202408160253.fMJW95oi-lkp@intel.com> <d2d7b7ec-c7db-4cde-b669-df727b93748f@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Aug 2024, Matthias Fetzer wrote:

> 
> 
> Am 15.08.24 um 21:00 schrieb kernel test robot:
> > Hi Matthias,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.11-rc3 next-20240815]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Matthias-Fetzer/platform-x86-thinkpad_acpi-Add-Thinkpad-Edge-E531-fan-support/20240815-054239
> > base:   linus/master
> > patch link:
> > https://lore.kernel.org/r/20240814213927.49075-1-kontakt%40matthias-fetzer.de
> > patch subject: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge
> > E531 fan support
> > config: i386-randconfig-001-20240815
> > (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version
> > of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > https://lore.kernel.org/oe-kbuild-all/202408160253.fMJW95oi-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >     drivers/platform/x86/thinkpad_acpi.c: In function 'fan_set_level':
> > > > drivers/platform/x86/thinkpad_acpi.c:8214:13: warning: variable 'rc' set
> > > > but not used [-Wunused-but-set-variable]
> >      8214 |         int rc;
> >           |             ^~
> > 
> 
> I guess just removing the variable and returning -EIO directly should be
> a good approach.
> 
> What do you think?

Yes, it seems that's what the existing code does. That avoids printing
the debug message errornously (as the operation ended up failing, not 
succeeding).

-- 
 i.


> > vim +/rc +8214 drivers/platform/x86/thinkpad_acpi.c
> > 
> >    8211	
> >    8212	static int fan_set_level(int level)
> >    8213	{
> > > 8214		int rc;
> >    8215	
> >    8216		if (!fan_control_allowed)
> >    8217			return -EPERM;
> >    8218	
> >    8219		switch (fan_control_access_mode) {
> >    8220		case TPACPI_FAN_WR_ACPI_SFAN:
> >    8221			if ((level < 0) || (level > 7))
> >    8222				return -EINVAL;
> >    8223	
> >    8224			if (tp_features.second_fan_ctl) {
> >    8225				if (!fan_select_fan2() ||
> >    8226				    !acpi_evalf(sfan_handle, NULL,
> > NULL, "vd", level)) {
> >    8227					pr_warn("Couldn't set 2nd fan
> > level, disabling support\n");
> >    8228					tp_features.second_fan_ctl =
> > 0;
> >    8229				}
> >    8230				fan_select_fan1();
> >    8231			}
> >    8232			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd",
> > level))
> >    8233				return -EIO;
> >    8234			break;
> >    8235	
> >    8236		case TPACPI_FAN_WR_ACPI_FANS:
> >    8237		case TPACPI_FAN_WR_TPEC:
> >    8238			if (!(level & TP_EC_FAN_AUTO) &&
> >    8239			    !(level & TP_EC_FAN_FULLSPEED) &&
> >    8240			    ((level < 0) || (level > 7)))
> >    8241				return -EINVAL;
> >    8242	
> >    8243			/* safety net should the EC not support AUTO
> >    8244			 * or FULLSPEED mode bits and just ignore them
> > */
> >    8245			if (level & TP_EC_FAN_FULLSPEED)
> >    8246				level |= 7;	/* safety min speed 7
> > */
> >    8247			else if (level & TP_EC_FAN_AUTO)
> >    8248				level |= 4;	/* safety min speed 4
> > */
> >    8249	
> >    8250			if (tp_features.second_fan_ctl) {
> >    8251				if (!fan_select_fan2() ||
> >    8252				    !acpi_ec_write(fan_status_offset,
> > level)) {
> >    8253					pr_warn("Couldn't set 2nd fan
> > level, disabling support\n");
> >    8254					tp_features.second_fan_ctl =
> > 0;
> >    8255				}
> >    8256				fan_select_fan1();
> >    8257	
> >    8258			}
> >    8259			if (!acpi_ec_write(fan_status_offset, level))
> >    8260				return -EIO;
> >    8261			else
> >    8262				tp_features.fan_ctrl_status_undef = 0;
> >    8263			break;
> >    8264	
> >    8265		case TPACPI_FAN_WR_ACPI_FANW:
> >    8266			if (!(level & TP_EC_FAN_AUTO) && (level < 0 ||
> > level > 7))
> >    8267				return -EINVAL;
> >    8268			if (level & TP_EC_FAN_FULLSPEED)
> >    8269				return -EINVAL;
> >    8270	
> >    8271			if (level & TP_EC_FAN_AUTO) {
> >    8272				if (!acpi_evalf(fanw_handle, NULL,
> > NULL, "vdd", 0x8106, 0x05)) {
> >    8273					rc = -EIO;
> >    8274					break;
> >    8275				}
> >    8276				if (!acpi_evalf(fanw_handle, NULL,
> > NULL, "vdd", 0x8100, 0x00)) {
> >    8277					rc = -EIO;
> >    8278					break;
> >    8279				}
> >    8280			} else {
> >    8281				if (!acpi_evalf(fanw_handle, NULL,
> > NULL, "vdd", 0x8106, 0x45)) {
> >    8282					rc = -EIO;
> >    8283					break;
> >    8284				}
> >    8285				if (!acpi_evalf(fanw_handle, NULL,
> > NULL, "vdd", 0x8100, 0xff)) {
> >    8286					rc = -EIO;
> >    8287					break;
> >    8288				}
> >    8289				if (!acpi_evalf(fanw_handle, NULL,
> > NULL, "vdd", 0x8102, level * 100 / 7)) {
> >    8290					rc = -EIO;
> >    8291					break;
> >    8292				}
> >    8293			}
> >    8294			break;
> >    8295	
> >    8296		default:
> >    8297			return -ENXIO;
> >    8298		}
> >    8299	
> >    8300		vdbg_printk(TPACPI_DBG_FAN,
> >    8301			"fan control: set fan control register to
> > 0x%02x\n", level);
> >    8302		return 0;
> >    8303	}
> >    8304	
> > 
> 

