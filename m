Return-Path: <linux-kernel+bounces-560104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2DA5FDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA2A17A6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435218A6D3;
	Thu, 13 Mar 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fs2aRRl5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935D1714D0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887001; cv=none; b=C/oKYkLduAo2ZAP6cONrPzNcph7kH++25oIj6tIP2bFjDwIKeyqVSHL4Hhwdr2xkMTGJ07lap6LVXGXrreroogl0KSsjm5hVjrhiminX/kcROhIMF6qsysdKaESwTRe3zQxlC8pcox0lxzsVj2kD57jMdGt1YRTy2DzmyYgws60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887001; c=relaxed/simple;
	bh=HmRa1m3tXTPbBXhjbC00+GsyFNYue27NTEWKBIJHeaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVpDLZ7YmwtFGiIdrY7nPYzSq4t5YQ+b144jKLoPUWcgPq3075zqYEMREtH4XGJbYu84I6/zYA2p1Og/5WQxunx8PLUl4Y6NZQTEqTxsGkf13giz4LJOedMW0803V7Kt30Nsorqyb7rs5RbIOwKgC8yirjjIh4PAWmZX8ocitvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fs2aRRl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9Dg8P017514
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	awOPnnsbd+ZITDDV/+JLRdAlqUsZWoQ4R77EaysafPU=; b=Fs2aRRl5KVkinpOp
	HDdew9bXb3MLMqoaPfl1Yg8hIq22hLlUFwd5DMitu/g4zIwo5Rk7IsNDNq2FIK7P
	jt3WQT+tvfhKkI/tD978Fb6V0Y8ezSlqS6enzQw51MDarjjRHOKY0Na/yuT/yDFt
	YJrAD6P2OD7bLWOVx6NsOt9g8qNO6VV6PooGCm7gEvEs5JrAY2kjbQtMfrWfX+bZ
	s2ij7Ircmlup0VIQ3q/1VsrgM3X6veip0gXKCstyyOVpD9z5Mu+soI3bIhvs/9OD
	LnDI+NDlEc/VS3EqZba5Xwc4pWfkGbfsY790lXktLDxhmrPbQLFQJEgDwO1G48Xz
	2txrHA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nxpat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:29:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ca2a4a5so16629655ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886997; x=1742491797;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awOPnnsbd+ZITDDV/+JLRdAlqUsZWoQ4R77EaysafPU=;
        b=BI3xxp8h0RnxdosEzMXS8DjuT2SFXjrdSeUInYpFWSKFMLnm1lr/9iaAfxw9NXD0MJ
         Z+3ywhMN8UNcN6Ab2/FyDE6+pO7K9UFxmjY8bDklE9EmkuYUNHdqlRIrSnkTu/QzlB+U
         DeVUYKs8Ma7Ox3yHVxLYoar855ThK892Jx++PIWvFCdWLn6oQ/YBAOvYNWH0aVfHwBaw
         6z2/SlvY+ozpbpFDj0YNs3NlnoQTkJN5jmSrUhByrAnmc+3fzkTp9g+8e+YA9f/gljym
         iYWYGuUgK5IMEZyWpDxJXM8WyHhRwAOLaHcbAlyM2kCfVIUn3i2bXqTCNgXv2yV8LOKJ
         S5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW3P1qWlkompTqv6uoxaiPPk1+hYNxUsPaWBWnq0hgc3bedXKbLe+iSiVW/rgYKgNdpnheB2y4AbvdqDio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMgdNnYfatvnrRfoC7VKz7vVf/oM5lRnWyzK4CyjvOwtUxNvH
	AoZ1+AR4fGqkAaUmBerKcmnas86LPxYBgn9gz+Cap05c3hYBKPSKD0WTjK2z9r+ruFJ3kF0E2Zh
	81aT9kX0lQehag4r3Nfxulx0mdcl14E4mAv9c6OWQRRi3UUMOzyy66431KuXawWk=
