Return-Path: <linux-kernel+bounces-423935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F59DAE81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825C8163736
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400B202F84;
	Wed, 27 Nov 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIYZ+Mb1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC622CCC0;
	Wed, 27 Nov 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739127; cv=none; b=MOcg+aJc93eUcproBskHevboQ+mef8qsl0hf8uYs6Quh2o1TGWQR91a69qlYenZvKYeH1Y21rEPyjRli6u6u/tk4hsaxPbutOoQEa3AFkJcg6JTOlDqmU20yK2Hd4OWDLYQa1nScwxjUKBUMhupIHkTvsmaW7fHiS21FCsn8EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739127; c=relaxed/simple;
	bh=g+aQQ/Ggzod7NNGajMUoLiB7GzgH/mALJiUvlvfNSbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/yboQ33hKwDDSJBqIlvJ38GvLT9aQUxior/cUHWddqjklvhH8sYZeJ87A+9qCYut+Jv4FVTI6yPU2jsqx4XC7GPB27Yq5BQbgzku4eYnM0r7zRaAUUp7CyN6RilkhjtJWr/qDY/Xjal1rRJNpzSEgxSPefVChtHnd36XdMlsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIYZ+Mb1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso88330e87.1;
        Wed, 27 Nov 2024 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732739124; x=1733343924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0K+iavJdOt6R73DNJUouu2pgKCbJgW737wlJ/zVGHcA=;
        b=hIYZ+Mb1kYnqYP4sUWDQ65Q7tSupmxAkZ9uq9REFOQcyLHxTEXRPqZqjnCGnCAap3b
         9ge/rpTzNds9Agb+icA2K/IuMk5MDNySuGuBaD9kHDVvgnXsPhxhJjbP4eHr/kdKFkMK
         lvsdqH/dZGfALSf5J7mRy4bAGS58HSzIG2twcQmcAPWfB53dwmezwqlDF+HZtRMAL/gZ
         i0esLOftlvdzb7MjmGsfTvTz14TGy7RDuDoPDyHF+qH3K0QB2ZmKXpgR6xsg/UjSkZ1c
         ZmYVPBCxgtfctvUOcr55YBycxCEXtJmXCm9xuuhb1d3zXgMT+zLdBUOluFLJ9dW+HO5Q
         lQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732739124; x=1733343924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0K+iavJdOt6R73DNJUouu2pgKCbJgW737wlJ/zVGHcA=;
        b=bvjlmpTmndjJqc6BI7ge4Ro44m/VuWjgY0RXQLY90Zw1Nofhyh8HAZY5IYfnvmj1Y8
         va+Lz50KW87FFokRlKNsnrlHe9lA1Czzrjbq7F1PtZTzBzzkNJlskYF+WCWEFmh/0v0z
         NdhaIpKqaPuI+G+NKufONTLnKeIEedj+8luYKNLPM+2PtF1+oql89fg5wMJBlpoHw2r9
         fT1Y2lyogovCZQmblRmv36FY6leHGszwMLY8Gz3DNfNOfBp8OMa+UTtGhdNv4AMqitPQ
         +a6dw/XW+7HSLr6tPCYYTFO0AhMoWjBAjrxTI2b7w4+oFqkHNQJKN87Ozgjd5DnZt4N1
         Eqdg==
X-Forwarded-Encrypted: i=1; AJvYcCUCnp6pzsaPCmZ36EhPPy9hKTnbsTJIqQMy9QWDZm7omYq3lFwtjpGN2jG71vAIB14pcXwS4qPoQ44+uZY=@vger.kernel.org, AJvYcCVQGUxKNbjeyZePDjR41U32yOjVTGj/q95yfYWTVSwlW4VJBBmIpa+JADiQ+Z297Lm7pWPpZoFmqqOPuBnzx3fVA1+5uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJobBhoDoAD1wPApySzrPp0yOyRM1n1znqYUZPe2iozvsdrUVF
	58qZxjpvgyfqbzu1+Hr0Wsqav6JO0lslAH0CgsJTE9viwDPg24of8B7Ndr1Qlj2GTfPupK4lWh4
	Lr5UWtzW0D7xgRGYvtqonY+MmSxqx0b9XL3g=
X-Gm-Gg: ASbGncsulPAKKtvSF6EnxhhR2K+5TAL7kANs5W+DAGdruqZlRY1Xu0UzUo7zhhuExYn
	+YkaRO1Dpx7PjmnWH07DmgW2DInhEK6pP4lwmueo5Wx71CBahpbmYOR7RIH7ynw==
X-Google-Smtp-Source: AGHT+IHAnPjqI0m3mX/rBTTsaJWOuXdC9RWeheEERSsb6eeLetqQSHpstJrb7dMhiHWJC9a0z/RZGP7Gv3PtwL59A8g=
X-Received: by 2002:a05:6512:2316:b0:53d:e5cc:d06b with SMTP id
 2adb3069b0e04-53df00cf669mr2904354e87.20.1732739123956; Wed, 27 Nov 2024
 12:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123133041.16042-1-sedat.dilek@gmail.com> <2024112335-liver-reclining-a95d@gregkh>
In-Reply-To: <2024112335-liver-reclining-a95d@gregkh>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 27 Nov 2024 21:24:47 +0100
Message-ID: <CA+icZUWtqu_1u=U92Qk_Z1Hd_7ub6ebcWdmd5L+omZV4vkUBJQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 10:15=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 23, 2024 at 02:29:28PM +0100, Sedat Dilek wrote:
> > Rename from "Samsung Backlight driver" to "Samsung Laptop driver".
> >
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  drivers/platform/x86/samsung-laptop.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Wow, does anyone still use this thing?  Anyway, looks good:
>

Thanks for coding the samsung_laptop driver 10+ years ago, Greg.

My mother died in 2012.
This laptop was her last  birthday present to me.

# cat /proc/version
Linux version 6.12.1-2-amd64-clang19-kcfi
(sedat.dilek@gmail.com@iniza) (ClangBuiltLinux clang version 19.1.4
(https://github.com/llvm/llvm-project.git
aadaa00de76ed0c4987b97450dd638f63a385bed), ClangBuiltLinux LLD 19.1.4
(https://github.com/llvm/llvm-project.git
aadaa00de76ed0c4987b97450dd638f63a385bed)) #2~trixie+dileks SMP
PREEMPT_DYNAMIC 2024-11-23

# LC_ALL=3DC dmesg -T | grep -i samsung
[Wed Nov 27 20:01:11 2024] DMI: SAMSUNG ELECTRONICS CO., LTD.
530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
[Wed Nov 27 20:02:29 2024] samsung_laptop: detected SABI interface: SwSmi@

# dmidecode --string system-manufacturer
SAMSUNG ELECTRONICS CO., LTD.
# dmidecode --string system-product-name
530U3BI/530U4BI/530U4BH

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, hope the platform/x86 maintainers will follow.

Best regards,
-Sedat-

