Return-Path: <linux-kernel+bounces-535875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0302AA47868
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB177A4022
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A3226541;
	Thu, 27 Feb 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NR0EdkVF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87821225403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646696; cv=none; b=L6yNCk9umWzCfYcvNiWoFHpYCcHZDEWeS+vUEIYhmSgc1q6DqE8aWPolJEGlvl9+p78AB+rIQMzHrfW6B8ahosHrb6UxkUjCxhvnB2f/kUHTQ2zLw9hZp9CYcJbkbcODUMXVlsqc3iVKkg5vovPQbOKwiQTJ3wcePrwy3Oqhv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646696; c=relaxed/simple;
	bh=mRCwYdhDdjfT1ryuXbi5zx1t+2TvkYj+V5CHntnFZQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XcYXd7DQnjNkdGrf2pr2Xo3uScvLutNUCrQflcS0L8GdVoRUuoU5TWXF3NQPbk4eAuPa14/T1BPtzq77FK1cXxcrm5tGimzcUSRsYdTToGteofhEEq6eUKrmRJa8eHyakYOrqaSz+IV4X95PaOOB5RiYAbYnUKNOG6hna9C50Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NR0EdkVF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740646695; x=1772182695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mRCwYdhDdjfT1ryuXbi5zx1t+2TvkYj+V5CHntnFZQ8=;
  b=NR0EdkVFYp8UcGAaxW219Oxe+M7RPkds0dbzwEzZtWVImTbNyqxCaRO5
   iNQdVZapFZg3t4AvaqE6LMCwE3/jbbMFb4WyCuxYuS1nBqKBkcmt1U2kk
   iE/8FWuunQPX+0yeZjh2aInURSdzJdhcBSI5HH5I1DnLW+fy4/UgTnCHT
   LsXhN147kpSD1B59Ney4HCsnSvwnwPOo6QeoFrLcNy3uMQveHGX/JOjjm
   L9k5A8+9vNJggelcl6+DZXmUEA+twAbEyTzddEd1omJhTHIWGUOZH28a9
   6p9mkQLb4XtryLu0zjGq9v6Lkfh8DaeGmYb5kQ8xnscT77yv3GknUDtkU
   w==;
X-CSE-ConnectionGUID: YSG6e6cATPWZBB76ANDEMw==
X-CSE-MsgGUID: 01pbVCgBTKiM3n10jwvxSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45179082"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45179082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:58:15 -0800
X-CSE-ConnectionGUID: qWue2tijSk2NplSDvMcZ8Q==
X-CSE-MsgGUID: qqmTMjZ2Q4aqEghxTsrESA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116738627"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 27 Feb 2025 00:58:13 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnZib-000D84-2V;
	Thu, 27 Feb 2025 08:58:09 +0000
Date: Thu, 27 Feb 2025 16:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/i40e/i40e_ptp.c:1375:27: warning: '%s'
 directive output may be truncated writing up to 287 bytes into a region of
 size 64
Message-ID: <202502271608.TTHgj7OB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Piotr,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd83757f6e686a2188997cb58b5975f744bb7786
commit: 1050713026a08d605b61f039700b67aab646371f i40e: add support for PTP external synchronization clock
date:   3 years, 7 months ago
config: alpha-randconfig-p001-20211207 (https://download.01.org/0day-ci/archive/20250227/202502271608.TTHgj7OB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271608.TTHgj7OB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271608.TTHgj7OB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_ptp.c: In function 'i40e_ptp_init':
>> drivers/net/ethernet/intel/i40e/i40e_ptp.c:1375:27: warning: '%s' directive output may be truncated writing up to 287 bytes into a region of size 64 [-Wformat-truncation=]
    1375 |                          "%s", sdp_desc[i].name);
         |                           ^~
   In function 'i40e_init_pin_config',
       inlined from 'i40e_ptp_create_clock' at drivers/net/ethernet/intel/i40e/i40e_ptp.c:1414:13,
       inlined from 'i40e_ptp_init' at drivers/net/ethernet/intel/i40e/i40e_ptp.c:1519:8:
   drivers/net/ethernet/intel/i40e/i40e_ptp.c:1373:17: note: 'snprintf' output between 1 and 288 bytes into a destination of size 64
    1373 |                 snprintf(pf->ptp_caps.pin_config[i].name,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1374 |                          sizeof(pf->ptp_caps.pin_config[i].name),
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1375 |                          "%s", sdp_desc[i].name);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~


vim +1375 drivers/net/ethernet/intel/i40e/i40e_ptp.c

  1349	
  1350	/**
  1351	 * i40e_init_pin_config - initialize pins.
  1352	 * @pf: private board structure
  1353	 *
  1354	 * Initialize pins for external clock source.
  1355	 * Return 0 on success or error code on failure.
  1356	 **/
  1357	static int i40e_init_pin_config(struct i40e_pf *pf)
  1358	{
  1359		int i;
  1360	
  1361		pf->ptp_caps.n_pins = 3;
  1362		pf->ptp_caps.n_ext_ts = 2;
  1363		pf->ptp_caps.pps = 1;
  1364		pf->ptp_caps.n_per_out = 2;
  1365	
  1366		pf->ptp_caps.pin_config = kcalloc(pf->ptp_caps.n_pins,
  1367						  sizeof(*pf->ptp_caps.pin_config),
  1368						  GFP_KERNEL);
  1369		if (!pf->ptp_caps.pin_config)
  1370			return -ENOMEM;
  1371	
  1372		for (i = 0; i < pf->ptp_caps.n_pins; i++) {
  1373			snprintf(pf->ptp_caps.pin_config[i].name,
  1374				 sizeof(pf->ptp_caps.pin_config[i].name),
> 1375				 "%s", sdp_desc[i].name);
  1376			pf->ptp_caps.pin_config[i].index = sdp_desc[i].index;
  1377			pf->ptp_caps.pin_config[i].func = PTP_PF_NONE;
  1378			pf->ptp_caps.pin_config[i].chan = sdp_desc[i].chan;
  1379		}
  1380	
  1381		pf->ptp_caps.verify = i40e_ptp_verify;
  1382		pf->ptp_caps.enable = i40e_ptp_feature_enable;
  1383	
  1384		pf->ptp_caps.pps = 1;
  1385	
  1386		return 0;
  1387	}
  1388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

