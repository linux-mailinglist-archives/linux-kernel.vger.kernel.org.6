Return-Path: <linux-kernel+bounces-510199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B7A3199E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CB1167DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC41F8917;
	Tue, 11 Feb 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7TnGWFI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A211BC07A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317053; cv=none; b=TP6B9qSMtPtTZm35lhXRLBkJ335MHxSAC1bzzIB8JbTzXQyZIYTMkosCmBIf9tNHGDzf3k3KZfpk7PJWlRWilw7DbtZaMD4ucfc5x+naDX43s6NYVBzGiFbI6F8NLuaOV4kINL+4nvWxCn0jrftLzl12T1jBpUFwktRtZ0TIvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317053; c=relaxed/simple;
	bh=GutEcZz61gwify1yCL/KrmgOIzRRqXpILaGYVs/GWDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaRBITeZoAsQGYpEhP3ufoTTy8lJKcgMfndhj+zmwZ2ZWc1V/XaYqHAXrruwfQlT0X1GEvu//Qmt5+jiodf3qDcYWS1GXEYtvE8xJYtulGDjtBlu4Nx3Twjhp7vKTK/yrSi1MBP9caGZHj3OZ3Ik6PhwXYhmj9d8tgIb/Dyh99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7TnGWFI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545092d763cso1191e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739317050; x=1739921850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSbvnItNGBxBKAvRaSMscNhWBRYdPAos9+Z7zPAciRI=;
        b=t7TnGWFIsKD9+cVu+60fmwiER5C1RhRvkaZTXuXTWThSfLEGq5qUR1DbWezDV15rKK
         i/aHa6G0NphexjSj/yumK2LvzGNPA/UbQHLB76WJeOrIADvZtnXzEduQ3HaIJSl4wfoT
         QF/SIsrZ+MfZ9M9VWkGosuzPsAM+bb/UUaOSQKlkApjOIFz7S4ZCBAN1Lusj82sDz/ry
         DWgHOs9Shc71O+4QeF+DZ+5ahmk4a+MZP1SulGYgr5MKnYrSWZo+/n9UsIam7T3xEe6a
         aJ53JBryVHXe7JjGRCj4GdEuRYqghlsLM8qTgqEo0eXBp1nFTn/ALipsbDTDBZxXM7T9
         IocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739317050; x=1739921850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSbvnItNGBxBKAvRaSMscNhWBRYdPAos9+Z7zPAciRI=;
        b=p3UCMCQ74dOk+mfCe+mi8CzGh6f0rlF2nmTbFF+qom9mk8PxRNCwseUFY7bgZiCG/b
         2qeTdlVUnGPZdtcZaOm3t83uHnyAWlj1f8YI6IJ5E4zG6Rkwm5A1IDtU2W5j6lWALez5
         xR7j+JGAKEC36/OM46LY+Eb986yG4y4FSKmdp3b6xxC7pmG9IuXs34fwR1s7P8bLjyjY
         eo5ZSc5LUTE/SSqrxRshMUSLi5pyD2KntJ7nVSul4rRlqnNMLLOhyFq+nymHGeJ1tszt
         ZWtWeoMDFqejD+nRhMLbf1bTMnagdThHXJAVSXd3s2bEkgU69YmtTBnSJX/zfnsiotMJ
         VTGw==
X-Forwarded-Encrypted: i=1; AJvYcCWHm8j6EcHHBJrDOpzI3SZBoVfXAy/Ti3jPfFIHXcRfLU1sQ1RMZO04lVCVzteEFlUlJJymyP4hIuRYMoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWzXQCjIPoKcBKy5OTb6y5QbV/W0UUEMRWwhY4WiFHiHxXN+n
	EIab7oSGbeJxu/QpZkJuZSdypWHHz9lOiL8R3+w9dEx3JPAitg+3CZc+gvel9ykVIbT+thrOkgR
	wLLqXkq7/ufTlFcLvYP6/aaIo20pOGyoT6OfD
X-Gm-Gg: ASbGncvX/386iIzh9ZJfcAsh+6Wn8+IaufQDCslb+Fb72aYMgwJT0HGLMxLqEw/YmCH
	mxgg/KTJVd3Hp/Eo6ZCozLO05A/Q/YGpVtw1ve0IxNcEXzEVLZx0RN+lGUFvZ5y+9+ZD9druQR/
	rY04Y92wPPk8a0udY7RVDXlKU5rl2yIQ==
X-Google-Smtp-Source: AGHT+IFwqfZpukbm59rOXt6h263eOHCDjc136zYAOcXQHTigPOGAqt3tg2yJH93apvYN9rjDIs6HzHeYOQ9BeM6qfi4=
X-Received: by 2002:a05:6512:3d90:b0:545:34e:16c0 with SMTP id
 2adb3069b0e04-54518de9606mr38355e87.5.1739317050020; Tue, 11 Feb 2025
 15:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206222714.1079059-1-vannapurve@google.com> <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury>
In-Reply-To: <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 11 Feb 2025 15:37:17 -0800
X-Gm-Features: AWEUYZl70YOalrJ-dWWuIpBvrvuQpb_FScJ4zAQWzJRP5MMlca2CNQsA8FuLHfY
Message-ID: <CAGtprH9yekaDTCn0P83k221sW2DoXL5AwKLmD54Pv=PmUPU6Aw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	kirill@shutemov.name, dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Feb 06, 2025 at 10:27:12PM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events. So "sti;hlt" sequence needs =
to
> > be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from using "sti;hlt". But it missed the
> > paravirt routine which can be reached like this as an example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
> >
> > Modify tdx_safe_halt() to implement the sequence "TDCALL;
> > raw_local_irq_enable()" and invoke tdx_halt() from idle routine which j=
ust
> > executes TDCALL without changing state of interrupts.
> >
> > If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
> > executed from TDX VMs via paths like:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >       native_safe_halt()
> > There is a long term plan to fix these paths by carving out
> > irq.safe_halt() outside paravirt framework.
>
> I don't think it is acceptable to keep !PARAVIRT_XXL (read no-Xen) config
> broken.
>
> We need either move irq.safe_halt() out of PARAVIRT_XXL now or make
> non-paravirt arch_safe_halt() to use TDCALL. Or if we don't care about
> performance of !PARAVIRT_XXL config, special-case HLT in
> exc_virtualization_exception().

I will post v4 with the patch [1] move safe_halt/halt out of
PARAVIRT_XXL included as the next step.

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.ku=
ppuswamy@linux.intel.com/

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

