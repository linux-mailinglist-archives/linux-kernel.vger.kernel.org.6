Return-Path: <linux-kernel+bounces-290684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F6955768
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CE8B21728
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2372148FF5;
	Sat, 17 Aug 2024 11:29:25 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983514883F
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894165; cv=none; b=ZvmUtYGSKzPBC0Hgcc9dm/1YYWo6zvaPZ1/JfCSNcpAZF8MS1TxHovFuNhMmEJI5HfJ36YOUym2aHSo7FuCg8eFGV/kxMqzMap+ZDbM4HFXn3aK6lUVGP107XaXIIj10lmGee4+tHX1/OG0JXYMcKBIKFHVX54Aqv0SzFlno8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894165; c=relaxed/simple;
	bh=VYdQL4HycLBApXUzI99povsLrS3ApxCsNKu9mKUX8DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3k12QwL10AfWMNoeA+jgw+AguQZG+6hBNWJMXdsbGgQyb6TqIscSnhEDv3QviG2QZIF/Ij5xBVDL9EZUvHdDQFxMeW3mavbkEMhbWCJRKCjfBDzl2Z45dcWpd8YeVfJUUMtuhFZHrfeqmsX1DVD88ma6KnHcbDn9YRjRft30nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b424e001e6so7462217b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723894161; x=1724498961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM6ythytb0slRRW9rR0HCeFWdoQmTXUFBzMIyoVQLMo=;
        b=UsWkeb3RZtrTgxV3Uu3Bfu0tWDOjQXR+dLU2+Y9IqZviAMC61ihUfzHBPe1KhBG8pA
         jD/ORC3MdzYrSn6G5aNQH3y0wRIjWvOQHk+0f9REWhm6pS5kwT6HiHWdGpd0/QyxE+2f
         vph7SlYlkk1V8yqrWRhY4Zx9mBiCdRN1YyESN1uaDZ98Jikmtsi5JUrZIetpnGS6Xs3R
         OJEPTPxJ7U7n4keQMigoe8pWyzKzi//7rDKJLMadZPJ35X2BOEZOModogl8rhaTcbidO
         6pjBeoJh+lDCz0iXWvWtKL644X3MAYkGxzM3+G0noITVi39Zme6QCH8ejSCThIloCA2c
         5vSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIRIQkIsAJB1sNpTmlkM3z1D+7bKYUaGWZAovO6KD551DGZkiRADa4/gx7GovbGasZohalQIopciFh7SMLOlj2HF07/6JeU47c0jNq
X-Gm-Message-State: AOJu0Yx3KU/f7kYi6gzylEs+S27yR9GrVyxHAAKYa1ZoJ7TCbcdvpPJZ
	PkVw0qEfy8lrfh1TuY6nB1rSM3PsMZPRKs0orKdOZk0vOJy8d/1AvKWlAqjT
X-Google-Smtp-Source: AGHT+IHxbAW/EpIKRNSb4yunxVEKvsmaLY3/eIaf8upB3FAxgO90R2YU5k68pW2fCuomyAYGzyC6+A==
X-Received: by 2002:a05:690c:386:b0:669:e266:2c55 with SMTP id 00721157ae682-6b1b6ec3ef9mr63355267b3.5.1723894161448;
        Sat, 17 Aug 2024 04:29:21 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9a77170csm9395137b3.61.2024.08.17.04.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 04:29:20 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b424e001e6so7462087b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 04:29:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDFrn95vPMj27zbyI9PlNS9ltwYpYb/piFLPL4Db/UWXp2rzV12GnS/Q87uw1j0w1iicr/woWvalNxQk5gmSsDji8e6b4OYn8FewaP
X-Received: by 2002:a05:690c:3206:b0:62d:45:4098 with SMTP id
 00721157ae682-6b1b92b10e2mr43363047b3.26.1723894160059; Sat, 17 Aug 2024
 04:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3633d85c51d2133622708e5b0e07cfea96fc295b.1723445731.git.fthain@linux-m68k.org>
In-Reply-To: <3633d85c51d2133622708e5b0e07cfea96fc295b.1723445731.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 17 Aug 2024 13:29:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx8XL5qPE0fWM3p6hWyUUH5FxSp-wCF5Q1ekXCSemmXA@mail.gmail.com>
Message-ID: <CAMuHMdVx8XL5qPE0fWM3p6hWyUUH5FxSp-wCF5Q1ekXCSemmXA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Revise PowerBook 500 series model name
To: Finn Thain <fthain@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>, Stan Johnson <userm57@yahoo.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn,

On Mon, Aug 12, 2024 at 8:56=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> =
wrote:
> The PowerBook 520, 540 and 550 all have macintosh_config->ident =3D=3D 72
> because that's their gestalt ID in MacOS. Hence, Linux describes them all
> as "Powerbook 520". Change that to "Powerbook 500 series", which is more
> accurate.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: Stan Johnson <userm57@yahoo.com>
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -677,7 +677,7 @@ static struct mac_model mac_data_table[] =3D {
>                 .floppy_type    =3D MAC_FLOPPY_OLD, /* SWIM 2 */
>         }, {
>                 .ident          =3D MAC_MODEL_PB520,
> -               .name           =3D "PowerBook 520",
> +               .name           =3D "PowerBook 500 series",
>                 .adb_type       =3D MAC_ADB_PB2,
>                 .via_type       =3D MAC_VIA_QUADRA,
>                 .scsi_type      =3D MAC_SCSI_OLD,

This is a user-visible change, through /proc/hardware.
Do you know if any userspace relies on the old string value?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

