Return-Path: <linux-kernel+bounces-391238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6939B843E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C232284AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58F1CBE86;
	Thu, 31 Oct 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFFwWzyP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC921A2562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405961; cv=none; b=B9QNhM+YZbVepOI88aJxUzRIcHyY6Kt96cFvDHT49IstqUxuZoxhKGLtnwicgIKnnamk/ML9O3nAujJsQ3MHxxW1ScAqJ2TqOB1RQwGxn1ViTwlUJc3i9r4VUyjVIGkbJqwEOg61OrNOBvS0zfjUHoJ9QuXYEAh1UbtZ1kLkcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405961; c=relaxed/simple;
	bh=GnQYDXIHoDOzz5+PV1tzxvrrVrX3X2asCJGs4etQLVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDQs5xvmc9iLPYDpK43QM2Vj/G2AbEmYOizmR6G7L2sNnAsx8jszaqGChQlE5rQRSlXKFav74wpUDck7l+9WcyTZ6s6mxSpa6h9QfnmVWikt29SMbvBqg1vHHBs86enMBCxdgoq5EX4pVykSpgiqhJhs9O0rTg3kbzsycWfcAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFFwWzyP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V916Pj013623
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJ0sAxBwPqJS8ftmuBtJ75sPX6sgnBhsPkA7vpmWuE4=; b=DFFwWzyPfNEIBF+W
	YpRk6svdlGevMIa65okbVCOem8TOmmFZDTPojdXFNlG1GxNqMZmWyOyrMJwtpSOi
	3bTSkWAXQW8AXiIxPQR/g2JfZxf5ikwQFzSmW2Wgai6CKY6ZPoCc+Cdgry7gDQwO
	M0uKYWp3y8QERN5xe6T3NVDtWetyTQ5GQb+c4lKIoB7WpKVg7tz/A/3cq+RpqJCm
	S8FjhzxoRVXEp35r4ENRoIiRaCN86vqELcraoHVsW6efXt4ySqW+CnJRrY6TdKEU
	1oGn5L0Egv7/Q57nZMKeEqxuWZLrZVoVUnO6cm0viOPC+AGnE87itJjETLKzoMRJ
	vNkjjg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k6rpq3sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:19:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2efca911bso350275a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405958; x=1731010758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ0sAxBwPqJS8ftmuBtJ75sPX6sgnBhsPkA7vpmWuE4=;
        b=t7d+vuWOnRMptwc2qjZhPnDgymUMO02GG4QsXeMsqxI16b7JIRom6SLAnlziSj/pYw
         w/byE0t215r7jYY8GzGyNsujHVkMjNejPqm4wBIvvaR+rYMUaOSEi56KyMbdn1sJ6tc3
         SD/5QiQyYH5/LHCTEnPMtLJfV9Cq71Zn3X8Pl8kdXyfNfqN4pO/Cq/eCNy0KNXRdBQ7J
         gWPUgU0IoSzriFLJgW8mHvhcuLwaxTD0IiQ6CkjFc1XbmMbJV+G5ymjeF+7LvlW1NteS
         Ti/3TUTtegMztZCFFJwAcG6cswCB4NrROVMRXriaYF17IgP+1vRV/cMRzfhacIt2NVaq
         5ivw==
X-Gm-Message-State: AOJu0Yz9rqkfxnLrt8r8wmAqAdlQh5BDuoizOFBJJ0K7yMV8WeWzCcYl
	l41BRT6gMyPUurFvGRV4UCWDyFA8HM4Qq307dYkTRVt/0izqOUEl7x+1Op0aOz52C0RGNbsZ6MJ
	pWbViZe0ZiW5VhoGsHyDe2Dl07xBeAhOmXyHgCKaZ0+v8D+a3zN7weHV7hvmo7mI=
X-Received: by 2002:a17:903:41c1:b0:207:14ab:c436 with SMTP id d9443c01a7336-210c6d1f342mr119054485ad.12.1730405957912;
        Thu, 31 Oct 2024 13:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2f6Wf0mJVJdxJuCcLKJLBOMNM00M+MzQNwuhinCzkjxOAOp6yuBXDEsbbGQRVDBBkzJcd+A==
X-Received: by 2002:a17:903:41c1:b0:207:14ab:c436 with SMTP id d9443c01a7336-210c6d1f342mr119054355ad.12.1730405957578;
        Thu, 31 Oct 2024 13:19:17 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e8e63sm99423866b.91.2024.10.31.13.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:19:16 -0700 (PDT)
Message-ID: <3b049641-f102-4eb8-ba51-471661b85060@oss.qualcomm.com>
Date: Thu, 31 Oct 2024 21:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: x1e001de-devkit: Enable SD card
 support
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, krzk+dt@kernel.org, robh+dt@kernel.org,
        dmitry.baryshkov@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org, abel.vesa@linaro.org,
        srinivas.kandagatla@linaro.org, quic_jjohnson@quicinc.com,
        maz@kernel.org, jens.glathe@oldschoolsolutions.biz
References: <20241025123551.3528206-1-quic_sibis@quicinc.com>
 <20241025123551.3528206-3-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025123551.3528206-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gewIdZp_3Sasy6MFKeqvgoVjmyXDz6SS
X-Proofpoint-GUID: gewIdZp_3Sasy6MFKeqvgoVjmyXDz6SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=774 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410310153

On 25.10.2024 2:35 PM, Sibi Sankar wrote:
> The SD card slot found on the X1E001DE Snapdragon Devkit for windows
> board is controlled by SDC2 instance, so enable it.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

