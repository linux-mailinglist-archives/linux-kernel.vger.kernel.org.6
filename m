Return-Path: <linux-kernel+bounces-257796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D5937F03
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89B71C212C8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E35D52A;
	Sat, 20 Jul 2024 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1EFcswW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95500B64A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721452756; cv=none; b=KisQXIYdvF9Y/9mYNxjqLHJbcwU+1xuGlB4cX7tFn8Tk6R5Xa6PkiT4Iu1cmkZcjV+MTXkDZBmnMXF5PPspcJDKVKx7P2F/mEgORQ12EuWBKJRox/a4XMe0U8PCdOTFDktwxodV2Slew0lC9rCm8OhFUhePvCUdnrqcO4iqssfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721452756; c=relaxed/simple;
	bh=xFER1jozDQSLZGm/yKa6R0PGj8cG316/fvTzPJ1qcEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3SDVoJ68qFqG+0237gXuYDhMXxhws42tss69mmY7NsWux2x3sXn/mc/iF1ZA9nTPa85Y8K0GdcG/epDWZ+GR0XpdmdlkDsIY1Gz4JCl07Y2DGpXKZ+DCo/X2plSUg66ABQAAfuibU5UGV/KgVieI3LhR52bWpBvzn7THvxlA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1EFcswW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso1674010a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721452754; x=1722057554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAqlDIeAXRO1DBTVpb7ic/6UZGkH7oIIoVxSBFI42TI=;
        b=J1EFcswWRwi6RX7oAqzLOuW0lzMNE5JGVg904+EV+c+B6u+HxKsWastPqSkzaADizk
         1gNwk5WV0XPeUKjVV4OOY9ff2kytTL+ghTBXDb+TiofEtqDWH+f7XIHs8YIMdiKxu490
         ylRvvviZYk2sl8+8aB8feg8EePqJVNgYZ9Qxnhvi4OP3635NOgii6T8jNAxmlL7F3mto
         vgo4Mqxm6Q/LsIUCyxuDwkgYIpPU3a4X4o3bsR6hdMvlYgp7/bXJCyY7CUDSoR/ezo50
         k66GF4NnIqsPpJyo6fbnX5ouOYNLv05bCNUL+I3s23+YI3zZMWWCZRndC47SNk6bFRKc
         icbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721452754; x=1722057554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAqlDIeAXRO1DBTVpb7ic/6UZGkH7oIIoVxSBFI42TI=;
        b=oc3wdPfVQsqq74DmA7WN9xxLsKeCUxhDDvjOQiCEVGHUUs4QLxZqK17/q/+IMuju/7
         /GlIJFANqnmm7oAnPd7rEjXm+cjMDT8Dea6g8/cOxcMdHsOw4zLTHoMIvtqu9hGAUf0Z
         yTV+c137dECXvhnWEcg5oZSv+C88sbR9yn50ffXRTNfghEWv+96CounpNSTDQyRuooME
         Hb2pNUj6eHsJ0hGdM6PhgHdeEyVe7md9wiMiw1+BxvsSkOQD4uJpwhZXAyyuleM3luKi
         PeMSGw58ZgXSFb+tfhGgFIPenDQoBeYc2s8OhWwXGrW6IAiuazPl8soJ1vDnZi4UwPDd
         Ht7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcearCHEYWvb9Rgl2G7538knr53+rDryAU4pwB19t+ERrLKwAh7c5JcFVY5VG94vQm0wPfyQwk/NsA6nXjGPn14zqkOPrlC/sZl5bD
X-Gm-Message-State: AOJu0YwAskIJiL3YKRU75z2E9va5TptMnYcMKvoAEDnPiD1lq2sGm56u
	5O8dz9yx3Pp85d6GZays7mZKxcyoJe2MDLmCmPFEHOnFkyiz/JRQ
X-Google-Smtp-Source: AGHT+IHRJ62D0AptfuP97fRJQS436WZ8onKwfDqm1vbVFDNJT6EXmzULExUMAm1nN/hVDRAgkmPaqw==
X-Received: by 2002:a05:6a21:8ccc:b0:1c2:9208:3421 with SMTP id adf61e73a8af0-1c4228cecc2mr2539274637.28.1721452753702;
        Fri, 19 Jul 2024 22:19:13 -0700 (PDT)
Received: from [10.3.80.76] ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b5c385sm2688785a91.18.2024.07.19.22.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 22:19:12 -0700 (PDT)
Message-ID: <758b3f44-5c8f-46b5-8f02-103601eae278@gmail.com>
Date: Sat, 20 Jul 2024 10:49:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi
 functions
To: Doug Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
 <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
 <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com>
 <CAA8EJpoRd3ooMnH8Z38yNH0M-L_CUd+H4WoYydd2AEmpXGeU8Q@mail.gmail.com>
 <CAD=FV=XDpEfTjTQbO-fZKKwgHCMUmCrb+FBr=3DMzVfs3on9XQ@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=XDpEfTjTQbO-fZKKwgHCMUmCrb+FBr=3DMzVfs3on9XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/19/24 10:29 PM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 17, 2024 at 3:07 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>>>> However it might be better to go other way arround.
>>>> Do we want for all the drivers to migrate to _multi()-kind of API? If
>>>> so, what about renaming the multi and non-multi functions accordingly
>>>> and making the old API a wrapper around the multi() function?
>>>>
>>>
>>> I think this would be good. For the wrapper to make a multi() function
>>> non-multi, what do you think about a macro that would just pass a
>>> default dsi_ctx to the multi() func and return on error? In this case
>>> it would also be good to let the code fill inline instead of generating
>>> a whole new function imo.
>>>
>>> So in this scenario all the mipi dsi functions would be multi functions,
>>> and a function could be called non-multi like MACRO_NAME(func) at the
>>> call site.
>>
>> Sounds good to me. I'd suggest to wait for a day or two for further
>> feedback / comments from other developers.
> 
> I don't totally hate the idea of going full-multi and just having
> macros to wrap anyone who hasn't converted, but I'd be curious how
> much driver bloat this will cause for drivers that aren't converted.
> Would the compiler do a good job optimizing here? Maybe we don't care
> if we just want everyone to switch over? If nothing else, it might
> make sense to at least keep both versions for the very generic
> functions (mipi_dsi_generic_write_multi and
> mipi_dsi_dcs_write_buffer_multi)
> 
> ...oh, but wait. We probably have the non-multi versions wrap the
> _multi ones. One of the things about the _multi functions is that they
> are also "chatty" and print errors. They're designed for the use case
> of a pile of init code where any error is fatal and needs to be
> printed. I suspect that somewhere along the way someone will want to
> be able to call these functions and not have them print errors...
> 

I think what would be interesting is if we had "chatty" member as a
part of mipi_dsi_multi_context as a check for if dev_err should run.
That way, we could make any function not chatty. If we did this, is
there any reason for a driver to not switch over to using the multi
functions? 

> Maybe going with Dmitry's suggested syntax is the best option here?
> Depending on how others feel, we could potentially even get rid of the
> special error message and just stringify the function name for the
> error message?
> 
The problem with any macro solution that defines new multi functions is 
that it creates a lot of bloat. Defining the function through macros
might be smaller than defining them manually, but there are still twice
as many function declarations as there would be if we went all multi. 
The generated code is still just as big as if we manually defined
everything. I think a macro that defines functions should be more of a 
last resort if we don't have any other options.

> -Doug

-- 
Tejas Vipin

