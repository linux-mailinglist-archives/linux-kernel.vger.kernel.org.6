Return-Path: <linux-kernel+bounces-526096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5271A3F9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B2165038
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFF206F1F;
	Fri, 21 Feb 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1jOL2Hi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BA205ABF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153268; cv=none; b=ld9lFYjATOboHBJrdjS/iXinL0XVYcd3hKJCdDvcEbhGC1uJ9z3A7emHaWEs+i2DJXmmxyD7r9ZPlVP0inJBjojbCUL1kGEMZtBDpprr7oYJ9w3aytfa727qR5F5+0XrVdwyymeXAwXLIBbKbGw6JsZEfaB6NOk0wxjeyjQdAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153268; c=relaxed/simple;
	bh=M3BlwZKi2May1AZSsuJjLBi0gwU/v2Dv0GMIyScBa3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEdEkiAeWfp/Pv6ryduxSTqaHdlcTamYqbWvbF8krnVmLDFkDVgLv0vQmEbLvDypkHrxOFDIJXVQQvv7yWczlugCxfWZ3sQCWf2C+AvjpiUdgStJGjpJH31xYzfDhk1Pc0z/j6QHhk9oLjqoaMbEXo1XFZyQNjom7draVpCvmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1jOL2Hi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545284eac3bso2203805e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153265; x=1740758065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZeiuIQbe9eoVM1i+acvJxoCv4cyaR7u6+3oGtzjOXk=;
        b=e1jOL2Himz9CXu9nw7m/gEq6fzUH3kIj/G/tRGE2c1TQ0Vf2CBWY+jkelN3/KPI1Nv
         BbHkjhcP75ewVj2t02mD63VFe32vyPIUzitAxhJAeRY8r96VIDTtk5+r4485LBKEZAJ4
         N4qwcD9V9bgkJ3VmD3yR4Y+xjRBNlK6yGPyGLUxvL9+oVJ3gFkz2aWaURXUN+7pVa/NI
         jmDMlHP2ktNV/06rV1oAqoGcddwHuCkIuTHzbH86N2irxzZKN97l7JK3CkPMdLHWPHXU
         Gc/uMqDgV72XpMW6miKUdnbvpzowxhnvwDuacS6e1k9NlbI3PGqgig40WmM3bzQbXcDb
         3Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153265; x=1740758065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZeiuIQbe9eoVM1i+acvJxoCv4cyaR7u6+3oGtzjOXk=;
        b=t205kmKxQ+xoC1gQZCeQqdMMb6n8CygvZdIX7DUi6XmY9tEQT+kPqLQrqHF63n+0l5
         f0/CFZTZ2MQAavpJLZQALL2er2JrHHgkLofrCZqkTAcs1EThf28MSlBrtf6OUR+Tb4Jz
         xesEUf/zwBoMBOl8f10e37fUc/keJ4fxm4LM+eUQcTW1qaEpjBc0pusRgk/zoOgz/bXd
         71BVviSaA/1NzoSc2dvzvmJUl8alUOGna4WCjjRORUsywe1pK5zt3d8iDq5fgCWRnCM7
         fEmeh/O0+OQHF0Uy0tZjFSNLmvueK1gUGs7EfNg4kYX9ytodM5HgD3GQtfq1FT1S+EoN
         K5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUDye29TZkmqWVxeQlLfadthufrnlOdg1TkAEZLtsOo6NorOuyGUp8HNaB5GH5woMfMy4Om2oEw0Arf3S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oE44TGzdXpGCCWJcBu8xM9uNgQKx2dPT0OUjyRk+8A7BH4eH
	h1NhD2DMSw0jtiFvOs5TxDyVNRW4csQWXW+xn9dJA3CVD8mEY6xMGfqwy9Ja5qNGwlztQ5n4j+B
	mdYKVQ9zxEk9A1eJoBsZvy5KQ8Tfh
X-Gm-Gg: ASbGncuz199usMnThDpNRolbIMCglcIOaT4ysii8TUfDtV/fS8cr4aMSvLEpCMDM2Ki
	vlpkcTCn/TpGeolRKSbm4uYwSqM8pnRfNAAsHXzOdP1vYtntb38duqBBzV67yLuCBTrsvYmFR9r
	QP8OSw9qmaf0vZBwZ2xEgO7g==
X-Google-Smtp-Source: AGHT+IEBO8Y+hBBFB56lNFJCf2Ozoaz96I/Wa+japZox69boXL7l6yUKb7ASojw679VJ3nmmsZpQap+LZNhrwt54qGg=
X-Received: by 2002:a05:6512:3c8e:b0:545:16d5:8e89 with SMTP id
 2adb3069b0e04-54838ef8930mr1401693e87.30.1740153264898; Fri, 21 Feb 2025
 07:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
 <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
 <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
 <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com> <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com>
In-Reply-To: <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 21 Feb 2025 10:54:13 -0500
X-Gm-Features: AWEUYZmUthZ6p_ykKpgobpaXzeNZ0aYp00ZqPPx45Yq64dgM6wgvczs1gscwXhk
Message-ID: <CAMzpN2hPWSQudpmccDtCAQAy_rHFwbBwo+95GMaqw6P-E4RPZg@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 21 Feb 2025 at 15:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 3:13=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >
> > > > > I got a warning from the relocs tool, but not a hard error.  What
> > > > > compiler/linker are you using?
> > > > >
> > > > > Does the attached patch build in your configuration?
> > > >
> > > > Ah, the attached patch is similar to my previous approach, where th=
e
> > > > build system *warned* on an offset (the patch was abandoned due to
> > > > Ard's request to put stack_canary to the *beginning* of struct
> > > > pcpu_hot, and this allowed for a simplified patch).
> > > >
> > > > The attached patch builds for me without warning/error for both, SM=
P
> > > > and !SMP build.
> > > >
> > >
> > > Did you try building modules too?
> >
> > make -j 24 olddefconfig prepare modules_prepare bzImage modules
> >
> > for defconfig, SMP and !SMP.
> >
>
> OK.
>
> I think I prefer Brian's approach - the only nit is that the placement
> of stack_canary creates a padding hole in struct pcpu_hot. However,
> that does not actually matter until we run out of space so I think it
> is fine as is.

Going off on a tangent, as struct pcpu_hot grows I think it can be
done better as a subsection of percpu data (".data..percpu..hot").
That way each variable has its own symbol again and it reduces header
dependencies.


Brian Gerst

