Return-Path: <linux-kernel+bounces-268145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027E9420CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2717E1F252E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6318DF74;
	Tue, 30 Jul 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TzfPULE0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0818CC16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368488; cv=none; b=c/9VFlkDAmKAc1mDc28sbcrbpacE5TR+Rzq/5Y0Y7SWJXcotvMO6Q6PklP42wnm8Xa0GQNHDp0fi8RkKJaf7ahJN54snj89vu4i+r5CHi2qCf8HwtNjjOKEvf9qNb13IebAGGrnLbdjLHSWxdz9xBdQwGl8sRFknvseCzI7/W20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368488; c=relaxed/simple;
	bh=vQI97f0Gx4pVAbUxmUD7f1j0lQ9/si749vWGUAW581c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+vimJFDAN4qP76TWNwgGu0a6yoAY14S+L+I9EX207Ty+36AqghvnsHJwDVsvRnmKxmPUUhgTY/sAoChQvN1oKSxNGzeXDKOhFm/jvew8sqRs4cYv0xWne0svgVMiNSxNWvz+VZX2car/w4hJijqTLK8BmSZ9n+yOT4AXg4zfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TzfPULE0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efd8807aaso7732668e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722368484; x=1722973284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPUDfS7x6dCy8pNBInPtWzHQcM4uFAjaQDZzn6zRJGc=;
        b=TzfPULE0u/lzM9KBy1bJeU/2DPhCH2+G1aSFhXPdN8h7QWPbTG9gRE9AanoGMzKdzM
         oPnLI03YH4rfqbV4wxcoUkPGKeit+d++IatJg9DUIa8zavKmlpmIPh86pY1dG8JPHgdZ
         lQOO1Lt4jB467HH7H/6gynCAQLJn9HUDBKLRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368484; x=1722973284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPUDfS7x6dCy8pNBInPtWzHQcM4uFAjaQDZzn6zRJGc=;
        b=wNEfMP130WPw6eci7D3S6vDQd1jIAIoj5+MpfVNy2b33NPOQjV8DR9/JqNh+0dLkVI
         LIrHbhuZ6FfOC+HaPweOrePzMWf87E1XdCNiZTOGCqdXhzC6S3jDqpIRX4Fxo9KF1Trd
         3p6eUrY9rO3dPWOvyhUcBdY01dQvrwCiPWorFKyn25xidSYrMX5qh+E9VQbs64V6nX5n
         +j9J9np0pW/0iqYf8//D656GauVq2ubh+qpJN57rQcLSg0NGfpsoRscN0eL4PSsZbQtO
         jfgi5jBKW74Ao55cOZrIxdXGnlco2FyE8QButvHscjxTxqxghKkvU3oh00E0yztY+Izz
         7Q+A==
X-Forwarded-Encrypted: i=1; AJvYcCXFMcVSVY6A6kyRno5Kgm1ZU9K8lbNT3qMYIpPrD+q6vHUzjSqAUDd0FDiu9UsSodEAPI8mbjosET73ZwAhr7YoGPdJbNFv/avQIRIC
X-Gm-Message-State: AOJu0Yy7zV6ExFqHzRlfDbCCOK/Zd+QJElMj0I30ncLcfhDS4IrylqZP
	JPmBXaTnFUOx1kHwfIcsNvvg3WLt89lvFKILU0tWpXRIWvSe5aE8d8dFUU/YB5NWQstixys3J+P
	EvRCMrg==
X-Google-Smtp-Source: AGHT+IG+StwCJC1FZxdpdc+SEBdaVWQGqOplUAg5ZGKdMhSQ+1o2oiATxsk0A11iD/m/ftZmqjhlMQ==
X-Received: by 2002:ac2:4f0c:0:b0:52f:287:d16f with SMTP id 2adb3069b0e04-5309b259b89mr10393699e87.11.1722368483774;
        Tue, 30 Jul 2024 12:41:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08e27sm1987506e87.176.2024.07.30.12.41.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:41:23 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso5977196e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:41:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWS8RU+Y8n1uEoAW74JjzAzqx7F9mhKNoMud+Ck+1D7gcTGx1kKBx5luvrmqqNhL9zu2i0qWO/rlIbNJcv2A84ZSJuO1cZoq9ehJ7Ys
X-Received: by 2002:a2e:97c7:0:b0:2ef:22ad:77b5 with SMTP id
 38308e7fff4ca-2f12ee192camr74087121fa.29.1722368482566; Tue, 30 Jul 2024
 12:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net> <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730193841.GS33588@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 12:41:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj55OXwh73g8sctjZ6Sy1KXYsigvOqUEePM7y18pf2_uA@mail.gmail.com>
Message-ID: <CAHk-=wj55OXwh73g8sctjZ6Sy1KXYsigvOqUEePM7y18pf2_uA@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Guenter Roeck <linux@roeck-us.net>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 12:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> I missed the KFENCE bit. Happen to have the .config handy, I couldn't
> make much sense of Gunther's website in a hurry.

This is what you want to use:

  http://server.roeck-us.net/qemu/x86-nosmp/

It has that kernel config in there, along with the oops etc.

               Linus

