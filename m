Return-Path: <linux-kernel+bounces-444671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA59F0ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF41881AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2681DDC26;
	Fri, 13 Dec 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHRzpVjj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180171DD871
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088738; cv=none; b=ly4UwCIUQaaiwX4obqjDM8I1Q/mKVdal+YxRYPCgqvXRmVIgYJZ+uDDLbjUaDOsH4fEt3gU6XI20ulMmq4w7wlY1k+khFSUNpjcIbizCIzrfeswLBHUs9uv/sFeCzbpj9/C8qWHRX+cIWGTL0laj21b4/2g1c5G3eRF2JW8FIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088738; c=relaxed/simple;
	bh=auNuVg+Uq01zi1bIh+gO7UoyVpAIBt6Xmw3RIjeDju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSiRMC7IZTjMaR8l1YseQis6jS7ZRwyaPvJwJWcg5xMSuDy5TeAimjq0WabCNKGpKvcle/J5FuMoBLmVR3Zd1aQOA+lFEVjHfrk8YiPKIST8Q3In2FQr5GcVr85vI7qRe56aAiFwMSrw189rbrm04eCKfms+fHbcWwjNa7Gjjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FHRzpVjj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD464b2018025
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/TQKENLvmprGOW1/Wu3SkBKRJf47l5oWgnMdRrCuEI=; b=FHRzpVjjz7wcMkwZ
	W27T6yxjzvmsYuiPzmedpeP4fEPqXr6E8enQCfNUhY4r6nSV2kcTJr7RhBt/QpOf
	XPwzkq1E4DQzdNH68VWyfT66rjvG1ns0/bS729Gca1mYJ6TcrmovRQcUkCTYrhkp
	WYvZEWlTuDym7+K19apfTZoHxejNVlDKG2s7sZWJbE20KWTknV6R1NhoTVHmVDI6
	lQg1xzYmwvGlx9r8oM/b79Tb7ehQkCej9xGeeswx5NtAg1NCsf1uXTc+6yXJXqA0
	9uXJiWzyZCJSmtlzm6ChMHl7RP6S4M5ZHMT098GGtDJG855QmqCAcUjTM5sh0qsd
	TV6weQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gdkn13nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6db1009a608so2921976d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088734; x=1734693534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/TQKENLvmprGOW1/Wu3SkBKRJf47l5oWgnMdRrCuEI=;
        b=veP2cb4YrNEpfEqRn/9EUdySJIjr6HECO8Nql4rupmuGvuvONjZ1kzV/RIzBf8zeF8
         GMi8NVftgfz36JD7t7QPBs6vVDo4k0/cYvQZxpf+7siYAwI0lvO/LCaF4ONuPHqg4FPa
         7kGDNDZqWTFZrkRrwLMD0pgGEVPqpWerCC7Xf69LuMdfvQCgYXcaG0mCVqLZm12u93Tf
         5IT4AgFO5TiUIlqvFPI3MNOxKvoaXGMgsy4+AZYv7ynUWjwFrnoNC0LVurB4Aetr1Lnq
         eImBtcpX4wHUxcbAATSnzropZ64TCJ/JG9Hg0PqZdidPuaGg61B8bCfew6NGqynMaYxP
         n1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN2+m532wDT71UU1649IwbReax4a5jO/Um8HQdkoUMUpwKMoCk4Yr4h5pKt6XpQXStRJVLIRY68GuHUVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjU3nb83WCQG8EhqejcLGeLdAW3uaGyYXPf4FWDCG+cHk6bqP
	aOWxzetvW9f96em235b/mdpS9wgkFhiJjmSN/+8DJRAbD+uRo4I7D9hVdHKixlKXLBFWY0vseHt
	nV6WfsGgnYcXbrD+2NG1cGWSfHk2dDZ0lx7xvGytp8KB95hYr3jt9+csrV7CQisg=
X-Gm-Gg: ASbGncup+uoZwWOGlk8E0o0+MFN98EbR7jkKqrxSGnwKHMiPPUq/1Ca8pe7Xkth4MZ1
	60ve+RVQ9G0oSgIeUc38Jm2ZvESrkTwA2JT4M2JlmceArg9Z5h/XhsyFQqe/8XMChujyi6wAayA
	Pkb6m44OnJ/wPNV1ykxSw3Re0rCLg0jCDDGrw+3Bw0Q2oqkpCByQBVhVihwPLLLHUWzXgBqJ46m
	U2irvAM9NDE8lmglMWal5xYtlBGL71qvXlB3ijaSbcUY8v0rfw2xUX4QO7XzElYCxF4f9TeQ7ds
	spf/okn57spIIS9tbM00Qz6SBBmftHvrbW3H
X-Received: by 2002:a05:620a:19a1:b0:7b6:c6f8:1d28 with SMTP id af79cd13be357-7b6fbce2263mr128316985a.0.1734088734273;
        Fri, 13 Dec 2024 03:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBR+cUBdvb74XuOejNI9mYSykpjh49aeXCJst5j85GNfPlE4TY4ja3JXn/U1G43w2NwwSbUA==
X-Received: by 2002:a05:620a:19a1:b0:7b6:c6f8:1d28 with SMTP id af79cd13be357-7b6fbce2263mr128313785a.0.1734088733880;
        Fri, 13 Dec 2024 03:18:53 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48ab4sm11339660a12.27.2024.12.13.03.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:18:52 -0800 (PST)
Message-ID: <d397065d-80fb-467e-bf41-0f5aad882a15@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 12:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom:
 qcs6490-rb3gen2-vision-mezzanine: Add vision mezzanine
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
        todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        akapatra@quicinc.com, hariramp@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241206191900.2545069-1-quic_vikramsa@quicinc.com>
 <20241206191900.2545069-6-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206191900.2545069-6-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CUZsdqYhrNxmzYkhR8iQywJ2es1odpPw
X-Proofpoint-ORIG-GUID: CUZsdqYhrNxmzYkhR8iQywJ2es1odpPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=812
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130078

On 6.12.2024 8:19 PM, Vikram Sharma wrote:
> The Vision Mezzanine for the RB3 ships with an imx577 camera sensor.
> Enable the IMX577 on the vision mezzanine.
> 
> An example media-ctl pipeline for the imx577 is:
> 
> media-ctl --reset
> media-ctl -v -V '"imx577 '19-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
> media-ctl -V '"msm_csiphy3":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -l '"msm_csiphy3":1->"msm_csid0":0[1]'
> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> 
> yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0
> 
> Signed-off-by: Hariram Purushothaman <quic_hariramp@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

