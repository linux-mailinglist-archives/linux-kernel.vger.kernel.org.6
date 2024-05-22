Return-Path: <linux-kernel+bounces-186570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC38CC5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD14282AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B21419BA;
	Wed, 22 May 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4hK+6w4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A246BF;
	Wed, 22 May 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400035; cv=none; b=ptbbq+KKGy6q9A9SKxyKLtVPqogF0zc/++9xn61wSs7jZsFRTVgSqcsbiXzclq49bSmFX+Y8fCGqKYn5OC71yXndwn8fZygYPUYjIxZboB0yDV+ZjHtC0kmi6jWpwBf9mo1HdWE6hoNYX+rTX+YScfPISn2zoK2KndQKcDHihDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400035; c=relaxed/simple;
	bh=e2uupAoRLg2fAJFgsHpKuTlk7Qy9DSy+sWf93z+oN68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2yRATlam+HVAzDNcNgpsdo9u3wcG2X+eKX5FujBDoSN1GFSpI2c61A+9uALK2BEFx7EFhAHMyyevlhUBW5zPAbdtgv2DMNq6Pgy0OCV0AagIpmr2izxcOwRv3/5VkhJ5IpuMHzg6sKqfAmjvxs4ptcsgQxhrElIntNhGrPuQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4hK+6w4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57843234ca4so86038a12.1;
        Wed, 22 May 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716400032; x=1717004832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z57vqKJPNQlsmuarRloLPzLzPovqGgbS+nQz+VX+Fhg=;
        b=V4hK+6w4OxIrHky5DSPNDi4uam+QsIoh+Z8BYtcwvwwh5O2ePEl+fCkWD4lbk4RqSC
         xzFBe6GcWKvJehVd/fr6W0lDhLXx3TELlJpOuADyfhusQLf1vexqI5qSBkz5sycQmK8j
         ATXaHh7/j4zvcV1t8E2H0BLx0eIqgS0J+parNOYBhihNSqRTAD4vqeDmV7n6vDvnT/u1
         YwKcIEtk1UKVYn4DvmBAn3nEp0Z5cOfg0E39LT8kzNVbFAM7zET4bkBZvBJ6ii4Umj1/
         V+4JgE1Gd79O3WoZ6acdtJ+H65AZPPI+vaqGR/DVWvev55hljd2JOTO6PSumaQC8NcQ+
         EEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400032; x=1717004832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z57vqKJPNQlsmuarRloLPzLzPovqGgbS+nQz+VX+Fhg=;
        b=TKLvnSlHEmoiF8JjGQc+nQPw0imjG4AF353UnYpvGSLjz9xKsIB3oIxKFKHeeR1/v8
         jbUJjo2sUkrXe8Tp7wOhB6eEnJtVwbK9FmXMO2cQvOaNlSLnxPX9RN89lP+Z7tPGbO3H
         viMneLvWvxp3hCLFfpGhyZAeZeUwmrW0pVsPCfVIa+9okur/OB1y3OQjTWETOv9hteum
         4Gx1/2GGl4RkGFqHD4Z0TDuoAQpXtUayqEjueFJvucDR6xipD8a4xisM2oXoEFcqyWLA
         90DVxXPawGzp+KtGMkBQpK5mYH4oLVCkNDFDRyBAcH6avdH8kgFcHOR78EfNEP0a3UmV
         j+pA==
X-Forwarded-Encrypted: i=1; AJvYcCWXF7SEHbwpZg7GEQfXODEQTw6F54Z+1NCHbqLgFm8VAy0nmo8MzTYpTRNDeGQDtIhZ3rgft9k64L13pZMlcd1XV8vpQg4OSgHQTFR6YcQYJFXBC0Dt1Ai9AtQOl7193eeTvGrRTfe1lw==
X-Gm-Message-State: AOJu0Yyg1rUeNVLVkgk3VATM4Y/G9r9s0lwli5ibB2aYBdAuPmMpbwbT
	CCpdPWxaccOuw0l+Cygiyg/7qIlS5Ju5iUDLOLcKCi4c5YGoqv89UabBu39w
X-Google-Smtp-Source: AGHT+IFWvQA/J6ZWqwBWJbkdcEd1WmbUfoih0F74jntXO5c7YsNiBuxlVmBayc0gxMMLYb+TRo61uw==
X-Received: by 2002:a50:d61c:0:b0:575:2a03:8ff6 with SMTP id 4fb4d7f45d1cf-5752b4c9117mr11267851a12.16.1716400031687;
        Wed, 22 May 2024 10:47:11 -0700 (PDT)
Received: from [192.168.0.31] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5782fea2c87sm1724685a12.17.2024.05.22.10.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:47:11 -0700 (PDT)
Message-ID: <292d220d-2177-4516-a391-4695bffc2ab5@gmail.com>
Date: Wed, 22 May 2024 19:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Julia Lawall <julia.lawall@inria.fr>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 19:05, Krzysztof Kozlowski wrote:
> On 22/05/2024 18:42, Krzysztof Kozlowski wrote:
>>> Yes, the binding document was neglected pretty badly but when converting
>>> to yaml it has to be correct since that will have ripple effect on
>>> existing dts/dtsi files.
>>
>> Yep. And testing DTS should clearly show that conversion leads to
>> incomplete binding.
>>
>>>
>>>> I assume the DTS was validated with the binding. Isn't the case here?
>>
>> Mithil Bavishi,
>> Are you sure you tested the DTS?
> 
> Dear Daniel, Shuah, Julia, Javier and other mentorship managers,
> 
> I see some contributions regarding Devicetree bindings which look like
> efforts of some mentorship programs. It's great, I really like it. Only
> sadness is that no one ever asked us, Devicetree maintainers, about some
> sort of guidelines. This leads to sub-optimal allocation of tasks and
> quite a strain on reviewers side: for example we receive contributions
> which were never tested (tested as in make target - make
> dt_binding_check). Or people converted bindings which really do not
> matter thus their work soon will become obsolete.
> 
> If there are still such active programs, please be sure that mentees
> follow these guidelines:
> 
> https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY
> 
> 1. Please convert bindings which have active DTS users. First choose
> bindings with DTS built by arm64 defconfig, then next choice by arm
> multi_v7 defconfig. Then any other ARM or different architecture DTS.
> 
> 2. Be sure dt_bindings_check (including yamllint) and checkpatch pass
> without any warnings. See writing-schema.rst document.
> 
> 3. Be sure DTS using these bindings passes dtbs_check validation. If
> this means binding needs to be adapted during conversion, mention
> briefly in the commit message changes done comparing to pure TXT->DT
> schema conversion.
> 
> Best regards,
> Krzysztof
> 


Hello Krzysztof,

Several mentees from the Linux Kernel Mentorship Program have been
converting bindings within the last weeks, but it was not a programmed
task from the mentorship as such. They are free to choose the areas
where they want to contribute, and some of them chose that one.
Therefore no direct contact with the subsystem maintainers was
established. We will keep an eye on that too, so we can anticipate such
misunderstandings and additional work for the maintainers.

Nonetheless, I saw that some our mentees sent such faulty/pointless
conversions a few days ago, and they received some guidelines and links
to the official documentation yesterday. All points you mentioned were
covered, so the next patches should look better.

Usually their patches are sent to the mentors first for a preliminary
review, but sometimes that step gets "bypassed". We will insist on the
preliminary review, at least for the first conversions.

Apologies for any faulty patch they might still send directly/not taking
those points into account.

Thank you so much for your patience and feedback.

Best regards,
Javier Carrasco


