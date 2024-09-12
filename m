Return-Path: <linux-kernel+bounces-326942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43710976EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AC1285FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB31BB6A2;
	Thu, 12 Sep 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+UEPLww"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD81BA86F;
	Thu, 12 Sep 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158977; cv=none; b=mWLrV9KXBYf/NEirHHTe2HlLUnhbP6y4KQxuaLDm769Y7/ZbuGlKfczsulocGr2Qzq8lrACgNLqFvKe57NgFig76xTh2ZmpwD67y2yTeluYcuSCcUgTdNwQucUfJI03kV6Yxn4tOX3pbx/ksqf6vaYdFiGGn6H/Y11OGkTliZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158977; c=relaxed/simple;
	bh=9ePkSUpvWLm8KN2FGW++zZeyNa08vsr64xdApCrFuGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buz7YSyYJu8KpqBDM73Bkka0WJbYOWLZzgvbo7rE0CZNHRRSC0dm9GeIGCca1oijuxlB46SGTFdl6b5zy+b5jEIq8rv6a7Kqa/n/RTwGj2rvUSU1Tk5qbln3l76rnJFDwyDA0YvGBTk8SQh/bNiGG1PdsJ7SZ3kSFg/rhGVxXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+UEPLww; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726158975; x=1757694975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ePkSUpvWLm8KN2FGW++zZeyNa08vsr64xdApCrFuGw=;
  b=E+UEPLwwsWcGXo/Vas9erV3gJHrkwvJ23JUEsp2aRwy964Ijz45TKVmA
   EROCcWztlracy6qtHekglzLuc0GEaETuPah5C5c+nFwCkbBhn8lhQamtf
   5ieF17jP/frc+L/PJ+/nGkvHDuxVbIJafjqOOYj4PgxPuOwz67kBupc28
   qbWtdZHmCOT4BELKCBwV9NogilIsPJzsbPNO/tYPYwvJhqnAPmxPQdFeJ
   6bQrM2h55GXQ0Z2kdpMGj/rMha3d+KLpu/awImOUy3bYIWVHHewS/1SLg
   ffqneKqnDHc+fms8psXhffyPw5UuKT62TjWKrilu2kVQ2sjRauX+IiF5N
   w==;
X-CSE-ConnectionGUID: PekZynJ5QHiU3Adb9RRd3w==
X-CSE-MsgGUID: T9dXhI5YS5KVE6b5r2qJ9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24564844"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24564844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 09:36:14 -0700
X-CSE-ConnectionGUID: o353610kQkmQeqsxkNmmsQ==
X-CSE-MsgGUID: XkwQ4q6hRvqUVoeEmgD4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68273802"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2024 09:36:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1somng-0005TC-0v;
	Thu, 12 Sep 2024 16:36:08 +0000
Date: Fri, 13 Sep 2024 00:36:02 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Biel <pbiel7@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patryk Biel <pbiel7@gmail.com>
Subject: Re: [PATCH] hwmon: Conditionally clear individual status bits for
 pmbus rev >= 1.2
Message-ID: <202409122210.audc5WGS-lkp@intel.com>
References: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>

Hi Patryk,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c763c43396883456ef57e5e78b64d3c259c4babc]

url:    https://github.com/intel-lab-lkp/linux/commits/Patryk-Biel/hwmon-Conditionally-clear-individual-status-bits-for-pmbus-rev-1-2/20240909-173838
base:   c763c43396883456ef57e5e78b64d3c259c4babc
patch link:    https://lore.kernel.org/r/20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408%40gmail.com
patch subject: [PATCH] hwmon: Conditionally clear individual status bits for pmbus rev >= 1.2
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240912/202409122210.audc5WGS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122210.audc5WGS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122210.audc5WGS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/pmbus_core.c:1100:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1100 |                 if (data->revision >= PMBUS_REV_12)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pmbus_core.c:1105:7: note: uninitialized use occurs here
    1105 |                 if (ret)
         |                     ^~~
   drivers/hwmon/pmbus/pmbus_core.c:1100:3: note: remove the 'if' if its condition is always true
    1100 |                 if (data->revision >= PMBUS_REV_12)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1101 |                         ret = _pmbus_write_byte_data(client, page, reg, regval);
         |                                                                                ~
    1102 |                 else
         |                 ~~~~
    1103 |                         pmbus_clear_fault_page(client, page);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pmbus_core.c:1083:9: note: initialize the variable 'ret' to silence this warning
    1083 |         int ret, status;
         |                ^
         |                 = 0
   1 warning generated.


