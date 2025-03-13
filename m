Return-Path: <linux-kernel+bounces-560207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BAA5FF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97743BF04E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5251DDC3B;
	Thu, 13 Mar 2025 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWyPum2I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3118952C;
	Thu, 13 Mar 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890786; cv=none; b=G60wKyJIEAQYN/4aD57R9Pr+5LIVbUxrN1L4foDlp3INAVLpLGtbvek3iZ5ukUErsbSMQ/t3nV+B/R1KAPbYg55Kn+BiHT8hYYPjg3d81fhZT9XdnNYZrxv75sTdIjSBVaKmnO8RuuGpJLjqXoJlBObW5GCc4dQH7GWh74vnq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890786; c=relaxed/simple;
	bh=NNfdweyltKpfxEYdB4dJuUUgTK30BjFlrikEsqHw4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxO9nWkGCHkXldREO8efwI2AZnauPE1EqSEtQ8ACl2ZrVYFK3LJ30DnC2KH2o64Kz0UNHfUWjt0gNT4JOwyExl8Pb0imzEbsb6grOYHc0e3fDHPyhFuxBNG7m0HB5bqgvq+RmVvZdBkO1kl7UhQT2FlMsAC82oM+zyMdmjlKpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWyPum2I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741890785; x=1773426785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NNfdweyltKpfxEYdB4dJuUUgTK30BjFlrikEsqHw4SA=;
  b=FWyPum2IuqRFFAf8Qs9te8FCnEbQTsxQiIFiKyVt4UUmtUJWk2Aa9ZuA
   pRl0NRcAPS55l1wY4vyBxNYvgPk3NM7q4GuUyz3rAHGZHnLFkgq+byJmO
   k6xTOlV6uZBo0bZ9nA/W7LDmNKneul9V1FUVt4/nleaml1QzVQI5Kt0L+
   iW+b9sfrAgDzvVq2WHJXv53yszZUNaaOXun3y6wqo3F2Fi/8n+xpgslWT
   9IOpKkt3gjYurTeqq5wUFNIIYa3NEMeX9e41JLhf68GydEE2+6/XSAYLv
   n1WLbpKbgBKlF9sZASxyn08xUYlZ5jHIpKJANxvLy6vu0Ijo+cvSIQwxU
   Q==;
X-CSE-ConnectionGUID: uZBVAx66SDe9Gt/LGSN3Lg==
X-CSE-MsgGUID: 0+ElCedaRl6xyASiroZu4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42911425"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42911425"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:33:04 -0700
X-CSE-ConnectionGUID: FWRYxOsiSAeJW66tDYLG0A==
X-CSE-MsgGUID: gmOubHMERIa2gAR7Sa2tyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="125663989"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Mar 2025 11:33:02 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsnMZ-0009lE-2a;
	Thu, 13 Mar 2025 18:32:59 +0000
Date: Fri, 14 Mar 2025 02:32:41 +0800
From: kernel test robot <lkp@intel.com>
To: Subu Dwevedi <messigoatcr7nop@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
Message-ID: <202503140229.R49CaAYj-lkp@intel.com>
References: <20250312123055.1735-2-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312123055.1735-2-messigoatcr7nop@gmail.com>

