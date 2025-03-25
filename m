Return-Path: <linux-kernel+bounces-575843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A4A707DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF916C3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9E2561D3;
	Tue, 25 Mar 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBNatZS2"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A91E5B9E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923039; cv=none; b=s5/bX5KPBEKJIyit+UXWJguxKLtp/akupXwp0TlbMQR/FSe1Ot99h/p7b7NlRLkop3ShjpZ2S9NaVlUNCK/Q9WjLxvp9aHzwNJedaZHDk/RTaWDW6ZlTwX6KuEBgxiL55La2zVUDhiWOPFnJSWepaHHpQdE8QizN252b38Kp5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923039; c=relaxed/simple;
	bh=FSaE51qf5gqGMlXTdRCG+azOuMbTiJaAowcVL0D9pNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8goGY3FTV5EEvPDtwNGyc6alp9u6Hlujp63s6817w0pqHNX5UGA4VfVvKN14uoZqiP5xVQc6v4Kdj16TAJthmV+TPxSw4+0xaPlC+/MFm4dfVJZOahgUbpL9q7Wxnc3LbxB/7zyYBSoQ+yejlrfp76CU5A7B4x74jJ3NWJQn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBNatZS2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307325f2436so58496781fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742923033; x=1743527833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSaE51qf5gqGMlXTdRCG+azOuMbTiJaAowcVL0D9pNQ=;
        b=bBNatZS2pmlrsBgmZzdlkBPwPp5ukgE799SQd+h941Ez4nz0uPVMutCdzpe+jqVwoP
         oUJtf5woQvVNUYGsk+X53Q6BicS/htt+rlbiAZwUHY4vZ69GTk+/TUJC9f/swcKYsqdd
         I5EEG7NCoQJMm0is4i1U408AqNNQZ2AiTUKm0JTI2vyTnXzFfUlBDR27TXusZd9RwFLk
         DXBi5iZPtwfE9eRPbsEqUpBmxg+NGPB1VMUC08zdnqBNBLdh7ipV2g+7/3GHlmukU8Jn
         kQ6SvPcS39HNJdggs93amrvsDF7x910nziVTlK/cn4EE9a9LG38t4LrS3Xvt3PslAjZX
         IEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923033; x=1743527833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSaE51qf5gqGMlXTdRCG+azOuMbTiJaAowcVL0D9pNQ=;
        b=rFmXTUsH973Pf3eZx/rB4v3eoLB1VvEO3b1oramH1v07KWkvdhVDoetAvnU6mpRth1
         1AJXLMkUvwWbBekeNzu/B0+GOcFtOQ8tLNONwMFNKwDqgmtzokVSUM9h3iOH6RQZQfb7
         Rbne1Fy4/GtCfbEKCYE/N7QhN4G360RqoK2Kfm7cz/Q0opiX7y1NeJOaQU8NQcKPjJLM
         zsdcZag8mGcobTsj11o/kGkxEB/FYufwWN6kZE0zKULwd89e4a0qc9eII1mHRU766gjR
         EmAxZEv6XNP5Xhz/FGb+ArtWag7juBte4x/pdAVKuKPFXaNDaMniRJ7U77u0Lu3swDsJ
         0M9w==
X-Forwarded-Encrypted: i=1; AJvYcCWw/HRNzO4Osg7Wgla19ulpePOhwrvFY7N/ExPemsF7bjSk1ZqotRxzhcqA7vGt7W8R//iTm8upDQKpmCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOHV6UD8Z1DBidmoMwM/Ova5jkFG3yIzmeoHqQmX2pTlDwPkm
	aH9JuipHWEK66xCoWrmuSdeBRpQ1xBamCdGJX4tBptKZDQGOPnT9/1Lv/RAIdJvYlMR4GZ+U+lD
	QbzXwBb1pXRSJ2xFsrNqROZyzXQui3+XLUfY=
X-Gm-Gg: ASbGncu+o6Dg1pUkKynMTE4MnHC3NnKxmhJbeuifKnMmY75NVf97BXCvL58W7Ja5dOl
	YYnylUOCnN61nqXidl4Jn5+xHBE94SjhMnOTGK+B+RHDIb1xab2qCdjzEtp8AYl9vTMTEJDM2r/
	+odwGrgVwGilX5cx1f70XOzRLUGw==
X-Google-Smtp-Source: AGHT+IHMWBA0TB81NRjqaj3ulEC+V8TZU96uZk3IEHQOvjM8wEL4ZVxuvLhi5mpFJmNoOsjmFpV6ZeziP2BDASAN/3E=
X-Received: by 2002:a05:651c:19a4:b0:30b:f0fd:fd19 with SMTP id
 38308e7fff4ca-30d7e235007mr71494251fa.16.1742923033227; Tue, 25 Mar 2025
 10:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325164854.199420-1-ubizjak@gmail.com> <20250325170953.GCZ-LjYdl4rftqY-us@fat_crate.local>
In-Reply-To: <20250325170953.GCZ-LjYdl4rftqY-us@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 25 Mar 2025 18:17:01 +0100
X-Gm-Features: AQ5f1JodUWQhumT0Z8zUc6SxJgABoHknkPN7Dvj5NmjzkfF-9HUpkFX7dsjDt2Y
Message-ID: <CAFULd4ZbYmwTOR0vc8+Xiq8uPgqbte=ruKVGiKKngjHmkNunFw@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] x86/hweight: Fix false output register
 dependency of POPCNT insn
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Mar 25, 2025 at 05:48:37PM +0100, Uros Bizjak wrote:
> > +/*
> > + * On Sandy/Ivy Bridge and later Intel processors, the POPCNT instruct=
ion
> > + * appears to have a false dependency on the destination register. Eve=
n
> > + * though the instruction only writes to it, the instruction will wait
> > + * until destination is ready before executing. This false dependency
> > + * was fixed for Cannon Lake (and later) processors.
>
> Any official documentation about that?

Please see [1], errata 026.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/specificat=
ion-updates/8th-gen-core-spec-update.pdf

>
> Any performance numbers to justify that change?

There is a lot of performance analysis at [2] and [3].

[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D62011
[3] https://stackoverflow.com/questions/25078285/replacing-a-32-bit-loop-co=
unter-with-64-bit-introduces-crazy-performance-deviati

> Because if it doesn't matter, why do it in the first place? Especially if
> you're doing this XORing now for *everyone* - not just the affected parti=
es.

Thanks,
Uros.

