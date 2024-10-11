Return-Path: <linux-kernel+bounces-360623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53278999D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F51C226B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38ECBA2D;
	Fri, 11 Oct 2024 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQFqUwA3"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C484635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630211; cv=none; b=MrsrnvuR3vfAPnwTJOLNO+2XfzrbTxiBWbog03Cp4bI/g/xx3YKzhYpcycVBxUq4jsy4zSySk/6Skvv5yTWds97mJgBySa7cfEo7rnYVy7VA1kCXjSsL2pCq+c4nQxgVGFjWK/U8FT+L/ToLRApF8YncKkfO9A1rVAlyr+iKkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630211; c=relaxed/simple;
	bh=cUYKvKXx3YacZEKlsfNYw4eUSZHyuCNL6LqQD01H25g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkPXzkIy8ZnMBiZaJ+nfiQjx5F005J6Du/D5zUMSJPmODw9bwHG/3bEGgcUdEndsKhkmlB635OaIpF5m6l8l+9BBMV+wrQ4sZUzzCKvME62d4Dn/cdLV9pF3UWGdAKPpDVjsLEN9SaBSlDWkF+/0EnZypiC5Pq2FPbpQrxBwzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQFqUwA3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad784e304so18901201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630208; x=1729235008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUYKvKXx3YacZEKlsfNYw4eUSZHyuCNL6LqQD01H25g=;
        b=FQFqUwA34iNrCv9+khaqvOZzGT+ODv2idH2ymcqqq4bwDEIVIdVVY4O0bXOuYtc87t
         wtxoG42/arOMDupfqoxw6kRbNIvfqaPI3sjWfzpdFo0gycRx825DsoN2jwWeDtPZaalO
         YuZamQ/t+Fu3iS3UbLuX/EQhahtdYU08JCdvnixthqXM/ouEYsRndqrmP8JvDQExrwcU
         EL1bh6jLiybHAW3Br69yT6ILJL3PTbmmwWQGqXfXiM0Ze+g3nbroqd6nYZqtGhV4u1F/
         7DsFgM4wrjjZ2CGEZgzoQAMiHPvRypID2ApO3t/nb2Ca3BACMG6M+ilD8QwGNNX340d5
         FFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630208; x=1729235008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUYKvKXx3YacZEKlsfNYw4eUSZHyuCNL6LqQD01H25g=;
        b=LiDaxAA6Uhq5cIzmE9bGbx9jlLZ+ft+AloXWz16mDBH398iR26uNP9Go51r7EfhArw
         Iue9FThn1XJEKq+XxXVNR2Tua/gr1UOhoHU5KmewzUKAret3gnIUPlFxmP/F9twlG6oA
         KULPJYFIEGaQgjcSE+R98GBrBl9qIiZCJI46LrRLbMvhppZDri43uGVljdpccmWVJVjn
         aoFsBQXwAzKspoIs5iwYaN9NgonrNX3uZbVWMIdbsRqjtjIxK4GkwsyzkEs4mDF82TGx
         GEiQu3MlkiYjW5wFeZ2uwol2abOFH29dvdU9lyS5tI0bynSB5yeKXt6na+lFRFgnus/y
         VUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzkzSvymDwGV5vt/NiEWhq6UpOVUQ/0N93bQO/qjk0HwueANftXw4STqSgchUEg3jhtDp1IIQC1iRCcW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfwz9QUOeFyuMBYyjrUtI44COSq/m8Yse1z0gtts0e6H5TU9s
	7493ssoY5bI2oaThGf6jb8VSChROFM9VvqqxGd6D+WM28MwQJs6A7edfWZ7tQvSkjeT3XwoISWK
	VqO+3Ka9JHCraWrs3hPF0IprHiOYq2Y91gIxn2w==
X-Google-Smtp-Source: AGHT+IEMLmWgU40XaEz7cg2fJjnrrvSFsX+Ixe67yUNnaZpe60YgcllCtweYxA726xWakmCHrvQLlc71P3K6O6pyHVY=
X-Received: by 2002:a2e:4e11:0:b0:2fa:d4c1:3b71 with SMTP id
 38308e7fff4ca-2fb3272a9a1mr5139231fa.19.1728630207670; Fri, 11 Oct 2024
 00:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011020819.1254157-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20241011020819.1254157-1-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 09:03:16 +0200
Message-ID: <CACRpkdZR0UxF69rcuSpcfYR69FC-rGOakeOiUUbzJH6BWGVh=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: Adjust power and gamma to
 optimize brightness
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, dianders@chromium.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:08=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> The current panel brightness is only 360 nit. Adjust the power and gamma =
to
> optimize the panel brightness. The brightness after adjustment is 390 nit=
.
>
> Fixes: 3179338750d8 ("drm/panel: Support for IVO t109nw41 MIPI-DSI panel"=
)
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If you look in panel-samsung-s6e63m0.c you can see how that driver actually
uses a set of gamma+power (ACL) settings to regulate the "backlight",
i.e. the brightness of the OLED display. You might want to implement
something similar in your driver to actually provide the user with a
brightness setting.

It's a bit unfortunate that this is for historical reasons called "backligh=
t"
but the usecase is definitely the same.

Yours,
Linus Walleij

