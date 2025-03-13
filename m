Return-Path: <linux-kernel+bounces-560239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBE1A6007F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B151288106D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6761F3FF1;
	Thu, 13 Mar 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff4v+jA1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4891F3BB0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892709; cv=none; b=NgaPrj4NoNQ7QEShEXJ1MjRGS8rgJ8guk/kQ4nb/RSvLJ7kpc8L3RTNaZ6Vh3VgkbwF+uhyUjKRtf9vg2CR3dNX21JBi516sFl2mpWREJUe1s3T4VEGRZJWKdPvWV44JFkUCBY5MtD8WK6qgU0BtJUKgf0EdXxiGNu7Riovj/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892709; c=relaxed/simple;
	bh=iWg4hVFvyTLL0ZXRr8B9fT0VXiGOPMtR0tov4PwJgNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpGdQIfaOGJh/8OeM0UoAnoOHsZRoninJmg9r6hfEHeS2nBPUT1gbR/nkK58DwXTkN7X4O9b9IzDcuZ/i1YD/7PhRiOrepUAG7B67s1mpt3Au8VmoglUrCE8+wX4H0e4UNomVzbHgLzsQAeDUs66kRkhzLkqtSIrdjtxo+gA1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff4v+jA1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741892707; x=1773428707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iWg4hVFvyTLL0ZXRr8B9fT0VXiGOPMtR0tov4PwJgNE=;
  b=ff4v+jA11hRrtmGvBQbSobBI2hlpYGHEz6mzuKeTMlesKUOBr5SQZHN+
   7CxtY4tAimyIbiYj6AOcxRWW6BglZHoogTzV4XZaVJdJ5AzpbXnnQxzoq
   lqu/k8qdIehnU6ji5LlTl7EITlsIXZvHA+ENBM20DcKIjzwDsV5INMCLC
   SpNIfmI+8V+O7sx8XT2HV3jZ3De5SBpbzQ8AkTQrtJDXgrcZ3EwwD/dxo
   HPjTvNDSJNBIPnC7NkC+3E+s2Mx278W2XtGYO7kCWfRMohy3XYIunWxG0
   V1t6hmVcrCSzjMHnDNoXySaN1B7sgl8AWsSCoTiS0EfmX4bciVulTNHfZ
   Q==;
X-CSE-ConnectionGUID: /vqRHOjVQf2wFRGYRAL5Fg==
X-CSE-MsgGUID: Q+0EgYz5RCe/zLLhgs4B7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42278591"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42278591"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:05:06 -0700
X-CSE-ConnectionGUID: 24YuMAPCSUyHEHtc3yh94w==
X-CSE-MsgGUID: jfo4HKpeQJGe/AaWt/Jqag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121095565"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 13 Mar 2025 12:05:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsnrZ-0009mO-37;
	Thu, 13 Mar 2025 19:05:01 +0000
Date: Fri, 14 Mar 2025 03:04:15 +0800
From: kernel test robot <lkp@intel.com>
To: Rik van Riel <riel@surriel.com>, Corey Minyard <corey@minyard.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] ipmi: fix suspicious RCU usage warning
Message-ID: <202503140113.cTWvIvtK-lkp@intel.com>
References: <20250312131932.44d901f7@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312131932.44d901f7@fangorn>

