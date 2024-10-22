Return-Path: <linux-kernel+bounces-375411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8B89A9599
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271C02844DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E213A868;
	Tue, 22 Oct 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhyGgtXs"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896941386B3;
	Tue, 22 Oct 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561438; cv=none; b=lkNSXBY7FmNK93X7ZfUNiXmtxwGlxmWlMT8QMRUfFE1qdH+8CCRSGxRkGXMpVGFgU+zcNEq02z4c53kQftY/hdLJxJ5p2daHAUvMnCj1uk+d70LaAXtR6oQglMBrDcMQylfJfrMlRuYZh3iaeiMmfXWXusb8ghSqczX3Ktcyh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561438; c=relaxed/simple;
	bh=ElqyEH0DssYXbZTnGs2QRhOqJPmAhDVhwab/tOXFiQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPvtoidomFFbn84ZPESt+iN+kDz6usG7hxMV2UT8YkOX9q2MJX013bdckWCRPTOPnPupliCFRv3YaWuv9Ucf/hlMJJ0M/S29u2DaRtNe9Ryg1Ri8AkjzpyuZb+ivxH8txqZ2az5g1DMiOVnZQCcX92hdTJfvF1v6DPFEynoA+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhyGgtXs; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e305c2987bso48566817b3.0;
        Mon, 21 Oct 2024 18:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561435; x=1730166235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukmYbiWY9+eCvH0IalSjBrOVJUmrNYDkseP5cJlLa/0=;
        b=XhyGgtXsQyngfFIw6pUsdwMvzautwM1Bq+9N5WHe/5wDLC8g0e23itYvwl8GCI+qZV
         EQHk5JLu6wd5Ntr3FM0gAnTd1LLX6dsLbKwntpsrgt2NcOsIpmyBJZXvuL61GioZ7YAY
         YXsFhITUDwwjGYSIvBbuk3R9MT1oR88sbXFQV3RhrUtd0PLCR+Fi/juudb7NgXqfEVcU
         Wo1j5jtU1POpUXZruxyRtlfQAahLV+FlMYj1rYUMrw2zCy6fU0kE4Ad65AYn7sEZcvuU
         4WVzhknY0U+/8+1OH0/k+opoxPDl0V+D1KkDdne0E5NsQVdoGwBWknS4sh/RLBCpcuBs
         i+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561435; x=1730166235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukmYbiWY9+eCvH0IalSjBrOVJUmrNYDkseP5cJlLa/0=;
        b=kXKv5XaI/FpLiBeOSQnf2Ux6IEhh1OZEJ9XUfv6IRIlHCiOG8EDWAAwAs/LciodTF4
         bI2hYG6ft8yHydvEbEMpQipdsjzug/5S4whuOVwn5RC1Saw0yjjfPGQNZDf1OJ+GJuzz
         7+PYEpg/QQlYxZ3RcUYWTdFCAcVikaAsuHSA+y0k8v2Wtzm43MpUJ2Wd5gXqMTL6Rujh
         GDcfPs0o8Rj2VyYtad2a5pFez+9M/gNBBh/Qt4zy7oxmT6dfEb0EO6HRw6fK7GX9KNKl
         Xl8vFHcwEXI+SHsNQNhUSdthm49OAACQ4Kgw2Ltz8eU5hrkp7B+k8vawik87+AHGAHx2
         LBMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBOYHsqgeb0i65IdUnowim6C+bAeCzQOYe4f4HAnSH4npqRJm9wjCwE60Bzt0RqQqNjTxPc+Dk14w=@vger.kernel.org, AJvYcCXaZ3EiQKcngJdMkKWgVtdJ5bAgTNvVbL1L99nglQW3Ck55z0J2nXVOSvwLEdVniE8alQaYZ6VsUa93+k6+@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNJMwE9qyFlJGZTIR+kRGjz6wFl7q/8AFAiPrE6NkjjU2MWrj
	RECEzkIMuCOXDeRBJd+xkr7wwtq2RoICqssGxPH4hSNHwj8b3N9g
X-Google-Smtp-Source: AGHT+IGxILeaWc58NcOJtxC2jJr7m9XvKIsCMs6y6xQyjInDCZ1/XAxfDArRLAvdOk4krlaCGj4ROQ==
X-Received: by 2002:a05:690c:385:b0:6e3:fb4:9333 with SMTP id 00721157ae682-6e7d3b84592mr21093487b3.28.1729561435560;
        Mon, 21 Oct 2024 18:43:55 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d396sm9089917b3.38.2024.10.21.18.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:43:55 -0700 (PDT)
Message-ID: <25a18538-0704-436c-8df7-a485e644496b@gmail.com>
Date: Tue, 22 Oct 2024 09:43:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] docs/zh_CN: update the translation of
 mm/admon/faq.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <20e7e17b18542ecbf924234ed40438b95345e514.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20e7e17b18542ecbf924234ed40438b95345e514.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit c6bb975aa60b ("Docs/mm/damon/faq: remove old questions")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/mm/damon/faq.rst
> commit c6bb975aa60b ("Docs/mm/damon/faq: remove old questions")
> 1 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/mm/damon/faq.rst         | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/damon/faq.rst b/Documentation/translations/zh_CN/mm/damon/faq.rst
> index de4be417494a..234d63f4f072 100644
> --- a/Documentation/translations/zh_CN/mm/damon/faq.rst
> +++ b/Documentation/translations/zh_CN/mm/damon/faq.rst
> @@ -13,23 +13,6 @@
>  常见问题
>  ========
>  
> -为什么是一个新的子系统，而不是扩展perf或其他用户空间工具？
> -==========================================================
> -
> -首先，因为它需要尽可能的轻量级，以便可以在线使用，所以应该避免任何不必要的开销，如内核-用户
> -空间的上下文切换成本。第二，DAMON的目标是被包括内核在内的其他程序所使用。因此，对特定工具
> -（如perf）的依赖性是不可取的。这就是DAMON在内核空间实现的两个最大的原因。
> -
> -
> -“闲置页面跟踪” 或 “perf mem” 可以替代DAMON吗？
> -==============================================
> -
> -闲置页跟踪是物理地址空间访问检查的一个低层次的原始方法。“perf mem”也是类似的，尽管它可以
> -使用采样来减少开销。另一方面，DAMON是一个更高层次的框架，用于监控各种地址空间。它专注于内
> -存管理优化，并提供复杂的精度/开销处理机制。因此，“空闲页面跟踪” 和 “perf mem” 可以提供
> -DAMON输出的一个子集，但不能替代DAMON。
> -
> -
>  DAMON是否只支持虚拟内存？
>  =========================
>  

