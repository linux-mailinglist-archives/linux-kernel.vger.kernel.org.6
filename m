Return-Path: <linux-kernel+bounces-526476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A5A3FF28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E1B424E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D82528F5;
	Fri, 21 Feb 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REPiqKEh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768F2512F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164333; cv=none; b=OogP0YfXlYO7I80GooIHZaGj85oib3DPhQ2Uy1jFP4ssm8E9UlM6it/J0LnLcEXQ+WIkQ0CvrhQPW6wnJ3BcYmvAE5DUl+pZYi8vKGhTX+XmnDmKx4n9aCt7CpoqBl7ks4FzE27bUA/4sBOIpMQYC1ZqV0Xl87v234k/Vb9XT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164333; c=relaxed/simple;
	bh=cAHIOldwwFNo/wAZhPUz57LxWBpil7EujySEEBgkP2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAQYcEB+lemYQgG61BGGA+EZ95/bt6Zyw67Uqi9gAVwQZ7J0Dk8ipMD9B52CwisbSknqHGrWFZM+RNGQsBWsbDk2AhzFXjE8eL7y4ih1nKFWn6SWs7xqHvqmEDsjrFwiHOoX8Lsk/xYjhOqbmSi2E8lzOwlXShlbNgp6GNmST14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REPiqKEh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCMQqt008437
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzV2o4eyTRfwYhyLT+w9P16JkkzT3HqrChTdrDEUE9U=; b=REPiqKEhhs+LdFQY
	hSz3lOjsRSwlCbqBi9sF1End6d7GNX9uK3QSB0bTU5HtJgJp6HU69u9f6Ty47snI
	Na2NsjWKUnRUof6L3c+4AK6ue+gRevvzw+i7FkXVKJzGgwx4Mpl0fSeYHj2swm1a
	3NHAMWO39LSI7n3tSmzZv42NURMVNV91VCNolbTjRX2BnybiIi7t1ZcyaGugHl8g
	lAYLrMySLtcrM7mjayAgpWaQcOKB0uV+SNGfbVIG1QPUqv8Rlc+qWSEV69QCs0e+
	SoLEvfVxXfZp4t0Dxhigql8jsZRcD1/Oxs4g9zXQ0xz79MDspbrgiG3ECMCph80H
	rJUMVA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3k12b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:58:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e4546f8c47so3585366d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164330; x=1740769130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzV2o4eyTRfwYhyLT+w9P16JkkzT3HqrChTdrDEUE9U=;
        b=r+aIcR+i/DJzH7TcVA8NG+MuiZw1elrmtc+2eJCvu66BLOwtXjUagbdg5zDCtuR1ZN
         ftXzpoJ+UOczlg93z0y3lGCRZvDKVaI4J7cYsJ3fCk5k/93R7BhIApZzvLGJw/v1whPJ
         801oNxjEY19ANr0eqCDbGXwsiDxGIb4VjoJ1D0E9eMqWAwX9a7c4SZyoQLdi3S3c3Qua
         vYxRpfZyIxU2wFPRW2xiIlDFiDjZnguJR0h007bFYZ+LTlrvUtOPg2CRbzbgVhZU9SZR
         IBd8+bY87IGWloieYdPqJjV06P809wlv8osS7ZYmJ5a5HocQg2pNOCyPOdw/D9RqHNmn
         GcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvP5wvuOgYRHGJRetoTiLmjcLP2ZWqCfMbhgYgckUnyQvUKjaLSr4UlbEdxQrENbZRel3lnBNY1M46EI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TTCwPl9zUPFfYBl/HqjjSr73FXHaJqdqoi2UYiHUSxXKDL4L
	LTlbU5hZP+CaSzMmIdQxRoZ0exUJ2+qejzdqRAArN4pXkxDihSLGThV3x7gGRXCpgew8iXJjXBF
	L7RGHnhRjDr+PHNRcLOsgUuQKLJ0eAU6JCHQBh2nSYbtCJtr6vAOfvf7rJSKLUko=
X-Gm-Gg: ASbGncuuwNyIa1FGRVSTDlH+BsIH32n/jbdeeGnpguvLW5HW18MH8w41+x/rQsHRSg4
	GMaivqinsT/rIoH0PfOL+NuWvHTLRRJrirg5Tl96KgHozPXH6C86ZAWC/AFI8tRafUbTAsAXCCE
	hVBRKGzvTdpBecT9gYCTrPbYZJgn7fZyJIjMvMJKy3ufsLHBb7B1GF7NvrQpwy9IvEMRUmNplYx
	lYmjq0us9aeKQFRuYoKhs7xGAR1OzFUWExaBVgrdDgsZWroBDnXFLD5tFybE/EqpPiEFriw209P
	Q9donWxIX9BFkTmKBomcq8apHO9dWOQwjn3ljLliyFy630O9cIVrHnC9RhmRfx6BlomIAw==
X-Received: by 2002:a05:6214:e64:b0:6d8:b169:dcd1 with SMTP id 6a1803df08f44-6e6ae9ffd9bmr19075586d6.11.1740164329993;
        Fri, 21 Feb 2025 10:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDMKRFaHc4D4Ja2PLy4N1h1xcVjFyYawh08UFrwgsskejYut5579S4YNCx1aQqtDmho2zVhw==
X-Received: by 2002:a05:6214:e64:b0:6d8:b169:dcd1 with SMTP id 6a1803df08f44-6e6ae9ffd9bmr19075416d6.11.1740164329513;
        Fri, 21 Feb 2025 10:58:49 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece271223sm14404266a12.59.2025.02.21.10.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:58:49 -0800 (PST)
Message-ID: <103f33ed-595a-422b-ad13-13d9c1f0ee78@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 19:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/1] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221171014.120946-1-quic_janathot@quicinc.com>
 <20250221171014.120946-2-quic_janathot@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250221171014.120946-2-quic_janathot@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WOEyQsFlZS14CwF3uqwhFVVwdBe45uTf
X-Proofpoint-GUID: WOEyQsFlZS14CwF3uqwhFVVwdBe45uTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=894 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210131

On 21.02.2025 6:10 PM, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen
> board and assign its power outputs to the Bluetooth module.
> 
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

