Return-Path: <linux-kernel+bounces-446219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973649F2144
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39E01624E1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C31B4150;
	Sat, 14 Dec 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrfvVctE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF81B3949
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215237; cv=none; b=GivpYXUFWCrVkuVc9w3rHnF/3jlM03l+z5zJWQlvN+JP/Dba+spo+2s0FM28OMDSs3GrNVSyVpHNaQBFB/MppSnSe1C3X6Q0RWpmYlzjJyNK68a9HgmLK6oU6KT5hk+f5UzDFrsyHEmV4L8voEErG3vKMV0Zknle3uEwFhug2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215237; c=relaxed/simple;
	bh=4sVDpVE/Y9aJqvtHiq3xY3rKoZ6SRs2KeWCOfv+kYWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al2JERJm5OxkL5Sxe32BDWnTGNkIHmA4EK3hk6xw+WgCnSvN92JgLdwsCvpRH0GOH0FXUmT1SCR66HD/+e39tcPkg2ZDAmXjjaK93XZTMD4IGAxAvFl8c800K+E4T16VqwWeqw2GJLdU+00q7Dkk75Rp0K/4/vYw12oieF8Yz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrfvVctE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEMCKNf015961
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WUyEk9N0WDqw2fKvVZTkA/HKuvY5U21X3H3Z5ETR4eA=; b=KrfvVctEe4AEIYJG
	TpS7TtytxPjWgaXF8S8/0lvnvn1BmMySPmAQmDoT+qPl6eI2WgMg6DWsxpez+OP8
	0CXNwgdfGXXWo9N2d2knS+pjKjB7NSr9HIcYgfjvbpzTmqCtGisuYlOwkzb0jaw6
	qrF7nD/cCQUIhwAu8Xv0Jxevdn0nl25JEljxd6uNlM6f99M8DG/zk2vsaT15nynj
	gE6Cg7iNOFjq6N4kDJLmFiy2aC6xwzghNzNN8jQC3aWJs572pCQi72C2WskslAeE
	Juhx9wAFDsGXmoQ5zA2amT2S//s4adKQ9tx+5RTcQ6PgXYSG/zYUApn7bp4KQE+I
	+DZWjg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43h36h13w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:27:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6db1009a608so6705046d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215227; x=1734820027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUyEk9N0WDqw2fKvVZTkA/HKuvY5U21X3H3Z5ETR4eA=;
        b=IyTMnRhSCL3Cwaf0aNeR01uv8M+g6F921GYcklQmB2U7B1ZMDJAdEVeGx5YgEp9rIS
         ZicViJ2g9XSeq7CvD2GoT+IzMUmm1R/+L8W5wm9ncL1x/Y5F1hJNwvTa7eTwry/5vwnO
         Kben0Yc5/EneVBHT7582jwopkbv0te/5OW/uJIoDZTg95ZGy+3FIhPrfhNp2TVhawB+y
         JWsCdH9/HN8/pgHDW7uQZFRaA+iw6zEV0W6PZcbSRK9DfQcJSOF5bZswqsbNNw6k1x8+
         WyTz1Un/rNXyWy0YbsvjAziNdw8gN30Fl9XsKyQyi4g6C8Mb0T63+Mdv/WSmjEdUacI+
         /RMw==
X-Forwarded-Encrypted: i=1; AJvYcCXiWV9ydiKEQXS2Kbshg3oiIh3fP05Yt6cpmrEoUgh1gUbf2HpcU54mZRc3eofl3gICi5fqeuVdpXS/bZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuZYeOi8ZDSQ2U29oaasv7/GweWxxQ+NTFWlJa/Pvmlm9SGB/
	JlUSUIORFlDb2pXGOqQHqTPGWHTHCSeCMDgZXc6R1Mg5P+VO7slhiKj9kBov/2wIZ1Kj5Oo0OSE
	aZAeXq8Gtyl+FYJyMTyAlNkF7kE5kxOOHj43rPI7fJnuM3DJAkwZSJlIW/hz+hy0=
X-Gm-Gg: ASbGnctBofteSz0ZAz0USHYYO2uXYnTBCGEBgEoFuphhXOfYQgKDGN9MuqrTK4ate9j
	FwAXpFsngS4naMtIGl9uH92MeKoxOqTTg+o+NkakO0yJ/Ir4RFvTBXl0b4EZdD/F3t2K4sjdn5p
	DhzbyWnMz6sHAoCNGxcVlGd0e+yo/Qo3912XbuNvjALsYEXH7MC3ai4eky70CcYgMAcowxM4lAv
	g4KAsoLXsmLPWzgZrAzY2rCtX1JXpH9WgQEiFccxU8FdDFdAgDBUHdERckkTs4JZcf7DG284Vpt
	JHFwpCGJVjiRjPMlZkM6MnQEYmgyVBWYSfY=
X-Received: by 2002:ac8:570e:0:b0:467:54b3:26f9 with SMTP id d75a77b69052e-467a5748aebmr46264821cf.5.1734215226767;
        Sat, 14 Dec 2024 14:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/+/MeuL56FY9YXxGv3jp5sajc9lZ2F4Si/Byr9CgGpkIT6bqlx8CUjJl9OlwGEkZEomusnA==
X-Received: by 2002:ac8:570e:0:b0:467:54b3:26f9 with SMTP id d75a77b69052e-467a5748aebmr46264761cf.5.1734215226377;
        Sat, 14 Dec 2024 14:27:06 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b4edasm139441266b.182.2024.12.14.14.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:27:05 -0800 (PST)
Message-ID: <81fb8975-3b27-4d4a-b04c-3535b7447408@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:27:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-serranove: Add display
 panel
To: Jakob Hauser <jahau@rocketmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20241114220718.12248-1-jahau.ref@rocketmail.com>
 <20241114220718.12248-1-jahau@rocketmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114220718.12248-1-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: F2ASKPEPzWP4Db9xVOMp737VXEw3ebVd
X-Proofpoint-GUID: F2ASKPEPzWP4Db9xVOMp737VXEw3ebVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=821 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412140186

On 14.11.2024 11:07 PM, Jakob Hauser wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
> Add the Samsung S6E88A0-AMS427AP24 panel to the device tree for the
> Samsung Galaxy S4 Mini Value Edition. By default the panel displays
> everything horizontally flipped, so add "flip-horizontal" to the panel
> node to correct that.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Co-developed-by: Jakob Hauser <jahau@rocketmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

