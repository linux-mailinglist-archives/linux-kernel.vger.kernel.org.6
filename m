Return-Path: <linux-kernel+bounces-346485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273F98C53C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385AF284CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324801CCB34;
	Tue,  1 Oct 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5j/aCLR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56615E97
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806862; cv=none; b=tezujh19ZB1X4M3rUEVYM9Fno8m8AL04GFEkiEXVPlVm0fbZizmmJaYqZvOS+iQf4QWIqdIiql7kaGSeOZw3RF62oPsdGtzgkoZUqkgxucwCxhM/89EpsuROsuoRtMpKFLJLDcP7eMF6wPSOZTC/iYpI/o+vmhry77HGbE2nArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806862; c=relaxed/simple;
	bh=sMyXaOytFNl8EZD5uMM2ER9N39v8yAYjBwDcbS8zkN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RT/QLulldiV1/qQnKwJbA/FWqsmaN/9rdIgXIxnCrU1LKLVU1O3WMk4biD9q2IibeS7yY30pUgANWx/k5CWVJu09/E/rA2lUBr/8S6axX3ZvjmzBYVoPOckPSK8ilYSO7YLytPsLNoCgH+WMSO0jrF/HdyFfgOD1tJVmSY6Jp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5j/aCLR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727806861; x=1759342861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMyXaOytFNl8EZD5uMM2ER9N39v8yAYjBwDcbS8zkN8=;
  b=W5j/aCLRQrlTvm6t87+0/CRGXVdswP2sNx3SGk80vqstG1l5DX/qHgZa
   /zg8C909jB8/gCHBTLHreEX+ggyAIORr57T9DIQ7rzFWvOQ5pV/Tw9AW9
   yQ+Tehutd0f1onuN46e8vNaH2uGQui2vRVm8yvowREWyKFmOieFmSJ2MO
   k3bBJ7EMkYzEVz7jMU9UcFIUPydqAqWLn5SduAm0ItbG3VW/qsTgTG2T1
   hRrAzO6dpHsr/4J3zLP4xjEcK/C8Vc/Mm0znQhDtAv/ykBRJpe14csXy1
   ofGpqv62odtRTNHkGLZAoheIM2npgmrdqTeJhSKFBGVZqwRmYWKCeKyl+
   A==;
X-CSE-ConnectionGUID: vkYHwF4EQme45e4dEfA3lA==
X-CSE-MsgGUID: 3/Fw14ukQwC7EgW40mzEVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27096304"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27096304"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 11:20:35 -0700
X-CSE-ConnectionGUID: IqW1GfucSQW8aqi0sQ1lBw==
X-CSE-MsgGUID: HxNHHh2LTqK+ArwjczzkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74061378"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2024 11:20:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svhU7-000R2c-1Z;
	Tue, 01 Oct 2024 18:20:31 +0000
Date: Wed, 2 Oct 2024 02:19:42 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/tmp513.c:163:10: error: 'const struct regmap_config'
 has no member named 'reg_bits'
Message-ID: <202410020246.2cTDDx0X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: 4bc82dd20be09fa133bf3116be6afc933497f860 hwmon: (tmp513) Constify struct regmap_config
date:   3 months ago
config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410020246.2cTDDx0X-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020246.2cTDDx0X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020246.2cTDDx0X-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/tmp513.c:162:21: error: variable 'tmp51x_regmap_config' has initializer but incomplete type
     162 | static const struct regmap_config tmp51x_regmap_config = {
         |                     ^~~~~~~~~~~~~
>> drivers/hwmon/tmp513.c:163:10: error: 'const struct regmap_config' has no member named 'reg_bits'
     163 |         .reg_bits = 8,
         |          ^~~~~~~~
   drivers/hwmon/tmp513.c:163:21: warning: excess elements in struct initializer
     163 |         .reg_bits = 8,
         |                     ^
   drivers/hwmon/tmp513.c:163:21: note: (near initialization for 'tmp51x_regmap_config')
>> drivers/hwmon/tmp513.c:164:10: error: 'const struct regmap_config' has no member named 'val_bits'
     164 |         .val_bits = 16,
         |          ^~~~~~~~
   drivers/hwmon/tmp513.c:164:21: warning: excess elements in struct initializer
     164 |         .val_bits = 16,
         |                     ^~
   drivers/hwmon/tmp513.c:164:21: note: (near initialization for 'tmp51x_regmap_config')
>> drivers/hwmon/tmp513.c:165:10: error: 'const struct regmap_config' has no member named 'max_register'
     165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
         |          ^~~~~~~~~~~~
   drivers/hwmon/tmp513.c:79:41: warning: excess elements in struct initializer
      79 | #define TMP51X_MAX_REGISTER_ADDR        0xFF
         |                                         ^~~~
   drivers/hwmon/tmp513.c:165:25: note: in expansion of macro 'TMP51X_MAX_REGISTER_ADDR'
     165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/tmp513.c:79:41: note: (near initialization for 'tmp51x_regmap_config')
      79 | #define TMP51X_MAX_REGISTER_ADDR        0xFF
         |                                         ^~~~
   drivers/hwmon/tmp513.c:165:25: note: in expansion of macro 'TMP51X_MAX_REGISTER_ADDR'
     165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/tmp513.c: In function 'tmp51x_probe':
   drivers/hwmon/tmp513.c:726:24: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
     726 |         data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
         |                        ^~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/tmp513.c:726:22: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     726 |         data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
         |                      ^
   drivers/hwmon/tmp513.c: At top level:
   drivers/hwmon/tmp513.c:756:1: warning: data definition has no type or storage class
     756 | module_i2c_driver(tmp51x_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/hwmon/tmp513.c:756:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
   drivers/hwmon/tmp513.c:756:1: warning: parameter names (without types) in function declaration
   drivers/hwmon/tmp513.c:162:35: error: storage size of 'tmp51x_regmap_config' isn't known
     162 | static const struct regmap_config tmp51x_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/tmp513.c:747:26: warning: 'tmp51x_driver' defined but not used [-Wunused-variable]
     747 | static struct i2c_driver tmp51x_driver = {
         |                          ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +163 drivers/hwmon/tmp513.c

59dfa75e5d82a1 Eric Tremblay   2019-11-12  161  
4bc82dd20be09f Javier Carrasco 2024-07-02  162  static const struct regmap_config tmp51x_regmap_config = {
59dfa75e5d82a1 Eric Tremblay   2019-11-12 @163  	.reg_bits = 8,
59dfa75e5d82a1 Eric Tremblay   2019-11-12 @164  	.val_bits = 16,
59dfa75e5d82a1 Eric Tremblay   2019-11-12 @165  	.max_register = TMP51X_MAX_REGISTER_ADDR,
59dfa75e5d82a1 Eric Tremblay   2019-11-12  166  };
59dfa75e5d82a1 Eric Tremblay   2019-11-12  167  

:::::: The code at line 163 was first introduced by commit
:::::: 59dfa75e5d82a1e1b3d090a1d51fc14f66844576 hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.

:::::: TO: Eric Tremblay <etremblay@distech-controls.com>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

