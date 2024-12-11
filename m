Return-Path: <linux-kernel+bounces-441464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B129ECEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A32616B4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FA188583;
	Wed, 11 Dec 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okDG0J9h"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225217736
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927501; cv=none; b=fYFHfdav3mMNunCLSF9YsPZs6kdw1Q3lNA/0QyuKIMLlbyHFFxIrbcM8WOSNuRNpd3gD8otoHJ8NEFo93feU5T7XcER6706pJI9QxjZ3ZUisD+Sqiqjw3TJsYBCm0VCYbUWjxu52t/l7Jwr31VYxBdXxJUBXSiLX/gFXLeS2AOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927501; c=relaxed/simple;
	bh=6MstwZEDzmfmfSlqeYA+EvXsVRXXP3jiezLL4oDN1/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfkeALMBJDsdUFhRugESbJbu4MyaxyP7wkFfFo0pY6RKfwsj1ZD9xGaVlRPHnvtrN4V1Vdwm9KROVHLRYvD5TGJjCoF26p3lA8WG/lVpOQwR2rOpH7O/c7aLC+Z/1b0mz0MPElr7a49c1WnOWVETuKy8N6Pm7hPLJGqnBOciVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okDG0J9h; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401c52000fso3384952e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733927497; x=1734532297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joWVG6YN6QwtMFozXajr6ob38hx5tuGFB2YqQJWxAV8=;
        b=okDG0J9h+GUQCa2yMvVwm1l7Ki01aCLTLF11MY2wD+Mc6rjns2xGm4dCpK9dmAxrsV
         AAne91oiXMkG+cEYGaJpfDqgQFzYYy1Mrc1TUZpM7nVQIFK56IJoZ9vnFOccSksPQdg9
         gAuVWRVbjiSbNB3sO9uKPfi7g8y+jxGVchT1IXoaIy+o8HpFAlc3ySKague/UHOqyCb7
         CuqJOLLCca2pesWYpGZejOtcjMg8WO5Z8TjBVPr0hYch9tivLk4EF4tVFzCS4L4eQHTi
         VvAJYHl0ZjO2psus9fhtLiSI/oPFY9pLOvzbKN+ri3nqd0/wtCp9ukZXuiUALrW/K2Ne
         ih0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733927497; x=1734532297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joWVG6YN6QwtMFozXajr6ob38hx5tuGFB2YqQJWxAV8=;
        b=Vd3jtjOvPGet53EmmzCn1Lkb9p/IVqOi/DSM2l3sdg/76x56pds8hZfgLalhuMUSgf
         WVWypWqPwDp9IbnfJ7knpclbj7a7s3s+XeAYwOED50wZMHhVzUIv78UPpxtfYzSxSKQL
         nDXlsI/AnQ4vA2ycKefxINvc/3wcGTw0/M336Z/fTEsgOMlwbJPkaJzVMeFqvSpkrSI1
         6rX+jyYZLD3BUuWqY9s2qM7Eu58viyg3sevknchnUy9Xbie8/787yh4euumoToSLJcBM
         wrmZATQ/WJ1gUmb1ulmtvlyua5aDUlBDSG9ytZRw7jh1fsVYkqT405gYKf2gWjFtS5zT
         ifgw==
X-Forwarded-Encrypted: i=1; AJvYcCWHp8L/aLafwaM1rGwYDGtSToREgO3THoC6OQJzlplOacBhEpvXAADL762upKSoc8CG1YYSppKBtMh+eDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xMWWlESfTd99vAgig6kS66qpD5AxWOU0bpWBnRTfPZwhv45M
	b+0rnDj23sFUOXtKIsbxkJcOyCKAYaSlaUU3nSHvezZUEG7ZVMgd8ztjgM13lbm7Z3dIj68yUkx
	vrQrw1zi6i1HkfuxDZt5VcPUukmlRVQwPM8awuQ==
X-Gm-Gg: ASbGncum82qG17pr3pg+W+lPJbDLDB8eTXFB5eoF23/NRDLbvYrl6EKmjWBUCVn7jhD
	A16FPmFLdb0GX5Yek8nQrWk34lpit9GeJhg==
X-Google-Smtp-Source: AGHT+IHhJBv1eQWShQpfw9LCRRpH2r8wN7wS8bE66kjHN+lCkD0sEsOjQXTbJhT/aLj/ehPesnm+dGREvL7jpex48dI=
X-Received: by 2002:a05:6512:1592:b0:53f:22f5:afdb with SMTP id
 2adb3069b0e04-5402a6055f8mr981790e87.35.1733927497423; Wed, 11 Dec 2024
 06:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-4-arnd@kernel.org>
 <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com> <Z1mYufbtXpeEwTAq@shell.armlinux.org.uk>
In-Reply-To: <Z1mYufbtXpeEwTAq@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 15:31:26 +0100
Message-ID: <CACRpkdb0g4zGQ-xu3yW=rRmz0zOVYnr-c-KaTSr155YvbrAv8A@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:51=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Wed, Dec 11, 2024 at 02:32:51PM +0100, Linus Walleij wrote:
> > On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> > > support. At the time it made sense, as the CONFIG_ARM_LPAE option all=
owed
> > > systems with 16GB of memory that made lowmem a particularly scarce
> > > resource, and the HIGHPTE implementation gave feature parity with 32-=
bit
> > > x86 and frv machines.
> > >
> > > Since Arm is the last architecture remaining that uses this, and almo=
st
> > > no 32-bit machines support more than 4GB of RAM, the cost of continui=
ng
> > > to maintain HIGHPTE seems unjustified, so remove it here to allow
> > > simplifying the generic page table handling.
> > >
> > > Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kern=
el.org/T/#u
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I'm in favor of this if the x86 patch goes in. We need to get rid
> > of highmem anyway and this will need to happen sooner or later
> > either way.
>
> Well... I use highmem routinely.

Oh I don't mean we should get rid of it without any replacement. Certainly
systems with big physical memories need to be usable.

I am pursuing two ideas (inspired by Arnd and MM people):

1. The easy option - "densemem", on systems with a "hole" in the physical
    memory making the 1:1 linear phys-to-virt map run out too soon and
    overconsume virual memory, actually collect the physical memory on low
    virtual addresses by elaborate phys-to-virt virt-to-phys and page
    numbering that isn't 1:1.

2. The hard option - 4G-by-4G splitting, making the kernel and userspace
    virtual memory spaces separate as it is in hardware on S/390, so the
    kernel can use a while 4G of memory for its needs. I banged my head
    against this a fair amount of time, so I might be incompetent to do it,
    but I still try.

Yours,
Linus Walleij

