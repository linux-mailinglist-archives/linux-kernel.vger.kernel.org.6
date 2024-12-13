Return-Path: <linux-kernel+bounces-444999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF69F0FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D293B1889322
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4F1E2009;
	Fri, 13 Dec 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9lvwmVF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F41E0B7F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101643; cv=none; b=MWcfgw4BKIlUad5YQOnf8a+89NSQdR3q5GgbM3MCZvT2I8cQrGgvfRXaHDbNNFG6vvV2jBqEsB/npZifdGhpgKiYNiS/drFnzzthuTQI76fmH/agSVDyrxinOjjk6zZFYAeTGwS47uMbrLS/cQulLT8qWNJkz4sE00Vr+I6bemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101643; c=relaxed/simple;
	bh=CH3mLT7v8IsunUYTHNbeDiMX86VuRK1OCaIdDG9clto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjaPCr0hW8lVGm+9UZsCLwFyGqvAEoV9vsAiCa1p8y171i6R2mm6X9eSeosaf9qpWgh2mdZnWtYS0zqKV5a2DMa/hFbW+mTmClnqGiquLBjMYlhLc0pyxptR323kVhxe0xc/gqV02ZUkBmrv1c0XSgajkKSCdobfdc6IkIJ+skc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o9lvwmVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBTo2H001404
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJ0+RquiEKp7rrarVQZM02Ew7/RBU8iGygX4fyM8G+w=; b=o9lvwmVFWgAZjpYW
	x5urWmDK4X1sJn6YVxSR3K4GtBwk3qIUH+ZNI72Uvio1szt+t7ha/dhCVs6VeP2Y
	0u7Lgsn1+1rFUWEKdTTJ/RfL4Cq8Rc0lEnFKYghOx2l2Prq8pWbbZJDuKfsNua3g
	ShZACQQYkOLLxrwDUpER+2E8nIdRSMvFY270GthcGhWbNqE4/1Hoxjx88ruRTql+
	CSPvmhWMvZXLfyoGnfh9SbCW9yLGF0IOqIbyqghH9GS727kU/0ZRo/UIw+dTnQpH
	jXGiQhfK/Yp/W2hbjO99tRzxyjpaJZsqXPMfMEGoQCYA6KXFJzOh9Y8EiEydWaga
	fhgnzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gm3s0h6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46748e53285so3693891cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101639; x=1734706439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ0+RquiEKp7rrarVQZM02Ew7/RBU8iGygX4fyM8G+w=;
        b=BbWdTtn1VN0bbI49EKw6ecDOueaTmKKmPUS72AW8nZ88mfpz2P5UOybtYi29Iwko2/
         W23+IT/jeqlkrn41MVsrSTRKocCTr3a4K+cnumAT6lgQ/+XkqF/r0TpE7QrEiEYVpwEV
         QXh5UKWZle//bWnxF+qupSqgByQFYRmVQeGfCDreXleHHqXMLRUCUv9uvKFFrwm20Qf2
         zEAoVtYOisqfapgHPILW4zGGafy4+LLx84f489IYtBdxMNGAO3CYQHsDJ+iL2F0Ny7p9
         KYDvzmYARBgk5YswK08LUTFg7dmxcEXq3K2/BPuHxfO0wFC1tPFOf3mu3AEB0LNo+DsW
         Q0WA==
X-Forwarded-Encrypted: i=1; AJvYcCVRCHmi4dEUK4P+V5sKB4Jw4Pax4vzO7L2mcu74MN4PcIpusOMQjH/eHRmkhK7Yon6Kr4KmJv97/BY7r2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymAz8gWGducJOcKjSBzg6QpcNzTBJ8BuFAHiiVQ+i/JLp/aUSo
	bTIMAyCor3oq07T8Mb1kB4CGvUXTLypAqftkZgp39/tuddUjGEhua6fxNTmtHh6VnTbUaexSACM
	EjPf14hTgkbcLsm95o5Q0rWP9iFOzxtWsM3phV99S0PotI2GXQ+NH2JdBTzPuEQ0lkEzH1GA=
