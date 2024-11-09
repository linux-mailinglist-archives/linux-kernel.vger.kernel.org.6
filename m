Return-Path: <linux-kernel+bounces-402531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A89C28D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3841C21521
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC454A00;
	Sat,  9 Nov 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WoxnMSw0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77810957
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112296; cv=none; b=lOtnRm4R+elkanYY90WGcbygvVc0s/TFI9bh3E7iODXBIxA2mpGWQ0AZ5y+d2VgEp4rV4evU4hD4eOSXZjs30eV+I8gK8W8dus2mjqS22xjOa78KbsmPbQiKOFWUngsCwelaZlV+hILnCMPDHbyLndvk5z63FxVlurNDo4a+08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112296; c=relaxed/simple;
	bh=gK1i4F8KA1Ylkt3Zs4hrB0Lf9ZhKC2B3jjYSUJlQmUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOguXYBo2Aq1E4iJO7ovfP4jxKIdmeGzEvylKMZo00x2ysnK10ohd+LWGJt56rNudgc4Xs9yLuB0V7jNmDq0QXOTfkdD6xuar1V1P7xuiDX/WjXQa5canWfcZTnt5bJBkCYSuYUUjNqrwfQsax4QvMml64JzM3dLFT3coVrxfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WoxnMSw0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a007743e7so3496490e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731112292; x=1731717092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBoWTToLWCAWM+f+gP5+hcTnA/Xflcg4jnMOvi1eF9o=;
        b=WoxnMSw0JOgJQ5C7n/T8+VICQrQiWHMh6npU9lm61+k0CxwYJT9vkyXCu2PbFPtp40
         pFPVxila/bFjM8U8JHJRE1fW37H5akvVxeoGBrni8/daDzcB83DftxHWd76r/HPoKLuY
         MHxRdTh7XFQRokv1i9TSlLk7/3FKO5ViO+W3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112292; x=1731717092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBoWTToLWCAWM+f+gP5+hcTnA/Xflcg4jnMOvi1eF9o=;
        b=hp6Ul4F95XhNoDjXEAmFSGdcUXp3W7TI6SrYbsvrEMU99K5e0QVA32XNqMPIM7xqsQ
         ZbtS+VA1orV2lfxpSLLRa6VdOVg8v1efA2MrvmLlNu7rtjnApd2FMtM6YP7DOBtwEI07
         kBk3tlYhtNyWLEaekpK7pteXHBqNHxBTu7Hc0gf419aar37fxT/EjxoDwDl9Sszt0Z7a
         kFvyV0m1DpxxsWL/hgtIJEpG2r7TFQ7Es6TNluozvzIa+ODA38iW5NSvkDuuznwkKHuc
         pgbavENxByLWPsuF1Eh/VUerEPtj2FPBR1Q94USi3WaddQrYxGRCvi1a694LefvLNHg1
         E0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXUx06oJT/+zgbmZqn4kv4+n4Uhkp1jeCt/tgQcyuc54OZDrpDl0wrO4FslQhQ83o2/wcNS29T9FDjqT0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnfMiHSIZYIjSVn3tI8ABYysfNdj35hFrLcKAzfIMeZbxlzcq
	vAU0AQTeg5iy3KVGSQfp1Sw5BoUlNfGAHaxXz4ry4tfvj9YS8HPx8HU2yRLrCfzMU1SykT42Nly
	uKQ==
X-Google-Smtp-Source: AGHT+IE3A5x2sUJ+Cn1s5c56XZQB8WCAQ+Lf4fqwvcHV68yk6YbrhLGVnyRHgnwWyjD2MPdnSo4edQ==
X-Received: by 2002:a05:6512:3b9b:b0:539:fbd4:9c9a with SMTP id 2adb3069b0e04-53d8626c823mr2854954e87.35.1731112291566;
        Fri, 08 Nov 2024 16:31:31 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826af020sm782907e87.268.2024.11.08.16.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 16:31:30 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a007743e7so3496465e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:31:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmrLey63ewlP8vVGh/lb8YZCExz9D0OVM06U407mtDBjyOwLktuiOkp6cUhCwsWP0RoBLWSywih8mMP4w=@vger.kernel.org
X-Received: by 2002:a05:6512:32c9:b0:53c:74ca:91d9 with SMTP id
 2adb3069b0e04-53d8623e16emr2259678e87.25.1731112289873; Fri, 08 Nov 2024
 16:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108221116.GA123748@lichtman.org>
In-Reply-To: <20241108221116.GA123748@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 16:31:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X6oS+v-ZvJWsHYAnfVg0Lurt8z4aYaboDKkib=p4zyJw@mail.gmail.com>
Message-ID: <CAD=FV=X6oS+v-ZvJWsHYAnfVg0Lurt8z4aYaboDKkib=p4zyJw@mail.gmail.com>
Subject: Re: [PATCH] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 8, 2024 at 2:11=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wrot=
e:
>
> Problem: When using KDB via keyboard it does not react to control
> characters which are supported in serial mode.
>
> Example: Chords such as CTRL+A/E/D/P do not work in keyboard mode
>
> Solution: Before disregarding a non-printable key character, check if it
> is one of the supported control characters, I have took the control
> characters from the switch case upwards in this function that translates
> scan codes of arrow keys/backspace/home/.. to the control characters.
> I have took them all besides the TAB control character translation (I am
> not sure what that maps to on the keyboard)

Tab translates to 9, so the 9th character. Ctrl-I.


>  kernel/debug/kdb/kdb_keyboard.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keybo=
ard.c
> index 3c2987f46f6e..2c004abd5375 100644
> --- a/kernel/debug/kdb/kdb_keyboard.c
> +++ b/kernel/debug/kdb/kdb_keyboard.c
> @@ -172,6 +172,9 @@ int kdb_get_kbd_char(void)
>         switch (KTYP(keychar)) {
>         case KT_LETTER:
>         case KT_LATIN:
> +               if (keychar =3D=3D 4 || keychar =3D=3D 1 || keychar =3D=
=3D 5 || keychar =3D=3D 2 ||
> +                   keychar =3D=3D 16 || keychar =3D=3D 14 || keychar =3D=
=3D 6)
> +                       return keychar;         /* non-printable supporte=
d control characters (e.g. CTRL+A) */

This is probably OK, but IMO readability here (and above) could be
improved. Untested, but I think:

#define CTRL(c) (c - 64)

Then:

/* Allowlist supported control characters */
switch(keychar) {
case CTRL('A'): /* Home */
case CTRL('B'): /* Left */
case CTRL('D'): /* Del */
case CTRL('E'): /* End */
case CTRL('F'): /* Right */
case CTRL('I'): /* Tab */
case CTRL('N'): /* Down */
case CTRL('P'): /* Up */
    return keychar;
}

The code above could also use them, AKA (untested):

/* Translate special keys to equivalent Ctrl characters */
switch (scancode) {
case 0xF: /* Tab */
  return CTRL('I');
case 0x53: /* Del */
  return CTRL('D');
case 0x47: /* Home */
  return CTRL('A');
case 0x4F: /* End */
  return CTRL('E');
case 0x4B: /* Left */
  return CTRL('B');
case 0x48: /* Up */
  return CTRL('P');
case 0x50: /* Down */
  return CTRL('N');
case 0x4D: /* Right */
  return CTRL('F');
}

