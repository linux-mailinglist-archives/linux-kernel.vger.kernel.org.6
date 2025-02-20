Return-Path: <linux-kernel+bounces-524936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23133A3E8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F81442234A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D9264FB4;
	Thu, 20 Feb 2025 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MT2iuLyb"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6911F4198
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095476; cv=none; b=eEaCRTIOyLg1tbh/D/SF4lwzJ+sP7/q3HmvBmHN6nk0MCVfPX/IlEAXVi0RhQH5t6Zebfo5NCPEV1FYy4v0y8l1A+VkU/IpRZkMrErUtvARMJeR0eZrFZjhODU4YLzNMUaX44XbFkoTUkIzywuRLJoGcayWDH3oScA0e8sptrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095476; c=relaxed/simple;
	bh=UdWhNOUBSdT4syJ+kosIuq0AfZUSJ0WGNQkI3p+ncvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI9dN44WnCO+t6vr+oiFSwYWVSBtB2JkF/cZc8UdsuR2IsLbmyNQsaYkIPqeHc+2Uh/K9BuYDcjvnxhC8bQSQqEAUq187xJbt5GHrSNZ9kZOWRT9vwZXuTnSjf+DBGa+0z/9Y391fK2S3Pqjq4pr8/DVOBJKwGRBDXotYQrpUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MT2iuLyb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54522e82e7dso3122e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740095472; x=1740700272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=MT2iuLybTjyviqAzrvIxqmMiPLvbkXrk4N1oUEoOL+Fyei3TQgLYJ9YqJqRbghecvQ
         phc+E+JImkcDnPP61dOv8zfPAYIjgsb++QvEC9kSkMQeO1cxWoIgSL/oQAmHTNvdfT8X
         TMPYlyCFItXE8+1CLJkZPFOkYXje+KY/FbZJMysx0Y3XuptfO4RfjsPvSIsgqHI45ZUJ
         pCnmZ16xxJqb+MG9BCPeqVNlNqWQC5rxeQOIG26hlaapubtoth6ItPskeeObEYwOaNm2
         Pb/Fs1aPCldgm9kJd1qMd7JZc8lokCYBXn3Eg18Sz204kS689YWr8HeUpd/rSUXPPb54
         NWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095472; x=1740700272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF2FkYUFOzGpOUac93fgsUwfXQ+Ch5dCBcOjNCGwr4o=;
        b=xI3yx8pGmD+7qX0xqSfSsI4+TSbIP2gTCt3FtUGiHO4oYHemG2co/r3j/m+k0TzPhp
         sCZfRtor0L4lzy1RiPFO2yLU4QumhImcR54dgULWoPgcfyFiTX5/dM8HYmpxXN7f/rKw
         YnPr9/C7QxIDqza2XQQ4kFCO3S+gxxaa61iSmgQ310IGvmKNVAqcoAO30dAu3nFRdRCI
         2bENM957mc0tgNMdtxiTOx5W6mt/HcvKpJpbA9przdWPGz1f5+8S5cXrLjIV1IsMFqDi
         iPP3B1vxJyuU7ZMUjQQGFZ/gDUYVuYUt69bYvFYOXMpE6rzVi3d4rUoL2Hvth7oMLdRC
         pTFA==
X-Forwarded-Encrypted: i=1; AJvYcCWb7Mc4rVUL3MEpI3llPg16MpxWc0qBodu5eoUfLQsvSKhFCQKe5jd2E09Sw5mvXlN0ELR2tXPQAnZ0uVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98NUh5N8tQvoP7uZgenmF2+u9xX25wvcKGVmK9OQcr59IdI+x
	wAyYEeo4v9MkHwn12Py13sJkClxmxRZDdYGWBZbehv9H11UxkHsEG/aXO3+lxbVqdmszlhXg7ck
	BpI3hFhojQ5QapWeJpPc8Cg4aXZZPCHglumKZ
X-Gm-Gg: ASbGnctiH94Gmxrg1fsxMz0s0TQUUU6/mQ54DlzdVKcWy6CeJ2bX8JRD8nFZ7Z+Baya
	7/cj8dEj8qcdZ3V0KXx6AqN+kiUjD9iUmYUlb7OspDn+3puB0Is9PumKO0CToPa1RFsODIJf6VA
	nCOZAf50owQwBIXHaj3K8t+UjG9U+O
X-Google-Smtp-Source: AGHT+IHNrahV1BDNb6HGmIpADFoAfSxQLvTQMK+ss0Zxtwi9sdNu6MrrXOWs+BR87xWGqTxyWHbSATFC1ErU9+Atf8g=
X-Received: by 2002:a05:6512:eaa:b0:543:e5ac:8ba9 with SMTP id
 2adb3069b0e04-5483912c478mr118346e87.6.1740095472207; Thu, 20 Feb 2025
 15:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-3-vannapurve@google.com> <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
In-Reply-To: <9053a4ef-2de6-47b4-a2f7-62d3ded24cfa@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:51:00 -0800
X-Gm-Features: AWEUYZnHtnB_aHba-KEBGxrwDPSTc-BtBIYPfsyILXR2O2qhE2mk2NxqrmEtVUY
Message-ID: <CAGtprH_z=4nsDj2GSnCrhwQkKESBqLTcUK3aNZO+2BzMc7P00g@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:00=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events.
>
> This isn't quite true. There's only one paravirt safe_halt() and it
> doesn't do HLT or STI.

pv_native_safe_halt() -> native_safe_halt() -> "sti; hlt".

>
> I think it's more true to say that "safe" halts are entered with IRQs
> disabled. They logically do the halt operation and then enable
> interrupts before returning.
>
> > So "sti;hlt" sequence needs to be replaced for TDX VMs with "TDCALL;
> > *_irq_enable()" to keep interrupts disabled during TDCALL execution.
> But this isn't new. TDX already tried to avoid "sti;hlt". It just
> screwed up the implementation.
>
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from using "sti;hlt". But it missed the
> > paravirt routine which can be reached like this as an example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> This, on the other hand, *is* important.
>
> > Modify tdx_safe_halt() to implement the sequence "TDCALL;
> > raw_local_irq_enable()" and invoke tdx_halt() from idle routine which j=
ust
> > executes TDCALL without toggling interrupt state. Introduce dependency
> > on CONFIG_PARAVIRT and override paravirt halt()/safe_halt() routines fo=
r
> > TDX VMs.
>
> This changelog glosses over one of the key points: Why *MUST* TDX use
> paravirt? It further confuses the reasoning by alluding to the idea that
> "Direct HLT instruction execution ... is routed to hypervisor via TDCALL"=
.
>
> It gives background and a solution, but it's not obvious what the
> problem is or how the solution _fixes_ the problem.
>
> What must TDX now depend on PARAVIRT?
>
> Why not just route the HLT to a TDXCALL via the #VE code?
>
>

Makes sense, I will update the commit message in the next version to
clearly answer these questions and address the above comments.

