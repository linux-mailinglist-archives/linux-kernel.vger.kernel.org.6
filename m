Return-Path: <linux-kernel+bounces-546326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ADA4F939
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5663AC12B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E31FDA62;
	Wed,  5 Mar 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUKNo3qq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED501C6FE8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164861; cv=none; b=iAZarojj+Y/+eSYND0wA+j+8qJ02I1h2jA0gjIjGbL0rJ1nm03GDqecxJWNfUiMdx/NnCNZEMnjwMrnbyUUaGRWE8yH1Oso+xztxOfvxhLNuH9DPsZQ/Tcc/4CwiZ2kfcTzwUpwAUwH2KRPzXToGrloWlH721AQ2B7Kten357fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164861; c=relaxed/simple;
	bh=invv4GtGvKtEtKN2J0dimasb51DDl8+yy2cucKldiKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj8ymaf+C4Nn6pNZeM3f1vpr78Vb7LdBKakaz7tpdTD15iJbicB6o03QaI/OXCbeleIKcLiBdOLgHI7npUE+7KPzP0OSIFMIeyFAK0rshfcsshkFFd6i/W00uSZjR/5kepaS4vpywzikl/8QxmrYbUukWPzjMoO6D9AunBASOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUKNo3qq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30ba563a6d1so6884551fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741164857; x=1741769657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=invv4GtGvKtEtKN2J0dimasb51DDl8+yy2cucKldiKM=;
        b=NUKNo3qqbtWT4DBfamXZVZk3nsC9IVzP6H2HrDr2R5K15A6y+bdnlkMl77mwSDY/B9
         7vMf5N/xB56fc/DT0+IeDcxZP4xlGNB1OzwwVZExqjMX7klZfx2EOrqLAVdqpeFkwz2x
         tJtJVcRExGkLruS/9SAJn4i2/LuQMKIt+1GeQdGuDhz/ZxE6rxH14LoYgN2IM1PVeOUG
         zbQRfMKCNXsNAT3QrBHQCdd9VPObGnMBPniMAck057s8EUZSCu1ZhrblJkNst/nB3amZ
         NUn6brcwbpTOCwXUEuI034NMMKyuaX8eM+Vc+7he889uvxVnzfKuZZnIOlla3z0DvSjB
         YeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164857; x=1741769657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=invv4GtGvKtEtKN2J0dimasb51DDl8+yy2cucKldiKM=;
        b=q+IRIhEAE5Z+oGeeQlPQf+1mtNF0sycbBbqQe5FJsQn+gtiDNyy6003sz8DGW1Ggpm
         rYqrpv+Lt869hR9ZCe7A11FhsmNXhIUw9uqSZw6fXDMXKRU1jg5R/xLjdF/uNgPjMhJP
         Kp3/PZBEIifaYqG1abAcNLjGVpv5uYV1qzRddeuP7YPMoNA6TrOEPuGnV6GDopUb+4Zz
         1iWtlTyOl7GMxrfAZLRzwqbpJFD/Lt4JjomPd4sAC+1x3rA5UwfFJpqRb3k6++LiVg0U
         Z2o15VVesgcFnDEuCBxhtS84G4Gt8juH55bkfiHCwqEFA3w+KfDzzt+1Cy3wBwHXIDOV
         IbZw==
X-Forwarded-Encrypted: i=1; AJvYcCUTeBPVs7rnAd7fbvjKM4fWXhA5jSEcGf6tZR9G0ApCzV8Sh1whYiWv/bjT/8E5VTJiH/AlnlF5sioJ9C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySw+gFVIX6FkScsuoGih4m8FfKq6I0TWqU63cuPG11CoaNYOuJ
	/uhRzWEwgjwZrBXhUhy7XYsN3wD+lKBEq9y61SdcGRDfRkFMa+RsYpl7KPxhQnhPzNWgDyqjvWA
	mJRnDf8ObrOhNWSrudo/idq4GRns=
X-Gm-Gg: ASbGnctiBLd23JO7+NsqM4R1FYZ5GjjxiS7Io8ucLEJY0VGgkOGjL4/64nU+lt0ZjAg
	IIgUkMuOCJR8rPRWyG6Zujjc6Gennreax1gGIQadcc5DroQH/TV+A6iYjg63eXP0mflr9/CKRfm
	DLjOmPljyu6bb+Wry8HyDnnjEApg==
X-Google-Smtp-Source: AGHT+IEBSzflrotXLMY9gJdBmrAghNuVWbTDxXksdlkviiTnKgMnHU9Qvz90CAsDRCciWPMAFQOCIwkrk8zGlbwQaY4=
X-Received: by 2002:a2e:be05:0:b0:30b:ab00:846a with SMTP id
 38308e7fff4ca-30bd7b0d78fmr8976041fa.3.1741164857081; Wed, 05 Mar 2025
 00:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
In-Reply-To: <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 5 Mar 2025 09:54:11 +0100
X-Gm-Features: AQ5f1JqCeHLdq50N42-r7NJwZ47m7-OMOeLDsuEfohfPiBDHcNVQ3yMRnTAz3C4
Message-ID: <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 1:38=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Sat, Mar 01, 2025 at 10:05:56AM +0100, Uros Bizjak wrote:
> > OTOH, -Os, where different code size/performance heuristics are used, n=
ow
> > performs better w.r.t code size.
>
> Did anything change since:
>
> 281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
> 3a55fb0d9fe8 ("Tell the world we gave up on pushing CC_OPTIMIZE_FOR_SIZE"=
)
>
> wrt -Os?
>
> Because if not, we still don't love -Os and you can drop the -Os argument=
.

The -Os argument was to show the effect of the patch when the compiler
is instructed to take care of the overall size. Giving the compiler
-O2 and then looking at the overall size of the produced binary is
just wrong.

> And without any perf data showing any improvement, this patch does nothin=
g but
> enlarge -O2 size...

Even to my surprise, the patch has some noticeable effects on the
performance, please see the attachment in [1] for LMBench data or [2]
for some excerpts from the data. So, I think the patch has potential
to improve the performance.

[1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42A=
VOWSnfKsg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAFULd4ZsSKwJ4Dz3cCAgaVsa4ypbb0e2savO-3_Lt=
bs=3D1wzgKQ@mail.gmail.com/

Thanks,
Uros.

