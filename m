Return-Path: <linux-kernel+bounces-562300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D5A6223E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9214F3BB0D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3E1F3BAC;
	Fri, 14 Mar 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WB7BEzEk"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8087083D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996211; cv=none; b=q03aJgbwTCnCydSlTd3XTk0Y8ZIqt8TbSCsfvolkL/O5zw95lM2LNM7+9+zaOZPkHuaDY8/+3OClRrHTlrYwOt2+l9JBX3V2aTjaF0at33zc4FNCRCL2gm/dTp9HzAiU0gWKGMkHTqbEufeIji2awf+DqBEyovzKXKD4G0AoB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996211; c=relaxed/simple;
	bh=DAaFlAKbB5ebNVB/Fdq7VJzkP7dVmOwJYgZ1l0hZAwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVsSuxyhqM6Odn8UPEd21A4uRQcXdTj/YpJAnkZ7Z6cEP3X/b5WSaMHFpGXZUgPcrY815ncIWQZGnHpy9+BzAnXqVDmP4wQuL5Acs6NHILHDEtIMVD/5s/4dq+dE2e3GNf2RPf9TX608r2Eu8c670vIliMFVdW7rADT5K2tzvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WB7BEzEk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2b10bea16so537076566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741996207; x=1742601007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAPT3XNJrcrZD05PFCQeNptKghkBGvpudT1jnpJUc9M=;
        b=WB7BEzEkNKPVCF3zH5Lua88Ih/YtYMpRLWNV7p+Zq11qcqXS65YVVqvY2fD6LGFOtT
         TX6nFZwn1ikYWn7fdEYTebnQDTMNMz68ECU3hxCG5WthHiXlYVjtAtmFfFWmYXCp7RmT
         inUXKO4+b4SfWbg6tsLIiK3RTQyCQikRMsJvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996207; x=1742601007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAPT3XNJrcrZD05PFCQeNptKghkBGvpudT1jnpJUc9M=;
        b=bzGEQFaKl/Wp4AH/nWymlzAjU9BIACIspaNbyiJQ7QO5KipeBT11hE5q4hJ43jDVxR
         Jq47lmVnYw52KmcA1RprJem9OD9ML1ug55jAbKRrKPjRaykroJImJCLfWT5tgXa87K11
         tn8CJ1O11c61HsKjSfWgJrjqYLM8Jhz+aYJEk8XyQ63y0rUjdSVUmgB1hfWAYpGcD4Jf
         1dxRHqbX+f7Z7aMJSUCiqWhcEBRPyhvvvPNCHSWSqLEitiUKwG6EI+3KSAiwKwUJmtjx
         ZN/S7ftID1nwCxrtcf6Q2y+s/3DShuPX0ltGHNooYJe6A+89/XmDpxxF274Vf7h3BmWc
         Ht3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2RnMuNET7rHhi8tDbdesF4dbrTqHswShj8XiaYzMkhZgnLpxej7ydtdvVfjUd5t3FnbureN8g8UUzOTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGJ4nkO/wNKjsrXcxrwNaGa0EayhOemUEK8k0+nPVraqHHazX
	yAKJ3y2djQIVyBJz9slLyv8mi3pnSLbkOGV1Vl40dF0cdDk6d6ielkAYBSb4z+4dO56ohXkbNMU
	O82s=
X-Gm-Gg: ASbGncvKt5Mth8hulMZ4yUkLuZRbHz1cjsFxpDn4lnU1dxndiICPZiJshKHcS11urzF
	gU9AhK0VsktzAiocNwoDnUII15YER5gwjuJb4wRhQR4x3u9xvUGy8b7BMyfV8BIpBsbLHhj8bd9
	bg38QT9LuTMmCTtPMZfYTQtVw5ybKfD2mM8q65igfLkKzQW2/6s07ueCAL3t1B5vbInBfNbqm0L
	U9nXN8FGl0xZxJ0abzd82pyCm7L2fg2HtqBYtPwGSca4QcM4ikr5d6HijUhI6Y1DtN2ip97Hvln
	90K88+qXnq2PW0eDuVQeRMaUt8Copq0Z93Wi13KNfhdUypL+rfc298Rq/D/P3DA4c6upRGwcyXv
	IsETWPEfqdQqMcDzKyrk=
X-Google-Smtp-Source: AGHT+IHM5HbNwcWUaPvlPZ1d9exIIPSu9AQH3J7ftGUhpg5eLonSjkfGZfkVFlFFNGrds69pArPRdQ==
X-Received: by 2002:a17:907:d92:b0:abf:19ac:771 with SMTP id a640c23a62f3a-ac33010b2d1mr571837366b.2.1741996207241;
        Fri, 14 Mar 2025 16:50:07 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3fc0esm291953566b.137.2025.03.14.16.50.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:50:06 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso4352536a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:50:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHhFi1ddu9LhLGml5RDBgRrJRhhxh9G0JAEBjjozbwqtAWmCth/e1M49G6z1BR6ljBJBsMTIG0Af+C87U=@vger.kernel.org
X-Received: by 2002:a05:6402:13d0:b0:5de:aa54:dc30 with SMTP id
 4fb4d7f45d1cf-5e89ea8ecc1mr4587228a12.5.1741996204789; Fri, 14 Mar 2025
 16:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 13:49:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
X-Gm-Features: AQ5f1Jo5Od6E7ztUN_XIm1BmsfnibAWhSL6bUshygLzOP3_H6mWG3BAzSOZfwoo
Message-ID: <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit barrier functions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> +#define mb() alternative_io("lock addl $0,-4(%%esp)",                  \
> +                           "mfence", X86_FEATURE_XMM2,                 \
> +                           ARG(),                                      \
> +                           ARG(),                                      \
> +                           ARG("memory", "cc"))

So all of these patches look like good cleanups to me, but I do wonder
if we should

 (a) not use some naming *quite* as generic as 'ARG()'

 (b) make the asms use ARG_OUT/ARG_IN/ARG_CLOBBER() to clarify

because that ARG(), ARG(), ARGC() pattern looks odd to me.

Maybe it's just me.

Regardless, I do think the series looks like a nice improvement even
in the current form, even if that particular repeated pattern feels
strange.

              Linus

