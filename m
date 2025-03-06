Return-Path: <linux-kernel+bounces-549710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34843A55651
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370C6161E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6926F447;
	Thu,  6 Mar 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNVN+TTK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDD26D5A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288379; cv=none; b=gdG58s6xV3a5C4shEePIo/5WjVVo593aQx+Y0LDjQnv7b9oXIN2SUYuoD22giQYUaCDRfuM40VWxYUuWOrkendlNjULYuLg3yWuHbgdfrsIjnXVlkF4x/P82nfI+BeV8ZKOdXak7dRsuBJqfH3EjyTV9pfK3AFwAT6UPGk1lPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288379; c=relaxed/simple;
	bh=ZE9+ebNgM5KO1RE0JNAQaeD0DnX2SDcXyjjzXDwQjRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMtPRiRceMkKZJUtHcWiixtuzjsNpb37BCNU8h2yEVTP+WWo03vb78Ydky0Py+EN6HaWHuEs5gAh7Yb9G+5L0RNkjYuHNu49q0gsepgW3jnM0FCFlYAefUIjuneM88eh6p1Q9HNe7TyRHnO7304FxBTBtHImEHK7YZQ7grGNvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNVN+TTK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526B3ihl031962
	for <linux-kernel@vger.kernel.org>; Thu, 6 Mar 2025 19:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fb3of7w9Ie3DB6n9UGY49aYrXPyhRGq0wD8JUa9GVqg=; b=aNVN+TTKmbstWgz4
	NeRQlPry+8vIeEBDsDA93osB6+tzRBilnc3FJHDpczpMUTUNd1vhQGv4qrgc48DN
	RKHqvh1Svun1Z7eKib3rj0f5Dl0THgKgPTSkfj1zLZgqqHluN5MQJvaMIY8Exfxs
	tRl1ssdpr1LcHa9mDZbI6fWBvDtntMgULz+OKm5hGoe7t1ESBVZyeGIz9YPY3a8G
	JLGhk55Knx5/BA26RKfqOaWZge8/N8kfcurF024Q9d3n22uZ+GnrtRJkjnQNcTEq
	sqAvs/D42CngQ5bVwHtsa8LROLatbZPA02IVt9dWwZXri6celDyGwGcSQ8pfif63
	TiCn5w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457aghhd2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:12:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223d86b4df0so28960425ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741288376; x=1741893176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb3of7w9Ie3DB6n9UGY49aYrXPyhRGq0wD8JUa9GVqg=;
        b=cwL2gRj8yN0QNqpHS6xh+J5WhFG2sq//6l2jFyzpoVuPpwQIa38WOAa/PS9NM/K/Bd
         qPsE/bow69T6S3V3CVajQfTL+RMIk7SD4psjOgp2T4RwnjbHAsG5L6vwN/WGDqUNsTFK
         7fnnPwpTyYSMPbIrVPuQ/1LnJ1yJdUz7uNmcjxXDfjXfXslrY4kp+1ORC8YHw4tqb424
         UZPk9AIApKrdkRVwOdzqsSBOpUT3OgZMH21GhCkOgnsjNqB5yjveHRCeTDrXRdGm+PKx
         UaS8YClqH0r3uW2vl8pfilpxmZc6XsQb6wz9a/bc4DF3kYXPWrv7wDGBlT+mjaSGsi/4
         7uPg==
X-Forwarded-Encrypted: i=1; AJvYcCW0tDC6kLFoOXfACCfApefnqvvaWQAbfosVh/q4VktTcU8YPmmolAH+Y69pDEvNWf38QoWkctcGpWt7f9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQ3mJAwKcjCh/PpbqAtlP9rhcP7I82XPlpq8wxYjZ7PUm8FWj
	45dbcn1+zXrvuAHNeofM4EG9AbhH4isRLR37543f4HvF8PafaC6yA6WZamCi9Vzm39yAvltonp/
	O5pIgKBuS5C73nHdhoJyTqFNggNnHPV16SRIs3YUkHwVCaKtVFkZdVD75N86C2bM=
X-Gm-Gg: ASbGncuVnolnYH3h4xce8UDPPVx5rTHhcaVFj7pF02IB2LoPYpzZWx0BI6A+JJohPy2
	mqoJZYBncPljwFbs/nRI47EWv7j7INO0C3qhqeUZKn/kpHReeiYp5skxK4U147jFzPllFMfxYGb
	l2H5RG5IQiwZbU8SYexM6MUCt7grGxhKI63M2SwgM2YnonA3ufvSHt3IBvAtg1i5JS+aCPI36CN
	ZPF9YmhfFd0RCUbZt4+vHhGUKFCVIer0otG3V+UKewUm7OyEn+yZURpKCJrI2Dwuk3QsOjd7NwZ
	+PiuOprd2EKAzr9lUhbGznmSiHm/Hk3ForUEd/tnWok3kyVewLSdE4VlNbHNXDk6Yw==
X-Received: by 2002:a17:902:eb81:b0:223:517a:d2a3 with SMTP id d9443c01a7336-2242888ad7emr7775955ad.17.1741288376406;
        Thu, 06 Mar 2025 11:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAx44BUCXx+xU4NJjeRySwsv6RYLFJfvyLsxvcs0xJneFlHm5kPRPA6wLw2vuLOUiAu+gRDQ==
X-Received: by 2002:a17:902:eb81:b0:223:517a:d2a3 with SMTP id d9443c01a7336-2242888ad7emr7775535ad.17.1741288375935;
        Thu, 06 Mar 2025 11:12:55 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm15958525ad.240.2025.03.06.11.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:12:55 -0800 (PST)
Message-ID: <03bfed13-c541-4a09-8330-ca3563be0f77@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 12:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Fix integer overflow in qaic_validate_req()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>, Oded Gabbay
 <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <820aed99-4417-4e4b-bf80-fd23c7a09dbb@stanley.mountain>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <820aed99-4417-4e4b-bf80-fd23c7a09dbb@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: amHvKhmMSJi1QZYrQ_gYnJtcPi3E_QMU
X-Authority-Analysis: v=2.4 cv=R5D5GcRX c=1 sm=1 tr=0 ts=67c9f3b9 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=UIlczW43xpdIlxS7G2UA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: amHvKhmMSJi1QZYrQ_gYnJtcPi3E_QMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060146

On 3/5/2025 8:53 AM, Dan Carpenter wrote:
> These are u64 variables that come from the user via
> qaic_attach_slice_bo_ioctl().  Ensure that the math doesn't have an
> integer wrapping bug.
> 
> Cc: stable@vger.kernel.org
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/accel/qaic/qaic_data.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index c20eb63750f5..cd5a31edba66 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -563,7 +563,8 @@ static int qaic_validate_req(struct qaic_device *qdev, struct qaic_attach_slice_
>   		      invalid_sem(&slice_ent[i].sem2) || invalid_sem(&slice_ent[i].sem3))
>   			return -EINVAL;
>   
> -		if (slice_ent[i].offset + slice_ent[i].size > total_size)
> +		if (slice_ent[i].offset > U64_MAX - slice_ent[i].size ||
> +		    slice_ent[i].offset + slice_ent[i].size > total_size)
>   			return -EINVAL;
>   	}
>   

I agree this is an issue that needs to be addressed.  However, it seems 
that overflow checking helpers exist (include/linux/overflow.h), 
therefore open coding a check feels non-preferable.  I think 
check_add_overflow() would be the way to go.  Do you agree?

-Jeff

