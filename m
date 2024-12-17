Return-Path: <linux-kernel+bounces-449712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046C9F552E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0B1763C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFE1FCFC2;
	Tue, 17 Dec 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDL/rrBu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBE1F8AE2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457474; cv=none; b=M+PgbeedtYGL7eOkQIjaavllC2QtzsuIbAZzS5ufKkRkjoLPvFVyVnpowTyA78TGdJHPI6Zb/zFPkFeCzjmelK54NhzYweEqQC7LthOgU/RkYaPk8BRzYFXNE1INMklQgX2fA+yoKPqCinX7NbveHUitfkxVGgZk9BZlzgg2B7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457474; c=relaxed/simple;
	bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgN+nfRjKOe7NV3Y7l83u746x3XA2c0ETt0A/oh/5rSPOJqOhYW4TFiJb+Sa24tQ8RkR7Jk2tsXWrSzon2Wn3Is7aG4WuLgN1aLP9Y4kHktLxPCX/uz1UnKke8YAQA439euo6WsLqmDOhSUWN8qxFa9HIk2uolzWYGKDW+P3zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fDL/rrBu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3c47434eso5609549e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734457468; x=1735062268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
        b=fDL/rrBu3vzkYPSRfzHBrtJLSKmFpO0nRMYCq7oG2RQPV02jBNPC6zbp9c5crHnQAl
         EdG/x0/ZSTdWzDz2HPGznpm20dV7S7i+iW/QLj5QazwFTbh28i05nn0d6oPZR9n3Q4IJ
         dzAYlMYIacvhjQKMbQzW/grjX6VtFNR76JQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457468; x=1735062268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
        b=MKWFunu9pBPfYeBFKxV8XBM7Y41JtJQbJLYZbkf3xi6ipOTVBV2Rce6MSRvSEbn0qr
         2DgldPE9Mzn64S0z4c3k/+oZH6wpHmjyN+k51uaTY/ejNr0PAa3NJiQkNE1/n6MvpQVg
         36CIyVBHHKYEzrwzPVNI4s9j7jaYhCW08TVDVtNsCUTVuW92fQ5f1SXP2RD7Ub1Bv183
         ofIR0hxG0EJ0qJ4rXdQmPioyfJRsFKUm02xVkLikIdny/tREVoie5Rzr6Kxbi0Ev7Z9H
         uizwyb3/KZxGKetMVF9UkXURE2pbCqYziYHEvkX14My0yPY1iiMeYMxei8oRPy+tQFvz
         mrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8zX3TA0HbbuXuAzbhpQCzytw5BDagsb8WbTp/3OqaxtzWilIDir8lkNtHQSDtszU8ZZELwsbuFeBkx+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXd/CbTeI5VBFjS5/V2Y3zU0fOPxgMuj6kU7BsTha1Mz0svVX
	omLaCxJtkOyBnESwdR4dC+bvprVtiXFyc4uvFdsdA+5lnnmLtkH5FOdzgqOlkk2VwQOTq93MyWr
	MEg==
X-Gm-Gg: ASbGncuYdAgo+sTtiLNfOG64I2C6rwPj7UOwtHR5b+QpR+d2TgvNmHMJYGu4Gvx6lgB
	b3OlYRDD0kpbzZvT3liP4ExfgkEu6aCRCacRKIR6JIfm3IYPh6854cvRvKIE0fvwqZHg2mXNTja
	/EsOyUluEMyhxgirBGxDhwRIQqBVVc0ARsBvL1JCKA3hxxTtb4mz99oJvgAUT5MaDGM8TY/Fc2t
	CtQmM//0jBqdvA5sv3xY7k0VKaWkSpS6TyhvBmVj1LgDPaOoA74ZOez4YW5as/Bg/OxPFqb9bo2
	uGZGLfx4p99rci/sajgA8Lyp
X-Google-Smtp-Source: AGHT+IH1Kl1tpQiV8OU5teVrL9YcLkAJin6JvGGm8j5cGhnJG97ySdwN+f6kALAfnXkVpqpCRavAKw==
X-Received: by 2002:a05:6512:159d:b0:540:358d:d9b5 with SMTP id 2adb3069b0e04-541e0f351femr14459e87.0.1734457468041;
        Tue, 17 Dec 2024 09:44:28 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b43sm1208749e87.81.2024.12.17.09.44.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:44:25 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30037784fceso55119231fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe2GqJSK+HVqbJdAGf3tYK942YiwldDGCFbcdmW7iedS5Q7oEikZa7jeizBIJt0g5VOXEQ9sHbf9u0qWM=@vger.kernel.org
X-Received: by 2002:a05:651c:2108:b0:302:3de5:b039 with SMTP id
 38308e7fff4ca-30254566a55mr66069711fa.8.1734457465327; Tue, 17 Dec 2024
 09:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
 <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
 <CAD=FV=UHBA7zXZEw3K6TRpZEN-ApOkmymhRCOkz7h+yrAkR_Dw@mail.gmail.com> <CAODwPW8s4GhWGuZMUbWVNLYw_EVJe=EeMDacy1hxDLmnthwoFg@mail.gmail.com>
In-Reply-To: <CAODwPW8s4GhWGuZMUbWVNLYw_EVJe=EeMDacy1hxDLmnthwoFg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Dec 2024 09:44:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X61y+RmbWCiZut_HHVS4jPdv_ZB8F+_Hs0R-1aKHdK4w@mail.gmail.com>
X-Gm-Features: AbW1kvbAgvCz7vA_yFdhIVykkakAa4L6Lz2IE9DR-f5ZjOd70MgEn8kxRtbYbd0
Message-ID: <CAD=FV=X61y+RmbWCiZut_HHVS4jPdv_ZB8F+_Hs0R-1aKHdK4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Julius Werner <jwerner@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-kernel@lists.infradead.org, 
	Roxana Bradescu <roxabee@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	bjorn.andersson@oss.qualcomm.com, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 17, 2024 at 5:25=E2=80=AFAM Julius Werner <jwerner@chromium.org=
