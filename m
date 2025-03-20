Return-Path: <linux-kernel+bounces-569559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE62A6A49E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503FC8A8123
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B880021CC5D;
	Thu, 20 Mar 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1vz7mQj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BF21C9FE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469298; cv=none; b=d9QgjwxiBNsKIDBqZ/ASaTlqdslCOwz2bIZTmhGsUz4wqj3BuR9VNbng4TDgnDP3DXG7IY73aRGtIK9zgB29B4K7CRWrDuxK5I7l+G3dmCx6vgfqRbxK3SsMn3hxuJJGma7OOM+rX0fPeZ0m5u42ZquECEd0up/r/mSDZko7rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469298; c=relaxed/simple;
	bh=KlHQ/WFnkGjmsqgep/V6ueRLG3RRI5gfdfEkHx5aY+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au8nOyT+Wa2LcX0KEWZpAwV8h7ZYY/tLnfJbaXHBDfzVU4xqzoI0ZKcEciiKtN3kV3NbYSNDMrsl9SO+0ldCoACOK1qap7xAnA9SdOf6LXv7hLDu5HoQEogAxhXMi/pYuPun1RjJ+fv7LvR414sM77dkOOM9fPUgs+PqAO0TpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1vz7mQj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z13w014468
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CphREDIqT3X+IPjX/cFD5C2t
	2uq9/2FWUbiQkv6xqKk=; b=Z1vz7mQjo0Un0ItYPnUmKcpxEmOMhvwUPHux9/HE
	4pjyCKfZ0bo5JF5jNM9sprCe+y3uJsquBFzo1JBRygHdRKH8LqzLkxz/wFukmAMn
	9sn9wcP4vVg6hkGaZVotIZhxFb7s9NCb+/UmXmnh4oN1/827Bb/Mn97vs0M3X6Xk
	STt3CMLuVWgTcqRm7bRftbjJSQPhvoF+sqlPnQ3inDMoyMnJKtwrWxGwSYwXPMAE
	ClrNVYp0ovXetJZGe2WBxufw2eR+ORTGD0dJLuwioNsu+HsvrEbMhe+XbxuO9v6Q
	vfZJyJGR2cGjBNZlxPcJkp8ZKhsOhbfn/dKv1Y4VmNQC8Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtrwhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:14:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c546efca59so199849785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469293; x=1743074093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CphREDIqT3X+IPjX/cFD5C2t2uq9/2FWUbiQkv6xqKk=;
        b=CUOQFf8B/uq83X+TEsfRrToH6km1ogSk2i1FV0n5YDRDzQC8VO15XLUBMN+EFudxCh
         vjFcq2JepQ/IKhJaM2fI7EZ9uCaF5t+9kmPATR3yyC2ZFRznHy0vyd+Plj7ZEI1RXUNl
         ByS4ALbwKjQvXZLTxL5lAtk3lVV4GIW+WIYwXCzc06YceakHhLSFhjV12sGUX21GLK+Q
         Ngu7yWoDzeRGuPHDY91WZrxrhCRAmKIc5kDmx4RiQ2dkXm+VTlyk8mMzHuv9uaggRzQX
         WX5WSc3ILsho/w9u3n8fi7f86X70suW+Oyz13hVpM8PJi/K10Ru7I1WcJ0uddsAQSXv/
         r/qw==
X-Forwarded-Encrypted: i=1; AJvYcCV7N011p460YxC+q3tYQfmBPSd7CijD+aLeFHEO/FNwVyGfR7ZhZ+Q1aF8zvcaWn+rd8chi4pxfxOVReVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcpOOv9Py/cWQxucYjaUXsU+ylMbkNcyXfbaYaiQyYc6a/f1U
	1ktUGY+JLtqDTz7pBatGpOaR4ZERRecodlcb8XBlcVbKyki270zWJ90PWTW9IOumBA0d7DStV/9
	WpQDojPEL/PaRySClG0/PsJetqE6f78Z0u4TlcCfGrOq4Qj29XKR6P/tiHs3Qooc=
X-Gm-Gg: ASbGncvYa4e9ZsVuKuUzBwDVRV4hUbzifLhXfdV6TxM+YzhX63FepGSXF7zS0ZFwbtF
	S9ex4GWyLFrMY5QhO0/PjZkRTUiqgulxvOshNBajmLiWrGwBfFnB+aL4fXqNSBQnZOUds1G55es
	MiwDw4nyn9+P9qewapFDrQ9gI10gmogOxAXjmok88mwPNP4UANVaYYPXU7o/oKDUsPIXwV3agTH
	Z6+J0SnEg4At2Y88cCQ/Hiu5xE7T0Mcg4hl+m9dYKh6koiabFT3J/KIxTykOgcGvxORWr8weMmR
	LSzbRYghK0/6G05g8infO+pYlsEI5JAr5PRyDmAAFvNN+aAL/f9J0t9wHugdqPDzNKfNwwPcoLM
	mCbY=
X-Received: by 2002:a05:620a:46a1:b0:7c5:5339:48cf with SMTP id af79cd13be357-7c5a83d3f7amr778271585a.30.1742469293278;
        Thu, 20 Mar 2025 04:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMbzGxGL+jwpf9q91HSRSqez6HkMOjgloJv545KGKYFtz6HFDw01gcoqjAgGPrCIiuIhR30w==
X-Received: by 2002:a05:620a:46a1:b0:7c5:5339:48cf with SMTP id af79cd13be357-7c5a83d3f7amr778268885a.30.1742469293011;
        Thu, 20 Mar 2025 04:14:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a833csm2243614e87.44.2025.03.20.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:14:52 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:14:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sumit.garg@oss.qualcomm.com
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8775p: add support for video
 node
Message-ID: <xlzyboz26ma3kuvwjbnnev7iolcnpm3wd5ajps2v7ci3frwsqs@3j6qfh4n4ujh>
References: <20250320-dtbinding-v2-0-8d8eaa4e76cc@quicinc.com>
 <20250320-dtbinding-v2-2-8d8eaa4e76cc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-dtbinding-v2-2-8d8eaa4e76cc@quicinc.com>
X-Proofpoint-GUID: lf4MWfKMpTEYNC-cH5YbKVch7vH3C2-a
X-Proofpoint-ORIG-GUID: lf4MWfKMpTEYNC-cH5YbKVch7vH3C2-a
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67dbf8af cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=2z3VMMZyhDFlt49ukAUA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200069

On Thu, Mar 20, 2025 at 08:24:30AM +0530, Vikash Garodia wrote:
> Video node enables video on Qualcomm SA8775P platform.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 71 +++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 3394ae2d13003417a15e64c9e47833725ec779e6..0b5bfcdb803913396ff269c9002b4314991075b8 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
> +#include <dt-bindings/clock/qcom,sa8775p-videocc.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> @@ -3783,6 +3784,76 @@ llcc: system-cache-controller@9200000 {
>  			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		iris: video-codec@aa00000 {
> +			compatible = "qcom,sa8775p-iris", "qcom,sm8550-iris";
> +
> +			reg = <0 0x0aa00000 0 0xf0000>;

0x0 instead of 0

LGTM otherwise.

> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +

-- 
With best wishes
Dmitry

