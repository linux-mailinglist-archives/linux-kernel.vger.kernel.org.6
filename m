Return-Path: <linux-kernel+bounces-371614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7C99A3D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BC32841E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D631D5AC7;
	Fri, 18 Oct 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyfk0RZ+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98542F46;
	Fri, 18 Oct 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251458; cv=none; b=ivfXduaS/JkwVPOMhsq+oNtSx64oKVpI0hO2IvZAEcKnbUIBsuAIwbEHONvoIXEp3ymUpVkh45zhvRxB4CMHB0vJasH7EJshtvImGjMr2ZgQOgj/Rks41E6ViakeWOy+OujvgROO7gKHBRAp3QMlFvCUzO7CHq9v8ZSbDJrcwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251458; c=relaxed/simple;
	bh=Z2ZsHBlv4F58yv72hrFjXHVDQlat+cHzX5o3VrnM12I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVtr3deTP4pow4/ZrJu4s/tm/cbt82+UCHwQ5s4SnwbEg9uRvwL9dEZRyDetp0Wf18ClxrgU75uqv/fmq1t9gd/BEjW8iXXEj/6TXOw4hV/0sChNhhpcYdbsQRDamjwFunoVH12J82huZ0KcHGYzY9QUxEPRY30o6RjNgIckvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyfk0RZ+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f58c68c5so3270150e87.3;
        Fri, 18 Oct 2024 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729251455; x=1729856255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2ZsHBlv4F58yv72hrFjXHVDQlat+cHzX5o3VrnM12I=;
        b=Qyfk0RZ+zrV0txLTse0GHwHlzN0TmI2lIObVDvkFeW05jKgDQUlXqfHaht65yXf05k
         j9KdnkH3Zx/MpvZC0guCARG3XQfYJ1l4FTv8E0OJRFMhG3ft/y+LuSEo+lmsPm1leKO5
         66R19luMMpBm4KnjeeUJl5OL1ng3dKrLBVQd+yKimhw4LvthBpxPx1agqYgbpY1YHxjh
         raJ9xoLjJgfWMLoNgcrBpNeoP+C5h1HwvseWyzcDsN6Wg+tVbitASQspQa7NIfp+0SM4
         F2O2dURVSW47pwPjQ6q5gb8p9xeCKBWmvkjOC/iCbknkkKJ41Mh09caHHGQpHoH5JnwU
         BOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729251455; x=1729856255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2ZsHBlv4F58yv72hrFjXHVDQlat+cHzX5o3VrnM12I=;
        b=BsOcCZhshrI+KnYbpidTb5mPhYfv37578Bf4MkK/A11dOXWB1gygF9tkGAyzEKhZ/K
         dfXqll6gup0gNiRo5nX3un5JMK3+k+xfgPynG+069UuI4PRknDETx+6vqB4rffloF0eV
         4znXzkS9598EndSzmVboGXMWAU7jR01e92IQ5bNuSqP3G0NEX9Br3b9cvSlzaRzKYsH4
         JsiwjQDrkjntL1rGsusYNziux5Ja374Y9AkK77cMs9urIT11VOv0qWZQjI5PpBvTIXO4
         TH1PXN+rtmoH9wsNDnYTSfOZt5CdoyCIZoxI+ipS6o6af/C3VxmUtgWNeMi2IFjOSF2N
         AUVg==
X-Forwarded-Encrypted: i=1; AJvYcCUueVAQWrYLeXXliEBtze3/NiTgwMVKLu1CGDlIoj2/3/JwxWSLZJBS42+35w379HkwaGV7iGl4kayc8DU=@vger.kernel.org, AJvYcCVG+h8mAMogIMmt2DPsHLGgV7hg1XS0GPkFFOnJZmYMxSFuMeF/btn9UAc3hKSqgiV7P3ka05v4Fheoyps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUw3iM8ulrQf0rb0tFsasO6S67R90oDeKwKIb9Y+erv8O9daGZ
	hmJjBu7sZWIJUmG1pEGFN/D3otgtSaWXXo+3OfRAWtwWlO2gl3QSfcSbpo/DtjQfRyWSXZpnTM5
	fDdrZQlYQSyCjAnhYEiZYJEPoW+o=
X-Google-Smtp-Source: AGHT+IFQAHfNnXc94cDnwolpYvSoq/a6eutp2/Sq+eDgHigng1jmEqrf3HNkTivuT3VBIoOWT8lNwvhzpBD8kgYACac=
X-Received: by 2002:a05:6512:2315:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-53a153408b3mr2468738e87.3.1729251454532; Fri, 18 Oct 2024
 04:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018110743.18786-1-v.shevtsov@maxima.ru>
In-Reply-To: <20241018110743.18786-1-v.shevtsov@maxima.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 18 Oct 2024 14:36:57 +0300
Message-ID: <CAHp75VfOoGDYHhNb2PoMOhn1SEnMMF1EXvb2ignWFenEa93Otw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: nau8821: check regmap_raw_read/regmap_raw_write for failure
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Seven Lee <wtli@nuvoton.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:07=E2=80=AFPM Vitaliy Shevtsov <v.shevtsov@maxima=
.ru> wrote:
>
> The return values from both regmap_raw_read() and regmap_raw_write() are =
not
> checked despite they can fail. Propagate possible errors to caller.

"...them failing."
"...to the caller."

> Found by Linux Verification Center (linuxtesting.org) with Svace.

> Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")

Are you sure?

While the code wise the patch is correct, the behaviour changes may be
catastrophic in some corner cases. The first one is the read where we
try to get the data from the register, that one may be okay, but the
write should be first put into the group of mandatory or optional IO.
If it's the second, why bother with the IO failure?

--=20
With Best Regards,
Andy Shevchenko

