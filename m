Return-Path: <linux-kernel+bounces-567083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E3A680E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C93E19C0AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1E209681;
	Tue, 18 Mar 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Il35Pecz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429D1C5F2C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341971; cv=none; b=DTiyrcnHJITfqFkubjbe7RBgb7yukhXwqSdNKVcgmcTgF5n1d7ONoIOpuzoueeI5TQOuDbiL+CB5fIEqFCraRVlosTMh116lo+gs6TIVteqLP5YLPhDyeCg1u6lyaXjZuqZkQApgN6vFDgsz0nP7d0rxbOnsJ1S6dUYBHVB6SdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341971; c=relaxed/simple;
	bh=XZ6Civ661AK+dwZ9vIuDNlgUtnaviahg6j4EBM0+VK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2IGTSo8WvPiomZLsRVtLFpU4ggiSo1vk0olJpBWK8kAVi+55Q+R2M5KczIq5/tDEVlvlLv4FoMEfGB9VhcuVvaaZ/Pn1bZUlHRV/9r7CJztcLr9gCtrBp7UaozB9n5hEYcxeazNnAq2YWSBb2caPu6aMgQbfMrgSpjbwq+Y9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Il35Pecz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIOfxl029610
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kMxy2l4lpFdhOKtsEKPPqQJK7FR0tn29jLDAH13JBdc=; b=Il35Peczt5Bu9Xhf
	QCuWBSnnO+8hzC4GEeWlvgfuCsshYCs1LCWZF5m0lgVacbwVTi7i7K6wBkSXE2SQ
	1hvVe1ctJo8rCHMt30mG78DrI+knb8PxISUc/37g9Er+DS9TGNlJI6GLVKBtUHz9
	lmQBAwkFYnHE8EwT+BxFOtPAIojEO5ICgnM/jBp2Dd0AE5Go2sjGHXYVGhWi7fl4
	h366ssdSJwN7wcBQIFEMhO0fnqFp/Isra2QGI9ExfkgPLqoYD51nTyS+bqctsEJV
	TqzUF+oRcqjE3cF24kpKPKZcse9Nh6srgzjgVjkzX7TT1LHPrxEBtoxcfQwvhWym
	YRLaMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sy1u3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:52:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b6450ed8so1058174685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742341966; x=1742946766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMxy2l4lpFdhOKtsEKPPqQJK7FR0tn29jLDAH13JBdc=;
        b=ZmpJUslXN3eyD+TzLlIXrVlYg/zNdOZ7WSNCZe0v3QF3+mFnoo8koRuTRpKYPV1NQv
         E7UbHCE7QxAC5EHcbORtpmoRBp9/QTmD0SXEx0gE/QiK1LX68jCgdjewWvjv+0ILEZLc
         SAY0zV4nSwgCEZ9moNoN9XbjjnoV4z44v4PMSOx3YL/Xm66IO9fIgT181/TxijtFkBfv
         qVMd5rnQNb1dhO//YDQNaO06ltAFNrvdNSCPJZ2ST0Var8U7LCv6lLlHmaIvhe+e/S2r
         fI3jd4whNu8fPY7RGA/QMoUL8uCkq5QGA/zh3mZ9u1Tv6VRU9XstEyx6YfM2tqhOVhL/
         5f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNcRvzyorujuPMHSzaeshzC38ye/qwOpCnDlqEeyHSMIEbjHbmZhy4z2K5ej+XA1yWwV4r+4uXUXnJHv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzyt2nVRWa2K3i7+imG48EBlerhENCvHmf3S4doxZ5WquhViJ
	9g1+59TC116r9wAbF413OJqkiNxX+4yAP7LQPQ1MiewAGxRUxblU2uvZb5mD5AMuxrCgPZFnc7n
	IFjvV3j7movghd0rX8wowD1xOGMk1fMshzk9QlNlbIwKcPXX0YL34Lf57GBEHKEk=
X-Gm-Gg: ASbGncvysn6iNKEUDvVya2EOAhHrmYii0uVMZkYFEljHEWWLb9fUewlmj9kEe20vj/w
	cLzqnkolhCTDYXZoPtOEg3sPCJvmHiBcXKrgkXLRM4SABUd65TLKX+mjv6H6Zt2znTkfPq/XQt1
	MCl4o8d7ba3DBrEH4jQVGkskKG6YLn9uIdmSxM5DO2PL/1LIwmhT4RYqfC1kbsspuDFUXbqwE1k
	24+ODDYhRohYYFzkRxNVxc089ZEJF37jSSeHucxnR62WEmyeGhbBzlFZ/P462JEQLGq/VxIz/tY
	7w0UALu7TLlEKoIySCJdeNZgyf2ufUJzOg22mr76y0OZHsOm86A3HnSdtGOJdqBFvPVXN0Hjiwf
	UxJI=
X-Received: by 2002:a05:620a:4005:b0:7c5:467f:d130 with SMTP id af79cd13be357-7c5a8476bdfmr128696485a.36.1742341966504;
        Tue, 18 Mar 2025 16:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsZLpGILgkoF9IHZR+sIkZJewr/d7N1/CnLDO40+U7MRxwn9eB1zt3/hkbTmYe/Nj6Vo9Vfg==
