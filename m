Return-Path: <linux-kernel+bounces-173672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFB8C03C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2812835E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12E12B169;
	Wed,  8 May 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UnofNZ/I"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47212A175
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190786; cv=none; b=ar6BvZu9TMLvjAXt/7de9uXyW7BFwJjYp9Hs2DwoVjIlr1uV/FsLPzYxXngPB6TuH8l5OIJaTTOhXyZx59L3UbfitU8QEjsM66rgiIhaMAwi2p7TEpyKS/2T4xSRX11YwLiLPK9T/snQLR0gIdJCIoXDQeuwbzalE7xM2/zpeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190786; c=relaxed/simple;
	bh=8O4fYZMWhW1IHisxTbuBjvyMlQTTyIfPG8nknj8tOK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyNpGUmmnzHAnmV7cIgMYa9UcaU5S6kxBuKbzysPbaT7MKViw4G/XM1gTJSvkNuVk/Y38WeG+B/mKEK0AANCewMl6KGp6f8TJZqtt1FI9SO+UGXYIFb9TSSJrldV+es4j4yThJFmqLvUHqgT6X9DJkNMPlAWUlgs1ub+NSXD0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UnofNZ/I; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso1599666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715190782; x=1715795582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDD6cSkxh18P1B/GILc0PBtmaYxZm1FGfsVGarC9pdM=;
        b=UnofNZ/IsySDOfI6JphDsckjO7Gq3qys9SLX/eMUf94aAEAvNb17xns1QkmP/yZK9P
         LnLWJwaKaqRdESzvjPmhki/VdlkwDikSNZDSO2nlWeGGyTQM4ME/4YYh62sKhWPNbSHB
         125dE+kaFNnef1j/hR9Wohg59GybRes4uTA5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190782; x=1715795582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDD6cSkxh18P1B/GILc0PBtmaYxZm1FGfsVGarC9pdM=;
        b=qDzbjJPm5pkV18TtGEItx5WVCZ3eGnMgzn192YzdlMyIXrUBCiEYiV9PcKqFeYE4gM
         ECaujmW53Cx0GOz9ez3KEi2sQOLY4W5LLplfRBPxJGxyF84Vvtvi80P2B+qCVIIMVA+Q
         sci0yjA6WXhNyAgEu+R3az+SMul2S+7WgGi1gIlA1fd/+ggDC9lLPL9K4F4HJQbOv1dD
         v6GN3eqMfQMIsq1G2Haa0dJXf7isYmOrraoVsizV3C54ziVhMMyC3JROgHhh1kj3p/zw
         oid6QeIkOAIE2ZciAfD4Tg8Iw2m7gH/g0TIIYJ56KdyfVVQxY7ALFdrl22p4FgkscryP
         dKDA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uKX6Y2O4Dt7y+F3XwSSLf6KpcTnDnZWo/0lhSD+nsey01K/mdIiUFxJtHsOfNiZvDd+hbqnZFoWXT1DxPj6NrIU+7KY6qZWL2HYC
X-Gm-Message-State: AOJu0YzC1uFj0RQpcWdgXhQz9Lys5Fd8dy86iG8LnTqj6gKYzh5W+WO1
	AMpomQ1eZzHyBMBjODLnFfXQM9WL7askTzXcog9PvNTAtPVsq1FZaYrl1WWddPK19t9k26t5upi
	epOLg+Q==
X-Google-Smtp-Source: AGHT+IHeMBhjXjbhK9u9x8GGZ2uB+vtkzo0ysZOJy7ff0MbS488rN6JFLoaYRvw4hZMGa1+MngIW5g==
X-Received: by 2002:a17:906:29d3:b0:a58:bdfe:95a with SMTP id a640c23a62f3a-a59fb9582cemr191522966b.26.1715190782527;
        Wed, 08 May 2024 10:53:02 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709062b4d00b00a59e377f197sm2661498ejg.197.2024.05.08.10.53.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:53:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cc765c29so894673266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMnlPrIwq1ZphnWhAc6CW+kr7gfS1DUvXTiGH8/0IY3qa3U8AZcEdaSLukfNb2KRvHSMxgxJY3s1VG48t8OkeFy4qk3kdL9/7/3pNu
X-Received: by 2002:a17:906:1153:b0:a59:9eab:1622 with SMTP id
 a640c23a62f3a-a59fb9dc8dbmr211243266b.56.1715190781396; Wed, 08 May 2024
 10:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook>
In-Reply-To: <202404291502.612E0A10@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 10:52:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
Message-ID: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 16:27, Kees Cook <keescook@chromium.org> wrote:
>
> When I say "overflow", I mean "overflow and underflow", but more
> specifically I mean "wrap-around". This is not about "undefined
> behavior". We already demand from our compilers that all our arithmetic
> uses a well-defined overflow resolution strategy; overflow results in
> wrap-around (thanks to "-fno-strict-overflow").

I'm still entirely unconvinced.

The thing is, wrap-around is not only well-defined, it's *common*, and
*EXPECTED*.

Example:

   static inline u32 __hash_32_generic(u32 val)
   {
        return val * GOLDEN_RATIO_32;
   }

and dammit, I absolutely DO NOT THINK we should annotate this as some
kind of "special multiply".

I have no idea how many of these exist. But I am 100% convinced that
making humans annotate this and making the source code worse is
absolutely the wrong approach.

Basically, unsigned arithmetic is well-defined as wrapping around, and
it is so for a good reason.

So I'm going to have a HARD REQUIREMENT that any compiler complaints
need to be really really sane. They need to detect when people do
things like this on purpose, and they need to SHUT THE ^&% UP about
the fact that wrap-around happens.

Any tool that is so stupid as to complain about wrap-around in the
above is a BROKEN TOOL THAT NEEDS TO BE IGNORED.

Really. This is non-negotiable.

This is similar to the whole

        unsigned int a, b;

        if (a+b < a) ..

kind of pattern: a tool that complains about wrap-around in the above
is absolutely broken sh*t and needs to be ignored.

So I think you need to limit your wrap-around complaints, and really
think about how to limit them. If you go "wrap-around is wrong" as
some kind of general; rule, I'm going to ignore you, and I'm going to
tell people to ignore you, and refuse any idiotic patches that are the
result of such idiotic rules.

Put another way the absolute first and fundamental thing you should
look at is to make sure tools don't complain about sane behavior.

Until you have done that, and taken this seriously, this discussion is
not going to ever result in anything productive.

                    Linus

