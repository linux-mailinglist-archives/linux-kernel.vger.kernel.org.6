Return-Path: <linux-kernel+bounces-552564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD02A57B63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9474D7A4484
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4361DE4E7;
	Sat,  8 Mar 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QStkJoM9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C451A83F4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446220; cv=none; b=FVl5MBZbDokR6Rs9dxUbA289eG9v24MSrm8p62wQiQcN8HmhWPDJGJFdsXH28eNAF8xbvwiDF5VktZltDR5c1r6FnUMMX3Yj/doKiRr9WfBGyTirBNIzHE9QetZTtnI0lDp605IfpUnULeFQoJUlutD5dOjIwICKbJbwhtAqaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446220; c=relaxed/simple;
	bh=e8SexFMLy+V7m84HKtVT7FdSZ56Nzyx3ZfiZYFbyK0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSlbD41poD2UXeyqjmyXXiaFcToxm8Hoi5CvQVYJOKCS5G/CfgwVNKMFldwlfLT7ZHETq9pl/yQ5HENTlTN+LZ6UETMPMgAVSbqy8HNPdYU0NemI4S3NLzeACc5ZP4EPpZj+S0O4+kGGYCFtE3hqEZcVGN+FiRxOWxLnTPB5tXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QStkJoM9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528DhF1x002191
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 15:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IKPlg8KpcdilLw+MDQw3ribbQkf1W3yXLlwbnkUFVEo=; b=QStkJoM9yFDPRuKP
	TAlN9Nx3GZ8AzY7PwGE6cY+IUQALBrunGtJ71X91Iydk32xhzHGO51JIXEG0/rVW
	iSoEx9rxOAMom7RXWhrXa4KQHWX3Giv0qYI2bJIDaSizeOBOJFAFjZzWZkuCtLXE
	KMrgw86aP/ossoee9Y7dn9i5D3NyfRy+6DVTn9vVIpTCkLkvOYN/9OgicGe9iA2l
	bIzWZCP9i633tpIVaOpMKHGWRbEbSYrkDqsvrYfi4hrihwwr/5JpB8GaW3NnKmsm
	plGuhK6NVVX4M6Fervj4CyTeD5QUU6MsXdfYyHzI7vGmqla/DFMRW152l8+7hIoE
	hYoZVQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f6a8qm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 15:03:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e906c422a9so3471776d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 07:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446216; x=1742051016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKPlg8KpcdilLw+MDQw3ribbQkf1W3yXLlwbnkUFVEo=;
        b=jeacYHcKS3HBf0KEeU3FlZIedqO+T72tm/vzcVQh3R2oWV/eVCGz1OLHvwFF2v02Zz
         mnIYuYtfRaBHQRE565d2W1HhKO4tm3A5rQruVkWicShet6bI4xj6LT05dMjc/+DavWXR
         Nxsc8IR9RLE/E6r5jd2HgDW/FE7hncNGoHma6QvIc2JELJEFhOGVd5P/rL5j7uycZ2Ra
         QIlQv48+gYn/o80nucgAiIdfVJm+U8Ao3hoRc1Ph9qR3SwB2Fyw504EyCPyDyOgSe/CX
         +HoavqJVCHajZNGiNPSaRHb8nL/JAh1UUye7ATTKeJClJWVw5NUruX3/8pz0ioVSr/Kj
         rIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhQlrcFxX9fX2Mx1a41PEsdC6piuT6OtopapeUkA9hW9mKqqHcKRWCuX4CiWVNr8DxGHbDlshRMLwPuUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpXu9QkAIj5pEWZfpRElmqo8EGFQ8Jxmbfkwkx0A03YZ1mpnP
	7qKuvQp8lRcz+geUwiG6j6z7l/lvQh6kl/963nlS3Bxx4TbLR/6chE4jtzSUWk8NFlBPx4YX4zB
	nvqc85a4ID4k1UQLqCVySZbGnwpP90zw9IUVgz6yBJPqjYXEdANxywMI+kFTtZLc=
X-Gm-Gg: ASbGncvDg7Xm7DKk70f98tcn4pABGnY3zXj8IbGm8x2ANRIVcyZfB6WSGKoJJWF5mFY
	3kzQ8iq9pVS3Vr5QMrhNYAMZmWQLcyz4bco4nOCGL7CcIRrgexVcDdOuW4nM0JrYxJBSVP9hdeh
	J6ikh/ANb0PG+BB7LZ5ND+J8XT2PsvgatsT+hxRQSMkoNbfsiPBMoFs2lNUPr40fjY1KBWXc0eC
	gzcjGsAYFIzanoW2opBhle0kIV4AdKgekcu48DWywvLnNr2X70tL9sqTPCYZnqQjYovVK/SEPv3
	CNyeHJps/9MxhN9+46pb/M13912r71BGIXauCAQ4Zv3NJRFLVnwyA1QFvufl09JxvtWu3w==
X-Received: by 2002:a05:622a:2b0c:b0:474:e7de:8595 with SMTP id d75a77b69052e-47666ca49c3mr13703071cf.14.1741446216613;
        Sat, 08 Mar 2025 07:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2C1ER2UZOIAo7ctUzp4nSuh/7gNp2uvGTLVNBhuB4jYEmqZINWmCWfInxvDC01eRy/YRnlQ==
X-Received: by 2002:a05:622a:2b0c:b0:474:e7de:8595 with SMTP id d75a77b69052e-47666ca49c3mr13702851cf.14.1741446216104;
        Sat, 08 Mar 2025 07:03:36 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f98asm3999255a12.68.2025.03.08.07.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:03:34 -0800 (PST)
Message-ID: <df2f0bfb-665e-45a8-8103-5c6217dd194a@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] arm64: dts: qcom: sc8180x: Add 'global' PCIe
 interrupt
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-21-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-21-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WsDRMcfv c=1 sm=1 tr=0 ts=67cc5c49 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: f9UVasGZXMh-xCvJpRw-ChVE0lb7ZjhC
X-Proofpoint-ORIG-GUID: f9UVasGZXMh-xCvJpRw-ChVE0lb7ZjhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=570 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080113

On 27.02.2025 2:41 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

