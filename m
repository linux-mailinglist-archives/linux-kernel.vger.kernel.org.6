Return-Path: <linux-kernel+bounces-270451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA78943FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2772817BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C41E4A9;
	Thu,  1 Aug 2024 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LtMq90Ff"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363813D2BC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474917; cv=none; b=mLGCMFDkAbg/wnjqU0yT0PXt5zuh148EU/1cx+IcTga7cyhrNbRWI4rFsKyWAi6J5wMUNuzGuMNQv8bGkNx/JX4ZkJ+jjPSR3Ue4mB1RuwQTBjCIW9/avW6Cb4BQjwwhP0zaoetgWIEbuyyt9apqLjWyUc7MOWWmWHXhr6hsQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474917; c=relaxed/simple;
	bh=SVgN9X5MN2Naoy6g3BbCxdj5ajlWUjJvw/VDf7KG5UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6bNKhXUglFYC4UWzWw0yMDglXL/hkz1egrX8TZBcX1LbzqtLK8NhWNFjtTEkMXW6IvPbx0GBwJLEmv1y4sTfbCMO963565SzdM8mCvHdwuJSuIUImkdGL8aFSIK3n63DhreRM8nmTWyBmmucJG2AyJsuP0lON7ehItIiNZlueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LtMq90Ff; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66a048806e6so50854397b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722474914; x=1723079714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=380+7SLY0H8ozFzYirfka87loOWyMCcZqwS7osxD590=;
        b=LtMq90FfoXJqpyIJgWu98Kqe8cNcEj9mBwaltQHdhHG4XeHaUqFDbFXQ0/KSSujNR1
         0xZGqHJMB4wSBcDhuWKo+23GstKn8Ve3M94iMV08A/ZMVO/Vq6otskBK54LPymJuwW+P
         dlGY280i3baeIliMC+jMrhuL9ejfr007+3jwM99mdy10nuPLEwUCJMjJiQh8o4qwPttV
         fWdjIHFHHa1i7HbM8SRSIoIeeNBXMvGGefFSRTua0ENtYepXpjZcSYzM1DuNHCCs2rD/
         jUC/1Cy4XNo2xravXK/JYhYr3V0MAngAzqtGekMfOZOP1fXgTt8GECAc/z9yxx8yClr4
         a5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722474914; x=1723079714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=380+7SLY0H8ozFzYirfka87loOWyMCcZqwS7osxD590=;
        b=qrlBHdGOM7paOKbwKC0mkjdahMIjV9h40EtvoG3ZTakVAurBF2WyuD5VxVzTIQvu0K
         olnVRZnTvGisKDqwIoPUkOnmA1jEvTiYaqPPLFd1xG4zzrIBBm6Mi9IqITJIM7siY1lY
         sYQM3YvstcuzF3FdHVsGr2VV37TaI7epTY/4qvr31Zx8IR8An+10WoSfmrB5sfZsX9MP
         amWPwfisFNy5e+3iSHleNGzXL3V67ff3KhiGb+XJCSnon30Sw6EzVBoFAE4d65edTCTl
         6bwihEPILWxY6OmBB2WeJxwQx1a01e7noSnz412OR1YPlz4crXVr5bNR89rafSCh8ecW
         Eqyw==
X-Forwarded-Encrypted: i=1; AJvYcCWekI7er7Oxmo5A5JKp6Re8D8+f+QkTdQrpbgEwRebC7PUlsEtzSgqnAbtNii34/+dZ2qXidPHRntdn2M5+2l+wY+ljRr66RFQc04LM
X-Gm-Message-State: AOJu0Yx2N9Sj/XwJYlYQwd27NpTlAbVZn2qHviZmQ7717cMiV8/nNIUH
	17YGQWSlxGzYeQYwsKaLUi6+Vf2Z3anxdDiG3of+T80CYF05bWHignvYYbETV3NaaqdMcvP06jb
	oF+f9p8muw8jYzRXU/GQKGePYOb4zJD1ZD4HG2webgab4geQ=
X-Google-Smtp-Source: AGHT+IG+KigIi1ZwL6yi99ABagx3s36jnOVjsRDDCi4VPrvftlbYePPH9NniWpU2v6MTuDp5h9QJ1836JqjIPMDQSDE=
X-Received: by 2002:a81:9c53:0:b0:665:b876:e35f with SMTP id
 00721157ae682-6874c73d438mr11780657b3.22.1722474914685; Wed, 31 Jul 2024
 18:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731213429.2244234-1-kpsingh@kernel.org>
In-Reply-To: <20240731213429.2244234-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 21:15:04 -0400
Message-ID: <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Do jump_label_init before early_security_init
To: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> LSM indirect calls being are now replaced by static calls, this requires
> a jumpt_table_init before early_security_init where LSM hooks and their
> static calls and keys are initialized.
>
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static ca=
lls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Does this look okay, static call folks?

> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..5bd45af7a49e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -922,6 +922,8 @@ void start_kernel(void)
>         boot_cpu_init();
>         page_address_init();
>         pr_notice("%s", linux_banner);
> +       /* LSM and command line parameters use static keys */
> +       jump_label_init();
>         early_security_init();
>         setup_arch(&command_line);
>         setup_boot_config();
> @@ -933,8 +935,6 @@ void start_kernel(void)
>         boot_cpu_hotplug_init();
>
>         pr_notice("Kernel command line: %s\n", saved_command_line);
> -       /* parameters may set static keys */
> -       jump_label_init();
>         parse_early_param();
>         after_dashes =3D parse_args("Booting kernel",
>                                   static_command_line, __start___param,
> --
> 2.46.0.rc2.264.g509ed76dc8-goog

--=20
paul-moore.com

