Return-Path: <linux-kernel+bounces-529137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A189A4204D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9AE189AB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB421931A;
	Mon, 24 Feb 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCVzeErt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768118B482
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402998; cv=none; b=pywn7wk1BeKUIVKeORrs94jfV9BHLZEfV0gx8DzhYm1iIbhoEC3BTqyzKwV6o9j8EXtGa87QYo/u59rUzcJH4f7dM9vK4TmYGxSY25CZ9kx0qCSQozCGXe676KGqp5l7fypQSL2Q6IpsWwOWR4cHu1jtguLGkWQIyyiV/N8MibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402998; c=relaxed/simple;
	bh=by4c7xWjZv7K9AG20FTgiR7lXj47hBVlvT0Gqp8cxbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmV9ecMH5KtdRFMYfWuBofx8qr8qG71Pki9Y1j4ZXT5fZXcCnvwkP079917ZjlHcdty4JGu8nEMap/9NF3gDdVOJVfsSsN5FrnQHYWKxlbAKpAmyEs5Vr0snWLAWOdHOPYLFwYHe84hc8X+DfFzImS4x4VaYcCbd9fhpToHsDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCVzeErt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so8160939a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740402994; x=1741007794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WTgfkvn8MxqIFdziVt3orvo1glz+j5V3klW9mhp9Q30=;
        b=GCVzeErtqN1ddNhWMlZ5GOPadxflER9cacfXr2TOjoUAG1PvDqrTm5jervxmXNYTzw
         It5cHPoQfQLh7xdnjjHsQEnBcsKXbR0BcKPXWB4/qH6FWiDZcOKztBgiOp007Gu3Kuo8
         Q/ImNDrC5thZGtrzYSJeopwkIyeCdT4uSVqULPr+w10KbBhZz54K/+B/e/GjHFXUq1NR
         5Wy5NB9B8XEmeFFmyNLS23JHr+qee2HQKLgH5HUTk35ZfFM5yQVASelaVgZd+9Qr5CZF
         DZn4K5renUH6mIhy0ytZ7ZXyFkyqS0GYzc/EBs2gp9apujSQl039t+pY6iVomyQfV3dL
         4H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402994; x=1741007794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTgfkvn8MxqIFdziVt3orvo1glz+j5V3klW9mhp9Q30=;
        b=hubojL/oAwgqkXti5BHo4HFJG1GKTL7CmGjWtYwfEw4cTIbNRdIYkSa4EAdw/oXR7Y
         IIHS8hRYrmNGV+ipoWTQYA404+eRxyBcsQMqlP8YirXi8zIRP37JcpTW+T3qWIemmRrw
         HX6RlIMC1AqMdmUWKb6Rxi5E8zSKC8BkYoO3QMMhRFqxTxJfmWPN/Iqq0JonpYfYs6FL
         4VRBF/8YFTSQUwBHxZuGpyoWq1PPI+qIav8ZfrFRpoCwve4jSiTJSWLNTyOFgpnQKvSh
         EjR7ouxbl7kY+Zibad+QCYlmhTMYx75ShQDIlI/Gj8Tru/hMf3scryBAUeDHaILBr1vt
         CiDg==
X-Forwarded-Encrypted: i=1; AJvYcCXbWho2IxW+2L1kmPeFZ4ErDuYgvG2nOlt6E5CFGpYR5YTEKdgTnHIEkqRqrQlZUGJwN+YuCKJxCqc+PMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAMhcL3sCzWF0AJBlkEihiPGOaHz4yrG+NEJVd6XraSchr6EL
	E4DwBdJWtgXgMhtESEkVOAKmhrBJ23aVX9EN3OScauBaqXJPm+z8SOvX2W1hEUTbcHa5gTsqPbf
	LKHZeY9LWcneoT1uBdnFQAwZJgi5rI2hQsrDo4w==
X-Gm-Gg: ASbGncsTIm9TIMZf6QORN2m1E7NmWjqL4+Y8IQlp7LhSovXQ/KeOYQJzWDWLNzPhJ6W
	LHV5i5a1dQS31zuFH5ZJCug/8E0p7Te4QCLohcL7miM7MYhUSoNJIhP9X1Agx+7xji283p3WKqq
	kOmCRPgX/7xjNAd9fiZqWoXqdsXrW5GMHOqJhC
X-Google-Smtp-Source: AGHT+IHo3g1OAq/ooC5HgR04q1dPHE/40igvAMR/vKb2A31SYMAPVdEQLLdj1XolHJ4wg4FhvzL9KZxbboHIVjwwkRc=
X-Received: by 2002:a05:6402:350f:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5e0b70e4ddemr12246110a12.9.1740402994477; Mon, 24 Feb 2025
 05:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210001915.123424-1-qyousef@layalina.io> <20250212145054.GA1965539@joelnvbox>
 <Z7rTNxHcXWizV3lq@gpd3> <Z7rxuqIB38Wv557A@gmail.com> <20250223232151.xtsobtuoaofotrxx@airbuntu>
In-Reply-To: <20250223232151.xtsobtuoaofotrxx@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Feb 2025 14:16:21 +0100
X-Gm-Features: AWEUYZkjxZV3kmYnifZsJKpjnAz4sFT0SwnxYtOS_72NpSk8PFae_7E2zBNEAfM
Message-ID: <CAKfTPtCiTz+-4Umcmt4adn3u6r=rcGoSZgNPfuvacCQ0XerKGg@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Stultz <jstultz@google.com>, 
	Saravana Kannan <saravanak@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 00:21, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/23/25 11:00, Ingo Molnar wrote:
> >
> > * Andrea Righi <arighi@nvidia.com> wrote:
> >
> > > On Wed, Feb 12, 2025 at 09:50:54AM -0500, Joel Fernandes wrote:
> > > > On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> > > ...
> > > > > I believe HZ_250 was the default as a trade-off for battery power
> > > > > devices that might not be happy with frequent TICKS potentially draining
> > > > > the battery unnecessarily. But to my understanding the current state of
> > > >
> > > > Actually, on x86, me and Steve did some debug on Chromebooks and we found
> > > > that HZ_250 actually increased power versus higher HZ. This was because
> > > > cpuidle governor changes C states on the tick, and by making it less
> > > > frequent, the CPU could be in a shallow C state for longer.
> > >
> > > FWIW, I found the same about power consumption when we decided to switch to
> > > CONFIG_HZ=1000 in the Ubuntu kernel:
> > > https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
>
> Thanks for sharing the data Andrea!

I  don't have power figures to share but I'm aligned with the fact
that keeping HZ=250 (4ms) is not sustainable when it comes to handle
task scheduling on devices with 120 fps (~8ms) constraint.

FWIW
Acked-by : Vincent Guittot <vincent.guittot@linaro.org>

>
> >
> > The "HZ=1000 reduces power consumption or keeps it the same" is
> > actually a pretty good argument to change the default to HZ=1000.
> >
> > These experiments and numbers (if any) should be incorporated in the
> > changelog prominently - as actual data and the Kconfig decisions made
> > by major distros will, most of the time, be superior to meta analysis
> > that seems to be the changelog right now.
>
> I will update the commit message to incorporate data and the feedback received.
>
> Thanks!
>
> --
> Qais Yousef

