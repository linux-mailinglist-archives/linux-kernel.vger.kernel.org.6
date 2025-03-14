Return-Path: <linux-kernel+bounces-562244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90BA61FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254D316CA67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4E1C6FE8;
	Fri, 14 Mar 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGu6UviF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9E1ACEC6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990097; cv=none; b=a4Lna96hz+N0ffO6RnPJ3tO4NGalqK4b0n6+Tq4f5rScFFjhC1gGEVAjtXmnYY1BYeZj/r3Ussi4V/9DVthTOrWRvWr+R/mjRzIaKSIzwxRR6wMk5SO3lDhWrD0LSRFfCOH16jweLlfeQYx3G2JlaYHRnG4LIBvlE9N9H6N+R+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990097; c=relaxed/simple;
	bh=jp7zp0XEMKSmfDPDgt4XGymSrntAbWSW/TwBN8UaChw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St4LlZ9me7TpHvq+e9bDq3hEulXzt3MGrYsK9wEActHQzeXW33tD18CNYyrfHJJlZQcY5hoaAuyEllPQl3kKHFi34UJzgnvxVt8exgH94CwpkkujxEPP5icdhYnMqEJc0OWuh4IciXju1aBxsmaVsKGla98Uk8N5wtdgQ1vjZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGu6UviF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EEQYkf008648
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hm51JlcwZKu0qNKQYJdKG1AEr0/67IevirTkdaw7cAU=; b=EGu6UviFJfIQgfJg
	lhKscTd6XjQi950aUlfQNc+1EythD3ogVJCa6kwltVNJYdaFe8pX0QiFZdSdwl01
	shdvejqodacAqNl3AmaASa6dUyeavWMg1J+r6CvNpz2ZdKxnlWSMRuQKjNryszPz
	j7BhFyuqDLFv5R7cGKgTY8NbX2frpdxz8AQfPs4FQK+y2c+V5fdhw+ih4yIjKd6R
	HH6423PnXjHolA/ogBvV9AikPGwfld1c/4Mjwz4yvf7CCyibo8AUkNtiIuuhnjKp
	nRAqH9IPFMuul/idAGLE1ovAcjFw0DF40IXg613nGTtJKeA+MF+6TWcRy+8w978F
	LlPmxg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg8ed0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:08:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ff8c9dcfso7399606d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741990094; x=1742594894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm51JlcwZKu0qNKQYJdKG1AEr0/67IevirTkdaw7cAU=;
        b=EefeL5dp46j+5rDK2kFDJWTLZ+XNAZrz0RmAlbO31BrQmM9vFHkA0+i8TgvH/gzwQU
         DaaYfs79gEVylmmoZF8YPs6EGFFvt70qmWCKKxIe44JyjMyzgKmujyh9ircZ5sOn9aSL
         WiCzXKh4ZP5oPCD2rgND/rXbFnBglf2UPJqvrBga44WXt3Y/Dn1QZEwaCmr2sPs/9zf/
         y4PgFEJMnVvQUlIMWZ8EXeVCoRrBlGxCbo+U4S2il9FQQiJ8NNqHY+wPJS6OAaK8N7wQ
         1gTx/jDakGqHEpgoZsCg8OJDQo3xH2r/6O3nQW+ugM0zYWX//VbFx4Tvb8VbAChxkj3C
         wc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/JW+sgbQlbKiBLWRgdj+PjkVVuW7tMcWUqNyscqfkhXz47mGxXjIENQEqaW81ptjkVyP7T/ywRSV+9yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJbChlknvvsHnwoeDNVZaMqE43rNaXw3jluQaOz4qLpmwreMm
	M6M6KZl1rDFSLMkIadBZz49Iqq5a9A2QueYlu9dvywcT0vJx2J/yxJi3xHydf5sWMtm6AvZA14y
	Om7MeXMhp5xhOyLeb4Pcxyuu1/kgoQAsBkmTgr/FVoIxbyCCXvqApHk+LwN5l925c/WXmLYY=
X-Gm-Gg: ASbGncurxP3CX5hBhTm4njJcOMwTKMvSNY5kTn0NFOP3CkYhCuuBOkfsDQOSCRN1fg5
	2MO2Sgteiq5jh5cn4CURltWBARKVsqYyd2+KPX8n3it4eQw5IKgBOHJr6K2Y7axKI+2NUIPUGac
	bIY+guUN0ebW9uqNK/r4BMqMRT4KNStdasrVhpQIiDztttH7IPA4o84NJJsVyDQKKZYa2CyzIwQ
	12m68mSEt6yf/BfYZJe3Sh+8O1sfgIW5tLcfY8KxTmShBSQ/jD5PGxbJbVhB30/1RhQl+EebcH3
	K/D3kurAOQCD/ltLhaF56Qkp94Iqdnt9L0Z6bVtWCc68IjIcdbA14fYlm8jH1pQNqT5DYg==
X-Received: by 2002:a05:622a:1a14:b0:471:f08e:d65d with SMTP id d75a77b69052e-476c8128d1dmr20172161cf.6.1741990093984;
        Fri, 14 Mar 2025 15:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhj62oZ6yLYlsV/TtSfLeq7Hm5YxgXz6uSx4Btn4goF1iNBBLb+Nc1jWYJOyJzLlYR6jOkAA==
X-Received: by 2002:a05:622a:1a14:b0:471:f08e:d65d with SMTP id d75a77b69052e-476c8128d1dmr20172041cf.6.1741990093690;
        Fri, 14 Mar 2025 15:08:13 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e5ebsm2396301a12.2.2025.03.14.15.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 15:08:13 -0700 (PDT)
Message-ID: <cddcd851-5e8c-4202-baad-e56a09d5775a@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 23:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d4a8cf cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=m3AVSQT7pDQk2eD9g64A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Aao7yNZhF0B-3Zr5M4QNyH3CdBQ3-pJd
X-Proofpoint-ORIG-GUID: Aao7yNZhF0B-3Zr5M4QNyH3CdBQ3-pJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_09,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=973 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140171

On 3/14/25 10:17 AM, Luca Weiss wrote:
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <37500000>,

This rate on this clk requires opp_svs (not low_svs)

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

