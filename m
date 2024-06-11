Return-Path: <linux-kernel+bounces-209301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5C903234
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCFB26D22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB692171083;
	Tue, 11 Jun 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge/3Skha"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBC170827;
	Tue, 11 Jun 2024 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085979; cv=none; b=k6Q3yAwLBnE53B0TwHsJMFqwrsgmFNKgBjQvk1+LN8nAKm289B27REJ1/z1K8qxV/HlnRFAoeuWvXQWh4+3q0oP0eVSgeDDlfH4/rpliVoMpVIMxz88E7GqGXXSyTmwhKU2AIJmRNBFLV6OTprhr1LIFlBqN4UHxYRyofhxm9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085979; c=relaxed/simple;
	bh=3WLu1KzhWF8BDxB6Gi2ctuPCKZTHtbDKETwfBMiGSHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9MQaP9CPerU5KPFPOVXnaVmDReVZ0vEpyRTrGACjeNwrWYIIR0i0+5sxoYtkfk00fETZLUquTcF4Dzi3fjPBbcZBVlV6oUqyBKEKjNQQSv6+s79DupP27gByUdr690QWAwehITMakY9iYVWk7c2SEy7O0qX6tnEZrzUvDcSZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge/3Skha; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3759e1ca122so9116775ab.2;
        Mon, 10 Jun 2024 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718085977; x=1718690777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igVgAJKX1q3RnM3nYvCY6Y/D50W0VXZWCcvRPOLqorQ=;
        b=Ge/3Skha7s30B6lx2uUMVkVNtyw911sIl1zQAvpAFch2wPrhj5mXizc1ORP4g4P/qF
         CWmtW4JnWzt+IM7KKsQn6V4rywd+dgxbuc1qwrEILBhdFRyONWBTNwHaOTyWH8YcwBj2
         R27gtTJg+GsfhigFIQtMPt4/wgvPKj6PoWIjt4XLWaXz9M3vCoH5paCaLTyK9Dg/L3hP
         38oV6hAuqAE0SP8gUth0wQ+IuY0HUSgT1+J/n1m/WIM15R5QCfyiM3JrI2EkFqlBBLER
         Mg38JZ+MUNrRZ8/GxC8GPl2Pjsz4GhIqv8EGS0PwJl+qRkF4m7dGA34SuPaGuz8zEJ4J
         dK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718085977; x=1718690777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igVgAJKX1q3RnM3nYvCY6Y/D50W0VXZWCcvRPOLqorQ=;
        b=vvTQxOUG66C1HC+7kmXR8wV4Naj7qfCuFLRqwCT1hWE11WSqF1piKaU010W+mJx6Qu
         0vLxFfqB5/s/09O8qK4MtOXR+ba+Gd8+lUWf1hOZYKOV8cpQRUsa+v6MN5+FNolZitpF
         NzLeoOXyLHvESoG5MRWKCCA+0p1CrkNfyR+OsTla1/w4ZHWkiOvoud0kg1kDBhQnh3I6
         UIog4dOW7S+lSqC/IRHw/eCuGL8eBRcL5ZlA+2T9ePwMCXc4z37B9gP2lS/Waj+8OwZp
         X1P2zRvKGY6QnJebKv+ZZoXSPCYYI+4pMcndyb/9PyQICwg/ZMu9k7+EDHDmWbB6U5tL
         +yjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr/o22RJscYA1LQ3laKakQADarYbyiwAajvduQ337XfHAE7FmmSntBQSLbDqV2wAUoKCbFGbUWKqxACsX2TMte0fVw5dP3cGtsDDQI
X-Gm-Message-State: AOJu0YwZFK187Rols2zRM830ZsSKKenkoQNaZPAVCTQLC3FidlRu+jVu
	WTDaAiQ+Ck+TYj4QiVLbX8lMFKsAFs2sBwKH0E1GMHwqa5u49iCD
X-Google-Smtp-Source: AGHT+IFH7cNQo5yyXSLFX/FtXEvRoq/CSaZ9tu9v/FjKcFyb3nfAg1DWdkRaqG3taZrC6V8O9WEjbA==
X-Received: by 2002:a92:290e:0:b0:375:8b0e:4442 with SMTP id e9e14a558f8ab-3758b0e4855mr88407975ab.19.1718085976597;
        Mon, 10 Jun 2024 23:06:16 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e9cbecdbf3sm3290882a12.77.2024.06.10.23.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 23:06:16 -0700 (PDT)
Message-ID: <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
Date: Tue, 11 Jun 2024 14:06:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Update the translation of
 dev-tools/testing-overview
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611044358.25689-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240611044358.25689-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/24 12:43 PM, Dongliang Mu wrote:
> Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
> Add link to RV docs")
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> index c91f9b60f9f1..d89d0ec1d4cc 100644
> --- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> @@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每
>    参阅 Documentation/dev-tools/kfence.rst
>  * lockdep是一个锁定正确性检测器。参阅
>    Documentation/locking/lockdep-design.rst
> +* Runtime Verification (RV) 支持检查给定子系统的特定行为。参阅

Why not translate the words 'Runtime Verification' here?

Thanks!
Alex
> +  Documentation/trace/rv/runtime-verification.rst。
>  * 除此以外，在内核中还有一些其它的调试工具，大多数能在
>    lib/Kconfig.debug 中找到。
>  