X-Gm-Gg: ASbGncszZq5lw4wealpMfJgRz8XozbQ3ftn9slYwVtGxgFZXqedeLiUpyWXjLUVhh4S
	ZWTfW3M9BJO/fT/zLoIYvUC29NI3Kyp75162iudTaXgDZSOB8fTz4WB1Kuxb7Ekbhwmxm1xo5m6
	1A0vI9n3rngvL7h808zNdCAM6x+6JRMznKsuBPYHkamotUCvnZPdUqeHzW+2w6aHtZ6GypPXqmZ
	wYx825M2HfzyH7BAPospGVsVrX0BdzWlKvsmeu5Zo7I0PpphvdrvuI8K2w5M+PwBk3IYPgD3HX2
	l/Dp7fIQDy33DKCc3wUkmwhGOA5DQi4R0u40
X-Received: by 2002:a05:622a:345:b0:467:58ae:b8dd with SMTP id d75a77b69052e-467a576e84bmr19529291cf.4.1734101638773;
        Fri, 13 Dec 2024 06:53:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm7nyEai7+LBryXvXeks41c0FwnZxFSCHsFVk3yvJUOaPVQjvDlzjPA3p5bBG7PqFH6CICrA==
X-Received: by 2002:a05:622a:345:b0:467:58ae:b8dd with SMTP id d75a77b69052e-467a576e84bmr19529061cf.4.1734101638300;
        Fri, 13 Dec 2024 06:53:58 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dbf898e7sm8899985a12.16.2024.12.13.06.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:53:57 -0800 (PST)
Message-ID: <17897300-3c9a-4467-867c-3dd2ecb1a766@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 15:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add Huawei Matebook E Go
 (sc8280xp)
To: Pengyu Luo <mitltlatltl@gmail.com>, konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, chenxuecong2009@outlook.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        gty0622@gmail.com, johan+linaro@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <c344a212-1932-47f3-ad0b-c6f65362a699@oss.qualcomm.com>
 <20241213135055.600508-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213135055.600508-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZsnSgijhiS5GgZgjhCxnwPE1LVxzC119
X-Proofpoint-GUID: ZsnSgijhiS5GgZgjhCxnwPE1LVxzC119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=340 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130105

On 13.12.2024 2:50 PM, Pengyu Luo wrote:
> On Fri, Dec 13, 2024 at 8:57 PM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 13.12.2024 1:50 PM, Pengyu Luo wrote:
>>> should I attach the all?
>>> # dmesg | grep -i 'adsp '
>>> [    0.000000] OF: reserved mem: 0x0000000086c00000..0x0000000088bfffff (32768 KiB) nomap non-reusable adsp-region@86c00000
>>> [    2.249916] remoteproc remoteproc1: Booting fw image qcom/sc8280xp/HUAWEI/gaokun3/qcadsp8280.mbn, size 12950508
>>> [    2.556517] PDR: Indication received from msm/adsp/audio_pd, state: 0x1fffffff, trans-id: 1
>>> [    2.556546] qcom,apr 3000000.remoteproc:glink-edge.adsp_apps.-1.-1: Adding APR/GPR dev: gprsvc:service:2:1
>>> [    2.556594] qcom,apr 3000000.remoteproc:glink-edge.adsp_apps.-1.-1: Adding APR/GPR dev: gprsvc:service:2:2
>>
>> (Please don't top-post)
>>
> 
> Sorry, I am getting used to mailing lists, recently I write replys with
> text editor, last twice I didn't give a blank line between subject and
> main content, then quotes were removed when sending via git send-email.
> 
>> Yes, please share the whole thing
> 
> Check this https://pastebin.com/p2JyGW4K

Hm, right, looks like battmgr is not there..

Konrad

