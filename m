Return-Path: <linux-kernel+bounces-373144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CB9A52F3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187D5282850
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB518B09;
	Sun, 20 Oct 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io6M1Ai1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2BF9CB
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729407267; cv=none; b=qB52I0KYKpeRmx7TNIVpyMhw0lVV7yyjqYabbXWa9uMtL+LUcdBZFS77oo2s9myi5/UEERNfnOHJQrd/6e4KLZimlF8p2DDjmEYlaQ/BNpD5oddsnnvpozJyGP2gGa3FsVfZgV/bJOdyiZZN+1cZSv3hn0NKAEbPlF2cuAOYJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729407267; c=relaxed/simple;
	bh=lkO+vTBMMOc1jYtqqX4WLiFRmJwjgaDkxbR7jVYYLuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts6b9GznMLIxIk8uD/YOuP0S0nN3dvLs/gWOnVd2mhQ11VFlAf7DtjXAT8o9Gq3uRImnTGVhUfWB0IK1Nn9M/0RwDsnvBV6//5hnWInNvBpqk/550ited5nwVZ16V33KbW6NMmtnq0MMgkuEZPfVDJ4PYPA2S0wdE6gtGwVLGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io6M1Ai1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729407265; x=1760943265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lkO+vTBMMOc1jYtqqX4WLiFRmJwjgaDkxbR7jVYYLuc=;
  b=Io6M1Ai1toYNNq6RoJlaUxcaXaaMdy6MPU7BFRktyBvu51F8xDXJ/EFo
   I2RQBpP1sjztLj9Tba8X/4Y+VK37RMpw0YHJSEvrieUEjJ/kFvpER5tfR
   FBq1sTkZe5isVkfXrp1u7JBBPQejHxEODrXruRme5dSGBxL0VUcmbD8Go
   /eJSNBp+vKrBenxfUyjqrM66aQZuKIqZm7Zs3wk/2BYqLEw0gL1Hel7S7
   7De5qkdZ4SvIKo6d8ncrMFVR6D4mZalGs6S/1ruGMHiMn/DlTrf+sAYsY
   RFgUPh55KsnrXlLfeXcR92qnB7pBrYr8tCsNAs0pn4gOTzbMbRI8sIgA9
   Q==;
X-CSE-ConnectionGUID: 1TvPzqPQTVauHJwSc9m5cA==
X-CSE-MsgGUID: zaU6EJNDRb2um03iHEgZ0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29016387"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29016387"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 23:54:24 -0700
X-CSE-ConnectionGUID: lJ9b9ft+QnWjqB4w8qV4hQ==
X-CSE-MsgGUID: Iua0YMnfT7uWx8PjM1+40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="78893427"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2024 23:54:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2PpU-000Q0Z-1S;
	Sun, 20 Oct 2024 06:54:20 +0000
Date: Sun, 20 Oct 2024 14:53:57 +0800
From: kernel test robot <lkp@intel.com>
To: Ba Jing <bajing@cmss.chinamobile.com>, mporter@kernel.crashing.org
Cc: oe-kbuild-all@lists.linux.dev, alex.bou9@gmail.com,
	linux-kernel@vger.kernel.org, Ba Jing <bajing@cmss.chinamobile.com>
Subject: Re: [PATCH] rapidio: rio-access: remove unused macros
Message-ID: <202410201405.3xFH0Ws9-lkp@intel.com>
References: <20241015000207.5047-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015000207.5047-1-bajing@cmss.chinamobile.com>

