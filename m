Return-Path: <linux-kernel+bounces-238265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583809247A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5341F22A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202C1CCCA7;
	Tue,  2 Jul 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhC4gmgC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5F481D0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946544; cv=none; b=UPjFKJlp6NRTW6bYUF6AX2MCBdInlGUy/GamorhNXldCX9UgT75Om5hvZL5amTrcPqb9DuHnOhesWVqHv2tVpW+5+ZdjaQ9sENzv0ZhEc99v0P6UIhFvpSD+Pqq3BUtSPnF+Er1qv/pkteVlPhjD6PLr22a4XuGygCE6B1ANJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946544; c=relaxed/simple;
	bh=VHQDmH8SsJUyNwP4grJbVP//d5gH37ksxqZPODeqm44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDejVomXp/T4EhQrOpmxEOGA1fEXTZM3MxqTQmT6m7A7mEUV5wLm/cNXOCYxKc+SLsJHCuPwAXjVKTkx8lxGXrWh9fLEgpzXf3OWs1RiCh68nKJhvpoG0UieT1HEK4oglc92IJsQdu1uuwrg53daED065M2UJjErSaibAnoTZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhC4gmgC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58bac81f341so1059329a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719946541; x=1720551341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN1U9vxr20829AjhJZIMvx8ur+LMDGCD9A9bJO/P0+s=;
        b=fhC4gmgCckyoMKrspIkloqxLTjfdhwrRjTWo6Z1e7wX15CwbKozmyksW6NBBHYVAU/
         4JgifzTWMW3awBuHG+mFy0vKRn+366G35W2l2yPSI+XzsSiDHJ1B3Ggrd4iXOQDkvDn1
         J433iKnNocJaaeg49vv0xVZudZA5t8alhJMo187LCjg/ZUjn1edcUNmRm+JiVHnjo3zW
         Y9p+ZalznQ3kZ5fxes3HeFt+OVWDIHri2ecNgmnZmZAyID5ZI/WBDgSuqwUj5R+B8s1f
         hdqkgGaI+ned0G5snVr3XACf5RFKMU24EGXVf3iG6Oc8498fpIALOZSD+ILNZBdwGvXy
         xgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946541; x=1720551341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN1U9vxr20829AjhJZIMvx8ur+LMDGCD9A9bJO/P0+s=;
        b=C24nQr8JTucp5jAGo3+0B9b5Tq+TR7EMCh6AOsWPx2E3TFom9rXk7U9Gw03WGrRp07
         8AvnCNvKCq/ULqq4qTOKlmgEl4qfIoRMrleGgVe4oKI9o2rx+9RTMs0VdPCaLes4m7qG
         KPc1kj/RE4pnERMJYP8QLLcfLdquVOYQhzXn7g/UvNUFiVFPPXyWaOS3C/FhcMNB7Oty
         8eH3CfDQtXHwf5bnIrWUW3si7v/L0AuqmjSddj5GorBWJeyvKElZaqrHa6LSC0xvICpm
         x8wZgihSS4qYtXQbpjvYWAtMmLROuaLAOAcFnIUD7XdypalVjNqa/MHu6KUGFcOmiaFi
         ThqA==
X-Forwarded-Encrypted: i=1; AJvYcCX87KHiYT4y4ra1+b1GSWIfFGZKx8iwNaf4TW2jf+awQSq5fFhMC6aQK+XmMKONkAj1h6KjfKT1wuNul2w/tcr+fUHRKpe06PdgcLOD
X-Gm-Message-State: AOJu0Yyjoah+aNekwKas+JhdUAs5e9ZPY2e5mEu5Cp5X9axgb9rinqFT
	PGv5cG3CijLmA8qV1mqt6H0Q7Ko5bteTTjMrygeba5uhnnX+JTxtKjISlIZQlucrBqjKFzrB98G
	0oQiBGNrZpusvvhYJmDAtVw599A+EDdcUHZFU
X-Google-Smtp-Source: AGHT+IE9/j59ePHsIE7wROexb2r7j2+PVDNkibAeLARQjWi3O8iWwuHamyAydSfc2QE7vUP1IXfFrbc67BULZGXTcBI=
X-Received: by 2002:a17:906:3185:b0:a6f:1590:ab06 with SMTP id
 a640c23a62f3a-a7514430d69mr573632566b.31.1719946540767; Tue, 02 Jul 2024
 11:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com>
 <20240702103628.61879ef17b9b01305515c634@linux-foundation.org>
 <CAJD7tkb7=sBdxXTmcqxe3+UWsTT7R6-rKGBhkEfgEAdTY+5jCw@mail.gmail.com>
 <20240702113554.2471f000055f3c717fced4f5@linux-foundation.org> <9c8a139e-9e20-4f39-b750-fa390a8a745a@intel.com>
In-Reply-To: <9c8a139e-9e20-4f39-b750-fa390a8a745a@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 2 Jul 2024 11:55:02 -0700
Message-ID: <CAJD7tka+=v2rSjWgs8zcNg2rQwgxg8V1m-nA-mxXdox=WoARXg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] x86/mm: LAM fixups and cleanups
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:38=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 7/2/24 11:35, Andrew Morton wrote:
> > But when people run older (or current) kernels on newer hardware, they
> > will hit this.  So a backport to cover 82721d8b25d7 ("x86/mm: Handle
> > LAM on context switch") is needed.
> >
> > The series doesn't seem to be getting much traction so I can add it to
> > mm.git's mm-unstable branch for wider testing, but it's clearly an x86
> > tree thing.
>
> I was really hoping Andy L would look at this since he suggested this
> whole thing really.
>
> I completely agree that this needs some wider testing.  How about I pull
> it into x86/mm so it gets some linux-next testing instead of having it
> in mm-unstable?  Maybe it'll also attract Andy's attention once it's in
> there.

That would be great. Thanks Dave!

