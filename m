Return-Path: <linux-kernel+bounces-511890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C834A3310E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F79168764
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6965202C33;
	Wed, 12 Feb 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez6rO81d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F9201258
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393506; cv=none; b=oIMrSViPap2u3pt1808kx0fgB2jIOhZcuK4niudluHx6Uc5w3NWow1Q2tAXrkOn4fwmT9IIOzmnaYTj4JfnnfhkhJkrGkSeH9YgVrTM5jPoL/+x5ETPIReoFOr+6rcPhJnpmlV9dJ2BrzFwhCWqqM+6/RFYg8Sdub4o0AxsycZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393506; c=relaxed/simple;
	bh=HghsDSxJqIdfZTjn8waXADE2Owp0YVraVawzHRAdXDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GSCEQiU/dKFL7A5begeH44H8I6ixC+VDRoaz/6HqjWpQavuDLnzPJZUe7fMMvrxXjyJYEbBzA5dv2+WHmA1WPZOB4FRcg2aOwAOXR1drnDJwU7h0WqXiZg/mkEHLJeYpDpSwUUSjxXGUjITLuQxS7IHpBgfrjY3sAE6+E+8Vo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez6rO81d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739393504; x=1770929504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HghsDSxJqIdfZTjn8waXADE2Owp0YVraVawzHRAdXDs=;
  b=ez6rO81d2jtE0ni++65cEhx//r+L1GSYZI0KRYRR+9hr3kL4UaIFJ8Q1
   8R+ehOTEvdwekLQzv22wpfTiZzd4ZFEvdHIlt2UAxvT6NCS9C1A7MbtFo
   r+ZHqaH/zxKQ7jn+fR1tMxydfC7Dp9/Q0C1WuXCIrNy36/gBwpEsC2Qfa
   NxIFK02B+ok0HSroBZkIMKSj0VMdz8/43NqXyqbcIWVdA9Ve2zkoEbok/
   k1uyp+OVVBBtU6cYM7QzoeZu8cXizBYvtorFx0CpzBxOAihPOpkBc+AhD
   hjSEcMNAtTa1poufPImSKVZKUP/y4JpgwEt2EMGWKWNJB/7Ju0njFIOMg
   w==;
X-CSE-ConnectionGUID: 0sPVAr9kRFO/AUvXAnT14w==
X-CSE-MsgGUID: xxAmmrxoTLqStE5GE2vjxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="57476828"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="57476828"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:51:43 -0800
X-CSE-ConnectionGUID: 7D9jCzJQRzqhDtv6ufiXhg==
X-CSE-MsgGUID: YHzG1jeiQRe4xxvGmWVVqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112787921"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 12:51:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiJhr-00167r-2Y;
	Wed, 12 Feb 2025 20:51:39 +0000
Date: Thu, 13 Feb 2025 04:50:42 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:590:13: warning: '%s'
 directive argument is null
Message-ID: <202502130406.iWQ0eBug-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
commit: 020620424b27bababf7f53d00692ab919c357a3f drm/amd: Use a constant format string for amdgpu_ucode_request
date:   6 months ago
config: x86_64-buildonly-randconfig-001-20250213 (https://download.01.org/0day-ci/archive/20250213/202502130406.iWQ0eBug-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502130406.iWQ0eBug-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502130406.iWQ0eBug-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c: In function 'amdgpu_umsch_mm_init_microcode':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:590:13: warning: '%s' directive argument is null [-Wformat-overflow=]
     590 |         r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +590 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c

   573	
   574	int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
   575	{
   576		const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr;
   577		struct amdgpu_device *adev = umsch->ring.adev;
   578		const char *fw_name = NULL;
   579		int r;
   580	
   581		switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
   582		case IP_VERSION(4, 0, 5):
   583		case IP_VERSION(4, 0, 6):
   584			fw_name = "amdgpu/umsch_mm_4_0_0.bin";
   585			break;
   586		default:
   587			break;
   588		}
   589	
 > 590		r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
   591		if (r) {
   592			release_firmware(adev->umsch_mm.fw);
   593			adev->umsch_mm.fw = NULL;
   594			return r;
   595		}
   596	
   597		umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)adev->umsch_mm.fw->data;
   598	
   599		adev->umsch_mm.ucode_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes);
   600		adev->umsch_mm.data_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes);
   601	
   602		adev->umsch_mm.irq_start_addr =
   603			le32_to_cpu(umsch_mm_hdr->umsch_mm_irq_start_addr_lo) |
   604			((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_irq_start_addr_hi)) << 32);
   605		adev->umsch_mm.uc_start_addr =
   606			le32_to_cpu(umsch_mm_hdr->umsch_mm_uc_start_addr_lo) |
   607			((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_uc_start_addr_hi)) << 32);
   608		adev->umsch_mm.data_start_addr =
   609			le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_lo) |
   610			((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_hi)) << 32);
   611	
   612		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
   613			struct amdgpu_firmware_info *info;
   614	
   615			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_UMSCH_MM_UCODE];
   616			info->ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_UCODE;
   617			info->fw = adev->umsch_mm.fw;
   618			adev->firmware.fw_size +=
   619				ALIGN(le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes), PAGE_SIZE);
   620	
   621			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_UMSCH_MM_DATA];
   622			info->ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_DATA;
   623			info->fw = adev->umsch_mm.fw;
   624			adev->firmware.fw_size +=
   625				ALIGN(le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes), PAGE_SIZE);
   626		}
   627	
   628		return 0;
   629	}
   630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

