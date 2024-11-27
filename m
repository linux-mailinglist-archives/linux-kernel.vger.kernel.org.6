Return-Path: <linux-kernel+bounces-423951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DE9DAEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32949164B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1B202F8B;
	Wed, 27 Nov 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbCOWpEu"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFB200B95
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740927; cv=none; b=EttcNeaw8oi14cAnXG0CHPwnYzfjq8X0Yzxa/33XHXBLhs037Qq/e2/25MXIxC8xKc1vnl9X5H+O/mu3DjjJHjhhhHPZXwGsSir0pKV/YvGjejwPJc7BGPwRSJxMU60C7CE82IWAXbPq59GqPhpHdCmlXQBw1P0Wl1C66LXJNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740927; c=relaxed/simple;
	bh=x2gfFrZUwzseqbug6gmVaw6spWNhlY9Px1PJF7ovdWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeGFUqFhXNyX7jywottXe/yhKR5cUrw2zL9dhssv6nZtj1F6xLnozGY6yr818VRnByb6SU/RDE8Z8IdRjQ2TO9CO7ZWneWKD3f6tt/NtjfyEbOTkOX1JIVlhJXzrOuSu8dAYsx9mBuWzXw9RmuLMHt6oYYyQppuFKRYZHGSXetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dbCOWpEu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so1837851fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732740923; x=1733345723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjCT3CJUw7mbVWg1te23k9gtZsl9VE0eK0p+bLSN3xk=;
        b=dbCOWpEuUWktuUq8hHBwymBbi9a1jj5zl/18A4Ib0Ucqba5dnFnuUxXu8SWdXjg/iu
         B8gX0292UD+LEcJkd65ukfB78GNY4Hs8k4sSn6QmXuMwq0sA7kzxctz/fc83TUXo/YeQ
         PcagXjI+LwHAOCEsBzLVQARbMaDReXqELYQNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740923; x=1733345723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjCT3CJUw7mbVWg1te23k9gtZsl9VE0eK0p+bLSN3xk=;
        b=edH+sWYPsLemRzC+RhRRnJ73PrP+ErSA/DewxIsaC9BS7k5u5cBwh/ofaeBSJ8ZSc+
         GJpI4+9AkipK2u+ORg+zJHX9yx23XeaQc6qyzvc1AZ6eTTOxVUmX/PVdeeopCdmMXUd9
         aGSeAnOJnVoWZnSV5S7rSCQVijxkkdvxaY/Q4F032M65REQmwidKEuH5Cme2lA3cbTj3
         uAeLTvhiCpVujLPguWDsu4lE9VLRMN7LSxPa3yVUi/sVbU3sJ9dWOOeQEtckQW7/Fia5
         Z/fAXWMLRqTA8G3w3yhz7Vhgz+JfqPpx7iaDu44h5JwQeLLVCImKT2JvKHPE1IrppTzY
         w+ig==
X-Forwarded-Encrypted: i=1; AJvYcCUH3nmX8w2krs5a4ZwJ+Ofw3o8H0ye8Ok6hSMfn7hQdDBtKEEmCJpc2m3EkmdKkwWVm7ijtYyVOGe5/T5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfx/TAxQES8Ulrk3gL4G8EKaZwNIR5985xg8HUkk2q9SsKr1F
	woZ8LCjOjdZQkbwBf6rAfLUBrNyNbBNpOK1rX3M/hGopwtAS5VkKeulGlleFCf/xPaji+X+BbMW
	OaQ==
X-Gm-Gg: ASbGnct3ogepA6KYBCxZvVDA5o6rOdSnmC643ziieGkphT08Jp1oEY04gGl5opXJhrx
	sSwQ/ciJ50v4cSLFRb2dd0EeO9PS7beF55XbmKQfyUhWzJyOpcVRnRj1kr/mrsCZSe/6F7i7web
	ydNGo2a5rid8bJ+eGkV+9gp8RksQcQR4xcAL0inhbZp3OCEdsgpFuNviqdib6pXNAIilcg9PzuY
	i7b06feCLxpzbLMXYevafI3R0O5f4MzebEgR1ESNDXvlWMO2P7tyl+dhufEtU1GzCS+ZZtMsl/e
	e350tKwI/+p2SeP80g==
X-Google-Smtp-Source: AGHT+IEVrSDbQpoCezq0kO5eOExvYlDgjKkGncyiZ7m2Vv7kOGywqyBWEsIqYIff7UPpTWo3xFsrIQ==
X-Received: by 2002:a2e:bc88:0:b0:2ff:dda2:eb0b with SMTP id 38308e7fff4ca-2ffdda2f145mr9414821fa.19.1732740922644;
        Wed, 27 Nov 2024 12:55:22 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53a0729sm21553071fa.118.2024.11.27.12.55.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 12:55:21 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so1779121fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJAeBhVA2GnwhT0DAiEaFB+0jUcWUR2h0tspRDdLgtzNHSL749BzcZ3XrkLF7pM5CjUmU+PxvVVraKOc8=@vger.kernel.org
X-Received: by 2002:a05:651c:18c4:b0:2fb:3445:a4af with SMTP id
 38308e7fff4ca-2ffd60325f3mr31834761fa.21.1732740921491; Wed, 27 Nov 2024
 12:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204527.GA285791@lichtman.org>
In-Reply-To: <20241121204527.GA285791@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Nov 2024 12:55:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6B9mAb-EQaK1K+pa4duzOGmz=dt4QUFVVGUbq7NnK3Q@mail.gmail.com>
Message-ID: <CAD=FV=V6B9mAb-EQaK1K+pa4duzOGmz=dt4QUFVVGUbq7NnK3Q@mail.gmail.com>
Subject: Re: [PATCH] kdb: utilize more readable control characters macro in
 kdb io
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 21, 2024 at 12:45=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> @@ -267,7 +267,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>         if (key !=3D 9)

FWIW, the "9" above is better as CTRL_KEY('I').


> @@ -176,14 +174,16 @@ int kdb_get_kbd_char(void)
>         case KT_LATIN:
>                 switch (keychar) {
>                 /* non-printable supported control characters */
> -               case CTRL('A'): /* Home */
> -               case CTRL('B'): /* Left */
> -               case CTRL('D'): /* Del */
> -               case CTRL('E'): /* End */
> -               case CTRL('F'): /* Right */
> -               case CTRL('I'): /* Tab */
> -               case CTRL('N'): /* Down */
> -               case CTRL('P'): /* Up */
> +               case CTRL_KEY('A'): /* Home */
> +               case CTRL_KEY('B'): /* Left */
> +               case CTRL_KEY('D'): /* Del */
> +               case CTRL_KEY('E'): /* End */
> +               case CTRL_KEY('F'): /* Right */
> +               case CTRL_KEY('I'): /* Tab */
> +               case CTRL_KEY('K'):
> +               case CTRL_KEY('N'): /* Down */
> +               case CTRL_KEY('P'): /* Up */
> +               case CTRL_KEY('U'):

You snuck in a functionality change (adding Ctrl-K and Ctrl-U) here
that should be in a separate patch.

Otherwise this looks nice to me.

-Doug