vim +1100 drivers/hwmon/pmbus/pmbus_core.c

  1050	
  1051	/*
  1052	 * Return boolean calculated from converted data.
  1053	 * <index> defines a status register index and mask.
  1054	 * The mask is in the lower 8 bits, the register index is in bits 8..23.
  1055	 *
  1056	 * The associated pmbus_boolean structure contains optional pointers to two
  1057	 * sensor attributes. If specified, those attributes are compared against each
  1058	 * other to determine if a limit has been exceeded.
  1059	 *
  1060	 * If the sensor attribute pointers are NULL, the function returns true if
  1061	 * (status[reg] & mask) is true.
  1062	 *
  1063	 * If sensor attribute pointers are provided, a comparison against a specified
  1064	 * limit has to be performed to determine the boolean result.
  1065	 * In this case, the function returns true if v1 >= v2 (where v1 and v2 are
  1066	 * sensor values referenced by sensor attribute pointers s1 and s2).
  1067	 *
  1068	 * To determine if an object exceeds upper limits, specify <s1,s2> = <v,limit>.
  1069	 * To determine if an object exceeds lower limits, specify <s1,s2> = <limit,v>.
  1070	 *
  1071	 * If a negative value is stored in any of the referenced registers, this value
  1072	 * reflects an error code which will be returned.
  1073	 */
  1074	static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
  1075				     int index)
  1076	{
  1077		struct pmbus_data *data = i2c_get_clientdata(client);
  1078		struct pmbus_sensor *s1 = b->s1;
  1079		struct pmbus_sensor *s2 = b->s2;
  1080		u16 mask = pb_index_to_mask(index);
  1081		u8 page = pb_index_to_page(index);
  1082		u16 reg = pb_index_to_reg(index);
  1083		int ret, status;
  1084		u16 regval;
  1085	
  1086		mutex_lock(&data->update_lock);
  1087		status = pmbus_get_status(client, page, reg);
  1088		if (status < 0) {
  1089			ret = status;
  1090			goto unlock;
  1091		}
  1092	
  1093		if (s1)
  1094			pmbus_update_sensor_data(client, s1);
  1095		if (s2)
  1096			pmbus_update_sensor_data(client, s2);
  1097	
  1098		regval = status & mask;
  1099		if (regval) {
> 1100			if (data->revision >= PMBUS_REV_12)
  1101				ret = _pmbus_write_byte_data(client, page, reg, regval);
  1102			else
  1103				pmbus_clear_fault_page(client, page);
  1104	
  1105			if (ret)
  1106				goto unlock;
  1107		}
  1108		if (s1 && s2) {
  1109			s64 v1, v2;
  1110	
  1111			if (s1->data < 0) {
  1112				ret = s1->data;
  1113				goto unlock;
  1114			}
  1115			if (s2->data < 0) {
  1116				ret = s2->data;
  1117				goto unlock;
  1118			}
  1119	
  1120			v1 = pmbus_reg2data(data, s1);
  1121			v2 = pmbus_reg2data(data, s2);
  1122			ret = !!(regval && v1 >= v2);
  1123		} else {
  1124			ret = !!regval;
  1125		}
  1126	unlock:
  1127		mutex_unlock(&data->update_lock);
  1128		return ret;
  1129	}
  1130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

