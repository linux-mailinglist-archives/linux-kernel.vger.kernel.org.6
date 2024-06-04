Return-Path: <linux-kernel+bounces-201043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBA8FB886
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AC91C250B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3D914882D;
	Tue,  4 Jun 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5lO12AL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD71487F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517296; cv=none; b=ZfyA9xU/lVFkh5QthlF9a7f2vfe6Z106SL6Jn/+GsAvqtqDTPU1O2IWtSug4ghmXp9w2oMEQVi76uSrqGtWo8YCdB3Fng4I6GiH0ISwHALPIWcgGfdixPeH/ONpMVtK5nEs5Rz/F7lMVZNVUpbgHRBI+++2X6zmlPI6F3j5muV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517296; c=relaxed/simple;
	bh=KDTa+PJ5eeVOd+MfhgCP89f4+O99J5UKBCREOezms0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arm5vQpD6oWY9gWDUE26pnO/HZYS+MrRpoFirBY9w9UumWNBT5qxboRZmmUIw4HRNjaknLFhn7Sw/GSeoF75eKc/ritk9bkvps4ex6jZTYSwbid37SIvHMf4zYkkkefHAcTRhuJ3sL7qQQ7lcmckl+IB6e4r8uC71KfZQ3YLmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5lO12AL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso11214a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717517293; x=1718122093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rVSYwx5fVzchQDcX26rC6LU8bv7Rb+05yZYVVsCliko=;
        b=j5lO12ALSwAvvkWuHSxgzGYzegCwq8hL7rcaqzPpajT8frf6fhmxlrsrW+vLJ1nNr8
         GEwHzQRnDPxZ3HXehbXBEmb+PKgQfEm97d9aim8dZHxtjLhLah19UXuUrh96NLt3k00U
         wK865TYMTJDnBvRZvCAsruz+luW3TuClA7BcJGfHUHujCA2aAdKdRmK1AT/12U7Vg1RQ
         mffWemJcJA1kUktbzC3gRQBCWhZN1/m7ABc9F9JdRLT77ob01vAG6Ls3ipaGbcY2VRC/
         Qs0c1Iwnme1hmL0t0Od3KcMRn+zU48xIDR7HzECAYycBpPeb6Fp12DwHjxh/8C/Kx1lp
         IXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517293; x=1718122093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVSYwx5fVzchQDcX26rC6LU8bv7Rb+05yZYVVsCliko=;
        b=HbikHncMbJMtrylFQU3GCVZjgEVCSAS4P5fpMQQ1xkwhb22J/Yisik+tNRA/iJ9l+m
         c2oDUO9N8IE9dHSM/lfzijk1DJAcC663EQlJslyH3CpRFC9G0adlJjIb7rkL1AtKWGLE
         nqj1xFVSbzsw6QC/fwe3h/gosyvvU/gIDoIeJk/JRo5RmE7LJtg2urus3StoEuY9vfse
         vPghBGEAfZpmnYDHlaTLKTl9O+zOlBgMFKSTGS3oveiAEu5gbIv/hyWEjUbomzBLSYxV
         t38NQN1USFH+MqODWnWsNRTDWJeVcaNFQhpZhT4H6ofx7sa8ABFyPWobIrTDi1qDiqXH
         1/jA==
X-Forwarded-Encrypted: i=1; AJvYcCVm2JmbEIXGU3/Up5E8sw12mDrb8EOWZdM+VqUcSf+penw1JNZDSqJEpC8YnlaZmirWwkNOxTFFCWUYYx95BeCluVPR3vGStSmixksu
X-Gm-Message-State: AOJu0YwjJlJm+6clqgyWXysS8dePQogOST7eQYs4UiFah1jI5r5Kc6+D
	lPOSbb3mZJx9FQT+UIeciktRZLOaKE7HRlzxgqvdwWVNHV6mG+nWgDQT4RyuzWrE8JFyOI4ymke
	qx9/5iaUAuZQ5BvLodY3Gloz6jpWHL2IBXE/1
X-Google-Smtp-Source: AGHT+IH+oB1DnjI2U/ZeNzKa/BJ7QaL35XcSz5qPnVnPsMEs1iTipj4x9dA3MeZNdH6wXMdTZguAgTpFdxXsurS8fnc=
X-Received: by 2002:a05:6402:b04:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a80593672mr150384a12.3.1717517290725; Tue, 04 Jun 2024
 09:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <1ada3be307bbd076c4ea63530cf445e7fbd0e4e7.1717507310.git.dvyukov@google.com>
 <3f15814c-de9c-4aa6-b56d-82761bb6520a@intel.com>
In-Reply-To: <3f15814c-de9c-4aa6-b56d-82761bb6520a@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 4 Jun 2024 18:07:58 +0200
Message-ID: <CACT4Y+Y2j-YxvjkkXwuUp6cRjhqQOQN=fcga+0co7eirD_wVaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/entry: Remove unwanted instrumentation in common_interrupt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 18:01, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/4/24 06:45, Dmitry Vyukov wrote:
> > The manifestation is that KCOV produces spurious coverage
> > in kvm_set_cpu_l1tf_flush_l1d() in random places because
> > the call happens when preempt count is not yet updated
> > to say that we are in an interrupt.
> >
> > Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
> > out of instrumentation_begin/end() section.
> > It only calls __this_cpu_write() which is already safe to call
> > in noinstr contexts.
>
> I've internalized the main rules around noinstr to basically be: Only
> call noinstr functions before begin_instrumentation().  Second, try to
> minimize the amount of noinstr code.
>
> This patch seems to be adding another rule which is that all code before
> preempt_count manipulation needs to be noinstr.
>
> _Is_ that a new rule, or was it something I was missing?

Hi Dave,

This is an old rule. KCOV was always intended to not trace interrupts:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c9a8750a6409c63a0f01d51a9024861022f6593

+void __sanitizer_cov_trace_pc(void)
+{
+         /*
+         * We are interested in code coverage as a function of a
syscall inputs,
+         * so we ignore code executed in interrupts.
+         */
+         if (!t || in_interrupt())
+                 return;

At the time the entry code was in asm and wasn't instrumented by the
compiler, so the in_interrupt() check was enough to avoid all
problems.

