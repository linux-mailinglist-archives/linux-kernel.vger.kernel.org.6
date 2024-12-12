Return-Path: <linux-kernel+bounces-444080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF929F0082
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33087188A979
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278B1DED71;
	Thu, 12 Dec 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m35H8QrU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F5166F1A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047381; cv=none; b=nQEMQiPTqQ3xYo7ve3VamYviXUcvXIN3/4zm0fv3qpaKCVtqdJlw8CyHR3qyHyeFOoLtnYS9cSS3X4XzBvOCrgdqL8Ofzo4Ztc+0fuyiqdPMhdMlomUqorEiFwuAiY07znF6iPaCRCn05eG2t2e1H/CwxGrUXRlsULu6wR5zfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047381; c=relaxed/simple;
	bh=URBmYjMmyDex9nMoXMnWsSAzcfTL+mwozsx0zYAHLvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUwzw09xRqfnQj+EVfbcK1Jb+BlWZezyYxKnNu+1C07jdZZC8STtjRX+sikj+Eq75LZgSE4jnUh9O1nbgJRoNBe4V65mWq4bqSC6g+t6NOKYKu9fS9M4s/vsVczTRIlj95QF4neW0WxTgJZEEppdybi3SdiqiVo9kRbhgDurC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m35H8QrU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGONbl005114
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L0QLS2uYSHAYK/Fhp2TxaPsUSttT816uFB65LOIdQ0E=; b=m35H8QrU57mQjKTw
	tEwlyuGsAGqFlHMJdYkyKA8MGwn6Uc8p209Ato8j2vMSRX93VGTId1z9C9n8rDye
	BWRmMxe16C6OET9lB49XxcEsf8keg0acK0A+uwfS+GvGqxz3NaVNqvqBPI8hOTr2
	kvW1KfnoClzxaaFIgXipPRkA+GtaMjvmur40G9tC9A0z0qUU28KrVTLPI1noMCAY
	cZZznbvVjhvH182PgMi8/2nz82d9tOVGqpj/62BRmnSUlj+682aCum9EZ/dmWhbr
	jV7H/dD1+rw+onnfbdVtLuMSKBf1uuMy/WWL2Vl4eiHy7VcwF570AXCMsY0Jqomh
	lwRGBA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9xyds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:49:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d887d2f283so2982356d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047376; x=1734652176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0QLS2uYSHAYK/Fhp2TxaPsUSttT816uFB65LOIdQ0E=;
        b=QPk539RfjO1MV7AScC1PRm6se3U4+rHdZ8P62+h8mqOq2bf50asTXX+MfhJKbiu2QE
         XhpgoXagXyC8wV1K7ITM5okqNaFmy7bu2F7kyeYTJm9JyJaG4VxXDAhS3uYd5BX8knE8
         7sHY6tIURPN4D/FoADAQL2a+xDObmT416Yhnzn6ftKz8rgDx12aktofw5QbKv13aFWiL
         92Lv648WS9OVF1UC6E/nmFexfv9JCDW4TI/8zxd7cRlXU44ASlJJnM7anW9k3Spg9HF4
         6zrMxHCgkdJM3ODGkqVEjKLkZxVAMteDQQq2Ul2McQG27mntL+Vg9pB0XbcnIa66nXGz
         Opog==
X-Forwarded-Encrypted: i=1; AJvYcCXB/z93OcAaX7O9ZuKGGi4GZ1wSvNvaahKwkJFfMxAP+waR5MQ0ZK3dA0c8MaV7lvvQI1GzHplJCDf9rIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFofBdHLbMuwsLJPuo6Pg+gosZ+TCR/geXUFD1UMr0WUiQ+Fb
	YUT/HiwH5wqJHiBycUfy4QCIjyLTVhPjqTXLLd1XP1336pkMcZS9LE3S6Aj8dAIEDtHRJzD2PTQ
	DXCrv1dF617o+4AB1wCwSS51Ef1NhAvxEm5nskPo8gXmsF6iPLjt/pQeRTbUZe/A=
X-Gm-Gg: ASbGncuLkyzMvdRcA7Gh0BbuM10yy4Fwr9TwTmp5FUejOK/LOsxtR+icGbE2osjptsb
	vKE0aIn5rouI3DYgcEAwQ9NBi9Ncd/a7XxxTVCdaHEpo4kWTfmi2aKMNYqp4MOTwGxZERK8jIh/
	zYPwXGxVzXt24ctrv2c0/EQRyrjYwmmKr+fE5TXz+2LAUZu/Pu3IEPyJFwlfyFLB2f95wQ4rZtE
	dblDFeKSq85DARSI97vQuu01Sb0RrDulyYtaUuUcTDre1h9TLfZv5Ou0VjABhvRCx4hlrTAmPVQ
	R0lobQrrxT4XbNCUmLOap8nmQORDCOU33h2+
X-Received: by 2002:a05:622a:102:b0:467:61c1:df39 with SMTP id d75a77b69052e-467a57f68f6mr3227621cf.11.1734047376647;
        Thu, 12 Dec 2024 15:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5AzZKeD73oYNDuNinX77d5Sgi2yqleUPr1NZ/mRZDEOxdKMTgqhc/82eGWxfy6eHLUiy+/Q==
X-Received: by 2002:a05:622a:102:b0:467:61c1:df39 with SMTP id d75a77b69052e-467a57f68f6mr3227401cf.11.1734047376274;
        Thu, 12 Dec 2024 15:49:36 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6801060e4sm688426066b.158.2024.12.12.15.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 15:49:35 -0800 (PST)
Message-ID: <da7590e7-bb18-4983-9d73-fc10d42c740a@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 00:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: x1e80100-microsoft-romulus: Fix USB
 QMP PHY supplies
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Marc Zyngier <maz@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>, Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
 <20241210-x1e80100-usb-qmp-supply-fix-v1-7-0adda5d30bbd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241210-x1e80100-usb-qmp-supply-fix-v1-7-0adda5d30bbd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: klO1Ugw9v4oThW0_r4mCrjjZQ1I5rghl
X-Proofpoint-GUID: klO1Ugw9v4oThW0_r4mCrjjZQ1I5rghl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=845
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120171

On 10.12.2024 10:07 AM, Stephan Gerhold wrote:
> On the X1E80100 CRD, &vreg_l3e_1p2 only powers &usb_mp_qmpphy0/1
> (i.e. USBSS_3 and USBSS_4). The QMP PHYs for USB_0, USB_1 and USB_2
> are actually powered by &vreg_l2j_1p2.
> 
> Since x1e80100-microsoft-romulus mostly just mirrors the power supplies
> from the x1e80100-crd device tree, assume that the fix also applies here.
> 
> Cc: stable@vger.kernel.org
> Fixes: 09d77be56093 ("arm64: dts: qcom: Add support for X1-based Surface Laptop 7 devices")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

I'm just going to assume these are true.. Can't really cut power to
these to test as they drive many more things

Konrad

