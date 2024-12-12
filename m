Return-Path: <linux-kernel+bounces-443309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F49EEC91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8E165B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E918218EB5;
	Thu, 12 Dec 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A30Wh20J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730A2054F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017640; cv=none; b=ZFTT9a6mLN5CvcvGGubxwo5mLQtxWaK++RHTnTXD1dBkBEeAY0IYPH8lR8IoldiqPx26N3uF18pPo9UKv4pdcE0EPLftv+EK8wqBIKn/VndHKRa96GUOqwSiZpesrdRLm48nROfRvHMi9BvTGRzpNnuJcHM5CS24NjGqM88DNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017640; c=relaxed/simple;
	bh=h7Qvbd0DgfU3DhtnwKA4sua59QGqX8BbaTXcCwT4uuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx1ih55Xb9b2c/I3SR0XalsoVGhH9OR4SgteEDQ8kyYjSC1RqwAlsKWtakNgYBKe0VH6KaUcLx+zA2iC9DjrX6Yky3esgtd2oM+lssXJdZV6j3davlsATJ5ZbxjLaLtf2ZeaZGPM08/Jpbnc1UxqSb4KDdIBV0rKpOtfJIxKY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A30Wh20J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9kf4J030541
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xcobdIQSpd1y7u7mA+U3MsRd/GVP7Hr3qs53FdCE3y0=; b=A30Wh20JxGW7dZ7P
	t/40sGGl0ECGgLK/GImZuwI6+UhSM+SzE3h8mkz3lnUDmDEA8hHgGX6i9KkeQHRJ
	NlYq2lZ1ljbG6CG9v8hhNL1CE6NRJSbANwMwTdj+UAUq8z+1ZxQO6KkTJdOU8Rs0
	kmo8ddfU3iVwywn3sA6HnH3kN63o+VOmDOEP0oV+9rlXZTL6TMn5zmQWqt+fmTXg
	UdUfDLvKoT2PU8zGWT4RB1yhuCcB23/vlryP6cAabN2BRivtt1dMapwtrN9PG5P4
	cUco+bcU8nD5vm23a60t8Dc5nDHk/r4LG7y22+VqPz2QeZw8jdt50dxUQpRrKbDz
	7HkdGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgegxur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:33:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46763cf8565so1706921cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017637; x=1734622437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcobdIQSpd1y7u7mA+U3MsRd/GVP7Hr3qs53FdCE3y0=;
        b=D+tYhzmW+8X1Re0QZDYe53mNj8YjUbd4K6UXs8CEOOGXGSlBxlXFKYNWUdgeWzBGcI
         Zg2slVKT8lfXni73m6kBywZEEinqjDR0PfL6c18geKzBP8l1MYxEpt9jG+dvvECfTjCt
         yqKA1ThK9Zpp0cUE1NGSwY5UNblGQnbBmaHGKc+ZI7g9JsucYPTSTdR8Ej5xNNHoZaQ9
         U0GCtfBvfZp1+94lMRKq+Ca1ly/SGL6M//jm1bCjKqG17qghvo7RXzly67r+5j+EIsAH
         Sje1at8cOTzejm0d3aZvSrpmsAjgVfMw+gt/bmOlXnqOx6GbxkEOIbpTwdvEGVWf9qi7
         G2wA==
X-Forwarded-Encrypted: i=1; AJvYcCUgYfuM9q6uDxWDn9hpzPupCYZ1HSruY8isPEClR8SWj1s+ZpVtMDFCP4vGeC/9+BzXZKTJBGyzAfzURAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsRjuzXoL8zPUd35thBgfA+pNhVFz2YWBYfQg9axItti5RscG
	gUCfu3Gs6zwv8IquKtjsQej/QD7W4MRp2DbNASRshWEzQoAeRUAXrQvGYlUAeYpqKW49qGfFYyy
	PxD1J3Agi1Wob+kcYdLjI56vu4hgrrzwCoaFCQBsfAx+1j2rzqr0DZX1iHot+LU0=
X-Gm-Gg: ASbGncshecEYgk8K8Y7ssPxEfk4DGvpuKMFFWNSzNJuQrWMP1TwfI7S9zbmJDrL+nU2
	PgQQoDH6HsqfCvk9jHvjKkdrHue1kgXqzOm9H+Wj3bN5svkiBdHp57onul+ZnQSAc9UVCe5aErm
	V7VKAJU96Twi5HzWNFx5skSZaWuNVD6n4uEAD0tzt3USQIXR0jyoGR9rgDv1fjxn3DblEnPdzt7
	jFwd65wbs577uWn0CUDuHlCElhu8r8hf/sVcg4TOVuchry9kZGfAuM1vVyXy/ikf/eZ22b8CU7l
	g70BpAj2cvGhhgiEuswzw6hVsY/xxFVWOaNtiQ==
X-Received: by 2002:a05:622a:5449:b0:467:5b1f:4060 with SMTP id d75a77b69052e-467a153f285mr5024851cf.7.1734017637059;
        Thu, 12 Dec 2024 07:33:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4+pzgX907kDQGDvoWeY/ZuCSH3vIPzYizGVrQ6+6iRhZfQ77zqHdERamPlv68id0M38+p8w==
X-Received: by 2002:a05:622a:5449:b0:467:5b1f:4060 with SMTP id d75a77b69052e-467a153f285mr5024701cf.7.1734017636720;
        Thu, 12 Dec 2024 07:33:56 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa684d6eca3sm614870866b.141.2024.12.12.07.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:33:56 -0800 (PST)
Message-ID: <33f181bc-8387-4f88-a754-0f05dcb6bdff@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Enable LLCC_WRCACHE at boot on X1
To: Johan Hovold <johan@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20241207-topic-llcc_x1e_wrcache-v1-1-232e6aff49e4@oss.qualcomm.com>
 <Z1mZubWYMxPaHx70@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z1mZubWYMxPaHx70@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CN6kR1tMmoiyso1m-nqxkn_YRdYIsJGZ
X-Proofpoint-ORIG-GUID: CN6kR1tMmoiyso1m-nqxkn_YRdYIsJGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120112

On 11.12.2024 2:55 PM, Johan Hovold wrote:
> On Sat, Dec 07, 2024 at 03:04:26PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Do so in accordance with the internal recommendations.
> 
> Any hints about why this is needed?

"it's good for your cache to be active" ;)

> Should the fix be backported?

Most certainly.. I'll resend with a CC stable and as per Rob
Clark's suggestion, with a larger amount of context to make
sure this doesn't get stuck in a random place in the file

Konrad

