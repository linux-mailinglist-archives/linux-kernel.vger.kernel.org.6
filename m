Return-Path: <linux-kernel+bounces-283578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C7E94F68B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEAD286760
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279D18DF6C;
	Mon, 12 Aug 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxtUuxGb"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC918787B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486835; cv=none; b=fxchkKlbs4z4t0OzFvs5LpaGw8PfxdDxL/VVKIpTF+KpTwEEf8OR7GZbv97avSlIQyKk2xHA8pwbQ9fd9KunRlchwfJGFZrkMz7eumb9oPu7tQE7qsIiUD4s+PKmF/6dEdlAxQ78WO4e/qCTckdYi13bJeW8J2uEIRtTetatV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486835; c=relaxed/simple;
	bh=A3HpNWJTcxymbYQEG1dA8JE4tnclhhQE4n/j239Bqc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6BlgG4YH6ifY8xgFwP43+l662ukhs+AEk818mnzR0v+u0mQ8olB5TRHxmePsduGGrJIt8qXtTJZlLaYSYN/ALt3xdO3ESjd7lh1sONi2iutIxhsOjJvun14VaE0nqtQ+tLvQZClopgghzZk5FCdBn2/2OUpyYCIq8LlSFyzkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxtUuxGb; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-49290ce47c4so2560569137.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723486833; x=1724091633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBPkZzpuplq753gUJkk8/OVrRBHsW1KQianPljyhNSg=;
        b=nxtUuxGbjPMkJnJyzS8ySXvsargHuCSwM9Azjav9HshDYbQg2SelU+Iapx9O/GqunX
         3wlREHTz/L29H4PDKuM6LbneebOFkfte4VUdA8wGCZisx7Alg+uLVm+0yqYw9+cO/nnJ
         oMZ50/i5Aw2CK8XsypqTmW3MeIVKfvpMIDwpcrQdEmA/1cCacF76CBATh4UH4VOShF7H
         h0wpRcYMlVjcLHhmEWBUog0szgOA0dUC/yUSwNb3Z4HFesCYlEBqcpdsgxmHMZff5fw1
         Nx/5YxPXPBhTwWxbXDwYmiWQfEtytm+GI0PQjWD/gG6RpZbJravWTW6v2YFfzdqfXOmv
         sSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486833; x=1724091633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBPkZzpuplq753gUJkk8/OVrRBHsW1KQianPljyhNSg=;
        b=J5sQ0Fh3VMv6ztry0gWgCM1fzrzMVgbzISuU3R5hUYPA0fuY3JwANVIvZxgwT5bVSp
         X/b/FCoos2/I7M2ggPy+RlE1L/7jxsNLo4edL1HGRzphH+qAfkLXNwlf092MZQg5+ETX
         Cs6baoZ6gmrZW/cL6FTp2wYsK+NI1pG94YyW9XP0GV9p5MkFCKTR0JOo16hMFaofPX/6
         L+m6qI3Y2aX2ZgK2C8ZsgEGKpS6rDHHH8/WYueHLvkFcVVdf+bC7dhZ9R8pPJOX3g+Tg
         jKOhpt6hGXuPP3yK32robzH6HkbytkHqebQQ66sM5LMfRxI+JkJl8v7aWrYrhoQf9Y3/
         Jz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXCIGRGR6KqEo1oswDVIcZyQNnb387KzEQU/c0D/AGvH99+3d8UpTrp2DBz1h/xMgbnIK4H7JkS6kwQypcBMbgP+lCBEDWlYzhSkzi
X-Gm-Message-State: AOJu0YytTxJphA7Lc7xisOvxa6LMYXQW4cI3wwWj4QI7H1D3Tk6LBkko
	3KQELCi4sXE81A4PSBUO2BI2OkuaIsZcFsbhqhNZADjF0dR/A8jU5lp113TrPEJlt/+mCdYn4LO
	lbhsp5jgac2jGnNWlePYIPAVWwup3VcX1WBCk
X-Google-Smtp-Source: AGHT+IFmcNAcCMREkyJBRNmlgUVt00nYNvlZjNA4ddNbYkY3f8RI5vPghUou6+rfiu+bmMKECidUEuJ/I2200GLo/e0=
X-Received: by 2002:a05:6102:32c6:b0:492:9e70:ef2b with SMTP id
 ada2fe7eead31-49746d0d86cmr481010137.1.1723486832843; Mon, 12 Aug 2024
 11:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
 <202408081609.D08D11C@keescook> <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
 <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa>
 <CAHp75Vcpy3+wZ-UuLRMVtvhK8u7X9wAyB8_5t1v8M50NCyTYEA@mail.gmail.com> <CAHp75Ve-uU9OfyTNUdP=nvEt0SoSWpeKofZ2pWz_J9PDdmJ1Zg@mail.gmail.com>
In-Reply-To: <CAHp75Ve-uU9OfyTNUdP=nvEt0SoSWpeKofZ2pWz_J9PDdmJ1Zg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 12 Aug 2024 11:20:20 -0700
Message-ID: <CAFhGd8r=SA9PxJphzhrU3S0TjMWRe897KcAUkgCrhpFFmMCn_A@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 8:42=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 10, 2024 at 6:39=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 10, 2024 at 2:53=E2=80=AFAM Justin Stitt <justinstitt@googl=
e.com> wrote:
> > > On Fri, Aug 09, 2024 at 02:07:57PM GMT, Andy Shevchenko wrote:
>
> ...
>
> > > But, we could  do this too:
>
> > > -       while (*src && --size) {
> > > -               if (src[0] =3D=3D '\\' && src[1] !=3D '\0' && size > =
1) {
>
> > This one is worse, I think.
> > Let's take time and not hurry up and think more about better approaches=
.
>
> Btw, have you played with the "do {} while (size);" approach?

Nope. Although, lots of ideas can work here. We can reorder the logic
any which way, really.

I am happy to send a patch following any idea -- so long as the
overflow-dependent code is gone :)

>
> --
> With Best Regards,
> Andy Shevchenko

