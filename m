Return-Path: <linux-kernel+bounces-513303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF69A348D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599063A385F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DE15697B;
	Thu, 13 Feb 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZPj+SSAU"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356A26B08B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462170; cv=none; b=maK6SQvNbbwH7uBeW32eWYaVjC/654WihbpzlJYTkRx1ldDoDadetCzsGedILV+dA7+keSejuu21OXTwZswISIQ4byQ2pDfsaA4DrLIAz93D9v+3s41yrE3e8Dw471R3WSCjutadEOgrt1qHkPlK8yKVXMgBYGPEsmpnicv+94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462170; c=relaxed/simple;
	bh=7i6V9OUku3e/q/hSkEcFP0qGhYQ8Xso/nVD/tvXD9sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKB8mdmDsTyjLRDus3I0w9BCETnwDQ1Kam6Bsx5a61DsniFaGUES7uq4/Rg/GX1xBrO1fDmnBdNaD0tJ8Ta0DCH6nhkWlBxDpHvXNBoa/4WcFH3BMUlwW4LAcJlqFcJcWdTVR+rXOohpZqXYkxNenvbOGhARyGD8FWD91KTMS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZPj+SSAU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30615661f98so11648391fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462167; x=1740066967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLAli4Gnmcw4fIPwE54pea1emeVcN0oq6/R3bNPrLic=;
        b=ZPj+SSAU8vW5HyIN9EiQkMt8k+I56bhCy0UL30YyzjIoLYVr145hFIH7lWa0jMynEK
         s3rzXBC0PkeaEmDBZlNQp0CoMHSmD+XvHPH652et2vBPTY3CTqR9f1FYJVXwfMSOkSmu
         7f9MgLXT95teNbSKeghMIz77WdjuTfYnYSKKIu885tur5/ILjvtIVDQgdWpYmvmBOKeh
         Y5msnJCoFqgFA/2TM8vPd/gdgP9IODPaduvL79vaJhxzkUnW9iJAQTJwWjsk1E6Bl+zw
         ogjJ8P8evyFYYdLYlpJiVfMQCbQMHorloSPlImgKyX/557uneDZA7g3xolzLLxmHmRwf
         Zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462167; x=1740066967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLAli4Gnmcw4fIPwE54pea1emeVcN0oq6/R3bNPrLic=;
        b=xD/WCsBhqQN+oE2mqH61xtVM17oAHLs7LGJDihkkwDsZjLHLoVKva4LnO2YkrDcE6s
         cDJpl/1prdfbYDbrGa/8U/J6mTBmzbGx5BMOn3m1wblgkm23SZB+308IZlPhe48durZX
         0YaAATESXJyu6JksOQ0yF/8+ZgAHbKatPx1ZuQeWN6tb2cml1Eor4cBZ9SOwWwRdO1OF
         E5nW1PiwKd1FJ9Ggksi1LtIpicTso0aj2i3Js9q41wIq8Vq0ZrfaNu6NPLKyNsUPx5LD
         sdyoacVhOrlWeK3KAm6ArnCJYfw2DT2vHpidXIC+qeMlTCoQWdK0UJajmPtlP8xAWkax
         25ZA==
X-Gm-Message-State: AOJu0Yw7f0ZQqzLRHT8PJGq3KKgRU6i/8YJ2CUYsGJw+DVuWygp6xCXF
	zjovtht4no7IKNVcgVWO8euqDseQZeA4Mae5+V2EWr86EmeQXxHf1aYe3jwjPJmYx1QrGfhItQU
	b
X-Gm-Gg: ASbGncvkfkiUaMa+Tqa8Bj6Gj2koPl+E5iC7XB3VsZBYgHQj4jqqXhRgWsIJ9rHB68Q
	cvQzxgcSk1K5gZdea+1Y14PRqU4CZuRaFxFCmm4ueGgGwbSwCI5NVTIS9bfQApDetVBL+xDeJLt
	HQnBrxXPxWB3h4jsp13idcgHiTWA6zXMg80nlIUpwz8/tzn4HMe1DcWEZtu4JzxBXZkvXwJb8SS
	ij/LDwCwYmdIf+Pd3815SxKEc4gQBQdCRxh1Pbx+qJUHivRmph6cQDpKL48sGDkodVcGKcDpnhx
	RYeRjZ6jAmWsSRtIpJU=
X-Google-Smtp-Source: AGHT+IEoXf8IM0BCiy1988JuJo2B9cXIjndci1o/MsuJC/BDML4b4xU7aji+rhA42cW+Qk30XmAwPw==
X-Received: by 2002:a17:907:3fa6:b0:ab9:137d:f6e7 with SMTP id a640c23a62f3a-aba4eb88dd8mr355840866b.7.1739462156201;
        Thu, 13 Feb 2025 07:55:56 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d7bfsm155245866b.141.2025.02.13.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:55:55 -0800 (PST)
Message-ID: <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com>
Date: Thu, 13 Feb 2025 16:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> In the unlikely event of the allocation failing, it is better to let
> the machine boot with a not fully populated sysfs than to kill it with
> this BUG_ON(). All callers are already prepared for
> lookup_or_create_module_kobject() returning NULL.
> 
> This is also preparation for calling this function from non __init
> code, where using BUG_ON for allocation failure handling is not
> acceptable.

I think some error reporting should be cleaned up here.

The current situation is that locate_module_kobject() can fail in
several cases and all these situations are loudly reported by the
function, either by BUG_ON() or pr_crit(). Consistently with that, both
its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
don't do any reporting if locate_module_kobject() fails; they simply
return.

The series seems to introduce two somewhat suboptimal cases.

With this patch, when either version_sysfs_builtin() or
kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
fails because of a potential kzalloc() error, the problem is silently
ignored.

Similarly, in the patch #4, when module_add_driver() calls
lookup_or_create_module_kobject() and the function fails, the problem
may or may not be reported, depending on the error.

I'd suggest something as follows:
* Drop the pr_crit() reporting in lookup_or_create_module_kobject().
* Have version_sysfs_builtin() and kernel_add_sysfs_param() log an error
  when lookup_or_create_module_kobject() fails. Using BUG_ON() might be
  appropriate, as that is already what is used in
  kernel_add_sysfs_param()?
* Update module_add_driver() to propagate any error from
  lookup_or_create_module_kobject() up the stack.

-- 
Thanks,
Petr

