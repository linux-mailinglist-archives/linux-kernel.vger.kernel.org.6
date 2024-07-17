Return-Path: <linux-kernel+bounces-254676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7820933645
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886681F23D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750FBA42;
	Wed, 17 Jul 2024 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KwGAkvSz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65960B67F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192918; cv=none; b=UdeNe8C5QB3bnGFXXfc/mJ8ixzBXma33TdHUrAzBZlvaBnLYY9yv5GJtHT39+uEOcHc2n9uVOysL7+RDbXf/juc1NVb3toDS9kqTA2sOXBgfjV4/yBWG7JrkU86BbFELWHWcwI4QDHZELtDV3maHQEx+EVle0YjhIwerQ+ZybjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192918; c=relaxed/simple;
	bh=456vFjdQgX8t+DKO4cXNe0nbngfpEhmfIZpf1Fy7zRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu1TS4MVtK5h541+OV0BaPrCKbifk9ALUnC6Mp7oxpC/c7q2w7PBm2aFX1z6jgTnruAENA4gZB1RW4jNL68NLiFqC54h24L1vTjvid54DyV5CmALTeVvxel9N0KqUMG9KDzv+CJ+EoI+a7Ja27Y4LhfcqtM4UTcM5fZoNedPqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KwGAkvSz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ee4e26790so327469e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192914; x=1721797714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=KwGAkvSzI3nMfUR/yLeMrhnZU0Q+8oDnMp3St5LbPJgvi8QQWsYjxFMVcgiCKm8xxu
         dpwpOd+Ij5sw7XnA/KsGjM1NWOWK8SBe6bvcEJbPq2P7sXVRKg5HsY0mXcZVvmDbL7M7
         XcJLb0bj7NZTio7h26FJ0JFqqs+qlIH0ZVG0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192914; x=1721797714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=LAxuSMAea6g/1/eq5cUW6ZXkvUfhgud3v1iqM808FucyxmLIUUTRHEJlbXac1w9Gdh
         KHONZDV2vc9PXeny4iFcjTRLaxpWRV7xnzPbMKBPaQvSBS3bX+Dj1evKCylHXfnRzeuN
         lT6I4y6Zya6dUHE7mEw6izA5gq495Km66xFyLVjUvegmNHHE2ScqHElN0iM/IGOyub0t
         VmmYs24s8ymJppBiYGtmV8eww3hd9+B1hb8bYPawfF76vfB/5hUTi1DQkW8ah2VC6suO
         NZ/gDXvZ33M7lPw28h06h4nMhk9p9Uort+Vw4fynSly0wa6vKzQAjUhnFe6feIU1o0x/
         W/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWwAXF8UuofUKB9sMIPBp42kcNPeAd10FstCiJrAftAZosVjbsDyYCHqX4hnvXEGW8ji+NtrYexgEJkKb1GJOx0MDDU16c6ZJ4Heusc
X-Gm-Message-State: AOJu0Ywf8gyEgDSSods32G3X9InmZhzFshzHWpeO8TKLLfyhNgd3HfD9
	Jhmcv/pHU5DsOul6ScDfXmCMs0liS8OOq2PVmq9cHOEHdz+VdHE7hrRLJekQ5QNTxIEF2DmUfdb
	SBoBxMQ==
X-Google-Smtp-Source: AGHT+IFexVR3DXzbXq+REqK6cUX41qMGeP7AnVTyik5mqSn4jsbUpliuI2yHPkh81g2Kif1UaMS3mw==
X-Received: by 2002:a05:6512:1391:b0:52b:839c:78dc with SMTP id 2adb3069b0e04-52ee53d656dmr342045e87.29.1721192914161;
        Tue, 16 Jul 2024 22:08:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e1ec8sm1360743e87.14.2024.07.16.22.08.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so89449741fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg5Lh4VN32dXASBAY9vMCtiQ75MeHiLBqsCjU8J+sc67sYrbHTCLG7RPHrs7L22Qs7qVVXdg/+eeDnHkth98Ygp1OwML8SFUtfTVmb
X-Received: by 2002:a2e:3a1a:0:b0:2ec:5f6e:65ea with SMTP id
 38308e7fff4ca-2eefd1bf195mr3375661fa.38.1721192913022; Tue, 16 Jul 2024
 22:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com> <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
In-Reply-To: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 22:08:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note, it really might be just 'allmodconfig'. We've had things that
> depend on config entries in the past, eg the whole
> CONFIG_HEADERS_INSTALL etc could affect things.

Oh, and my "find" line was bogus, because it turns out ".config"
itself is only updated if it changed, which explains my confusion
about some of the other header files.

So it turns out that to get the real list of rewritten headers, you
need to do something like

    make allmodconfig
    touch .config
    make

and then to make it faster, you just  ^C after five seconds, and do that

    find . -newer .config -name '*.h'

and _now_ it's meaningful, and on arm64 I see

  ./arch/arm64/include/generated/uapi/asm/unistd_64.h
  ./arch/arm64/include/generated/asm/syscall_table_32.h
  ./arch/arm64/include/generated/asm/syscall_table_64.h
  ./arch/arm64/include/generated/asm/unistd_32.h
  ./arch/arm64/include/generated/asm/unistd_compat_32.h
  ./include/generated/autoconf.h
  ./usr/include/asm/unistd_64.h

while on x86, the only header that changes as part of the build is

    ./include/generated/autoconf.h

and all the other files I listed were just because I hadn't noticed
that "make allmodconfig" itself avoids the write of ".config".

So that "touch .config" is needed.

Or just use another file entirely to flag the "this is the state
before I actually started the build". Which I probably should have
done instead of thinking that "hey, I have this .config file that I
can just use as a marker".

            Linus

