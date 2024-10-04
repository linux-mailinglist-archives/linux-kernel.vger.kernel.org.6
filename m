Return-Path: <linux-kernel+bounces-349988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06198FE51
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E798F1C232B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F02B13B79F;
	Fri,  4 Oct 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBu8P6ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893781AB4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028800; cv=none; b=hNjf+aCbBS8nKSb1n0Wt5btjDu18k6GLCUXROuqGnqg2+wKPyWjr0/8H0486quFYYfpXQDLFIIbsJHr9hlSR/ezebBd9BhDZN+yuUid4+vR9Usod9YX+WVMa89EQFcVYYoRkledoozGlf5/tBqV2u7+qMpgwclVsG0Q/SeMcHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028800; c=relaxed/simple;
	bh=gH1EjjdQwsWfbG39xO0kyHoK76uYMvZ+CN2d9gfGXh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpnlnIBYYhy4ZW0UyKKrKDtE5OG8vw00+RQ90lcUiX3r1OJxSh0PyVSr2OoacjCZpPonXUCHZTyWS+K+zZgY/EKJTZvv58nZ0wy00jk+YdYOkdp6Smj9+S2vTRdAWrrIJMefizRTlUt1VYfv+wLkVgBBbZ6nmabwtcRok99HqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBu8P6ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9781AC4CECD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728028799;
	bh=gH1EjjdQwsWfbG39xO0kyHoK76uYMvZ+CN2d9gfGXh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBu8P6owkwszxxQfUfcfX6P2DMwZnCRKIb+n7VR5hdx294R7VlLYRx6yTB0MOhG0C
	 eKmRaNoFAfIHVKnTo55MtKlWnWammgHjXD/gSKBZGP647yXZLQPX/PgG0fb1OzqXi+
	 0JrcCi3KJTUH5UC6Bmo4rgaH42Ah3LwtAiJdPyMYUghDvrEh6zJr4bv2cEMZLEPYwN
	 vt1+4w0zJEeArcLFrbFRSOsBdlg1ANcXz+wL/pWBnuTMy3RQB2VhQEV3Q1DLKnIBa8
	 kfcKf1Dag3yqJFEURXOc0nMO77nF/wu2hal8nUOrOUu+b5f1CqhD1yWdV3CIPDxOd8
	 7mL/AJS1+g3UQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53991d05416so2247664e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:59:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEUYJnn6G6TWstQxfUCwyQ1ThE5075WYtW+LP+/cDAdtm+YBXhWse/GV7rqkKtTckFMse7cqzgZ3xErUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvAWwCViUgfoUty5+wCToh5/Wcnz4bp5DsaJAOwBh7+pZz89S
	anuu3RLqy2bReCzbuBwPUNV0gXXUsj5sq0kFUcCbXFLCT585MKE3gJi/D+rZ09RU1zzpfQMk7gw
	YtizooJTjGPU8J0/IEZslho66hOM=
X-Google-Smtp-Source: AGHT+IFRExm09fKU0AOXfAlg/Zx6Iocw73831/ez4boxd2aW2dvjCn0rrirEyku4XkPTVrRthWeux/Sjz1I2+RPl6S4=
X-Received: by 2002:a05:6512:3ba4:b0:536:a695:9414 with SMTP id
 2adb3069b0e04-539ab84e6e1mr1796554e87.6.1728028797824; Fri, 04 Oct 2024
 00:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
 <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com> <20241004072847.zihm6dw7y5m4e2lb@treble>
In-Reply-To: <20241004072847.zihm6dw7y5m4e2lb@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Oct 2024 09:59:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQAQwcRFnhiFPySmMEruJPc1gSvWr-1ui-qaiNBV4ZNw@mail.gmail.com>
Message-ID: <CAMj1kXHQAQwcRFnhiFPySmMEruJPc1gSvWr-1ui-qaiNBV4ZNw@mail.gmail.com>
Subject: Re: [PATCH] objtool: Detect non-relocated text references
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 09:28, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, Oct 04, 2024 at 08:54:16AM +0200, Ard Biesheuvel wrote:
> > On Fri, 4 Oct 2024 at 02:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > However there are some "lea xxx(%rip)" cases which don't use relocations
> > > because they're referencing code in the same translation unit.
> >
> > input section
>
> "in the same translation unit and section" ?
>

Yeah, something like that. The point is really that the only way we
might end up in this case is when the LEA offset is known at assembly
time.

> > > However if we enable -fpie, the compiler would start generating them and
> > > there would definitely be bugs in the IBT sealing.
> > >
> >
> > -fpie is guaranteed to break things, but even without it, Clang may
> > issue RIP-relative LEA instructions (or LLD when it performs
> > relaxations), so this is definitely worth addressing even if we don't
> > enable -fpie.
>
> I haven't seen this with Clang either.  Also, objtool runs before the
> linker so LLD relaxations shouldn't matter.
>

Fair enough.

