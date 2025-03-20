Return-Path: <linux-kernel+bounces-569491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5BA6A3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22049188579E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66A224253;
	Thu, 20 Mar 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4cj1sGn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CC209F5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466526; cv=none; b=pvPf6EPo5A7cj3D1r+8dEyLh2w8cVz+ZcnQn4E8UAXyKAKnoGs7iXUplTE5gC7pAuRt9lKHqtCaf/O5VANMN7RdXT/v49VL8EtToyrFCdthQiFVdTitv1tk6Bc4apt4MBRcbWe8kBxGe0sVIncXILzeuAxMOSnty+6KyLDMhexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466526; c=relaxed/simple;
	bh=uKLOxDij7c7sdT8Zk1Ksoy8JUZVDpgomJWrglxeAbhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9cGOCIkW3qxwiIUmgMSUy0ZUz0TKAKGLZCVm4kEkSfy4QpDhYQm61kP4CCL/tbnGIaNg0va62cmD4O2ZS32/yI+9FbzyLUmyBZAmhH/imvaUgAFePQBRhQZWSHkUF3Yu9EyuVbPCaLbugborGzTwHer9zRHUea/G5w8hBzvCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h4cj1sGn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z4bv005861
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7JCFxJENGct7M1n7Kf+6tvuHHB4HK4sMdAZpytvjcM=; b=h4cj1sGnX3jHFcpd
	Y/V7raEGTWPOS9mM35u/HRsKdiQTSCVklabyqD8TAGASorLC+Dg1/kC44VeoObuQ
	vDLZBz20Ebgb3lwitOAHGVcYqT88UgSNgqw8eZarU4esArZwCnGaDKzo7CZA5hRt
	GQRjwY4CulEsIhndQBRBwQlRUS1ImEgfHZ+YOgInELBwT7jU68wChIwYqHbHXQKH
	Do/nW565edG7cVdUXf0KdnxebtOsFkoVNQTmy1Hnq78DOVMX7SPuLg6i8CQS/5n3
	OsDhKN2gGzMW0351kW1ex3uvoxkNkhg0Z3RWvKfJ1Q1o+so5hrQdv0Qoxi2WuZTY
	Tc76Aw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmc157f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:28:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ead1d6fd54so1003786d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466522; x=1743071322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7JCFxJENGct7M1n7Kf+6tvuHHB4HK4sMdAZpytvjcM=;
        b=ktSrOG20Nynn+04hCnepNXcyO5hBG0rYwjMuYaum3J/IQ2B8O8s+fc128bGutcIf91
         tdOJrwn3VVqGITNeAJH3XeXw+aelA4Ex2+toEEJ6WH8F/0Wvrwgensq7hKNMljDHcKuF
         Ge9QtySai2S19aM3LJpGrx6POUISZJHlpimodGrHtuujvjzrexmNktCUl4UtSeQOAbDN
         mhlhBGhYtZu1TTzDb/f7l3yfP81DWRABaLYXPpGfJbKW5SjHWX2zwnuY9TIKCBpeWL9L
         OKu/Wa2FlajNbO9hWoH0K3ol49fWkJNfRrn/pykNLpnjzLr6V4eDG0euoBF8T+DbBKJ2
         UJog==
X-Forwarded-Encrypted: i=1; AJvYcCXyZWFZr7W3Q2WyNHX5hHXrRJ32fVx1WhhR1+A7P3tI7ldi/Bxx3nemh0Jf2Uv3tJ+CfF1is9PyaGtoK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtlVfEUIOUs3MHxg8ygX7lBsloAj0Kelk1/pMM4stqCqfOtJH
	rr17H92lUcvocaaSbBAdnbt1rMazbehT0vUPfNK9S0FniuwG0h2OFC0PDEsNsQ+oAxJtmlOCcpN
	BqCP4EzMr7Gh6GQwhDlRiPQb+HZHzq/N6R7z9YgBnosJJKvddLQENBD9uvKuxCcY=
X-Gm-Gg: ASbGncuKLwQ/IKnB9uSQUITYO5CveIGOYrgOYThPc1bpDYeL9jxjoRj1khgSoX+DKz/
	dYWk/YqvkDrSIyWCGfGBQRTi//8j23cG7ZntbxQVv5ki1gsBVjc3x8lsBqxOOGKqcRdZ7K5r0Uf
	wLRg6Y3XPDtAxeQYqRXnjvOzmqdxekENfbRNXg65Xfl4IO0riAVqtYNLxz1y2MtNxUkpmOsyXzR
	2eJjJ4qnHzGyYaidm2olwVNuoAqBE9gcsRmpfA9k7UPy7YdRL1cJuVGHgZTRyTWRRVy4tz59AAk
	X7dAdOLxPiZxpvRNrAH800J4fE1B6B0R5r+vKfcaWjLEr1OvBvv2CrSX/vlqOKWoGuOJUQ==
X-Received: by 2002:a05:6214:23cd:b0:6e6:62fb:3504 with SMTP id 6a1803df08f44-6eb2ba0c59cmr29712156d6.8.1742466522650;
        Thu, 20 Mar 2025 03:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDiGX/C/TqtQC7A30JrTt6Srt5dzpSfvmRqIWtJNoV+GAAS2k4SYx2YUt3qrXWOs29AJnUw==
X-Received: by 2002:a05:6214:23cd:b0:6e6:62fb:3504 with SMTP id 6a1803df08f44-6eb2ba0c59cmr29711986d6.8.1742466522225;
        Thu, 20 Mar 2025 03:28:42 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce9a9sm1138534066b.110.2025.03.20.03.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:28:41 -0700 (PDT)
Message-ID: <3b4c816d-d7e7-4029-917d-f519a75149d6@oss.qualcomm.com>
Date: Thu, 20 Mar 2025 11:28:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: fastrpc: add support for gpdsp remoteproc
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250320051645.2254904-1-quic_lxu5@quicinc.com>
 <20250320051645.2254904-3-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250320051645.2254904-3-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VFaKyAHNrQ_z42PLiGz6gdv-M8egvj2a
X-Proofpoint-GUID: VFaKyAHNrQ_z42PLiGz6gdv-M8egvj2a
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67dbeddb cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=0IcnB8eo5JocWn4U3IUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200064

On 3/20/25 6:16 AM, Ling Xu wrote:
> The fastrpc driver has support for 5 types of remoteprocs. There are
> some products which support GPDSP remoteprocs. Add changes to support
> GPDSP remoteprocs.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7b7a22c91fe4..80aa554b3042 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -28,7 +28,9 @@
>  #define SDSP_DOMAIN_ID (2)
>  #define CDSP_DOMAIN_ID (3)
>  #define CDSP1_DOMAIN_ID (4)
> -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
> +#define GDSP0_DOMAIN_ID (5)
> +#define GDSP1_DOMAIN_ID (6)
> +#define FASTRPC_DEV_MAX		7 /* adsp, mdsp, slpi, cdsp, cdsp1, gdsp0, gdsp1 */

This sounds like a good enum candidate

>  #define FASTRPC_MAX_SESSIONS	14
>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
> @@ -107,7 +109,9 @@
>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>  
>  static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> -						"sdsp", "cdsp", "cdsp1" };
> +						"sdsp", "cdsp",
> +						"cdsp1", "gdsp0",
> +						"gdsp1" };

And this could become

*domains[FASTRPC_DEV_MAX] = {
	...
	[CDSP_DOMAIN_ID] = "cdsp"
	...
};

etc.

Konrad

