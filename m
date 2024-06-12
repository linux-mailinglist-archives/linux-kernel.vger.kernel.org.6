Return-Path: <linux-kernel+bounces-211524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD487905313
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601B11F2170E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A46176ACD;
	Wed, 12 Jun 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj1yywSl"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198116FF4B;
	Wed, 12 Jun 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197070; cv=none; b=OAlj3g/6FVNnIF4f/btaagGtBwPx01J8twEDY2fmnFX1piyjMHrRpJQlkpAVPuMh1QWS0M7y4d5tVBzJ9ccMhQB3Yax2cU9al6hLbaAeZFhb+XBCBjEZcZVN8KzeZyBmxPIa4I+pUonNcvfCQ90R5J0vKFOxF0peO/58bYaShX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197070; c=relaxed/simple;
	bh=jHJQCaQVIy+PX6til3PhpW1AFi3YRxN9aLTguRX8Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnN6+Ze26yZKgM4HuK1uF3YeHdIuKGixl5+1Z4376rD+hg355q+Cxwyyw19B6nSugxcddZ23Q7Nyv6tmD23KbDofWlTn7WfeA/CohtC+DxnsXLbKzMBX3zEeM7+Ry2BO9fae2L3zV96kJfqAbMSFeEciUlK4Xw9Z3s8zaLQdfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj1yywSl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4405cf0cb1eso11674001cf.1;
        Wed, 12 Jun 2024 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197068; x=1718801868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB+PMr0S7scrngc2VZSdORJslKMc7ShMF5tnKYvV/ic=;
        b=Oj1yywSlZubjlzZ7UfgN52j++S6CGdWqs/IBOBL3JHKxfqv/J8hZIzZcIM8LExMeiF
         83zLv9IHC8QuEqIS9vetPr7cW6rKOEbyCdInWCBeEZe8yai24O7tYBJxhlzSRkkJgPjg
         J+T0Dwy9NJvoPL391fM3nN+ougqOSiY9on/cvbZwUJPAzNdui45SPB0p0bueqXHD/4yf
         ArGV5rw0aeF7xveE5s9Z452UKd7QFYKKZ4ozK1u7xVitSpQ/LG2gwJZuOJBzLYAcQeCp
         Mc6Mhlg9WqQHL8smQDQrg+4QcdUSyO4Ny9qnUMtZI1qE2RIAKM3nkOsYqVgEdP6paoaK
         sfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197068; x=1718801868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB+PMr0S7scrngc2VZSdORJslKMc7ShMF5tnKYvV/ic=;
        b=f9DKWKgVGRA45+K3hzYP9d+Bf+6SIc9F6Yiue7m2oU0seFj+OM1F1NAQ/zA7wUuTf3
         VWRpR0gw3971+CxS0TQQwXFsvYQeJQDb/TU3OwJ8QQlTBRdHbuQuSkWEtNQNMRKFUFKt
         KsnW+7FpXHOvfKe/Phn0lyQS2LE0F5Xnjy4reS3vgMt/GLWygdlsr9W3yw6kLhCNlEuv
         cgwcH5Z3YpaI6IWn/GW2qPoNioEJ838wZRcNVS8hTB7gPCocbMvjI7ir+R3vl6/wpod/
         YwGvH7+l9ddxrvLkj9+Gyohkw2S8S726PlZVa0MgQgnQ8yPEbbk1hwD/mnhBKG6ib5+K
         31FA==
X-Forwarded-Encrypted: i=1; AJvYcCX/FcuO+M+PgaQkyOgS27gd93qzwVnqkPCkFGjokptaZrqquGFmvLR/IImPoHJA0rUfkaFAH446lSr94KybGZ0F+8T/ap7OQf9RmqB31UslBqXNYoimqp2aiOwkixKsglPUeoXnFvynrQ==
X-Gm-Message-State: AOJu0YxPDWvQox5ltP7g1iwE2mAf0WsnXcDYKCYJ9usxU0A88JK8caM1
	X5wXT2R2qUipT2YBJ51YJL982F52mCvwYoBd1JSQITvQchU12dAmn6AOXnxbEMzt98mFO+lN1aT
	SOmt/y0ntpes+U/Hm+ghw2x9yXKQ=
X-Google-Smtp-Source: AGHT+IGBdjfgKQlOZpfKaHfJn/nzVYYtFBGLJ+YL9qo350RsZMZ0FClzxSPhm0lYF1lTq3MVhQrLCzuCFslcRCzNMYI=
X-Received: by 2002:ac8:5981:0:b0:43f:f361:1b17 with SMTP id
 d75a77b69052e-4415ac612ebmr28240521cf.56.1718197067797; Wed, 12 Jun 2024
 05:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612111623.102868-1-krzysztof.kozlowski@linaro.org> <b1f14e92-4491-45f5-90ca-cc3d5ceea81f@app.fastmail.com>
In-Reply-To: <b1f14e92-4491-45f5-90ca-cc3d5ceea81f@app.fastmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 12 Jun 2024 16:57:36 +0400
Message-ID: <CABjd4YxxmNqDXe7SSzTpr4gsf4-Rp4sgB8x2sYSGzDDx5CWo2A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ARM: vt8500: add Krzysztof Kozlowski as maintainer
To: Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arm <arm@kernel.org>, soc@kernel.org, 
	Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Krzystof,

On Wed, Jun 12, 2024 at 3:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 12, 2024, at 13:16, Krzysztof Kozlowski wrote:
> > The ARM VIA/WonderMedia VT8500 platform became orphaned in
> > commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
> > and clearly it is on the way out of the kernel.  However few folks send
> > patches to it and it is nice to actually take them, till the platform i=
s
> > in the kernel.
> >
> > I do not plan to actively support/maintain ARM VT8500 but I can take od=
d
> > fixes now and then.
> >
> > Extend the maintainer entry to cover also VT8500 DTS.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Cc: Alexey Charkov
>
> Thanks for stepping up. A few years ago, Alexey also had
> some interest in this platform and knew some other remaining
> users.

Indeed, I'm still interested in getting it up and running, and even
got my good old WM8950-based APC Rock board out of storage for it
recently. I also have a WM8880-based laptop and another WM8850-based
one at hand, but need to bring them up to speed. Should also have a
number of older WM8750, WM8650 and VT8500 (but not WM8505) devices
somewhere deeper in storage.

I haven't touched the related code in a while, but as the original
author of VT8500 and WM8505 support code from over a decade back I'd
love to keep it all alive and functional, including reviewing and
testing stuff as well as (hopefully) adding extra functionality that's
been on my backlog for years. Does that count as support/maintain?
Happy to be listed in maintainers and be in the loop if I qualify.

Best regards,
Alexey

