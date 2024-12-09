Return-Path: <linux-kernel+bounces-436621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95E9E88B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85A2280FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21838B658;
	Mon,  9 Dec 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CyvR4EDi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B44409
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733704375; cv=none; b=fTEHQ5MihP+egf4IrCLOQ9XMGUjz/VTUIojlTuI0zxJhoAT2+6plACa7z1VwkI9KghvBaCj6H7ayNDU2unwT6ofJQuGBnhysEUQioFApr2Zdt4Z5KUVCnBFFdKCckVQl3/K3yTmzWUqeD6o3nZ9Y0xFgd6NyAg/rK3h+RFY7tTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733704375; c=relaxed/simple;
	bh=DvV8DNt3QuaEUy1QJHbUTvNHSY2heRPQqHK3Ay/x744=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7S8094lLfNR/flFslzMPFIWJSYtfh6ZaCFVelv4+eVOEzCJc9RGiM4MXoygZY4Q4d3lWIGJDHjJBktZ7k0CPWXVTedxMM45pGZrQmo7aaq2V2Jh3u6pribAR9F2ul9jrNHEmu/bNJC/jSLAcUcI/bONsbALsZr+wBKvlYoqdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CyvR4EDi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso42968366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 16:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733704371; x=1734309171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rk/kBvGXbOiTTCvnHv9JwPUrIgzBbvNG0YVTljgAwPM=;
        b=CyvR4EDivChbVOdxiEY/cqvLGFsTaYX8CgBAZ9JpOVGhQG56bIVUU2/FO10M8sKuAj
         H+LLqODPXalQa7B8yDt1fiaBmcLd5JNZCwK1knJa5OYuhYXaxraMuzu2z2xx2MpYamKe
         vWZJ4oN6zQIbVtGBBq2wBWkFHR08cJRy3RKmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733704371; x=1734309171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rk/kBvGXbOiTTCvnHv9JwPUrIgzBbvNG0YVTljgAwPM=;
        b=pDs6Y13LbjCnvCLsj0UwMNsMAG0GOE9Wahy1LB6RTRJ3uZHfC7Pr3rTfDFmpWeaAY7
         xrS/vdj1UKDx/OmFb/FiWcLP8VNwE+aAq2sKlrtIwSrbM02hpm3bzSwbwsFADoc+d6yh
         rF0i4tDW0H5tLi4EQoze5KZl5QFWqqgY0N2aMkfUzcKjmKm3YsWlo9/ZjIZhHQ+VspGw
         Yx3b7zK5rxT2LAelHvzgj0bksr7GTrPMRYXubhCCS9vokVAwZOY5CHNs+VxtyvjnF33A
         SHLtNxjrZyGqCTEE61gTZet8/czo+5fRYpZZVBSccK/O3lbnvg6uu5XSOnjZhmlyOaPR
         CkXA==
X-Forwarded-Encrypted: i=1; AJvYcCXiBclgi32OefhrvhD8HER90uAX3ycTi6B7J+UFVPUsrb4sNhT3S4JdrbZ4Hvlnr1uocIWhPvdfgeeMpgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Zm0RO8Dy2faev6nHWOd3k0M2bkJLCwJu+SHPytCiajZ2WrQT
	shqw12jyEaBlW4zQaUh0YbnVee1xTae5LWfBbaZ5ywGSiMHvjF0b2HzyPn+cIT8o4sG0i+8uznj
	IdZZDDw==
X-Gm-Gg: ASbGncsc+aJORfAE/GpS1v3xI4ustuRACHLNGxqWNZLpG5d4EO+K8dRBhbWVz6M3UGb
	FWGlYfS4c+MU0j2j5y2QQ75v5Nyn94zY8PFnilWY0VtyPxmO0bT6e5bSuVAxCPF6pmflzWkSJku
	oK4FLyJBhY7nz9PB2HUHzc5uVjMSXZbSRxE4PUIEd3wl4jsIRK2OcYVs8r9SCkGbFM54wzZ0466
	XGayLh5Mt6KqRtbyJyk2D1OxAhORzio55EUjH6jb8xfT7KpVQerHi2Zzvb0mt7Xi27Uz+tNNxdg
	V0b7whvdnt9NHUBHyR7spqOL
X-Google-Smtp-Source: AGHT+IHm4eOir6al15NXjKIwoUUM06PlNP3bMjYdoFe1SQeVbP60wnuQuQtISSY4zNKJ6GiIlDFf3g==
X-Received: by 2002:a17:906:9c18:b0:aa6:8edf:bca5 with SMTP id a640c23a62f3a-aa68edfbfc7mr57940966b.19.1733704371461;
        Sun, 08 Dec 2024 16:32:51 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm97952966b.108.2024.12.08.16.32.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 16:32:50 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69107179cso15695366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 16:32:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKy3V8cLnoG5Kbfqk1JhG3/zWUh5HhGvpiE2NQ8Af9wX1X7przFvywUHpbrmGoIwCz95URgPeB95dk+Dw=@vger.kernel.org
X-Received: by 2002:a17:906:31cc:b0:aa5:3874:c646 with SMTP id
 a640c23a62f3a-aa63a031645mr1031456266b.18.1733704369344; Sun, 08 Dec 2024
 16:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122193305.7316-1-torvalds@linux-foundation.org> <87bjxl6b0i.fsf@igel.home>
In-Reply-To: <87bjxl6b0i.fsf@igel.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Dec 2024 16:32:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
Message-ID: <CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
Subject: Re: [PATCH] futex: improve user space accesses
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 14:54, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> This breaks userspace on ppc32.  As soon as /init in the initrd is
> started the kernel hangs (without any messages).

Funky, funky. Most of the diff is the code movement (and some small
x86-specific stuff), so for ppc, the only part that should be relevant
is the futex_get_value_locked().

And since ppc doesn't do the masked user access thing, so it
*literally* boils down to just that

        if (!user_read_access_begin(from, sizeof(*from)))
                return -EFAULT;
        unsafe_get_user(val, from, Efault);
        user_access_end();

path.

Ahh... And now that I write that out, the bug is obvious: it should be using

        user_read_access_end();

to match up with the user_read_access_begin().

And yeah, ppc is the only platform that has that
"read-vs-write-vs-both" thing, so this bug is not visible anywhere
else.

IOW, does this one-liner fix it for you?

  --- a/kernel/futex/futex.h
  +++ b/kernel/futex/futex.h
  @@ -265,7 +265,7 @@
        else if (!user_read_access_begin(from, sizeof(*from)))
                return -EFAULT;
        unsafe_get_user(val, from, Efault);
  -     user_access_end();
  +     user_read_access_end();
        *dest = val;
        return 0;
   Efault:

I bet it does, but I'll wait for confirmation before actually
committing that fix.

Thanks,

                Linus

