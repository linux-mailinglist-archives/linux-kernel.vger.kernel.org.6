Return-Path: <linux-kernel+bounces-367410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031119A01D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2261C20CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89732193072;
	Wed, 16 Oct 2024 06:57:10 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D9170A37
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061830; cv=none; b=QUaHmGMWgpTzWzyPRIfEI58HWljXK0p9cjxxp+Oo52IZVxWvCnxO0i8AvSnTepHz2hTLx18wnWLsGbywl24D7pIEwF+L3vws5fNq4hhkZs1nElfporMhF41sioLm1quXR4pxl3wHFkuFdF3e1qNvHrb8vHhfpBCE5GqjUjDa6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061830; c=relaxed/simple;
	bh=/Pw7Lk19rpr5qs/y7YRHB+eljjtpGRyvbk/W8F7QdUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1qGIsoyj4U2M5ae1X8cb45rJERV4MSZajZUfmiJAp4DyxJ8OOiBDtlFph8sTkH22GU6B1KZFm6G2Jb64gW2uQkk6q7qvE0s9wKFUa8JHV2YFCFoDOXsw/fOWsnjdECfHWn10/7H/AfIng3DQ5gVuqZGr778Bn0tPkCCJpaXbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e41bd08bso65885667b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061826; x=1729666626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ULg06Dva0WoBj0m6VE1kEFmhnHFLA053b6bZA0CjUQ=;
        b=VTnqaMFyUp6ripROLjMWVZNwBp9n2uHGnUVbw2h0IxIGSzN88Imb8GXFO7b/ifw3EU
         2mgKxz+2n6LyQ52BYymn3fKrNQkVoK2SfMhaqynS9QcJyhFFuP1U7gbslIN4m1Gfw/OS
         Cy0ypfo/4rjz4vfFFcGb4SJ1gaoWjonC7AjklV0qduJq9xtfWv7ysQBk8qUe7p+EfRqU
         LMKJvkikp9wQU+aca0iURzTOhEt13p5KsBVuRvdwUZ1RR0Magkif1xN1sCuDFklc2aHX
         Evd56SlvOG531nCGdpqdSH2Ga/vN76TYSohlIh6wGIycjUxgGq+aQlbJfb8nGtQHF1Au
         CJkA==
X-Forwarded-Encrypted: i=1; AJvYcCU2pkUmuHJleIlqSNmrTXXJdvnS8xKfdtRBQlZoOKHVzEFX94sWItmRl6R1f0HGymrCIABcWCOGFs8gKaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dUegDfm1my2hmyX/QGVkY2SuDGYeQIxa0gJQCIyMF6M/MJYf
	WkGlc7k+dJSsQp96lt5Dt5HNax5L9Dkzb3upGLkN+uMkED+SAO2CbXkSiLOF
X-Google-Smtp-Source: AGHT+IF/owlHOK8PNBgPDWJ6bQ9y3LIURU770QsPHRdPRdZHY6JNWdkpBY98Lk1Hpf4arS6dFcuu4A==
X-Received: by 2002:a05:690c:3381:b0:6e2:12e5:35b4 with SMTP id 00721157ae682-6e363f17f9cmr119939587b3.0.1729061826337;
        Tue, 15 Oct 2024 23:57:06 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d25fbfsm5940497b3.124.2024.10.15.23.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 23:57:05 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e214c3d045so46369137b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:57:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdOcygtYTXSq2KuWOYPQn3FtAdtJkAQZX8L0hkj6Go5l5o8z5TuUeIZXADuw4NRpv8MrM7du2ggHZmDzY=@vger.kernel.org
X-Received: by 2002:a05:690c:6305:b0:6e3:3a22:7205 with SMTP id
 00721157ae682-6e3644c0082mr125754047b3.44.1729061825389; Tue, 15 Oct 2024
 23:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fix-m5441x-gpio-v1-1-0a29befd4b8d@yoseli.org>
In-Reply-To: <20241016-fix-m5441x-gpio-v1-1-0a29befd4b8d@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Oct 2024 08:56:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVktMFfPQZqvB6cdMOmxwBuG7CW9rqm1kU+p9MnrF1SWA@mail.gmail.com>
Message-ID: <CAMuHMdVktMFfPQZqvB6cdMOmxwBuG7CW9rqm1kU+p9MnrF1SWA@mail.gmail.com>
Subject: Re: [PATCH] m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

Thanks for your patch!

On Wed, Oct 16, 2024 at 8:45=E2=80=AFAM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> Fix a typo in the CONFIG_M5441x preprocessor condition, where the GPIO
> register offset was incorrectly set to 8 instead of 0. This prevented
> proper GPIO configuration for m5441x targets.
>
> Fixes: 83c6bdb827c9 ("m68knommu: Implement gpio support for m54xx.")

The typo was introduced in a different commit, so the correct tag would be
Fixes: bea8bcb12da09bd3 ("m68knommu: Add support for the Coldfire m5441x.")

> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

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

