Return-Path: <linux-kernel+bounces-557682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C44A5DC63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782AB166C82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83FD241CA9;
	Wed, 12 Mar 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatJa12t"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5323F39D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781552; cv=none; b=gCpBCXXZPYD9utCc9ngpxu795HWAS5fSR+ElXkivlIIhCQza9ZYdzD+LhumqX6rwMAPrC1EXA7wwgpMXLHCxcplZmMrNKisY9pBPBYO/35YXf4bVplWCwyxWVEd8JbU38K7YSw0SBzgX/BoIk4mJY9Z64z0HmyLZ4da3qC+euLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781552; c=relaxed/simple;
	bh=qZ5EiQihouwLiov/3DKyrtoz4b53A4UKfKlE2kK29Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi9HC6UWguW+5v0vnd7bYAxNhHNekBzhkx8KvI40b9TUTL2VdY0Gb7ZJZwlWSPEW78pNxg1CwSL3JQRAVGMxL0rGx7L72PRB+M/iF8tjGX9F0OS48FD5g83OzDxIYIu2jJwzrKkKfcsM4pXYRaZa7IqNP43ZnugIhJK+jDc/HqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatJa12t; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf1d48843so55723841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781549; x=1742386349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ5EiQihouwLiov/3DKyrtoz4b53A4UKfKlE2kK29Z0=;
        b=XatJa12ta696EWtDT3UXOqVLm6TaO2UYj69e5C8UA2aZIQtVdfq7h1Lw3dp8+Wrvjq
         FsqW9Ou4JJ9I7xll6gT7HebrIHvMJQj06xPGUlCB64jR4uGhJR0thQrbnMokXllfVGma
         NUjPI3k9xLMvQDmUDJ7OmTMn2G2Ylo8w+60NrihDZlsdycDZYJCcSGr/dqphj6YuIrLR
         2wu+1e/s9DC7k9zz5iZxfAet9yIgq9sjqPQwX7sOZXhNGck9EYjUtQuEL0XLYmuIUk6e
         HKtBOHU2rkke6XPLZX3DCl8/niVGW3todr4hQ9AutXMj4d4vITlGPayK0VuQ7yh06GOK
         4Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781549; x=1742386349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ5EiQihouwLiov/3DKyrtoz4b53A4UKfKlE2kK29Z0=;
        b=h77C/qdSbnWqoHVUW5FPE0FeHo5yOGvNy/jTsqb4DprdmbeG08S1N+AQTRu4YhnEzC
         ItS+31wT+hQf1hkc47Ji8XSWcQY92BALu/Ptz0JwZwXohjptLmcEVW6zeSKoDb8iSTsC
         x0ZPA/I/Pn+qWIz03eKL4r07VVNHx2uogoievb6rs02N/KAhVLbqz4gdns8XB3vNFwLO
         c0yCgPM2V+6ZFOheQtJHIimTChKqffDRTjzhPbpMjhr7RAoyP9HJsI3RcLVueqCblN+j
         80R4m8xo8qNzuE5XNf7lqurWA6vJ7/h4yvfa5+Xu+3F2GvxYs3zu/jeOz/MmbNTnCISb
         0S/w==
X-Forwarded-Encrypted: i=1; AJvYcCWyWSPG3JBhjMm14MXegAVTFx9/ad0NRi5cq7glubfKg1iAhJuHmrs1hFSa7qcL4Vt0+EDHB+V9mcUBkkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsXtd0/TR65gMytwCG8dA7deD/WiU0g0PRlqfsZ+VScNJctKh
	9tnhFZGdeQD4mWr4aEke1+fL9CWeOtubIFSSScvd1NvQFX4SZAe8i2OyUa2aIo0J2RO6Bpst/m4
	1nHg+XOI/yyPzDU7U2epo/tB1N1M=
X-Gm-Gg: ASbGncsKIqfCbRO6vEk83xAO4Koc+VmClmTDqxQXawD73jgBAyfnNZjXYhWH79KQTlW
	ssHD36xJ1mYTTY91mzliyO0yOdS/vl3vuWQpvO8PcreY6dcqyIm0un4NPKUfnep1Y7Otr4GHepD
	eY/8Nyfn4/XY3vcifDJf4r6nMxMg==
X-Google-Smtp-Source: AGHT+IFQdv610SGScnzwZFqylEXePH9UaXJqqYBOPVxybt7kRgT+QD08bkoz2HYVkj4EwOZTDH1fLMGiEXpZCZMV/1g=
X-Received: by 2002:a2e:94cf:0:b0:30b:f775:bae0 with SMTP id
 38308e7fff4ca-30bf775bd2cmr55579881fa.36.1741781548408; Wed, 12 Mar 2025
 05:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311150745.4492-1-ubizjak@gmail.com> <Z9F5h7cEiV55dWMB@gmail.com>
In-Reply-To: <Z9F5h7cEiV55dWMB@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 12 Mar 2025 13:12:35 +0100
X-Gm-Features: AQ5f1JqOIBdYwOLb4_iDy4SJk-SCtsrIdjDkDzeKCtJVUnIw8870SMpIIJescoo
Message-ID: <CAFULd4bir3v7heqdUtPEFGEY66SwqxNkmRXy=uhB_3popS3zDQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:09=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > instruction from being scheduled before the frame pointer gets set
> > up by the containing function. This unconstrained scheduling might
> > cause objtool to print a "call without frame pointer save/setup"
> > warning. Current versions of compilers don't seem to trigger this
> > condition, but without this constraint there's nothing to prevent
> > the compiler from scheduling the insn in front of frame creation.
> >
> > b) Use asm_inline to instruct the compiler that the size of asm()
> > is the minimum size of one instruction, ignoring how many instructions
> > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > pseudo directives causes instruction length estimate to count
> > more than 20 instructions.
> >
> > c) Use named operands in inline asm.
>
> I think this should be a 3-patch series. While it all modifies the same
> code, each change could introduce separate issues, so it's better to be
> individually bisectable IMO ...

Ok, will split and send separate series.

Thanks,
Uros.

