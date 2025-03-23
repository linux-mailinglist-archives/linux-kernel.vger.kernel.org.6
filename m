Return-Path: <linux-kernel+bounces-572707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85569A6CD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2175F3B8A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209261D86E6;
	Sun, 23 Mar 2025 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuJBJc/p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E136E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742692720; cv=none; b=OaHaJCCionsnz/jAhtMJqUwVbTJF4yDKia1HgrMN/z5YhnqxG9wKUPr7cBt7l0dieoLt3E+oPYKUgcSLrTh2V6VXB9q128KNXh/FoEc+di3LEgGWJ70iiw2JJ8AUiKOyXgvdB/I+Z4tF6Ju51MekJOX0MraSNh0YoXEzQ3i+AK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742692720; c=relaxed/simple;
	bh=2ky60IaXpGICg8HniI6ovJiS/QU8uC/lhyixFAte1sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3YnOuJ1hAjRSMHGGpbn8NN1RY6Ht4n/P/7dOTnXUpKhGK+lyEq7dLmUfSsE+0vbz+/5PoZ0v7ykSMhO6rRRvbXBwRotBgHyltJAWgd5PRmTxRpUMnNS4EL9y/1U0MOUWStp8jav7YaOUisb9T+9bSz2Fw9imXPiodjOaDN1GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuJBJc/p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MMZbxC005634
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 01:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2R9ezOTp2OXuwq2T5MuT2vKZ
	RZJiv8BpmQQIAHvkRRo=; b=fuJBJc/p1pME36ADkN25DN8/FvUuW4LGyR0BJfGw
	LkfBleFjuQmWhD3r/zLQxhZevo4KIET1dD+C2qwlXWstLq60ZJZe1UcKDJIq43L3
	CbzhVWK8TZ8GFc0blvX23vdn1TKDHrcS7vkFjFiw5H8mO7VlstReT98uuc+nBpJi
	xjoytF7/xSAbzpfbBlsjpvvIrZoK6zyJYbZivwCcOmxoSPCIXag7aj3djHnuS6IA
	GNHuEJ7oZVXqxDF68QuzHldLNY8Tx7cWhb4EjGuO2lbqa+xbjdioZdfGU/bvRc6U
	BgdttTafXS3rzpFRgTL+wxNRTAok9q0/ier+QJvHf1GFiQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyj9amr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 01:18:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767db0bae2so52786651cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 18:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742692716; x=1743297516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R9ezOTp2OXuwq2T5MuT2vKZRZJiv8BpmQQIAHvkRRo=;
        b=anK2liPC6OJQchLKCyC78x3kpPIXdZKFUUGIlZYVM85hYHdqmKh5y0MZV0NDb5C+ll
         a+RUnqtnZ7b4/oY02Vzvn/qVCSDVP6thCibF9NwMtAEDZSnZ6x38XBy2kZRq7wtVwgXP
         hSDBrhkZwTGDaRQBWvVU5htYny2mnYOgEP40JWxlYQZDoOXFSsu8tw5BAIoddiA6gjw4
         K5v8zeLOSMeGE2SHMYetgVagVRJaHF1qEKZElPmp0AlE4LfqzpKv2XrKBvvfXjf4vCpR
         xW7dKI+Z5qdHVzHSb6uVv4uz0uv16mkkn+7BusewshuDXfqqXqLZkOA/+Ph486bHoTf2
         2XVg==
X-Forwarded-Encrypted: i=1; AJvYcCVc19f61qPKRkaVWRv9kUDiHjp0Xue6LrJUgaWe+t29gQ7HvmtP0ReSNPTfi53v04lzFGlhN+d3eMHdd7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUW4PDJzwAKOoVzCxCaJx4Fc6F+Jcrj4p7tliR6HZ5+pbannc
	HwlsxXakLyjTOMAiYdrW5l7Ynq1mQsuL3SX+gkC21VJjnGdWy182p6pE+1y+C2tmKiO664CLLOO
	C+Y6PvPK/YRUcJg7X3AY/c9IKl8CWwXv3VGkqkGWfelLtevhm/ngMjH/xGyNfj/dOqDnMGJY=
X-Gm-Gg: ASbGncu7WrSWfBgPwp1h95EgoeW/QyfM+O9c+YZgDrGVID8CsuevkNs5eeLXiLI6o3A
	cg3C7GLm6fAlFpO2qHKSeS0yNtelbfULpod3faQRIVYM3OAI1xlVO31Dr4PTOchFPGHPMJZxu5R
	BbkIPGKODk7Jf+gw6q/GgsqzoDyQN0r0qJgiMzStn+8Kh8wKjyu6kKiszhZON5B65vwLa/lu1kj
	lukYqoVQh1QUEja4EM9fe8qXxbhGdN9GQLaysEp7SBQ+c43ETqjZcowxI8iEv2rSDATDX1g1VY+
	E7TJCjXEpZvITg5JwyPSAmDh3TYl0jyJJ8AwHQYaA0kS1mrIaAb2bLyrf4m53wsfS7O9T83Bw/H
	EqoI=
X-Received: by 2002:a05:622a:906:b0:476:a655:c4a2 with SMTP id d75a77b69052e-4771dd922e7mr125176681cf.22.1742692716021;
        Sat, 22 Mar 2025 18:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0/WAUbrypxHSD2MRLn7a/ohpYmGZD79AJWPxjbyAjULl0qmwkDIxxDUHGu7wO7VnkZgiMmw==
X-Received: by 2002:a05:622a:906:b0:476:a655:c4a2 with SMTP id d75a77b69052e-4771dd922e7mr125176401cf.22.1742692715594;
        Sat, 22 Mar 2025 18:18:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64685besm635531e87.33.2025.03.22.18.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 18:18:34 -0700 (PDT)
Date: Sun, 23 Mar 2025 03:18:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Drop fictional address_space_size
Message-ID: <tih7arhudjn2sotdvjddzncqi7nyx3xgsvnfi472ve7xcwhhqd@2nlrtoyymkfj>
References: <20250321185437.5890-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321185437.5890-1-robdclark@gmail.com>
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67df616e cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=qQjcqu3RhaNh0RZ1ZdMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 98uViE5GQ8RjlUOglxMTDL6_zvBvt-X1
X-Proofpoint-ORIG-GUID: 98uViE5GQ8RjlUOglxMTDL6_zvBvt-X1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_10,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=805 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230009

On Fri, Mar 21, 2025 at 11:54:37AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Really the only purpose of this was to limit the address space size to
> 4GB to avoid 32b rollover problems in 64b pointer math in older sqe fw.
> So replace the address_space_size with a quirk limiting the address
> space to 4GB.  In all other cases, use the SMMU input address size (IAS)
> to determine the address space size.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 33 +++++++++++------------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c   | 19 ++++++++++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  2 +-
>  3 files changed, 33 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

