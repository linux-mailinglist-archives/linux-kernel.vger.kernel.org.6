Return-Path: <linux-kernel+bounces-173831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546648C0619
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB35284C49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5721373;
	Wed,  8 May 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXF2fxN4"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2413175B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202809; cv=none; b=XTizNxIsNXk7xyHGtXyDVYv4e+Yw5Vf+TnSTwGZgBIU5LE7KzhsxXa4Gr9t/ZAqop+1saQZRhwoFXcWMj7KbgmF3W8kb7jV3vX6AbQRwKjZbr2WsRgPG8hqnggGaErdB3oXDMaMgOpxSf9NoqtXHJe+UTACb8ri/PMSdtshGrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202809; c=relaxed/simple;
	bh=XYj2SfU/qI2Oqly9uh18pSWAcgoIOhgV2D/F8k1QRS0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6vNZAY+jucSpkwu3mxW7My9GrX4smV7aWmfKVCngst9mk1jpTvFN49TbZZnMZKU/k1/ztHt52y/gSI1bE4stZxFmxZRkfKqmaCOBNgWIhGQ29ZVnC0JMUlWWly6Tw6jwsaZORwbmB/eGfwGXYXjs3XU+DAorSEBmGoS3YgTXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TXF2fxN4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9741777f0so113417b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715202807; x=1715807607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M98zkpUg3yxVayso31qmdD5gmDCW7hzlsYnZ3G3ptME=;
        b=TXF2fxN4p8RNZqgfbpbrpLjq5xW7oJNoqkfd3VuNY8EQiBgaXVsgjS6o4+Pd5kvzC9
         wPkrlQvRrGO0Lmn1mgbCE0mY5UoVOugIdH7k6qDbPuf2d53XsGXfsZ3hIzw/eOCTXyZF
         mQhGTJwm+5oe/V6+X0crl7Fc5IX+wlS2hDw60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202807; x=1715807607;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M98zkpUg3yxVayso31qmdD5gmDCW7hzlsYnZ3G3ptME=;
        b=hYMKDvz7U9lx8sCIBMWd8w77WcWDXNQYuRnJv++6BlrR1iNTywwKwi84s7pMaxOt/P
         LOd/0k/n4FKPOk1xMLKsc4rQ/N8gcR2TPV0bHYfO2ZT3kaaG708x7O7mJCyVQhfh64K6
         W65DJJTv7dP0PGK7ArwKyuVk+bjzOkay6bxL8uYUzoIYHa5+++gevEWnnd0+S4Bc8xUN
         WGknnHTyOO7VAyeMhNWc4Tc39lvDGcDc6GuBlwuaQdhLqtREPejaLfKcc4G1b/874ebx
         Qy6KnqS9i/0MRyR8ApJc9fnxUZ/gAG3NlSYH2LC/ezLFrNphCr+JGxcFKjyYDHMIZmFU
         Wy3g==
X-Forwarded-Encrypted: i=1; AJvYcCVCLwz6VEWuo8sklo4D09TLldgJTQFCHh9vVj9mu8WFbadDKOujSuBkPu6aCG19IxECptwO9iXgLRsYcP+kAdFLSK2K5YRANIXK5gNk
X-Gm-Message-State: AOJu0Yw4FykQ+hUi4o8UvdL6cKK3xL/M1dc2JC9rsmYdODc/lH5S+l5M
	lI/A78yTUzflPZz6aiAMJkAEZwDodnO2q+Qvrq20fA3G/I1qt6ainunPJ3oLFPpg+3unoOcz0sO
	18/lwA08Ky1mB6EbRGjnMD6/YEDpjTJ6s1UT1
X-Google-Smtp-Source: AGHT+IFTemfTMKR0QxJ6EVhmJjQlbP9xLe7ilDDVa9JCZeC8nukoUyyV89qhOs3YHhAZd4nqAQXTtvTb6s8kR3KAeoo=
X-Received: by 2002:a05:6808:1705:b0:3c9:7027:8e8c with SMTP id
 5614622812f47-3c985306fcemr4906245b6e.39.1715202807033; Wed, 08 May 2024
 14:13:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 14:13:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240503171847.68267-2-puranjay@kernel.org>
References: <20240503171847.68267-1-puranjay@kernel.org> <20240503171847.68267-2-puranjay@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 14:13:26 -0700
Message-ID: <CAE-0n5248NiYQ9KvLqwaLuSSGXMM4RMtnB2uayZQbdJXQWTAvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: implement raw_smp_processor_id() using thread_info
To: Catalin Marinas <catalin.marinas@arm.com>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Quoting Puranjay Mohan (2024-05-03 10:18:47)
> Remove the percpu variable cpu_number as it is used only in
> set_smp_ipi_range() as a dummy variable to be passed to ipi_handler().
> Use irq_stat in place of cpu_number here like arm32.
>
> [1] https://github.com/puranjaymohan/linux/commit/77d3fdd

Maybe you should have put this under the cut for the patch so its on
the mailing list, and lore.

>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..98d4e352c3d0 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1021,12 +1016,12 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>
>                 if (ipi_should_be_nmi(i)) {
>                         err = request_percpu_nmi(ipi_base + i, ipi_handler,
> -                                                "IPI", &cpu_number);
> +                                                "IPI", &irq_stat);

I know this is mirroring arm, but it would be nice to have a comment
saying that we need some percpu variable here even if the handler
doesn't use it.

