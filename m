Return-Path: <linux-kernel+bounces-266577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4C9401D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860BBB21A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377818F2DC;
	Mon, 29 Jul 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CNICOkRf"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8571E49E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722297484; cv=none; b=ETgakrzfwaYg3ilNnYlvxXCAHXr+le/FvFvaAZeEfLy4MMizwxk/eIS6fcfQ8ORuUW4+dqN3ZQg9wPkOUWlnhB5ob23ymhxzRow17PimFWzFnbqFwC0ZffyFetIweqzNgC83idYKJHY8aL5HSWSJJ720He8vBs8xPbWPmfGPxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722297484; c=relaxed/simple;
	bh=HsTkYaQvLHEv35+aLag0xljxwQgmY5E7o11ogohLXTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpYWtf7NwmJ+eyzs57HiKxT1kJ4dW0BXAET5SC2xmqbBWLms695ss5Xmlr4UczcE9iF7fZ9xfwDXqe9yAERvPFOowRaS0eEvkb+CJmwOE4tkVKMDnSunFFWSY8WqupovZfaFSpj5tFlWeGNgujPCpet6F4r8smy6nxWdqOj4JCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CNICOkRf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso6400062e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722297480; x=1722902280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M5OeD/TjdLdg6TWmjDcFFR5g1FHvQF1TaQWWZJWDtZI=;
        b=CNICOkRfwdZZsg8ZAdDwtqHxqAceZy1gATtyrc4LehVVaubq+tmn6pJckU6yk4r/t6
         MnA9DFERdzQhLsmNqJZ9J/YS8nsjbtZe2JvzynnqeWzopWVkTcopOnjhXEqkc+v3pACD
         jjDAvP1ByqJLajfFlBW9nRwntJLQZ0SiaAaCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722297480; x=1722902280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5OeD/TjdLdg6TWmjDcFFR5g1FHvQF1TaQWWZJWDtZI=;
        b=SBOR1w6f/72oN9UBuCc6lp7V7bt4OxDf+M0iEHsXmXfq4fqtNl9TQraThg+i/muUIH
         lnKPg9p3a5jO/THrJOUZh7Xl9Ceq4vsf9XJs7B7LDib3EsQiFPSZctY50Ya5BmkwZBMk
         EWPzNbGfrcfeZc2HzAA587mZPhpgLTpS1ScWIqxQMppDaMitQ6Qp/q+FuSp5VKrFDjcU
         9dsPq6kIPFS6ICWuo+SMiFRh31OG3bYTYERBZfzbzp4J05V8r3/9BirwjL1r3ESUI/Hx
         65yKz/dKeH5U6eX1J/V8O+qyEg01E9QwnzSFn51HyyCWgqW6Cd6jyC3HOq1Qekr8V6az
         ngWQ==
X-Gm-Message-State: AOJu0YztEggGIWrR+hCYbXPF+Xv9deqkubHabif6Z8C2hdDZC0iY5n0n
	XcCjb3O8mljDhS/DIrQMDKpSNASEeoe8yrV3Uh+omP2TDv8PrtDVo3efEKmiPTV9mAYDmFqb8zO
	LoMZXqw==
X-Google-Smtp-Source: AGHT+IG0QQIP3O64n82OYezkIWKf71kmdYgiS1mqjhAAjoIut4FGC0wYWkbs9drXl0OWW4y0nfbJQA==
X-Received: by 2002:a05:6512:36cd:b0:52e:9a91:bba3 with SMTP id 2adb3069b0e04-5309b2707bbmr5304249e87.15.1722297480267;
        Mon, 29 Jul 2024 16:58:00 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc42d6sm1677172e87.45.2024.07.29.16.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 16:57:59 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so62587591fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:57:59 -0700 (PDT)
X-Received: by 2002:a2e:9ac5:0:b0:2ef:23ec:9356 with SMTP id
 38308e7fff4ca-2f12edef762mr60373271fa.8.1722297479131; Mon, 29 Jul 2024
 16:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730082204.57c64765@canb.auug.org.au> <CAHk-=wgEipN1BoDCG02m1XqvACCFLxj2SoEG8O4BZMAFXKifqg@mail.gmail.com>
In-Reply-To: <CAHk-=wgEipN1BoDCG02m1XqvACCFLxj2SoEG8O4BZMAFXKifqg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 16:57:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3+tK5ndB0P3Yi2HOYFm6YMc-k-wBJjTEo__opsp51jg@mail.gmail.com>
Message-ID: <CAHk-=wi3+tK5ndB0P3Yi2HOYFm6YMc-k-wBJjTEo__opsp51jg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the origin tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 16:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does anybody have a clue-bat: what makes only the powerpc build show
> this valid warning?

The obvious fix to just remove the stale static variables has been pushed out.

And it turns out I see the failure too, if I use clang.

Interestingly, clang did *not* complain about the

  static DEFINE_MUTEX(profile_flip_mutex);

only about the static DEFINE_PER_CPU() cases.

So it looks like having an initializer ends up suppressing the
message, probably due to various historical usage patterns (eg things
like

   static char *rcsid="$Id...";

which is a common traditional pattern).

I have the same gcc version on both arm64 and x86-64, so I guess it
could also be some gcc version dependency that caused me to not see
it.

           Linus

