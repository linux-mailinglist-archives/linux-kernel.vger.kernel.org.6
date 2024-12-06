Return-Path: <linux-kernel+bounces-435491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6559E7887
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB34C1887FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EA1D222B;
	Fri,  6 Dec 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UYvuoncw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63D153836
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511789; cv=none; b=uDRDNfTwuY8LTj9x01ICphoLHfH5YrNDRWBdpGVFqKUVWsB0S22i6FsIdfLEGT0r8fDRmweZLDO+Ec1pmh7hqdAlyJyd5wNu8T9KGeTp/7fdvY4Kvo75TbCQxCks63DN+mZdVl5hdAb6vN+msqcbQmB+wOca33AkHbM6IPpBtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511789; c=relaxed/simple;
	bh=mpzJOBPMyEgZbeHSaWVVY8PUqVjZS+sd0oYWuGX6RdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwb//FZGNwGEvMMUj0bWieG//4N+DQ02HRkgGGFo9WlCG1df1vVEi90Btu9PwcZHJRjX4KupSamTVUSNcRurgIs3aUVerfd8sLWPkuqQJAaa6ydEyMkCuvF19Z5aE/EvyBKTKMi0aORrRwz4Z26k1BLpkLSnwlISp5fLAPXOSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UYvuoncw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d10f713ef0so6315132a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733511785; x=1734116585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=UYvuoncw2AY9fp5PlKtkmgXeThFO9CAuOxEuUEQD8Vyj5zmr8+yxj/AdvUCEou8d7i
         JzE5PmRK3fyc3YZl25lA5mlLASaW7j4nj8MUL7gTQjfI0OswfVxGmxMTA/H/LzrizdbZ
         e6CdUHBJi8cN1qVQ3NeOFbu3ZgfNowpn43aZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511785; x=1734116585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=OLT5M3Q/arZbszLuuCxr6C77UtOvYAo2ayG6LGO+imrKI6hYGnpreOVIPq7E7zkbXF
         DDvqKzdZwv9lLWHbNOe0+MiadStEr1qd8XkgynuxF+/Hwjz21lOOnG1RBBm8+g0Mzaxd
         KvJ3bcIOj0t+7ycTtX7bm4OD8nheLaYZhuGo1XET2oGGrA5OELOzYn2+8XAetp7rlcus
         HKNCw/uXzrm8Iea7qn9iDcHcORigRDA1K95SuYCBWiEtTEr07Ra7l3E/qdPawOyPw4vj
         ib70CGsLw6H0ABodIJ5Anph3cHHgvREKyyVJMztf/yQeEvCB0SqQdcW7BwUMoSbvKYim
         4sMg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZVrZxm9UCFxYgx+/zYdl3ph/FCIko+2TB6XQ6H1DaDGvjz4z1dh3CadMpxvonAxTgf8DEk5/jdN6yYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGZ5GfnGrGebfgGyVvz8N04oiYC2RKPFd2vpWFCrHoEezZi8l
	INEzEKEOgAAsaepso7auOkG/KQVdTqQXk/YB/1/PEFkCzqizHyFcToVL6JCudNLkh7fbgxzexfc
	zgc9ong==
X-Gm-Gg: ASbGncvHNdri094XggZD1c4RBM1U35M7fgRdPAZHmAMygrlTJGocfYqyVGkzjjLI0iu
	8clfRF1ftetnNCGPMV+u9SlAsKiJOs81dvOscVLEtSYWppEBmVt+tXo0GEwyZUch/T7SEmgS/zU
	VLkxednUDPi1N+xfCl6joThrYOGXtQAEwTN2PxXSNaNCTm8VwcrUvsrQdWvZfcPz2UvqXX7vKBW
	ulMjfN43wQUuq11TB9mG1oBQna1lT0fUcQuG37EKmsQ9fZNfNGvXJ0eIIc8JKM//Z2FLbUBpgXP
	UliykYclvvFnUM9NfLLqTKBWH+EJ
X-Google-Smtp-Source: AGHT+IEdJ+Kk0mMrXb6GzijnWwfHFKmgOUNp5PDaKSnwWm/+Q2QFVWLRju8SxsBXaeAn4c3iRzSv3g==
X-Received: by 2002:a17:907:31c3:b0:aa5:b8dd:fec4 with SMTP id a640c23a62f3a-aa6202e01efmr852287966b.4.1733511785516;
        Fri, 06 Dec 2024 11:03:05 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260a3beasm278586166b.162.2024.12.06.11.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:03:04 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa560a65fd6so423811966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:03:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsFsNVjyqsLU7ckryrIgPQUG9aYugVySAbY0FUhMG6pMlRpKKESEKhXtsTaSl/onr21OjNBDVgIp+wjpE=@vger.kernel.org
X-Received: by 2002:a17:906:9c18:b0:a9e:b5d0:4714 with SMTP id
 a640c23a62f3a-aa6375f5cd6mr310802966b.21.1733511783880; Fri, 06 Dec 2024
 11:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com> <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:02:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This may be a case of "we just need to disable that incorrect compiler
> warning". Or does anybody see a workaround?

Hmm. The "== 0" thing does work, but as mentioned, that causes (more
valid, imho) warnings with pointers.

And it's not necessarily require that a pointer expression actually be
marked as a constant, as for the fact that these macros often get used
in various arbitrary contexts where things *might* be pointers, even
if "not constant" is a perfectly fine answer.

We do actually consciously use __builtin_constant_p() on pointers.
It's very convenient for format strings in particular, where
__builtin_constant_p() is a good test for a constant string, which
sometimes gets treated differently.

And in fact, dealing with NULL pointers statically might be worth it
too, so I do think it's worth keeping in mind.

               Linus

