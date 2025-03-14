Return-Path: <linux-kernel+bounces-561830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3990EA616F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA913BB171
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3E3B1A4;
	Fri, 14 Mar 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vkg2oNws"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC6282F0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971630; cv=none; b=c56k54lnOgb7bIsH3NDlxSC+vSXmfKoiucU7XoZImNKVYP4CayGBNC3P72QpLFZEhiC+2o0vT+oVNGmpBmlZf1Q9HsCrRQ77FGm6Ggps4um3rrX44+/2uv3ixBHlQM3oyx45Nwte0plsxFSwd7wbe1xIiiu76fbrlbH9STcKQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971630; c=relaxed/simple;
	bh=qEkVU5iHr/g+7SVo4A4rC2mUoGzIB16b3ce0OZc1l9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZXFxv35Hwvh1R7o4CRxChs1NrAb5z6DbqyiwmZAKPdGvCX8T6MDTuMT7HY0YmP/dzr9cTEAfi7htSjX4SFPa11oK6c7aYxDWgDy6gYVVM+CXbuJrMi0tBfzBk5buxZAo97B6y8/2XVdowDX2JE5Kec64/dA+z5U1zhfJ9ZM4sJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vkg2oNws; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E6nmXM019504
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vj80ZitApyxnsoDCCb/FGtnDuHwIs7XmDAt2lhrvDG4=; b=Vkg2oNwsSosCvSbh
	QFti8bEokE+IR5cahTdbUw0/QeAZGqifmVOCA+fSjLlg77anwwC4E57dMNmj0Dc2
	xK5fR9WtgA2t7HD90OorO53rm4wbjBFQeGACdyxRbxt2Jor+3vLWhGt0a4F7ltyz
	uDtATJWe9QUBiYPvUrlzgBnT2pk7oN5pSxirXFCrjzkFwRzQshP9leUThRBkLyuG
	ZVE9Wtp4OgFdoCtPcw1OMkRuA9zaawuAYDj2WCugjvoemTAY9+c9+n6H3n2EAZW/
	LwXbm6sk6KVdfnWrWnG5ftYzjXzsNqtptJY/IoD6Tg1qx9c/Up2fUcWKIp8qKRwH
	qpbWIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0mxkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:00:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225ab228a37so32601865ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741971626; x=1742576426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj80ZitApyxnsoDCCb/FGtnDuHwIs7XmDAt2lhrvDG4=;
        b=mhlgszG8BeHbA76+N7zJmgPO75cYrOXSUyYjT4xil4NyX2MCKelN8kiTD8ylgdG5IU
         wgwRyj5ztzoLMEB+r0Xz1eKM3OjYhNe3Jd2yLlyTnIRn3tPJmHiukZM/T1uiXW4usslv
         XUz/nYDy0JX2qvC1lPz/ihVhOThvlngfusS6SEN9dgzpiJioCkhopLuzbOyrYOk/z5ds
         9FZl4BZ6a9paixplDcEDgXDd+6ijAbmnAI22ie+DvsdCLOe/86IAkCqrfS4k6Lbse4yB
         RKAmSb1w6vllMVC3OiX1HXLa2YmKuM5W/a01ton0oN7M4iwKR1vNJB193kMZG3hbuFfq
         2Law==
X-Forwarded-Encrypted: i=1; AJvYcCWuUpuvfZskAXmw30dQ3ehYeFtRQQFrtOs5WuP1MmC/VdtQ5+5lQc/7RDGlJfqmVz8cN8jZGbHpUz/cGRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNBaGIn/FCSXwzfG8JFOn+NqkPdcMFyOLZXnT2ak4EHg2WNzW
	0pgPpT+Bh/9tySGLQDgM5Tw3FPv/kAYPw1cBwRZg/72lN/okJm13CAgKS0kH/6Mf0VmvNwwrSI1
	iTSwIsz4qBPRfE3RHoOQD1wot3YD21BT/dSgFUgKEi+pGBAMY7X4ncjOrX0l9NEo=
X-Gm-Gg: ASbGnct0zBnzhl4yb+OGJ0HfjCGXmzh8yYEiEL+Rce0uwuqhYm9n9kk1tGqm1saA7Xd
	EbdkebJxgZKoZUf1Y3VI+dFWNa4kz26HMeXRUMyzVwAehMhIzNGmtXhrvAWSM8pkXCj8rQxBb7J
	YK0WBunE48Y9Mh8yvLKWM8swsUxm/FhguN1Bzm8r2pdn99tMExYT/GxXUzRRh33pL6+l4b7y+q7
	ijDQk/MnMJwKlQPezIaWHgrxCVeE8+USw300g4h7FbkHd18wtSJz6KfRuL4fOr0Nb5ZRpp4I3P9
	U5/9l20N9rUKXwodzVvZseT/2nswZ1hR8bWnFE2uJ4+qEkX++mBzOte8hSckAh5szQ==
X-Received: by 2002:a17:902:d542:b0:223:58ff:c722 with SMTP id d9443c01a7336-225e0a75b3fmr50537655ad.28.1741971626475;
        Fri, 14 Mar 2025 10:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgaTrqJvv3hrH5zwdalhsLolvqrISTAGweaj7t70Pd1LstxRhICYIFHsdLjBTzxckLK/Z9NQ==
X-Received: by 2002:a17:902:d542:b0:223:58ff:c722 with SMTP id d9443c01a7336-225e0a75b3fmr50537025ad.28.1741971626026;
        Fri, 14 Mar 2025 10:00:26 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbed72sm30782835ad.197.2025.03.14.10.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:00:25 -0700 (PDT)
Message-ID: <ceedce0e-4294-4ff8-aa70-d2a077b4034d@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 11:00:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Remove redundant 'flush_workqueue()' calls
To: Chen Ni <nichen@iscas.ac.cn>, quic_carlv@quicinc.com, ogabbay@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250312073404.1429992-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250312073404.1429992-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cSZw_M-X_mh2g2DAE3LAl6T7Dycu3qu2
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d460ab cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=jdnOPd7pnXj7N3RGrIQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cSZw_M-X_mh2g2DAE3LAl6T7Dycu3qu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=835
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140133

On 3/12/2025 1:34 AM, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - flush_workqueue(E);
>    destroy_workqueue(E);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

