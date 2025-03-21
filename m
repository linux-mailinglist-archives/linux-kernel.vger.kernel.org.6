Return-Path: <linux-kernel+bounces-571633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A5A6BFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578DF1897269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE322CBE2;
	Fri, 21 Mar 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+97gpzr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62431C5D4B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574676; cv=none; b=cvJHpIczOV1hEWqAunhIVEOxb2GHAoN+TNN01TFecuauml0AQac6rspjjRrYuCHCmSP6M4WcKl1ro7k+9Ez77GhHlJY+ynxJ9v2M9s2xVKNaYry8ngH5Kia+BYkPEnXOmfnYlZtrCj3JRMAgEcSl+DBfEXSqBrnuXA4BpSOhS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574676; c=relaxed/simple;
	bh=fgjzGRwz/sHKjvo13WvtrAd5xwLUoVWt+vf8ZjaPXRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOLwhZMgMGE5R9ADNClsN0z0cv9Bkkuu9XlSM7gJlEl4ZM/mySebEZ6gyQJg+8C54wwTxaUBHlBNvm8WhGPKrxVdrnNJ/VRClx98ku2jUuIVqbYOKMJdF90e+AWbjsQDvoG5aerueelfGxeQQ8NxP7jbPhfy+YacSwzDGnkr6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+97gpzr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATK0q001130
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2IMt4Kk4/Dx/8oRvpv98Pwds64XlQ1coaXykI33I/Bc=; b=o+97gpzr9oNx+1c/
	KXMa5bWbdJwfh9Xb5upxmRQIMe+lpArlut9HyxAj7NHPbnPPWRLf8NC25ZJhIlrj
	QXSOZZ7yXJC9jrbfF0fETqLbp4+Inj3JAQqb5KPklZmSXvo3sRaWD/8yN+CPZ4w4
	D0AYupa6Gwbw+X6uySDgOpV/NxAHy7xD5B3duToLxZ1AOXF2NoKeJKqYsYobUU28
	7offgH1u4v87A3G9l8+673B44Jm4Gmy/6jifTISC3ngtUbb4vW3g/OkZ0WTZwAVE
	p33SVoDPiC4U7jMj07+VsOenHXkYxEbKEB7ocbWOZVtKdRwz9iE8xYYiunrGE3XE
	+arRHA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4u9s9k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:31:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b9242877so420353185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574672; x=1743179472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IMt4Kk4/Dx/8oRvpv98Pwds64XlQ1coaXykI33I/Bc=;
        b=laACZI7rKK7n24ra8lli0NW3Ur+J1so64GEj7vyXz7AxrqCS8kYq6ISHd73itsUM0o
         d8LNAz36S8L6VdRScCL3gkCtIBjEeOhCsrcdkZDzXVwgy6MQeI18MDw9y9AH7IBNN7G0
         NKCbGd7bnnfPt72ttyeFCebNKdTt2IHWrGOJLU54xcErFPemD/uc8zbCDL4h0qHt+Z+K
         G+WoPqXT2EJU8lUn+y9no4rxXIn6zPhzWXEMtyVa8q63J5nQE55A+FCMaR69Wn4Mf4zH
         glSG+yHQyOKgz5KkkBSzVind6qZ5uhyZD6cOBImXtzPcK2Cy8KjJ/7/dOZnEEo0ZN/+y
         Zk6A==
X-Forwarded-Encrypted: i=1; AJvYcCXmxdvs53+U+01OL6STZv6XlVTcp16OLAiU/zXEVcoCu4Z7qb40OZz/1KWsVmJxQbfxjvjOEviOhQ5x1Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK9jl+W0/P9zVgtId2YHszFxP4XXN4oVgJyRzklH6vi5J1amy
	sOQcMq8ZIV904sR0TxwaKphciW9RuBzhTWsxGD1ztjgGpi4LTIfajrIVnLhCdr2CFF5CF+1UJb0
	WpYxP78wWkipbh911toT5fTcy/ADSkrAeiujwWXEa54Y3sDYYZXjpEI9aynO/ivo=
X-Gm-Gg: ASbGnctUavGNk/FhJOh98krqTjbJ1pGXK8WwfeMsREnXgKlcdt1fZQdMHRv37vXn/e7
	hH/zSTzF0iJTIKRBWd+s9N26eJqQpMoDnyLaRWgPIogLv9hL6jDY6ekCuHbv65RGkXxaiBYoFhC
	Zwc1urkEptDx8K21mm/Epox8z4NOSoPRcj7NyHOd+hPbQ3J5G8H/JlY2c3k67C463GLeOx/51s+
	ymneN0Asglc9YRquER2uuHD0H0idzAyR/EQIKfFDzjZmkfwKfPAAK7nuPV8jOU64fu3XxZ7kAYX
	oe2gytH7L83AuAsdqZUyl1LRUUEH0RFlb0k08OMUEjJmZoPe00IRW6zjUfNiUGBRbXhRRvYHn6c
	CjxAUKcX3B7JvMYvreKtEI6hUZGmDihqOrelMtsyy7cD2KDmhsvxYZbqLgh9qJLm4WPgL
X-Received: by 2002:a05:620a:4406:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c5ba1deda8mr478440385a.40.1742574672477;
        Fri, 21 Mar 2025 09:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC11C3ROuEuv4LnPyl+Nggj2bsLHRBsWaManjOdSZzmLn86PXUTHmkaKj69Rn5CvZ35HXpuA==
X-Received: by 2002:a05:620a:4406:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c5ba1deda8mr478435885a.40.1742574672070;
        Fri, 21 Mar 2025 09:31:12 -0700 (PDT)
Received: from ?IPV6:2001:14bb:c2:310f:a0b3:1d12:b116:f8e6? (2001-14bb-c2-310f-a0b3-1d12-b116-f8e6.rev.dnainternet.fi. [2001:14bb:c2:310f:a0b3:1d12:b116:f8e6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbd15sm215071e87.131.2025.03.21.09.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:31:11 -0700 (PDT)
Message-ID: <f3be50ff-53cd-4e8c-ade1-af8e4f2e1960@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 18:31:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/14] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
        Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
 <20250318-phy-sam-hdptx-bpc-v6-13-8cb1678e7663@collabora.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-13-8cb1678e7663@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iXwuetrye4pxhrDgwl9uWyBlbV0oVSEL
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67dd9451 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=3d3HDMnJp-VYffEgFzgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: iXwuetrye4pxhrDgwl9uWyBlbV0oVSEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=923 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210121

On 18/03/2025 14:35, Cristian Ciocaltea wrote:
> Drop the rate parameter from a bunch of internal helpers and, instead,
> make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
> data.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 47 +++++++++++------------
>   1 file changed, 23 insertions(+), 24 deletions(-)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

