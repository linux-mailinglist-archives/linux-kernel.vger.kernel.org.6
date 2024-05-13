Return-Path: <linux-kernel+bounces-177519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC98C4011
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D8B1C22C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA714D2AA;
	Mon, 13 May 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJV2SyBP"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782443AAB;
	Mon, 13 May 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600815; cv=none; b=gaRzZpE05y3rjKgl4Gxo/yu/hW5cKtaZVhKEWGWgSWu56fFcyl3FHBxxrFdZtSGUVVa+zT6dHpivHxB1xtgaMg+ln6DkuL6wtJVZYXXMRgmMzMwazTipbfB98gpX4RIzUJdwhTpdaXm+ZcRxkg508bSeBJnEBxVhk94kt1PSOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600815; c=relaxed/simple;
	bh=6Vt49lAt/fqxzVw18yAShVk5jwsZeYS5WMBMzeJouhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE76UGGOrtMnZy9PIEoceGRCjUbHBeZCu5E8UxGdpTwaMIMN7cgxC2FHCZSbEtiOsiYH+0P9wUPM3XBGGcbih5QDU+TsGEjqENfYpsdk6c6mT2IzhmBtHvVfQzontfSYPgdgV5x8Y9nWfliPVMnA+e0k5hAo6HliIC12Ja8DQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJV2SyBP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1165281166b.1;
        Mon, 13 May 2024 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715600811; x=1716205611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r/YihET62pp66VvT6dwJcRFRNIrAFiu1E7WWei/ujI=;
        b=TJV2SyBPA420+T6Uyu+G8OYfNCVGURnkIH2pA/sQUdcoKq9n+HXj+VztGwvyrVS/t1
         WS3kZqWrk+Abq9B0gvSyhHj0bgYhOvgtYnTm2CK52aEewVCA5XczG9RDHN2Osx9X+r6P
         8rdPfm6FyYAO9duG4KMbQRYdMyNzzNAwxH6RrIO1qvh627imD4PvS7Y0Ce/exfRKefK9
         n0LQD4tbeBukkOiBMC9wqG+gNRNiLYLJs0FR3uv9KLrBof/bgbUDuF4WQtz2CarNr6la
         sb5snMt5hfzxYY+XSoacej3U6P4DWtIaSz6KmuPBVeERKMdW1fN0Shdkj/W6VWy+ImOg
         cVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715600811; x=1716205611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r/YihET62pp66VvT6dwJcRFRNIrAFiu1E7WWei/ujI=;
        b=dxmUoaPovLyYdg/rSdECLnBHeoV4mk7gbPsi2ffab9p32LxEBfTJexrEBglt4AElET
         IAdLGtZqQO8KDFEQuGFRodDs9eJafuVEN1lfYPi/DzN1/6XVPsxFlR5wD/9Acnc1568m
         jK2iAuwYM7fdXQMBV1Zb6COQtphy8Abeqpi9WYcw3qqkxPhTfTvu+VIzPc/724abXCXL
         614fnntsZLKlML4CQjc2R40sIyxLp4Ohy1NRK4iQMQiO7xRPtDcZpBPXAZkwlCBbxnoX
         xo/gFQb5CbFcF7bvHeCntAVKde4ytDl7auZGJecTsyO5KmSviA3jUzUo52OwP8TdWKe/
         SUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsmJ6KF5gzann5wEyIL7p37bA1Gs6FTfV70mt1R/xCHS0dGiirkV8M5pXzBVWfoiMUEB3UGNMdEAJ5QEO0lG2rYTh6AiXDNy3rG8aQ0kF52dsv0NEB1mHpye7nQrH4jvtTkhiZrDc7
X-Gm-Message-State: AOJu0Yx9eqMmDn+0aLXzKaO3wmJIH0M5r1958PokOqjY399lLKR62i+U
	nkprI/vURvrR5ixalLQmcXGZ9CZhwoPONnm3VwP+OoDO9L3WgtcJ8O79wWQSGBhGelDEK6hu5es
	6uuEgTHdoP/jxESkhQK2zdiQMYrY=
X-Google-Smtp-Source: AGHT+IFEA6ve/ilE4tQgCNvmXoFA3FyxxFEkTB2O7fYoLi+SZczszgJVcP+EP+ORiILF84jJvUdKuBsAhM3Q68FaPdQ=
X-Received: by 2002:a17:906:a47:b0:a59:c52b:993d with SMTP id
 a640c23a62f3a-a5a2d55aa31mr657895566b.20.1715600811171; Mon, 13 May 2024
 04:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513102237.112376-1-didi.debian@cknow.org> <87a5kuez97.fsf@intel.com>
In-Reply-To: <87a5kuez97.fsf@intel.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Mon, 13 May 2024 13:46:39 +0200
Message-ID: <CAKXUXMzw6_JnPxXfgU2tEU-VkU6E_=ee-V4MUzGX8MQCSXLuNA@mail.gmail.com>
Subject: Re: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch tags
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 1:18=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 13 May 2024, Diederik de Haas <didi.debian@cknow.org> wrote:
> > Make the tags directly linkable by defining targets for them.
> >
> > Closes: https://lore.kernel.org/r/8090211.0vHzs8tI1a@bagend/
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 216 +++++++++++++++++++++++++
> >  1 file changed, 216 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev=
-tools/checkpatch.rst
> > index 127968995847..6499e29c3a19 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -242,6 +242,8 @@ This section contains a description of all the mess=
age types in checkpatch.
> >  Allocation style
> >  ----------------
> >
> > +  .. _alloc-array-args:
> > +
> >    **ALLOC_ARRAY_ARGS**
>
> Alternatively, you could just convert the definition lists into section
> titles to make them implicit hyperlink targets. The rst stays cleaner
> and there's no manual updating.
>

Agree with Jani. It is important to check that the verbose option of
the checkpatch still works. The script actually parses the
documentation and then shows the relevant parts as verbose output to
the user. It currently relies on the specific format, but it is not
difficult to change that to use a different pattern, see sub load_docs
in checkpatch.pl.

So, please make sure the current --verbose option in checkpatch.pl
does not break.

Thanks,

Lukas

