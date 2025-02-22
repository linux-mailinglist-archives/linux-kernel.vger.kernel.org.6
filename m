Return-Path: <linux-kernel+bounces-526867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603CA4049C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141FB19E0B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563517E00E;
	Sat, 22 Feb 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKr4YQz7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F742A1CF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186942; cv=none; b=o56x4xPz1ABSKj3i7yHZtxnEHbszlr4pPFtBOYAkvu0t6bGojI3FtL/1MM2SAmfEIG750EbLyTPjiqdj2qyyV1qLzlr56c2Bna9fdmr4e1vC8y6Ifr7I3po9NFBnEtYlTvuoCUqZZmYzzeG7/i8nOnEWA6TjwTkj5fEfZyJTkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186942; c=relaxed/simple;
	bh=kcM168HKI5Jed1r4nVUAyCHhMXa/UH7cpDzt4jG6/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiLgDua8A/nbbTC0v04w6vpFEgx2fvJhZd8RScxqjqIVi69GWneeeGMqiP9MV19Dp9XTkTupR3/wWQesgB958aFEQu3xPf6b/8XAslTX6AryNCi8qODFFN7gcFi521Y4xfTlbPduI9W+ZnVvcTPUqP3tFOgR04f1q5P1Ep6ueeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BKr4YQz7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCkuZe031803
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I+TCfbgcqE/1oBoYAt4RCN0sS63NXiTuGZp5HOUUOoE=; b=BKr4YQz7LliFUlku
	LcCW9f9R09vIJd9kmTsrUvkKi6cFLFnKKVHHC4hhjS6FCuFDnTEOoYz/774Hmc5g
	DNVBNE76qodVK50k1AE76/U83UcjLRFBlbu1aDpfew1RUDIKYTUdqF3EuYlh4J32
	JYhOWL8pZAFoVep6ZLmMV8LjbCilaCTcX1V7eFeNaz1fL/8lWR4CcKIZnjjAWPZZ
	rbi4Kun5YSUd1R/fbl+LyWDu1NmjffoUcy4qIkgH8C1vi15n1tcIp0UjhiFzWULM
	UIB6M7vPD5wbxkoH6IMXns+aoKlUqMx4MtMracpoVCg7B5Ba93WRG6+iR7aK8mpm
	++Ijzw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5kj4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:15:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0c491f065so36107285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186939; x=1740791739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+TCfbgcqE/1oBoYAt4RCN0sS63NXiTuGZp5HOUUOoE=;
        b=IqzmWP6XvU3ZtkPkZ4MMd5tmFbT9cRjje/t4yqxH06uLaTqRjaRx0WfUjJ3qP7Dogl
         qN1+Pzs/sLN6yMesOQUJHk5u7coC683BnzursmriQRnNfTJ0PzRytGXp93DX/HyP1gbG
         aRgwVW9vqMoIpilKNNk5I3undx06E3Db9j55F+BhIB+lobGJnxisCzU+3tJf8nre9dNb
         e+AZpJpMiCdwZfo6wTLQhBtPHaXTaQc4r18CVbOElFOujl8C8Usdn4LnHJ+IYtUK21qv
         e2Emgjsrs3Y0guUpTEsGm9jnKzlzknQvukeCuiTgvH8QsUH/lexZaE6eFLgvMFYIh4Lk
         ViIw==
X-Forwarded-Encrypted: i=1; AJvYcCUIifWP4VgGg4ysuvxFHr4Kt4wBZecyHZPN8kKy/YushjWBFLhXYHbKoAaiEqYNmJ9nQnzW2QEio/c4y6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmK491rPy1esr/dycC2kNBnRe9qEkxXjuubJ71LdR4l1iWvV5
	hKYZ9I5reSdefVO42kdwcMN0vdZNl/mVVh+Mg1iMiWNJ3M94Yc9dm1pP1YieSWiec1J14vOD7qJ
	nlQzSU0gHk0wjvydP/HDEKOGoB3Rw81eZp8Ax2yAh/17bShxmNsNKHZcx9u8/De0=
X-Gm-Gg: ASbGnctQNAibJyvN3KuUWRQ4cUxsEFfZukkLqdLIqHjjZ694p2igOeW+U+6vVzzBcjj
	j4zYS6ZQR2MSBT9VHl5jmerr35H3GzcGgBEWBQBnFkQqhK2MrHTbtvMAojQ/RujW4pZThCwhs1w
	Kq5nMz6GgYxSTxIPNcu2uMqYVBgBfa1sB/TKo91Abudt60xNzuCGBnuyjUUzYa6+aI99XDuXeC4
	/Z0VM1iRcw+5jLjU/QKKKqGoKPzI+7JxHMOiS29uYzSp3LgzJGCFNC02LC7hv0/iFAPe7QL2rFa
	tKEsi1nJ3iNNj4+HNER6/y/fo3w33Tms22NoS+/UJwzurLuc3ZAwuqokyavWC2MHRPRlkw==
X-Received: by 2002:a05:620a:2620:b0:7c0:c2ec:e560 with SMTP id af79cd13be357-7c0cef6c8bemr300407285a.15.1740186482354;
        Fri, 21 Feb 2025 17:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGSlx+o7PycgVPhhbvjZgQJlB+2/vJecp+ZwAE1CaGp8FDGTYUWBZmppwJ75uZfZwTQOsWXA==
X-Received: by 2002:a05:620a:2620:b0:7c0:c2ec:e560 with SMTP id af79cd13be357-7c0cef6c8bemr300406085a.15.1740186481963;
        Fri, 21 Feb 2025 17:08:01 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e8dsm14342801a12.14.2025.02.21.17.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 17:08:00 -0800 (PST)
Message-ID: <60b4da8d-ac1b-4122-9dbb-2450b0f5b6de@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 02:07:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: enable sensors DSP
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
 <20250222-rb3-rb5-slpi-v1-1-6739be1684b6@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250222-rb3-rb5-slpi-v1-1-6739be1684b6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2YgXoYCcpSViHTUhXKAaMxCqU5fe0hlD
X-Proofpoint-GUID: 2YgXoYCcpSViHTUhXKAaMxCqU5fe0hlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=806 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220006

On 22.02.2025 1:43 AM, Dmitry Baryshkov wrote:
> Enable SLPI, sensors DSP, on the Qualcomm Robotics RB3 platform. The
> firmware for the DSP is a part of linux-firmware repository.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

