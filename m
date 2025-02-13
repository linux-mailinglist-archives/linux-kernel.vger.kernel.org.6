Return-Path: <linux-kernel+bounces-512853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C152AA33E74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1927A51AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3521422A;
	Thu, 13 Feb 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSEbYhi1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CC214A62;
	Thu, 13 Feb 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447431; cv=none; b=i4l6KHpSVNGRzGXB52/hNCIKTvx0Aa7pjCm+HpGpDaCQnKYh2MXuyDpqBRwfU7AQOlaHDf0lrFagAzG340vanrbNq3T6ucdCDiExaLOZ2ywJ1kvCvw0fPiNoxnfyW9IKVtRdyMYZebvJmev8FHjlGimGdy+kPkARvvBzu3cS2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447431; c=relaxed/simple;
	bh=s7y+vsG1sqQYMMb3Rkr13a4BlT3RJ2jFTe/m5yWCJJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhoOPe1oXmG2obRDy1XHV5BjRLJMRBr38TPZhtzku8tTWEzNwOz8gf2u+D2VQU+x2sI7xLAsB17mMXovcJMsiPWoQTGDPWs9uIXJrPnZRg2OhRIkDFSvugi7/6AfuHZKBkq25+NfaGvlP5SWu4QByqvWL0BaTbHyvFieZDz08Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSEbYhi1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739447429; x=1770983429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s7y+vsG1sqQYMMb3Rkr13a4BlT3RJ2jFTe/m5yWCJJQ=;
  b=XSEbYhi1yi8ijf+2FcCsUpyqSn2GRGLDVIR7p+3jCTRUErAWJcSVEK6y
   C6Zydm/4lBqr77YEL2usDZUijxVWYx5swJNlxcCUqBoIAlz824SlaY5gi
   zMrInMFIpR9uOLFiOmNT4t5QuZxXlPMGlFbdniMMBpAKvHiOT2Svje8NM
   ON2F/beSEBVGA8YJrbFOBEiuxbEX5T05d7HS0oGosR+UZPlyaeZkSyTji
   tZrhHZ5tTeaxegJM8nUtJPDSMLJIe4y+FtqEA+bwnIKAk85X/9RVSoriW
   yKk76CHKJOWYtT/bVT6iTF9c/SQsIqwVeMAoBQm05T4Fk6gpv0M0r7H0Z
   w==;
X-CSE-ConnectionGUID: pedEKFQTRPm+LpkGLY1MBg==
X-CSE-MsgGUID: qy9rEKW1Q6W/aeADyJ5BFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="65497238"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="65497238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:50:27 -0800
X-CSE-ConnectionGUID: Lwl8CKFPTzC6uqNi0kIL2g==
X-CSE-MsgGUID: UZfww+L/QsCVplzJI2MNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144067437"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Feb 2025 03:50:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiXja-0016zn-06;
	Thu, 13 Feb 2025 11:50:22 +0000
Date: Thu, 13 Feb 2025 19:49:42 +0800
From: kernel test robot <lkp@intel.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com, Frank.Li@nxp.com,
	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <202502131947.VmPYnXuz-lkp@intel.com>
References: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>

Hi Aman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aman-Kumar-Pandey/drivers-i3c-Add-driver-for-NXP-P3H2x4x-i3c-hub-device/20250212-213659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250212132227.1348374-2-aman.kumarpandey%40nxp.com
patch subject: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub device
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250213/202502131947.VmPYnXuz-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131947.VmPYnXuz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131947.VmPYnXuz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:6:
   In file included from drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h:12:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:52:7: warning: variable 'flag_clear' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      52 |                 if (ret)
         |                     ^~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:80:62: note: uninitialized use occurs here
      80 |         regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
         |                                                                     ^~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:52:3: note: remove the 'if' if its condition is always false
      52 |                 if (ret)
         |                 ^~~~~~~~
      53 |                         goto ibi_err;
         |                         ~~~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:45:6: warning: variable 'flag_clear' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      45 |         if (ret)
         |             ^~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:80:62: note: uninitialized use occurs here
      80 |         regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
         |                                                                     ^~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:45:2: note: remove the 'if' if its condition is always false
      45 |         if (ret)
         |         ^~~~~~~~
      46 |                 goto ibi_err;
         |                 ~~~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:32:6: warning: variable 'flag_clear' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      32 |         if (ret)
         |             ^~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:80:62: note: uninitialized use occurs here
      80 |         regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
         |                                                                     ^~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:32:2: note: remove the 'if' if its condition is always false
      32 |         if (ret)
         |         ^~~~~~~~
      33 |                 goto ibi_err;
         |                 ~~~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:27:6: warning: variable 'flag_clear' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      27 |         if (ret)
         |             ^~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:80:62: note: uninitialized use occurs here
      80 |         regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
         |                                                                     ^~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:27:2: note: remove the 'if' if its condition is always false
      27 |         if (ret)
         |         ^~~~~~~~
      28 |                 goto ibi_err;
         |                 ~~~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:20:35: note: initialize the variable 'flag_clear' to silence this warning
      20 |         u8 target_buffer_page, flag_clear, rx_data, temp, i;
         |                                          ^
         |                                           = '\0'
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:453:2: warning: variable 'write_length' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     453 |         default:
         |         ^~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:460:12: note: uninitialized use occurs here
     460 |         desc[2] = write_length;
         |                   ^~~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:372:30: note: initialize the variable 'write_length' to silence this warning
     372 |         u8 read_length, write_length;
         |                                     ^
         |                                      = '\0'
>> drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:453:2: warning: variable 'read_length' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     453 |         default:
         |         ^~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:461:12: note: uninitialized use occurs here
     461 |         desc[3] = read_length;
         |                   ^~~~~~~~~~~
   drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c:372:16: note: initialize the variable 'read_length' to silence this warning
     372 |         u8 read_length, write_length;
         |                       ^
         |                        = '\0'
   9 warnings generated.


vim +52 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c

    12	
    13	static void p3h2x4x_read_smbus_agent_rx_buf(struct i3c_device *i3cdev, enum p3h2x4x_rcv_buf rfbuf,
    14									enum p3h2x4x_tp tp, bool is_of)
    15	{
    16		struct device *dev = i3cdev_to_dev(i3cdev);
    17		struct p3h2x4x *priv = dev_get_drvdata(dev);
    18		struct smbus_device *backend = NULL;
    19	
    20		u8 target_buffer_page, flag_clear, rx_data, temp, i;
    21		u8 slave_rx_buffer[P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE] = { 0 };
    22		u32 packet_len, slave_address, ret;
    23	
    24		target_buffer_page = (((rfbuf) ? P3H2x4x_TARGET_BUFF_1_PAGE : P3H2x4x_TARGET_BUFF_0_PAGE)
    25								+  (P3H2x4x_NO_PAGE_PER_TP * tp));
    26		ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, target_buffer_page);
    27		if (ret)
    28			goto ibi_err;
    29	
    30		/* read buffer length */
    31		ret = regmap_read(priv->regmap, P3H2x4x_TARGET_BUFF_LENGTH, &packet_len);
    32		if (ret)
    33			goto ibi_err;
    34	
    35		if (packet_len)
    36			packet_len = packet_len - 1;
    37	
    38		if (packet_len > P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE) {
    39			dev_err(dev, "Received message too big for p3h2x4x buffer\n");
    40			return;
    41		}
    42	
    43		/* read slave  address */
    44		ret = regmap_read(priv->regmap, P3H2x4x_TARGET_BUFF_ADDRESS, &slave_address);
    45		if (ret)
    46			goto ibi_err;
    47	
    48		/* read data */
    49		if (packet_len) {
    50			ret = regmap_bulk_read(priv->regmap, P3H2x4x_TARGET_BUFF_DATA,
    51					slave_rx_buffer, packet_len);
  > 52			if (ret)
    53				goto ibi_err;
    54		}
    55	
    56		if (is_of)
    57			flag_clear = BUF_RECEIVED_FLAG_TF_MASK;
    58		else
    59			flag_clear = (((rfbuf == RCV_BUF_0) ? P3H2x4x_TARGET_BUF_0_RECEIVE :
    60						P3H2x4x_TARGET_BUF_1_RECEIVE));
    61	
    62		/* notify slave driver about received data */
    63		list_for_each_entry(backend, &priv->tp_bus[tp].tp_device_entry, list) {
    64			if ((slave_address >> 1 == backend->addr) && (priv->is_slave_reg)) {
    65				i2c_slave_event(backend->client, I2C_SLAVE_WRITE_REQUESTED,
    66					(u8 *)&slave_address);
    67	
    68				for (i = 0; i < packet_len; i++) {
    69					rx_data = slave_rx_buffer[i];
    70					i2c_slave_event(backend->client, I2C_SLAVE_WRITE_RECEIVED,
    71							&rx_data);
    72				}
    73				i2c_slave_event(backend->client, I2C_SLAVE_STOP, &temp);
    74				break;
    75			}
    76		}
    77	
    78	ibi_err:
    79		regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, 0x00);
    80		regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

