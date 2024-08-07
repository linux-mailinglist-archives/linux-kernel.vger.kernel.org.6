Return-Path: <linux-kernel+bounces-278549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68794B1B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5F71C21160
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08B148FFF;
	Wed,  7 Aug 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnFr0o+8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FA364BC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064562; cv=none; b=Xix9T/zSs848/qvEVjpMKVtRMkw6SEX0czUhiVdFn3O72V3sKoGwfjpfeAgAVBf6/ACJKBnlVJBJ9yFwwFI0/Uah+OL3oqojWNW0vV8GbSR5qe6u3+q01SjSVKhA1pbQ11mgWr5npDu/buK4IR+e1WbwlomwfmpHCbVLQvOKWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064562; c=relaxed/simple;
	bh=cTYXAHlyuGK4qJh3GSpiuZskKn2nz6H+kdyrHKoET5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqj2LLiCULcSFFvvJigN/1KPzwe0CSlzpMpmpu1O1w83BXVzBEg73NvzGgoVNF8d6pM4sW5CFFhn4w7dLKpk9O4i5iYN6rf8jwfFewWNRu2B7qfXVEew8E+OtQ/7Zu38ubdZS2AhYGd2bpjvpK0VGrNNpg0+vB3QrnPGYGmPgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KnFr0o+8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so297029a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723064558; x=1723669358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTYXAHlyuGK4qJh3GSpiuZskKn2nz6H+kdyrHKoET5c=;
        b=KnFr0o+8eMnpQOzdhAYGxPZSb01+LMGbCIxNvYddgFU1w+fj4Ekeno2RPtp/QenQR2
         USOczaUKA1ZwYILE2guurPRmDF4lZimbI5Zrbpy123RVkQJNJ25LEX6Q0BUcEua+B0/c
         Ybq8L95uhU7Q9oZgLNBl/xsnecaWTXwjNxCuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723064558; x=1723669358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTYXAHlyuGK4qJh3GSpiuZskKn2nz6H+kdyrHKoET5c=;
        b=Q3Tkcy7gnytWMqHWnAMBovLFOnt+ANKfGPsgPjJjEdaZdFP9E3ojPv8p+NFioXr1YE
         dKUtbCZc0CkRciDQir0bkNWIqvbnoDzTrvs5iN0ZYQm0jM08407wR4nmG3o5aTUuUowA
         gjNXFXkYaGO6w8QkCty53fLB/TTgM/+qrDpVqSsyibc33760AIbclfK4b9gxn/CcD5jW
         Fn5p1mYk5NqjViWMAinb8wY87qncIr1buxRwMUMXI+q63TZoChUJLCzMbdw3hxXXQboV
         lzdZ/ewljVcTZYKa1yFZKPOvskA7IKCrfdnaaCY1JMPxoDQhrQRpuxoWiA0OgZd7ek22
         ZrXw==
X-Forwarded-Encrypted: i=1; AJvYcCWIEobJWxcatKP8yHlepdix/6okd1HHhl63WXRFFFeeWUOYomfYGPJ5pGX3KT+vlD83VzPYIx37duqXiSTh7LicagvY7BXCUWgYLq3S
X-Gm-Message-State: AOJu0YzmzvcvjEFncu3eTex/nQbqKrAKcLhgofqbUle3usMdUctwEeZE
	hCdf6LKWzt0lilLInCuc9G6l1qnweWA/oXBnLuNw042UPrfTxEB3qrgO+Nv/6Nl/5fhtY5ZUtFx
	01w==
X-Google-Smtp-Source: AGHT+IHaov66TYrI6c/jm3UDeS6mQxmpC55QOPZ9diHfVMta1qvV+P7gPD7PC8QWIDnRwDXD6HySUQ==
X-Received: by 2002:a17:907:72c9:b0:a7a:d093:f843 with SMTP id a640c23a62f3a-a7dc50feae0mr1488709866b.63.1723064557567;
        Wed, 07 Aug 2024 14:02:37 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecabb2sm666713266b.214.2024.08.07.14.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:02:37 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso6965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBegYUQN4Hfkc4aJDCzHPH0kCP08AA/BT/lhn1iU7cmpUG96IZF9vDRlcRws/hNKUEljlw1e4AO2qeozrVRtUPMOkLDdGDrznRfq12
X-Received: by 2002:a05:600c:a4f:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-42909cdf292mr410945e9.0.1723064555426; Wed, 07 Aug 2024
 14:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624185345.11113-1-michael@amarulasolutions.com> <CAOf5uwkhThmTEuhYAxAgLqg86PEHJ49wWp67RahVhio=O2OfQw@mail.gmail.com>
In-Reply-To: <CAOf5uwkhThmTEuhYAxAgLqg86PEHJ49wWp67RahVhio=O2OfQw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Aug 2024 14:02:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9=Ynhgi3nrfuM47rz053iWTvsEhhQFkZ5xp_bmwzmLA@mail.gmail.com>
Message-ID: <CAD=FV=W9=Ynhgi3nrfuM47rz053iWTvsEhhQFkZ5xp_bmwzmLA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 7, 2024 at 5:39=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Doug
>
> +cc Doug
>
> I have seen that you have done some re-working and investigation on
> drm stack, do you have some
> suggestion on this case?
>
> On Mon, Jun 24, 2024 at 8:53=E2=80=AFPM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > The shutdown function can be called when the display is already
> > unprepared. For example during reboot this trigger a kernel
> > backlog. Calling the drm_panel_unprepare, allow us to avoid
> > to trigger the kernel warning
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >
> > It's not obviovus if shutdown can be dropped or this problem depends
> > on the display stack as it is implmented. More feedback is required
> > here

In general the shutdown should be dropped and it should be up to the
display driver to do the shutdown. If your panel needs to be used with
a DRM Modeset driver that doesn't properly call shutdown then the
ideal solution would be to fix the DRM Modeset driver. If this is
somehow impossible, I suspect folks would (begrudgingly) accept some
other solution.

From a super quick look, I see:

* This panel seems to be used upstream by "imx8mn-bsh-smm-s2-display.dtsi"

* In "imx8mn.dtsi" I see "lcdif" is "fsl,imx6sx-lcdif".

* "fsl,imx6sx-lcdif" seems to be handled by "drivers/gpu/drm/mxsfb/mxsfb_dr=
v.c"

* Previously I determined that "mxsfb-drm" was indeed calling
drm_atomic_helper_shutdown() properly [1]

...so it seems like just dropping the shutdown handler in this panel is cor=
rect.


[1] https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f=
746b93621749c@changeid

-Doug

