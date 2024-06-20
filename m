Return-Path: <linux-kernel+bounces-223376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3725911201
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF028B21786
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2931B4C5A;
	Thu, 20 Jun 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MARp8UgU"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CD1B3F38
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911267; cv=none; b=p87nVgwgJYJxYmZLMJSAJa1UZWs3i+AhBAYdI7GEIcDUtvcOK4e6C5ZKeZRfw7AUzYukTrlbzCiA99Fdtpq7kWEh4ANdviskYGaJuCb/X/pol6cLanjnIUyxhGTzF4y/E0j6o/dKTtNMOjWTV1cG1ez7gpnDcHqxC0O66ldy5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911267; c=relaxed/simple;
	bh=6U+UiUTO23oyjadTo0w/kiMzzky8bLwHHVEdkkl6RAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7r67bxGfFoOpSCkuR1msyKu8G2BxYugngbTaA831s27vVm36UdorQYPrvlj3HwblLhJRd7sygNSwMHjW+N2vJcZU+AEIDcTgu5DypGqGH1v4li6XszHQoLNetiX2rR+AdNiv+nIhYEAKKt0f4a2Ci1xLYHTWA2hLdfjeUuj6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MARp8UgU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3645e9839b3so987680f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718911264; x=1719516064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1iJzjizGh2wBhzxdq8cmqbfEnfFmiOa9+Uvi8Nk2w4=;
        b=MARp8UgUgeRpCiRWsBvQSG2c3rBvTDYXElCTFsv00G1u8MLMcWMkbvOx4exely8FRI
         a8PjKaxdNBhNwBmb//SNZS8CAMDfiGHXOPST9fk17mzZkvLwOo3kabZAWk4aTkZDuenG
         PrlL/eF81oPGsVlqnFAHXTrDKmrPcSYFIXOLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911264; x=1719516064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1iJzjizGh2wBhzxdq8cmqbfEnfFmiOa9+Uvi8Nk2w4=;
        b=b8Pco8P+/UTV/nYwi1BNOUQQvuOfbylFpQSaKVzlUU72ABZvnyDWCSNst8Nsb3FYOD
         2OkHYdpVdrSeApOZK168z4uTetCMmX2lPTxCA4XlUCQRYDY/chOpdcFT9W3zzyjztttx
         8wGBCQJrxOQ0XRfdYiMyB+e62kriwuVrV01246FAZdg14PbnHJtbWay4qyua/H7fFa1v
         e+KEIbqzFxfUF+a35ogJ7VVzMzVoSqDdN6tMd3gcTP2upH0tB5FXEgK+lDyDvuxyG905
         wF/Dc7rFD4/7OvWVwKKeIM5wRcM7mgVaGXZaUkOc+h0dk6dpIIoZ9doeuSPk7zTbra99
         Lh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw6FrZHWipYpBReYIPxjIVyeOPoVCYz8w0QmDFGcSXtmFZPEXFLWk8kGUVTo+tWVsTT8e99yKBmryl2ebYTAuDc/rWh9+ma0JIbtfb
X-Gm-Message-State: AOJu0Yz2Df5/GMqSDcMBeKjL9y20PeiN2oCUHwyU0Q9bB3j/72624NHN
	fmAZPYRbLX9nkmD5H9134IRBenQORpR+Wp2Py0KVpYnaEi87uOlQFdwIvapQhGJqpUZdER1Sneh
	bMRFpLw==
X-Google-Smtp-Source: AGHT+IFoZhf5yxPzjgaozcKyzDV4nsL8Vs11HE/iBU72Pne7sX1n8Uj0yQ/cEp6KrH/MClKs9GG4VA==
X-Received: by 2002:a05:6000:144:b0:360:746b:6015 with SMTP id ffacd0b85a97d-363170eca2bmr4696155f8f.11.1718911264162;
        Thu, 20 Jun 2024 12:21:04 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560ccdsm2207866b.185.2024.06.20.12.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:21:03 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421b9068274so12395215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxcGFI0mT8ULlEAuAgbOQ9z3D79RBgfpPHP+cTQeKy7dP2OgM3IxcSCvpXQjRQvX0GdE69OH2D6kpyJiJPcoaSvaU9s5i5AbPy0dLd
X-Received: by 2002:a17:906:1289:b0:a6f:6721:b06d with SMTP id
 a640c23a62f3a-a6fab613cbfmr334109566b.24.1718911242018; Thu, 20 Jun 2024
 12:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
In-Reply-To: <871q4rpi2s.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:20:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
Message-ID: <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 11:47, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But wait a moment, that can't happen as pluggable schedulers have been
> rejected in the past:
>
>   "I absolutely *detest* pluggable schedulers."
>
> Guess which famous programmer said that.

I'e also said that I find schedulers in general boring. I think CPU
scheduling is just not very interesting.

Look at the 0.01 scheduler, and the comment above it:

 *  'schedule()' is the scheduler function. This is GOOD CODE! There
 * probably won't be any reason to change this, as it should work well
 * in all circumstances (ie gives IO-bound processes good response etc).
 * The one thing you might take a look at is the signal-handler code here.

Which shows just how much I knew (or cared).

Things change. Back then, you could have a maximum of 63 processes
(plus the idle task).

And the "I detest pluggabnle schedulers" has been long superseded by
"I detest people who complain about our one scheduler because they
have special loads that only they care about".

> > But I get the very strong feeling that people wanted to limit the
> > amount of changes they made to the core scheduler code.
>
> Which is exactly the point.

But Thomas - that's *MY* point.

If this code stays out of tree, the goal is always that "don't
integrate, make the patch easy to apply".

This whole "keep things out until they are perfect" is a DISEASE.

It's a disease because it's counter-productive. First off, things will
never be "perfect" because you have people with different goals in the
first place.,

But secondly, the "keep things out" is itself counter-productive.

             Linus

