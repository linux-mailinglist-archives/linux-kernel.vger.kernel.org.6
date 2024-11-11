Return-Path: <linux-kernel+bounces-404426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303549C43A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3243FB21860
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5A1A256C;
	Mon, 11 Nov 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LnZDFPyh"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CB8F77
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346354; cv=none; b=VexLa2BbKHsT3k96OBVWyx6TSR9Oz6eAZlN76iFz3NlGRYKL+uDYBM+TpPZxh4xatg5t8Rf94MO0edvdLtsBX3H2Wfg4uZOSZlostX3XKwwcXBrUgCBI0Xl1NkyvGC16ORYitic432gZZfJruB3JeWG/8E2G+mQuCGgFCFm/I3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346354; c=relaxed/simple;
	bh=PPNNsS1qLG2J+Yv0Mjv/CI33UdPosqw6oofwmfziC1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+1tgZjJllg5Llmte77FvjVKDx/eCmrpWJvEZQqc0KyoOCHikED0Ez6JcgYptTCDp98biMLTieTQKyS0i1/xC7hkzb8fUuE8zmhwlRWEv2OfVAjST51dz4Vnmfo/oWLk6we5ReKRQ1ephuPHxvqgZm4+cXM1QyNSeNuGvfDjLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LnZDFPyh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7204849a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731346351; x=1731951151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMII0Va/Pc2J6Ok+zfB4lxRXeg8cQiz8GFTVesocEWU=;
        b=LnZDFPyhtV+aWaJykuKIudODpOk2BzPd5YBypID2oC217006ZjtUCxTg1lbIqEcy3w
         qOP2AhWdPRrGr4Ph7QCP4G1MKxJtlMdbUKFzGYYofaMeTPxCiPfgTOdfVSd+9CHy5Z/s
         c9BJLApSpaifXaHLLoe57Uf4s12sKOhpxd7L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346351; x=1731951151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMII0Va/Pc2J6Ok+zfB4lxRXeg8cQiz8GFTVesocEWU=;
        b=hzKC5M+uOil4Z8TOr+flwgAhZr6SZ+yLNcewuRrEROof6h4uMHVhntk4HrdvvkwYgI
         4PSEtsoirRkIcJQUz8xSrB4AjlWJo3c0HhNQV+NGcynExcfZfros+nsR8GzEUu9jpKI5
         Xj4nGVG8/+msGl9hH4+3jIKJGRsDllaW7eIC+XL5WtahxlFtyij7zU2XT3OvtIlkWki+
         JcCFr89UfhcwgW3rQWYqqL2LlBPq7vvUK5yicVP/eGfJjoqGGPLDyHK9P7uYsCyg7WLn
         Ju80hf1V66+uLe7VJw/bvQk2jBh8ocOPlYT5YCjSddA7sHk7G0tPT91/oJ6w+ZU/bEtj
         SV/A==
X-Forwarded-Encrypted: i=1; AJvYcCVFiwM4uHPkWJyzPKrTxK/amtQUhvkTUcJ/1/Ci3upZKOPl6nOJLvgm9atDdXW6SJdLPcghj3A8rBwkk/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySoblXGnT08dBTHbVmCr9Ayq4dYI9vstT/8aiHecGkj7CxOgpb
	IhqMJNfNMBHLQlYfhr5lnM0WyY9w5PteT7c7jzA5BvxuNREwJfZreBhsqkSQzzk5IqcQnw+b++s
	AxLI=
X-Google-Smtp-Source: AGHT+IEturMPuqTlcsLMoI99pVdB8Rj6CF34keghRyYYDS2vCWkCidXWU1UfyiYu3OouuWAbw52NqA==
X-Received: by 2002:a05:6402:13c6:b0:5c9:6f20:4cf1 with SMTP id 4fb4d7f45d1cf-5cf0a4442b7mr11168063a12.27.1731346349908;
        Mon, 11 Nov 2024 09:32:29 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf3d301d96sm1442558a12.39.2024.11.11.09.32.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:32:29 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso249173066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpCKXUOEnu2keqcJ7C5DVUQURJE83CxxPlWf6Qnra0UwUnd25sC7XZFRSDkUToKoCoMFe1O9tjkG5Si6E=@vger.kernel.org
X-Received: by 2002:a17:907:9494:b0:a9a:597:8cca with SMTP id
 a640c23a62f3a-a9eefff1308mr1311580566b.45.1731346348977; Mon, 11 Nov 2024
 09:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111164743.339117-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241111164743.339117-2-mailhol.vincent@wanadoo.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 09:32:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5SNYdgx8-X+ggHP+ojbG2F7oyt3TLmMgqejYd5zn0Aw@mail.gmail.com>
Message-ID: <CAHk-=wh5SNYdgx8-X+ggHP+ojbG2F7oyt3TLmMgqejYd5zn0Aw@mail.gmail.com>
Subject: Re: [PATCH v2] linux/bits: simplify GENMASK_INPUT_CHECK()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-sparse@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 08:48, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
>    - introduce _statically_true(), taking inspiration from
>      statically_true() as introduced in commit 22f546873149 ("minmax:
>      improve macro expansion and type checking")

So I really think this needs an explanation of what the difference is
when using __builtin_constant_p() vs using __is_constexpr(), and why
the existing statically_true() didn't work for you.

In my experience, __is_constexpr() is too limited, because it
literally requires a syntactically constant expression.

In contrast, __builtin_constant_p() often works for things that aren't
constant expressions, but that evaluate to constants at build time.

For example, I had a test patch that used statically_true() to do
things like "if the size of a user copy is a multiple of the size of
'long', call a simplified version without the byte copy part".

And sure, __is_constexpr() gets it right for completely constant
arguments. But __builtin_constant_p() will actually trigger not only
those, but also when the argument is something like

        if (copy_to_user(buf, values, n * sizeof(u64)))

because it sees that even if "n * sizeof(u64)" is not a constant, the
"is this a multiple of 'long' size" _is_ constant.

IOW, I think __builtin_constant_p() is preferable, because it not only
doesn't expand to the horror that is __is_constexpr(), it also
generally does better when you have the flexibility to use it.

Of course, I do think that the use in BUILD_BUG_ON_ZERO() requires
something that is more statically reliable, and so __is_constexpr()
that is purely syntactic is probably the right thing to have. So I'm
not objecting to your _statically_true() per se. I just think this
needs a big comment about why we have both versions, and when to use
one over the other.

                     Linus

