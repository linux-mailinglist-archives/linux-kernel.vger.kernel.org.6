Return-Path: <linux-kernel+bounces-218257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D305B90BBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D6B282008
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605D190056;
	Mon, 17 Jun 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ShLEzPPK"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503318F2F5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654986; cv=none; b=tELFDqxBeg8otP9kEDE6szxdNFvzyhkIm3yWOXg/g2eoqKB6zfsawIDizWizX/PGCREuQ/8P5FNgpd92xm53EOJPwoMpnAjtkx8/FmEXEHrSACkFYEA298jBvythwZ7ezsAb0f9CLR3jZ+eP4neUMPmiykc9E5ctWyAaqQ/FGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654986; c=relaxed/simple;
	bh=lMOHT9AzaSNEukALssulLQMHUV6v697K4yD8C4n+Ca0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT5OYP2edBMuzriELgHCbZlmz5Xc5yj0qkoRrHtGgYYLSoQOR0nljnusGcebRYhLRarphUcKQQipFtILN8FwQAXPb4okNxywSAiZhcxIyhCHkDflx0KDqBQOXkqrMO2SBRkonNLAHoQ4O87JzFU6lU2S/j11aXJcZ4lzKrjQ0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ShLEzPPK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so53397161fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718654983; x=1719259783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32irAGR56mVNB9UGYg2c/DMgiXDqjQ+y0dbB2T9WACs=;
        b=ShLEzPPKEtHAou6ivJtsfQR3B07UIIet5ec5PX0atO4aD9/zoFM5rFXN5O0uype2cB
         +bkUEFd8LIQwYHuQm4OUBs43GTLJiCgYHST7/c6NFHgmJG4EiLIl8cY4QApXSg0oBiWY
         4rZFVLXhBS0/SeDx5kZd1MY3WwNsTo+TXd6lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654983; x=1719259783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32irAGR56mVNB9UGYg2c/DMgiXDqjQ+y0dbB2T9WACs=;
        b=ZuTcbh9V1HAtVZBrS7MlPpV9zwIQw3IXtBCKHeZy11UXAIEq3Q7RZ3LanwD+8eGewH
         qKNTR+U2NEknI27xVu/+lomAA0p3X+HtlEs+5ieBty0ereGY757wn5WaZ2tO0a31qNWA
         32safUGrdJQX1IJDH4ozD2d3RobfpgClEdqogkRyopECCuMFI2lHWB5MuqtSeEZmTXve
         fSn8ON0VVBqhrDF6xA/6ytYDoobSPCNJgpkMdt48po+iemmWKjjdNNyUtUaxDksXlRsA
         5de2vsZUj+U9g1CsmFPP1dWgoym3BbCSIioQZtC1rxoo5N6nBJg6Rs8uuw51sUteF40S
         nkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQSM6krMOTgnjUx9AOHUW+ZhHMNHKQelUCU8xPETLY8wBDTs5pGXo7FtBdQVC2w4W/6hOFiReY7fHzxkAdvxSq6R4RmbFq3rVbJ+VN
X-Gm-Message-State: AOJu0Yw3MdynRpGlQH7Zff++bR/RcRXCt0xFqQ/V3fGb0d+8RiFLq/Cg
	6MGuEgV8AEbmUefwAtyf6j1BinSLEGWiXmtmigLFPH6kIbAl/V3IgRl0FixEgW8JcY+Gw0QjxJO
	+y8y6RQ==
X-Google-Smtp-Source: AGHT+IE+HFbOSvuGaQfOP8V+NZ4ooFb09kEdRyfsYFlvSn712Gx4XI4LMJ4J/avxgXw4GM9MUpxyhw==
X-Received: by 2002:a2e:2410:0:b0:2ec:1779:fd5d with SMTP id 38308e7fff4ca-2ec1779fe9fmr78808641fa.19.1718654982623;
        Mon, 17 Jun 2024 13:09:42 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f71b94dc2sm339598966b.101.2024.06.17.13.09.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:09:41 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f1f33486eso293718466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv3wtKS6VBPloMyOeHYbUBF3e2DDt3P6ybqKeYXNiRvktfko1EdDpUxa6jC3bOfgzMV79AY1HyifnWZ5x5cmis4IKkC5Lsmlw04aud
X-Received: by 2002:a50:9e85:0:b0:57c:6031:8ebf with SMTP id
 4fb4d7f45d1cf-57cbd6c74c8mr7654997a12.31.1718654981431; Mon, 17 Jun 2024
 13:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617114712.45d4743f8bacb832dea4b5a9@linux-foundation.org>
In-Reply-To: <20240617114712.45d4743f8bacb832dea4b5a9@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Jun 2024 13:09:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiUzOHfHaWgUcByAygaG6w_BKOqbTN6EHrDHaXb_i+xA@mail.gmail.com>
Message-ID: <CAHk-=wjiUzOHfHaWgUcByAygaG6w_BKOqbTN6EHrDHaXb_i+xA@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.10-rc5
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Rafael Aquini <aquini@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 11:47, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Rafael Aquini (1):
>       mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default

No.

And HELL NO!

We're not adding *another* new random incomprehensible config option
that tries to fix a random case that no normal user will understand.

Our kernel config is too damn complex as-is. We're not making it worse
like this. Anybody who cares about this kind of crazy esoteric detail
can damn well just set their Kconfig manually, instead of forcing this
kind of insane questions on other people.

This Kconfig insanity needs to stop. Why do I need to be the person who says

  "STOP ASKING POOR USERS IDIOTIC QUESTIONS THAT THEY CAN'T SANELY ANSWER"

I've pulled, but I'm reverting this commit. We are *not* going down
this path of insanity.

I'd also like to note that the reported 32-bit issue was ALREADY FIXED
months ago by commit 4ef9ad19e176 ("mm: huge_memory: don't force huge
page alignment on 32 bit")

It's possible that we should extend that - much saner - fix to also
look at the number of bits for randomization even outside of 32-bit
processes, and judge things on the number of bits we're expected to
randomize mappings on.

So it's very possible that the

        if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
                return 0;

test in __thp_get_unmapped_area() should be extended to take requested
address randomization into account.

But there is NO WAY this is fixed with another completely
incomprehensible Kconfig option.

So I'm really unhappy about this. The whole "add idiotic random
Kconfig options" needs to stop.

Those options are not something a normal person can understand, and as
shown by the fact that this patch was already bogus and superseded by
a much better patch from months ago, clearly said Kconfig options
WEREN'T EVEN UNDERSTOOD BY VM MAINTAINERS!

Christ. Sorry for the shouting, but dammit, people need to really
internalize the whole "we don't add crazy Kconfig options".

                    Linus

