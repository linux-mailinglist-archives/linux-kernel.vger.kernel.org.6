Return-Path: <linux-kernel+bounces-276899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1F9499D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B4F1C2159B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72FF158DDC;
	Tue,  6 Aug 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JqK12Lit"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7B155C97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978219; cv=none; b=GP/URI0kjJ4z2iyQWO3WOuScXo3IpXfCNkvM918C6OhA98cb1ZRkjid+ejSO0Z1u3Ulnb0ZLYOS7e2aL8ZLOTZYlo9envBcis9eEjOSSBBrkLKhtyn8O9xw4Ji9yqjmlP+s0DZKQBnF3buAD9LZkKQEHEZCjLY/legXUYqYamGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978219; c=relaxed/simple;
	bh=EHk3CnvYYburzyUAKn/KN9qtx2QqkPwRCt9DSb+MDFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvBinAjkxJULj3T5Lr2GEQ01I3BWVTzE0FTWd3PQfr0//devyUi7TcR7goE6h9NTFeGhK3usaTXzNxg++NHb3BWgox3a/t2xyqEy23pq9a2wRl1C2fDlMm0l7vdxyvmxt6vW885j6RezfgOuhPZbC9oU0qvAmci9dx9zaAIf7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JqK12Lit; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd69e44596so1976745ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722978217; x=1723583017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2q6pHf2d+29PL7ARSSmco2Uda2QTne6ymuc4cRUvxc=;
        b=JqK12LitqmD2ibirZAalRx9pOWoD3MxMw0dI9EiGmyXbdVi71PETsF0lfB6HoJZFR1
         /9SlUZO/cP/9GmstKe8Rj/C0nHC58a7EhwDrqryC1BWZNhkRhFe3P8nPekkZpe01mWDB
         vYHzr/PAj0YIEe8OldMroJAjvzprlO+Ge7Xk4NzarnX38OD3LPbJoamRgvGcnuc8rA8q
         0M27IutPRu2bVfq75IEw6nm5T7QCgGXnfeumHS1yjM/ua9Yo4+CmDxoAZifSYBmX8m9P
         Rzc4J5rjhDG01znCc0t09L8PpgAWD56F1H+gAR2WmfurzcyoA5rnwwL7HjqWusv2YQrS
         b48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722978217; x=1723583017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2q6pHf2d+29PL7ARSSmco2Uda2QTne6ymuc4cRUvxc=;
        b=WNXRT12DAG64wwoMmbsEchtklid3TP49GUym3A1GjmrUo90Fwf+YCAYBYGyiW+E012
         L0dHuvV5BRBJ60+okmqs2Udkw9IgkZ6dvzPvf96g+kBkGvH9vyXwMepS5/UUupcTg4ia
         /yDVE2HjmcQB8QtWWBv2V4dM6Jj1jh8fV4YFzSbo3I+UaOy+Qdd00li3NYK/wLR/i8E5
         6r8ukQuXA87BmlyC4m+dxVrjMQ3sDHFB/xbNktEysLIL8YCCFGnNasoU0UBVn/PAKn44
         iGyHxtMVFJayBX3AcGHjM+MyyveotTWJG4TvBHIpeEQB+OyCKR4G7J1lfxW7mN1t5fK6
         WKRg==
X-Forwarded-Encrypted: i=1; AJvYcCX6HM+TO0THMfZd482nNxi86Y1l0WeNZCBAH+ovWZ5YcjXJZ1EFjHG6rRYJdzOe7lFXBs7gqI1fIBV6QDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4X8dO2qa/KcrCZJ07ZBh51iZZ2GH2NKXeb4uQeHMUaZ/GnatO
	BvpFZQ0c72XG9pX6YcXWogs+kHDpXwf/BadshloODkLgHTNWV4EbN35LC1d03ztDNaia/Him3NS
	c5cQc5iC7HrDQI0lkYnbau0kWfpk=
X-Google-Smtp-Source: AGHT+IHnTsomZEJTNgTr0RHgWmTYrb/mu0Mk5eZcXXey+C/tHk5gZ8CXDzozzaLkZe8gUGsqKmfnGvzIxRoRWUKUOxg=
X-Received: by 2002:a17:902:f64f:b0:1fb:7654:4a40 with SMTP id
 d9443c01a7336-20085492a0cmr824815ad.14.1722978217049; Tue, 06 Aug 2024
 14:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125023.710237-1-jbrunet@baylibre.com> <20240730125023.710237-8-jbrunet@baylibre.com>
In-Reply-To: <20240730125023.710237-8-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 6 Aug 2024 23:03:25 +0200
Message-ID: <CAFBinCAaZumGU6dOq0RrHRTQV=MejTJ=RW0P_6tQFOG9vybY6g@mail.gmail.com>
Subject: Re: [PATCH 7/9] drm/meson: dw-hdmi: use matched data
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
[...]
> +       }, {
> +               .limit =3D 297000,
> +               .regs =3D gxbb_3g_regs,
> +               .reg_num =3D ARRAY_SIZE(gxbb_3g_regs)
Just as a side-note: this looked odd when reading for the first time
as I thought that it's a typo (and it should be gxbb_2g97_regs - but
that name is not used).

[...]
> +static const struct meson_dw_hdmi_speed gxl_speeds[] =3D {
> +       {
> +               .limit =3D 371250,
> +               .regs =3D gxl_3g7_regs,
> +               .reg_num =3D ARRAY_SIZE(gxl_3g7_regs)
> +       }, {
> +               .limit =3D 297000,
> +               .regs =3D gxl_3g_regs,
> +               .reg_num =3D ARRAY_SIZE(gxl_3g_regs)
> +       }, {
> +               .limit =3D 148500,
> +               .regs =3D gxl_def_regs,
> +               .reg_num =3D ARRAY_SIZE(gxl_def_regs)
this is not consistent with what we have above or below so it either
needs to be updated or a comment.
I think this should be called gxl_1g48_regs

> +       }, {
> +               .regs =3D gxl_270m_regs,
> +               .reg_num =3D ARRAY_SIZE(gxl_270m_regs)
and this should be called gxl_def_regs



Best regards,
Martin

