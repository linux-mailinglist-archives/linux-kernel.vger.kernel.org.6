Return-Path: <linux-kernel+bounces-240635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16903927031
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9233A1F24EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B021A08A9;
	Thu,  4 Jul 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWu8LL6F"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AE13E024
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076688; cv=none; b=rvWJvZYYbQjMnRxWbhvsew4/4HQJM0iNQz5+sGdKh0JtTj3CFmCDnCZm08ttClbfzYv3QRaYOvGh2/x/Y86T/xFFoNPQLRhx45DEQh38Ls1f1tN+oYmM3D5D2m+2N3EHyguO9giqB34hoviv5ZAXV3wQQu+m7NRwy72coX/7ZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076688; c=relaxed/simple;
	bh=+I0YFt2S31oYkUolijfK0ro39JsAf/yoRmVvlou8NbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp0r97A5HKEmyqGGPlFhGO9dWzR0Nu92ACaLlZ8Oj/B+CfWUCUkUFrZijoZVj5U+i99h42m50XeFW+usl1yChdVVu0ggoe2nbzLFvxMjJZGqfVjDGXhjt0+2bcQPyJv6XzC78OWI+xoducslzK8VCCao8BQT9778lTfQmulZm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bWu8LL6F; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so3037921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720076685; x=1720681485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I0YFt2S31oYkUolijfK0ro39JsAf/yoRmVvlou8NbA=;
        b=bWu8LL6F1mRE3AZvMseBAuVePhXXeiIWF6T1xhKDYfLCFMr200691YBi89cvmSypdv
         btgRfLvWdTgMqNQeK8nx6zlCv2JKJpxFNvjAOVoMAdodYstdBeumsTA+J5k7Sqt8HFws
         omuMrRfwcsTE9ieLwCOxXo6ek5ImqUKm+a4RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076685; x=1720681485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I0YFt2S31oYkUolijfK0ro39JsAf/yoRmVvlou8NbA=;
        b=K3rYwfuJ/qhNPnHJzUOFP/IP4WP//mkaS6Ey12JGgd74JB7fg17IYhGVgWrmmaUasg
         fcp5qxaGLDlQ6dJqkFEpLgP1OSb7sXP6cyi6LT8SbDhB7HI1xjr52DNsMF6dCfx1LvOC
         xkySUSrfo+akNF8Zg8tBu0an7kwA1W9ObPb41VyZ5jNiHBt9V0xj6avzTkUqFIANPdhU
         x3V2mrBkqGiTV9WWFRZLPqNEIGb4NruXsph+zQVWhth28t5eaoJ8b2nCbL1K24uabU7/
         LgVvoupxO4Jx6pVntv/54EIN55ouKC1lV4GQyn8HplmSb50z6D3iZyOwPC1vZcu7wVHH
         mo/g==
X-Forwarded-Encrypted: i=1; AJvYcCXkcHVv8ADdGxEQ21NI4Wq/LGllAjfxiDfV43dssS9MPNut7IgJSzwKwFUDfUSMCCSNbfCfSVlkiYvf8Ktf+wi6iU5KZiVZ1jn0XboZ
X-Gm-Message-State: AOJu0YzHYklUgDELTuEzwB9zd6BUyKMmFY+8xZaCZUgVaAQig0ldGF9T
	xpMUxzLV3abbTX+orcvoUJqO/cnd8v4fjm1DAtocQirrXrFXCVclUX6Hh8yErpWjhwcVR4hdWil
	61TRoQolD3dO8GiKvU3SUF0kPKUZP+64eoa7E
X-Google-Smtp-Source: AGHT+IFA8Zpb5aVn/nJmjDl78Fqz8vpLDKvtcaia4i1+n5h5N+xv8zrHzcTB09mYhepYidg32nJsuqBn0nmYhW5KqtY=
X-Received: by 2002:ac2:5a5c:0:b0:52c:eeb0:8208 with SMTP id
 2adb3069b0e04-52ea06ef484mr375340e87.66.1720076684489; Thu, 04 Jul 2024
 00:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627071904.4017160-1-wenst@chromium.org> <20240628123140.5872fc6f@booty>
In-Reply-To: <20240628123140.5872fc6f@booty>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 4 Jul 2024 15:04:33 +0800
Message-ID: <CAGXv+5FZtRb2R_OSwQQAUESM4p-UszXGWaDf8GW7+cHcZ7CuNQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mipi-dsi: Add OF notifier handler
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:31=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Chen-Yu,
>
> +Rob
>
> On Thu, 27 Jun 2024 15:19:03 +0800
> Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> > Add OF notifier handler needed for creating/destroying MIPI DSI devices
> > according to dynamic runtime changes in the DT live tree. This code is
> > enabled when CONFIG_OF_DYNAMIC is selected.
> >
> > This is based on existing code for I2C and SPI subsystems.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks for copying me on this patch. Could be useful for my
> hotplug-bridge work, however I'm aiming at writing code that works also
> for non-DSI so we'll see. The code looks pretty fine however.
>
> My concern however is about the usage of an OF reconfig notifier. A few
> days ago Rob Herring wrote:
>
> > a notifier is never a great design so
> > maybe we can come up with something better
>
> (https://lore.kernel.org/all/CAL_Jsq+=3DmGEJXsjq1UZFMJtHko_z+doiFMXnx9K7e=
xDuznymSA@mail.gmail.com)
>
> So maybe this is something you can clarify with him.

Well, as mentioned in the commit message, this is based on existing code
found in the I2C and SPI cores. In these cases it is dealing with the
status flipping from disabled to okay, which then triggers the subsystem
to register a new device for the toggled device node.

If a better mechanism can be developed, then the existing code along with
the code I introduce here can be migrated over.

ChenYu

> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

