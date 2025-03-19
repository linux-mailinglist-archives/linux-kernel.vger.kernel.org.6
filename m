Return-Path: <linux-kernel+bounces-567936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B106A68C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27C53B550F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18764254860;
	Wed, 19 Mar 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESNTuoEs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF7207DE2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385275; cv=none; b=nzqLQwZ5HLh8a1SPuGEbWCtWHqSXqULA6i40whdCu+jdkZSgAoiaeiMevNdNahGmGI63+Fs94jKDKWrtmLS9jvNQ4zt6NYHDzUQicEj8vdZ5kKE7G2gq8OeJBDB0PohNZ0Ix68NNtvv6z9XeSywGcvmaRNVhkuigLZRm4y4wCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385275; c=relaxed/simple;
	bh=6JdWvVf2+DhX1pCwRxYAPcV5TasCVQEKoOi3bsR8coM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGzdf8tg0U8KoCvoLhFXE4TnOol7eQc00ZuiECaaRXuCZAoJ+5HdeXIpshD6xNePRWBeVxSyvk9GXAf3TsUD5ROTp06DaOgHzS5Y4XYSIajcqR4a0P6GIwvTnUjFl5hPuI7wug9Wxd0LqQ3NH0iDq6M0XX58ajls8kErlZQ7bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESNTuoEs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lldi020465
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m1wVp3ayMkhsdP5PDoes/pSj
	xAH0RQ5XhKprMPoSjj0=; b=ESNTuoEsj0GW0LOBiKZlO6XnSbLiinR3dxBfFfKA
	cYiHH5GxDRtnagMvlLapAzc9rythdZDuVQTjiWa104Hl0KlZ5EqYuMtqfvnAZc8K
	WpAXApTxZKj4v4EodbLEAI/Rj6k4rJKx21Xnp/kCtvikKA22bLdVCRwPcP+bU3+N
	nad4F674adhvlPltB+q6LtZYHLO7+3JNQ3ij6BZ/40oiZWLS8l2rgSQZgLYslPQh
	iEf/QL93cCk5y0ipxvT7Df7ecVB1IhRCmgq6qB4bFHdTzxTxtEttRreXvHg4g5P0
	KkHDX29lY8MzRraBArKVvg/ttIZYhjdojGhjBO/Q8ltCtw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwteeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:54:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3c5e92d41so1177772285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385271; x=1742990071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1wVp3ayMkhsdP5PDoes/pSjxAH0RQ5XhKprMPoSjj0=;
        b=XuSX1Sra5fkdmhYLJvn3ZJpzHvc/dUmzONMIwuOSIN8nhDXVeOLe724rud4a3krLsG
         RBPIz7cqaVCfaoCSSzLXSTRLdAEh7dVmCwwKgY1iOcLJYFmRvNIPkhfRqYwcuuAAIvVb
         sisMXmaDBrYaNa0Ux6NfNkINDL32gMI/GvFBJlbDLUqkMbaWPxFQLajw9rp5muqKgrmf
         T7X3MX0WhmHPMCECI+aTyuxM4U5IcVpSpK8uTBiJf2suwkchEkR15W6HUPCjbe8KMIin
         eC46UfOTIqOzlgXqP4T5EV7qRttujXLU8s0MyVlJCM4Gf326i9NvUR7frH9Gu9IGuznE
         o1bA==
X-Forwarded-Encrypted: i=1; AJvYcCVJdKdDhUWojBZhSiR/noescjdxmbfANZiI998xiWqIRWnV1EzQoLD9wx3xdBRpwaRQ0moy4jEjL8CZ8aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza//Y2KNM1Q8MQZzCLrkVHFmCEHkSUgf5dE9gdWprL6Yoi2Cc4
	yMCgPpGvk9trIkTYrQaE/ur9yf1Llkm1oEV+GSN4864iewMDVr4RuNCvzO8MLHJghiWQavaBvPt
	auBbmsL+ML6S/bCY7R64bZg1+FwNfVzHr5xSQNu/vKiIVk1m0C45G0/LnqH4k4Ak=
X-Gm-Gg: ASbGncs86jzcawjuKLhtlUvG7/QEPvZuEbahq2K7hup2R37qwE1lpNfDrdqvx8zB59+
	RjZq+lmLdyi+k3USfpRII54ma9J9IQX2j23PH6Le+3aOhJi2u0O20TFtsvP4T/0Bk/BJWEHNedR
	FzGiwV8NrtcyvJkwTqxDSkpnUVLvzWpfSF8Y6yA8XkgrbsuTa5SNVZr0pwPxjikFFdu8j2hxYLL
	1w9eOc2rqs2++ek4DRDKJ/FHvzRV4wSX2hWBdCbakXZBJQw0ESSUdKGzno7f8UsthiFkMOf4wf0
	Uy8qGCPek0lL2DeFhPvuLJLbb3XoG4nIdOKigmsumF2xzITh5C4heEq4eHjfzpSrLS5WCXomPfm
	Xg4g=
