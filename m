Return-Path: <linux-kernel+bounces-436160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610449E81F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AE91883DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F296155C83;
	Sat,  7 Dec 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GfwJyppP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BA14C59B
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603335; cv=none; b=PdR3+Ll6PSQWxarGl1G5KDw/N1K7hIREcLpAxJiYaoMmgshsYVicVlnoW2yurQaGETZAJMyIl5bgJpKaHuXud7Jf5HUTi6j4fkiSdbzcXBZiQ4/4MD/69wAmIhw4YRgGtKkwcN/CXDXwi82Y12nFpcemxgXKGfUHDH609QX6MSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603335; c=relaxed/simple;
	bh=7mHyTv6r85AJbexntlqRENNWjYsWWzkVfT4oFafMmAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHPefWPpGQO81bm7vbdtta/g4zrWUNqZLR/bWvyrgvK2jBywDuUiZJzS6XV5D2zOHGypIiNcMk1aGZnnR6VfnkMHrKFn+nuCwxcIHz6vh2hpr61jOxm6+oKxR3icaJyG8ut7N7/waARqttBiAS3Lt8XDu6qjh5deozoO+RMegvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GfwJyppP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso521833566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603331; x=1734208131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=GfwJyppPOlIO8ZfZs4wfIpMio2yhh0dPq5nfrPaAq7d8oZV8brxgqsAP1hxRU/xi97
         TUjROnuWnOZ08xYQVYWpQWPU4tb+fZq3nYLZGgMsWKfLbPX8+Jh7mcfb55Q3QfULGps/
         b8ka4S9EIX/aZGfkpYLiG/Xziok0L9NncXilc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603331; x=1734208131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=fsfoz1mESUi8YjNYqnIkkeizw2XMtaQ+k/td5mdqZe/kbfohVRKQZ9QFgS3RyA9xfQ
         cdrbIXts+1HTZBdJhu4QucKkcf9Kcucfu6XUZiip4E4iPAdjZobkpy4Gq9iI18o5ATcx
         /fznpCi8hFh2yH6KTUs2wz1m7jP0z2ehVv7kjOAR9MPnfodUkqOY1AR7P4U9+kDv8CHa
         MXm9dxBr/8baZRl/qroSy40oD6JTyKw34EukQ/h793+EocmHr4myuV2ULgHLoTlhvanK
         lH3RdiTf+j6jYLU8ApqyS7B+rlQN7TgQnZ9RNJb6JO2vlI1HDBP2Sz7Io3TwKvw7Z0A8
         +zvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeX9rvqEjlQi0FNI/aX34jaAPVR33k3roN99IbSOHIndUvpDcMm2HJPOghyh8DoOWdh7xtA/7Vvs+HOqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pQXZq0C1fA9G1oZWMwWeC4mLcQY1Sd6NZf4qittwqTfDa2Br
	+RescqTtaSmQ3NFZsS5Xt1S2rVauid2AGOigN9q/e5/GAni1XjzC2N2vUDkjdJg7VpTojYRXWaq
	GzWqSFA==
X-Gm-Gg: ASbGnct+arCFf3qAahG3Hdtq9G3Sx0hx2LWy7/6BYJQYUgmA5R2Td0q7LFSmJP3V/ws
	VXRk0OgxXN0ZKfh90eGKobzXUOTikBNA8Ph2VipwCViJ9hd6oInwu4jJd5J5S2RcCYW79J2/VOn
	U33Y2T9pUVK85IAObH1htCHleTNCl3pt8TC4e4qjxPhTqxTGH4l+vKKpdMXK1i66M19efDs/CKo
	O2rKypMhtvFu85xwFjAWyW/nbE8jpA5PRQR5h+ztMmn2eHYtAo43VHOH6rdPgPk6o3jyx+zMoMO
	vkCBsjbDxPz694D/jDMUbf4o
X-Google-Smtp-Source: AGHT+IG75ZpQY1FWtQCqOgDwNBmupurunK1y1OW37sXiaNoVFHncnKwA1UNVXkpIvOEZ/iNiFTd5Dg==
X-Received: by 2002:a17:906:328a:b0:aa6:2924:4bca with SMTP id a640c23a62f3a-aa63a071390mr665264166b.26.1733603330728;
        Sat, 07 Dec 2024 12:28:50 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92a08sm429337866b.45.2024.12.07.12.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:28:49 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec267b879so604373966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 12:28:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWVyw0oOJs2vRlgY8bg5HKIjU5dZbzLETyN/ph7AKxsx6HiUitdOkpq4ZnDEx3bWXvBzXzuGRCwItgWJw=@vger.kernel.org
X-Received: by 2002:a17:906:5a52:b0:aa5:3853:553d with SMTP id
 a640c23a62f3a-aa63a21b715mr608706066b.46.1733603329136; Sat, 07 Dec 2024
 12:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
In-Reply-To: <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:28:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 11:19, Martin Uecker <muecker@gwdg.de> wrote:
>
> But that all seem solvable issues on the compiler side.

You know, there was a whole *architecture* that was designed and
predicated on "it's all solvable on the compiler side".

That architecture was pure and utter *shit*.

Because no, it's not solvable on the compiler side.

Getting things like value range analysis right on the compiler side is
fundamentally hard.

It's hard to the point where either you only get it for the simple
cases - yes, I can show you a ton of real code where it's trivial - or
you need to have explicit markings in the source code to help the
compiler, and then you end up having to have the compiler (or some
other tool) validate those with asserts or whatever.

And random asserts ARE NOT ACCEPTABLE in the kernel outside of pure
debug builds.

They may be acceptable in most other situations, but in a kernel you
can't just say "we stop now because it turns out the analysis was
broken and the manual notes could be fooled by an attacker".

Now, would we want to have proper value *static* range analysis in the
kernel for other reasons? Oh yes. It would often be very nice to have
the ability to state "this value is trusted and is in this range", and
have it percolate all the way down, both for optimization purposes but
also for various sanity check purposes.

But it's simply not sanely available in the generic case.

> a) this is not guaranteed in a specific situation (-Wvla-larher-than)

We'd either get horrendous numbers of false positives that we then
have to manually add special code for, or

> b) transform the array automatically to fixed size array
> of size X *or* something smaller when it can show this.

we'd just do this by hand *once* and for all, and say "VLA's didn't work out".

So yeah. We did (b) by hand.

We used to have VLA's in the kernel. It was a disaster. We got rid of
them, because the (big) pain wasn't worth the (few) places it was
actually useful.

So we have been VLA-free for the last five years, and it's been good.

Simplify.

             Linus

