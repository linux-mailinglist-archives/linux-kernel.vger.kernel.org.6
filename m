Return-Path: <linux-kernel+bounces-542127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23CA4C5F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9816DAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C52135CF;
	Mon,  3 Mar 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGwuvb7f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08184A3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017703; cv=none; b=ClsmvZAApC7Lty83/uda45zEm8mx7+wUVoB3K//vFrHGTvo58O0PKz5T3b3naJWtSbfJd0Mv6DQS47m1AGoz3J7tXeEmGjHNNAC0jzCFn+jwWa2KZkjyP1s0I1kTmgeIa6gPc/LnogLAeRl0afDjsP0mloljWCge1KFiTwAOvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017703; c=relaxed/simple;
	bh=DQ2ARohgT2WIxx2+PKksbW62z0i8lh6jAaz6kyrI3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWhcsDEc7aclWofeRH+1tyQW76ICOKu3K/t9TpRNsvRgJACePE3Ud7FbIavjcPfUmoI9O+NmcVPkvRE94QEvdEcLchvV8VSeFcZ7hSgzX/vOe9gymKDPuot+6v95pLfBwin6b8dRTA7GX0m8OyLxrJuNR2OZrIuB1/IPiIXYkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGwuvb7f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Av9t7006589
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjaEGavEZhaf/n/BWdL16Lx6yvyWPHtzKIlO2g0w1kc=; b=FGwuvb7fPeCdUYmt
	kSEV+tNt2exVNAVOVU5hX26IERHMoo9UNVgLlvIpctgCziJsB3TAnNYrv80c6wY4
	qLkEGYNmMZ+3bbVGLkD/J5X2+gYwmQgbHjY+SXhE0UMgV6VDdQFWkKAQg3CoQuZP
	04Hvo2JICh4Y8BSk90bxpKmLNPuWcxbZQRnQiqMXnOg9KADvtuDne/5x9zmJfVxF
	JpHEAZInTpXaqZMeqDl0VioKXJijBoA5tbOyfe9tO5uXSqGViZZU/uCgVvV4Zlij
	rAx+wUzKOsj8bXHWXE4/zTqtM0XMxTw3v9iHqxtwk4vJuUuLOpPsUjr8N3epnCD1
	tc0V8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hwcnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:01:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fe8fdfdd94so9135287a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017699; x=1741622499;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjaEGavEZhaf/n/BWdL16Lx6yvyWPHtzKIlO2g0w1kc=;
        b=sGDcznH3igQiaGf7DVd07p09B/0bI2ipaEUb+Yz9WOi+Npb9vgmpesqF9+dCIFSUP4
         K1JGgfLr5N0/+yO62Qvz6+iJzg8H2KSpGWwgCgncm0rpk3AsuCoMKksKBI+E1fL9kh9O
         d8v7w4D9hkall+dCO+6PWF3zCF2tum8sujZAiotpR1rqQcyLob9UzU4kdWpXjs2xaD8U
         uI20B7erBNMOF7HdAr63hKrHetJGqisxjP0wCCPBIt8gpwRO3E9k1ARhFz0PsF8bge1r
         fSf1FXdd7Fi9K1je3h7JWYtYp/Hqy8s07FUfdEY/EIu+EJpgdh2pnijsJWRJj6eJUPUp
         cuqw==
X-Forwarded-Encrypted: i=1; AJvYcCU4M3E2LGqyQBSQcvv5PVnyjcQ8EjGEPounTBctHiX0lvciqtVk+WS8lJDy7x6VVRMK4jVU6u2N+oY5XTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8v0SdTZIzaRIZtAENEjdOWnuR9x7OdZAQuheSTjK6TFTtMUV
	5ljFX8OFjOvUFrg85JexCfm8ic261a5Ky3epMDzeM5qfmVRvtqgQ1c3I1ysxdgzWdLwSt0K+aE0
	ZLro/04PfNxIu8cwaTucmImHPXWVyoIype30P7fuo+vU8vYs1uQRP45Av6JpWl6I=
X-Gm-Gg: ASbGncu0UDWm6sClys9h6MKfbTwo7qzzRpVKqbtBqLP8GWlIpXtcSS7jplgW/yuEPXF
	bmt+n1NOUMGukPtRhPg0N51pSEPl0R5EeTiVl2QGrDcRPNztAWBlfK3iKd9hvLVmjXNqmGKCYlA
	g0FcQDt2U5H2HEIzOQjY203/uLnSuzjxp8DDDTpXigIvjQPzf0pK3YGizyxY7QqavjNyABVk6Fq
	HSeCmBpalWlzafoKqSrsfhnBosk8tKNjb7YnsrAVjp94CE4YQqIA8rplIGxdMJEP9PlOf+ZFGLt
	wxM1Z6aqbujbc1AgSTtFfDH48zZVYd/Oa0L11gDBHbSPm9s4Yp4dbaC1RCkTMv5pzBXhLl7l8/4
	i7r/RU0aI
X-Received: by 2002:a05:6a21:4613:b0:1ee:cfaa:f174 with SMTP id adf61e73a8af0-1f2f4e4c89emr22116731637.42.1741017698938;
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ7lQhwdPu7F1bK4GZ8FGaLSacV4bEWANJf/oaDv1AOnK27gH8LHesKf32x0Ct88uuBV+zUA==
X-Received: by 2002:a05:6a21:4613:b0:1ee:cfaa:f174 with SMTP id adf61e73a8af0-1f2f4e4c89emr22116685637.42.1741017698472;
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf29f4sm8326270a12.11.2025.03.03.08.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:01:38 -0800 (PST)
Message-ID: <0d92ca31-c22b-4798-aa60-5feb66def31b@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 08:01:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
To: Johan Hovold <johan@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
 <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
 <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>
 <Z8VWAWl5UdZQYGgr@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z8VWAWl5UdZQYGgr@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZGOHMNsftyn9tF1FxCsLK369S5SH91ac
X-Proofpoint-ORIG-GUID: ZGOHMNsftyn9tF1FxCsLK369S5SH91ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030122

On 3/2/2025 11:10 PM, Johan Hovold wrote:
> On Fri, Feb 28, 2025 at 09:07:32AM -0800, Jeff Johnson wrote:
>> On 2/28/2025 4:28 AM, Johan Hovold wrote:
> 
>>> The ath11k ring-buffer corruption issue is hurting some users of the
>>> Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
>>> with you and Qualcomm.
>>
>> I've escalated this with the development team.
> 
> Thanks, Jeff. Just let me know if you need any help with testing patches
> or firmware updates. We have a couple of users that can reproduce this
> very easily and that are also able to test patches.

There is a patch under development -- you should see it this week.

/jeff

