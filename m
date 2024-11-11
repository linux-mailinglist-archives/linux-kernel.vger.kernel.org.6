Return-Path: <linux-kernel+bounces-404779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220B9C4801
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C941F21C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDEB1ACDE7;
	Mon, 11 Nov 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XHvoSGi1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB51165F1D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360489; cv=none; b=uK/IhisD7BhchjroT/OV1BZHJvaZKM7EYIRavwjE8fy9V9yeyHdZzMagTMoY03cbCWxTTtuqBaEKSLbpHgibCyFDcB8D1lsnahkPBEwA0iiEYL54J7ylLpBLkSFYNyiw3d6tRkTC+Z8pufXWnZhqHFUvNSPD8ghocK2iWfFE9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360489; c=relaxed/simple;
	bh=g4XGFichJ/k6VUF87Yk/CjVlsbTQla2xAqfiGyKx2JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ee4PtmK27Ri/tOnCifKSk0P5s5bgOJSft01/UvaJuAMpp0/XEVZk0MUb3/Vxr+Eoh+YSomclCA/m4YPzw+qGoYCHVMt5uttXlCFJi4H9lovH3bSbEkpNNNGpru5OyhHp7e7KwvHX4h1G9RfD17aLzq9MCHpiJxo0HPKBzQ98T50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XHvoSGi1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c913aso8605693e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731360485; x=1731965285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2KKkc4duGGlWY9yI6Mfu3mB4uwF0xJ7vAD/QyREAvA=;
        b=XHvoSGi1AHIFRfjXbAM1pfrgiW0cm4yTBr3NoYH6MZOoUzFGeXegJtr0TlVmk6ZzDb
         ZXc9bAvwYNNEFHMX++PxRrsNppjjIRfqxEYp9H2AGU/GXr6DdWa5jPsD3f9XytlyBUKe
         2zBJarqHFhRkuFFr/AqhPbIHXg8gc019Nw/cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360485; x=1731965285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2KKkc4duGGlWY9yI6Mfu3mB4uwF0xJ7vAD/QyREAvA=;
        b=RjhfeZJ7ZtFH0f0XrCmOYPG0/g9A3PnPylxefX45KrZPmuaqMsEA6CmVsKGlDdt15j
         IFUvOsU8oJLJdq1YeG9LPFHibBOjAsFiadvtxC45Ycewr85h/32ad8I4kY3g3YqDX+6J
         l/HpQuLQ+dLXUMCJnJJ+egc+nbmLutXlvDeH5sd5zwGIQyVzWNop5pHiziQV5lioI2+Q
         gb1OS+ic5lAZkbJ8DWiLFDqWnrt5fQCYgfg74cRz/JvaFblxug2CxEL8H8/ntbBd9o6i
         UL01BqF3uArz7Vy503K4TvPfE7wAmKPeXBj0IH3f+wrVkYdrCDsHg8lsqeEuyoWM3jee
         sR4A==
X-Forwarded-Encrypted: i=1; AJvYcCW6wepAIQ4++q+ZEFCqu247wFKyJrqeBgZD2ABhw6ls8/H1d1evE4ZGCGwtAtfO5ZeC20f7dSMa1qFvzbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEV33MX3+YfkTlTDAzbAogiD2nSN4sDx9xXl8lOTTpY2bEIJT
	zsmmJ4NXO2OjEHKZ7NRBs6OkjAEk5RN5kYce8k4+i3234IG2olJlm8U8B87+rlIHuWDkTyek/su
	lvg==
X-Google-Smtp-Source: AGHT+IHAt+IRPSUPHMcH6ho+HOr+qVC1fI0/oX7l6jrzcoyZ5jtV/R79dhBsM0G2eFOCbFmeC+1xeA==
X-Received: by 2002:a05:6512:3403:b0:539:ea7a:7691 with SMTP id 2adb3069b0e04-53d862f7c4amr6582450e87.47.1731360484768;
        Mon, 11 Nov 2024 13:28:04 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a783csm1681167e87.151.2024.11.11.13.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:28:03 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so39679671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:28:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNqcLzy/IjIKG3NDstxMom0MI9WE/fXv3ooXYdoGTQf0TqGC9AOiWStiOnZmxf2LXTBZaiwXt3UobPzac=@vger.kernel.org
X-Received: by 2002:a2e:bea8:0:b0:2fb:5ac6:90f0 with SMTP id
 38308e7fff4ca-2ff20307759mr56150691fa.34.1731360483070; Mon, 11 Nov 2024
 13:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111212254.GA160555@lichtman.org>
In-Reply-To: <20241111212254.GA160555@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Nov 2024 13:27:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XS=z0cF=H8mokEOTKyxWPr-AVL6pnxFynKqkeN19pCMQ@mail.gmail.com>
Message-ID: <CAD=FV=XS=z0cF=H8mokEOTKyxWPr-AVL6pnxFynKqkeN19pCMQ@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 1:22=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Problem: When using kdb via keyboard it does not react to control
> characters which are supported in serial mode.
>
> Example: Chords such as ctrl+a/e/d/p do not work in keyboard mode
>
> Solution: Before disregarding non-printable key characters, check if they
> are one of the supported control characters, I have took the control
> characters from the switch case upwards in this function that translates
> scan codes of arrow keys/backspace/home/.. to the control characters.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>
> v2: Add CTRL macro following Douglas's suggestion in the CR of v1
>
>  kernel/debug/kdb/kdb_keyboard.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keybo=
ard.c
> index 3c2987f46f6e..9b8b172f48c3 100644
> --- a/kernel/debug/kdb/kdb_keyboard.c
> +++ b/kernel/debug/kdb/kdb_keyboard.c
> @@ -25,6 +25,8 @@
>  #define KBD_STAT_OBF           0x01    /* Keyboard output buffer full */
>  #define KBD_STAT_MOUSE_OBF     0x20    /* Mouse output buffer full */
>
> +#define CTRL(c) (c - 64)

My fault, but just to have good macro hygiene the above should have
extra parens around the "c" to make sure some hidden
order-of-operations problem doesn't come up. It obviously won't with
what we're using the macro for right now, but I could imagine some
automated test might balk about the missing parens... AKA:

#define CTRL(c) ((c) - 64)


> @@ -123,24 +125,24 @@ int kdb_get_kbd_char(void)
>                 return 8;
>         }
>
> -       /* Special Key */
> +       /* Translate special keys to equivalent CTRL control characters *=
/
>         switch (scancode) {
>         case 0xF: /* Tab */
> -               return 9;
> +               return CTRL('I');
>         case 0x53: /* Del */
> -               return 4;
> +               return CTRL('D');
>         case 0x47: /* Home */
> -               return 1;
> +               return CTRL('A');
>         case 0x4F: /* End */
> -               return 5;
> +               return CTRL('E');
>         case 0x4B: /* Left */
> -               return 2;
> +               return CTRL('B');
>         case 0x48: /* Up */
> -               return 16;
> +               return CTRL('P');
>         case 0x50: /* Down */
> -               return 14;
> +               return CTRL('N');
>         case 0x4D: /* Right */
> -               return 6;
> +               return CTRL('F');
>         }
>
>         if (scancode =3D=3D 0xe0)
> @@ -172,6 +174,19 @@ int kdb_get_kbd_char(void)
>         switch (KTYP(keychar)) {
>         case KT_LETTER:
>         case KT_LATIN:
> +               switch (keychar) {
> +                       /* non-printable supported control characters */
> +                       case CTRL('A'): /* Home */

nit: I believe that Linux conventions is that the "case" lines up
directly under the "switch".

-Doug