X-Gm-Gg: ASbGncv69A/T+HrhLq6j/ySDgFTcLAH3piPhjcY4EloXjH5sXKIkU8uiUPYKQh98Q5/
	L0ZWZLjTU3e50o6WWPSF76XzAcLSNrfIeFyDA7lVzDxuvO8/vAtKeSH+4ivVi6Dp4tdqyF/acnJ
	jTmSblpveKEo0Ka2nN4qOr7u8/I5Fn3cXkap3l56p2G3ARNZcUj44dqk8vCd/b/Pm2yfnvW8JRF
	k+K+ur4hR0Ivrpno6b65ktOIEdWwVBAl/erypvLNrGjXuDpJMdAU2UGNsuQoiifXj2HxXOeaTDn
	9ftLsyQ8solgfuyLx37wZ31Vo0udPnIH7RZLFniPb5jErzGc4hPM+Dvr1G1n9IdqtcFgLfEwZZF
	R9M6k4InF
X-Received: by 2002:a05:6a00:8d2:b0:736:339b:8296 with SMTP id d2e1a72fcca58-7371f17e455mr494948b3a.18.1741886997436;
        Thu, 13 Mar 2025 10:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhq47TWkIDcRQxoDx44xKFXPM4TKX8MLJNf13Xta2UOYeZHJ1f+/yEahV1YT+F1aEcUgnFQ==
X-Received: by 2002:a05:6a00:8d2:b0:736:339b:8296 with SMTP id d2e1a72fcca58-7371f17e455mr494906b3a.18.1741886996826;
        Thu, 13 Mar 2025 10:29:56 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529531sm1608998b3a.2.2025.03.13.10.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 10:29:56 -0700 (PDT)
Message-ID: <fdaab417-62b7-4151-be35-34fb7a354eae@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 10:29:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Drop of_get_property() call
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250312234228.1243477-1-robh@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250312234228.1243477-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LMMueeNCk3Yy7bkAq0SGNsyVp5g_Sz5h
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d31616 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=syD-WeZVJwOIrOENAgcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: LMMueeNCk3Yy7bkAq0SGNsyVp5g_Sz5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130133

On 3/12/2025 4:42 PM, Rob Herring (Arm) wrote:
> There's no need to check the property presence and length before calling
> of_property_read_u8_array() as it will return an error if the property
> is missing or the length is too small. The return errno doesn't matter
> to the caller, so no change in behavior there.
> 
> Change of_property_read_u8_array() to of_property_read_variable_u8_array()
> as the former allows properties to be longer than the requested length.
> Now the property has to be the exact length requested as the removed
> check required.
> 
> This part of a larger effort to remove DT functions like
> of_get_property() and of_find_property() which return raw DT data
> having no reference counting.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index b3294287bce1..db7444af251d 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -1889,7 +1889,7 @@ static int ath10k_download_cal_file(struct ath10k *ar,
>  static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
>  {
>  	struct device_node *node;
> -	int data_len;
> +	int data_len = ar->hw_params.cal_data_len;
>  	void *data;
>  	int ret;
>  
> @@ -1900,28 +1900,18 @@ static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
>  		 */
>  		return -ENOENT;
>  
> -	if (!of_get_property(node, dt_name, &data_len)) {
> -		/* The calibration data node is optional */
> -		return -ENOENT;
> -	}

note that there is one instance where .cal_data_len = 0

so i suggest that there still needs to be an early return here to avoid
kmalloc(0):

	if (!data_len)
		return -ENOENT;

> -
> -	if (data_len != ar->hw_params.cal_data_len) {
> -		ath10k_warn(ar, "invalid calibration data length in DT: %d\n",
> -			    data_len);
> -		ret = -EMSGSIZE;
> -		goto out;
> -	}
> -
>  	data = kmalloc(data_len, GFP_KERNEL);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	ret = of_property_read_u8_array(node, dt_name, data, data_len);
> +	ret = of_property_read_variable_u8_array(node, dt_name, data, data_len, data_len);
>  	if (ret) {
> -		ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
> -			    ret);
> +		/* Don't warn if optional property not found  */
> +		if (ret != -EINVAL)
> +			ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
> +				    ret);
>  		goto out_free;
>  	}
>  

this could made even cleaner using cleanup.h functionality (all of the gotos
could disappear). perhaps I'll do that as a follow-up patch on top of your patch.

/jeff

