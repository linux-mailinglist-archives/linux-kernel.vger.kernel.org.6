Return-Path: <linux-kernel+bounces-345020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB298B12D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2863EB2180A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5C185B62;
	Mon, 30 Sep 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyL74MF4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9843155
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740236; cv=none; b=YLcbu0XnFEaUWZgCcm+R3p9+idXGulru7/AeYvY2gaD2DVQP0QhcZ8ZZoYXzj/1eHOrZU0eVIcqMehNJbSP/+Jx6qSW1Nwkf+SEhML5rvl9frJfLfX3wIkm1g7QpNW7g8rCWhDpYnzc+IXWEvawJuqaj9fuAxUdfl8NWd7CGyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740236; c=relaxed/simple;
	bh=ACR2yF7nK6QESAC6N8xK4cXTeJMrNfd0BEmVWi7NIPU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfXjwM3PHOOTUB3IMQSZZ/F32jCDSEtMTo8B5lTG1h+LbYNSkDLnUheCfZHcuHEWm9RP2SqkSoYqION142aLOPw+2VnlJ7B4XwKEuj511nIZq4R9V7X6YW6wgKzbfZgM6OLkiErxh5xwbxpVxuc390cOL3bfr9amXcznveUlcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyL74MF4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ba6b39a78so5893685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727740235; x=1728345035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZphdxYxFvquInnU61Cl5DN5V0h/wyqmirweAd2bCCLY=;
        b=kyL74MF4TUbEw8RDiSmiq0YtAgTLU9ofhzpSodVFU3PqNh2WTo/EPIvX6fwl6uPOhc
         EcW7cBhVUx5CFAM/umtJkDCuAgGFiV3GIDYQeKmtBOZxPaa/E619cxNbt1W0Tw+q5Dh7
         9VCA53Q/eNXLZkTCZx7wXKeO7OTUybD/o6XuM0gJkhFsWvrtuDaumwrcKMuXmh/INyrD
         2F79loEaMK+imew8p6EOFOjaDE8aIzmNrgvwMjosdEjUVEr/LWlTZIH7UvF41/1ZihLP
         n+la69xegCALhKDOI/ZgmCnZfepj0ZSb8dPcL+stddy6j224Sot4d48YRdBXH2DVkBKF
         QKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740235; x=1728345035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZphdxYxFvquInnU61Cl5DN5V0h/wyqmirweAd2bCCLY=;
        b=Pfhk7N6ejCZDKR+CTsOTa6oclsayQiKZjHpkgHvbcARaV8ZwNezluo2ph/wCqZznBF
         sMaSMEVykHXyWwDy1kH7brpQ0JVM5AwJkQ7alL6chaSAWtCyh/daO7G3YFb/NHtKFZCo
         TIfzbhAVSwZsjUpMVVWT+ut3mgptYJBzoUmQFUpRH3SFXLU+k5NpXYMHsQbrf3bSoDfI
         DYgwSmNavMKzMuYZzpuzJR2+qMG5UIUnOIwqekIn1cHLdrrqTBbc4ciZsuUg5I1pWMqB
         vua4Q8ZdsMV8nLvy6SB5Lynaa6MEJtTKNFjCqiddzyo8xOwOCOWpo8kUtJ+uoerAh3Am
         8KIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUmb37UBI4fN44TJHisyYf3OoT/EKmQDFvGLPkdPhqtAP5vVvo3BoB4lCN7VM6mTM76zYt0FwCakayspg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwlXA1V//tf/qIf4khSwKPkR7zXpBeiSiXxnecwjskQ0I+WPc
	lOh9/6KKdCHKV+9aGYbyUlz7fXlwMzltINO0hnk7xYGuojxXZaO1fudbgQ==
X-Google-Smtp-Source: AGHT+IHw9imh6kU797aMUTgM03ml/Zz1Qr+ClzSsNBMyLqUyLeHNNI08BGLOVD+IQ0f+t69lkGyKOQ==
X-Received: by 2002:a17:902:db06:b0:20b:8d5f:a918 with SMTP id d9443c01a7336-20b8d5faae7mr61852975ad.57.1727740234530;
        Mon, 30 Sep 2024 16:50:34 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0fa94sm59383895ad.135.2024.09.30.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:50:34 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 30 Sep 2024 16:50:32 -0700
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
Message-ID: <Zvs5SJ/dAojRneC8@kodidev-ubuntu>
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
 <CANiq72kqVFs5rfS_y0a40ZAygE5S+vkyb2Fv+B5BNzvuAa_hiQ@mail.gmail.com>
 <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>

Hello Geert,

On Tue, Sep 24, 2024 at 08:30:30PM +0200, Geert Uytterhoeven wrote:
> Hi Miguel,
> 
> On Tue, Sep 24, 2024 at 7:21 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Tue, Sep 24, 2024 at 3:55 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
> > > the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
> > > x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
> > > The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
> > > fails in the same way:

[snip]

> What's your definition of "all"? ;-)
> 
>   1. All compilers available on Ubuntu 22.04LTS:
> 
>       aarch64-linux-gnu-gcc-11
>       alpha-linux-gnu-gcc-11
>       arm-linux-gnueabi-gcc-11
>       arm-linux-gnueabihf-gcc-11
>       hppa64-linux-gnu-gcc-11
>       hppa-linux-gnu-gcc-11
>       i686-linux-gnu-gcc-11
>       m68k-linux-gnu-gcc-11
>       powerpc64le-linux-gnu-gcc-11
>       powerpc64-linux-gnu-gcc-11
>       powerpc-linux-gnu-gcc-11
>       riscv64-linux-gnu-gcc-11
>       s390x-linux-gnu-gcc-11
>       sh4-linux-gnu-gcc-11
>       sparc64-linux-gnu-gcc-11
>       x86_64-linux-gnu-gcc-11
>       x86_64-linux-gnux32-gcc-11
> 
>   2. A few from kernel.org crosstool:
> 
>       ia64-linux-gcc-11.1.0
>       sh2eb-linux-muslfdpic-gcc-11.2.0
>       arm-linux-gnueabi-gcc-11.5.0
> 
>   3. A compiler from the J-Core folks:
> 
>       sh2eb-linux-muslfdpic-gcc-11.2.0
> 

Thank you for testing the gcc-11 edge so thoroughly. For my testing, I
used a handful of gcc versions across 9 to 13, but ironically only
tried gcc 11 on x86_64 (which works... :-\ ).

> > > +#if GCC_VERSION < 120000
> > > +#undef __retain
> > > +#define __retain
> > > +#endif
> >
> > Should this go into the conditional in `compiler_types.h` instead? And
> > perhaps the `__has__attribute` test removed for GCC?
> 
> AFAIK, the gcc-specifics are in compiler-gcc.h...
> 

Right, I agree it's best left there.

> > Even if we keep it here, I think at least a comment there should be
> > added, since it says GCC >= 11 supports it, which can be confusing if
> > one is not aware of this other thing in this file.
> 
> Fair enough....

Yes, some clarifying text would be helpful e.g.
"Optional: only supported since gcc >= 11 (partial), clang >= 13"

Otherwise LGTM, so:

Reviewed-by: Tony Ambardar <tony.ambardar@gmail.com>

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

