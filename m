Return-Path: <linux-kernel+bounces-567902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E6A68BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7783D188873B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041F254B0A;
	Wed, 19 Mar 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lp0MyyfV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FB25487C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383890; cv=none; b=S4ty0PE920aijAMv5CqTrf3lUQjNkuBu4D/Bd02f3prkDQCESsfy8Y2Mmhk3KHir/6+KnqNro9aHYrr/hrliTVmVI6mM4/u6VCJU/ACrutFAnuIc+ozHYylIeypNHdLGIPEVc3qZbLg7/p6xtCdF2AK+hh2kMjq9bjfe+cw3AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383890; c=relaxed/simple;
	bh=miPNwNamxQnwll9Jxfko9krCAsFl9p+itypX6gJKU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi97Te59k5B02JJ+eC09nI+j+Kzf97mNHm30saF2SBwGwaj/sBx6Egm5PRZBUsIKCY3lCk7tvuZU9ZgjwsB6edB1L5DRaGh/YUlfELm9B1SHJmhLqcwdYpL4/J+Ys2Kqfs30ALc7OEBF88/Hk2TfUgn4yMzEsiNtpYMulHviPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lp0MyyfV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4loDd020954
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KpWWS4rtujK1n/xo8nEaDZVAURyLPCgq6nUafEBKolE=; b=lp0MyyfVfGy8z0YJ
	vL04sg/ByWLmFfW3eDFjBpbnqMvq7Lz3LPhuHyRGy2O82tMBNX1P/szo9vhmCGmD
	LTAqG2Q6oaRMwgCubYd+1In/M5GSo8A+juxjf3WcVl1FcMb4iD+dW+e1MmWtEIDk
	suh+6o6JQI3NpVYMetczxlU+94duPlqi5AlfjoWNRW7lpHVKwIOTDsjJ0EMWEzV8
	nXrCyQ3+sv/Uh6R8tJb2R7DCm6oiS1sCuJkpsDqpNxNfLDmzAIhDcfg+MQMPVE5n
	eP+mwnN21BMMZK27ZGATSEtFSGdsps4kBrItvYQa5Vh3GvLP7b2oi+a2PmKyNPsC
	R9ZE9A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbn2fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feffbe08so177763986d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383886; x=1742988686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpWWS4rtujK1n/xo8nEaDZVAURyLPCgq6nUafEBKolE=;
        b=C122ZJZoDI8grPqQrlU0DOdmNWlphbXsqbl/cEsVpEm7+UMENnGckNKlguglnM9PNk
         5NrQw6XIuqOQlGWs1r7N4XMactjJVi3Aha8+n7l4VVkMwSlJvtFg1GLHttnsvJdB7Cyl
         bfXuW8zeRXUPXBxBPjTUmS2hLBy/oKuTMec73NNnqU6+JZk7X53x/G8XL6hZHG7B9vIz
         nRUPPtprnQlrpzf5eoWaZfOUcNroR4O75x9DSYjRQdIm+h2kFxug+8rYgYXGA6ZyTjyb
         f7jTHjWi7QGO6FRDzbdRiWTj/q9xdArNm3Zn55TVIaFDdWC32KeK9PxxQ6fPIUfnI5FV
         mH+g==
X-Forwarded-Encrypted: i=1; AJvYcCXGFQDbK10BmVNOLnxWi+7dLqimHid3wURQNk7MTrhsSvhkYOUh7ssBcg8v7qiOE2YuxC7jkThcp7Y/fv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2UFbjky7XSNEpP0wZTiEmwNV24TIQSoh+U9UMswlwV974fq4
	hcssBgCI4UB7+ctNkUodGAQVBKJVl0NBZ7RphOpC/924nl9Abvc7vu9KPikRvVGIzhdsbtAFawY
	GRu1f8WGwyqXQzYOOL0VFsdxPaxWJildt2rlmcMh8e6wDsuvxBqFePD3Fh32T604=
