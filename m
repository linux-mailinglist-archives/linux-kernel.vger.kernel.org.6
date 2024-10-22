Return-Path: <linux-kernel+bounces-375409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A79A9595
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BBAB203B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006812C478;
	Tue, 22 Oct 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5J1vCcZ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B012CDBF;
	Tue, 22 Oct 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561433; cv=none; b=Psw8OaVN8VwZFFSHfoAsol2ut2IM4NTnW/3RAflmtrq7gdEwaeiRFN1mvwgI/5y1fIiEUrXNNKgJr3rau84ARw3SswUXW32JuUFZV07Skm6o1E1O7O0Q0jvFrjuDuV4kaY4xaJ7BGvnLOkZTAacORMC8y+dhTN4QRXkczfzO23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561433; c=relaxed/simple;
	bh=ejkcxRLya2VN3gLG4cWkbWn5f0Or4zA9D9WBSCwW2hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZMpB9kjecaQNdjoR+Nd4IvPv6bytpE1xdKYAH+/2zrtS1Tqv/E9/GBIrMs307bMZbhC+kYXgdfdX1cgj1U0tJuW/IJ1G66136FPkyJGljZE20mK3dw9BuznxF0DTGShwDHo0+Y2H4yb2NLMs0Gbbzmds5KfFmRRP3ZF8eIr7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5J1vCcZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e5cec98cceso27851717b3.2;
        Mon, 21 Oct 2024 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561430; x=1730166230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f61uqV3ELWQbH6T5fbomiTd9mipnudY5iVc16/0X9rM=;
        b=O5J1vCcZ526/EN3PB1MP7uIBHa/5RHwVa7bkM/PUna7yXxeSZAlDCB2XSLZPQAlkSY
         WAhVYaIwfZVz1gdqYnu0x1h3vjdMJX7uREL1WDPgrXrFHmoZP53HFbKxI06ATdaQeyLZ
         dGNJ0rutrvoFPCi0zdRBmYnuL5LtWILxa+VnDLpItKpVTkdALC9s5CdCANhNZicVsfZl
         1Jac5NzvLBThtzVEiq3bfWz+IeTzXJQLxUT0qMowtcqLhqWocRe04j+Nq+rtzfvomMR/
         I2+cHGs2/Oe3ijxtHtds6t8BbV53dSDet9LZGswBpDsyYI02xixXJdtGtRegr/yQAB8h
         BdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561430; x=1730166230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f61uqV3ELWQbH6T5fbomiTd9mipnudY5iVc16/0X9rM=;
        b=muQrEKZBzApgS9yMfk+KIkgZTEJH0ajPH2seVvuyqfbznXOqekSKiOja/0Dxg6LdAA
         lzqIzDe1Lbopjy2/GaDpRETkW+8q8UX2+aUB7s+0jy74CG4MCj6ctBnT7K3YfUW3j9j2
         iaex6fZj0G1wQ9oNc+h8OLr4nwIJl/QpNOcpvx+AuL3dV3rOktRGp2oVGi+wb7LGEOFO
         hvjUt0NclpWLg9S+hN7OmcWceLL7TO77ywZ+gi/eBbAe1wyvATyFLuOdc9ocqZVigfp+
         3wG0zzPiydDngVTUTnXgReuM1Zqa1WrgS0hz6+5AuCq99jlvEFuf9fyV+ZvULl+UkCEJ
         ruoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8wdo+SBd8q64p4sAvHOQXl/WxCxkhPhhQAoJeOVA1LJbbuCAyPREqb9ENB7O2oUguv0w5cJBO4fdVVkiL@vger.kernel.org, AJvYcCWJM482Gv5drMVmK6msXRLQJun4m8PimYuGtpDxDpnS0tANjfeEOMqDi3V2DGK6kF9r2KOOSIfn+WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJRIwK0fgC0L1e8cRGJa8eg0Ts1LZDp9LmzUyZnX2ALI14fIA
	JzxwT7peMccU0FM5U65fWYeWvreV/150yNDfYtuejdI4FIl5xWRa
X-Google-Smtp-Source: AGHT+IE7KH6GPwaMtwN9MSQoBn5a51JAXGjPX7oRqlCy3YjwBgTrkhXuPyv7SlOqj6Aq23KkZHDX0A==
X-Received: by 2002:a05:690c:9989:b0:6dd:b9d4:71a1 with SMTP id 00721157ae682-6e7d8211324mr13278037b3.16.1729561430578;
        Mon, 21 Oct 2024 18:43:50 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d396sm9089917b3.38.2024.10.21.18.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:43:49 -0700 (PDT)
Message-ID: <2e08db0e-74b2-4b50-ab0a-1318e541ec7e@gmail.com>
Date: Tue, 22 Oct 2024 09:43:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] docs/zh_CN: update the translation of
 mm/active_mm.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <985f62236dad7c9446272d94bffc20eb8f45ae4b.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <985f62236dad7c9446272d94bffc20eb8f45ae4b.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit 88e3009b5283 ("lazy tlb: allow lazy tlb
> mm refcounting to be configurable")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/mm/active_mm.rst
> commit 88e3009b5283 ("lazy tlb: allow lazy tlb mm refcounting
> to be configurable")
> commit ee86588960e2 ("docs/mm: remove useless markup")
> 2 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/mm/active_mm.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/mm/active_mm.rst b/Documentation/translations/zh_CN/mm/active_mm.rst
> index c2816f523bd7..b3352668c4c8 100644
> --- a/Documentation/translations/zh_CN/mm/active_mm.rst
> +++ b/Documentation/translations/zh_CN/mm/active_mm.rst
> @@ -13,6 +13,11 @@
>  Active MM
>  =========
>  
> +注意，在配置了 CONFIG_MMU_LAZY_TLB_REFCOUNT=n 的内核中，mm_count 引用计数
> +可能不再包括“懒惰”用户（运行任务中 ->active_mm == mm && ->mm == NULL）。
> +获取和释放这些懒惰引用必须使用 mmgrab_lazy_tlb() 和 mmdrop_lazy_tlb() 这
> +两个辅助函数，它们抽象了这个配置选项。
> +
>  这是一封linux之父回复开发者的一封邮件，所以翻译时我尽量保持邮件格式的完整。
>  
>  ::

