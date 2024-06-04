Return-Path: <linux-kernel+bounces-200780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD38FB4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A267A1F22B72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C62B9BF;
	Tue,  4 Jun 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="AbTa8NuS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD7179AF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510269; cv=none; b=Q8UjnY4iDLJd783NCweFty/c6As8GensA4wqWJmgpJc9S++hWfkuBHYpDLH6GxV/XEn6spRAarn6zy6aAzQZN5TJqxfSProQyc24hgcKVl1puqmIdcw4T9wo5yLDLTtH3Ny2lyrSHDis3xLJkkoVe5/OZVokHMZ6x6SdMP7TiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510269; c=relaxed/simple;
	bh=3J224HS/i/m5wpovzB18NFbdiZs3oTx/Dp+0hVsFnGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7wcfQIf47eLTOjm5YRaTWQIKgeJkBf6iST6o4XBLqiTf4kIVCTMYHmZQSQIXSZ/QJIvD/IR5iVnB6hcWYGos9YYnOGLsbAbprvMX2TFpgQUnWQkCjMkBzo3OKim27p47NEqmKFQ2OMKVHQUC16zbYFCumZ3y1tZrrEvOLQ8anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=AbTa8NuS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42135a45e2aso26976975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717510265; x=1718115065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHLll6BTIMUHEHBTeAtYvtf1ag837ymjZhmcP8Q3NO8=;
        b=AbTa8NuSSkbpuFgMUVm4u4pWCeonA/cQ8UqqBWmPObOb36QVXihtpwhO0lZ62DZJNF
         J723VdsqX/De2da+jMN1XbSIlRpXaIrc8h1vNCZvM0QgXIiCg0ShlrcpDn/+EjDv46rn
         MRhmKkQvFDTeqvXY72VV/iqBlg4PzgI9q8hdDWYm8lMrFY3fiUgAoAPe3mgUaWtr/5Mk
         OxoCZp1vG7qcpViTtVuZkytgcqXtwqyIfSKOjNuB3BV81aCma5SqlxhY8qdljtFKzx9U
         AoUsl3xxhSY416wfVSFZdUBtJyAPRSXIaGenKmLdSqvgR8rM6EdDD0u81f//W+Bi2FXC
         zEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510265; x=1718115065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHLll6BTIMUHEHBTeAtYvtf1ag837ymjZhmcP8Q3NO8=;
        b=IOM6mIuLqbEJPacQyWzpZaFxMUynSVs7O/TldiPXrObTpzb9cPHbLO7B0Bqv1RDh4s
         fU2nnVwHBgCqLyk5NoBB4KbAMLGdFvWqNbEE3vdD8/6kVKamVygaPYiE6Jrz5OV+1WnD
         EHB0Vf4Vdrta3qzq/dxCDLbPhUIN1J2vOi5vWPaMlO31sh69onqCMDtVT8Fq0uZZeTU6
         sIQUFkU/CtxSYrlsqmecgOmv5hiCgZErwPfQThWfF9ez9vizBzKou+3os8FXaPeMDM6o
         qepu00Txa+JTFk1FP3DzcrIM6re7r1AqgMhV05Zcu/xT9elssCu+ZBEC4yVzJGiaxCIy
         rLBg==
X-Gm-Message-State: AOJu0YxKPl/tXW9DHov5MS5aq7WertyE1bjFcGimcSa047nMLFGgYdmA
	D4aMAC0uQVtE9md5VAuuzXdguYT9wS3qOOrrzpl/9TR+xt/7NgH5wGdXSIam1t4=
X-Google-Smtp-Source: AGHT+IFpkMIUuPKlJOFMDP5oMo8/uZFBjSZJLegpODPIv7QNBGYdRIgYTbSS1Rq8yZQDmG6ptdHByg==
X-Received: by 2002:a05:600c:1ca6:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-4212e07548amr115529045e9.17.1717510265372;
        Tue, 04 Jun 2024 07:11:05 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e4f0fd15esm9168827f8f.68.2024.06.04.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:11:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:11:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v10 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240604141103.idwodwyeecml4keh@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507045450.895430-8-jstultz@google.com>

On 05/06/24 21:54, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Let's define the scheduling context as all the scheduler state
> in task_struct for the task selected to run, and the execution
> context as all state required to actually run the task.
> 
> Currently both are intertwined in task_struct. We want to
> logically split these such that we can use the scheduling
> context of the task selected to be scheduled, but use the
> execution context of a different task to actually be run.
> 
> To this purpose, introduce rq_selected() macro to point to the
> task_struct selected from the runqueue by the scheduler, and
> will be used for scheduler state, and preserve rq->curr to
> indicate the execution context of the task that will actually be
> run.

This is subjective opinion of course. But I am not a fan of rq_selected().
I think we are better with more explicit

	rq->currs	/* current sched context */
	rq->currx	/* current execution context */

and the helpers

	task_curr_sctx()
	task_curr_xctx()

This will ensure all current users of rq->curr will generate a build error and
be better audited what they are supposed to be. And I think the code is more
readable this way.

Another way to do it is to split task_struct to sched and exec context (rather
than control the reference to curr as done here). Then curr would be always the
same, but reference to its sched context would change with inheritance.

ie:

	struct task_sctx {
		...
	};

	struct task_struct {
		struct task_sctx *sctx;
		/* exec context is embedded as-is */
		...
	};

Which means would just have to update all accessors to sched context to do
extra dereference. Which I am not sure if a problematic extra level of
indirection.

I see the latter approach  more intuitive and explicit about what is a sched
context that is supposed to be inherited and what is not.

I generally think breaking down task structure would be good. Hopefully the new
data perf can help us make better decision on what attributes to group
together. And generally this might be a good exercise to rethink its content
which grown organicaly over the year. Maybe we want to create similar such
smaller wrapper structs for other fields too.

I **think** with this approach we would just need go fix compilation errors to
do p->sctx->{attribute}.

Proxy exec later would only update the reference to this struct to enforce
inheritance for rq->curr->sctx to point to the donor's context.