X-Gm-Gg: ASbGncvcWJbRlf5HJTlDtnWUQwNDYY20R6Osv+G3hOdlCxr7sjmHEpaJfTTH/6No8oD
	KJjZ67FUZ9UmlEhrS/wvzh8kENvxQQ11CNqOCg+Yg/+JzkFEJgBGywOykeKDjy4cZ7oNcu08Fen
	sd2Ti94vNIwR1+Xx1AH1MsryRwbs5aGphKzU4UIAI/bioJ7OIKLpFZXO6VU1U2qWx6/NH79IOMz
	31P9F3zeQvrtBjGNpgJfXZCC3EVPdNhvH+TSGC9KMgdHv5scxvA8ICOvyotFQuXE4HxxpWL8uJV
	Dv7XG/8aAqtNhTL4pWBeeD8wm2kte4ELOZjp+2izK9Rh2u0gNvZw7L3vOfLP+7p8A8PCvZ/pxsb
	DeS8=
X-Received: by 2002:ad4:5be4:0:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6eb2949600amr32213006d6.39.1742383886261;
        Wed, 19 Mar 2025 04:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/Y6VInAkBnON3Epc11JfY+SkSvLQjl2R0CfSZ7JEcJWOHWNKrGQiyeneFTelehZyZCM5kA==
X-Received: by 2002:ad4:5be4:0:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6eb2949600amr32212736d6.39.1742383885904;
        Wed, 19 Mar 2025 04:31:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d270csm22789301fa.8.2025.03.19.04.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:31:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:31:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: neil.armstrong@linaro.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Message-ID: <xu2gugtf67b46cxn3jnbwgxmukhh7r6bcvsxdodpg7tdecdurk@ct5nk7ohs6xs>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
 <38cd738c-1a2a-4382-80f8-d57feb7c829d@quicinc.com>
 <6717d816-02b3-4d27-848b-620398808076@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6717d816-02b3-4d27-848b-620398808076@linaro.org>
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67daab0f cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=fqUNt6dOXZUB1Xd34j0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4EnWCQKAMiGrE9qAARa61stvsqH-OWyl
X-Proofpoint-GUID: 4EnWCQKAMiGrE9qAARa61stvsqH-OWyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190079

On Wed, Mar 19, 2025 at 11:00:34AM +0100, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 19/03/2025 10:46, Baochen Qiang wrote:
> > 
> > 
> > On 3/19/2025 5:12 PM, neil.armstrong@linaro.org wrote:
> > > Hi,
> > > 
> > > On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
> > > > 
> > > > 
> > > > On 3/19/2025 1:34 PM, Neil Armstrong wrote:
> > > > > On 18/03/2025 17:35, Jeff Johnson wrote:
> > > > > > On 3/3/2025 7:00 AM, Neil Armstrong wrote:
> > > > > > > In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
> > > > > > > single_chip_mlo_supp")
> > > > > > > the line:
> > > > > > >  ����ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
> > > > > > > was incorrectly updated to:
> > > > > > >  ����ab->single_chip_mlo_supp = false;
> > > > > > > leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
> > > > > > > 
> > > > > > > The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
> > > > > > > crashes on driver initialization with:
> > > > > > >  � ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
> > > > > > >  � ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35
> > > > > > > fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-
> > > > > > > QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> > 
> > this FW version is not upstream yet, why are you testing with it?
> 
> I was not aware the driver supported only a small subset of firmwares.
> 
> > 
> > Generally we only support upstrmea driver + upstream FW.
> 
> In this case, change the driver to only support those exact firmware versions,
> or print a warning in case we try to load a non-mainline-supported firmware.
> 
> But if you did read the commit message, the commit 46d16f7e1d14 is bogus, the
> single_chip_mlo_supp should be set to true to keep the driver behavior prior
> of commit 46d16f7e1d14. It happens to trigger the crash with this firmware,
> but the code behavior was changed by commit 46d16f7e1d14, which should be fixed.

Now to the change itself. I have checked the referened commit. It's
behaviour doesn't match commit message. It tells: "For the WCN7850
family of chipsets, since the event is not supported, assumption is made
that single chip MLO is supported.", however the contents of the commit
doesn't match this. As such, I'd support the patch, it looks corect to
me, despite being used with the non-supported firmware.

> This is the whole point of this patch, fix a regression on the mainline tree
> for existing users.

-- 
With best wishes
Dmitry