Hi Rik,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.14-rc6]
[also build test ERROR on linus/master next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rik-van-Riel/ipmi-fix-suspicious-RCU-usage-warning/20250313-013222
base:   v6.14-rc6
patch link:    https://lore.kernel.org/r/20250312131932.44d901f7%40fangorn
patch subject: [PATCH] ipmi: fix suspicious RCU usage warning
config: i386-randconfig-001-20250313 (https://download.01.org/0day-ci/archive/20250314/202503140113.cTWvIvtK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503140113.cTWvIvtK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503140113.cTWvIvtK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/char/ipmi/ipmi_msghandler.c: In function 'ipmi_create_user':
>> drivers/char/ipmi/ipmi_msghandler.c:1238:62: error: macro "list_for_each_entry_srcu" requires 4 arguments, but only 3 given
    1238 |         list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
         |                                                              ^
   In file included from include/linux/dcache.h:8,
                    from include/linux/fs.h:8,
                    from include/linux/poll.h:10,
                    from drivers/char/ipmi/ipmi_msghandler.c:20:
   include/linux/rculist.h:455: note: macro "list_for_each_entry_srcu" defined here
     455 | #define list_for_each_entry_srcu(pos, head, member, cond)               \
         | 
>> drivers/char/ipmi/ipmi_msghandler.c:1238:9: error: 'list_for_each_entry_srcu' undeclared (first use in this function)
    1238 |         list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/ipmi/ipmi_msghandler.c:1238:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/char/ipmi/ipmi_msghandler.c:1238:33: error: expected ';' before '{' token
    1238 |         list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
         |                                 ^                              ~
         |                                 ;
>> drivers/char/ipmi/ipmi_msghandler.c:1246:2: warning: label 'found' defined but not used [-Wunused-label]
    1246 |  found:
         |  ^~~~~


vim +/list_for_each_entry_srcu +1238 drivers/char/ipmi/ipmi_msghandler.c

  1203	
  1204	int ipmi_create_user(unsigned int          if_num,
  1205			     const struct ipmi_user_hndl *handler,
  1206			     void                  *handler_data,
  1207			     struct ipmi_user      **user)
  1208	{
  1209		unsigned long flags;
  1210		struct ipmi_user *new_user;
  1211		int           rv, index;
  1212		struct ipmi_smi *intf;
  1213	
  1214		/*
  1215		 * There is no module usecount here, because it's not
  1216		 * required.  Since this can only be used by and called from
  1217		 * other modules, they will implicitly use this module, and
  1218		 * thus this can't be removed unless the other modules are
  1219		 * removed.
  1220		 */
  1221	
  1222		if (handler == NULL)
  1223			return -EINVAL;
  1224	
  1225		/*
  1226		 * Make sure the driver is actually initialized, this handles
  1227		 * problems with initialization order.
  1228		 */
  1229		rv = ipmi_init_msghandler();
  1230		if (rv)
  1231			return rv;
  1232	
  1233		new_user = vzalloc(sizeof(*new_user));
  1234		if (!new_user)
  1235			return -ENOMEM;
  1236	
  1237		index = srcu_read_lock(&ipmi_interfaces_srcu);
> 1238		list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
  1239			if (intf->intf_num == if_num)
  1240				goto found;
  1241		}
  1242		/* Not found, return an error */
  1243		rv = -EINVAL;
  1244		goto out_kfree;
  1245	
> 1246	 found:
  1247		if (atomic_add_return(1, &intf->nr_users) > max_users) {
  1248			rv = -EBUSY;
  1249			goto out_kfree;
  1250		}
  1251	
  1252		INIT_WORK(&new_user->remove_work, free_user_work);
  1253	
  1254		rv = init_srcu_struct(&new_user->release_barrier);
  1255		if (rv)
  1256			goto out_kfree;
  1257	
  1258		if (!try_module_get(intf->owner)) {
  1259			rv = -ENODEV;
  1260			goto out_kfree;
  1261		}
  1262	
  1263		/* Note that each existing user holds a refcount to the interface. */
  1264		kref_get(&intf->refcount);
  1265	
  1266		atomic_set(&new_user->nr_msgs, 0);
  1267		kref_init(&new_user->refcount);
  1268		new_user->handler = handler;
  1269		new_user->handler_data = handler_data;
  1270		new_user->intf = intf;
  1271		new_user->gets_events = false;
  1272	
  1273		rcu_assign_pointer(new_user->self, new_user);
  1274		spin_lock_irqsave(&intf->seq_lock, flags);
  1275		list_add_rcu(&new_user->link, &intf->users);
  1276		spin_unlock_irqrestore(&intf->seq_lock, flags);
  1277		if (handler->ipmi_watchdog_pretimeout)
  1278			/* User wants pretimeouts, so make sure to watch for them. */
  1279			smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG);
  1280		srcu_read_unlock(&ipmi_interfaces_srcu, index);
  1281		*user = new_user;
  1282		return 0;
  1283	
  1284	out_kfree:
  1285		atomic_dec(&intf->nr_users);
  1286		srcu_read_unlock(&ipmi_interfaces_srcu, index);
  1287		vfree(new_user);
  1288		return rv;
  1289	}
  1290	EXPORT_SYMBOL(ipmi_create_user);
  1291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

