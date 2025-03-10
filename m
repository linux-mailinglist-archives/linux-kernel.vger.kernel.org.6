Return-Path: <linux-kernel+bounces-555059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107AA5A508
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214EB3ACCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AD1DED55;
	Mon, 10 Mar 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT5afIvI"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA311C5D40
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638958; cv=none; b=MURTVDHxi2XivLdoUs/Fn15U3nHOFmmw5tMi4c8QiiG1U3iMhsBGNJfRt8/9moEB3lTKpg3YFT9797AMpa/hTE91dgGpga4afZW6BlNakgB6SJ13ZKNOKtiPui0gofJDd3dmqGFtA9xVyJljtVrVn1PZPUn7baN4Ic/DBGA+Zgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638958; c=relaxed/simple;
	bh=MPmy86oHDDI8c0BY/siddE35Y0crGXJzQ14E3jr6UKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grGJWBAHYv3KHFSRTuZp1IEkEWZSRbMXLobgA10n5ElaW7LBS8VXIRspczOx+D6/u7wDdpuXRGlIjtmIJPRMPfnKaHwY2JRK1qxwBTE9QX3iaw5Y1/HlTbC7506NndSeaQ+IjAqlWqJr7PS1iXrrrLnEQ6n4pau/IO2AXakdDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT5afIvI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so35642881fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741638954; x=1742243754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPmy86oHDDI8c0BY/siddE35Y0crGXJzQ14E3jr6UKc=;
        b=XT5afIvIKKVw/p1eVdNIrEKiBBLismZQzCBg3mezaRCJgi8vqksgNfrOnGUF/wQZFn
         nUBNCYaHR4bMlgmH6x+RpvOWg8wEbgV5cBprEZ/43kx3NvjORyuqkKiMHhLo+mtoHUjM
         K/tim3OCb++YakkooUf9e3jdSLkoXWwyqduB4bI6qNsjJJpoF8KymEWwZJbst1YJ6sxe
         BDn3XNsofouY0g9zV+lxCaJx4Mf7pwkRWJQDbBCWTvik0jz20DJrs3Zv1NdT4VZPEILj
         xzuU3bL9gwB0WfrhVFJ+sLb5QpUPd4Az5VjaDxyuVLmbJJOvCEZO00uZRJXPyNvo7E+t
         Xa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638954; x=1742243754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPmy86oHDDI8c0BY/siddE35Y0crGXJzQ14E3jr6UKc=;
        b=Cf8uG5fVN5hnvRF+2qUCkpVDhGv5baXZxhJky5ZpnPzXeSPtYTqwcybNqNhF2vJ4pw
         MZgeH0nauAkWPJYR5TNotFKKG50EpS6s4mNwFR1o/IqV1QiK7zigOS6ZCqiLblzedMF7
         Swip2pFmMEwk97feWRJVWKE1QW3uXyCEejrhXojUJKw2FMVaU9qPOhXx6UYdv3udt05H
         bR7uFdTeFH59pG038FpmvK4f2eIDSr5cs0MvhLGzk/0yG6bx/jbDcM6d/PEhV/SMADA0
         iQaGxy2Yk3J5f0LbXyxcQW+FJw/oww5Dx+mm4hYzXkQ5h2pWbPCZJ9gTQ3ghd3ccv7xf
         lEow==
X-Forwarded-Encrypted: i=1; AJvYcCW56wxhNwtMiONhanWRshauPzdqnsbkaHk52xxMb+vciea6i8/hgxdYeAKTOZRe7zX48mQ+KVOowRlar+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0QmJ6goPGLTtuXqj7udkmr7jSsJzg3IkLKKp7Th6iPZyFkYp
	OjldYenDyDYdLmwXA0kUW6OCMLqae/PxjGThYu3bky6f5p5g8fqdR0MdPN66FIWGzeo/ztPrd4s
	Iz3FqJJNVaBHsj/JvmgN/B3R5x/U=
X-Gm-Gg: ASbGncsWUtQEcwTWPsTnZzUX/vgk2aCP1ptZh5+WFl1lhTTXl3n/t5g3/nmrYFEmjpk
	ivWagoBqgc58jdO0FePuXHG7sQJYzvluoh4Niz2RkSQMRNhwvsV4g+5Ctj8CofC/djLQ8pGpznl
	miVK9r421VbWPtDyLRjcXfY96ycQ==
X-Google-Smtp-Source: AGHT+IFlocfSqMLpjRbjTg0X7td5o/r4i1rn/Q2fQH37cj6nCgmfguHFSU+P6jXKR88cetTgE0nLbkqQqECcBZtOsSg=
X-Received: by 2002:a2e:a54e:0:b0:30b:f23e:77fb with SMTP id
 38308e7fff4ca-30bf45575ecmr59217041fa.21.1741638954161; Mon, 10 Mar 2025
 13:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310200817.33581-1-ubizjak@gmail.com> <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
In-Reply-To: <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 10 Mar 2025 21:35:42 +0100
X-Gm-Features: AQ5f1JpDUw_GIkpPOtRAn3wu-WcEL6MrHxCvlwbgT4UV1n4_bAuC3LlUJcxci_w
Message-ID: <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > instruction from being scheduled before the frame pointer gets set
> > up by the containing function, causing objtool to print a "call
> > without frame pointer save/setup" warning.
>
> The other two are ok but this is new. How do you trigger this? I've never=
 seen
> it in my randconfig builds...

It is not triggered now, but without this constraint, nothing prevents
the compiler from scheduling the insn in front of frame creation.

Uros.

