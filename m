Return-Path: <linux-kernel+bounces-433690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CC9E5BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115AF2868C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90322146C;
	Thu,  5 Dec 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQHOqbp4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD6226ECD;
	Thu,  5 Dec 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416951; cv=none; b=QSfLECULeovYOcc4avUws8wWg4tpNJbtdC7giCU0DBafp7OakUzqI/KBQVzKICyc9a4JkLpoEavcIVzzVdd7ZiGk/y7KcaekNWY5rFe1BxEdMIxgKDQWx7YVvP6dHn+/23XYNk7xXC8rgNR48jNYQlwpHuQpBPUmipieXijJVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416951; c=relaxed/simple;
	bh=uwJORr6lYv+2fD/3UybCxfQotZIsukSpSifUmgN5abY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei+CjBCPIWqYEnBcWngOZ+7GDH9eylX3QaGWm4OFXf/VowQ3zO9+SAtm/GHmxUinYcj11pVibqLeXakg0doGr/M5sNm4/PQCSr83SReJ4ElqN9hHtXFEg/yHnSuhumlYM24792yKsse1VoDsl6pCOHbuCatgQ3uxKbeWJdikPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQHOqbp4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so1399323e87.1;
        Thu, 05 Dec 2024 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733416948; x=1734021748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xL38ZgZFjgD/c1dhEQ6sIMBHQ5oRx1qiNvWMWE5O0q0=;
        b=WQHOqbp4VyjoVrZ4sDy5ISt1uDX1kvr1ILuumD1sNPK5Niqwt+qQrFGPh0oiucZqO+
         w93iKuPhpOTjxGObpfRteKdL8VPY11dmDAXHPoc6Nu+PY36fZHOQzoMGhxFGzgcSef1i
         zXtYn1zLtukoy0bPl5irK3MZ16Gi9vPGnnG025mnqfo76v/ow6t4kkJ9NIFK883AXevu
         p5GtK3vKiD5yYkIXjvxNGhy5APPuzA/jMs3Z9bnOKMIGjyOmmIIgyWisTkQlpf8m5qnQ
         lAiLCoHy0gvOCB325HjJBf72KUsn6DXakOy/gJCk25HLPrUjonIQNLPHc5BFYAaHfllS
         +sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416948; x=1734021748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xL38ZgZFjgD/c1dhEQ6sIMBHQ5oRx1qiNvWMWE5O0q0=;
        b=DI6WwzdPnhjxBkxgGONamBAFUMWhIRT7HMcVMMhwMRsqoR6bNESpDCRynkGJt4YeE/
         rdqwyZS2c3KgWDHxD8DcdwbpDFgVjyGXegC2F4u27MWz8BFduqMuKUdlmhW+f5CltquL
         dW1Zm1B+zUPGVQdJ3/h9WB4YIjY5TA/72qiQY0hnd+xpPPELhVdCRTxvsulUo4XttX7A
         VO4wdrudCC4u5oxsToKhuXjRLhxpuLsWz2U56eydD1WvFG5Vu6U/5mHExAatKiflC1FJ
         9gmbsj0qhgVSzJ5UsG5Jwj0UjWTTCneRxjd0CmGWgSW+OoSZd2OQo76eNZf5nK8Gs91F
         2wGw==
X-Forwarded-Encrypted: i=1; AJvYcCUI0/TYF+/BCUrPlTjK1kNIm5eYCWewETLFqT4bf9qrul3Mv/5x2ZMvjV+jjFXdFOHmwxHch7iMmMvApvU=@vger.kernel.org, AJvYcCWHMNQh5wcCv81i5kPHhwb+WIGe422NFc0ad3DmZJuQVUEVwfCy+wtw/PwCInvWaUiedJR+2ceAmw/OLZIKO0qjph0JQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Vn6qA+1g4mECvigsiSq9FVj5Jd8wVNQu/iFem05XEEnDLBUJ
	1egBUjoeHtpK3WxvTiPjDb0tALnj+Ve7Y3oFtcZvjdThEZwhwCBy9oL5jzCRYK/vyW8P+4u/8kx
	D202N9f04D3j4YR0T6l3FECHU65k=
X-Gm-Gg: ASbGncsrf0rhqdp14gz9qLplgwQIEqrTXhPA1w6ZT22V5YzF+Nyt/HayPVxTTMAHeSx
	HngrireZqsM5Xd5eMY8fpQtYWlBtBDQD8Fw==
X-Google-Smtp-Source: AGHT+IEE5u4KC9DrYBNEk3YONZDgsrN6j2NnGhOJbTc6tQTEFRHZ8bud1/TQacX6mhHTp8Ec35zqmHGlg5KBCr4+e/s=
X-Received: by 2002:a05:6512:3b83:b0:53d:d41e:b1a8 with SMTP id
 2adb3069b0e04-53e129fdd48mr5668318e87.20.1733416947747; Thu, 05 Dec 2024
 08:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123133041.16042-1-sedat.dilek@gmail.com> <173315902007.13686.16854039790074639451.b4-ty@linux.intel.com>
In-Reply-To: <173315902007.13686.16854039790074639451.b4-ty@linux.intel.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 5 Dec 2024 17:41:57 +0100
Message-ID: <CA+icZUXSKmnLZGY7U4xpOBEhEz5UUh88Ko1WFFKCAwPBRwohpA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Corentin Chary <corentin.chary@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 6:05=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 23 Nov 2024 14:29:28 +0100, Sedat Dilek wrote:
>
> > Rename from "Samsung Backlight driver" to "Samsung Laptop driver".
> >
> >
>
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-fixes branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> local branch there, which might take a while.
>
> The list of commits applied:
> [1/1] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
>       commit: 3510398032b445abd034753ce86a60882f41fe27
>
> --
>  i.

Thanks, Ilpo.

The commit is now in fixes Git branch.

Best regards,
-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-=
x86.git/log/?h=3Dfixes

