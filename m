Return-Path: <linux-kernel+bounces-445060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7699F1092
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12DC1881B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095A1E2838;
	Fri, 13 Dec 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mK8J6k93"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3391E1C07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102656; cv=none; b=oVmWtzbmTkoCF+jxi9HAMn82SaqYPtpaMxRaLoOSrOD2RaLR9QGZDg1pwslCxZ/IYTW3fos9nxiOyLHvGmYNYce26FjbdrmYa8WMgB3uWjaRnnIlc18DuoX5xg6uSjJl8a41IfVi6dufmAyFOoWgSdwRBWmxAbcsBSiDtpIbzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102656; c=relaxed/simple;
	bh=pZkTUNEPfwYzY6QCzWwAaHbPeARAbCFotlemTTF01C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH5c7Vam8LI3PPCblZN++WBnAWI9Xzo6qlNy7QSB4wHcEDCzVxPPn1+QH2GbmKx0q/UlxcW/e0yEgKHPSKZBG7zpVSStDr62XqknIwBEyVcajBhZn15Evu/DlsZFky/IHP30kbWr1xq8iTawpKv1OX7pCjqkCA/st4uKy3wQy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mK8J6k93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhk1D017764
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LMIc4H61MSX6NhiZyaW7yQQ8yYjrJ8QN6wNQuoNHEE0=; b=mK8J6k93itNSQHVL
	3K2T9rLsizlfRH70pfIh13QxdWITiqOKxT9q6VaMTeU6Ek2qbGChXYlLlgS0K+GQ
	MBsz6hxU2GRFXe080hRCYhHuY/ja5INxatSXQWiOYSkSvXMIg2eeDqUIJ+jyeCVg
	W2OktgAHNaMPkt7haa2AWqZAyvOgLQ0iqCdDOcWwIE9mTKTWdee/A73uZHv+M1lr
	SaaWjleMW6osd4hMaIEZRknj2Sxb2dqVDpoH4mdTx9ITM+08BQ6Cg7YmTaF1eh8N
	yD1sGzaX6GMAbk76eYtOC2ZmHOPhGrSC6T4KS7BbhIDkApo2ZwLaUP0s1GqvBJiZ
	A5vuwg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0hvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:10:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d880eea0a1so5154096d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102653; x=1734707453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMIc4H61MSX6NhiZyaW7yQQ8yYjrJ8QN6wNQuoNHEE0=;
        b=l+2yjOTP26x0A/ipn9HKntSF9tMEb+CV21sJ/NdLxEx3eWs4+UqGUY+D5ojk2ZBw6f
         ZQoU9YUVIsAn/wyfxz1AeEJwQ9MksSltSW2to1tUySvJAHRBN3NahRoZj45DHpnRDA08
         x+fkBh2VLVi3N/KbGeEM//xHgDhxtoXZ8rSYbyLcQTAtMwthZnwZrVUBddwojquzenf9
         wik03oLUM0zH1KDFQM5VUu5QEAEvsvviI5KmoO32tZGexjD0T1gOkxWuVR4WwvymYJcx
         KOkG67g2bRJONT0yj8GuOoo4zvTaLT9mQ6u2Urxk/tP4TUXHEtv6XgAHASWoPCFJOcca
         be+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY0uG3FPFD6hh7qybmmjkfuGXoL3JMmLunqhMSa9bN4iBJH9k6ie9XLnledUM8z9Li0TNdoMhwqad1wwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi44U0u1myFoFYe8lwYo4PQSaXHuFCC3n4soSX2o283GCOP5Fh
	VL6LH+PtlEqqa9dKuBvudxq9CbrI6t37HAP5ffpKqiVSKKKG7djSdC77WfOwc0ykaKVHoyndIgV
	Gy2+sMOLJEwsBa4egkmCpHv0etn0+TDVBgnP0CJOYrfway2kw9xknaOcQBkeg+Wc=
X-Gm-Gg: ASbGncujkNs2NbTRR585It7yqjl7TCJn67mJUtEhKKQ3lTJjoc1SECLXhN46nM/g7Wo
	kvcl+V37zX40Xbi6BU80jrVjCrqzxGpzTUClbf5eEYVHi4Nb6Ei8qC8fB/+OIlFE8nj/49EyN1Q
	pN3wYeUaoyiBpf1SYSYuBvD3TAvViCl61kdEpE/YOohN4S2G0ZBDcIk3d7XGq9lM+qcGgUjcp88
	TWr1GgZvOawoEGIqauh0+BgVlUNbrIyAswcPitNd+sNVwFCUbewW1mzHEmC2QDR6C9fx/ubXzV9
	jGiUB9XdFF/8VYv9OORwWw/e4vITYrT5aAM0
X-Received: by 2002:a05:620a:4609:b0:7b6:ce8b:6858 with SMTP id af79cd13be357-7b6fbf3267fmr153298685a.11.1734102653261;
        Fri, 13 Dec 2024 07:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXTG+90+T6m0TzrCRgHC+VZFlf1IXbKAxpR0NrkdAYlucCrf2kmttpqZI7dcBXlrZ51YZyFg==
X-Received: by 2002:a05:620a:4609:b0:7b6:ce8b:6858 with SMTP id af79cd13be357-7b6fbf3267fmr153296485a.11.1734102652746;
        Fri, 13 Dec 2024 07:10:52 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683a0a736sm746086866b.142.2024.12.13.07.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:10:52 -0800 (PST)
Message-ID: <a31a60b2-429c-47f6-af8a-57f14163a4ab@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:10:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/4] arm64: dts: qcom: qcs615: Add gpu and gmu
 nodes
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20241213-qcs615-gpu-dt-v2-0-47f3b312b178@quicinc.com>
 <20241213-qcs615-gpu-dt-v2-3-47f3b312b178@quicinc.com>
 <a41eb4ab-2045-49b3-b571-b49eb5a05057@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a41eb4ab-2045-49b3-b571-b49eb5a05057@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jv6QWM64NHiczidTUEZGnWTXqecLe8wd
X-Proofpoint-GUID: jv6QWM64NHiczidTUEZGnWTXqecLe8wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=646 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 4:09 PM, Konrad Dybcio wrote:
> On 13.12.2024 12:31 PM, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Add gpu and gmu nodes for qcs615 chipset.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Well I forgot I made comments on the non-resend version

https://lore.kernel.org/linux-arm-msm/a44027ee-40d3-4552-8f61-bcab77476f68@oss.qualcomm.com/

Konrad

