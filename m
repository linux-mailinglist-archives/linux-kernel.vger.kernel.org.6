Return-Path: <linux-kernel+bounces-569411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D577CA6A28E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46023427B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211020E32B;
	Thu, 20 Mar 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5x807F8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383F221F13
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462827; cv=none; b=ZKzt7onClW9E3ylejeKtNgXymghcMZ2pVD2HKsORPR3RAExEioFhhlklu1oevfA3j+dAMoWp8oj08JHt4ocoGrT4FuaROprb8tZ21LWTdwsa6r5cGONGItQmtZ6PU0YpGqJqxjxIRRFzeTl2H95T5Q4M/QNajB9mkqAlJAa9AUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462827; c=relaxed/simple;
	bh=mrIgqAV+mMUyUP/4WfFZ09+R9paw1POvDo6IZ7RuEiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WEejLAVvk11kSW8PlKPZ28ARzysiNuEPP+dsC34UfkqGh5tNlryB1xMPbctvpbyl+D9JVOQMODH3a7GiP1KmjdKZiEiGDo6Jbef2t7GWJc2MAILvghHJQzyWdouBazedUaUrqteAeFmZeVN+hUmTIVhIDJ3T/xEniSKyv7/U5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5x807F8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z4ml009408
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KeHYHgSRoKLBQR4ChNEg2+DinjKOYoT9p2BUm9bLAEs=; b=h5x807F85KZGcI2T
	FEZ0TjAXf69j6bFfIU6NNTZUjv21ZQ2L/T9prIY//EHR/rvtCYhqjhTuX5n37bfE
	DMZn/HQach8XeyUvDVvF/kkF2igdsUw91pRZ5P13PAdoVCj3zZZmec/Tp5AgWVLr
	hmTOXVx/aH5wUokc5RPVWgflIJMmARFFIvxYrGkKqrs4p31gGfcnKkQyH/zRxRbk
	2G/uey3LIwRgVlt001dOnDPUCYx51MaI1fx/KZFp0vhYFY3Ina8O1K/qhCBX08xI
	+nuV/uTQbyZS865BPWfdf+5Ea6X2PCHs8ENUf6uA1HQZmgeIz21yttvBKnKirLO3
	EPKywg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx88ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:27:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso883284a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742462824; x=1743067624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeHYHgSRoKLBQR4ChNEg2+DinjKOYoT9p2BUm9bLAEs=;
        b=LkbcoE+iMFvwUmh4/dxV6U5Q0KoHr2NDZB0xX03UKrIoDdVNkJzXBfjVuq3fryYWvg
         aa8SOBiM7LAylm49KEA+cteu5Ytl3fFiUG/JpbutQnY/C2yiOWLL//2VO/BA+4VADC+2
         kW5tB2TdjedcD5D0rWIU23Agu4DaRhCrRaqS3NGTrqqrvrKuVp3MWXZR4SSaEB3/CeZB
         mGEIAlnR0NqLxulYTMMLTp5DgDIfB9BUgBtJLkNbIj0ucJA51cHSMY2Z9khdYerADCwA
         a6spEXlA5GrzEpNMfnJxNRZuppQ9QstiTj0I5UkdtBzAgme61KCu2N5vYRyjFYoSrFxn
         PA+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8HXQcFadII/PN7rvrB7Mg/4h/FHkDxuZV2+Kh8pzNhd6s+HnLrUaWebYTRnZy22qVcj7I+fjMX9g8tpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRA6RixKxwjdh982BJPtXpOv0GlsIDAIY/JLCjcwY5fSZ4KSA
	hwKwNnTrp7Zh5i5iQjeUr0tW1BJFj6iey2Ytya5C9qFLGEt3lvlSlWEtK4kt2uMub8AN6XN2pjR
	aDsGwg1blNYleITrxKLs5MVAwZrcgPlzdUxuCK3Z6YHgEr4f2Qc2ObFoSUGl4lM8=
X-Gm-Gg: ASbGncu8nLBy4y5N3Ihqa8k66bWi4WnCUFa13D/dw4lGaQgmzQ6kZLHnjzhiT+QSyba
	DUX8MRhvJpFvuE++DR4zrFAmoW2hDqGtjQQ0/VxB8ZgwClBPIdhQkV/qhMjRK72NjzeqG89fRj5
	A0eeM7x2n0qmf3goBnMgBsV5GsGhvRLaZCiDFb90+On74nuLRozsvS64wjUREpKMzYm3hO2xJuz
	onNsPrmw+agjFqzUPXeJaSibVMd1RhmgKiQXcOtz01F1BPDi4K0QSXmEuAd4oL8jmGp0tOcHTPn
	8lpNNW75V8nHatI8i5NTSYsd8vF1tCgpkf5DdYsQ
X-Received: by 2002:a17:90b:35c3:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-301d52c9d71mr3683770a91.21.1742462823701;
        Thu, 20 Mar 2025 02:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpGvrH1EWOiqoFrxiYDGBjxuwdnasSg3FLzSkenBU4hTM8xFgoe/Rl+VzdbYGqcHraNoYMgw==
X-Received: by 2002:a17:90b:35c3:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-301d52c9d71mr3683748a91.21.1742462823281;
        Thu, 20 Mar 2025 02:27:03 -0700 (PDT)
Received: from [10.204.65.49] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf575936sm3312292a91.4.2025.03.20.02.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 02:27:02 -0700 (PDT)
Message-ID: <09a4e15b-d951-48c9-9aeb-103b6b293a97@oss.qualcomm.com>
Date: Thu, 20 Mar 2025 14:56:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250320091446.3647918-3-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: noIBbQcmFstkXn0dJnCwk_Hgpe2TxupL
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67dbdf68 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=98RdHtkJ8WjIMYe7nFEA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: noIBbQcmFstkXn0dJnCwk_Hgpe2TxupL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200056



On 3/20/2025 2:44 PM, Ling Xu wrote:
> The fastrpc driver has support for 5 types of remoteprocs. There are
> some products which support GPDSP remoteprocs. Add changes to support
> GPDSP remoteprocs.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
>  struct fastrpc_phy_page {
>  	u64 addr;		/* physical address */
>  	u64 size;		/* size of contiguous region */
> @@ -2338,6 +2342,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case CDSP1_DOMAIN_ID:
> +	case GDSP0_DOMAIN_ID:
> +	case GDSP1_DOMAIN_ID:

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Thanks,
Ekansh

>  		data->unsigned_support = true;
>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>  		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);


