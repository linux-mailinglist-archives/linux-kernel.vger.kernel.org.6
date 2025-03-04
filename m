Return-Path: <linux-kernel+bounces-543308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B7A4D41B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB223ADE49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFE1F4E4F;
	Tue,  4 Mar 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aF/Xk+hK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7913C67C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071116; cv=none; b=Nfh9gr4lYYQ7qvIzMFJFSMVqia6Mcg48KnFvZGYnDuvd/6xPLTV55rIzvFPpuObbCALJPSKZtmWs1f8r9FHzSX2A4g1I0e/JoPQIIntBhf6jT0MCrZFQWRW+3ZPY3xXL2w8mjPmqmzcAGnXwQQJft9BWGX0Mu0Crxhs3KMbKKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071116; c=relaxed/simple;
	bh=B8pwLAH5PRmaaLqV4s0UhtVNmaChZZBxuDzE6LonftQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OiaZuKZ5ZPreVRx6IQJT8y4xIb/nNIKE77UwaQOTYhajzb4PmksewQ+YdqDveAGBkGkC/S98Zd81zfj2+WCCX3j74VXqoO56ZaUEZ3sP54+CHk2ILot6jK2o4OtMd/6FHtb5kjhsYdsnAhHtxDSTRU8Vio5A2FCkRbPUMMJJ3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aF/Xk+hK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741071115; x=1772607115;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B8pwLAH5PRmaaLqV4s0UhtVNmaChZZBxuDzE6LonftQ=;
  b=aF/Xk+hKjhiAf5zwVgzA4JZEx/SFvQEgezK1/QMu9azg/avMWooycIAr
   H/ECzKLMUwY1e1YEouWTXykfqnKKP+nzIw4Nk+iJxvwWclMcmkAHUZnLV
   RFWwntc+/TfVaQzDcuHIE1YrRYQsciscFKxWEelB1BryXSeIX+uWsYlS9
   ZiBZpvoUs39qWz1syuz98FgNejwdNwnkuvaEeH5qNiSaBgN1PL4w9pnMU
   ghzgCjvE+QTI+VXbTT9DHlqYQcSHhowwjGX+8DLAGpxYW2jA5+2bZQp6i
   kuUaTlOr7NevgQtD//sDAXfTpJqATfmZvL6AffeJrLXkJxkImQCTLHnef
   g==;
X-CSE-ConnectionGUID: GQxvA0Z6RZ2BsvC5dqqRLg==
X-CSE-MsgGUID: Q2FyopADTaCByZZ3KlaXkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53368480"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53368480"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:51:53 -0800
X-CSE-ConnectionGUID: Oe6jlvS/S3WYUXEfNPDdUg==
X-CSE-MsgGUID: IteWVqepSrWNR7Uvrq7aBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118768560"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 22:51:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpM7p-000JNW-0X;
	Tue, 04 Mar 2025 06:51:37 +0000
Date: Tue, 4 Mar 2025 14:51:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Pearson <markpearson@lenovo.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: drivers/platform/x86/think-lmi.c:758:51: warning: '%s' directive
 argument is null
Message-ID: <202503041429.NcONo2Xk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99fa936e8e4f117d62f229003c9799686f74cebc
commit: b49f72e7f96d4ed147447428f2ae5b4cea598ca7 platform/x86: think-lmi: Certificate authentication support
date:   3 years ago
config: x86_64-randconfig-161-20230920 (https://download.01.org/0day-ci/archive/20250304/202503041429.NcONo2Xk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041429.NcONo2Xk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041429.NcONo2Xk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/think-lmi.c: In function 'certificate_store':
>> drivers/platform/x86/think-lmi.c:758:51: warning: '%s' directive argument is null [-Wformat-overflow=]
     758 |                 auth_str = kasprintf(GFP_KERNEL, "%s,%s",
         |                                                   ^~


vim +758 drivers/platform/x86/think-lmi.c

   727	
   728	static ssize_t certificate_store(struct kobject *kobj,
   729					  struct kobj_attribute *attr,
   730					  const char *buf, size_t count)
   731	{
   732		struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
   733		char *auth_str, *new_cert;
   734		char *guid;
   735		int ret;
   736	
   737		if (!capable(CAP_SYS_ADMIN))
   738			return -EPERM;
   739	
   740		if (!tlmi_priv.certificate_support)
   741			return -EOPNOTSUPP;
   742	
   743		new_cert = kstrdup(buf, GFP_KERNEL);
   744		if (!new_cert)
   745			return -ENOMEM;
   746		/* Strip out CR if one is present */
   747		strip_cr(new_cert);
   748	
   749		/* If empty then clear installed certificate */
   750		if (new_cert[0] == '\0') { /* Clear installed certificate */
   751			kfree(new_cert);
   752	
   753			/* Check that signature is set */
   754			if (!setting->signature || !setting->signature[0])
   755				return -EACCES;
   756	
   757			/* Format: 'serial#, signature' */
 > 758			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
   759					dmi_get_system_info(DMI_PRODUCT_SERIAL),
   760					setting->signature);
   761			if (!auth_str)
   762				return -ENOMEM;
   763	
   764			ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
   765			kfree(auth_str);
   766			if (ret)
   767				return ret;
   768	
   769			kfree(setting->certificate);
   770			setting->certificate = NULL;
   771			return count;
   772		}
   773	
   774		if (setting->cert_installed) {
   775			/* Certificate is installed so this is an update */
   776			if (!setting->signature || !setting->signature[0]) {
   777				kfree(new_cert);
   778				return -EACCES;
   779			}
   780			guid = LENOVO_UPDATE_BIOS_CERT_GUID;
   781			/* Format: 'Certificate,Signature' */
   782			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
   783					new_cert, setting->signature);
   784		} else {
   785			/* This is a fresh install */
   786			if (!setting->valid || !setting->password[0]) {
   787				kfree(new_cert);
   788				return -EACCES;
   789			}
   790			guid = LENOVO_SET_BIOS_CERT_GUID;
   791			/* Format: 'Certificate,Admin-password' */
   792			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
   793					new_cert, setting->password);
   794		}
   795		if (!auth_str) {
   796			kfree(new_cert);
   797			return -ENOMEM;
   798		}
   799	
   800		ret = tlmi_simple_call(guid, auth_str);
   801		kfree(auth_str);
   802		if (ret) {
   803			kfree(new_cert);
   804			return ret;
   805		}
   806	
   807		kfree(setting->certificate);
   808		setting->certificate = new_cert;
   809		return count;
   810	}
   811	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

