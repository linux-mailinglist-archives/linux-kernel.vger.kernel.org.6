Return-Path: <linux-kernel+bounces-176422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BD8C2FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A9B28439F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 05:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F184E1D2;
	Sat, 11 May 2024 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsH2yEUi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253D4653C;
	Sat, 11 May 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405454; cv=none; b=cjUII0alStyVv4pqSIeWrSCHCVlbU/jtGVsMBy+u8ppXYhRUAW+FBudH7epWult+R8HVhCAAqK0AOjmWNbnmoWcWp8VkOPDLVF0zGzX6M67N+cfOW+gdH4cbbT3ltFuUOls1/TuyZNBjfWApYyA8+KnpmdudI/zUDPkrJMtFxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405454; c=relaxed/simple;
	bh=rQ1c7y7bZSRr0Y8VPoLgL/gNE+kEqKqhcHEmsbqe1Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne5nERiCmK0AsKW7FWui4mIJVqtHEB7kIcRgw/1AqprEdjEs8XslCcH33RQyHrZz7wsB38Rg6zmvzaWIOEcKH+aQKbEaf42/p6EEuTV34E3bSoqHn34xvVNZAkmaH/U9kGPpQ61ATObGD01m9mp3qapuUgu74eBwcjMo6o4R/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsH2yEUi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715405452; x=1746941452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQ1c7y7bZSRr0Y8VPoLgL/gNE+kEqKqhcHEmsbqe1Ro=;
  b=TsH2yEUiIGCkFS3jmLSBNRQMylh1Lhu/qpTOkB91E4Va9xEY38Wrb0j4
   x7gF2GBsx8ILsH45awhvzVbqID24i5UcCz9F7d+l4oF+pb06XOK83cFnH
   0bDwg/xe9aI2xH9z8oyCe6EynypTKNIJN0EGY2e/EtMgipuGboe8ZZLiT
   zwGALGm99nVWleW7K8soqvZAswc6fDFth4bsoiE2BCO9Wtzo/AvykJKb6
   Z5NXGqWbPZfqqK49YmjRXE+S5uhtj57oyT8Tjhu+xZBRklB5j4R0zavH/
   ai/cZUYG2h5z5PsKh1Zq+FEZGXsSts3SAx07agzYdVqsgIsDzOlAN0G7j
   w==;
X-CSE-ConnectionGUID: ndBxNdeXT9G0VpDepZF/lg==
X-CSE-MsgGUID: CFiTEkvpTHK2n0CrJwrhHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11627140"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11627140"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:30:52 -0700
X-CSE-ConnectionGUID: U7mxv43QQ3aMp4eUHKbX3Q==
X-CSE-MsgGUID: 1Yto9Q3cTBq4VwM+MDji3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34347206"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 May 2024 22:30:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5fJl-0006yk-2S;
	Sat, 11 May 2024 05:30:45 +0000
Date: Sat, 11 May 2024 13:30:02 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <202405111304.CJcpd03O-lkp@intel.com>
References: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>

Hi Pankaj,

kernel test robot noticed the following build errors:

[auto build test ERROR on e8f897f4afef0031fe618a8e94127a0934896aba]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Gupta/Documentation-firmware-add-imx-se-to-other_interfaces/20240510-213210
base:   e8f897f4afef0031fe618a8e94127a0934896aba
patch link:    https://lore.kernel.org/r/20240510-imx-se-if-v1-4-27c5a674916d%40nxp.com
patch subject: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
config: x86_64-buildonly-randconfig-005-20240511 (https://download.01.org/0day-ci/archive/20240511/202405111304.CJcpd03O-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111304.CJcpd03O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111304.CJcpd03O-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/se_ioctl.h:12:2: error: unknown type name 'u8'
      12 |         u8 *user_buf;
         |         ^
>> ./usr/include/linux/se_ioctl.h:13:2: error: unknown type name 'u32'
      13 |         u32 length;
         |         ^
   ./usr/include/linux/se_ioctl.h:14:2: error: unknown type name 'u32'
      14 |         u32 flags;
         |         ^
>> ./usr/include/linux/se_ioctl.h:15:2: error: unknown type name 'u64'
      15 |         u64 ele_addr;
         |         ^
   ./usr/include/linux/se_ioctl.h:19:2: error: unknown type name 'u32'
      19 |         u32 base_offset;
         |         ^
   ./usr/include/linux/se_ioctl.h:20:2: error: unknown type name 'u32'
      20 |         u32 size;
         |         ^
   ./usr/include/linux/se_ioctl.h:24:2: error: unknown type name 'u8'
      24 |         u8 se_if_id;
         |         ^
   ./usr/include/linux/se_ioctl.h:25:2: error: unknown type name 'u8'
      25 |         u8 interrupt_idx;
         |         ^
   ./usr/include/linux/se_ioctl.h:26:2: error: unknown type name 'u8'
      26 |         u8 tz;
         |         ^
   ./usr/include/linux/se_ioctl.h:27:2: error: unknown type name 'u8'
      27 |         u8 did;
         |         ^
   ./usr/include/linux/se_ioctl.h:28:2: error: unknown type name 'u8'
      28 |         u8 cmd_tag;
         |         ^
   ./usr/include/linux/se_ioctl.h:29:2: error: unknown type name 'u8'
      29 |         u8 rsp_tag;
         |         ^
   ./usr/include/linux/se_ioctl.h:30:2: error: unknown type name 'u8'
      30 |         u8 success_tag;
         |         ^
   ./usr/include/linux/se_ioctl.h:31:2: error: unknown type name 'u8'
      31 |         u8 base_api_ver;
         |         ^
   ./usr/include/linux/se_ioctl.h:32:2: error: unknown type name 'u8'
      32 |         u8 fw_api_ver;
         |         ^
   ./usr/include/linux/se_ioctl.h:36:2: error: unknown type name 'u8'
      36 |         u8 *message;
         |         ^
   ./usr/include/linux/se_ioctl.h:37:2: error: unknown type name 'u32'
      37 |         u32 msg_size;
         |         ^
   ./usr/include/linux/se_ioctl.h:38:2: error: unknown type name 'u32'
      38 |         u32 error_code;
         |         ^
>> ./usr/include/linux/se_ioctl.h:42:2: error: unknown type name 'u16'
      42 |         u16 soc_id;
         |         ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

