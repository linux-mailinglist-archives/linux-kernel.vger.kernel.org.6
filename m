Return-Path: <linux-kernel+bounces-264458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885F93E380
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE95E28202B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0028F4;
	Sun, 28 Jul 2024 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EPVSqaSW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD21877
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722137334; cv=none; b=ceySc+bpKSIgKtf7O98xmf8a9V8yD+eOQb9cu2/vaGOd2lBhsJx+poKr/9d3hRhLecW8VZTjmtsiCklU21QVJsvNyVTh9D7Kp43je1Gb7QaBOk5ypEY9MkrCKbXbmZnUg/j9kwiWld3SZTVpy+ucSoket+rsP+PctyeuIekQ2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722137334; c=relaxed/simple;
	bh=6YFkB8nyN6MY46qdVK8H/fQ9atpreiAfeSAZuOFlF40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG609M9I9PVP/29/gje2g2vm41QZVBurc8IdC2PJJuOOIPMScbRBkPYNnHq0WpTq+6MNWwVcULYF8CaAKwoPmxF5+fCo0Ihqh+DHwVWkf89dxwnRwWjOwMqfY4Ds9/nL5LP1ZebpsBuPam3lOrZaXKjjG8JFsyizeNsLiFh3sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EPVSqaSW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684bea9728so761923f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722137331; x=1722742131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9X+da1FcOcMCu66M+y5ic2/n/9Mq1N6QW/0JWco3Tk=;
        b=EPVSqaSW/awC1xX5IV8LM7NcgFUlbYKqFZoPFCmy4wXSU7qtD2yfbt9uVogWF1xCVA
         S5BB4OFg4M9lHmBSYce/ivPEX8tHPbWG188XmHV6HVwm2aOAd4eqGJuN9yP2Kphu9wzN
         WrT+6NmcU4k1Am5NC7E0O0Fr7ZLDqD4R8eCm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722137331; x=1722742131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9X+da1FcOcMCu66M+y5ic2/n/9Mq1N6QW/0JWco3Tk=;
        b=MbGjqh0iIEmKo5Nu79NhRLq314n/kT1IzH4xJQl6wJrBOXLFddaRZ1NK4Qc/XyXdyu
         YKRM38R95MYziHKML0RjncinF+oa2lyZeefsUpW4leM7koPamd3FOtqMtgoRTQtxlnDK
         YAChHr6qSRnvh641qgIIuFbOBjTY7Jg2Gv3CiDE7N/TJicZNBGbwQRWW4/CLFCeuBybO
         WFOMhlE13C7mfKqpa6avddrtPQr8kIUpA3OVMmu4cyL+hokNAX/fZRwsooJEIwrWFVVr
         yqcPgqJxOJzY4wn1WYXYkGjW6hpNYPCBSo3xwLsu9uPGqQVzGU/n1hXEiFK9rEHU+kff
         VRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi1Ie8TfRwnY/RMnYJ/p6N0OXSPONcwT9YGkXW3akdA8wwCcjRWOcjtUtu7o5Nt4p7iTosMO52hSZlr/4ArcMR7issef9AB6rozwZy
X-Gm-Message-State: AOJu0Yx/ZhZ+Spwfq4QneGJ0KxjKR1ykdQwjHIR7rzNJrM15zq+wLjD9
	iNGgUaSxslCDeDKY+83RzFvZQCUC2CTanDW2HNMK68uHIXyKMhKzxtE2PrQ/TpfXfawLuQqgLd7
	IkiUrVw==
X-Google-Smtp-Source: AGHT+IGpx4WU1aL+Vi2JgFD0kMQ0IES4RUEjhGeu3w+VISpZXGlmgDSqjXEinZi6KkHofgVYESvVeQ==
X-Received: by 2002:a5d:5246:0:b0:367:9ab5:2c80 with SMTP id ffacd0b85a97d-36b5d0c844emr2416308f8f.57.1722137330786;
        Sat, 27 Jul 2024 20:28:50 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4a188sm340534466b.134.2024.07.27.20.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 20:28:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso3945225a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcE7S20CT+zXwhDh4WF3KJ/NUAEU5ZE5jb6H9PM32ZaOkMBaTYxch5GiE9HuwpsKspkP9OqnIYpLSqtwHaYuyc6OfdVCdZbSUKC2Ab
X-Received: by 2002:a50:9e64:0:b0:5a2:694e:5faa with SMTP id
 4fb4d7f45d1cf-5b0205d6384mr2138631a12.8.1722137329214; Sat, 27 Jul 2024
 20:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
 <87a5i2ttv0.ffs@tglx> <CAHk-=wg-qQGB2iM1OeprikBWp9-nUEDaWNxwwJ00u1vmUJVtHg@mail.gmail.com>
 <503c1a50-ddc0-4128-b0f0-feceb43ff5d3@I-love.SAKURA.ne.jp>
In-Reply-To: <503c1a50-ddc0-4128-b0f0-feceb43ff5d3@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jul 2024 20:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_mq+fvV2+V6FPYNF26DW0J_3zVd1i=ukf2oRe-B6O6A@mail.gmail.com>
Message-ID: <CAHk-=wh_mq+fvV2+V6FPYNF26DW0J_3zVd1i=ukf2oRe-B6O6A@mail.gmail.com>
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 16:48, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> What about emitting some kernel messages for investigating whether there
> are users who need this code, and wait for two years for whether someone
> says "I need this code" ?

Heh. We've tried that. Nobody reads the kernel messages (or the docs -
people have tried documenting "this will go away in a year" in our
kernel documentation instead).

People notice and let you know when the feature is gone, and generally
not one second before that.

Actually, what *has* worked is WARN_ONCE() kind of big really scary
messages, and that will actually make some people notice just because
they are *so* big that people see them almost by accident if they ever
happen to look at any logs.

But then that causes other problems (ie the denial-of-service on
platforms that have panic-on-warn set).

So while we have done that too, it's only workable for some "let's see
if anybody hits this during the release cycle", because you can't
release with the warning in place.

Generally the best option is probably just to remove it, see if
anybody notices, and add it back if it turns out to have a real and
valid use.

              Linus

