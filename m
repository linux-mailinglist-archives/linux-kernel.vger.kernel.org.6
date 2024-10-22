Return-Path: <linux-kernel+bounces-375408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A529A9593
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F5D1F23C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19AE12C81F;
	Tue, 22 Oct 2024 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QszEiAPk"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925471E51D;
	Tue, 22 Oct 2024 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561403; cv=none; b=cx1FnGTajs5RJ4U8NIQPi9emhWYf719UKthpThGTxDL1eZheu7vyzVgvOCterC9IFRl+j4c56+9VRlbbFshPB9oTdO06mGPBShHM1+vBZew5WGgHCZRl805Vnqkany1VfFF8ofdTQbtkULTP7blbVhnVZT2M+TIhFCuUSiHpP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561403; c=relaxed/simple;
	bh=+EgaXF/VyRaCocT7c4QBaSaXuDPO+CiNlt6NTkbIoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkWVLnI0i/mWmsUEuk8LKfi1AmdicWYkLjOAtBHvGmAtiar2bQfA3YBy8iP82HWfZC/F1VT/OLDyOjZdYfDe9Tz/LAYW3GlA89Ck/XBWN46qqtuZr5Dojc3qVa4PAvZuUXeD20MnrdtHgDasVl5W7dWFb8vNiqlQENyUV1YxJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QszEiAPk; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e61a779148so9375747b3.3;
        Mon, 21 Oct 2024 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561400; x=1730166200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+of3sn6my3fTdyQClh+kg+3L6lJjqrKeiMmZ8o2XgE=;
        b=QszEiAPkS8fRuAxFqFYeBgXACDHz2BypklfVX2w4uhvOk4pqJBwqNX/9dE7/VhOWUs
         cS2YfR+LMQQ9TdtBiN9AyB4iNKftxR7gwVDMOnoNH1TqXSx0KiUOye6Y+/ka0kRGWJhq
         Sw8aPO2aRkdgfeeNU3+/5kg89BZM/Fba2IS4PxX3FWbmWLCrnDMh9bY86Q/pij2MeXFh
         XxEWha1BWNEA3Rg2C4gmxjtVzAx6gXr8CPu9Q3rcXQ02S7sfGS8JqpXzz+K8EHdbovTq
         LSxigIXAB2W1KIUG2Q0OSef/2/rGcd7mpRrzeuHflldPW//N9B3NfxzdV7aOtxGQKxpj
         T3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561400; x=1730166200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+of3sn6my3fTdyQClh+kg+3L6lJjqrKeiMmZ8o2XgE=;
        b=DuKDCD8Yvejnjn8fvDZSfmWjfHpfsOjCSEczOH5KG9ua8qzzxWs3VtkHuJV4Ppyc9G
         pTxP65P59Jjot9qJKsXarwqYYA4/WYU625pEfh8Mz77ZT3SKCK9r2DuvJlL9R0MTL6Wl
         rCE1nNtxeUeLsTILtF1ZFuGYfd6uWjhPiX8xttk3j5okJ8pt3AdYS5Qu+I3KrK/UWft0
         9wJqp0DPO60GXRzqSmaPY0mOniaHsTxaTjJtuRHaAFOUSH71Xcb4mbM1j6TYP6lVo5iY
         k2bxoQ1Z61UwUEdMwNnphx9yZt/zZX+h4LjY9phrY3fM/LcVpeOQAgQ6N/T7rsJSXqcS
         Wp7A==
X-Forwarded-Encrypted: i=1; AJvYcCV9QaSS60NiPfMEJXsEY0bzye3lvko3r2c530TwDYiV5THvRAhphY50LJ095+dyfE9sV/4GFpF9gKWUDc2R@vger.kernel.org, AJvYcCXVo9/CN14HgJwVa3KprmktDvW6fCnJO7SBqMcZ7j+ozeNKP/xGDVOyg4pPbHNR+50N/n1TVRhNERs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyraXjfrCXeuLBaol4S/+LyZA7knQV6I8/OMGrueQBvoe0A9Bbj
	HVjnrj9opa2HxTgTKhlg9aVB4bSAvbKXEm0mW7gYFraM+5d9XEGp
X-Google-Smtp-Source: AGHT+IGmi9GxWrSh8gqT8EyqhsrowpFhcEE5nadMXCV0dFI/UXCHqclwi1pwgxSEsTJGDj0ycO9cdw==
X-Received: by 2002:a05:690c:f8f:b0:699:7d04:c7b4 with SMTP id 00721157ae682-6e5bfc39b06mr127229597b3.31.1729561400461;
        Mon, 21 Oct 2024 18:43:20 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2a451sm9030917b3.116.2024.10.21.18.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:43:19 -0700 (PDT)
Message-ID: <b1a1f485-5d59-41af-a864-86e5e361808a@gmail.com>
Date: Tue, 22 Oct 2024 09:43:12 +0800
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

