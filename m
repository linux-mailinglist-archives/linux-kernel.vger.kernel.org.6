Return-Path: <linux-kernel+bounces-439868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DD9EB534
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07940283109
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB61BBBC6;
	Tue, 10 Dec 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3PIt32v"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A01A9B3E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845223; cv=none; b=SH3KUQFmBX04PVURvLO2KuOcTDHsceQncCtn5mFZk153WzOBX+CRjj0qBFvtc+ovF/AIoV76IMQfn5SzmzIZCMxxRz3kjKeQSPykb6uS0LbyVi3vfYgaJSM49jwmCwE2As81zq1VtMJNTSVBm6xa0dpoFIKdMflURQF5oRY4k+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845223; c=relaxed/simple;
	bh=0L071sou9yriPK+YioFYPPtFgGlMNxmiREGnKJ83SG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czrre3G/w6ThVsvAW1xz+3oiKplloj6+BzE8by2CNSsLZ8jb5Xxx8UkPO64x/SCEZDI0KXRps/4i305PAB7uDtz9ZYFAG4IvztsHv9esEflYoTsfJMjceCxyEVBzbnCIN38+Zyry20sOrQfLel+ICJarfWjOdpqz1HRL73xpnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3PIt32v; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so924066366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733845220; x=1734450020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L071sou9yriPK+YioFYPPtFgGlMNxmiREGnKJ83SG8=;
        b=Q3PIt32viH+Bo65Fk81D9JhIsTOyGQv6abWHOsJRbDbaGucL6ZAyoCl5gr4Z+hpiks
         n+xKwy5mm3Er37QfIGGMTcCXUn+J54Z+hmoL5QO0cxw/or5fpg0NC1VWFl02FdoRsHxf
         IYqyfIBijdsbQNNVyzQDOOiivSQ/vWXE3xHXyiexOgzwsZ6QuOrifB8VvLcR80rg8VXx
         AB/bQjlVfBFe1waPL5rLoO+2TbU6TBY/jRq9h2uLu2+6Nie7JHxPXEzwy5iWnHPdVYqu
         krQw+LxIOCurqmHHbqZz4IGtXPNV9w6tWeRyBDEA/HqHVjqQECf1WkVmSmyz17qjSfXa
         UGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845220; x=1734450020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L071sou9yriPK+YioFYPPtFgGlMNxmiREGnKJ83SG8=;
        b=WQ2QXyhYfnaxLrmXmoJMxrRC9tpaZfSUYFZ6j7VfaIVBGn5HxPQiAgyyuORs/q3j/v
         QPsQQB8NwpDx+zHnqZA5wgsndBCHzYG1CXWiLY1i8+RiFwXTEv/7MumnvTeAGAjzXjne
         I0CQDIc+xJAD3P4yi1IzZxnMjHj3SZ9sTBQJNHCO06eUeOFs/ceccytgCWJyYyN6SLOG
         X6MFuKbtYW/GrLMtGlnDRk1xvkEyIusDb03sUHl6eiJRQa+Kb509HrP8K8XJLR96XOdV
         zxSGoffQSL9iqTfs7oPWf5S9EdfAqqEpaBECXfWpt41CLTaJ+YvvxiX+iyLmfeentJho
         8iBQ==
X-Gm-Message-State: AOJu0YymHzjIkKfYgaEb7l6ngIC+2Ez7gJl/ZXy+x+IcbGvJhScw7+73
	ZvoikQNKqoKSKgwAVEHR2cVfmp+nvKRKK+JrpGv3QqCP5FxIe4DRdOjWFnQFQ1G1zSHBl/GhiBP
	kJBrXo9t2gWNurtm+mAhtZkpvb9U=
X-Gm-Gg: ASbGncuC+39tBx7ptgJQZiaGSx9eh8MlQTRS4ANnEOfXncxaJisZNQ4CZatzQg3luDj
	36MH7rtHD7+ZdCeR93XOVj8cgxcClbIV04R4=
X-Google-Smtp-Source: AGHT+IEIW/Q3o0bnBqlodYw10UJag1F084eviEsIUWgy1Ye7aFXfc40wgaVbp9dSmbbGgnyLORTQKybzcVolspm3MF8=
X-Received: by 2002:a05:6402:4406:b0:5d3:ff93:f5f9 with SMTP id
 4fb4d7f45d1cf-5d41853f8damr11420365a12.20.1733845220392; Tue, 10 Dec 2024
 07:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210144945.2325330-1-arnd@kernel.org> <20241210144945.2325330-11-arnd@kernel.org>
In-Reply-To: <20241210144945.2325330-11-arnd@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Dec 2024 17:39:44 +0200
Message-ID: <CAHp75VcvZh7+a1aLj7fYNLDAzGXCM-13SRYkCWWAEVAaysrvtw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] x86: remove old STA2x11 support
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> ST ConneXt STA2x11 was an interface chip for Atom E6xx processors,
> using a number of components usually found on Arm SoCs. Most of this
> was merged upstream, but it was never complete enough to actually work
> and has been abandoned for many years.
>
> We already had an agreement on removing it in 2022, but nobody ever
> submitted the patch to do it.
>
> Without STA2x11, the CONFIG_X86_32_NON_STANDARD no longer has any
> use.
>
> Link: https://lore.kernel.org/lkml/Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmm... Haven't you got a tag for (at least) this one?

--=20
With Best Regards,
Andy Shevchenko

