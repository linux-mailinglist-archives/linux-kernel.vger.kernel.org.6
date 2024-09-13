Return-Path: <linux-kernel+bounces-327688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA49779B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CA41C22105
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABC1BB6A2;
	Fri, 13 Sep 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8Xbao1b"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580A77107
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212840; cv=none; b=awUnKfOk9vsOyrHqz53W7+eNDBYIKJhKMXCvGpS+//MWroI3tKMl+EPHKnuXktMlqqCbW2VXq9OqTJQf7jpA9fsCteXbCLHx9jbJ8OhePPol0wpxXu84+i62MhSNK2COWGavAqFCFjxAdS0YOI3w2aIMkT35SEDhDdaljH0h/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212840; c=relaxed/simple;
	bh=4EhGCh5UlFLWv3yy5BWWhJnw5ZlhnXBRO0XFQzRSN9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gumJ2MwDuzHMA+yCOauMFRAPjTY9Ff8Hq1f/9kx8wwrvessK2kkHD1knAJY0n6+E3m0K+us4W/lo0+H+jERUO+NzyNkkTJfiT90En1BSuTuw9FWh/SM3ZWfTFMF0XOfoDXbKO4TGMzyrcn4H+dzvAv8fL8mxeSX2opjkDb8+Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8Xbao1b; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37747c1d928so427843f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726212837; x=1726817637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX7GEgwmZmRNetD/mdSl0xv1Lugr1MnK89Dp0qjJIwY=;
        b=T8Xbao1bqpUZgfLcdaHn1xtOSmoUWRAsNdy1tqnPyT7uny5e0tdo/WAPYbwHe6cyWb
         QyOQzPJb0nOC+qXx9w0yd5dKhXmswisK0FOobNIpdgKVTO+UUdKVC+MI45Fpz+3Osa3t
         +6zcu697BlZSp++4Rb9O3KPltFoF2I4FxHPA2VqSsFJ09YJkJL4vKBnWT/Nh0rI8R9WN
         cPPWCexrgdeuVrk6B6QvtEZXvHElJWew9+54F2wUgpYOSx94GNOcI+ngvR+cWD2deKOX
         4/xqQmv/LfB1bGq+r2E0QXL/rwSl0S5/agmKTenRPSOiFggBSFFgj03nUoCqP8J8JVu6
         IdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726212837; x=1726817637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX7GEgwmZmRNetD/mdSl0xv1Lugr1MnK89Dp0qjJIwY=;
        b=UjiEHp2cbfFfTxHdbAwOlAT+yThN5Ku6B57i97qx7vEEeyunZSbC6dQGg0IgiFwBak
         u+b0IQPcCAxp8KpucA4ZdLsBlomIyE87V8lEw1Gn0+YHkq7+Zsxu8j2VNDILt99m98xr
         aEDCm1Rf28HkEs49vceyu04jhv5dPA/bfnf9JZU+Bvi1+NgnbLZDQIxTRlpOKljLi9du
         IBSj14ku+UaR2tGg0KjcuAm2vbR5Lnow78LhrPl96GYgDmuK74gDaU/t4WZNOcsTLuej
         fomqqEnca5afuh2BLaWf8M/+73rrmwmfpqJJB1WMcy8CcKdys8GlG0ZGUeoKXmDL0FD+
         srBA==
X-Forwarded-Encrypted: i=1; AJvYcCX2XkjIDCPrzenmb5uCi9YVyYdy9GyNQvsP51l/M3d2OSDVsKLcKsiR768Feg00WaOMb0flvNg+CJ/4SOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx809zfF105BFs8idxZyfS3e0yebkjgHmtELoTPSOBOLIS2yhz3
	PEGYh1TTQ3DbW00dbCpUddzvB6J5tYZGY9PpiYdohWeUi/dUcyUUW6Ko4dKgdrlXclWE9KhSJNl
	F0l8Qbsnqrl4lzlpmloac+bzuO/1rRo0QPgxr
X-Google-Smtp-Source: AGHT+IHnztr4jlB7m8lLsakxkOS0gIY/NRQK0skKLI3F9WO9LF5gVY0ClyYEHsr3Ab4nqjP6YJUKnyihOrotw9LgkDA=
X-Received: by 2002:a05:6000:154d:b0:374:bcff:cfa6 with SMTP id
 ffacd0b85a97d-378d61e28camr961842f8f.18.1726212836453; Fri, 13 Sep 2024
 00:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912195649.227878-1-paddymills@proton.me>
In-Reply-To: <20240912195649.227878-1-paddymills@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Sep 2024 09:33:42 +0200
Message-ID: <CAH5fLghxvLoQp+G1oaaVfBx6DOh-GO0Wc=jboiwz9ZCoEtHVpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on known non-plural rust doc headers
To: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, apw@canonical.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, 
	linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:57=E2=80=AFPM Patrick Miller <paddymills@proton.m=
e> wrote:
>
> Adds a check for documentation in rust file. Warns if certain known
> documentation headers are not plural.
>
> The rust maintainers prefer document headers to be plural. This is to enf=
orce
> consistency among the documentation as well as to protect against errors =
when
> additions are made. For example, if the header said "Example" because the=
re was
> only 1 example, if a second example was added, making the header plural c=
ould
> easily be missed and the maintainers prefer to not have to remind people =
to fix
> their documentation.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1110
>
> v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-5f=
20@gregkh/T/#t
> v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4d7=
c42466@proton.me/T/#t
>   - fixed whitespace that was formatted due to editor settings
> v3:
>   - move && to previous line and remove whitespace in WARN per Joe Perche=
s
>   - reformat following C coding style
> ---
>  scripts/checkpatch.pl | 7 ++++
> +++
>  1 file changed, 7 insertions(+)

This is missing your Signed-off-by and the changelog should be below
the --- line so it doesn't get included in the changelog when applied.

The change itself looks good to me.

Alice

>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..5b18246ad511 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3900,6 +3900,13 @@ sub process {
>                              "Avoid using '.L' prefixed local symbol name=
s for denoting a range of code via 'SYM_*_START/END' annotations; see Docum=
entation/core-api/asm-annotations.rst\n" . $herecurr);
>                 }
>
> +# check that document section headers are plural in rust files
> +               if ($realfile =3D~ /\.rs$/ &&
> +                   $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant=
|Guarantee|Panic)\s*$/) {
> +                       WARN("RUST_DOC_HEADER",
> +                            "Rust doc headers should be plural\n" . $her=
ecurr);
> +               }
> +
>  # check we are in a valid source file C or perl if not then ignore this =
hunk
>                 next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>
> --
> 2.46.0
>

