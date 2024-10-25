Return-Path: <linux-kernel+bounces-382716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA39B1298
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15B9B21E65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0B1D222F;
	Fri, 25 Oct 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R2vq4Vur"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337431D27B1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895509; cv=none; b=OEES0RL8VXFfI8f4Hh4wVLCeNDgtLuDWOSXIAmqFJx1jLDpJo72ew7GvBhYTYISLREoDWHRHNGp0LuakfFEuIRDPJj+gS5angBp9vu+4TZdQz9Q+a2xZEQxjRjZ/BxHpJR6aC02d5DEIdalwAMUtLPYJpOkEb65ztNl2YeBdfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895509; c=relaxed/simple;
	bh=NkHx6XgJkMV6CszYdB/P297/hMHuzzGQvrdB5FeGWxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O46my8devpA65AidncBMNfgIrHIukQs3g9o7IT8D7jqAZV5oQbXUbHjrwVu5mgtqqR4Enbnf418hJBfYiM1+xrhPmgWGwH5WFOoRhN0UYdKmkqZvNB/FFWEW2Btvm72x+FmkVHU4NOG4K05UVk79B5FdlTDo7z3op2iNE/ChsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R2vq4Vur; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e6c754bdso2396108e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895503; x=1730500303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFr8zCuXx7Qa1HYksDWyqy8DL1qhBnHCzBZwSDddfWM=;
        b=R2vq4VurDtGII7xm/P4GCfCPrr8tWbOuATiWwDtQMxsVjMR2jD/kgRMvX5j5TT/zps
         ekjDGT6KLdPF5n8gCnr6voy7kZOfZE9o76bid/NOYpgyfaGf6IpQnBBhABsHRwVwvk/E
         m97AwAUzPM1jnr90xmCHfE6XQAy4EC4IwqkkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895503; x=1730500303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFr8zCuXx7Qa1HYksDWyqy8DL1qhBnHCzBZwSDddfWM=;
        b=Pq6OpX5Dj2iLnLF4uzSjqyjjzEcXp0N90a/8nNCr3tyTR7cKBDPQsPOu1AMAqHu2sp
         ZigJHJk5u8UcHdKWXlkaufOaQqkxEkOmL78foktUbdSBGATeXxyUHXrXUt3dmA8ateUY
         vgLMrAGmdXCttCaOwKFYW9vKNltJHaNCxwSg2yQzFzWz4fT0QCNLc6RugIntwZXT6H6B
         KO6nPt/mPnyBGufPVugCcIJJn95REAykaDWc8Z01utcsNGnaELYx1Gmty7Yr6woKN6JP
         gsgCISCmKsLAkVskUcCCmzRnLMkPmgMwIDR/JYUxvtxAZfT1l61kcTWDxCiEQEUnQoz5
         iBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhdI/fTw7yVGA4A4j5eVqBaZWXKkMqPOt9bxCN2BjJMbD7yQBTJmCg24JBNIxLVYzRqKuJUR7+QSbf4cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfF1Kld1RejRV60zo8sdhBBQVO2gs+bm6mxd/BLKtZfcw5b6VN
	tMbmXRG9GJBNsBZkvAWMBT6q667QjaJ659z2pEBC/anObIf6ux/zf2muL7JB9YqH7fqN9BAVylo
	ZRA==
X-Google-Smtp-Source: AGHT+IH2HKWbnQTZAWtM4lKlkbQhLZsqICmU7IWKKf41fsKM9sewswoIO5GgKrClCVCCbf9xIkmDtw==
X-Received: by 2002:a05:6512:3b0c:b0:536:9f72:c427 with SMTP id 2adb3069b0e04-53b348e5635mr351412e87.28.1729895503189;
        Fri, 25 Oct 2024 15:31:43 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1e1552sm331131e87.266.2024.10.25.15.31.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:43 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fc968b3545so26098571fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfN4jEvq5HO0BuEuHAam/IBYREdJQvToZ64W7dIknunfCyzgMeJb6V/HsykvIJ95iu9pMD8frDSFxDRO8=@vger.kernel.org
X-Received: by 2002:a05:651c:b09:b0:2fa:d604:e525 with SMTP id
 38308e7fff4ca-2fcbe077e48mr4065661fa.28.1729895501542; Fri, 25 Oct 2024
 15:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211451.GB835676@lichtman.org>
In-Reply-To: <20241021211451.GB835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJsUZ1+v5Rd+Pcx+3tO18ivgax4i8XfRg2BZJ_OEEu+A@mail.gmail.com>
Message-ID: <CAD=FV=WJsUZ1+v5Rd+Pcx+3tO18ivgax4i8XfRg2BZJ_OEEu+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:14=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these functions successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strto* series of functions
> with their safer kstrto* alternatives.
>
> Side effects of this patch:
> - Every string to long or long long conversion using kstrto* is now
>   checked for failure.
> - kstrto* errors are handled with appropriate `KDB_BADINT` wherever
>   applicable.
> - A good side effect is that we end up saving a few lines of code
>   since unlike in simple_strto* functions, kstrto functions do not
>   need an additional "end pointer" variable, and the return values
>   of the latter can be directly checked in an "if" statement without
>   the need to define additional `ret` or `err` variables.
>   This, of course, results in cleaner, yet still easy to understand
>   code.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Since this was Yuran's patch originally and is still substantially the
same, keeping their sign-off first was good. ...but:

* You should have kept Yuran as the "author". This should have
happened automatically in your local "git" repo when you picked
Yuran's patch and then made changes. If it didn't you could manually
set the author with "git commit --amend --author=3Dblah". Even if it's
right in your local repository, though, it won't be right when someone
applies your patch. This is because when someone else is the author
the first line of the commit message is supposed to be "From: Original
Author <their-email@address>". Your message doesn't have that so when
I grab it it looks like it came from you. If you use a tool like
"patman" or "b4" to post your patches (or even git-send-email) this is
handled for you.

* When you take someone else's patch and make a small change it's nice
to mention what you changed in the commit message.

If you want to see an example of where I took someone else's patch and
posted it, you can see:

http://lore.kernel.org/r/20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8=
ae8514dc004@changeid

...though maybe ignore the fact that I managed to accidentally add a
Signed-off-by for both of my email addresses--oops. You can see that
it has a "From: " line that patman/git-send-email added for me and you
can also see my mention of what I did:

[dianders: rebased to modern kernels]


> @@ -402,42 +402,15 @@ static void kdb_printenv(void)
>   */
>  int kdbgetularg(const char *arg, unsigned long *value)
>  {
> -       char *endp;
> -       unsigned long val;
> -
> -       val =3D simple_strtoul(arg, &endp, 0);
> -
> -       if (endp =3D=3D arg) {
> -               /*
> -                * Also try base 16, for us folks too lazy to type the
> -                * leading 0x...
> -                */

In my original response [1] I suggested that the removal of the base
16 fallback should probably have been done in a separate patch (in
other words change this from a 2-patch series to a 3-patch series).
That keeps the "cleanup" patch separate from the one that's changing
functionality. It's not a huge deal but it would be nice if you could
split it out.

If, for some reason, you didn't split it out then you'd certainly have
wanted to mention it in the commit message of the patch since it's a
change in functionality.

[1] https://lore.kernel.org/r/CAD=3DFV=3DVZ61XFb1Ks79BHr1jL1jwf_36wYXryy0ZX=
Oz1xTQ9zOg@mail.gmail.com/

