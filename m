Return-Path: <linux-kernel+bounces-319442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C655C96FCA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26AD1C2298A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A51D6C7E;
	Fri,  6 Sep 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eY0SFyvh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5413B584
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654418; cv=none; b=NYyFN5dB/oWThV5V35pbM+7DatkaqFFL+cr6D8hBPcMdSa1F7NDA4K7AOJm4mjkQG5W0YPZ2Po7WMXguOBpyt2GuI0ZY4GGhXPVuDEKcnK9du3mf/uXA3/m/batdGAx6U2ojpwSNY2YeyzypZgjdPFPHiGW5tk1K6aipK6iUCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654418; c=relaxed/simple;
	bh=tgzEtIP4iIUgG7rWVZKsFLSTd3Ij6i1A94zJJ803g34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arHSXf6r5MmGydFl4KM8cV1hB06PaNyj2frX2rEuD9tL1AcUG3AEaWL5cu1BiKRs9OL2JN7yZ5T5s51NoPcgvru/376vLYPuHF0PaM5dgzAMFgygFx9qGIVWUsb9R9Pop0ULWvuKR3UW51MtVetr3bp7XcJTIj1++jTPHI3iQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eY0SFyvh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so19613966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725654414; x=1726259214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcurxd1vA4mcj7KzFe3Wj2Jx/osLbbhyw02EmyEuD40=;
        b=eY0SFyvhV5Q0Ff/8R88Il37DUpmPdl4AFTVsF0pH3IxVdTiyMJT7rR8wuDMfQPZNCt
         qG9aeUw/eTXFTsNlXgu79Rn9xmEeul8Hl98j2S2FmZji4sTaaFFA0NaF6/6uARo8aQMQ
         3mpBcQvtLq+1pGtMB1MzgU0G6uiwqut4FfM4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654414; x=1726259214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mcurxd1vA4mcj7KzFe3Wj2Jx/osLbbhyw02EmyEuD40=;
        b=lf5XxMFGFaw3xBCgKi5c3TJdl3WKulfQEf5hRveIGFVLR3g7PQ+Bmrak4PQWogphA8
         hJ2mexVat7sWhtICMPWCIE3m9mUyexLoy0suMURCdn02yrtqIXTG0k9dsI63JLYZ+DiQ
         JHYNgpO5V6nJBaGk2xKG/GOYQUdNM3jWsTrGkfIpd0xmE1dYYbpLy4BofsCOBILPH0ek
         58pgOgzYlE7eIMhJGN5TGIIEPXfcJ+0XCM7FVnbMA+PCrdkNugEr0kdCH/pz2l637EHS
         BF9/W72e4DuNfIJcZeN0sivbN2GgaUUwZD7LnARWJ5oXJRvlqkAxzrlXNInRz5JBCu3I
         tj+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMdC3fU/0nNKTZzEF6k6DsV+P9MA1oLEiiBnJ1TF0mqJ+zoUXc6Cr/3WU9RejaShP0XajYCpHfiMcYAYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsjHpugmrfpiUjQ0Kd03Qqo/i9su9JUbaQqD3yL8V9GLuEeiq
	4j9fnxwcFoeN0My6LIFcWqXGtpg5aRaOAYyhA7PJiW6kfKnsTKFrsAq+6h58dVBe5YHesc/E+bE
	ZSyrwgA==
X-Google-Smtp-Source: AGHT+IFC4CjK/pi+eh4WQV/uOjq1JWCjCoKiSfn6adJAPIkIxPNHX/lntHI2k7O0ncOxSzIrLew1Kw==
X-Received: by 2002:a17:907:da9:b0:a8a:926a:cfff with SMTP id a640c23a62f3a-a8a926ad655mr229450966b.27.1725654413360;
        Fri, 06 Sep 2024 13:26:53 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6fa6sm319155066b.170.2024.09.06.13.26.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 13:26:52 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so2730567a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLQNBFtidp9ZbZbnC2/3bA+NtiVE0ezWbtVrMEm9U9V7MaOXF1qKDmUiKH/sHUVaSPyBhBgSCMbfWsnLc=@vger.kernel.org
X-Received: by 2002:a17:906:da85:b0:a7a:9f0f:ab2c with SMTP id
 a640c23a62f3a-a8a8866090amr351523966b.29.1725654412251; Fri, 06 Sep 2024
 13:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com> <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com> <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
In-Reply-To: <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 13:26:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
Message-ID: <CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com, 
	sunilmut@microsoft.com, vdso@hexbites.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 13:08, Roman Kisel <romank@linux.microsoft.com> wrote:
>
> When the process has run into a fatal error and is about to exit, having
> a way to break into the debugger at this exact moment wouldn't change
> anything about the logic of the data processing happening in the process.
> What's so horrible in that to have a way to land in the debugger to see
> what exactly is going on?

I don't buy it.

If you want to debug some fatal behavior, and a debugger *isn't*
attached, you want it to create a core-dump.

And if a debugger *is* attached, it will catch that.

This is basically how abort() has always worked, and it very much is
*not* doing some "let's check if we're being debugged" stuff. Exactly
because that would be a bad idea and an anti-pattern.

The other very traditional model - for example if you do *not* want to
do core-dumps for some reason, and just exit with an error message -
is to just put a breakpoint on the "fatal()" function (or whatever
your "fatal error happened" situation is) using the debugger.

Then the target will behave differently depending on whether it is
being debugged or not BECAUSE THE DEBUGGER ASKED FOR IT, not because
the program decided to act differently when debugged.

In other words, this is a long-solved problem with solid solutions
from before Linux even existed.

              Linus

