Return-Path: <linux-kernel+bounces-567285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1FA68427
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FD017244B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9924EA9D;
	Wed, 19 Mar 2025 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djqIU74c"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96877BA3D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742357831; cv=none; b=PDFjs645PXa5gW3JmbGIZFeumAf9bvCSfIs7+VRIpKHPa5LvpMle65IFVwNSMHAPPIHQoiXBfQP7HXKqs5hduObSQU+un16hT8ISCg3uIGimRggnVW1ABYHDPKGeJ/2B9hI2M0uh7s7Z0uCMvqpswmZHmDTPtYPBKyQCVHS+Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742357831; c=relaxed/simple;
	bh=qZN1BAH0i4cCOVb1K3r1yUu2wfYtbm7OV3dX+n3+X2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJBmP+n97cNORS4EB75bmcrpKAu5qcsds8HgM0eRFCKihatp77i7UkeOyJYpq5Y9QeorUUCanrqbEGVk2+4qWPOEFMuLZEsFtALLfTFcwHfuh8pvZ39wyb1YyYOzPlUGFiLoSbeB0aThlpOsTD0A2STkBG6+H5mKEBCE6LID2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djqIU74c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIBODN005152
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hjpICs2XfxuOUVdumFWXYVzyYb5hofcnf4+bty8z/OY=; b=djqIU74cfcSftdds
	xbzM3KRDIb47bGntZJY268Xh8LFqUacc3OFuiiGvoouggEwOt1azYazyk8QmDKJw
	GunOzm8ur6U/EVHrWS+qAewZU3oVc42/gBy9EnqiAxJ3QsPMjHJPdTN4xIoW6xXD
	g8y0Y5Wzk+B5Vr0ZmCBDw3CCgiPrsf9Ry234pl5EHiswIR6SrV+owiCDWbeVC8P4
	kv1kUUhKHIt+VjQdBHWSCRlUImVjr9tdZdsV4QJ52NyfyBDjUa+rKM5hKuebYJs/
	8ylVLmiXKmlgnRQH3Q8BTYUD6FnwTvkj9rQQErM4Z7X/M2OBOOFu1B2xTUZscmJA
	QP6Tkw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdvxh629-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:17:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so11062692a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742357827; x=1742962627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjpICs2XfxuOUVdumFWXYVzyYb5hofcnf4+bty8z/OY=;
        b=g+U1p/fl1TJBm83z4KSC4l5IPYkX5X3gQOcWzeeHnfU8LKTJc9ML0aTQlZNIYxPqah
         6t8Wjq0eJcXThpfAsTvpH62XLMF6nvA3vXDY/5lE35SF+E0aPTIG1T/4XVBWFpQu5U95
         hQ7r7yJhryIIha9kyh+S1LFidFNiiJW+9Bc22wv238MqKyJPisIkorUD33Sift1kgri7
         XfxncR2tqJBi+Nhyglc36VQe4qZDm2nhB8/toT7NpfR+rSIRfe45t6njjq32w/noYCHX
         SG0ry2LoBEnrrN5BhmAssYw+Y5vFpzNgAd5VaNuC08dzSYYBaOHadfC4ZD0cn4CfOP2g
         kK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKZfqPKjimN07tIUPvbEy0HPmIxhMl1iBznn8RdT0QpI78qbqLqKz/PZQ7hIV6whO0ZnbuQw2p9ofGKsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksVVTaV3nUg8wKcHRk5jirMERxS95dqwg3nYmmZfu76FMUnjX
	h/Zq0c2nQCI3td90iV5xhpQklEgseoi7cYFy1f78o68OkSk34kZJeTSmLgzZq1SrDLNettkvrnL
	CLGUUXs3qKBYo5itkt1AnPhMF36+rmHxYbYuZ4g9ZXJDFqQWdkdQIt1MwNk3/G54=
X-Gm-Gg: ASbGncvfhvfrP2OPZSqi7bzDsh7dtmhNcTxBo8QWeHk2BiY1XDhpDesVxZeFWHYI3+f
	yXDoHssRnqxmTWfnxFz4YHuF0F8RmlP7m5fDdaXP5H/5dFqBfNQmpnCN+n8sfDP49Mz8xxW8SQJ
	oClVXOecRPVvmrgcAnWWbITfqgBDpt6vvbnvocgT16nWkCNotVYVJbXpdplOfvJBDfC7RuBaqmT
	xaE77z3lw3oNosexRNSoWl3TzNg29kmf7KDf0JU+CPFVkxA/MGagIeki2upVlS1qPxvWCf10mBz
	KHt+8QlVMzfUubp1Kco4OhmtfoWKkeZq5BN1wcDDaspbEoEx7JabTgOL
X-Received: by 2002:a17:90a:dfc8:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-301bde5fc40mr1788283a91.9.1742357826934;
        Tue, 18 Mar 2025 21:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwNKEYllphJN6ZLzsFCOike+d+DjF4hTYhMKZH09eLwIENTWzQC3Jrz0zHXUmOsOC4gRN+0Q==
X-Received: by 2002:a17:90a:dfc8:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-301bde5fc40mr1788249a91.9.1742357826539;
        Tue, 18 Mar 2025 21:17:06 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885acsm103557585ad.32.2025.03.18.21.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:17:05 -0700 (PDT)
Message-ID: <43eec351-4e1b-492f-8717-be2c479edf43@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 09:47:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq5424: fix and relocate uart1 gpio
 configurations
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250318064939.3638381-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250318064939.3638381-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=67da4544 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LlwDK8VgIywOn4IyDEAA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 33IQ5BDVpiddv7RJDKhuMAG0CiAYMyb8
X-Proofpoint-GUID: 33IQ5BDVpiddv7RJDKhuMAG0CiAYMyb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=724 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190026


On 3/18/2025 12:19 PM, Manikanta Mylavarapu wrote:
> Update the bias configuration for UART1 TX and RX pins to ensure correct
> settings for RDP466.
>
> Additionally, move the UART1 GPIO configurations from the common .dtsi
> file to the RDP-specific .dts files to account for differing bias
> configurations across RDPs of IPQ5424.
>
> Fixes: 1a91d2a6021e ("arm64: dts: qcom: add IPQ5424 SoC and rdp466 board support")
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>

