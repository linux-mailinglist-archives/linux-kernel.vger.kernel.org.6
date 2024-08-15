Return-Path: <linux-kernel+bounces-287895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C94952DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31867281F33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FF17BEAB;
	Thu, 15 Aug 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z3+MH6Vv"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6517BEA0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723503; cv=none; b=XxFC667mi1/bfiXgYiCnIJJgGwsxuZmaMCWowh0S0P6JC66j6131xjUt4uOrevZFw9QNufQNH49iCSInWMiisNZ0KpwszQqsSF9kLZBAjMJFFoONlgYaLX8t36XrXmdBdT9ANkymzeWfvDUxD0WvOOJn9fIv7ttOGFyNw2FMAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723503; c=relaxed/simple;
	bh=iAsrpjKnTZv/D2VgeVVLyUmXKIurQQ0adhT8SEJIc3w=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX6MQWdilv/L1kOzlnwyJISjK9WMOCiRG3ZzuxPftui2qz9zrg0V070iSaCw/eAl4pk8xf1KNojzy4IJREpBfFbywcYb2v92/BfkQXsLMPFnJIzFQKGYEwRaVuJUbKyCX5SxFH0FRQlNC/MIy4D+MP7WqtBpFzMh69L7w7Ahtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z3+MH6Vv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 453AE3F1ED
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723723493;
	bh=7ZBFQryseJrs4bYfDgEEs/HpYyXTP2lyjLbjfwARrdw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Z3+MH6VvMQPmOWFzo4ZiLFBm6V6HZEo3W2hjlPkzfEr0vRsvK2ifsO9aCwmNS4ijK
	 DSHxPVgpJnwi/GfDP0IN0PKRunGDy61fgmV1tHTsCKT/PZxgYeyR2mrrwXNAlKbjEP
	 P8/xjpMMRTziIlPEYmwqRNuCwgfQh5CJNP9APZXW8k+UzGGtOsVTmIibqA0seamuUZ
	 TwLTR3R9TtEHz5NZOXYOnF64hwTcJn8TKLTIjUqKh7tZchFnOGFNeFJFTp/2uhP/nw
	 d9PBfTvpUjEApIYnt/BkdyWuL3TnpBrOPCaHml9YcEwi+XX+liBZ7QMUpwfgk5KJ95
	 xZ6Z1EWi33TZw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe32a1a4cso8875251cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723492; x=1724328292;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZBFQryseJrs4bYfDgEEs/HpYyXTP2lyjLbjfwARrdw=;
        b=MEDPLkngtAUh9OKtn9iqAD79aIqYHclodeFjP+kP56p0wRsYBrZvSfvwBc6L5GNWtn
         GtQal9upEzX12At99YKuqtEI3vzilsdgsi3Ct37BAWGVclzUhIBB2qCtuWccJ3y/sFiY
         OVG+CFE+c5R15//a6iOYDMtlXQ3/cPoAnFZVkzyT7UZ0N5al9GNi+0G52HBRVMHh2nhe
         ff/Cu80YYSA8BNB45OMOh2fVWoGq6mFE9wbXL/PILatYY4p6vTgaGse/8hNxJlfgnMbk
         IkuQRNlCQauJR88RnBObYeGK0CMJtOCCFDT/rlRTP83N2uMd5x9ay5NxMfUxWynCmEE2
         5N3w==
X-Forwarded-Encrypted: i=1; AJvYcCVYvMTd0JHMVVhCTVhMP4FYQFLWTa0+JGbrO1QyBwtdGKrvjpp7lHaPGiJjey5t2OdpJhNxC32XU0X5gaAa++vyuIr6/RirScEc//cx
X-Gm-Message-State: AOJu0YwxiNuyc6mISwrrqNZ1VxBr3n8YUArW2xAOxofQ3nc383LUzgZ8
	kOcDc9qd78DS1BtwGB4dibw63yMDzdk1wZ08w/qC0N2qn7xU9O2uaNepgiUIyZGxYgJwaqjs+/L
	U0RivDw36msa0PeeHkjpueIjoO9Nf0puyUf8hSIKcvDOxO20pJn1DEoiouNQbfFLImtfMyms/hm
	SWSD5ZLrb1oKFcvvL8NQTLVNmIoPziB12rTBC/QIsZtGqsOpnJyQwe
X-Received: by 2002:a05:622a:1f98:b0:44f:f06a:d6f5 with SMTP id d75a77b69052e-4535bb370dcmr69186581cf.36.1723723492107;
        Thu, 15 Aug 2024 05:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCrKqnX67yXWeSCk7DjtbJqRwQJAnNVtCSUPATh5Fgv3rkpF5FNHMjzutwyyeGqOQ3p5D88tr/8ufomoR/zBU=
X-Received: by 2002:a05:622a:1f98:b0:44f:f06a:d6f5 with SMTP id
 d75a77b69052e-4535bb370dcmr69186251cf.36.1723723491700; Thu, 15 Aug 2024
 05:04:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 05:04:51 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <87ttfmm2ns.ffs@tglx>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 05:04:51 -0700
Message-ID: <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 03:29, Emil Renner Berthing wrote:
> > Thomas Gleixner wrote:
> > Thanks for looking at this! Unfortunately the above patch isn't enough to fix
> > the issue:
> >
> > https://termbin.com/7sgc
> >
> > It still hangs after the "[    0.176451] cpuidle: using governor teo" message
> > until the watchdog reboots the systems.
>
> So what's puzzling is that there is a timer installed early on:
>
> [    0.000000] clocksource: riscv_clocksource: ....
>
> That same init function installs the per cpu riscv clockevent, so there
> should be a timer available.
>
> The deffered probing of the PLIC driver delays obviously the probing of
> the sun4i timer, but that should not matter when another timer is
> available. So the sun4i driver might be a red herring.
>
> Can you please add "ignore_loglevel initcall_debug" to the command line
> and provide the output of a booting and a failing kernel?

6.11-rc3 + these reverts:  https://termbin.com/q6wk
6.11-rc3 + Samuel's patch: https://termbin.com/7cgs

> And on the booting kernel please provide the output from:
>
> # cat /sys/devices/system/clockevents/clockevent0/current_device
> # cat /sys/devices/system/clockevents/broadcast/current_device
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource

On both a 6.8.6 kernel and 6.11-rc3 + reverts I get:

  # cat /sys/devices/system/clockevents/clockevent0/current_device
  sun4i_tick
  # cat /sys/devices/system/clockevents/broadcast/current_device
  riscv_timer_clockevent
  # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
  riscv_clocksource

/Emil