X-Received: by 2002:a05:620a:454e:b0:7c5:a55b:fa6c with SMTP id af79cd13be357-7c5a84620e1mr304858285a.38.1742385271508;
        Wed, 19 Mar 2025 04:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp9lvt7Q0aLMIolPL2+xrZPtBlFeLVP+h8L4UOLPcPOwLwkMyFNsvohYJ6wdFLYq9DY5XjMA==
X-Received: by 2002:a05:620a:454e:b0:7c5:a55b:fa6c with SMTP id af79cd13be357-7c5a84620e1mr304854185a.38.1742385271046;
        Wed, 19 Mar 2025 04:54:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba882793sm1963795e87.179.2025.03.19.04.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:54:30 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:54:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 drm-dp 0/9] Add HPD, getting EDID, colorbar features
 in DP function
Message-ID: <eazroq6fccuklkzps2e5med3bn655od7qjbkyahryzpimlytzk@j5gordvuudg4>
References: <20250319032435.1119469-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319032435.1119469-1-shiyongbang@huawei.com>
X-Proofpoint-ORIG-GUID: k4IaoPvIryAU3JhnNl-Hm-01eymvQLq9
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dab078 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=flXVKZ_LIo3tZOgc874A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: k4IaoPvIryAU3JhnNl-Hm-01eymvQLq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190082

On Wed, Mar 19, 2025 at 11:24:26AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> To support DP HPD, edid printing, and colorbar display features based on
> the Hisislcon DP devices.
> ---
> ChangeLog:
> v6 -> v7:
>   - add if statement about drm aux in hibmc_dp_connector_get_modes(), suggested by Jani Nikula

Where was that suggestion? Also, would you please implement his feedback
regarding drm_edid_read()?

>   v6: https://lore.kernel.org/all/20250310040138.2025715-1-shiyongbang@huawei.com/
> v5 -> v6:
>   - fix the DP_SERDES_VOL2_PRE0 value after electrical test.
>   - move the detect_ctx() to the patch 7/9.
>   - add detect_ctx with 200ms delay, suggested by Dmitry Baryshkov.
>   v5: https://lore.kernel.org/all/20250307101640.4003229-1-shiyongbang@huawei.com/
> v4 -> v5:
>   - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
>   - fix the format of block comments, suggested by Dmitry Baryshkov.
>   - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
>   - separate the vga part commit, suggested by Dmitry Baryshkov.
>   - remove pci_disable_msi() in hibmc_unload()
>   v4: https://lore.kernel.org/all/20250305112647.2344438-1-shiyongbang@huawei.com/
> v3 -> v4:
>   - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
>   - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
>   - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
>   - fix the comment log to imperative sentence, suggested by Dmitry Baryshkov.
>   - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
>   - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
>   - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
>   - remove a drm_client, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
>   v3: https://lore.kernel.org/all/20250222025102.1519798-1-shiyongbang@huawei.com/
> v2 -> v3:
>   - restructuring the header p_reg.h, suggested by Dmitry Baryshkov.
>   - add commit log about dp serdes, suggested by Dmitry Baryshkov.
>   - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
>   - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
>   - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
>   - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
>   - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>   - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
>   - split the patch into two parts, suggested by Dmitry Baryshkov.
>   - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
>   - rewrite the commit log, suggested by Dmitry Baryshkov.
>   - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
>   - change binary format to integer format, suggested by Dmitry Baryshkov.
>   - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
>   - remove enble_display in ISR, suggested by Dmitry Baryshkov.
>   - change drm_kms_helper_connector_hotplug_event() to
>     drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
>   - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
>   - remove struct irqs, suggested by Dmitry Baryshkov.
>   - split this patch into two parts, suggested by Dmitry Baryshkov.
>   v2: https://lore.kernel.org/all/20250210144959.100551-1-shiyongbang@huawei.com/
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>   - changing all names of dp phy to dp serdes.
>   - deleting type conversion, suggested by Dmitry Baryshkov.
>   - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
>   - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
>   - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>   - using debugfs_init() callback, suggested by Dmitry Baryshkov.
>   - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
>   - optimizing the description in commit message, suggested by Dmitry Baryshkov.
>   - add mdelay(100) comments, suggested by Dmitry Baryshkov.
>   - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
>   v1: https://lore.kernel.org/all/20250127032024.1542219-1-shiyongbang@huawei.com/
> ---
> 
> Baihan Li (9):
>   drm/hisilicon/hibmc: Restructuring the header dp_reg.h
>   drm/hisilicon/hibmc: Add dp serdes cfg to adjust serdes rate, voltage
>     and pre-emphasis
>   drm/hisilicon/hibmc: Add dp serdes cfg in dp process
>   drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
>   drm/hisilicon/hibmc: Getting connector info and EDID by using AUX
>     channel
>   drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
>   drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
>   drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD
>   drm/hisilicon/hibmc: Add vga connector detect functions
> 
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  16 ++-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  10 +-
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |   2 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  91 +++++++++++-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  36 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  97 +++++++++----
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 130 +++++++++++++-----
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    |  71 ++++++++++
>  .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  78 ++++++++++-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  87 +++++++++---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  12 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |   3 +
>  14 files changed, 638 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> 
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

