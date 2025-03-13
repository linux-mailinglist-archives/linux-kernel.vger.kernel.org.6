Return-Path: <linux-kernel+bounces-560533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA4A6063C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B024C189E214
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34241F91FE;
	Thu, 13 Mar 2025 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPjRJhj4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A41F30C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910016; cv=none; b=bDbM0jb0SyCq7LpUy37XSHP1xAkG+55sw7hsk5j2jU2O99YqzSVymMXTYjWB0kXk1kBIMgMkEPmvM6pEhEBYKh5XVBCwOVs/dV3NLCBXZKFKkubUOWLZelsl3hbl9H5URfQ4AdtPu8eFDXVZbH2AmWTg6ApaQAgpJj4so+CYfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910016; c=relaxed/simple;
	bh=/WF7lCXlqMJQXcnRe/Nj0OUVnpD4zUFuEEAmeWVowgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivf4SYrZZtvzUWbTgRIl3o2EOucxWEHGv34l4Igiz8gjv7bb5Y06DCFdwKSLKrkRGB2eDSVPIhrEKJAeRAkuKRoYbXpDAXhcbOENriE/CZqQP+Db14+h7wPnVR62HYSqQvEKQTTTSQlhDQDD/dp9wBalDlpFUnG90frOEirLl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPjRJhj4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAhFmg019093
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1qHYlOfwaIa9F8NhGAepXYgOg3iVgKToWFIujHQr7Q=; b=RPjRJhj4i13DyISw
	zz5+4A/xR1gTJnoZrUKDpkGEAz1a929GrLPfOG0t5ajBs96ENsHjpaf/VtV9oCFj
	PjL2OKh0GXkehenNDE1/GbfhF6g8VqEd2n52DYKuajcz7WB/1MZpCRijGgLJtgtE
	sDiMD9iBrwj7cRVmGIx/Fx7QeKTjgmGlDRPSX/mDXnK9UZjPCIo6azdhpPNW+fXt
	C/PNF5GvyskW5GF82kpXmp6F0CDr61bZr1B9TAU3GhHvop4tIKmqiFrDMllI81PU
	xPxi2ywG+JJgOwJj+emdaZynXNzPokFVcuK+8LZflrQq89dHio+eZYbNu3/P1Zcb
	5jKXOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p7g8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:53:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff69646218so4052014a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910011; x=1742514811;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qHYlOfwaIa9F8NhGAepXYgOg3iVgKToWFIujHQr7Q=;
        b=bLuRLL3M42AuZhlyLW/MOfuEWbx46J3160CZnVzJNDi/wZHpY9ug9qw8PHJuOGNJPH
         aCqbWTX3INhA9aBPyfr6mQzPVZLh42396GuT9t+ugZ0O+falBaxpdQHj0yiVlFIbzYuD
         tRIrYfFbVzKB/ocWrq4TuRhbx0mZSoMuuC6tXesj1PRVDAvtmz6kfMdNA2gfgir00Mxo
         sR8SG0ODckn/Wshlk65kkrO9AMebmmLvQ8geS5/QcKbwyGSGlcdU3GNR3MQQJ0XEIJeV
         yd4gjLfAMcJdm9a2jD6ajkYnOAyIWGGn5sxQbdhV4JWzP73N4tJg3ZC76kKAXtqFzY3Q
         sK1g==
X-Forwarded-Encrypted: i=1; AJvYcCU4QDteZrmGbPtK+wcvMxpYu+xn38GQtH2zS2Kap+Jg+6qNL7is5suq+hjtg3f958UpfeZj1vgT5sAn48s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhn20aYMyFAwEVu2X2Fq2tOYa1JeUE1zQp4By9tV6ifczvGigh
	VlZzxJBR1HPZq98x0xaUmp88OM+72rVojQVhWvxt5N9f5HTl1cj9ln2WbxFODxzHoNovLo429eF
	xwV1YuVjJn6IDPU7ZPpqqV53+dDsGWf2ju/yN2RbYqycXz3zC8PAJ2vRzb4iWOf8=
X-Gm-Gg: ASbGncvXcjdk3BO9j06/szrSwlKZNVRWpOYBZvBdJ5a8iaVt61U28ghp8MLMRRbqZd0
	4qBMVWnI1toB+OXpdOKcI1VNmxF000Dlz0P3ALQF+UscJykVQLDi9fqOLfnoMz/mvFGoeu16b9U
	uFmLdZxRdC00943komemhUB7p9v9uIEAaga2VFSkuKlsRyUBrQX3G+aJ68wFMBqcLzqcT+SoEsq
	a6w9hezxK8rxie55VDTPTs1FovtZkA8RLU1S7/aLkl/LIliKOsoh0M+1dSzYRb1stajVtLrKNNY
	7pFI7Ou7GiHoj6BP8A1D3byET84IqKUuRuC5G+n6I8wuXk7s0Gcd9S8NbE/hSH4/yGwYzuL3h8d
	9OQntF++k
X-Received: by 2002:a05:6a21:328e:b0:1f5:8e94:2e7f with SMTP id adf61e73a8af0-1f5c12c790dmr698737637.33.1741910011164;
        Thu, 13 Mar 2025 16:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6b+l2sHUOM4fapHzw2f4ilNzLLFqdXS3SQzF+UQWAtBtRNPOP8tJRZpq6HKBejspqZR3Cw==
X-Received: by 2002:a05:6a21:328e:b0:1f5:8e94:2e7f with SMTP id adf61e73a8af0-1f5c12c790dmr698706637.33.1741910010801;
        Thu, 13 Mar 2025 16:53:30 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea0428fsm1864011a12.38.2025.03.13.16.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:53:30 -0700 (PDT)
Message-ID: <06a86ae9-6537-4d48-82d9-60fb7e123054@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:53:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] wifi: ath11k: add support for MHI bandwidth
 scaling
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d36ffc cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=DXIUzMgivY99M8N_Z1sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AJDH7vZEZo-2vMQ3jbVEzHQybpcr7wf4
X-Proofpoint-GUID: AJDH7vZEZo-2vMQ3jbVEzHQybpcr7wf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=857
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130182

On 3/13/2025 4:40 AM, Krishna Chaitanya Chundru wrote:
> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Add support for MHI bandwidth scaling, which will reduce power consumption
> if WLAN operates with lower bandwidth. This feature is only enabled for
> QCA6390.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Tested-on is not an official tag but an ath.git-specific tag, so it should be
separated from the official tags by a blank line

> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

your S-O-B needs to be added

/jeff

