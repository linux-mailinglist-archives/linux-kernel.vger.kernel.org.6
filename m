Return-Path: <linux-kernel+bounces-530023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8EA42DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4743B2165
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E4420AF64;
	Mon, 24 Feb 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFC21oGz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A01FCCEE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428941; cv=none; b=ZqRjJxBa2GJM16Q8O6Jt6DjnELbqZD9qD8KxZ5SlPhWjL4s/2Jq/vsv+QHW72GfbM7ODK9/qyP7itDAVPGhxXE6GJUbQPk8DkmlhISnehuzJzb09GAe1BdKQf+OMaT5IMprGGtZ44eNa8ipx9O3eFojzb5OoF9AWgxm4dfjCwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428941; c=relaxed/simple;
	bh=C4PUezSCHuw6FaHV1HKbKJ7N//pAYv4ESJN+50v/nSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6thUjwjjs9Oa+uHUpqjLBbdJ5PYGv6HlnQoeTZMZ3mJFxSXpFtfI9rLjhm2Puj7yoNkXDrNf8/BAoZMgjLnchdJpU/oW1BKYuSDw7wVWDK10SgNAO2fZkKNJ0SYpDt1QJG4rTwjjTTmP3X2sAt8iMEzo8bDhSkcyzlxGStprxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AFC21oGz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOd92015181
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E6fDmmAAyuKlBL6ws+051ou2T/3ji4zavCGP8WljcNw=; b=AFC21oGzGdGlgf25
	CV0XFFZLFTK73Kf2RI1MidF1w979Vry2HV7PhlQA7ExlL+T/gC4UL/fik2KTy8UO
	leC/U3N4c+uz0wSQTu/RbplDCnPRWrV+/AHCpP+mBS4THCM2xxI531Mr5uoVpls2
	GF4FZMfl36OW4lRY0ASv+GDRAryMAVMmao8hV29MWoVEKMzhyWHnaXOmwCJPhKlu
	quJjleXkqtj9a4aG6QfuYBYAYmq6CgN9+zNeGJYYD8vk4FO7/OcvbSFqL6n6qyWg
	jpe5pjbUCIUHDjSh84+lvS1X5CH4ygQBxL7NbEunNe0sLpotOx6Kgm88QVS+YGPS
	zqdkkQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450kqg2na5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:28:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e422f1ceadso7724626d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428938; x=1741033738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fDmmAAyuKlBL6ws+051ou2T/3ji4zavCGP8WljcNw=;
        b=Mhehy7AaOyKH/3Xhjz5PDH9ZwvDl6qzk0hToyR+lTK7GVYz/MPyeoC8WNBesKF3ki4
         eFJgyj2E62vw3BfeT+uSm4VxTnzfLi/ExZZ+omvSsLlLcr9Bv9M3KThYaBekg8i0uDHK
         TaMdaY/AVlSou7Z3YySTEQLN5Tly6eb/01w3YA8ya76ctprlmny3micq/WFCMZByrzyj
         IFTwDGv7eEhk/9/FjWSuoQ50b4DIh1yCNaRA90Ul1YzTUIUH2XEdpzHx1HcIu6yGSCrs
         1zfGWt8A0j5HsJ4X118LNVfYWTCJQ+m7OjOIFT6hd1gGFlDL3PiBBfC023LgL8FvV/yC
         OX9w==
X-Forwarded-Encrypted: i=1; AJvYcCWxvzMwsk7C/Y94lnf+cWO7KT3cAEcIRhuczAUXUEs7qWgkSlH1OpPExo5W50rgfWawWO+hixYJyb1/4Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Vtp2Y+00xWNut+LZUjcvTSfJSNiRPrcfq5TxT6mgXN3ag6vo
	XBkAqVitWr6JpOHqdwWfOWM5ESRZggIHTKKazpeCugm/BCc4r+AxPrfQXsfdlkOFqeM/OJV3Wa8
	h6xPa6k8rOEeDlDcpPghGCfvOu0HFRzB/1c2YzIYWT+9mtFyQhKLYGl+/iqMCpvQ=
