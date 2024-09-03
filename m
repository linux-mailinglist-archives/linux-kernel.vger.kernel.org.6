Return-Path: <linux-kernel+bounces-313598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FE96A769
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B687B21F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B918E052;
	Tue,  3 Sep 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Go59oPpZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B11D7E3C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392092; cv=none; b=i4lmdCNjo1Ko8AcpQ7DP5uxFzEjC7hYiyx1KvNQ4GOO2nmCiKJ7JVqQAWjyQhKYadXr6JrY/rJwPkPznfV6ruZvIwwOwBRD4URboXRgZ5kdHV+KepHM5WAp3ZSWiC7FFq1gGauyz0FA5L/Q6iPk2w8oGellH88ZZZcx3PoXOw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392092; c=relaxed/simple;
	bh=UShskrRI1DRsJKg6TMK+JzmQnbWj40zzdhGhaCwR9Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7w058vr3tj7BLETjufK4Cv1i/B7EP1hGqCz6XWgbIG0DMEeWsEuYPJE9IIlnZK9lgVoxlQdFh462IPmFi9RNn/QvgVjGreP5BVp6v+k+ZrG7Tpa3z9Mq+L8G0ezgKSDdHG1Wsr6asImwx2P14X7CN28U3fCaedGrSZo5JBy1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Go59oPpZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86a37208b2so675148066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725392089; x=1725996889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=Go59oPpZS4eeerh+Zzi5xtpTFHfpaW3tVnu+O4SScU/72CpM9/py4vHk40VQSiMaWp
         1bgdEZ3ga2rp7sUS7OVsZS4oIgxPTtXXpRGIjXWclLXZaK082CtsvQwLAbz8kSaIZFNL
         veJLrx82n7AK2jAe1EmX5YCThGUoJ0/HIYnoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392089; x=1725996889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=bxpvlGh7XaTwTwPhEs6dDfBAXMC5kcS54uW3wmWjs8ewRQQ+OcQUwPK73LuWde2bUz
         ePpfheLLUKEjP9XBmL1CttKJSoHstgKboKmqYQBhmDHkdV/+erucNYgKTzahFDe6ckB2
         i7PyKcCZeZkPbbfNXKvqQ9dK3syAT6J0/YwbnZatfGK2ZmxLFwERlKyhXZ0yNVAnf9s4
         Y4kWpZiPuyVYZ0sV3AD7tQ5xnounyAZ0Sk9zWvKHr0XMSmcu9P0O1x4gLFBwfxFu9Liz
         q5PTfjTzaCSNqsBL6TBkOh8R+8zxTxfSO5ApbaqBRTRonEV6x7AD9CBwpkbpiZOO7ZFl
         HGQg==
X-Forwarded-Encrypted: i=1; AJvYcCVQDfKjNw72VEkkt60FYMZtDNbH4o93HjP9VNPIau0nyH7pxmtYJwX5cCml+9uTG/UPXt86/y31Faww82U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvjI0qkqdlq4IckcILpkcOUE87gUM3rW6WnpyEGFeRi2PusDg
	8l+TfKf7G0ppprVKGU0Ipo0TeDqG7QALVIl6ND6h7kfHifuCGa0RAiocQZDnFKCvtyYnTntF0ev
	8m2i9MQ==
X-Google-Smtp-Source: AGHT+IGGwUvkzYDzlfX0ePF2Hs/S+gi/EKK9/4rBIX0dRI2X5AbbRNkxUuIWV8rYcji1SB7dhpqhgA==
X-Received: by 2002:a17:907:9725:b0:a88:b90a:ff30 with SMTP id a640c23a62f3a-a897fa74dbcmr1361868966b.50.1725392088271;
        Tue, 03 Sep 2024 12:34:48 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a37asm6780280a12.1.2024.09.03.12.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so5435362a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqYdWh80qfsSGnvIv9rOtdvIqsfjg5Co1gjg7kSOqfqjAJwZr6YGvw5ovEfRvKpbQq+N+S9nm1bwm7aSI=@vger.kernel.org
X-Received: by 2002:a05:6402:848:b0:5c0:b33d:5fcc with SMTP id
 4fb4d7f45d1cf-5c21ed52b2amr15503716a12.20.1725392087234; Tue, 03 Sep 2024
 12:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
 <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com> <yt9d7cbso7p8.fsf@linux.ibm.com>
In-Reply-To: <yt9d7cbso7p8.fsf@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 12:31, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> > Either use kzalloc(), or do a proper initializer something like this:
>
> I sent a patch which does this today:

Ack, looks good.

This should probably be backported independently of the new close()
series, since the mremap issue seems to be a longstanding issue.

                     Linus

