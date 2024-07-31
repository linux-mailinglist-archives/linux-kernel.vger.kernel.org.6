Return-Path: <linux-kernel+bounces-269557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF094343A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880AC283E48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669231BBBF3;
	Wed, 31 Jul 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X1juhscx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EF1BC066
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443917; cv=none; b=bGr9DABOGbftQSiw1sZ77Z3K81jTun5ZsHIrUnhZmOvRJqL7UDFaCrLTbVQcki7E010+8aQySpZ2iMoP+KTXhmyntghCkUycLjTmEULsucDRZ/XK9LTtg+jM2ECFMXyRejRb7zUhS9TT7f02dSzGxzu1FiRN9oz5/PnWDI4bhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443917; c=relaxed/simple;
	bh=0XEbFP7IGFOfJ5Kbdiqalhj71LZNi9oqpzUisjiGZ9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwbnnvGLxKFw4urgZ2OB9tQDuXRsml9udCHe0UNI5x2D8AjsimYdfSTpWPyidxkoS/rdV6mCageAoRojg4ONqJ055j4Zu5+d2rIZAa1Kc2GCsl8uVfTTT8ZCoMUfgOPDV2gJczdxcLqvcN349u8o5MwdTKBMIW/D58TUgh8rz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X1juhscx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6402261a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722443914; x=1723048714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aF3T8yqwH4k4oPYgTWrygjhwSwvFjJnxrqJoDBC6mcM=;
        b=X1juhscxb4amPxZ7g2RDiOzD6yyHNyHgVqKdBVFQsjNXYX4NuDpSxU1e0zRecfsLIc
         U+teT0kXZil2wuPW3gErbd3VvE7taOPscyU1wp6nSuDtsKToJkQ/kpLDfacoliP/j+dz
         SDnwREk1prSHRspQmBzK/Smten0CGWmSAaUGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443914; x=1723048714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF3T8yqwH4k4oPYgTWrygjhwSwvFjJnxrqJoDBC6mcM=;
        b=MGmu4MNxggogstU35gUjFZ5Hqsw0F/IjmZRg5B3b661gS6bwNgYDyLV0eb+z+MvsP/
         Cmzur5R5RWt7hU0EHsjvpy7OjeXsoo+qGVwFhjZlLdo+K9EZdNYbL6uGSDu5xZMoz7Ga
         hxF8BMgnAajVD+GH7q5XW4UOy89tpW+RM7GWF9uT3zluP5kLpc1Ef6P/HHk4ujNbkiCq
         IsI24vz1X+H/E8nD0k8HuouimWGh5G4pYgKQCsXaCsMGiQcejlg3HA6K44i9sSvfOrVO
         Lx4DRYawMLkwsZ7X9+hEUHlYwuTrqT6HByULFnWOBM2h2BlkMitPEqEQEkS38oXM2B9/
         BVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnPAjlzRTBC/yFlEfjkI9bJc7twZ9RscQgJfNLOZS6cDE3FxLqfqv18W9evS4pVot1CIxVNC86WHt2175qSXuWaImQ2svHFLt7ZpvY
X-Gm-Message-State: AOJu0Yx48lrMY1S6jA3Mf5NaqfYuUOrvVPSjiwmq/6kXrvFk+5nIGjdq
	ZpZ527SGfT+iCkdc0cRnLoNqBaxCFhHNmK6ltrHjoqER9cKWQxzjx768zpMLH+xK91NAMN1HL2h
	JJ5B+vA==
X-Google-Smtp-Source: AGHT+IF9qphNZkfa0e0vflSTQ1DcrvzOAefMQNbHmVgoJ47/TwP+fJOuhc9Rz23PfF06Av748xM2mA==
X-Received: by 2002:a50:d7d5:0:b0:572:9962:7f0 with SMTP id 4fb4d7f45d1cf-5b0221f0b07mr8198034a12.34.1722443913661;
        Wed, 31 Jul 2024 09:38:33 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6358fa5esm8869999a12.32.2024.07.31.09.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:38:32 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6402194a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:38:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMItrmDi7WVKycnL4WpHYFuLXKDQnPcmmQVz/74iajVGQQ/xbgEp/sMW/y8/0PqWEFzbOvXTM81bNKtJP9qHHnhdHJH69p6FwuhFAJ