X-Gm-Gg: ASbGnctjP5CQ1iDhP7lvFKIE4NUo5LCcd5aOzFyoDgRzMXmkA9xsb7rUARsDEAB3DP9
	E0wVtrpJfG6xWEFxUY6GwylhBf1yISVKnqBeKg83IFCPEhHmbUkMr6NtZJdXmvgG4F1ZF3I+loJ
	JiI22o2wx3/GgdI50J/2QdXK/xkUNut/FHMFqdFmtGInF/yNvRjslRS2XrvTgxuzehGXFjv+vp4
	DMyVO5xi1HQMGb+f4RYupM2ZdB5kmzV7XqFciDssvIj0RCPohDcznTc/Frb0WjcaL4R/3DzAdI5
	r5bu2D8k1NvluhkwasXmVey1gisCokKu8xO1+eTLt+bpRWGUVVPSl3/9u/bN9ivUXm53jQ==
X-Received: by 2002:ad4:5c68:0:b0:6d9:2fac:c208 with SMTP id 6a1803df08f44-6e6ae9affebmr73396166d6.6.1740428937797;
        Mon, 24 Feb 2025 12:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtOqp3xaG/Jg9zjC3Kz344Y0fun2IzA868MgedRQnJqWcAxYiaghqDYomRV1co7tz3Naoivg==
X-Received: by 2002:ad4:5c68:0:b0:6d9:2fac:c208 with SMTP id 6a1803df08f44-6e6ae9affebmr73396006d6.6.1740428937454;
        Mon, 24 Feb 2025 12:28:57 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d696d3sm18439266b.59.2025.02.24.12.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 12:28:57 -0800 (PST)
Message-ID: <61f8e08c-4f29-4e3e-bfbf-8a561e4b92f8@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 21:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix clock for spi0 to spi7
To: Pengyu Luo <mitltlatltl@gmail.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250223110152.47192-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250223110152.47192-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GfZTrJJJuQwbO10WK3SjODu2nj37G9lN
X-Proofpoint-ORIG-GUID: GfZTrJJJuQwbO10WK3SjODu2nj37G9lN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=780
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240129

On 23.02.2025 12:01 PM, Pengyu Luo wrote:
> Enabling spi6 caused boot loop on my device(Huawei Matebook E Go),
> 
> 	&spi6 {
> 		pinctrl-0 = <&spi6_default>;
> 		pinctrl-names = "default";
> 
> 		status = "okay";
> 	};
> 
> After looking into this, I found the clocks for spi0 to spi7 are
> wrong, we can derive the correct clocks from the regular pattern
> between spi8 to spi15, spi16 to spi23. Or we can verify it according
> to the hex file of BSRC_QSPI.bin(From windows driver qcspi8280.cab)
> 
> 000035d0: 0700 4445 5649 4345 0001 000a 005c 5f53  ..DEVICE.....\_S
> 000035e0: 422e 5350 4937 0003 0076 0001 000a 0043  B.SPI7...v.....C
> 000035f0: 4f4d 504f 4e45 4e54 0000 0008 0000 0000  OMPONENT........
> 00003600: 0000 0000 0003 0017 0001 0007 0046 5354  .............FST
> 00003610: 4154 4500 0000 0800 0000 0000 0000 0000  ATE.............
> 00003620: 0300 3d00 0100 1400 4449 5343 4f56 4552  ..=.....DISCOVER
> 00003630: 4142 4c45 5f50 5354 4154 4500 0100 0600  ABLE_PSTATE.....
> 00003640: 434c 4f43 4b00 0100 1700 6763 635f 7175  CLOCK.....gcc_qu
> 00003650: 7076 335f 7772 6170 305f 7336 5f63 6c6b  pv3_wrap0_s6_clk
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---

Fixes: 3d256a90b3bf ("arm64: dts: qcom: sc8280xp: add missing spi nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

