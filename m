Return-Path: <linux-kernel+bounces-203723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692F8FDF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC901F271C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D413C3F4;
	Thu,  6 Jun 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W13iCal+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993053D56D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658476; cv=none; b=W/bhOPJvEAl+5PmzWO5aJGJJlqdcHimEz9RoBH35ZTEKwOc6Dl9bkzhQcXIWQdKRlqs9hie0/CEvDt4IM6fTUN3Wk81DUDYomEVlR7FvkgirJSWvB/Vh50IfWgswk80R9CYFK8LcubUW0TFxLsS8yPG14kNl+L6+lTxgOZHj4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658476; c=relaxed/simple;
	bh=QD4Dh8MLYOkud3AMPflq2aHwK8HUP7fobAgy/H0UKDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W7be2c5j5JV7Rb0IJmxKwxDDdHtXe8vrs+Cgr2gRXC7V2BHzlNnCsRzkfPTHF0VFBvuk85RvRnmDHjx4OSQq5bdG5Jo04XH7e+y3oLSwmpt6VYJNQHdXJ9i6RVRegRfE6TLYlkhVDaCdgfe5tsHg53nsYpHTfGwcxq4xFK5QvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W13iCal+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717658474; x=1749194474;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QD4Dh8MLYOkud3AMPflq2aHwK8HUP7fobAgy/H0UKDA=;
  b=W13iCal+q0SluhaypB2NOFgKTY8lHrdacPljpzmliv/ds1RJLG1nAXtB
   epeOOhFhfinZRuTYii/Vx3xsHy5t/1nvv+Eg+7VML5gVudeRCMfVXjxwr
   SAIDrxZOT8qoTxlDBKUwmy5NPk5he2f189b0S3i7bSG8BJPSgua3MaziW
   iQKeK8Rc/jsuYVY+JBxrBer4M+XXQ6f0acwc4II//OSaatTq6CSPCZa32
   1PXC/60FvwdX84NBN7NSHN37rmDNyTjBQdl4J1qNGwn+r56OnURevUhMY
   jEqeDxYAmO6m5cCsccOmInZEjZcNla/7TnjzW96ecY8F/HN9q208upbAl
   g==;
X-CSE-ConnectionGUID: ozJJMAXSRV6JLY1zC+UbGA==
X-CSE-MsgGUID: p0kBJBhXQgWziV9DGVc0bQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14147843"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14147843"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 00:21:14 -0700
X-CSE-ConnectionGUID: v/EJ7GX4RJOkNXeZvA21Fg==
X-CSE-MsgGUID: dO3Tae8ZQJKIx4SLwrVfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42794382"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.9])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 00:21:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>, kernel test robot
 <lkp@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 hughsient@gmail.com
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during
 initialization
In-Reply-To: <ZmB_cs-7GU-m3GXX@debian.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240528210319.1242-1-mario.limonciello@amd.com>
 <202406040928.Eu1gRIWv-lkp@intel.com> <ZmB_cs-7GU-m3GXX@debian.local>
Date: Thu, 06 Jun 2024 10:21:07 +0300
Message-ID: <87h6e6bkpo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 05 Jun 2024, Chris Bainbridge <chris.bainbridge@gmail.com> wrote:
> On Tue, Jun 04, 2024 at 10:02:29AM +0800, kernel test robot wrote:
>> Hi Mario,
>> 
>> kernel test robot noticed the following build errors:
>> 
>> [auto build test ERROR on drm-misc/drm-misc-next]
>> [also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.10-rc2 next-20240603]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>> 
>> url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-client-Detect-when-ACPI-lid-is-closed-during-initialization/20240529-050440
>> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
>> patch link:    https://lore.kernel.org/r/20240528210319.1242-1-mario.limonciello%40amd.com
>> patch subject: [PATCH v2] drm/client: Detect when ACPI lid is closed during initialization
>> config: i386-randconfig-053-20240604 (https://download.01.org/0day-ci/archive/20240604/202406040928.Eu1gRIWv-lkp@intel.com/config)
>> compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040928.Eu1gRIWv-lkp@intel.com/reproduce)
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406040928.Eu1gRIWv-lkp@intel.com/
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    ld: drivers/gpu/drm/drm_client_modeset.o: in function `drm_client_match_edp_lid':
>> >> drivers/gpu/drm/drm_client_modeset.c:281:(.text+0x221b): undefined reference to `acpi_lid_open'
>> 
>> 
>> vim +281 drivers/gpu/drm/drm_client_modeset.c
>> 
>>    260	
>>    261	static void drm_client_match_edp_lid(struct drm_device *dev,
>>    262					     struct drm_connector **connectors,
>>    263					     unsigned int connector_count,
>>    264					     bool *enabled)
>>    265	{
>>    266		int i;
>>    267	
>>    268		for (i = 0; i < connector_count; i++) {
>>    269			struct drm_connector *connector = connectors[i];
>>    270	
>>    271			switch (connector->connector_type) {
>>    272			case DRM_MODE_CONNECTOR_LVDS:
>>    273			case DRM_MODE_CONNECTOR_eDP:
>>    274				if (!enabled[i])
>>    275					continue;
>>    276				break;
>>    277			default:
>>    278				continue;
>>    279			}
>>    280	
>>  > 281			if (!acpi_lid_open()) {
>>    282				drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
>>    283					    connector->base.id, connector->name);
>>    284				enabled[i] = false;
>>    285			}
>>    286		}
>>    287	}
>>    288	
>> 
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>
> The failed config has CONFIG_ACPI_BUTTON=m. The build failure can be
> fixed with:
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index b76438c31761..0271e66f44f8 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -271,11 +271,13 @@ static void drm_client_match_edp_lid(struct drm_device *dev,
>                 if (connector->connector_type != DRM_MODE_CONNECTOR_eDP || !enabled[i])
>                         continue;
>
> +#if defined(CONFIG_ACPI_BUTTON)
>                 if (!acpi_lid_open()) {
>                         drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
>                                     connector->base.id, connector->name);
>                         enabled[i] = false;
>                 }
> +#endif
>         }
>  }

No. This is because

CONFIG_DRM=y
CONFIG_ACPI_BUTTON=m

The pedantically correct fix is probably having DRM

	depends on ACPI_BUTTON || ACPI_BUTTON=n

but seeing how i915 and xe just

	select ACPI_BUTTON if ACPI

and nouveau basically uses acpi_lid_open() it if it's reachable with no
regard to kconfig, it's anyone's guess what will work.


BR,
Jani.



-- 
Jani Nikula, Intel

