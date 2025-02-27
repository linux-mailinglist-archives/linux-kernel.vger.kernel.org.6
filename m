Return-Path: <linux-kernel+bounces-535855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19FA47825
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E53188BD52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333F225A47;
	Thu, 27 Feb 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EkKFaJSo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5455191F8C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646002; cv=none; b=XYKIoelbOIf45ziC7dLZ2ttM8eC1hfgOPtLB0F2VkweXP9J5gygHlhlCC6+xy4f0blJF3BI+mapz+B08oe+l0QRHsty47F/xVzai/gLe7IpJaDG89nVYHW9QSXg3YcI7OGwzUgfAKRSiwtM3zfrXnwi1cywZ+R0lckp4TjDgndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646002; c=relaxed/simple;
	bh=i3wWe6ahx0nNYsdmrz7shy89KbnD0dzmfCNsWOogpJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/nWk6ijMpV2NOmDqutRoL2y6TjHPnofcabxIqalspWYgYHeEu/SlbmG7fhPFDeH1bbAuzUcVXWbLQNfXCvRu6jcDNAFxUdNXfMrUFZQr4zUomLiOaVWq4E8xo8L1xO6481Q9i4EpUk6T/PZi7xvgCUQLJ7DpaHC1k5zlhwX9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EkKFaJSo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2bJAm001049
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=; b=EkKFaJSooeCORZoT
	yax2RsQ3MW0XACt9wm6rgSGjDSNe1pbYNTBS8gcpBuJ8coKUTA5dsTtSYz2oERKk
	H1G7GcXIvFanQbqLwxWWVV3cMgUK3zfMPiU73sOSzm1Zu/kTJDgwgaZS3cZvQug8
	babFQPS29vf7gqPNUcNAQcQvR+83VnB89t13qW+BqPiawWriytL334/R4MRFk1yX
	d2VOMPzDcixl8hZ9GHK8RZjwtNahD4EYzfT5oaaFhSOz2X8TKLNQWahW0SQIh7zr
	i6iAlJPJq+Ih14T5nsSb4jEoko8f74nawZlw3fdPCvSYRnMulbmQIvDqFRER8fPI
	w5dAFA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4523kcavsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:46:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e88eea1af5so837726d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645998; x=1741250798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=;
        b=mPn9cbT3UcEZ18pZHFnHNJp95ZAryir5rMmYAdDjapJ+vqQygLDwNal+j1w5+PR3Br
         FV3ptRLM7LvZlOQ3i+nfWtDmSj8FTCCpIBIeGUdEQDL8aM3Mp6ERwIIcDh59fbA9tJVr
         niXW+r7mBwq2gLVCj54gaPSso5A6HnWkejIWZZVSjXEtsgeKD9QHOZ8EPu7uadjuhYJm
         F97BcPIF56d7MUNVEX2DBrfBnL+vXSya6bIG124auiOWqIs3QicgXLhp1M5Ot8wt3bbM
         T6ZsjGBwiA+czOjFjnChzsodm/oOPZ+Fx3s+5jEjyKlus1THLS/00+WdcdnmHYs/I1FG
         eW0g==
X-Forwarded-Encrypted: i=1; AJvYcCUF9lVV5t8dHLNtGSj2C3AaD9dcBz424KrZ95J4Bdyk4H0t/rQUnnd4dzdbT6C6ze8XxCirohUjJzA4EHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRwmMtPzM327TJ3kGrpHZ6pL4+wjq7A94EYZGM4iiBJKurCue
	IXFVaJgulHwHCwrpUctvBOaQX4MPaEvB1r0J4+HXZr/UGU9fzZeNyP9ZTmvSxaA1BVL+GeQNMAt
	JQpX7abq8wZqFtSWrwSpQ6bJSeEbz+Ge47Vcqgy9wXuYbzpZALpozUsoVBUE4sHpcsQm2/BA=
X-Gm-Gg: ASbGncs2gq7wKCX2W5zcacfqKQtGxCZtBrw+D2yRkqngFDr4db2D4NOmpkUVqiYstaC
	CKqBLpzaxuyknUNLtNyXNoot0Ee4oPT0WH39iwCxMu93gEp6eeldEHlwBlI41vTlL+Ri6h9P9O1
	ltX/Rgvr7la/ku9UMF/RwPDD0/KAmGq7K0MHC+x9YKkxyBudWQFWziLc7mu9FTtpnST3jgMUv4g
	Eex9IsMAbEK/PqCVo/izALwowLDe9mgTTdEwFyHcIwx/jPpLfVYt17y90Ksah0lXTIE2PQbRznH
	6GnKrUFV04uUFIveVVGv0gk6Wi9Y3e5Pqpy9CMH4s5Im+79gon9fobcnxlcdHeqmoSpHkg==
X-Received: by 2002:ad4:5bc3:0:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6e6ae8118f4mr106219646d6.4.1740645998558;
        Thu, 27 Feb 2025 00:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMosI9i2Jn6Wd2Hmlan3NqGw9jIWceBTgpEgh4PjT0JA+3gBexN1L59AMBlj0IeqkvWa3PIQ==
X-Received: by 2002:ad4:5bc3:0:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6e6ae8118f4mr106219536d6.4.1740645998127;
        Thu, 27 Feb 2025 00:46:38 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75af58sm86712966b.147.2025.02.27.00.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:46:37 -0800 (PST)
Message-ID: <94b92fe3-a437-4368-a51b-5f6bd1711fe9@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:46:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: x1e001de-devkit: Enable HBR3 on
 external DPs
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, laurentiu.tudor1@dell.com,
        abel.vesa@linaro.org
References: <20250226231436.16138-1-alex.vinarskis@gmail.com>
 <20250226231436.16138-3-alex.vinarskis@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226231436.16138-3-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sFrtlpEipjgdXg9kkI0FhgJ93Bycmdp8
X-Proofpoint-ORIG-GUID: sFrtlpEipjgdXg9kkI0FhgJ93Bycmdp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=816
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270066

On 27.02.2025 12:12 AM, Aleksandrs Vinarskis wrote:
> When no link frequencies are set, msm/dp driver defaults to HBR2 speed.
> Explicitly list supported frequencies including HBR3/8.1Gbps for all
> external DisplayPort(s).
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

