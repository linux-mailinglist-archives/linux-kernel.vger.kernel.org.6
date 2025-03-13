Return-Path: <linux-kernel+bounces-559707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A9A5F864
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7674117ED73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916426A1A1;
	Thu, 13 Mar 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ju7BUlzC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043C26A0DB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876243; cv=none; b=mstRgA1M3HjJ4hxLzR0K4HuIsnjadCNVHAi1JzjBn5a40oYJ58zjSpTvAv4WRSbXbodql1DMFNoQaxS/UIcnQ/yADOH+0nr1D+GVfSbSLpQ2ydM2Br23bfx+o3fIIVsp8MliGZmJsfNYPSxZSqIE9up5ABfe2upvQtg9eGZ4Luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876243; c=relaxed/simple;
	bh=kzt33hJsTa85KuEVyT53fPaWcVDArcEY6RG1XvTBeAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtixm2nvP8AhP2Ug2Rfx7lKosvWm/yd1I7M6ap5HOJhNJoViux4kcb1Gm+x77q3Rsbb8UT2NezTXBF6csZfO2rphkStD/SuirsRq8ST8FaFnnSlOk0KRBSJzVDukh4HQayJMonnbUdNXXUzpyTFVrep15+DrVxc7v6HZUEsdBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ju7BUlzC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAUBg4020069
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JHUDmC4PTSFYAcWgaACKX1N5/pWQOKndXgV5ZuGvDLc=; b=ju7BUlzCln+YLfMy
	kdWXxUplQuGwkchYliq91VG/zEC2L20ojpqBGdIC36R6pUF3od3KUsdXY5vyKDSj
	QtDeTHqzqpAh7/qyWGnMbPnUyg9iYvIL9KVT5njNA4IVHul4nuR0vGEHDrMYnIIM
	WdoqiHIIjl/Yrv1iYl5CWZAlF//x1PmnAC2WX8n6ZHHvE6qQ2/meMkZ7rjeW83Gh
	mybOs+DSAlmlOjbMVxoloQoGO5V7OJgAmTMzD25rVCkyIzvlXur9Jdw8qX73mDY9
	64i6WXRPuuNeeprpab06KNhC4TWIeYh74ebIhTRLYoXhLz1D7KsHMxcZbDfRESNG
	TccUjg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p66g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:30:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f3c21043so3130096d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876239; x=1742481039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHUDmC4PTSFYAcWgaACKX1N5/pWQOKndXgV5ZuGvDLc=;
        b=J67VYiEBd5PwxZHhsO3Mnkn7hNIGrLCBGh60Zwa2xWK2LwLMFlaETetxkXlOKy11A5
         HJ8bN5k60VAwhP6igbN3H8RN0ctBh7Os7/bjEULJUWxDIBUXHcD83EoG/oKh3U5NDH1m
         zdlzcBSOGA6XRJhNVK9SIElqBvitDL9WWNHeQxxTgPOlhc8wapL6AalH/i6Rli6SNHrB
         oV/FBgsUih251ipfw6xeLptgdV+kaJ3tm7VpC1WaG/m6ieVWp3033+gdoUpdmy2oJYjJ
         GMDRGtn2HFCeMTCk2fz1MHad7j+KO2LeG8iiD6myFlpSRGTxoVqK2pmrnkgc9WmiYW0C
         N+hg==
X-Forwarded-Encrypted: i=1; AJvYcCUIMo38LIfHJR2eqEqy/UiadY7NfH2aD1EP/2VLS3mqY/i6Vv82QAtVpoAxdwHN4t9lcnaN5mREOUR1vzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9PDQmiy0t6VZJI6bUbr7JDQry4u6lt4am0EwZOgplFafdYBE
	Je0huKxUwjvbVO6V1ExpVh2iof1YKrDJmV/q83vD8s7ixNu7DEcLhYtk7WD5EKbO8+hsFKfPdEt
	MsAFAVXFi8GlCH/I/9sQRz/69BBA5W7OhoxxsBOv56kbdU1b5yS8hIuaV9kFm9ic=
X-Gm-Gg: ASbGncsW5XertDcr+dWmdMsolB9pdr3Wqa8HwqJ+ax9QSl2IIZ4cpgnOxeW5CE0W7rf
	7KdjeLNcYFzQDgurqh7+O1j+KKGRuu7naB5glq3IOpVeN5GuCORGWaCLotLeYL1EIuJ7n1O0Xsp
	U4/tiEJtKnubSrCHozMDkMYZ5XSR9EFXjf7ehYuv4RdeCymL4HDE4Hgx+ftO2PgCZoHCGq1S7Mt
	SS/gSvW700VM5CV0r9UaRut8oYkus3fyQuNnZJINAoce41sp/RsW9SFop1L0GyvLKJUS5Ga6U6a
	LVJ7IFFFnfTOiTcodU+6W8ONIyNg4tJANGh/iD+VutXAzf6bXK13zz0vWvWdSKVjcNzIUw==
X-Received: by 2002:a05:620a:40d1:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7c56fee175emr285585685a.3.1741876239688;
        Thu, 13 Mar 2025 07:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGew7PamKyiAcrPgUIZlCIP2W0SkL4/r8o51tM8nCHDl5YMpcw4o7WNySRMHlagbq/nm3aG7w==
X-Received: by 2002:a05:620a:40d1:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7c56fee175emr285583085a.3.1741876239273;
        Thu, 13 Mar 2025 07:30:39 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf25csm85386166b.113.2025.03.13.07.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:30:38 -0700 (PDT)
Message-ID: <07957f72-ce7e-41f7-8ea8-5839a33f04a3@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 15:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Enable QPIC BAM and QPIC NAND support for SDX75
To: Kaushal Kumar <quic_kaushalk@quicinc.com>, vkoul@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andersson@kernel.org,
        konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d2ec10 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=puiEX6dKtv1lSrn3j0sA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ePHrJquKTqpJiM-qua0bbcphTZvG9CKd
X-Proofpoint-GUID: ePHrJquKTqpJiM-qua0bbcphTZvG9CKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=741
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130113

On 3/13/25 2:09 PM, Kaushal Kumar wrote:
> Hello,
> 
> This series adds and enables devicetree nodes for QPIC BAM
> and QPIC NAND for Qualcomm SDX75 platform.
> 
> This patch series depends on the below patches:
> https://lore.kernel.org/linux-spi/20250310120906.1577292-5-quic_mdalam@quicinc.com/T/
> 
> Kaushal Kumar (6):
>   dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND
>   dt-bindings: dma: qcom,bam: Document dma-coherent property
>   ARM: dts: qcom: sdx75: Add QPIC BAM support
>   ARM: dts: qcom: sdx75: Add QPIC NAND support
>   ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
>   ARM: dts: qcom: sdx75-idp: Enable QPIC NAND support

subjects: sdx75 is arm64 and the prefix in that dir is:

arm64: dts: qcom: <soc/board>: foo

Konrad

