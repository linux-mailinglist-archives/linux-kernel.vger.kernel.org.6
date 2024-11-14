Return-Path: <linux-kernel+bounces-409669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CEA9C8FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B13E281102
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE8166F25;
	Thu, 14 Nov 2024 16:35:50 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F58F62
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602149; cv=none; b=M5p8A+CD4JH58XqRSzaSJZXR9qKbDGChZBf6+4+Fhxz4C63NeY+yGDRJR7UjfJBs4K4sxAhRiHzvGHEQNxE8exulUu8e9XRpfJaUPT12brHphYqhRgUfjhG20EU8h1+Hg/WNTM1NfIRqXvtjinOxKjb7ME3pkwcB49CzpVf//eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602149; c=relaxed/simple;
	bh=JeOGZyNYheVXtcf54L3xzI7R8X0oLwAMyN0n3X67Qys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4VrodlE/HrkUnc0vu3xA7L4AVs4Gef/HxzdCth/C8qFdnUHVFzpODVwKepAQf6tbX94KQEyqoenYIOCjT/aqfB9dgn1g9z/hvgqqWNikXmeFhxXrsobRUG8Hp3skCPf1g6vcsQlUr8LJhiTwzx/87BPoaTEA7FWRoR9NmB7Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso972384276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602147; x=1732206947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkTsD4p17KtYX2Naw41InyqJWAq7hOuOapsF7fXl/og=;
        b=hhDyA03McjVteAFUBY1xsqsA2knqEgRsdZOEeemoMciY72Ue3tB+T9a1U8IFFmRDF0
         quZ0NKlMgN/9ffIv4mmsGPEOiPRpTIs0SoHpe+H49EgdY92wNwQ1nKp8BXOq+6ayWjy1
         d9OklaY1XAXjYtQtjkI2HMiS2ndCBC4bc1+ltwCC2/A+xVQadYZ1ENpTMZRJg06cuC2J
         dpubtKgSTgGZwF+cGAWmr3o9glYcOD22nUGKiJTXZK8OSf74JKriPwsnyRMzvg0WBABQ
         1XyBFkZzz5hVWNtlx2IN0bdnBnh6qoXmTEy8ZFLgo+FWl+6XH4KyVnWpB4MkZI9pl8lU
         AKWw==
X-Forwarded-Encrypted: i=1; AJvYcCU98NAU5Esf4E5N5DcPYF2Es1Aa7KYdgVJyBmH1KCc0YQGPxIiu1jJmFpiT54BmVNTLR4AZJ9+uAvlFUW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6NsO0lOGZQSuwGe37cRWBWyLVeBAP0aaTOzUb4+WrJswF1lN
	2PSoZ0ctwDEBGfbtq1IXt6jpf7kGGu2Ymm8pDkqcGbDhKNym3GUQ4gQqIoO2
X-Google-Smtp-Source: AGHT+IF4+MmBnEpSXy0nnSq8Rwbc65d38iMpq9sDuxZ7G+eOUkUHntMrEqYqUqIIBE1JGC73CxMhSw==
X-Received: by 2002:a05:6902:102b:b0:e2e:46e5:c2ca with SMTP id 3f1490d57ef6-e337f861a10mr25514511276.14.1731602145799;
        Thu, 14 Nov 2024 08:35:45 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e381545b964sm387190276.42.2024.11.14.08.35.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 08:35:45 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee4fcfd92dso2727667b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:35:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxkzFBOXlXAIEi4nNuf2jm7paIFF2620hHtukKjvugzpyVvJ23fRnatzKy+l9MJo8rz5gUzqeiGxDfSxI=@vger.kernel.org
X-Received: by 2002:a05:690c:7487:b0:6ea:bfbd:5511 with SMTP id
 00721157ae682-6eaddf9703fmr271941207b3.33.1731602145354; Thu, 14 Nov 2024
 08:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114131114.602234-8-mpe@ellerman.id.au>
 <ecb9d449-85dd-4ca5-a58b-43244b7c0765@app.fastmail.com>
In-Reply-To: <ecb9d449-85dd-4ca5-a58b-43244b7c0765@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 17:35:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUxY7YErDa8OzxemnwJ=j+tcoXGs-Gma+eD0i7bPWYB9w@mail.gmail.com>
Message-ID: <CAMuHMdUxY7YErDa8OzxemnwJ=j+tcoXGs-Gma+eD0i7bPWYB9w@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] macintosh: Remove ADB_MACIO
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, Nov 14, 2024 at 4:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> I also found the promotional video from 1996 at
> https://www.youtube.com/watch?v=3DNrvrIEPeSNA .

Amazing to finally see this, 20y after mine died...

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

