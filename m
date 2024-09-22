Return-Path: <linux-kernel+bounces-335086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6897E0DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A051C208C6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA0824BD;
	Sun, 22 Sep 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="InlzMJyd"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983B14386C
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727000457; cv=none; b=RtFYCUFt2aLW30g6bBrmcITFM9C0IHmnv78Ui7OkbvvwuOMYwL0vH/LCpgOWkPpLWmosoNy5txcFpeR7uxVCSu2n4Dij+degBw03Vg7WL47RlJ7aeEog5wijf4iXTKj/bn0qp2XxXgJiW4gS+NeDkrXziXAQ+4a9L5TVKECEK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727000457; c=relaxed/simple;
	bh=pm8dHJrsGf7Il9p55Q7LINTzOlFn/8nsA6d/5jUfSgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUDKswuEvygueQfoFoM11XkgkuKWbE1JsZ33GIPvk3j52TpBJeyqGxqUAGo+uJiyehuz838i3HMjP/RjU5W5nHqGUcUEF5IOvL4q3MdSM094rSBO99xH2BG1yMDIB6SHqDJBmDtZbpl4No9Y+EGc3OQ418n6roT3Brbp3wc5hOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=InlzMJyd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-458362e898aso29472891cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727000453; x=1727605253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8/4SWBzBRsRFoXrz0ENhRuWuJUVz2So0jJkLzHcuiZk=;
        b=InlzMJyd0lo5R68/BCTB61kTDq2vQO8LIT3sCuw/PMzClYKQHhs7jbsW5G4T+PYmiV
         NBBUaQE1X3MXlYrhGaX3BfYBreniM1JqwzoW3l1jOWXvWJxfA2d2DsJ8Vm9V6P8fPheH
         uL7Gs0iy4pO2hhZeLkDSHIw0Q5F3UOXTXT24La4Pzxdnq66oufMT9S08UhR1It2NLOTe
         4kixz3NJk8mkysepsA7/Ft2qdtNaYz1/evSrgQdf0ZFkWBg7gJgk8D3dk2Tf8GahkO0N
         H9vDO/Ex3dcTbrxCYfhTN+zQOxMb7RWP5G4dRGZaJgmbhjVy/KRU8O4IsvcTorn0W5W2
         FVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727000453; x=1727605253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/4SWBzBRsRFoXrz0ENhRuWuJUVz2So0jJkLzHcuiZk=;
        b=AG0r1cNIaSA8+bPBkJ03z+GbEtCI3j35qc9xYZeBAmmRRETPYt5qkX23/IVnsMKl++
         18GVeJaWGZxt9JaLw8N279WukVrw0lXSop1i8QFplUEUQ35RX0Ig1LPvxHOhgUnDPBNe
         YhKnAeYn1JunFzlW+kNu4+p8NVaDmWuOC5h0DYx2lmVzcnQUWaGi3T/CpnlZQVWWRQo9
         8YfjxCvQmGeroWzszgk4GQzkgk2z4eBDiRFC4RBe1lyf0M+jqEf9RY/X/YTrD5BjSmyI
         gLPw68vGJ0cGGQ5ERoSB+RcS4PjrWVq1dmLL6rDdE2KKi62ltrB2BkeYKvWRlo7o61zc
         3QBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWeiFFsEKltHGqS83HpgrEth1OQmNrbDbxTTTDZyUHuKeLfurxnL+1ZinY6UfcX4aIx9s7Z/zjElB8QWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyVeNTTgYqYjfUCDHiqnnPk8D7sZDZRjBQdErFFt5rWyVLKEi
	+0rANr0Tzf+r38NwxWvl1hAZKgf1hVnnziczGV1Xdd26uXgPr9U2fCOLPUlax8A=
X-Google-Smtp-Source: AGHT+IFjZiKh0O4Hjrg2ghYZK1LOtr5fLh5RrB8KD0gWAtgtR2Dj9yb3WBwXo5/FEiuyo9gA0F7Thg==
X-Received: by 2002:a05:622a:14c:b0:458:4dc5:b7ef with SMTP id d75a77b69052e-45b2057e770mr127555161cf.55.1727000453197;
        Sun, 22 Sep 2024 03:20:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b1788c181sm35890941cf.52.2024.09.22.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:20:52 -0700 (PDT)
Date: Sun, 22 Sep 2024 06:20:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: Error: psi: inconsistent task state! task=1:swapper/0 cpu=0
 psi_flags=4 clear=0 set=4
Message-ID: <20240922102047.GA437832@cmpxchg.org>
References: <cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de>
 <0bfb1dfc-bab0-45c1-9fc0-7e91266ef52a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bfb1dfc-bab0-45c1-9fc0-7e91266ef52a@molgen.mpg.de>

On Sun, Sep 22, 2024 at 08:53:37AM +0200, Paul Menzel wrote:
> [Cc: +PSI maintainers]
> 
> Am 22.09.24 um 00:50 schrieb Paul Menzel:
> > #regzbot introduced: 2e0199df252a..54a58a787791
> > 
> > Dear Peter,
> > 
> > 
> > With merge commit 2004cef11ea0 (Merge tag 'sched-core-2024-09-19' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip) I see the warning 
> > below on the Intel Kaby Lake laptop Dell XPS 13 9360 and with QEMU.
> > 
> > Dell XPS 13 9360:
> > 
> >      psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4

Oh, double enqueue.

It looks like the psi enqueue/dequeue callbacks need the same
treatment as the uclamp and sched_core ones for ignoring delayed
tasks. [1][2]

Do we need to reorder psi_enqueue() after ->enqueue_task() as well? I
can't quite work out why uclamp needed it, but sched_core didn't.

[1] dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
[2] c662e2b1e8cfc3b6329704dab06051f8c3ec2993

