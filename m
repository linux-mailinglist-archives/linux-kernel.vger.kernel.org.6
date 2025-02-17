Return-Path: <linux-kernel+bounces-516980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A616BA37A87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EA316DDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFB1624D0;
	Mon, 17 Feb 2025 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GSjuBgeg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7642A96
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766379; cv=none; b=DUcq1WkqtEF8y6ot6YK7y9V7prmyuCDgt4m8H7Ip69A35gXY1hVZKHPkR2JbPVe6QmgQLhNZ6OIZH3IQgHFnrmmgUM1ZOJs5PdD+K2mxiWxF5yKUx1MgG1+aYvvydAsaC3OvZopxai4kEEW5uOwdXlfbasC05DTHffiWteaDVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766379; c=relaxed/simple;
	bh=vtNX/UFCEi6pYMVsqVg4FqhekriRTyUXH4F+kZ06Zmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVKc6ndWES+ncnpWlRYuSVo/xHhHIFnra1nxyyqE4KvXqknK4xsHiA3op8VN0mNZXLq3N9aKsY2rrfndY7akLqqnrsYuTBZtRZe/dog25ZOChgULAnSQi0iFihGK9gMwexbPKkMtETTdUw0mU3IK2vsKsOG6wQ4DHgq5npRlc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GSjuBgeg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb892fe379so146998466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739766375; x=1740371175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtNX/UFCEi6pYMVsqVg4FqhekriRTyUXH4F+kZ06Zmo=;
        b=GSjuBgeglg1trLNv4ealuQvB3p6rb+1RYMZoyxMmIMPO+Iz/aDclBJlldSMYnXtCgg
         /fj22dtjph4spAd7q2SX7qaJni8jsCPhEnTJ85KSjOKSsNGi7DcXeWE6T3ai/VmBO78A
         q+zkiP7AS8NKc3UB3Bvzd+lDF5spGZb5iHaKPYnwTF0YiCVCDNRj5fO2ESTHDge7CZuC
         pQbXSWZhHQgjUpTW+eQnwT+p9GEKLlE58oFaEq6FktE4lTLmllNkQVXKp+abBfibQ66n
         CzwbVQXLfki7K6Zj/TbjlmtoRb1gGZ+PhHmUHh02M7EDqPnn8DHpRW1i18Q6EAVqksOa
         l1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739766375; x=1740371175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtNX/UFCEi6pYMVsqVg4FqhekriRTyUXH4F+kZ06Zmo=;
        b=qEfxomVeGZOD2zgIEjJL0GQHwmm/U3Vgusb7zE+i666Z6RTPXyN5TV/6kiEoGZOOCF
         4blwbTttFvogWMAaUehr7bmU6dRImJntAgmQ7QoJpev2ldMyOEII5Xt1vbccVGnVR0Ra
         iQmn871Pu6UMOtCNUCKSgpThrMp5RyZJd3BaAV+tww+KNdlLL/7LKFhzhfaobCZZA0KI
         kbRHyavXkpRWnN0xbrRNucMYYs1vfMDCEiy/0RuLAAAkbO0vlm0+ylN82AS5MI72rV/n
         m/v5+bicMdoxNiEAUjr3QCbrdFQPeniCvFVYhNnTERcX7SEbQ3/X1URKZGz7ZfdPIV5d
         K3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNgUC5rpxEiq+OIdXlCjEPqBmtYrJRcex8kFy2DAZT+Gfe3kzpwiNnWo5IVsL3IE6pkEaA8CchfQ+q90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpY5OIebnz1P36ZH4Ud11c76OCsvNgcs2wea4OczKxtCM1VSm6
	txup4Spm0nbayIsNheC5fV3PC4oYcYbaTC12gUiB4g+UnmzA3m+kbAFB6p7TLL+XOug8yjMFxQG
	1vMvzKp2Zkcn4TlQBjwX9vD8eaE4BSbV3co+xfg==
X-Gm-Gg: ASbGnct/mfgg5k+VKmTaFC2m7DVhLxUbvnKqkxCf0uECuC0SA1KALqZ+U3fdzOwzs3t
	ZmX193WRrX2tsf17TI8QqkLPHwjQbqDVQnk5VTt+XzvRGDfQfV0JZUOHNk22QbOV1pVVnnt+XxA
	==
X-Google-Smtp-Source: AGHT+IGqR09ncd7RtDiYCHnqel0IwA8/KPIVmtCxbKbZIlJpbL6zVOLcVJ6dwuzAFLdjeOGKZ9qI9z1ate7AXjr0ds8=
X-Received: by 2002:a05:6402:5201:b0:5dc:d8d2:e38f with SMTP id
 4fb4d7f45d1cf-5e03618307amr20113776a12.31.1739766375048; Sun, 16 Feb 2025
 20:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209041655.331470-1-apatel@ventanamicro.com>
 <20250209041655.331470-2-apatel@ventanamicro.com> <87seoijb5q.ffs@tglx>
In-Reply-To: <87seoijb5q.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 17 Feb 2025 09:56:03 +0530
X-Gm-Features: AWEUYZnsLDuB-_3nJekaV0ZQ27JIbe7lpoXoicZXgPN5kJR_Ra7fWK8_x1q1rco
Message-ID: <CAK9=C2UyC1bOaRuvjUcZ=YWyOGhne8Yt5X7aYSAjQUPiUUUX5g@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] irqchip/riscv-imsic: Set irq_set_affinity for
 IMSIC base
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, 
	Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:42=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Feb 09 2025 at 09:46, Anup Patel wrote:
> > From: Andrew Jones <ajones@ventanamicro.com>
> >
> > Instead of using imsic_irq_set_affinity() for leaf MSI domains,
> > use imsic_irq_set_affinity() for the non-leaf IMSIC base domain
> > and use irq_chip_set_affinity_parent() for leaf MSI domains.
>
> This clearly lacks an explanation of the purpose/reason of this change.
>

Okay, I will improve the commit description in the next revision.

Thanks,
Anup

