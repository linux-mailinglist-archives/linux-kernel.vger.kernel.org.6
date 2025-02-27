Return-Path: <linux-kernel+bounces-537353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6AA48AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A641614DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8909271291;
	Thu, 27 Feb 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZ9wVRmS"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822327126A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692942; cv=none; b=hY3ZD2rBG7ddciFGACM2ctUMO6g8G0D/xTZNsaZ++tvjZeAnRYoVVhICHtCWsOqqShK4G0lJOURBb7172IVDfjbZhUD3PjM71YFk7L1SiDHShjX9nB41PsPi9PkQ5DkORfPgbD68mGsTYlXuc3QaU2QG4zsyzPWtpyHZhtLYswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692942; c=relaxed/simple;
	bh=j65XZnLRgP5uH+H32AXhBNqNHf2gezKnh56MWy4Juyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAksa80nhRbx5emwluyl6lWQV5p0svpJx4No+jVfm7mBNmmNBV9REkJBZmUA3TbjF66/CxHNxjREnpXZNLD8GR/MQO4jeZwMA+HBIANqEhcaheolblK9jDYB7W6HmDoGSoamwy52QzPAta517mcv/Z1cj1GUwHuAZhANHu9+IHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PZ9wVRmS; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2b1f2b286f5so77845fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740692940; x=1741297740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S20fxq1ry7p9hh50mjUI/MxMWC0bw2bNpdDweaT8JpQ=;
        b=PZ9wVRmSECjb2yKVqvORnSHsHXIiQFU3LkT6l/Wlkn2GY4+IhdjHG+sP4s5whNbbBO
         6KY32UQswlbwfrS5jWe9M9M+unfQhDT0HysOHgwfbgsDI20iv2gWQ1kl8nCg+/UROMWp
         qkdUQxKOD26yO5djukGEWfTdbDQpfdn9qrHOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692940; x=1741297740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S20fxq1ry7p9hh50mjUI/MxMWC0bw2bNpdDweaT8JpQ=;
        b=iZB9+fXZatsHtqDyXhvMaFdJwc41UUY2ETW+vdu0aKrevff/5BochOjuBjoInl9GDE
         GQdn0l7BneanjfnL+V0MjMWzCslattZAAfF+tnBVXtVfmGqXTApRj28haNY+0vFJiFj8
         fuulGRFIE+Lgq5+3J5kKCdcOC40+3wkYrRrJwhGpKgjZWj9OHmMJDI6TQJLXEYBG8Q5n
         QtrqygcQaRF3yUWlfDrGa0E8nS7RNp07PvqDGchUtJ8Q/dR3cDPK1c6g0b70LA5QVlfS
         orcr2mohV5Fi2zznpJ7Aeam0Ime/tIQd7cGNUqdyT1gS/iM/0bQSYvdl5wNCPaHEDVh4
         4ofw==
X-Forwarded-Encrypted: i=1; AJvYcCXL1PTNwyp7sEhl7wkt8tmBPb8Tgt2nLhNXVubkZOo2xdNIHMkAUo4P2yn9xbyaCAQubAdqJJBHXTgP0IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUvB6jBdJ00wVU+ahwCOGzI1CD2DJt4UG+rknckBVzFgFhRsI
	1ltv9bee60L6qa2jMkpd6BcnlhqSsbIDE4o+sDIse9oaQjaJl0N9qLNSEzag9VfL9DZv/iVI7VW
	nCWh4LNPj40zSUh9yM6b5PC+iWK78GtrpuCsD
X-Gm-Gg: ASbGncs0UMEWWKQ1BhY99WEX4Q9DN1CTJFZvjjByDQD0nE0yZ0NunyWcx9bH5dadzGP
	s+B5+Pblm5pskyf5m+vJ/1dh2GzlV0SD1BFaim+lZvSeA1DMLCskijMMl4vWzf9N/fQwrkDqL4m
	yu4wQBYVgY89KJAgEr/iGWm/8aJX9pVqfcM4ri
X-Google-Smtp-Source: AGHT+IHyEdounA70KkXSh23Nmd4f4aE5ui8o/HbAvGXPGW/uNecoMbNRDyQAff5aD7Br5h1XJp/sjnk6PehGLfqhLtY=
X-Received: by 2002:a05:6808:3097:b0:3f4:a27:f74d with SMTP id
 5614622812f47-3f55862f435mr194102b6e.9.1740692939817; Thu, 27 Feb 2025
 13:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com> <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
 <20250226180135.GI8995@redhat.com> <b67cb9de-24b1-4670-8f8f-195e426c8781@lucifer.local>
 <20250226182050.GK8995@redhat.com>
In-Reply-To: <20250226182050.GK8995@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 13:48:46 -0800
X-Gm-Features: AQ5f1Jo2mnzwZQraAqqQiHYSY4itEhI58lkCEMcdRw_QRoxgrmRrD4sF7HgEYxE
Message-ID: <CABi2SkU=eXQGbk0sacMXogE72-EDqpmeuj9sA=MfL0y3tt=Qtw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
To: Oleg Nesterov <oleg@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleg

On Wed, Feb 26, 2025 at 10:21=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 02/26, Lorenzo Stoakes wrote:
> >
> > Like I said, Jeff opposes the change. I disagree with him, and agree wi=
th you,
> > because this is very silly.
> >
> > But I don't want to hold up this series with that discussion (this is f=
or his
> > sake...)
>
> Neither me, so lets go with VM_SEALED_SYSMAP.
>
> My only objection is that
>
>         vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
>         vm_flags |=3D VM_SEALED_SYSMAP;
>
> looks unnecessarily confusing to me,
>
>         vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMA=
P;
>
> or just
>
>         vma =3D _install_special_mapping(...,
>                                 VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED_SYSMAP,
>
Sure
                                 ...
>
> looks more readable. But this is cosmetic/subjective, so I won't argue/in=
sist.
>
> > Jeff - perhaps drop this and let's return to it in a follow up so this =
series
> > isn't held up?
>
> Up to you and Jeff.
>
> But this patch looks "natural" to me in this series.
>
Thanks for sharing your insights on uprobe! Your expertise is invaluable.

-Jeff

> Oleg.
>

