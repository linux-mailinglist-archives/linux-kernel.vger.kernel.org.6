Return-Path: <linux-kernel+bounces-216570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714690A18E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25389B21BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3433EE;
	Mon, 17 Jun 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su22+yyr"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91BBE6C;
	Mon, 17 Jun 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586367; cv=none; b=Jg7sQ0HkiNC15VTQQPN/OPXfe5r2WEehaQa55vLoqk4v1RWkhiG5QHlxfPIan/Ei3BDHY0nDQHGyBipfZVuwfUgJr6KZT4aLMjPDpvhrLWCXH3rPlLu3SO8u+PAxn2CibQawHj2y1yjTEYYVhqzhQoMd2RPEcy2DsH2Z9xQspcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586367; c=relaxed/simple;
	bh=kSPVw4dT4J8MrF+bbCP8+FxtODsw4m+RIALku8aOxYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stgNQn7CdN6I9cE1fx4fCm0LyYnIkQ9iyu9b56E+EvcRFgEpM8o4rJuLD/pa0JAQj/fJZF0ACsugXe2SYwf89AwjdwkTAQtKUFAa7xbMvD13+obQpvzHg0x8QjKV0vKhYpP6Syz8gRRABlF48kKPGUPYIJTfPeMaYaiEs7AjnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su22+yyr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f8507aac31so33354255ad.3;
        Sun, 16 Jun 2024 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718586365; x=1719191165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFgL/o9mJY8Tf7C2W5BjklY1i7RQ/yhFk9Ylqaj0pKM=;
        b=Su22+yyr1NvxH5eJYiYsChuag4HvttdcsnemABNGq9ZNFWK1zebwkWjTm5N8KOluGA
         7zWU22WuwVyXm7E+19pYmjFLLVDS2U4MiPAW9QXdwXBVziuPCgg5RciOSgzc/VcrtdT+
         53BljbOeNtMTDerZmMmhdE22kuA99fHx0yvAxyICk7KRe44pcWqVXoIdlTBDoq29HN9Z
         MO4+4N0fg+pSepzihcf6xv+49YptfuhgEsChQi8crwctWJRCQ6lesg3bBe8gv4SIpSHr
         HfE0Ibcip7VHGXJYsvm0/+sqge6Q1mgVfmybo+DEJDXPHOQ7aXQ7dQvpR0mNlpK6Amdh
         CUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718586365; x=1719191165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFgL/o9mJY8Tf7C2W5BjklY1i7RQ/yhFk9Ylqaj0pKM=;
        b=Ltj2uzBZ4xxH6zlQzU6iQYempr1FsDbXRQAmJZg6inDZm+X9HvydCDzYeSp69TCaJl
         osWZ1JUem2MEod6MP0N/3RGWtVPfa6CLnkHx6Mx8QMBqaT0TpxgFd8xALfZfDnVdNC+E
         gLZni/22LDPnfKQamLG7nef3mBooY7Mh+pGbLY2QjHtUBzcScjkIMd2ueMX9yJv/l1cz
         ZiV9K8NFxSOWOara3qVktRsKZINGaowEGs4Fjr64u6oe3DqG8zlBoIiLWI3tKWdVmaOu
         Gt3IkzqRU9plFG+flczNsCRjzswO+CT/XwIfY0BJ1MAe/NT53uVL+HVFgn59PYK1xxuP
         3BqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMTN87XnOnDjqctKUBu8Mk3RYY5uZZvLqXILisc1Q1J7KR3CcAkPlR5ulSkmIIHtDVFWNT4ifvAb0dMM/u0QdxT/ej9PVo53HrlNCAWAF458B05rNGPLsytiN2hSplTtZTtzLG6cmL
X-Gm-Message-State: AOJu0Ywx+hZnN5RooFjBX350j0A/ZLhMES8Ulq3dHab495jww27XaABc
	kyRcJ/tAA1YS7SctCs+Wh/MGXXYR3rXi9OvNMeHam8g8sxB+D5IO
X-Google-Smtp-Source: AGHT+IFbUwBMPGeGJAExix8Yqkga+a/KeW2fDm513vJgbB4Hikah6j54+sOQ7dc6+R46HXgTWTLSFg==
X-Received: by 2002:a17:902:c945:b0:1f6:efa2:a030 with SMTP id d9443c01a7336-1f8627cf05dmr110468245ad.19.1718586364922;
        Sun, 16 Jun 2024 18:06:04 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f17d5esm69436795ad.225.2024.06.16.18.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 18:06:04 -0700 (PDT)
Message-ID: <bad5950f-0573-493e-868e-fe71d0b60ec4@gmail.com>
Date: Mon, 17 Jun 2024 09:06:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: add back the missing part in the English
 version
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Andrey Konovalov
 <andreyknvl@gmail.com>, Qing Zhang <zhangqing@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240614140326.3028384-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240614140326.3028384-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/14/24 10:03 PM, Dongliang Mu wrote:
> The zh_CN kasan document misses the code change in commit eefe68280c94
> ("kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO").
> 
> Fix this by adding the translation of the missing part.
> 
> Note that this missing commit is found by checktransupdate.py
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Reviewed-by: Alex Shi <alexs@kernel.org>

> ---
>  .../translations/zh_CN/dev-tools/kasan.rst     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
> index 2b1e8f74904b..4491ad2830ed 100644
> --- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
> @@ -235,6 +235,24 @@ slab对象的描述以及关于访问的内存页的信息。
>  通用KASAN还报告两个辅助调用堆栈跟踪。这些堆栈跟踪指向代码中与对象交互但不直接
>  出现在错误访问堆栈跟踪中的位置。目前，这包括 call_rcu() 和排队的工作队列。
>  
> +CONFIG_KASAN_EXTRA_INFO
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +启用 CONFIG_KASAN_EXTRA_INFO 选项允许 KASAN 记录和报告更多信息。目前支持的
> +额外信息包括分配和释放时的 CPU 编号和时间戳。更多的信息可以帮助找到内核错误的原因，
> +并将错误与其他系统事件关联起来，但代价是用额外的内存来记录更多信息（有关更多
> +开销的细节，请参见 CONFIG_KASAN_EXTRA_INFO 选项的帮助文本）。
> +
> +以下为 CONFIG_KASAN_EXTRA_INFO 开启后的报告（仅显示不同部分）::
> +
> +    ==================================================================
> +    ...
> +    Allocated by task 134 on cpu 5 at 229.133855s:
> +    ...
> +    Freed by task 136 on cpu 3 at 230.199335s:
> +    ...
> +    ==================================================================
> +
>  实施细则
>  --------
>  

