Return-Path: <linux-kernel+bounces-445720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDAF9F1A53
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1435162CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E61C3C05;
	Fri, 13 Dec 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BM8PfZh4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DE1A8F81
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133978; cv=none; b=uPu7KDME2zEaxDZVRZXX56YciJ6sHGzogyaEfjNFjKdTDg13hhqPvu7vNIiPNRrvuVlCTzyYeOAhoGNdLdRO/1okSz8UPS1ir1NaY078FJam5TdE4ALZokpTfxVlzM0xW3H8dEFy+z3Zhch8pQmVzSmMi5H7sHqVV9vwVFfdbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133978; c=relaxed/simple;
	bh=RfB4J/3OZIKe8oDeYe/PcMGp8YLFFYtl7NrwaLuaBwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsNfBInKo0/WM1ZJZglL1IKs490HUvQa0NmG2suOVs9NFZhcdEdgz1EDVfk+1ESCzfMiyu9mVu6AbEnPq4sYU90GBYy4PHPszrRQdqaE8y6l0NDezEysFIjJAF5JwS8YJFJAHOErpJPUDSfVW1fshuS97POzpP196Z/1hEMGysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BM8PfZh4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBTqvf001416
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N37b5CHVNpbNO3mJy1xrr3qdkEzMazP7Mp7+movUY3w=; b=BM8PfZh4byuz78PH
	yQlZaa6IQbEyMitNoLN+6cdTRB9IfdxZWGThs6y9feLG8aCbg+PA66rGxdxDGCRC
	ukkX9HzDWmLAg0k5pTxEpvePPWTJ0Pdx0n/3isAdAipHtd1fwPwYPNuoJqla02xg
	i6mYIROb/w7q/BjskevJlLLSXcgFyeSVTYc/TmpC8xO1C84OGW2n/VqwdRZ8Zqka
	Ig9DNXZ7AxT80pzQqc3LASPB8mIfcf87x28Cqef8zhKmHn2YoeJCsYaKbMmOBet5
	JKOlz/qhxg0ChLk8iEj04uTGb8ihT5jSxT1bDgkHMJ2XW9/8mel0AqpyrdhQHEZh
	p6XT3Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gm3s1kts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:52:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a0d7fb9fso3458501cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734133973; x=1734738773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N37b5CHVNpbNO3mJy1xrr3qdkEzMazP7Mp7+movUY3w=;
        b=fMQCc7tsHKv1b6XsnZ0jnGMkS/IBwi6c4itIfSX/RKsy+TPOI8HWc69TIym85CJ23p
         bPJwJjB17CeM/F8TR0JX5J0Fp6OJ2x/oCByAieesGPH2cJ4ET9WWaIXl5PY9XjIyAXXO
         FWfGGcIyns5V5P4ikvnX/HB5FQS0gGZdvq839VFSbvYwL13EIT0/QqLrqxLTth2YSp9+
         sImxGQKMouNHiRsXkVRAcagmiTpVw1OVhFDEAwiSYag3qXvmvWUeQLR0LPN5Fk/Eta8Z
         89dIzPFBhNH31Ry2g2vxcr/bqxjLa8eaLsCnD+j0r/1ciQcP5iwWmXySx5xRoXPaXcpI
         aQjg==
X-Forwarded-Encrypted: i=1; AJvYcCUgxm3kPZuPAMF1N0r0eFlCZ5kAQKW46+zVhnmDNGjmlVipW/AGOvmjW0q/Ymb2QUgG/Kajmov9iuv2GN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMCm5rtMS2Wayh6cTo0kXc0PoUcKrK/pv7GluTOZdlkU/ho4j
	JLyXZaPnXJgtb4pgJVGoFtkl73WiUw1YC6+v9HzOIUtNI8s9N05pjLivF2m9l8rpjwgOO9FgfzF
	42updTooN/9pFU5oVUkixwZpgsBucPZ1dIi3EDps/Ddh1LrBT5Ilr1eWo3ct1hSA=
X-Gm-Gg: ASbGncvn/EiHT8pOsqwYNTf5Yp3uMf5Cr7cpgv3exCRSr/MS+UrMyz26PcFaPVpxNkP
	iYoRK9fDkypUsdyJFsxEr6JRpXdV659H0VOkHr014WNeNp0vhAGFyolIg3Oznc8rVtbamv0JMa6
	TfUKQHnWzghYpygiVVse7ataFUKBnHXq4Y/Y+rXTcL1Ik7J3QJtghecq76509v8L1VbdoxSkuTq
	JSSjN/LhQMiYWDl9osO5b05soFXiCTqUOath75z0Ey/mpTvCHAF1Whjj+zcmIy+kpIh6bUBLsUY
	B+fgLGi8TdpGrc60V2aEb+lLqL6K/85DL30=
X-Received: by 2002:a05:620a:191c:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6fbee75e0mr248718185a.5.1734133973580;
        Fri, 13 Dec 2024 15:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJPdM/1J33q3OBU4K148O8fBOXwXDUj5yh7R2/a6WIaqHivQbWtTXdCwgOTQEJLpcofie15w==
X-Received: by 2002:a05:620a:191c:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6fbee75e0mr248716385a.5.1734133973145;
        Fri, 13 Dec 2024 15:52:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ace9sm25242466b.136.2024.12.13.15.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:52:51 -0800 (PST)
Message-ID: <309303a2-995f-400e-9fc3-c24b5ea703dd@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 00:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: Add support for QCS9075 RB8
To: Wasim Nazir <quic_wasimn@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241119174954.1219002-1-quic_wasimn@quicinc.com>
 <20241119174954.1219002-5-quic_wasimn@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241119174954.1219002-5-quic_wasimn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: --qHNTMRnqHf95-M_We_p3WKfJ9H77DF
X-Proofpoint-GUID: --qHNTMRnqHf95-M_We_p3WKfJ9H77DF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=781 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130170

On 19.11.2024 6:49 PM, Wasim Nazir wrote:
> Add initial device tree support for the RB8 board
> based on Qualcomm's QCS9075.
> 
> Basic changes are supported for boot to shell.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