X-Received: by 2002:a05:6402:524a:b0:5a2:1693:1a2e with SMTP id
 4fb4d7f45d1cf-5b020ba5d4cmr11776986a12.18.1722443912032; Wed, 31 Jul 2024
 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731073031.4045579-1-davidgow@google.com> <CAHk-=wjx1qBON_8+N2Mte8=EtpVRHNa+JCxbBnJXGs3=wF0c0g@mail.gmail.com>
In-Reply-To: <CAHk-=wjx1qBON_8+N2Mte8=EtpVRHNa+JCxbBnJXGs3=wF0c0g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 09:38:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPD+=Wi8T0A59muq46LxquhsWQSyPV6KM5xa8V1UPK=Q@mail.gmail.com>
Message-ID: <CAHk-=wgPD+=Wi8T0A59muq46LxquhsWQSyPV6KM5xa8V1UPK=Q@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000085f35e061e8db9a8"

--00000000000085f35e061e8db9a8
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 09:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My bad. My mental model these days is the 64-bit case, where the whole
> 'check_range' thing is about address masking tricks, not the actual
> conditional. So I didn't think of the "access_ok fails" case at all.

Actually, now that I said that out loud, it made me go "why aren't we
doing that on 32-bit too?"

IOW, an alternative would be to just unify things more. Something like this?

*ENTIRELY UNTESTED*.

And no, this is not a NAK of David's patch. Last time I said "let's
unify things", it caused this bug.

I'm claiming that finishing that unification will fix the bug again,
and I *think* we leave that top address unmapped on 32-bit x86 too,
but this whole trick does very much depend on that "access to all-one
address is guaranteed to fail".

So this is the "maybe cleaner, but somebody really needs to
double-check me" patch.

             Linus

--00000000000085f35e061e8db9a8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lza2lb220>
X-Attachment-Id: f_lza2lb220

IGFyY2gveDg2L2xpYi9nZXR1c2VyLlMgfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9nZXR1
c2VyLlMgYi9hcmNoL3g4Ni9saWIvZ2V0dXNlci5TCmluZGV4IGEzMTQ2MjJhYTA5My4uM2VlODBi
OWM0Zjc4IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9saWIvZ2V0dXNlci5TCisrKyBiL2FyY2gveDg2
L2xpYi9nZXR1c2VyLlMKQEAgLTQ0LDkgKzQ0LDkgQEAKIAlvciAlcmR4LCAlcmF4CiAuZWxzZQog
CWNtcCAkVEFTS19TSVpFX01BWC1cc2l6ZSsxLCAlZWF4Ci0JamFlIC5MYmFkX2dldF91c2VyCiAJ
c2JiICVlZHgsICVlZHgJCS8qIGFycmF5X2luZGV4X21hc2tfbm9zcGVjKCkgKi8KLQlhbmQgJWVk
eCwgJWVheAorCW5vdCAlZWR4CisJb3IgJWVkeCwgJWVheAogLmVuZGlmCiAuZW5kbQogCkBAIC0x
NTMsNyArMTUzLDYgQEAgRVhQT1JUX1NZTUJPTChfX2dldF91c2VyX25vY2hlY2tfOCkKIAogU1lN
X0NPREVfU1RBUlRfTE9DQUwoX19nZXRfdXNlcl9oYW5kbGVfZXhjZXB0aW9uKQogCUFTTV9DTEFD
Ci0uTGJhZF9nZXRfdXNlcjoKIAl4b3IgJWVkeCwlZWR4CiAJbW92ICQoLUVGQVVMVCksJV9BU01f
QVgKIAlSRVQK
--00000000000085f35e061e8db9a8--

