Return-Path: <linux-kernel+bounces-221556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F890F56F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E189A1F221CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD2156243;
	Wed, 19 Jun 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L1840z5S"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142C15099A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819223; cv=none; b=ZStBNiEsXZ23S1zwkuKiAFZQg/9kbU+phonOU2d/dmWCzgOBI0fv+W5VFV9Lk5GpBc7ujdu2rOo97VFwdgLUiqp4MOXPcxoACFd/IIxrOFEALu1qehDiKgcHr+dGF6f3O/pdfGiRTTzq+VkpAGfNaYG6ZQ8/DG48EJvnXIduqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819223; c=relaxed/simple;
	bh=7dKHhsWrdXGUj9CUjBKpNYM5hOCQBSvW71NJlWmtlYo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejVmru1tJVT09iG3W/8DNGR5dVI7ZCZAriPTh86Jbc/wrNl2x6NLoIzZ+1I/m6pWLAH8SXwMKlVrAWJ/vjslFbvExBQE8zaGhZO5+48oqDPUeUY3uP1uK6iftq1utSWS7J9YDEOJs4yZpp0Ug+P76V643s3K/MomvzS8n/f5R5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L1840z5S; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ABC213F724
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718819213;
	bh=IHT5FlBGHX8BcDz3usrcaubsAD5+eJT9hDJvn3YQ/tg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L1840z5SfzOUVpq+Ezq21xEnWsqMqpoy/H53tYwXWbjnHXdDexztKffb2CLGgUuSu
	 tFQQP9W/cZcO+K6tJaT0KxBJVd66k63V6RgORPO1mY4zLmy/WAeSNUTvwsBILh29En
	 avZdpvWHLNlg9AbbcJiXkL8Jl+wq3O0swTSyivbFoRsO013rxWNU+fDOoAX1KYIJIR
	 w8jq8NBlaDBQM7j4WasR8XI6WKSIG8c//k0ogAN/Ovid8I1sVAYTR2uaEv77FzgqZi
	 pMvk0LNCB4lmisc29txler0psmEcaHD7z9zMICuzT6+z6BI+7y5LAuZH6vOCBxofAV
	 HDg6b0Gk/xkwA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4411f4617d9so75783851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819212; x=1719424012;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHT5FlBGHX8BcDz3usrcaubsAD5+eJT9hDJvn3YQ/tg=;
        b=DxSrX4clga3H7c7+bgeejYdy51kQET56SOHBflC9Rb5CgdVVG784ZovliI1lIKJI4m
         0U2rlQgEw0Ow6hwVVtVsSx/RZespRzhWhcA6vWTVAx+HTrdDEipLX2nQn8j+CX43dEDG
         RASkseTEABd8AMeiITsnZyTnwpfm/KteKb6xCj0wsWgs4sDw6LeWrx70pRof2wdiB6aU
         NX8OhXdxETKejniIrJskuifwgsvFLd+6wncAX4hIGrR9hlJm6kDx1thxvGRWSx5uGK26
         KcDbuT858I7R6oRaHoghmp7g9Nu7aQli1H9+G5v+OjfFsQzUN+07+d6pibZ1V7xIHkRs
         fhQA==
X-Forwarded-Encrypted: i=1; AJvYcCWB/RfGJYF+dYQ5/zfgF2uQfxchq8fPCQIWGNOA1kmUCZAMrSIPRH4aeln5RgyAkDtfq478sfXiqQQyDaWb1zDiFS8DBC0aTk0rD5p9
X-Gm-Message-State: AOJu0YxAqxJjxUSB4e4CNlEjhxMdRvB+QARwXS8MRacJY0nBYJbiYwlP
	d95U/96VhQkp9FcTI3ANE9orxUBGzPmCrLUHE88pBjWkutzRk9kcuUY4Nzay24zadm4s/0L6SBf
	oBXaELyGOQrZ5ba5c3m/N4RwflmhhDFe0AHsUsaEYUI3wR9dKJEe+MUQ0fovlaRwEFegHcdbLiW
	biks3WsjmHuVJB1ExVRnkzuhq8479vP3H39WpCnoVh1ETUaTMnz0PR
X-Received: by 2002:a05:622a:2a0e:b0:444:b33b:f64d with SMTP id d75a77b69052e-444b33bff32mr9783191cf.46.1718819212428;
        Wed, 19 Jun 2024 10:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF95k2RvsNdi+fcZdUd49VFCJUgO12myNtpWdozPj6zXj+cU0eJTQB6VEWAjg1+fxFJrgsQuA6Wpy9JkVGnUFc=
X-Received: by 2002:a05:622a:2a0e:b0:444:b33b:f64d with SMTP id
 d75a77b69052e-444b33bff32mr9783031cf.46.1718819212115; Wed, 19 Jun 2024
 10:46:52 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Jun 2024 13:46:51 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
 <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 19 Jun 2024 13:46:51 -0400
Message-ID: <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Anup Patel <apatel@ventanamicro.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Anup Patel wrote:
> On Tue, Jun 18, 2024 at 7:00=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Anup Patel wrote:
> > > The PLIC driver does not require very early initialization so convert
> > > it into a platform driver.
> > >
> > > After conversion, the PLIC driver is probed after CPUs are brought-up
> > > so setup cpuhp state after context handler of all online CPUs are
> > > initialized otherwise PLIC driver crashes for platforms with multiple
> > > PLIC instances.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > Hi Anup,
> >
> > Sorry for the late reply to the mailing list, but ever since 6.9 where =
this was
> > applied my Allwinner D1 based boards no longer boot. This is the log of=
 my
> > LicheeRV Dock booting plain 6.10-rc4, locking up and then rebooting due=
 to the
> > the watchdog timing out:
> >
> > https://pastebin.com/raw/nsbzgEKW
> >
> > On 6.10-rc4 I can bring the same board to boot by reverting this patch =
and all
> > patches building on it. Eg.:
> >
> >   git revert e306a894bd51 a7fb69ffd7ce abb720579490 \
> >              956521064780 a15587277a24 6c725f33d67b \
> >              b68d0ff529a9 25d862e183d4 8ec99b033147
>
> Does your board boot with only SBI timer driver enabled ?

I'm not 100% sure this is what you mean, but with this change I can disable
CONFIG_SUN4I_TIMER:

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index f51bb24bc84c..0143545348eb 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -39,7 +39,6 @@ config ARCH_SUNXI
        bool "Allwinner sun20i SoCs"
        depends on MMU && !XIP_KERNEL
        select ERRATA_THEAD
-       select SUN4I_TIMER
        help
          This enables support for Allwinner sun20i platform hardware,
          including boards based on the D1 and D1s SoCs.


But unfortunately the board still doesn't boot:
https://pastebin.com/raw/AwRxcfeu

/Emil

