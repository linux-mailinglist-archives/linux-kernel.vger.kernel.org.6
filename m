Return-Path: <linux-kernel+bounces-369745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A369A2217
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46254280C83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952081DD0F3;
	Thu, 17 Oct 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv57JiCx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD41DA0E3;
	Thu, 17 Oct 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167630; cv=none; b=YlZCWpf24wWxqrapWPE1orMOEch86FLFEsIhXH5N28nL01QhtSHONCAGsSl5pltRj+VIgKn1crVZbWm9w/QD5q2Y8RXlwfrOqQbM5cF0BpoG1FeW39Hpg7de+Cu4OqaPEDIJfqhXL9fRyJgDDC+pyEqSdEd8yMyqE2gzxVOkZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167630; c=relaxed/simple;
	bh=UzEC933QNlyBQvfZIOIfz6b58fWhPD60XcUGJX9oNa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn4uHLFeTklFyu6ry60GoRzidbKmGK+jBIzMfqbFEBtrg5iXmuf/QTH/HRCepXF7y1mhip/gbqClfk8SOTWsbwTHfcjA4gkgGOKgY0p+zVIP6HNZiQ91kJvGeG+7Bl7geRsC+XNAAZaX/xwcSmpYEn0DroC0rGYIYYv4AbnXq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv57JiCx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729167627; x=1760703627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UzEC933QNlyBQvfZIOIfz6b58fWhPD60XcUGJX9oNa8=;
  b=Uv57JiCx79KF7o34poMKYKSu+hNArpZ9oTB70oNtFYdWQkRR7rr9tvDB
   ybdTRDcjxaOk/17GXeuyXar0+52jWrWRh7cVkH+CrBRcsoi6C8AIUfYG7
   Xe9YN0ThkMCxB/PbOzaFZRfyOASxZDgIJOeTqkAWYJpmsrt4+NzM0KCFh
   9jOzb+CFPezp54JpzUreM3BT8J12aYtNXzoDY+qt0ETesHaW+V2w2yHJM
   zQxcQziDg+Zn4IH37tZ6v0jPajLPqedIjAmO5nSCpI6N3EwTKz8DzkSRe
   OqmauI07IHSZvxbBwGeglvKv/0NzKvJpdEfDNZvk3mLvLbQXjtnTHwe4k
   Q==;
X-CSE-ConnectionGUID: 01yAv/nATHiOBl9mbuSASg==
X-CSE-MsgGUID: P7CDxbaoTqWjYCRgMqly4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28440391"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28440391"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:20:26 -0700
X-CSE-ConnectionGUID: rLJKg05STUGFOV8gcxCyLQ==
X-CSE-MsgGUID: AB2sSXubSny3l8h1ZROPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="115966099"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Oct 2024 05:20:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1PUJ-000MIh-2I;
	Thu, 17 Oct 2024 12:20:19 +0000
Date: Thu, 17 Oct 2024 20:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] firmware: imx: adds miscdev
Message-ID: <202410172012.K2lpYYqD-lkp@intel.com>
References: <20241016-imx-se-if-v9-5-fd8fa0c04eab@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-imx-se-if-v9-5-fd8fa0c04eab@nxp.com>

Hi Pankaj,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Gupta/Documentation-firmware-add-imx-se-to-other_interfaces/20241017-002539
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241016-imx-se-if-v9-5-fd8fa0c04eab%40nxp.com
patch subject: [PATCH v9 5/5] firmware: imx: adds miscdev
config: x86_64-buildonly-randconfig-002-20241017 (https://download.01.org/0day-ci/archive/20241017/202410172012.K2lpYYqD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410172012.K2lpYYqD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172012.K2lpYYqD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/se_ioctl.h:13:9: error: unknown type name 'u32'
      13 |         u32 length;
         |         ^~~
   ./usr/include/linux/se_ioctl.h:14:9: error: unknown type name 'u32'
      14 |         u32 flags;
         |         ^~~
>> ./usr/include/linux/se_ioctl.h:15:9: error: unknown type name 'u64'
      15 |         u64 ele_addr;
         |         ^~~
   ./usr/include/linux/se_ioctl.h:19:9: error: unknown type name 'u32'
      19 |         u32 base_offset;
         |         ^~~
   ./usr/include/linux/se_ioctl.h:20:9: error: unknown type name 'u32'
      20 |         u32 size;
         |         ^~~
>> ./usr/include/linux/se_ioctl.h:24:9: error: unknown type name 'u8'
      24 |         u8 se_if_id;
         |         ^~
   ./usr/include/linux/se_ioctl.h:25:9: error: unknown type name 'u8'
      25 |         u8 interrupt_idx;
         |         ^~
   ./usr/include/linux/se_ioctl.h:26:9: error: unknown type name 'u8'
      26 |         u8 tz;
         |         ^~
   ./usr/include/linux/se_ioctl.h:27:9: error: unknown type name 'u8'
      27 |         u8 did;
         |         ^~
   ./usr/include/linux/se_ioctl.h:28:9: error: unknown type name 'u8'
      28 |         u8 cmd_tag;
         |         ^~
   ./usr/include/linux/se_ioctl.h:29:9: error: unknown type name 'u8'
      29 |         u8 rsp_tag;
         |         ^~
   ./usr/include/linux/se_ioctl.h:30:9: error: unknown type name 'u8'
      30 |         u8 success_tag;
         |         ^~
   ./usr/include/linux/se_ioctl.h:31:9: error: unknown type name 'u8'
      31 |         u8 base_api_ver;
         |         ^~
   ./usr/include/linux/se_ioctl.h:32:9: error: unknown type name 'u8'
      32 |         u8 fw_api_ver;
         |         ^~
   ./usr/include/linux/se_ioctl.h:36:9: error: unknown type name 'u32'
      36 |         u32 *tx_buf;
         |         ^~~
   ./usr/include/linux/se_ioctl.h:38:9: error: unknown type name 'u32'
      38 |         u32 *rx_buf;
         |         ^~~
>> ./usr/include/linux/se_ioctl.h:43:9: error: unknown type name 'u16'
      43 |         u16 soc_id;
         |         ^~~
   ./usr/include/linux/se_ioctl.h:44:9: error: unknown type name 'u16'
      44 |         u16 soc_rev;
         |         ^~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

