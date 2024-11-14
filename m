Return-Path: <linux-kernel+bounces-409402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238B9C8C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3627DB34744
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4805A2A1D1;
	Thu, 14 Nov 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GghzDWtq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B80BA53
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592649; cv=none; b=L/w8Ws4Me+lpu+NhYrmPucqU1HV39LtvUD7BELUuTf0cgiW/VeuesORUEQ7SJYr1iNyxnAQFai8SIg1NTT+hYEcTYQy0E79UUMM40+R8sbHENq9dprV71t5JzS8omD2N7QfC/HzsOobeJEZYelo6380wzKFPkqSXSy96Q+YWfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592649; c=relaxed/simple;
	bh=a+AUQrdW+PYA61YxrcqIvJErr6SmNmqDLMixPc3UFdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGe0an54tTAzjjzh8uS7ATobwNAG65lysYeeNAyyx0yiykYxzddIKOE9Q+pXAlM8ARLV1L4QyrW+vVWohGaJsaDjumVJx8+CYRe9R85M0joWezj6f47aVSn3H9PbiNFeeTdk3Ogu4R+aUNsKDl2ufFZc41j1IfAMcbsWtCcVRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GghzDWtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDc8hM020457
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5goF3KV2cIAs2QaOfnwRv9qRBAvGbfSx7o/YGvGW+Y=; b=GghzDWtqvmaAP1j4
	vOufLtvEUGYsuKGXjo0khJzFlWa8OWZEbRzCGfwLcxiNEwmPdz9i6O18u0PmdsCB
	Qg4gsypOsQnXSHk3eNJbpbJfSIsRTKAaMN4GX1KSlxBAvhAAzQGk3oPUdVDi0eKP
	8fnqxwXBLLeMSEVgPYggKUP80cCTkHByZe8M4s30d4HeoJm+iCeSeJm9SsMJK7MH
	v8MvMcjVGohDJ6h9Z5wUOpOv85d7Z76mqB5mylAtsLrJqZ9hQ8ctmVo6ennA6UrG
	iYs04Fe9eOtp25pGgtIRYiQcYxDO6vICtr56lh67TktFw09+0gqDu0HbFIddKAQ4
	tzQV+w==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv2h7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:57:26 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e60838eed4so23438b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731592645; x=1732197445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5goF3KV2cIAs2QaOfnwRv9qRBAvGbfSx7o/YGvGW+Y=;
        b=CFoHUt9x0qHragvPLp6sYiEzk2Y+H//eS5TsSAXUl69scoMPXi5Guyd6Y27ipCcbDl
         YIWTcrvRV5tlZNTrVquFXWHTfWM/wJCLflPsdE9zeWPJOXzo2i13hl6bfpN/1qtkexFF
         W0B8TF2EO4WaASFqDqlgT+lT3/zgQEFG6yeTg6gjvZbmzAr1zeSIrbOT4zc0Pgdz0VyE
         gzkZ6FsL+96Hzg7OY/DQckpLGAS+hARxuS/YD2zTkUp1w1OEjcG4wU8nMXtQ8efhcntU
         vKa+WlVIBvOpY0Hdcww0gDofIDRg35LuqxJ+z0/DgNDsWZJyuELTmr7qcJodZqz45Q0S
         1rVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuXcX6oskKqpig3mxEUZUU4EIIjQztYYFEFR9grAC7/6osAvoElu5SKmyNtwboH50UAl1VAuWeTSIHKgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDMIF1F3F0rpAgpKXQqkEGZIPttHxDmBvWqH3TeOJ/x2+vCBx
	ahv8pRG+bnexr5+4KFY3tkGBt0yREBFUjHVVe9h3ObExHBl068tE5eifQqj0TkINBFGGrlTbhUI
	gURl4ZPAqwnTiIjKmQJhNUQtGZcMGxn3O4CIMRt9TQKFJLy/YwyBNpIGd+D0k8tw=
X-Gm-Gg: ASbGncvmiPg8lAa1tQvUK2L3ObRqQlmnQnZfdSjoXFFCW9s+vMPiI7lvlTLy1aQASNu
	e3Yrw7Jrh74mI4Ia0QEsM3ZclHU38IuRjm7NAP1SKzQELsNCfkyguSBp6R97cmXzv9BzIJYlWYQ
	kHvabyk8ru3KG7qvhQMU3XFlRfrhSG41G7s6p7rW4DMEGNu7TJZfoQLmvQ+JPlTqe5I6L+qXW14
	qd9qzJWsW01o20HHlKeK9AqvwUTCuWLZGs+T9QiFaruiLyIEPZwm5g1FVHWgPbWJSjgWLZO468y
	4oppNkOuBwAZZnjmFcbGBXGR01N/9+Y=
X-Received: by 2002:a05:6830:f93:b0:715:4e38:a184 with SMTP id 46e09a7af769-71a1c2ad1d8mr4817820a34.6.1731592645260;
        Thu, 14 Nov 2024 05:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6WOi/e6VYMuaESWh26yXjsRegZdqLm5bTpJ4NEg8Pa4CgUSOaZkbMvHVfXE3iWkVhZnN9DA==
X-Received: by 2002:a05:6830:f93:b0:715:4e38:a184 with SMTP id 46e09a7af769-71a1c2ad1d8mr4817809a34.6.1731592644879;
        Thu, 14 Nov 2024 05:57:24 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df2649esm66079966b.39.2024.11.14.05.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:57:23 -0800 (PST)
Message-ID: <49b50756-bb6d-4863-bf19-f61057d5861d@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 14:57:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][V2] drm/msm/a5xx: remove null pointer check on pdev
To: Colin Ian King <colin.i.king@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112182218.1119158-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112182218.1119158-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JtBBLhzMiutxECnwxrS5ry3XF9D2ypg1
X-Proofpoint-GUID: JtBBLhzMiutxECnwxrS5ry3XF9D2ypg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=729 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140109

On 12.11.2024 7:22 PM, Colin Ian King wrote:
> The call chain on a5xx_gpu_init is such that pdev is not going to be
> null, so the null check on pdev can be removed. This also cleans up
> a static analysis warning where pdev is dereferenced before the null
> check which cannot actually occur.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

