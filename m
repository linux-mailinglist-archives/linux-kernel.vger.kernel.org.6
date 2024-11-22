Return-Path: <linux-kernel+bounces-418202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FD9D5E94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F9E1F21084
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7556187321;
	Fri, 22 Nov 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FTneeyND"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60F1D318C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277361; cv=none; b=OZQPSOfQW8uZDLp6dMC/FR5BZqdyhAUWRY43mudnIjHRjzKPA0sfftNEmXxQYVwflKI4kcbmeAD/W+hGlQ4a/kq/ehiJCgi8u0uyusL5dOaDCzylYmJScRZ0OV9gKmE7qZw5Lgqdn0E7/4nFqpPyXPY9MOqKV4wCAf/5EPicPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277361; c=relaxed/simple;
	bh=f3I4gqxCEIx4XLDLokX5S8VXumoKTGDeUDBMTyPNel0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H4kWPXn8sC3JGYSgF4bDVtpY/ZPP4Xn60ZcxFMcFaVeYc0Gz8vhR85H803cBOM3e3Pa9f6YbdR+dDJZUO/2C0zFNDoAwOlwePwJ1c8FA3QGbyj6CbvwhPcvze3jVYaCQq5cViavK+gwY41x4Pu4Cdk4VuHHvDT4j/hAZfsqiGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FTneeyND; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAMOEh020697
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sgfQ5I0CQl8UfQ3flsk4bhkJPTEDMQpM6xgAt6l3YTk=; b=FTneeyNDQWEvHnxQ
	xz3fChARcBrFbrWPZBmXiIYv+ZWIzHoa7KjZD7bIG4sWL3ErgQbQEskXkUmCOJDn
	IMnKImaXWh+QBJNrycrxskgyl+zbFzAolx2N91lKSuzUehpOCRoy+ZtCmFSRN4DM
	86vbyv9vSNHTdSab4uhCPYmiSyDiWou+ry+/EZSehk8HhGGB5Bdm5cV2v30BFp1w
	M/t0QsvPJ4mBDl0dmdP2u/8MDc2BiBfLkL0tY0JUEj6b+bIOdGTx4sAriePn8wym
	7UulJlnP8sHvkLjOgnj3fxYsP7+wgcToPKwR+1Ib5ag/bGcx6Ki/r2GHZNe9oBuS
	a9FBFQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2n3sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:09:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-462c15afdb6so5543331cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732277357; x=1732882157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgfQ5I0CQl8UfQ3flsk4bhkJPTEDMQpM6xgAt6l3YTk=;
        b=ltYHvwG1wQtChgVo0pj09iTkEvHKTH4QibMPC4AxiFcocC5+762dVTvrjBWIIFsyA1
         B1OhJxunuWBjSyqthpsvZ/hl+M2EPs46R20Q7ew+IIW+3IUtybUo6/GjJvnEj1A1uq1D
         OTcCoFAvg5XuQbvcg1kVEPb6+GjQmBEd6B5BzAnuF3F50sGVFIzJ8REai7XQ0hfJZXxs
         E3+F/9zhZnAfqmLhcbegwlvQCqyh3/ooC7UplCPkq9uQtoU15OLiuitN5F3/pQ37bfzx
         9OD7mIDhOqMs3sHaDynstqrtO/1x+uoyhl9JscFN456taNXP8E2zPrCfGk6VqrzRaYCj
         pYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqTS+P1m9aHXVpOz8YEB49TlvQahlhp/cgBbQBALJK9xQj1vTzCyp2tffKHk4siT9u31etH44zFo8UNNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRHz+X0EAeGDfyj6HjCd4Vokkxt+meJ/LC4+dTao/IkQvr73N
	lAcaCb2uYknA8J8gO7obmtVEwq5qozHXT6xROdIcSiG5mBR0Im7I464qohmwOq/sOzG57Lt2UMs
	RSY1fLhiQ0jPZFWBIL9/xiXiGzMcKiZQI4G0ZLvCsi0Nzs8U9YC+zoD/ceAOmTTY=
X-Gm-Gg: ASbGncsLDCTs1kNrcpPnhFyW8enTFSakS55HaDvhLS/rqNi1DsdJds9+60wCv7LQAxi
	MfJWpWHfbF0HgHqXsjf6iAY7LzNmFSjQrhZSKeMWf0ARgzVRzipkA+YZVXaci+CqYZvrsKUNJ8l
	HfBosH96e2ayQ0G+6EYxRjzxnVd1U6gMjC4DJRDw5mJnaApYAId7KVrEXKqdtOFV4IVTdhWrZC4
	htLXzzzv5kB94892CK8npUkj6k7OC9CEbAcqRV+AccuOdk7IzLnIBswf7Dza07ZuHD9k0C24Aeg
	bxfK/8CGdIeJRBYi/pnxvXePovjFlg==
X-Received: by 2002:a05:620a:4393:b0:7ae:64d1:d31 with SMTP id af79cd13be357-7b51451a49amr145612685a.6.1732277356786;
        Fri, 22 Nov 2024 04:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIvmb/Y1Kc36T84MfAddlUEPXu02tmNhvl1dBN2N1NQHDvFihw8x5CC9BRGYVlS2+hubr+Lg==
X-Received: by 2002:a05:620a:4393:b0:7ae:64d1:d31 with SMTP id af79cd13be357-7b51451a49amr145611585a.6.1732277356421;
        Fri, 22 Nov 2024 04:09:16 -0800 (PST)
Received: from [192.168.212.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5300e1sm91807966b.106.2024.11.22.04.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:09:15 -0800 (PST)
Message-ID: <7da6fa27-0967-4fd7-af75-0141fde79b3b@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] soc: qcom: llcc: Update configuration data for
 IPQ5424
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, conor@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121051935.1055222-1-quic_varada@quicinc.com>
 <20241121051935.1055222-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241121051935.1055222-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ICFLaqEKQfomryfU7oVtm-dPKRDj_ZYX
X-Proofpoint-ORIG-GUID: ICFLaqEKQfomryfU7oVtm-dPKRDj_ZYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=932 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220103

On 21.11.2024 6:19 AM, Varadarajan Narayanan wrote:
> The 'broadcast' register space is present only in chipsets that
> have multiple instances of LLCC IP. Since IPQ5424 has only one
> instance, both the LLCC and LLCC_BROADCAST points to the same
> register space.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

