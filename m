Return-Path: <linux-kernel+bounces-375441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F09A95EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498B61F21E41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2012B176;
	Tue, 22 Oct 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2s6C02Q"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D131870;
	Tue, 22 Oct 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562578; cv=none; b=e2NXmhT8U0rdo/pfPUfaz/4Wu6DvKnPArMSYC+ydB2k8PW2X3qBVrTXIG4dCrlgqgG6HKF9PkTswDfiH7QMvsy6nCDWPdsxE+FKF0VeGyNPeWp8CBxrrkJbPwpcKzdM9OWZsoluVPnklZq5bE0u7dbePoMn/STYsKmLMBBT6Mts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562578; c=relaxed/simple;
	bh=w3uBAv2S85rHsQiAju5VFG2QIMqNZPn5GAggM4kpX4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npSAqNwPkgv1pGm9F/gMNzkcXAJlLuECVS/qa0RhbrSqFpt/x+xC8GVtNAh0asr23DjPWg9z2MN62tbeZFZFGILySGMOYU6YABb6803zrHz6b5lVZqqrqUoA/ZPMWEVZe9fo5n4iOr/m2IXDBh5nT+Oz6FCG2KLSn6pRhPmAOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2s6C02Q; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so74145276.2;
        Mon, 21 Oct 2024 19:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729562576; x=1730167376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28ul720o1zYUO97fBoC0nabWlctPKuwIiK8OcYD8Av0=;
        b=U2s6C02QtPycuToezCYjP9EWgBNy1BYK4rkKFLia9kY7a2OEuoPN5l7VT545KLoi86
         SZHUv3dF5YoaZ9vikBL56QA60/oPHPLJC8UTUwf8x7NmDY+8fC5HyNeSzg/i0dTOtv1Q
         BEbjsJWMLRXvSFQOWRm0xqiRI3M7cLDSeLuugX5iJxxvIkiDeuODO1yTV0GXzPyBOpkB
         Vnzoj2al2OhJRfUFNQBWAQ5wqCoPpkst76oynJ78MGcltCrXLYsQEM6hnCvhgXlIsLAz
         ZrxNDjPWAcvGhA704lJdEFJTNzCq+BMADS3LESXSUeq8sufULrLxKW7E7qv6yK5kq6c2
         BfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562576; x=1730167376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28ul720o1zYUO97fBoC0nabWlctPKuwIiK8OcYD8Av0=;
        b=f7stjt+OiC/W9k4zGTB01aVFrrKqhLoMYStQkAVQVpuaYI1zBiUoMcXfGY2lvh3pV2
         YMpTCnLuLQcGja8teVlCTF2BCZgNqIBJHvOtMzz4KaCIe6rfbSZgnoV7m/tUVbYn0P46
         cp9ieehFgBEG3NAkBPFh5GHxvYLqSnVxjP5cLcGG/W3QuZICdqhTCvVHlSewhW/Obb1J
         5btGOm1Z3NqVlwqW03DhnbUVzS2A/SsnlIDnGaWf89D3phSxrTF7s51j58CQxQoEg2OK
         C8g1n0f88ug/ub6nk5KvA0YurFDduXVbNZpgdtJNORummcq4Vsest3zHP0sw9ZcvS5Qw
         O+eA==
X-Forwarded-Encrypted: i=1; AJvYcCUg/t5rN4uF4/YMkROFoWZ4WGk42Bnfk6mBOy5p2VSizX0rvy/c1n54Y1U4wizwyelshTf66RzyMf3pHJyQ@vger.kernel.org, AJvYcCXbZzwRaan9JWkz+D0kNoHAdpIIjtJHXa8/1/WciqtUr+u0lIgx4ACv5njyzEyRv8lEANB6c/WuorE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SifTfJ3sIuxOMIYCj24BkN+hgX+dL2jRy/HuGj5PAyV2jf30
	EG/8HblgKVv0KJP8j2zDaSjsfhQitXza23JnXvgk7KG3A+TK2Kxi
X-Google-Smtp-Source: AGHT+IGvZ8HwwUM4SFPM1eWXiilrVnXZMURNlN2iRsZjcK7HKlpUr8cduWqCGHyP+J9dwT05By1t0w==
X-Received: by 2002:a05:690c:640b:b0:6e2:2c72:3aca with SMTP id 00721157ae682-6e5bfc9b476mr118367757b3.46.1729562576078;
        Mon, 21 Oct 2024 19:02:56 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5c05sm9020097b3.27.2024.10.21.19.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 19:02:54 -0700 (PDT)
Message-ID: <6bc14163-2240-4b6f-ad5e-8d18c5dce2b3@gmail.com>
Date: Tue, 22 Oct 2024 10:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] docs/zh_CN: update the translation of mm/hmm.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <82259a2656549c90591dc3873f3d2e8a4fb41233.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <82259a2656549c90591dc3873f3d2e8a4fb41233.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>


On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in
> heterogeneous memory management page")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/mm/hmm.rst
> commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in heterogeneous
> memory management page")
> commit 090a7f1009b8 ("docs/mm: remove references to hmm_mirror ops and
> clean typos")
> commit d56b699d76d1 ("Documentation: Fix typos")
> 3 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/mm/hmm.rst | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/mm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
> index babbbe756c0f..0669f947d0bc 100644
> --- a/Documentation/translations/zh_CN/mm/hmm.rst
> +++ b/Documentation/translations/zh_CN/mm/hmm.rst
> @@ -129,13 +129,7 @@ struct page可以与现有的 mm 机制进行最简单、最干净的集成。
>    int hmm_range_fault(struct hmm_range *range);
>  
>  如果请求写访问，它将在丢失或只读条目上触发缺页异常（见下文）。缺页异常使用通用的 mm 缺
> -页异常代码路径，就像 CPU 缺页异常一样。
> -
> -这两个函数都将 CPU 页表条目复制到它们的 pfns 数组参数中。该数组中的每个条目对应于虚拟
> -范围中的一个地址。HMM 提供了一组标志来帮助驱动程序识别特殊的 CPU 页表项。
> -
> -在 sync_cpu_device_pagetables() 回调中锁定是驱动程序必须尊重的最重要的方面，以保
> -持事物正确同步。使用模式是::
> +页异常代码路径，就像 CPU 缺页异常一样。使用模式是::
>  
>   int driver_populate_range(...)
>   {

