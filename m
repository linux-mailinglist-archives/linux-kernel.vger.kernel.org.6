Return-Path: <linux-kernel+bounces-516652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A313BA37560
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD063B0247
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D551990D9;
	Sun, 16 Feb 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlGlrnKn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1C2EAE4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721789; cv=none; b=L5N16jV6C/p8FL2pL0a8j2hfeRWeS3vkZCZtskBOCx2wGSraQPMdQqCcmZsQ6UrWanl2P8orQY2KkTK7zETFd5S+uxEVQzbpf13lMQg1UjJyeAKH8kLA7W2u0Ge4FEtwVTgh4fH18e6VdCDYFwEfOYwnPy9Vtfp/MV8aKi7BVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721789; c=relaxed/simple;
	bh=+hs8dPlv649ZuZboi0I0jvkHr4BIxeOpWHTRcis4xkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne67jLDuhlC9d8aR8nvXLfk2NRm/cGQUHV9IMRstfY6vj5pvwF6iWKiNsvAYDlzzs9KHLAOyDcG2p6GcBPQszXL0UdD/3AJwueHGkBIg4cb5Y4etP1dXMcS/KYgLinewLuOPw1iBXvmIxxd7h9zTPurzBeQ1icHzaM10IOn8D9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HlGlrnKn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so1798705e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739721786; x=1740326586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WalijOTNz/wHoQJXRkE+i0bnTCvGIIuSGBI+PUXsc8=;
        b=HlGlrnKnsPgeGsoMJzeIqlqQxsgT2vGzZnQBh5Pf2O5j9s8GWlVR1oj3RNrQiP04uW
         3Tbe/JSxTLzXsb/FbVTO0KE9x9lr6urAfjs8K6erZ3w5Kq+6nkxu7leSJqpUwpoUpXtK
         zBRa/QmSBDYmaHeJu0maWRYjvI99tDQ2G0tG1OSag5e+FVr4ipape3Ft/0hcxZPWe41x
         KTfDNM8E0mVhDXoYtYWveLFjztnr5NhJWiEkQVCuL/b7sbfUbcusxL/5OgP0EtO9J0p+
         f24tzwdIT5vDIkaI/thoQZgdaB9s+jqMaWG2DL35z47/EMkN4LFTEpe4IRUie82r7mSZ
         wSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739721786; x=1740326586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WalijOTNz/wHoQJXRkE+i0bnTCvGIIuSGBI+PUXsc8=;
        b=LfKfE8MDWiKxNqnYqjo+I5wIudmFk922zJLwEPysrpZejVz3vbzNsfY58YHMW34Rp2
         LMxZuIcmh7v33raPwIikPnA7CLupoJLFPPEw1U4noHIdET5cR111rRx/eYaPO297sFzG
         VaOZZy0lgYRNpcYW/LvMd6yF/uBg7uQyptL0qDonvuCAEF/yqq4mf5jhwCLkEE4UtsYZ
         CZk3vGh/5IfRKJdclcIGqYnPuzeSuDsWfmmoN+JgPacMQohXP2FuyEuTLztjy3eBmSlH
         zZ9tRnqhwxgwNV9AIAlNGmUv5RIWCzwNKBKGHzEbH1gLH3wlqNjdc+6uG6mNTnuvSUpu
         8N8A==
X-Forwarded-Encrypted: i=1; AJvYcCUHYSDr68r5oIGs9ahghXJEsVfeCbppGLjgFX8ckFWHKybbeuU6kYlCLv/6E3CmMiXkTYFCNb4abbYWIc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCZ/7JFjXHb/9jL0O3O0NyMgo+RG+xTk5kwfbhD906j865Ro3
	eMgmKeMrQlEfUka7wE0VbNgv5MNnN5P483pDzq0AmFG9T+H7aJi0+Wp5pBSsatI=
X-Gm-Gg: ASbGncuuc6lDB7qHtb9sJgWEslWRJzthm+adfD/6hM4FaaMbihJY1SOgH0jgwTox/9B
	EvtOnyv+99YY0++ZoR6JuBe3C2ij4gSHScroEzoNMlO7QXrLRQ8GlnQjXHS5GN0aVWhUrCKF7dh
	wRw696hhwIVpc7TCvOWInPkG3pkrqHlWffxDO+AWRv3iQeXJk6SC8A3r1GCE9CTN5sqcLkDG7MN
	RgUmlf6NVV3d3axYYV+Vz6IgiPsv8V4+prjbBH6nGlOK+l9ZHaAg7CSES0IMvfRMjjAizEhGruk
	QHYl7m/W67noHoBgQTPosR+nJzpyXEyFaNbwOu0ODjRh5oOQ6eGNzUHW
X-Google-Smtp-Source: AGHT+IHedH1KLJz+JAqT1o2zSIOfhcwUOiD2GGTr4gt+kVC6Y/4owul+oVcVO1XLpogHuuAgPnHPEA==
X-Received: by 2002:a5d:5f4e:0:b0:385:f220:f798 with SMTP id ffacd0b85a97d-38f33f3737amr5455766f8f.6.1739721784259;
        Sun, 16 Feb 2025 08:03:04 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9970sm97159865e9.33.2025.02.16.08.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 08:03:03 -0800 (PST)
Message-ID: <c3b27e55-f627-417c-bb62-3189f248fb99@linaro.org>
Date: Sun, 16 Feb 2025 16:03:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] venus driver fixes to avoid possible OOB read
 access
To: Vedang Nagar <quic_vnagar@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215-venus-security-fixes-v2-0-cfc7e4b87168@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250215-venus-security-fixes-v2-0-cfc7e4b87168@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2025 17:19, Vedang Nagar wrote:
> This series primarily adds check at relevant places in venus driver
> where there are possible OOB accesses due to unexpected payload
> from venus firmware. The patches describes the specific OOB possibility.
> 
> Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
> ---
> Changes in v2:
> - Decompose sequence change event function.
> - Fix repopulating the packet .with the first read during read_queue.
> - Link to v1: https://lore.kernel.org/r/20250104-venus-security-fixes-v1-0-9d0dd4594cb4@quicinc.com
> 
> ---
> Vedang Nagar (2):
>        media: venus: fix OOB read issue due to double read
>        media: venus: fix OOB access issue while reading sequence changed events
> 
>   drivers/media/platform/qcom/venus/hfi_msgs.c  | 72 +++++++++++++++++++++++----
>   drivers/media/platform/qcom/venus/hfi_venus.c |  1 +
>   2 files changed, 63 insertions(+), 10 deletions(-)
> ---
> base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
> change-id: 20241211-venus-security-fixes-50c22e2564d5
> 
> Best regards,

Could you please address the feedback I gave you / questions posited in 
these two messages ?

4cfc1fe1-2fab-4256-9ce2-b4a0aad1069e@linaro.org

0eab7323-ce86-40c7-9737-06eedcdf492d@linaro.org

The basic question : what is the lifetime of the data from RX interrupt 
to consumption by another system agent, DSP, userspace, whatever ?

Why is it in this small specific window that the data can change but not 
later ? What is the mechanism the data can change and how do the changes 
you propose here address the data lifetime problem ?

Without that context, I don't believe it is really possible to validate 
an additional memcpy() here and there in the code as fixing anything.

---
bod

