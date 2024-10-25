Return-Path: <linux-kernel+bounces-381294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B589AFD43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701161F23021
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F91D2F6D;
	Fri, 25 Oct 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkf1xS6N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28B1D1F5A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846471; cv=none; b=eis7w+cy+hJuqXPw5BxItXU0GzeXLvoMpItVvk5pPuaTrGTnUPpCFh3OGcVf5X0mZbHNXB6bNQgBdevZVxQjFc4P2L/IeQU3OZ7YuuF7ej2zCmNofKvgowOwNKczklKf07VtkwI6EtH3tCWyT6CE/B/0qKumLuDy2ha9Wtg0Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846471; c=relaxed/simple;
	bh=F39ZcLvXtrXQq6xnL082hnDbi6fUu0vK/sa3ozS6hS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhKlfoZsZSdV3Tds7qRAYy0auimMaOgwtKXmiZVO8+M+/U186CJXojwKtwQXHLf5dj657QmedZgDqtG831ZmygUoPCn6Idiq4msnRUlkrT82fVNuQYlRyb5h8kQX8muP6CdBwM6bOjQF5tLDtSVLewj/dXWZpdcb3SEEh7g0LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkf1xS6N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OLfGq1000978
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzIil6qFlRjjpzK1jMma5ZZA8ZWxhvhCfcYPxJNtsA8=; b=gkf1xS6NesDVM5bP
	W9DCfohRGkPU144YScM+sdyoM7Tgwihh59MsUoyHg3/MnFxSKTIhc9uQir8MBliD
	Lk+jiTIoKyUQUFAK1WWvWIAknzb6v0IYZR0w3BhQcXTjNbD6TguUDCxRhH6rhv5e
	FLPEOCYFdsvGAjMIRbXadXLgfAMo+DGv94PaRG4nsDsnhoZH7mCSCJxBZNGLWA+6
	SpSvBb35TLCqr0VnTB7XS701xLGlkIRxgOTkBqG/E67MDI3GaNAIJ6bwrDcQHg1E
	6Jy7W7nFXuH6oamFPLsu8Z/xDzErWm3zRhAPDBl33MqGxQtpeuOCjyR7GSYBgCZa
	Xn9qnQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w0d50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:54:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbf4770c18so5616886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846467; x=1730451267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzIil6qFlRjjpzK1jMma5ZZA8ZWxhvhCfcYPxJNtsA8=;
        b=JnUWvOIrMd8mEjHvnDPOc0E9HHOwBg23Xsh2xWGgdlhXWH0ApiDTlRWYW1SrZm0eh+
         A+YyYGO5Jom8stQrmYeTIYD2z9tdUpSHIqHTNU9yRSk3Ick2oAcs2eCRGoKG7D0eByUa
         rpW0fw6vrMjRoB9GD8c4+ygU8vUWJETP1ecVN4CNyWyvBSUQoMu0UMYwwp8hXzU8xIzG
         hmaWtberADT2w4t2PoBesxea5d8Yj8pTDSsr7nOxkqmPYnRFxTBqYzp+ucS02Q/CvH37
         av6TlXKnfwCEITu56+n+henCt3PKPH7cIL08WRTdfTCVdtXq/OxQiwUD+zOZ30HvQqGz
         Z48A==
X-Forwarded-Encrypted: i=1; AJvYcCUqRd18TwIoMiycmGIlfz8kX0jh4bC9KLhFJzu9a2KS3eLmqSxfQ0o4DS1TvzqTIxF+h9ESwZFdWBxOO2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDBAwvvOIKExfp/CqBZ8Q5ipgwkG8SaBrgJmeV4AaS98T2GEr
	xSlgwETkbzY6QUPcExUozGMpfO9hLOmYOlzVeBY+du8k2FXSETK3NdDk/hG6pYB0Qwo72wZ2/Ju
	Z6K2E+L/zKu5szv3mDBqxIRBzQMgoUq9ELPvMDiEhZAAQJKT3PUQY/UTmsUyWlNE=
X-Received: by 2002:a05:6214:48c:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6d17de3fd61mr2577706d6.12.1729846467412;
        Fri, 25 Oct 2024 01:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIR6lMzjpcEIUrXzldpvhx4X5xa7xYLFjRv6/LmmEJwnQTFE0E+j9TgGk/kA03pNKojhY29A==
X-Received: by 2002:a05:6214:48c:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6d17de3fd61mr2577616d6.12.1729846467040;
        Fri, 25 Oct 2024 01:54:27 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b307b53fcsm45295666b.148.2024.10.25.01.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 01:54:26 -0700 (PDT)
Message-ID: <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 10:54:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
To: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025030732.29743-5-quic_qqzhou@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Hg-2FT72kKZCIGkWVegcRz49D-1XdPVr
X-Proofpoint-ORIG-GUID: Hg-2FT72kKZCIGkWVegcRz49D-1XdPVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=738 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250068

On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> to limit DMA address range to 36bit width to align with system
> architecture.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---

You probably also want to mark it `dma-coherent` (see e.g.
x1e80100.dtsi)

Konrad

