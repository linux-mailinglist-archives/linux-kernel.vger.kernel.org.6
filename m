Return-Path: <linux-kernel+bounces-287799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B067952CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F3AB25E20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BC17BEC2;
	Thu, 15 Aug 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sDCBaWAV"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7C1BE87A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717805; cv=none; b=STTpBBVutUNzDXWGu/KjXEtXruEMcKmu57LfpdGOrpSCayYBpLxxa5vJBflAqFSZcGWr/V6d3ESyodSKkpDOmvq8oKOaHBs10EiR8sdcTmSfqkzzUfwGinu4+dPnq09GQ+SbpEEUR2yfqfkh33atMeKQMCBo9c0hxesO4G5qUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717805; c=relaxed/simple;
	bh=rJE/B7yKbXTMm+3QbkhLssisrBfOy+6TS2EytP+cito=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABdeV35EFAol+TBb8qjhkM6A8BVtl6nM96ARc1yoD5XOh49Zhm3FondBaE2gZ8QTeDtSBzrUZeE8nIGglVYmDHPB+ned8O8ZqhSgQbaMcCAl9Svw53NNl2Pwb8p9XwO/LZzGV0D4bZCscnwwIKC1cJe+WA5KmwEgrM1OECJOW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sDCBaWAV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 262B03F1F1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723717798;
	bh=3xaxNhe1FqV8WHQsaw+Wa818Bwsy57jjLMJR4J0o3wQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sDCBaWAVq+7X1D5pc4fxty5+DdHQfbtwrvKpFRFi9QttGNfG6fhEgKkuAnVyHYvRy
	 KUoWvPmNMIX1dR8Mk6PCoFkNuqJEkyasAh37copyp5Anhl87Z4JDvHFWpaLE4uij7o
	 TXFARWJs5IUGi3zxMIbU6wdGlDrLTYH/3BTiLNwxHM9A/qdQ1d26OwOIRqWoTmpCeK
	 oPzJhFQP0VwMverq+Zvo9ZE1nPHJnxQ6QXkHtzKVZ5o9bnuLYQX0K1RR5CuZvpjt4U
	 zzYOp/odRBq7Vyi3t5mdW1rI06yM9mHVqNyEv1Mcc7VwrIFctdhmNhPIaaSfThU15g
	 SDQJ6fWmiKvVA==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4f5d3a84330so282035e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717797; x=1724322597;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xaxNhe1FqV8WHQsaw+Wa818Bwsy57jjLMJR4J0o3wQ=;
        b=eLIc+M5YKoOJCR/FB7IHc5zSLPq+7Z74ly4gtrjZ43rvx1Hzep84jr1bi4wAQZDKMv
         OspYdf2e+TB+ceLUwQ6gD5bf04TkCHF6JMjmWpvi4qT/ynruuI2/t3pfVpiXhLmuVOXa
         0qz2RCTbtBSp5m28aN1SpBa2QHaxtYCd2MRrwutmCxm/W7YNppUkQd9uceS+fxWa+sAQ
         Um1n2AGJUTfnMBu05s+GBljbP5nLlCwztDmMyMBw2v8/KRfHYeTwRZnR4DdmZow05l7u
         LO5DRsHQc4f75wCgawwHAgI7669YFanGOvGi/QWRTcYd6+dUVqt30SL7rzxzoHEXTMTl
         vNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+XxqErC3TjoXgrddhStg25DGM40NbRxX2ps/Y/IZx6+hhlZKFaPqpgT72FYU/MmeOJ0ywS4ZPmjCQJqIUSBNLPFPF9prvKeiF007r
X-Gm-Message-State: AOJu0YxrUoQoGdhArWptxVzccJUe1vhy3PZD6/EjYImrFUa4YIGYsyxB
	HwMSmS7oDXwiI+8f57Nh3yqkwIOURRHJlkhimV778+9jO+J2KqdMFeBf1eI/diobnAAyv1pCdBJ
	Tt2acCa9bAPSIhbU/9JJy9Pr6ST7Gbus9CPcb8GYvZfWNqnV9eBlzGcqZFfMFH/JhBKtQWuk+8T
	qe6l82wclRDkLGVpy8Y5a3pcw97Bu5gZvSxNQ+kjjhGv5Pj6jIoI41/qjsV8I1
X-Received: by 2002:a05:6122:2a42:b0:4f5:26df:690c with SMTP id 71dfb90a1353d-4fad2337764mr6784886e0c.12.1723717796807;
        Thu, 15 Aug 2024 03:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGbkgj1Ik7pHRKdoLY3IN9m4oes3YiWU6MuLMMuW/zMuvzd5NfyPIy7S7pQruSLB4yXpDd+rhID9Ek2/6S04k=
X-Received: by 2002:a05:6122:2a42:b0:4f5:26df:690c with SMTP id
 71dfb90a1353d-4fad2337764mr6784856e0c.12.1723717796323; Thu, 15 Aug 2024
 03:29:56 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 03:29:55 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <87jzgjnh9z.ffs@tglx>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com> <87jzgjnh9z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 03:29:55 -0700
Message-ID: <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Thomas Gleixner wrote:
> On Wed, Aug 14 2024 at 16:56, Emil Renner Berthing wrote:
> > As described in the thread below[1] I haven't been able to boot my
> > boards based on the Allwinner D1 SoC since 6.9 where you converted the
> > SiFive PLIC driver to a platform driver.
> >
> > This is clearly a regression and there haven't really been much progress
> > on fixing the issue since then, so here is the revert that fixes it.
> >
> > If no other fix is found before 6.11 I suggest we apply this.
>
> So this mess has been ignored for two month now?
>
> From the pastebin in the initial report:
>
> [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
> [    0.000000] Failed to map interrupt for /soc/timer@2050000
> [    0.000000] Failed to initialize '/soc/timer@2050000': -22
>
> This comes back with -EINVAL. So the timer cannot find an interrupt,
> which makes it pretty obvious why the system stops to boot, unless there
> is some other timer available.
>
> This is obviously related to the SUN4I_TIMER because that message went
> away when it was disabled according to the next pastebin.
>
> Obviously that can't work because the SUN4I timer driver is using
> timer_of_init() which cannot handle deferred probing.
>
> Daniel: There was a partial fix for the sun4i driver, which you said you
> applied:
>
>   https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sifive.com
>
> But that thing never materialized in a pull request.
>
> And of course everyone involved ignored the problem since March 13th
> 2024, i.e. almost half a year.
>
> Seriously?
>
> Can you RISCV folks get your act together and ensure to fix things you
> broke on the way? Especially when Emil reported this nobody pointed him
> to this patch and nobody noticed that it's still not merged?
>
> It took me less than 15 minutes to find that patch and the correlation,
> but this is absolutely not my job.
>
> I'm seriously grumpy about that. This is not how it works. If you break
> stuff, then you take care to fix it before you shove more changes into
> the tree and waste my time.
>
> I'm very much inclined to take the reverts right now, send them to Linus
> for -rc5 tagged with cc: stable and ignore/nak any irqchip related riscv
> patches until the next merge window is over.
>
> Emil, can you give that sun4i fix a test ride please?

Hi Thomas,

Thanks for looking at this! Unfortunately the above patch isn't enough to fix
the issue:

https://termbin.com/7sgc

It still hangs after the "[    0.176451] cpuidle: using governor teo" message
until the watchdog reboots the systems.

/Emil

