Return-Path: <linux-kernel+bounces-375414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBAB9A95A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D67C1F2217E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAD13B2AF;
	Tue, 22 Oct 2024 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbpATPA1"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B113AA2E;
	Tue, 22 Oct 2024 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561488; cv=none; b=jVqXXe/m9FRb2h6Q0ychIup/IjMx7dRLvs+xfV013ZslmQ10HPrMHGNLOXoYsEhGOYKZ61O0B0v7Pfyco5+r57pmDusv+qOI+VIMVZpknsPID0N/XCpRbNCGRq/TzFCyiNdwHIfmHfvsaUYhjfTgnt5qqR1bKd0Ibszon20059M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561488; c=relaxed/simple;
	bh=LM7kCxfSdjMImrtNwi49tjX0XGpmKW4U+0YaTeZ40tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akPfTxtIoFcYW2E4sBtT7H/NOKY6I8doEwl19M96t43GiREeF9thx0v0MPLDLh0XWO8gxdZvnY61w2asCPeLpUp9jzJy+JWKFsSazbE/JT4HuScisysN5boEeTXNj0Cmyhpl8WCzag/AmjURg9hK7VXeo2R9y0b2Q26a8vJmDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbpATPA1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290554afb4so4899724276.0;
        Mon, 21 Oct 2024 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561485; x=1730166285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRmrVHIc6mh1gXV4gWBICi785kZ9ZmDV8j1zATRO+vg=;
        b=jbpATPA1ABoeacO5ZSlOtmuUQuDUeD8BCdeypB2KxUZrAmF6rjg91d5pBh9e/IUMMl
         DbdXMlmPOo1OOVf2GcJZkeapXcklCzk0y0fnrI9FfseIGFMbc6VolvlH1LL8Cq0RCmR3
         KjGpDDsHrYKpjOgHaSZrT8yEd8yxzaNXUz0a+/ak03Sry9lk8An3HkqbhiEusJfd6wRB
         xUPyPDU67/YAvL/KOZhuz3qCf86tN78gm/ly+sLdRbZ3DfILEVKR6QCJtx+XNXcWdCEj
         0LKqWxS+nog4/h0qSuq/HJPgBma5vhW6gvA8n5V3zGtoMQCyIFgFETnM/EeQANy4HECl
         wywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561485; x=1730166285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRmrVHIc6mh1gXV4gWBICi785kZ9ZmDV8j1zATRO+vg=;
        b=jsxPPFCCjYgBDoFxoZtrCw75j/HfVF0RVvipPPI2mRj6Ie0PPoTvYHMIjzC2BBTJoW
         pM0pnQLyrLMymHqm/XSwyM/8iIRInAEmVsQU6Q/7gEm/Za2D6W2WxUcPziEQu+lRLqo1
         KsFnIPDSlsM6rEfJezMfpwZCNjMyIJ0L9KZahOQsJYw/v+O4QexEAwDxKUnYCuVesh2w
         e4QnOV2+eT/uBU3I4PWIrFjl5W087ngGz1jQoSslpW4L8XdjcHBNIDlWcyZRYrK4eRbo
         CLd7uTnvdnx4yM9sdeCvIg4gdk27Y54sUsJPn8oaZljxTtsifgBmn9kpCv5LWNsz/fks
         vmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCViT7TAOXXnv00SP5hg/zvNyDgLoEi9sT9SaK0D7INiluCYCV642mLG9xFgCwQ3lFPsgudRs+ktkZo=@vger.kernel.org, AJvYcCW+GNGq8MvfPWRPgMdJCfklEU6i1mGc89Horuvz+5LN83buNXEReLQ1iC4dhuhYIzMG9RfNJjAYIn9nOpOi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwv6IGpMK6+x0nIjSU5MxtB2CJZdr2Oh6G/fodbavfpYZy21Z/
	f/OGgQI3+JlTPFll7+31+Oc8U9edx9DhisCZutboV4OaMCsiLocwEOjizeio
X-Google-Smtp-Source: AGHT+IEM+DJFtW49hW3Q3linHM8gj0afhMUQbXfX5EtEogd72s8mO5klbaDq6vD1tpyEE455IiQtQQ==
X-Received: by 2002:a05:690c:2f0a:b0:6e3:39e5:f0ed with SMTP id 00721157ae682-6e7d826b656mr9384047b3.26.1729561485514;
        Mon, 21 Oct 2024 18:44:45 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2d311sm9100247b3.132.2024.10.21.18.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:44:45 -0700 (PDT)
Message-ID: <0a794201-6886-482d-8533-dd7fd9e59de9@gmail.com>
Date: Tue, 22 Oct 2024 09:44:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] docs/zh_CN: update the translation of
 mm/page_table_check.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <68b62a5713d5a465f09226c1a607dee7ec76a6aa.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <68b62a5713d5a465f09226c1a607dee7ec76a6aa.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit 8430557fc584 ("mm/page_table_check: support
> userfault wr-protect entries")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/mm/page_table_check.rst
> commit 8430557fc584 ("mm/page_table_check: support userfault wr-protect
> entries")
> commit 81a31a860bb6 ("mm: page_table_check: Make it dependent on
> EXCLUSIVE_SYSTEM_RAM")
> commit ee86588960e2 ("docs/mm: remove useless markup")
> 3 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/mm/page_table_check.rst      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/mm/page_table_check.rst b/Documentation/translations/zh_CN/mm/page_table_check.rst
> index e8077310a76c..dc34570dceff 100644
> --- a/Documentation/translations/zh_CN/mm/page_table_check.rst
> +++ b/Documentation/translations/zh_CN/mm/page_table_check.rst
> @@ -54,3 +54,16 @@
>  
>  可以选择用PAGE_TABLE_CHECK_ENFORCED来构建内核，以便在没有额外的内核参数的情况下获得页表
>  支持。
> +
> +实现注意事项
> +============
> +
> +我们特意决定不使用 VMA 信息，以避免依赖于 MM 状态（除了有限的 “struct page” 信息）。页表检查
> +独立于 Linux-MM 状态机，它验证用户可访问的页面不会被错误地共享。
> +
> +PAGE_TABLE_CHECK 依赖于 EXCLUSIVE_SYSTEM_RAM。原因在于，若没有 EXCLUSIVE_SYSTEM_RAM，
> +用户被允许通过 /dev/mem 将任意物理内存区域映射到用户空间。同时，页面可能在映射到用户空间期间
> +改变自己的属性（例如，从匿名页面变为命名页面），导致页表检查检测到“损坏”。
> +
> +即使有 EXCLUSIVE_SYSTEM_RAM，I/O 页面可能仍然被允许通过 /dev/mem 映射。然而，这些页面始终
> +被视为命名页面，所以它们不会破坏页表检查中使用的逻辑。

