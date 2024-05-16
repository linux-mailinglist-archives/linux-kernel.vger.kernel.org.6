Return-Path: <linux-kernel+bounces-181165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988378C785D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397B41F22697
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FFB149E00;
	Thu, 16 May 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDYC4GvO"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE31474C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869118; cv=none; b=Iv4W7MHo6tnPTb7n58AX+C5kv8Ux4+ZCb6/ayN7WLlFm+Qid0WiGsiF72CwcRpT7we6QtNab1ZFm8T2LpI1PDqCjHSTS7daSGlUUPUA/ar+mHLT9nq0KlOrbtYOV66cH5NvFEN6cKYlcml4EgD1Xhqjxs6v13zHJI5RzSNXbyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869118; c=relaxed/simple;
	bh=JPrbuvzJmP549EXMhSurniQz/CR0BpLb88/Sk6ORJvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk5+qT6rb9fmHS7qoAW/x3lIIBPAP3iJ+rsxlXygUg0bkkfn1U7YnvIW2Z76XxWcnklcJMJ3JIPJezvCAXU/VJbauquWrZjR1Aht+nVffA2Mto2RMrrzixPAkKs7pvW9av46hCHbjWgZ6Q8S+NLvFAvd2zwKK8IXx7RfPaAtVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDYC4GvO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so204750a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715869116; x=1716473916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFqFvB9X9x/SOQWaJl/MFlMCgaLN3M7Ecw56sYSywTw=;
        b=eDYC4GvOSb9YuLB4Z5nN4BJ7+IUaj+6OS6+6t4uNaiGkzOueMqLcAuWdCO48w/iAe/
         QXLhXCl+TQgbGEM6S+XnRSXP4AJrthn2+/d9nI80H2bCO8QgiFZ3eIsePS/1D+JliQah
         qnlcLnukQ/aIUo+s3CuIQ6IGbSyN1pV+rxel9TnOBJLpOqZVg9bQNZoy/Quxyrp8nm6t
         GULM3haInyWMyPJUPUNukevZVVAOHI0Xv7oLN+zWlPPMgvrLBxJN2UNSjq9ec7H2NAex
         wSuVwGXJLJL33orB090eETjPeu5eX722jtCXS6uW6tcoBTpmRM69k7Zo/IfMscgHECuz
         ThLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715869116; x=1716473916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFqFvB9X9x/SOQWaJl/MFlMCgaLN3M7Ecw56sYSywTw=;
        b=GDZfDYzbTWtE6HgZEd37SAVe0Ny0Xa8LY7JDaUmxQQ5E6getRJyBYTRK4dbUBYnUb6
         sUkJChroMOgzwqNeMU85ygvAUZJLC+HEWUHRihPJLU+GeZBPtMVj6zJ1fmgKl5SIqict
         lRht/7fRgGIl3MldgJd72ORdhET9sXwuN8sQxAs0SCFN3H3gfM4kdZUfZlZ7A7LDlD0v
         iffhlxKKC1w7MIoASj9EMjXpfQRZQYkm5Tnr+1a7aRHbQ7S+MNeHhwUdHqK6tL1zsVr9
         2lWwqQylXTlpaD6g0eL5lrqMX9ooeTSBJtNIGt7zPWKDmjYowUgvL6For06Q8mL2q1wK
         Q+fg==
X-Forwarded-Encrypted: i=1; AJvYcCVS3w7g5nEBe5vaKwDCKuyG8PkhH9tF2osMM5Ug85bPTJKZVKP3As39BFPVuegpEq7OkM3NUyV1BP3/vaixA4QHsdMNMQl9PHqgnXMO
X-Gm-Message-State: AOJu0YxNBQZ2G2pb/TB5mX/9YFC4qvzlxZ8lt9+HeQaKDFJwbu49OED7
	XPjYOrdL4LPHAZL2twK816nqqEoEDitkRdiZQddj2X7erzEuHSQEIVzG/VwtxTQr0wMde/3Iu4F
	Ue3YHSnradKoREh5YtZ92T2Q27EE=
X-Google-Smtp-Source: AGHT+IF7rqtlefoJskjfOVgRm5ttPIIXk/Hr85QpfbCuEVZDyoCo4P3ZYjyXFT1cO5o/oo/mwamP+cL6UUb1NwbjAVs=
X-Received: by 2002:a17:90b:b0f:b0:2b2:7c42:bcd7 with SMTP id
 98e67ed59e1d1-2b6cc97c729mr17131456a91.21.1715869116108; Thu, 16 May 2024
 07:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515192009.14362-1-kendallsm2@icloud.com>
In-Reply-To: <20240515192009.14362-1-kendallsm2@icloud.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 10:18:24 -0400
Message-ID: <CADnq5_Mb1fDJ=Z8Knnyj5B1YRN+ni1_mmje+==-C9ytmX0Z1uQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: initialize atom DIG backlight for iMac12, 1
 and iMac12, 2 with Radeon 6750M
To: Kendall Smith <kendallsm2@icloud.com>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, May 15, 2024 at 5:47=E2=80=AFPM Kendall Smith <kendallsm2@icloud.co=
m> wrote:
>
> If a Radeon 6750M GPU from an iMac12,1 is installed into an iMac 12,2, th=
ere is no backlight device initialized during boot. Everything else is func=
tional, but the display brightness cannot be controlled. There are no direc=
tories present in /sys/class/backlight after booting. A simple one line mod=
ification to an if statement fixes this issue by initializing the radeon ba=
cklight device for an iMac12,2 as well if it has a 6750M. After the patch, =
brightness can be controlled and radeon_bl0 is present in /sys/class/backli=
ght. This was tested by compiling the latest kernel with and without the pa=
tch.
>
> Signed-off-by: Kendall Smith <kendallsm2@icloud.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 2bff0d9e20f5..7b11674f5d45 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -201,7 +201,7 @@ void radeon_atom_backlight_init(struct radeon_encoder=
 *radeon_encoder,
>          */
>         if ((rdev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE) &&
>             (rdev->pdev->device =3D=3D 0x6741) &&
> -           !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
> +           !(dmi_match(DMI_PRODUCT_NAME, "iMac12,1") || dmi_match(DMI_PR=
ODUCT_NAME, "iMac12,2")))
>                 return;
>
>         if (!radeon_encoder->enc_priv)
> --
> 2.34.1
>

