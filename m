Return-Path: <linux-kernel+bounces-513934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0FA35069
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A6A16D551
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281DB266B73;
	Thu, 13 Feb 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6QnQQEJ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9428A2C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481481; cv=none; b=RErw5CZYrugex4qJnCAyJckyJ1ZAgkYWdePefhLueqXdq3AQEMriGjLY0YBlXzFF16kCrKezjodF27fLjX/zXwwYdIfiTmlVcxXe8aQxeVz14NRjVzx5lODxVu4j1ksLnTTbBaHkjO1Xj5iqLS8uXddFuqVE0GuQyMaykjiVsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481481; c=relaxed/simple;
	bh=F7rtUO+sYK4IquZRwkwuLyyE8F7H0KKEoRfcHPzdTk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ0mHKoU6zylf+J6s+sk74i9PN0DCAu4GyVtL0yDjNOFmaS8UitrFZGyJ9GQPn3VRxdjplLE8mpMg0HEUgCQKhuyB0TSApEj+hDAhc0quuOkVCa1vnFEr4Vd6yKR5nKSbOgnbV1R9CvCZi8QegIxL8CI+pgaPOJjMjFpksMThqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6QnQQEJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308edbc368cso13552621fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739481478; x=1740086278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7rtUO+sYK4IquZRwkwuLyyE8F7H0KKEoRfcHPzdTk0=;
        b=k6QnQQEJEGtHIAOf96yUfq5/yFOxRdI5txLaPlPhryWvwlMm8VPpKdLg6CQ2ZagklT
         d4El+eJf6DV1Bgg/JSBVvuIiAbjoV3GldcwKYkPqTwx7cF8vOx6vDi9tOUposnvWKEvt
         +axES4a1qkjc4BSMGMO6UBk6hDjFXMeoUHNvTnDb+1cLAH2m8VNvQTG9qf6ZrrvjqZIV
         U7Izno3If3j8VzABIKU0ah2/ID6weO1fSAgoWEelFC0In0yqdxHr0vjTplwQu39c43/z
         YEHVpqMpqwLY/Uhy8xs2dFhd48Wt9X9TtMCxDYbrVVlEuhBAOgT3IjXgZTyjkvhRoZDd
         +E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481478; x=1740086278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7rtUO+sYK4IquZRwkwuLyyE8F7H0KKEoRfcHPzdTk0=;
        b=AZtf3sidqiqPw86v34fX9THRXvQYmaLtMXj9QCCThOwobgfzfWeuL6nBUxWxXn6OUA
         CanAR91AukGARDmLl2r932IF5JF9szDDEsYiFrLoTBWQ8ib1FGh6s8NsXxeqf/xqw+P/
         bMOZzIUBcsQ+j0Am3Q8r62o5tERjlfR36+KQL0JjdaT03UHWUF+HpEjnOj+UmRheWJET
         XSSnziYHCodi3UsaZ079PxARQHapgElFh6VrKyGs4CyTpz0EpoxwJ+1FJ/t9sWbA7oUx
         dW2KWbTiJC1q2Y6KW+EnfDXCT/AvEfyQ4wXytrVBJZjm55CSM3pp3R21u3leci/1OTix
         GBQg==
X-Forwarded-Encrypted: i=1; AJvYcCUg1KHa8wPLLZAQg0uvBwy4fmWkh/FNJx8Pk07cIqZ/ajKMKOjJZG215hL2NT4r9pAc1RgHe4zq0Q9BLcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9Vm9k9zWUjR5bE1e+iutp+Lsf2X1ONoV853ziO5utg2SzuKG
	o9xMvBcjWXumOr1KhM6QX5duE8L/2jbrbG/T/3q2e+0OOyz/3jBFQh5CXBzLF1ZoafZmv6MZ7ve
	PD0jTuDTakK2nFyVJfAiO0YqrQ7g=
X-Gm-Gg: ASbGncvJfF9R/44UGsc8dgicQDcfWZrySF1nAPVYJPhx2a+tetbNcSeaGNbe81551S1
	/QPmW7HUcTtcKuHYFX/HhFj6lus7O0u0/3ggfc+53L63g2KbWRaoqzdhTXXjdXoenJvwvm83/
X-Google-Smtp-Source: AGHT+IEvnBZVnHY++r9w+H+F+AX3dUBv/bc1/Z12RQwcp1pcz6fCp3zs5GOQA5mkjUz00oj0YxLPC0rUTqCIIzHMRno=
X-Received: by 2002:a2e:a909:0:b0:307:e302:a34 with SMTP id
 38308e7fff4ca-3090500af87mr36218881fa.20.1739481477421; Thu, 13 Feb 2025
 13:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213191457.12377-1-ubizjak@gmail.com> <04adffd9-2900-4cdb-a557-1c486a87b522@intel.com>
In-Reply-To: <04adffd9-2900-4cdb-a557-1c486a87b522@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 13 Feb 2025 22:17:45 +0100
X-Gm-Features: AWEUYZlNLo7NNqMCySZKpk_F4CuhEY_hr8veiHVSaSPXExnCLmkQMrsiv5cCk1s
Message-ID: <CAFULd4YUSCBSJQ1F0Rn45bwTonQJb2_=c2sZZEGV7RfgHBAOJA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:43=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/13/25 11:14, Uros Bizjak wrote:
> > percpu_{,try_}cmpxchg{64,128}() macros use CALL instruction inside
> > asm statement in one of their alternatives. Use ALT_OUTPUT_SP()
> > macro to add required dependence on %esp register.
>
> Is this just a pedantic fix? Or is there an actual impact to end users
> that needs to be considered?

When call insn is embedded in the asm, then the compiler doesn't know
that due to call insn asm now depends on stack pointer or frame
pointer, so it is free to schedule the instruction outside the
function frame prologue/epilogue. Currently, this only triggers
objtool warning, but if we ever compile the kernel with redzone (IIRC,
it was mentioned that this is possible with FRED enabled kernel), the
call will clobber the redzone. Please note that alternative_call()
family of functions, __alternative_atomic64() and
__arch_{,try_}cmpxchg64_emu() all use the same macro exactly for the
reason explained above.

OTOH, all recent x86_64 processors support CMPXCHG128 insn, so the
call alternative will be rarely used.

> Basically, you've told me what the patch does, but not why anyone should
> care or why it should be applied.

This is actually explained at length in the comment for
ASM_CALL_CONSTRAINT, which ALT_OUTPUT_SP macro uses.

Uros.

