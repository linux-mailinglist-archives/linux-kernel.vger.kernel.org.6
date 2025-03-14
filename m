Return-Path: <linux-kernel+bounces-561143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33CA60E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942443AD9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1C1F239B;
	Fri, 14 Mar 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ux3MiuMS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC51DE4D6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946325; cv=none; b=JhVPmuCv4oGvkykmiCQnQoWYqIZdzq4BwA1GtAHImSNWV9veaUuSN8cH2xOKKsDz+dtQt8a60KCyNE35oquBgv1Wtm0i3vkWzzTXyeQYWN/WG5pJl1eRSGNCFiagJjqN24yhmD+Na6UGPlISMYFGzMmaLQuy9kGViBUnLXnUKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946325; c=relaxed/simple;
	bh=6ledBmw64IMYLCB3uHex3PJXa66AnJ6XewpvkI41vUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJaiaDVO5nG432RSqbDL1CD0pUg1A5HW8lPBAqyR6weD6UMtead3U9/1yzz6X/H2LZ2v/0wW77qQ88VcXzG/n7OCLHCrFYQCXNcPyWZj1omHKWz2O/7zcIes34VlBuD/xQD2a3L7R2m1CLxRy6Fk/voEDXxog6crHS+6RYRwf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ux3MiuMS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498c742661so2115611e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741946321; x=1742551121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVMJ0XfN9QvODwePy74mrcG1WyO6ynuUF5BlFrOKL7Q=;
        b=ux3MiuMSrmrzSLvGjjBlbudcJ+OJkzIB3CinmGI1ijyw9UEFNhgI6RtFZzaMN9FW7T
         Zb9DNTHJEC1v9A5umuT3S/U6RQNjNcmSv8W/rkIY4FQLuRf2mS+JQf3rMaCJ6Kgh/axw
         e/+vMxBwANjvt2X5DfEaNETaqw8kstCUKtc2MsanYV8xlEYzsR/P7ijrhOvCuFORPHx2
         RwFSQWlCLwp73bhyyArAEvQLN3gUlfcxEuIuiy6irf9nB4vaIVt9Xs5BkZnLbUIlK5D6
         qwGFZVTbka3r4bBBIRhdTfNzXTu6x+O6pThgm4vqy1fIAsWmtj2x0dT5N1VZKGsLN6So
         GIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946321; x=1742551121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVMJ0XfN9QvODwePy74mrcG1WyO6ynuUF5BlFrOKL7Q=;
        b=ZC/xegGei3d8EYuI6ZfXCUXJ7fFg8f/wR89vbUeUd5eR9s+aAUFTacNNcckuLE/xy2
         AMZxGikB3zOQUAgOXmRpvXz5lLQ2Ph0om4Lm8QGx1P4S1/sM+/yIDhLtmVJ7C0tjztb5
         x4qsfRXtFTJMCFlWcQeMt/KAWMYfSSBSQN01MMcQH5Rs4QnEjPxvbQHPmtLQuBE7kncM
         GxxfsZFxA4wEAjE1QnpDMyl1LDvO1yCeE7uncGfi+MhFwikxzzkP44xlb5OKWpyXeAyG
         luFEAqUYkHICRwH9l1nI7VTtMOPSUdeoti+IY7XqXPdXs3WuWazG/XWON7KV1G45N6Cr
         mOUw==
X-Forwarded-Encrypted: i=1; AJvYcCUU/pKG4BAwt/sQywC7e1Ey0eZM6EykI1lBHYzM4g06Z4+Nedw0ltUkuq2RFG1KYcOQyegI9a08sxefPAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/OQ7ifoOd+ZfTDjuWHpHmoYqLlBRVWvtQvbFgkwTtpynrZud
	/jd2oEy3vPm/nr2KMvqeK0JJA8Sh7UsAvdgs0qf0cPgSBGN12gmuWAhfkcogmKDcH0Ih7EYlcHb
	bxFDyR5svX3gIWZuns1/nkgjWVonlc5OgFkFt3A==
X-Gm-Gg: ASbGnct5NoWY+rNxe8zHS8uLfe7KehYLk/x/6xen35FMvGZSGgbVfGmVh2O+6Z5ZXB1
	fUdPIdq7bgvzy0X5bTm07JzV8Lf1Nyvwi+mNq4PZ+UN1jIwjDZGRMeIdqNiG/O4acPqDAYCD7re
	jqUMOgpnJLGzGmJ5Hvz0zE9MqKDYM3VxC/Q6+IgYkBWHNVGhGUqe0NjnaYlYqtvjxwD7kg
X-Google-Smtp-Source: AGHT+IH9j3IpXeGPyRXEy97HD90nMbYlV7KsDn8yxwE7zodQopDU2nIKQMb3fZvnWWerH5fkqmb9lqn3N0aqV3VOL1s=
X-Received: by 2002:a05:6512:3c8a:b0:545:5d:a5ea with SMTP id
 2adb3069b0e04-549c38eaca6mr633793e87.3.1741946320671; Fri, 14 Mar 2025
 02:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-da850-fix-select-da8xx-v1-1-a348ab91448f@baylibre.com>
 <CAMRc=Mc7Xa58J55_kenkr2OA=ho6YH_gENOFEvAiA+q+p54dDQ@mail.gmail.com> <4866908a-2e93-4d19-aef3-5203e002a8cf@baylibre.com>
In-Reply-To: <4866908a-2e93-4d19-aef3-5203e002a8cf@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Mar 2025 10:58:29 +0100
X-Gm-Features: AQ5f1JpPB3PpPt-JuLNaawcumS6S_tcIHXPiru5slPy000cZaWv72avVODqoiVs
Message-ID: <CAMRc=Md=Qz1AEToj4ebg-0HTDgKm=pfDhvmJs7Hngt2x_CpWSA@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX
To: David Lechner <dlechner@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:17=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 4/2/24 3:47 AM, Bartosz Golaszewski wrote:
> > On Mon, Apr 1, 2024 at 5:10=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >>
> >> Chips in the DA850 family need to have ARCH_DAVINCI_DA8XX to be select=
ed
> >> in order to enable some peripheral drivers.
> >>
> >> This was accidentally removed in a previous commit.
> >>
> >> Fixes: dec85a95167a ("ARM: davinci: clean up platform support")
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  arch/arm/mach-davinci/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kco=
nfig
> >> index 2a8a9fe46586..3fa15f342240 100644
> >> --- a/arch/arm/mach-davinci/Kconfig
> >> +++ b/arch/arm/mach-davinci/Kconfig
> >> @@ -27,6 +27,7 @@ config ARCH_DAVINCI_DA830
> >>
> >>  config ARCH_DAVINCI_DA850
> >>         bool "DA850/OMAP-L138/AM18x based system"
> >> +       select ARCH_DAVINCI_DA8XX
> >>         select DAVINCI_CP_INTC
> >>
> >>  config ARCH_DAVINCI_DA8XX
> >>
> >> ---
> >> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> >> change-id: 20240401-da850-fix-select-da8xx-989725eec11f
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi Bartosz, here's an old one that never got picked up and I never got ar=
ound
> to resending. Can you pick it up along with the other davinci stuff you a=
re
> doing this cycle?

I already sent out my PR for this cycle. Maybe Arnd can pick it up
directly? Otherwise, remind me after the merge window.

Bartosz

