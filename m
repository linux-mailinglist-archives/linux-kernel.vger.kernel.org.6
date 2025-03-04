Return-Path: <linux-kernel+bounces-545537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE4A4EE4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAABD16A13A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1824C085;
	Tue,  4 Mar 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hJfM/74K"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213781FA178
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119950; cv=none; b=rYvqOPN/qrqVN80Sqp8FTNXKQ0BUQgqHoJHcCKd0AlZdWFI7KxCUxofs+Ojx1U/4pVqUo7NZ38Ukcr5WU1uvC3g7T2nyNh/Rc9ggvx0Ab3KyXE+5Ni3nua/NszCnkfemm4Xgglk0PayFCNDdDESwpOgKguZLFdHpolYN9PflNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119950; c=relaxed/simple;
	bh=X5RiZHBsbLcPKV323Q8tWpZ073WfByOYU3vrxNxusK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCDLvb9AexhNeWSMrMoJIbkbHSJKS+u9gVmyrfhmxzVjmOvuvWc90Q52n4GmIo4lIPHubxo3LPIV73/hMbFFtsffnGIdF+h59ky9ZIKZShurRuIqaaO+QXFCscdh9SWXa6/wnHhS3OOEvZTbtLOOVyF9l57/uOy3NzRC6/9ucJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hJfM/74K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso10506702a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741119946; x=1741724746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ng6/HlQleweYy73ZBFOZ7zU4VxzpXmmE/CHm0RKEds=;
        b=hJfM/74Kb1TF4MxMKpnWR4w1Bxak8kihFYFmbX98F1wvhlDZGx83RYqCfz604NoqNR
         NrQ3DFla4YoFbNiaUa/UrQkqaEXwKr1L8ohxSCLVL30wKPqJ6yNeXVPG4eC6qgNA5nCf
         aZlWTOa8VfZUW/iQMGI1/VZ+Jr77kKjS3gPlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119946; x=1741724746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ng6/HlQleweYy73ZBFOZ7zU4VxzpXmmE/CHm0RKEds=;
        b=Lm7p7C0/UiAnFYhWR2RqhmDll66YksFD+8F30C85F/crGu3wJ7YtMkFvfyFUdvimu1
         7eOOr0MO9NmaLgGZfld7FU9FIhunK0oRMUIJwUcFQR1MrojOX6k1XlPUJBRgsP++rgTR
         DiDZNQ68oZ0TcTTptE+LGX1QRSaPK9OA0q555BvbI+HP3Yrg4HsJP+yjRuamf47bGi/w
         zy4e/dZa+hVi63J20UKDbKS/uRB3M4g0OAtYbPaKGuFtn1mSDqaMu1L2ft/LXKRZF69o
         LrT7kbVlEa1kZgIhKQEw1YTtFC+vnwBmfpe/TaH5cD4V4po4qwkz/UfxZjSc3iq9EckL
         2kCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLlih24JsL6WGRjluWc8tlhrf1DbRP2NPTcCoQKcun2GM6RG3X0nfI6HZhobgdJQLnYHQHCLyFZxR5F4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUSAjklhI5YCr2W4tXGR634yAuX1izhJHOBIK3Q4e6+HBX/l9
	cwQ1LOjlLBxO5f2EqmyRNiUgpaV83vsaVmOpM0Askl6Kz/FoCJrDyJSg1+PMg5wMNzYYbvJVVpb
	g5CuLlw==
X-Gm-Gg: ASbGncttRV1EbrsOaVCAckasaC5ku/21AuaRHdv2Pe7g/dF2I+kdkBWdawW68hel83m
	O91Bm9IpNrjcnQ27fnkfsdfJNGdUJPDhV0booGLXhv3HKc2dQYDrtCMDKs4mnofDvcxwkgwxS2u
	b9K1Y+4zhCYPF5gfC/tMd7pgAz8NWOCwWgSFXN/jGJIR8YR0pls9lah8LTgDwlnn0qAb2UJoIB7
	XNxxxthkDyq+OwwKxUnbqzgAGF4FOYPxnHwyhil2pjZ+J1KLsFEE5SQz7RD9Pv854FLEvSE8uS6
	G8BtpwCMtDZs1vI7Esi0uzQ1qiFl9nc2xdfMzw3P/8iTGOYdMrLfZjUQmwEz2YVaRIdaTj+QV7U
	M+y/oMLYSm2uaBg/ArP0=
X-Google-Smtp-Source: AGHT+IGeBe+33BWA8uz6Vl728NrGXlOnmm3LtwjjN46iLazLJciWHhC95S01Z2qZxS5TacJULy5cgA==
X-Received: by 2002:a05:6402:430f:b0:5e4:cfb0:f651 with SMTP id 4fb4d7f45d1cf-5e59f385a07mr551409a12.6.1741119945946;
        Tue, 04 Mar 2025 12:25:45 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb66fbsm8611530a12.37.2025.03.04.12.25.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:25:44 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf64aa2a80so590291966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:25:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUArF4Xu9UMQYXFQON1ivHozPXuetRn4XztnGwACVZbaBL+fFapdDwegqYFOKbch1mUJdeF9jMaaaV9BzU=@vger.kernel.org
X-Received: by 2002:a17:907:9496:b0:ab6:362b:a83a with SMTP id
 a640c23a62f3a-ac20d84509fmr57802866b.8.1741119944023; Tue, 04 Mar 2025
 12:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe> <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
In-Reply-To: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:25:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgtnKe+pH2Sx7C0u_UDzan6paTMesRDhAyDEAcCptyuuw@mail.gmail.com>
X-Gm-Features: AQ5f1JrMDxVLcTEMY5jJ6-t8Assg5ksjiB7T5IGpvzD8oxsD3xGemkRL0m8NNVE
Message-ID: <CAHk-=wgtnKe+pH2Sx7C0u_UDzan6paTMesRDhAyDEAcCptyuuw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 4 Mar 2025 at 09:56, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > While that may be theoretically true, the reality is that it produces
> > better code for Clang.
>
> Does clang even need it? Last we did any changes for clang, it wasn't
> because clang needed the marker at all, it was because clang was
> unhappy with the stack pointer register define being local.

Put another way: if we make this conditional, it would make a whole
lot more sense to make it conditional on the *compiler*, not on some
random kernel config option.

At least making some "use this to mark inline asms" be
compiler-specific makes sense. We already do exactly that for other
compiler issues (we used to have the "asm goto output" gcc bugs that
way, and we still do asm_inline that way)

And as far as I know, we've only ever needed this for gcc, and gcc has
never had any problem with just using %rsp as the input - whether as a
local variable or as a global one.

But regardless, changing from one very tested model to another, when a
gcc person already has said that the new model isn't reliable, and
doing it for gcc because of a *clang* issue, really seems all kinds of
insane.

                 Linus

