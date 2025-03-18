Return-Path: <linux-kernel+bounces-565354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42EDA66684
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF7188B1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81518FDAF;
	Tue, 18 Mar 2025 02:50:20 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6D4A1A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266220; cv=none; b=Z3wPCpS7C017maY+xVWMX1DahWtWl6/Dn7JPaQUmsObnR9BJlTZk2yslDVTBZL4bpXujxZLGucmX+AoTRCOnLeqlyz6zxuB5v6b32QCCZde6GeM2yR1OF4OATYgfYz0CREw7z7DX7aA4OfreamAHbL0jz5GaDQ7Mca83uqLb+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266220; c=relaxed/simple;
	bh=RLKoQFNPwgjqqqVFk+kcD9RlxTYpQpTTNioP8z7oXKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CSogbN+a06tFxXa29cpLFHKaMyjn0YvF3T9Z6/MRbn+DI7naVEqRYqtE6lpTt7KJt1vP9wJkpEv58cOTpzdekM2vOUtsSfDIEgcAL5jvFaCDZtDi0u8yAiISdTjRRoHgCL/XFR2KgRV5WXYlMHBkpg0Md/dAMCci3e8bNtFvBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZGx7l5DDHz2Ccy4;
	Tue, 18 Mar 2025 10:46:59 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E5531A016C;
	Tue, 18 Mar 2025 10:50:13 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 18 Mar 2025 10:50:11 +0800
Message-ID: <3e872ee8-a537-4e47-90fc-45fe06f85220@huawei.com>
Date: Tue, 18 Mar 2025 10:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 drm-dp 0/9] Add HPD, getting EDID, colorbar features in
 DP function
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <libaihan@huawei.com>, <shenjian15@huawei.com>,
	<shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20250310040138.2025715-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500013.china.huawei.com (7.221.188.12)

Gently ping！

Hi, Dmitry. There is no more comment for this patch set for one week, I wonder,
could this patch be applied, or wait for more comments.

Thanks,
Baihan


> From: Baihan Li <libaihan@huawei.com>
>
> To support DP HPD, edid printing, and colorbar display features based on
> the Hisislcon DP devices.
> ---
> ChangeLog:
> v5 -> v6:
>    - fix the DP_SERDES_VOL2_PRE0 value after electrical test.
>    - move the detect_ctx() to the patch 7/9.
>    - add detect_ctx with 200ms delay, suggested by Dmitry Baryshkov.
> v4 -> v5:
>    - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
>    - fix the format of block comments, suggested by Dmitry Baryshkov.
>    - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
>    - separate the vga part commit, suggested by Dmitry Baryshkov.
>    - remove pci_disable_msi() in hibmc_unload()
> v3 -> v4:
>    - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
>    - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
>    - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
>    - fix the comment log to imperative sentence, suggested by Dmitry Baryshkov.
>    - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
>    - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
>    - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
>    - remove a drm_client, suggested by Dmitry Baryshkov.
>    - fix build errors reported by kernel test robot <lkp@intel.com>
>      Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
> v2 -> v3:
>    - restructuring the header p_reg.h, suggested by Dmitry Baryshkov.
>    - add commit log about dp serdes, suggested by Dmitry Baryshkov.
>    - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
>    - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
>    - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
>    - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
>    - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>    - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
>    - split the patch into two parts, suggested by Dmitry Baryshkov.
>    - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
>    - rewrite the commit log, suggested by Dmitry Baryshkov.
>    - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
>    - change binary format to integer format, suggested by Dmitry Baryshkov.
>    - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
>    - remove enble_display in ISR, suggested by Dmitry Baryshkov.
>    - change drm_kms_helper_connector_hotplug_event() to
>      drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
>    - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
>    - remove struct irqs, suggested by Dmitry Baryshkov.
>    - split this patch into two parts, suggested by Dmitry Baryshkov.
> v1 -> v2:
>    - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>    - changing all names of dp phy to dp serdes.
>    - deleting type conversion, suggested by Dmitry Baryshkov.
>    - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
>    - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
>    - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>    - using debugfs_init() callback, suggested by Dmitry Baryshkov.
>    - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
>    - optimizing the description in commit message, suggested by Dmitry Baryshkov.
>    - add mdelay(100) comments, suggested by Dmitry Baryshkov.
>    - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
> ---
>
> Baihan Li (9):
>    drm/hisilicon/hibmc: Restructuring the header dp_reg.h
>    drm/hisilicon/hibmc: Add dp serdes cfg to adjust serdes rate, voltage
>      and pre-emphasis
>    drm/hisilicon/hibmc: Add dp serdes cfg in dp process
>    drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
>    drm/hisilicon/hibmc: Getting connector info and EDID by using AUX
>      channel
>    drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
>    drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
>    drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD
>    drm/hisilicon/hibmc: Add vga connector detect functions
>
>   drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  16 ++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  10 +-
>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |   2 +
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  91 +++++++++++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  36 +++++
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  97 +++++++++----
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 130 +++++++++++++-----
>   .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    |  71 ++++++++++
>   .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  75 +++++++++-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  87 +++++++++---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  12 ++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |   3 +
>   14 files changed, 635 insertions(+), 102 deletions(-)
>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
>

