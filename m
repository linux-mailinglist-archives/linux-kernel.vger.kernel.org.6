Return-Path: <linux-kernel+bounces-271790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816F94533A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346F6282258
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F531494B4;
	Thu,  1 Aug 2024 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QhjHTyo4"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CC1422D0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540037; cv=none; b=AL1kgMZHl4CUaxADw00SD7KwO6sRDS5sw5g6PkkroNEggFC0CSmAzqxxHNaeHEgeWp/V9o3UdYd81Rhw7OvaElPN1D0Yemq3m5gJVD5ZziWqMKTkS7lMFOMDuhtRk4fyuaViBSZEWusnmlMjr0Av6kxYMzRSrE9zW3tGKjEnKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540037; c=relaxed/simple;
	bh=SEHgN/kv6/C26FTWyoXLiqKYn9TZgDOsUttgHckkeXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JKzb8UZdachQFjBfTiCoai2Rx48I7gMTslJerzJY7HDT+qngx7nVdgobDzeDDAtgLiXcIEnR0wHOgiTG5M6oVW+c487sxgVzCH95cSleq6hVVcWHTRGHgvewpppkg9iSESTLYk3FcBG8xE8QcFawXK9DZO2jFj+Yz2iyolB3VaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QhjHTyo4; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-399020cfbb7so30170775ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722540035; x=1723144835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0pg6YXhtY4f6UJYgaFLa/yn7KUmiZNNRf9NC4VF7bk=;
        b=QhjHTyo4GfOR7jgM06eM50kEGXcPkgBgYVpCKXtIAEZIpg3BbRtN7NKNNyLe/NV/v+
         wtL59iFCScCHIaksAKmM4akJqRSqfg4INQdoYEwnYbelnpfe98Tlsppb60FnH0KyLGf/
         2TwXyUIg+nmfJBirelOR/iNNAEhXU+pPt/ozJIGAGdlRRrJYH00lZt0eJxzPNyUpvpnO
         j8O3SgYF8OaVfJm9sUPOkoAVrSRbzIq2oLbn/xT7ofXH6kSYknTiopiBrRBX8qCHiuJW
         Mmr0Qg7l6xURsuYW7p/pfJopBFhUDg6FX//Dlzt/xBr/RszrXx2egeRTP1m2bF3QFtnI
         C5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540035; x=1723144835;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0pg6YXhtY4f6UJYgaFLa/yn7KUmiZNNRf9NC4VF7bk=;
        b=HWT2TAkTclqnkyqfqLmRlp5UHQaBki9JbawW+A4BmgX74NG9Q/H/hCN/G/5MJ1YR1U
         OZuqBmLgMIYQp0i1QLnxp8QN0qv2N47FPDcZXiWoFIGdZl6bt9XbTFJnTEd/AwBfo7mx
         b+n79OJBd/4lbm/tgv4reyJSUHS6wT5ciG1XBzHaRSW1lSIEUbjXzlOIObGcP3Ml3rEn
         9nm81528WtFgU0tRVjNSNs4UT6HYgi5DUOPHV73hpkVWgRoYFsBm+W24JQ3KD+MZYLbp
         l5MxDlUZJeq1ZEVJ8F0SSky0SBuTmUeIgtIs5R+A/bc3fhzTVixQoRqtJVVCMrZvTenj
         +9PA==
X-Forwarded-Encrypted: i=1; AJvYcCUAbppc1XFYOsWbEIqXpdkAASJoR0uJcTF5Z19Uiwgk+xy8tp6grzTJW6xIwKWK0yxtr9xLiCoDDxBRcdammRdBqLQ3fmz4z6YdcfhG
X-Gm-Message-State: AOJu0YzL6fkGubUuPJ25cBmFNey4zyqWHnyzEWkuJ630HDZXlk1Gbs1A
	/Ekx9MwKpCgVZb74xHYrsekb5pA2Evw0a3Jecqdw30qIGzv8Ad3Ha2H9vZx86zY=
X-Google-Smtp-Source: AGHT+IHE2eHuMz82l6ajvPT31NaD8GDbZZogtIvNcarXHsXietZcyodp9fy+D6q8Cawbi5d6NuA1Kw==
X-Received: by 2002:a05:6602:1641:b0:81f:cb5d:a5a5 with SMTP id ca18e2360f4ac-81fd4353a70mr208168039f.3.1722540034835;
        Thu, 01 Aug 2024 12:20:34 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d82ef9sm12146239f.52.2024.08.01.12.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 12:20:34 -0700 (PDT)
Message-ID: <b5343609-1b05-4825-99a6-57a33187dc90@sifive.com>
Date: Thu, 1 Aug 2024 14:20:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2] riscv: Re-introduce global icache flush in
 patch_text_XXX()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240801191404.55181-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801191404.55181-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-01 2:14 PM, Alexandre Ghiti wrote:
> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") mistakenly removed the global icache
> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
> reintroduce them.
> 
> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Closes: https://lore.kernel.org/linux-riscv/a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/patch.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for the update!

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