> wrote:
>
> > > - Refactor max_bhb_k in spectre_bhb_loop_affected() to be a global
> > > instead, which starts out as zero, is updated by
> > > spectre_bhb_loop_affected(), and is directly read by
> > > spectre_bhb_patch_loop_iter() (could probably remove the `scope`
> > > argument from spectre_bhb_loop_affected() then).
> >
> > Refactoring "max_bhb_k" would be a general cleanup and not related to
> > anything else here, right?
> >
> > ...but the function is_spectre_bhb_affected() is called from
> > "cpu_errata.c" and has a scope. Can we guarantee that it's always
> > "SCOPE_LOCAL_CPU"? I tried reading through the code and it's
> > _probably_ SCOPE_LOCAL_CPU most of the time, but it doesn't seem worth
> > it to add an assumption here for a small cleanup.
> >
> > I'm not going to do this, though I will move "max_bhb_k" to be a
> > global for the suggestion below.
>
> If you make max_bhb_k a global, then whether you change all
> `spectre_bhb_loop_affected(SCOPE_SYSTEM)` calls to read the global
> directly or whether you keep it such that
> `spectre_bhb_loop_affected()` simply returns that global for
> SCOPE_SYSTEM makes no difference. I just think reading the global
> directly would look a bit cleaner. Calling a function that's called
> "...affected()" when you're really just trying to find out the K-value
> feels a bit odd.
>
> For is_spectre_bhb_affected(), I was assuming the change below where
> you combine all the `return true` paths, so the scope question
> wouldn't matter there.

Ah, right. OK.


> > > - Change the `return false` into `return true` at the end of
> > > is_spectre_bhb_affected (in fact, you can probably take out some of
> > > the other calls that result in returning true as well then)
> >
> > I'm not sure you can take out the other calls. Specifically, both
> > spectre_bhb_loop_affected() and is_spectre_bhb_fw_affected() _need_ to
> > be called for each CPU so that they update static globals, right?
> > Maybe we could get rid of the call to supports_clearbhb(), but that
> > _would_ change things in ways that are not obvious. Specifically I
> > could believe that someone could have backported "clear BHB" to their
> > core but their core is otherwise listed as "loop affected". That would
> > affect "max_bhb_k". Maybe (?) it doesn't matter in this case, but I'd
> > rather not mess with it unless someone really wants me to and is sure
> > it's safe.
>
> Yes, but spectre_bhb_enable_mitigation() already calls all those
> functions on its own again anyway, so I'm pretty sure the "must be
> called once for each CPU" part of spectre_bhb_loop_affected() is
> covered by that. (Besides, it would be really awful if they had made a
> function whose name starts with is_... have critical side-effects that
> break things when it doesn't get called.)

The existing predicates already do change globals before my patch and
changing that is outside of the scope of what I'm willing to entertain
with my patchset

Given that I'm not going to change the way the existing predicates
work, if I move the "fallback" setting `max_bhb_k` to 32 to
spectre_bhb_enable_mitigation() then when we set `max_bhb_k` becomes
inconsistent between recognized and unrecognized CPUs. One gets set in
the predicate and one doesn't. Even if it works, this inconsistency
feels like bad design to me. Also, setting `max_bhb_k` to the max at
the end of is_spectre_bhb_affected() would perhaps _help_ someone
realize that the predicate has side effects because they'd see it in
the function itself and not have to dig down.

I would also say that having `max_bhb_k` get set in an inconsistent
place opens us up for bugs in the future. Even if it works today, I
imagine someone could change things in the future such that
spectre_bhb_enable_mitigation() reads `max_bhb_k` and essentially
caches it (maybe it constructs an instruction based on it). If that
happened things could be subtly broken for the "unrecognized CPU" case
because the first CPU would "cache" the value without it having been
called on all CPUs.

In case you can't tell, I'm still not convinced and will plan to keep
setting `max_bhb_k =3D 32` in is_spectre_bhb_affected().


> > > - In spectre_bhb_enable_mitigations(), at the end of the long if-else
> > > chain, put a last else block that prints your WARN_ONCE(), sets the
> > > max_bhb_k global to 32, and then does the same stuff that the `if
> > > (spectre_bhb_loop_affected())` block would have installed (maybe
> > > factoring that out into a helper function called from both cases).
> >
> > ...or just reorder it so that the spectre_bhb_loop_affected() code is
> > last and it can be the "else". Then I can WARN_ONCE() if
> > spectre_bhb_loop_affected(). ...or I could just do the WARN_ONCE()
> > when I get to the end of is_spectre_bhb_affected() and set "max_bhb_k"
> > to 32 there. I'd actually rather do that so that "max_bhb_k" is
> > consistently set after is_spectre_bhb_affected() is called on all
> > cores regardless of whether or not some cores are unknown.
>
> Yeah, you can reorder the loops too. I don't feel like moving this
> into is_spectre_bhb_affected() would be a good idea. Functions with a
> predicate name like that really shouldn't have such side effects.
> Besides, I think is_spectre_bhb_affected() is probably called more
> often per CPU, both once from spectre_bhb_enable_mitigation() and by
> whatever calls the `matches` pointer in the cpu_errata struct.
> spectre_bhb_enable_mitigation() seems to be the function that's called
> once for each CPU on boot to install the correct mitigation, so that
> feels like the best spot to put the fallback logic to me.

As per above, while I agree that having predicate functions w/ side
effects is not ideal, that predates my patch series and I'd rather
things work consistently.

-Doug