Hi Ba,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ba-Jing/rapidio-rio-access-remove-unused-macros/20241017-152330
base:   linus/master
patch link:    https://lore.kernel.org/r/20241015000207.5047-1-bajing%40cmss.chinamobile.com
patch subject: [PATCH] rapidio: rio-access: remove unused macros
config: alpha-randconfig-r072-20241020 (https://download.01.org/0day-ci/archive/20241020/202410201405.3xFH0Ws9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201405.3xFH0Ws9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201405.3xFH0Ws9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rapidio/rio-access.c: In function '__rio_local_read_config_8':
>> drivers/rapidio/rio-access.c:29:13: error: 'RIO_8_BAD' undeclared (first use in this function)
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:52:1: note: in expansion of macro 'RIO_LOP_READ'
      52 | RIO_LOP_READ(8, u8, 1)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c:29:13: note: each undeclared identifier is reported only once for each function it appears in
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:52:1: note: in expansion of macro 'RIO_LOP_READ'
      52 | RIO_LOP_READ(8, u8, 1)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function '__rio_local_read_config_16':
>> drivers/rapidio/rio-access.c:29:13: error: 'RIO_16_BAD' undeclared (first use in this function)
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:53:1: note: in expansion of macro 'RIO_LOP_READ'
      53 | RIO_LOP_READ(16, u16, 2)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function '__rio_local_read_config_32':
>> drivers/rapidio/rio-access.c:29:13: error: 'RIO_32_BAD' undeclared (first use in this function)
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:54:1: note: in expansion of macro 'RIO_LOP_READ'
      54 | RIO_LOP_READ(32, u32, 4)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function '__rio_local_write_config_8':
   drivers/rapidio/rio-access.c:48:13: error: 'RIO_8_BAD' undeclared (first use in this function)
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:55:1: note: in expansion of macro 'RIO_LOP_WRITE'
      55 | RIO_LOP_WRITE(8, u8, 1)
         | ^~~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function '__rio_local_write_config_16':
   drivers/rapidio/rio-access.c:48:13: error: 'RIO_16_BAD' undeclared (first use in this function)
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:56:1: note: in expansion of macro 'RIO_LOP_WRITE'
      56 | RIO_LOP_WRITE(16, u16, 2)
         | ^~~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function '__rio_local_write_config_32':
   drivers/rapidio/rio-access.c:48:13: error: 'RIO_32_BAD' undeclared (first use in this function)
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:57:1: note: in expansion of macro 'RIO_LOP_WRITE'
      57 | RIO_LOP_WRITE(32, u32, 4)
         | ^~~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_read_config_8':
   drivers/rapidio/rio-access.c:81:13: error: 'RIO_8_BAD' undeclared (first use in this function); did you mean 'RIO_OP_READ'?
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:105:1: note: in expansion of macro 'RIO_OP_READ'
     105 | RIO_OP_READ(8, u8, 1)
         | ^~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_read_config_16':
   drivers/rapidio/rio-access.c:81:13: error: 'RIO_16_BAD' undeclared (first use in this function)
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:106:1: note: in expansion of macro 'RIO_OP_READ'
     106 | RIO_OP_READ(16, u16, 2)
         | ^~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_read_config_32':
   drivers/rapidio/rio-access.c:81:13: error: 'RIO_32_BAD' undeclared (first use in this function)
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:107:1: note: in expansion of macro 'RIO_OP_READ'
     107 | RIO_OP_READ(32, u32, 4)
         | ^~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_write_config_8':
   drivers/rapidio/rio-access.c:100:13: error: 'RIO_8_BAD' undeclared (first use in this function); did you mean 'RIO_OP_READ'?
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:108:1: note: in expansion of macro 'RIO_OP_WRITE'
     108 | RIO_OP_WRITE(8, u8, 1)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_write_config_16':
   drivers/rapidio/rio-access.c:100:13: error: 'RIO_16_BAD' undeclared (first use in this function)
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:109:1: note: in expansion of macro 'RIO_OP_WRITE'
     109 | RIO_OP_WRITE(16, u16, 2)
         | ^~~~~~~~~~~~
   drivers/rapidio/rio-access.c: In function 'rio_mport_write_config_32':
   drivers/rapidio/rio-access.c:100:13: error: 'RIO_32_BAD' undeclared (first use in this function)
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^~~~
   drivers/rapidio/rio-access.c:110:1: note: in expansion of macro 'RIO_OP_WRITE'
     110 | RIO_OP_WRITE(32, u32, 4)
         | ^~~~~~~~~~~~


vim +/RIO_8_BAD +29 drivers/rapidio/rio-access.c

bd7bca4335a555 Ben Dooks (Codethink  2019-12-04  13) 
394b701ce4fbfd Matt Porter           2005-11-07  14  /**
394b701ce4fbfd Matt Porter           2005-11-07  15   * RIO_LOP_READ - Generate rio_local_read_config_* functions
394b701ce4fbfd Matt Porter           2005-11-07  16   * @size: Size of configuration space read (8, 16, 32 bits)
394b701ce4fbfd Matt Porter           2005-11-07  17   * @type: C type of value argument
394b701ce4fbfd Matt Porter           2005-11-07  18   * @len: Length of configuration space read (1, 2, 4 bytes)
394b701ce4fbfd Matt Porter           2005-11-07  19   *
394b701ce4fbfd Matt Porter           2005-11-07  20   * Generates rio_local_read_config_* functions used to access
394b701ce4fbfd Matt Porter           2005-11-07  21   * configuration space registers on the local device.
394b701ce4fbfd Matt Porter           2005-11-07  22   */
394b701ce4fbfd Matt Porter           2005-11-07  23  #define RIO_LOP_READ(size,type,len) \
394b701ce4fbfd Matt Porter           2005-11-07  24  int __rio_local_read_config_##size \
394b701ce4fbfd Matt Porter           2005-11-07  25  	(struct rio_mport *mport, u32 offset, type *value)		\
394b701ce4fbfd Matt Porter           2005-11-07  26  {									\
394b701ce4fbfd Matt Porter           2005-11-07  27  	int res;							\
394b701ce4fbfd Matt Porter           2005-11-07  28  	u32 data = 0;							\
394b701ce4fbfd Matt Porter           2005-11-07 @29  	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
ad1e9380b17add Zhang Wei             2008-04-18  30  	res = mport->ops->lcread(mport, mport->id, offset, len, &data);	\
394b701ce4fbfd Matt Porter           2005-11-07  31  	*value = (type)data;						\
394b701ce4fbfd Matt Porter           2005-11-07  32  	return res;							\
394b701ce4fbfd Matt Porter           2005-11-07  33  }
394b701ce4fbfd Matt Porter           2005-11-07  34  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

