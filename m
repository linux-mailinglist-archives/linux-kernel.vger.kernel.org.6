Return-Path: <linux-kernel+bounces-297785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD795BDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB5A1C22801
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F161C9DFF;
	Thu, 22 Aug 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="An7c6knU"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D838F9A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348890; cv=none; b=Vxr+3zHRrtnNILUfDyaxBdhEctB+lvVP6j2PmA4eyOSGTZn656/fck1tJkY2EDqgTc0lU54uG9+9XEo6ydXUGsQcFj0/XvyukosXEuiJpZVwGf7a3Ob+usaOY86ZOqtf3mxYYJMyh8RPhxfS+XMfimqXbn9xPWppzoWhBFxftZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348890; c=relaxed/simple;
	bh=oomnAfwkIIwMwMnJdWOjdg3zgHFTrar5w2PFkUayNGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDauPLQHr9l+/uCKGtoB8oBgv8COoWFk38HcH8u/XrDaFqSaWZjb2Wm+iXSl2ksFe9pUMuKSkZsAed+/fI/0a93kRHwunISH/g6brKSx620M05ZNDPWLKb1IuyL5+pzRQ6mJUxczgbN4I5IC00I8eLJ8+w7A6Keb1bZGyi45jRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=An7c6knU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a4df9dc840so66289985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724348887; x=1724953687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6QLFS/223EGiUxs5tjmNPrl8Nvfi/fSGuus5YjHYKc=;
        b=An7c6knUzYCUmwsBiGBkSgabxH8MvL7t42S3vND9s1BdjY7KQ+OzjJa+eWsGoQppG1
         tOdgJMpjd2H3vbkX6mQ5noL7fy6fvgfsXVq4ayh3Tk3KRmAvfPVchiLjvD871RQJJiu3
         mqZD05QYVGBaLRlPMLnRXY/OOEhZg9Nm3+keNognLsgFO/HcDgEH5/nFcYHy6P1PhWxi
         4HVRjkOBXPYIuvX9IcU9Vp4trFtSCsRgzHemmSuHwxEV1PZbz3MwARgm4Q8fnvn6vw8o
         KRKmgMwkBbsqnEl43kcGhTvGmhr0iTx/bcZQvDMNMlvYncRXG6eCx3qKNsGkhGwRsQgU
         Cb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348887; x=1724953687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6QLFS/223EGiUxs5tjmNPrl8Nvfi/fSGuus5YjHYKc=;
        b=HYA8WUP+ONUw6gtsvgD97WozUP20PKBaE6zDAvq0ZjSS/MTz2Ee4joZJ3lAg15BJ+K
         rA74qhouE0vu9yWLs3uTsbwA+JTlGWApckJ6BBvNH+wCSl2xvkTcRzWDMezvZrsd1toL
         NctA35xM7uyLvlLBL/CyBaTifCDu0BMZzie7+98jWPDyp4ZJWcUsEe+vDAM+1uOvaW8n
         3t7zi/VVYHMRQxtlw34JXeejoNjPpOm3VxBbv9ABIhxyjNynxJc2waGinaHkgWalrD0p
         qDchHes/kw7bOn17yvUDS3r/EZCovGo3OXj8cyV9liTDprXpc99dgNNBkjZlBvLpsn00
         GgkA==
X-Forwarded-Encrypted: i=1; AJvYcCVHy5ycTKw+3Awb8DTRyqaWeAYuhknUUAIAIOxGE9pf2d7/WDdJnlT6kXaY0dWw9XPO5IKxR1HIqfJl8hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznalakCUdhxiVcpGBvlsMYVSmVL7617QMSrd73pFG5PpF6ZVPo
	PimyCPnHzTw+lAa6VdZjjHKMGbehU0z6KJG/7vx4zB6dLMpfyM5WDxA8AtKQj6XacIj/kcqPo6F
	TO06hycZkN7sTGzNrTjs28WKMDABVD5bfG2ZMPlJvpnB8Va69zQ==
X-Google-Smtp-Source: AGHT+IFGwUrobsK5fHxOpalWNdc1NoJwlmN9E5WaHLuT0VfpNOVU/eY0hrZCRXlucXyDgVbOqJoLAPunNzn8LMHOYzE=
X-Received: by 2002:a05:6214:5c02:b0:6b7:abe7:5665 with SMTP id
 6a1803df08f44-6c1567d96c5mr64521926d6.22.1724348887318; Thu, 22 Aug 2024
 10:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 22 Aug 2024 10:47:53 -0700
Message-ID: <CAD=FV=V8ivgWn5krEYzt5C4aiHMMK07mtMVwJaCeSQHG6ZscSg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add Add elan-ekth6a12nay on the basis of elan-ekth6915
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, jikos@kernel.org, 
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiri / Ben,

On Mon, Jul 22, 2024 at 12:31=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 300ms, so the
> post_gpio_reset_on_delay_ms is set to 300.
>
> The Elan-ekth6a12nay touch screen chip same as Elan-eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
>
> Changes between V4 and V3:
> - PATCH 1/2: Combine the 2 const into an enum.
> - PATCH 2/2: No changes.
> - Link to v3: https://lore.kernel.org/all/20240716082851.18173-1-lvzhaoxi=
ong@huaqin.corp-partner.google.com/
>
> Changes between V3 and V2:
> - PATCH 1/2: "ekth6915" isn't a fallback, modify it.
> - PATCH 2/2: No changes.
> - Link to v2: https://lore.kernel.org/all/20240715073159.25064-1-lvzhaoxi=
ong@huaqin.corp-partner.google.com/
>
> Changes between V2 and V1:
> - PATCH 1/2: Respin the series on top of v6.10.
> - PATCH 2/2: No changes.
> - Link to v1: https://lore.kernel.org/all/20240704085555.11204-1-lvzhaoxi=
ong@huaqin.corp-partner.google.com/
>
> Zhaoxiong Lv (2):
>   dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
>   HID: i2c-hid: elan: Add elan-ekth6a12nay timing
>
>  .../devicetree/bindings/input/elan,ekth6915.yaml          | 4 +++-
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

I think this series is ready for you to merge at your leisure. If
there's anything blocking it then please yell. Thanks! :-)

-Doug