Hi Subu,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Subu-Dwevedi/hwmon-applesmc-add-MMIO-for-newer-macs/20250312-203248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250312123055.1735-2-messigoatcr7nop%40gmail.com
patch subject: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
config: x86_64-buildonly-randconfig-002-20250313 (https://download.01.org/0day-ci/archive/20250314/202503140229.R49CaAYj-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503140229.R49CaAYj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503140229.R49CaAYj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/applesmc.c:717:42: error: incomplete definition of type 'struct acpi_device'
     717 |         status = acpi_get_current_resources(adev->handle, &buffer);
         |                                             ~~~~^
   include/linux/acpi.h:801:8: note: forward declaration of 'struct acpi_device'
     801 | struct acpi_device;
         |        ^
   1 error generated.


vim +717 drivers/hwmon/applesmc.c

   678	
   679	static int applesmc_init_index(struct applesmc_registers *s)
   680	{
   681		const struct applesmc_entry *entry;
   682		unsigned int i;
   683	
   684		if (s->index)
   685			return 0;
   686	
   687		s->index = kcalloc(s->temp_count, sizeof(s->index[0]), GFP_KERNEL);
   688		if (!s->index)
   689			return -ENOMEM;
   690	
   691		for (i = s->temp_begin; i < s->temp_end; i++) {
   692			entry = applesmc_get_entry_by_index(i);
   693			if (IS_ERR(entry))
   694				continue;
   695			if (strcmp(entry->type, TEMP_SENSOR_TYPE))
   696				continue;
   697			s->index[s->index_count++] = entry->key;
   698		}
   699	
   700		return 0;
   701	}
   702	/*
   703	 * applesmc_init_mmio_try - Try to initialize MMIO
   704	 */
   705	static int applesmc_init_mmio_try(void)
   706	{
   707		u8 ldkn_version;
   708		acpi_status status;
   709		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
   710		struct acpi_device *adev;
   711		struct acpi_resource *res;
   712	
   713		adev = acpi_dev_get_first_match_dev("APP0001", NULL, -1);
   714		if (!adev)
   715			return -ENXIO;
   716	
 > 717		status = acpi_get_current_resources(adev->handle, &buffer);
   718		if (ACPI_FAILURE(status))
   719			return -ENXIO;
   720	
   721		res = buffer.pointer;
   722		while (res->type != ACPI_RESOURCE_TYPE_END_TAG) {
   723			if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
   724				if (res->data.fixed_memory32.address_length < 0x4006)
   725					return -ENXIO;
   726	
   727				mmio_base_addr = res->data.fixed_memory32.address;
   728				mmio_base_size = res->data.fixed_memory32.address_length;
   729				is_mmio = true;
   730				break;
   731			}
   732			res = ACPI_NEXT_RESOURCE(res);
   733		}
   734		kfree(buffer.pointer);
   735		acpi_dev_put(adev);
   736	
   737		if (!is_mmio)
   738			return -ENXIO;
   739	
   740		mmio_base = ioremap(mmio_base_addr, mmio_base_size);
   741	
   742		if (!mmio_base)
   743			return -ENXIO;
   744	
   745		if (ioread8(mmio_base + 0x4005) == 0xFF)
   746			goto out;
   747	
   748		if (read_smc(APPLESMC_READ_CMD, "LDKN", &ldkn_version, 1))
   749			goto out;
   750	
   751		if (ldkn_version < 2)
   752			goto out;
   753	
   754		return 0;
   755	out:
   756		pr_warn("cannot enable MMIO will use PMIO\n");
   757		iounmap(mmio_base);
   758		return -ENXIO;
   759	}
   760	/*
   761	 * applesmc_init_smcreg_try - Try to initialize register cache. Idempotent.
   762	 */
   763	static int applesmc_init_smcreg_try(void)
   764	{
   765		struct applesmc_registers *s = &smcreg;
   766		bool left_light_sensor = false, right_light_sensor = false;
   767		unsigned int count;
   768		u8 tmp[1];
   769		int ret;
   770	
   771		if (s->init_complete)
   772			return 0;
   773	
   774		ret = read_register_count(&count);
   775		if (ret)
   776			return ret;
   777	
   778		if (s->cache && s->key_count != count) {
   779			pr_warn("key count changed from %d to %d\n",
   780				s->key_count, count);
   781			kfree(s->cache);
   782			s->cache = NULL;
   783		}
   784		s->key_count = count;
   785	
   786		if (!s->cache)
   787			s->cache = kcalloc(s->key_count, sizeof(*s->cache), GFP_KERNEL);
   788		if (!s->cache)
   789			return -ENOMEM;
   790	
   791		ret = applesmc_read_key(FANS_COUNT, tmp, 1);
   792		if (ret)
   793			return ret;
   794		s->fan_count = tmp[0];
   795		if (s->fan_count > 10)
   796			s->fan_count = 10;
   797	
   798		ret = applesmc_get_lower_bound(&s->temp_begin, "T");
   799		if (ret)
   800			return ret;
   801		ret = applesmc_get_lower_bound(&s->temp_end, "U");
   802		if (ret)
   803			return ret;
   804		s->temp_count = s->temp_end - s->temp_begin;
   805	
   806		ret = applesmc_init_index(s);
   807		if (ret)
   808			return ret;
   809	
   810		ret = applesmc_has_key(LIGHT_SENSOR_LEFT_KEY, &left_light_sensor);
   811		if (ret)
   812			return ret;
   813		ret = applesmc_has_key(LIGHT_SENSOR_RIGHT_KEY, &right_light_sensor);
   814		if (ret)
   815			return ret;
   816		ret = applesmc_has_key(MOTION_SENSOR_KEY, &s->has_accelerometer);
   817		if (ret)
   818			return ret;
   819		ret = applesmc_has_key(BACKLIGHT_KEY, &s->has_key_backlight);
   820		if (ret)
   821			return ret;
   822	
   823		s->num_light_sensors = left_light_sensor + right_light_sensor;
   824		s->init_complete = true;
   825	
   826		pr_info("key=%d fan=%d temp=%d index=%d acc=%d lux=%d kbd=%d\n",
   827		       s->key_count, s->fan_count, s->temp_count, s->index_count,
   828		       s->has_accelerometer,
   829		       s->num_light_sensors,
   830		       s->has_key_backlight);
   831	
   832		return 0;
   833	}
   834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