X-Received: by 2002:a05:620a:4005:b0:7c5:467f:d130 with SMTP id af79cd13be357-7c5a8476bdfmr128694185a.36.1742341966167;
        Tue, 18 Mar 2025 16:52:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864ec9sm1847027e87.110.2025.03.18.16.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:52:45 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:52:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 0/9] Add HPD, getting EDID, colorbar features
 in DP function
Message-ID: <d5ql3fozkdbbad6mfpz2eta6mwssgwihyydjkcpk257ocqsi6l@nyqpzq36pr27>
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
 <3e872ee8-a537-4e47-90fc-45fe06f85220@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e872ee8-a537-4e47-90fc-45fe06f85220@huawei.com>
X-Proofpoint-GUID: fYCUubxruAChGs_oBsO-b8uRzVw9t7Hc
X-Proofpoint-ORIG-GUID: fYCUubxruAChGs_oBsO-b8uRzVw9t7Hc
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67da074f cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8 a=vDggtHR7Q3xBfYhfKjgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180173

On Tue, Mar 18, 2025 at 10:50:10AM +0800, Yongbang Shi wrote:
> Gently ping！
> 
> Hi, Dmitry. There is no more comment for this patch set for one week, I wonder,
> could this patch be applied, or wait for more comments.

Currently FDO is in process of migration, so we have a cooldown period
of about 1 week.

> 
> Thanks,
> Baihan
> 
> 
> > From: Baihan Li <libaihan@huawei.com>
> > 
> > To support DP HPD, edid printing, and colorbar display features based on
> > the Hisislcon DP devices.
> > ---
> > ChangeLog:
> > v5 -> v6:
> >    - fix the DP_SERDES_VOL2_PRE0 value after electrical test.
> >    - move the detect_ctx() to the patch 7/9.
> >    - add detect_ctx with 200ms delay, suggested by Dmitry Baryshkov.
> > v4 -> v5:
> >    - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
> >    - fix the format of block comments, suggested by Dmitry Baryshkov.
> >    - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
> >    - separate the vga part commit, suggested by Dmitry Baryshkov.
> >    - remove pci_disable_msi() in hibmc_unload()
> > v3 -> v4:
> >    - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
> >    - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
> >    - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
> >    - fix the comment log to imperative sentence, suggested by Dmitry Baryshkov.
> >    - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
> >    - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
> >    - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
> >    - remove a drm_client, suggested by Dmitry Baryshkov.
> >    - fix build errors reported by kernel test robot <lkp@intel.com>
> >      Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
> > v2 -> v3:
> >    - restructuring the header p_reg.h, suggested by Dmitry Baryshkov.
> >    - add commit log about dp serdes, suggested by Dmitry Baryshkov.
> >    - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
> >    - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
> >    - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
> >    - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
> >    - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
> >    - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
> >    - split the patch into two parts, suggested by Dmitry Baryshkov.
> >    - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
> >    - rewrite the commit log, suggested by Dmitry Baryshkov.
> >    - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
> >    - change binary format to integer format, suggested by Dmitry Baryshkov.
> >    - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
> >    - remove enble_display in ISR, suggested by Dmitry Baryshkov.
> >    - change drm_kms_helper_connector_hotplug_event() to
> >      drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
> >    - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
> >    - remove struct irqs, suggested by Dmitry Baryshkov.
> >    - split this patch into two parts, suggested by Dmitry Baryshkov.
> > v1 -> v2:
> >    - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
> >    - changing all names of dp phy to dp serdes.
> >    - deleting type conversion, suggested by Dmitry Baryshkov.
> >    - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
> >    - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
> >    - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
> >    - using debugfs_init() callback, suggested by Dmitry Baryshkov.
> >    - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
> >    - optimizing the description in commit message, suggested by Dmitry Baryshkov.
> >    - add mdelay(100) comments, suggested by Dmitry Baryshkov.
> >    - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
> > ---
> > 
> > Baihan Li (9):
> >    drm/hisilicon/hibmc: Restructuring the header dp_reg.h
> >    drm/hisilicon/hibmc: Add dp serdes cfg to adjust serdes rate, voltage
> >      and pre-emphasis
> >    drm/hisilicon/hibmc: Add dp serdes cfg in dp process
> >    drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
> >    drm/hisilicon/hibmc: Getting connector info and EDID by using AUX
> >      channel
> >    drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
> >    drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
> >    drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD
> >    drm/hisilicon/hibmc: Add vga connector detect functions
> > 
> >   drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  16 ++-
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  10 +-
> >   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |   2 +
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  91 +++++++++++-
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  36 +++++
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  97 +++++++++----
> >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 130 +++++++++++++-----
> >   .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    |  71 ++++++++++
> >   .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++
> >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  75 +++++++++-
> >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  87 +++++++++---
> >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  12 ++
> >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |   3 +
> >   14 files changed, 635 insertions(+), 102 deletions(-)
> >   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> >   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> > 

-- 
With best wishes
Dmitry

