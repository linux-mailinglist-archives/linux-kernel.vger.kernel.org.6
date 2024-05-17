Return-Path: <linux-kernel+bounces-182622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E426F8C8D70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B571C2083C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689938F86;
	Fri, 17 May 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEkLI+La"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B941CAA9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978685; cv=none; b=IxK7jKnwKqICGq8CtAvEAT8j3Jewy1b0BAB+p01hyTohGTS3t2M0NKbADdoi962ODohM2UVbwEanTec7ASysu1RJy4hMWpN575eWwFOyJn3QZfmPdDAYgjyiwUwmS9cOO5IHY9fsM35UiIGdtQ6PcZnW2RYZIBj+8iS5uHAdWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978685; c=relaxed/simple;
	bh=enl/u0WaBGKVumEPgKBxzG2xFD28G267kmodtBlJvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwfhIWyx9zdGh1h03aqCZjNImbgfDHEY3xuNOs0cWxVwmVgTSPRtCHHsMxFsi/V7d/ZeSSYBdCEkPFS88mOuhWekpl7P9HGAa+jXLPUFgVOknBVPDT7rq78SqxL3tpFPrbiFHy1mBBWHhsmVLjjm8EwfaMHkDKgYmSk4CaZ+C10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEkLI+La; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7f3aee7c531so284780241.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715978683; x=1716583483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfW2CzQXRR9NaohIgk1ll7SgEJQUK4q2DEIg0yJzBQo=;
        b=cEkLI+LaWPYEo88fd1QkkNy6yVncogG4/gz5ArXjG9Ci/eeMclthOwD3xdmAIrsFiP
         5ZAa+hVLXQ2K7wfstSxo8Q3GUCZpAXV+Qy/4x6LkbSwmojIzF//ISvNRO1HYbl6haD17
         jL5Imh5RFuo7FmHqng1V0B+2GCB7FDM5DCVIa//BvW+NbAFp5J/MIRtZ6H+nUeOIhCrA
         IBC80siB0IH6P9tp7h+9Z/vuyD6FX2tWcYbg3T1Y25R35zxEojtPAdAdlvHFMKrqUmsL
         hJBjUNsaXq3V6THye9g8u4T1z5gX4INQoHqLFkrst5Dm5F0YsmcyCtNo+Uwh7fh5nKw5
         P9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715978683; x=1716583483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfW2CzQXRR9NaohIgk1ll7SgEJQUK4q2DEIg0yJzBQo=;
        b=jJM4gdgdsDgYLKUAURteRf80y1pFpSF9MtrOiYly5UAQYscP0bhepkOMTgqkvI2Ust
         h3qmufCvkeqQWLnGHSCh6QLNKwn8hE/RUNK9x72lRE6xr7d94fgXRxalZBhG3ZoU3CI2
         3gsep4JXnqwgMRn8hJNcrLBLDj/lZnupCHd4VaSp4J9QdiTZWpcIvi4fZlWJGD8JV2AP
         NbW3nRxiuv2u4czZLRdIVSaeK8scTq5LBLTEA8jthAG9td1RPL46tsXRpDigGLMrLPT4
         v8/CHH15PDilANNfhddl/gSnjQiAye9SX/z5IHcnItTzjLd2vJQze9jeix/12KEQ/Y+u
         uiGw==
X-Forwarded-Encrypted: i=1; AJvYcCUuq4ql4WN20xTgc4lgXPmSBw+gC6oRS/J6goOkVE50TSAPr8WvHKn5AkjmGGlTUsSLUlRSmHIjxO/lA3B5WwXsSO+Q2r7UzMyaVeJm
X-Gm-Message-State: AOJu0Yyjm/1XSz6OKtBkLxN6YnTAKKJ41Ju0ctpI2/ON8fyM9fsn7bzv
	pv7oyXSsylI3YtfElxDKIHmUVFaaGp94H9gbBuv2PD9bZGW2kfwANWlfpcG+dPkO+FRp7JpbJvl
	awAnBqXLAGJQ9ALKgSkN0tebhrZNV2dko
X-Google-Smtp-Source: AGHT+IG+/zAu1Dl8amLmFT3k5MgQYed9GX65bDZwnT0Z0B9g3f/kbACp5UVaG5InYsDTWEWboSye1VZzuu4pO9hKVeI=
X-Received: by 2002:a05:6102:38cd:b0:47e:f8c0:c453 with SMTP id
 ada2fe7eead31-48077e187e8mr21855823137.19.1715978682690; Fri, 17 May 2024
 13:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+isxCcxq3QLqmapcQwvZDYb-PL7FAi2cFMgFwXVNU2h7g@mail.gmail.com>
In-Reply-To: <CAHhAz+isxCcxq3QLqmapcQwvZDYb-PL7FAi2cFMgFwXVNU2h7g@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Fri, 17 May 2024 14:44:16 -0600
Message-ID: <CAJfuBxzV5YWOmhU6AdOJetERO0ySs+6GkYxcFjWQiH63_rsXcw@mail.gmail.com>
Subject: Re: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP Error
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:39=E2=80=AFAM Muni Sekhar <munisekharrms@gmail.com=
> wrote:
>
> Dear Linux Kernel Community,
>
> I am reaching out to seek assistance regarding the usage of spin locks
> in the Linux kernel and to address a recurring issue related to hard
> LOCKUP errors that I have encountered during testing.
>

build your kernel with LOCKDEP everything ?


> Recently, I developed a small kernel module that involves ISR handling
> and utilizes the spinlock_t primitive. In my module, I have employed
> spin locks both in process context using spin_lock() and spin_unlock()
> APIs, as well as in ISR context using spin_lock_irqsave() and
> spin_unlock_irqrestore() APIs.
>
> Here is a brief overview of how I have implemented spin locks in my modul=
e:
>

I certainly dont know whether the above and below are legal.
Id be comparing my usage to working examples from the source-code.

and you didnt say anything about your module or what it does.
(fwiw, you'd get more help if it were "our" module, ie gpl'd)



> However, during testing, I have encountered a scenario where a hard
> LOCKUP (NMI watchdog: Watchdog detected hard LOCKUP on cpu 2) error
> occurs, specifically when a process context code execution triggers
> the spin_lock() function and is preempted by an interrupt that enters
> the ISR context and encounters the spin_lock_irqsave() function. This
> situation leads to the CPU being stuck indefinitely.
>

Id build w/o watchdog, to see what else goes wrong.
2 different errors might help find common cause.



> My primary concern is to understand the appropriate usage of spin
> locks in both process and ISR contexts to avoid such hard LOCKUP
> errors. I am seeking clarification on the following points:
>

Documentation/locking/hwspinlock.rst

>     Is it safe to use spin_lock_irqsave() and spin_unlock_irqrestore()
> APIs in ISR context and spin_lock() and spin_unlock() APIs in process
> context simultaneously?
>     In scenarios where a process context code execution is preempted
> by an interrupt and enters ISR context, how should spin locks be used
> to prevent hard LOCKUP errors?
>     Are there any specific guidelines or best practices for using spin
> locks in scenarios involving both process and ISR contexts?
>
> I would greatly appreciate any insights, guidance, or suggestions from
> the experienced members of the Linux kernel community to help address
> this issue and ensure the correct and efficient usage of spin locks in
> my kernel module.
>
> Thank you very much for your time and assistance.
>
> --
> Thanks,
> Sekhar
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

