Return-Path: <linux-kernel+bounces-179657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C18C62E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E2D1F20F77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DF4E1A8;
	Wed, 15 May 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="EeMIzhhW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93946430
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761800; cv=none; b=TRHnBQQrYYVtqVdDicQiPuyJNhVA3bOGtloZvqepSf5jHtjIM3BU6pvXIyJI7AmJo8bh91Q9/GaTjip7ZRVmcSLXHigeoccHLBZYXVvEMctYxqfoldXzqlqiTyqtj1ftwOQN/atqGMcQF7acye/jpW0Ok2i4rAMEYDY+audHqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761800; c=relaxed/simple;
	bh=3sJKvBCoJaKkb2UJWlCMu8vxaDXyGjihMzp2hGE2ezY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hytujHKWmunkC7nFTOcj/3C3HYKjk627R+L4QGOmzND5F0z16urupRj34SrDSLvag8cggobmo0XvOxYfiMZ/BUbHzLeaXACEsflhrjvC8jXSEi5/SC2eokez1w8qOryAiyof697yuLZKsxmtapqWZgOXxI1q8XPuc/svLNwej1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=EeMIzhhW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e271acb015so85514711fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715761797; x=1716366597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdZ6+CYbkRe4GWY6A69afts7kPSMUQxevIZoOvytkAk=;
        b=EeMIzhhWQIPsSm5KFm17MA3Vj4U/+Hs/Wgd+g8qm2ZYT0wVYrw4CABaTCj3x/7FF/f
         HRrMzpo5F70GxHwtL0YjUsuVQocmqykCvc5mXGX3oQ5YhTq+g02S3CZlKHxWk7+VUDnu
         5cZQm+5JIpFLCbKoB5SPYU2Z5+BmtrB4XnTUsR45Wle9MX64eqYZzYTQV8gu2297cnRY
         2uxF1v6eQWQawOqAakG+3zLlk6cCduv+zC5ta0LCBkmE5kd5zg4csWOMPXoJydPVjWWs
         X2Hr0gPB4GsAI1HrtAaFl9Opvg7948F3Sb+TokvD8RlqKaKwA6Dr5glPG8Cdv4U43OF8
         yNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715761797; x=1716366597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdZ6+CYbkRe4GWY6A69afts7kPSMUQxevIZoOvytkAk=;
        b=AhEdZBr0YPVM8FEEky1/WXY+J9nOHKSO5k2QQ89VOTwkIKsDsotqfsTOn93ohvs5wT
         f2U9tuIqt6NhFIjaKWqeijnNBv5qLIgZO+0rcWbVFvqgEM6nzJgkalIsZFoHt9x4mdo3
         Lf+wvnFd6hUjxTKx7WvqrdQAFVZq7/t38kyViI5P0OgyXxXUeytJAs2RQzJkVMbyyn9Y
         nWHNKgv1IaZ66Arhsc/FkKoeqVKdQTrnNKk3tSqssXKr/OaeaF4BYsIFXvOBtFkeuo0J
         JSwgjFr3b3uUClFFehg1Q8eag8aZoQs6/8OGXE+qXB+c4StfDcZPFaK8gQDvQkjzetYg
         JSig==
X-Forwarded-Encrypted: i=1; AJvYcCUPXv5ByLauC9HcS2x9/840ksIvAl3mY5uiUXWq/EFO2XxRKlq6bzj+SQsGrVFJ455x6bRQwxH9Uydy6V3cDrk0H1AyfOg5dAQ/pfMk
X-Gm-Message-State: AOJu0YzW060nZYdFqtI+hStF+NQcv1HoGv4VSBirdtsok3lXzKOly/on
	CNJQCE+F9RCbM/jzmIIFWyoWxsXcnv3wrhFp+FtvcgJfnJa+zHoA8NCI1ezP6OM=
X-Google-Smtp-Source: AGHT+IGrFyIGNekgvi7YvLggWgiFyAjxsuUBqcC1ibM/CNjEyWzWGDg20jTRgwWYO3bbnH8X0/j41Q==
X-Received: by 2002:a2e:a591:0:b0:2e2:9416:a649 with SMTP id 38308e7fff4ca-2e5205c3760mr106145011fa.53.1715761796962;
        Wed, 15 May 2024 01:29:56 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6a8a64d84sm8110551fa.76.2024.05.15.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 01:29:56 -0700 (PDT)
Message-ID: <847f2e4f-ace1-415d-b129-ed2751429eec@cryptogams.org>
Date: Wed, 15 May 2024 10:29:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto: X25519 core functions for ppc64le
To: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-3-dtsen@linux.ibm.com>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <20240514173835.4814-3-dtsen@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> +static void cswap(fe51 p, fe51 q, unsigned int bit)
> +{
> +	u64 t, i;
> +	u64 c = 0 - (u64) bit;
> +
> +	for (i = 0; i < 5; ++i) {
> +		t = c & (p[i] ^ q[i]);
> +		p[i] ^= t;
> +		q[i] ^= t;
> +	}
> +}

The "c" in cswap stands for "constant-time," and the problem is that 
contemporary compilers have exhibited the ability to produce 
non-constant-time machine code as result of compilation of the above 
kind of technique. The outcome is platform-specific and ironically some 
of PPC code generators were observed to generate "most" 
non-constant-time code. "Most" in sense that execution time variations 
would be most easy to catch. One way to work around the problem, at 
least for the time being, is to add 'asm volatile("" : "+r"(c))' after 
you calculate 'c'. But there is no guarantee that the next compiler 
version won't see through it, hence the permanent solution is to do it 
in assembly. I can put together something...

Cheers.


