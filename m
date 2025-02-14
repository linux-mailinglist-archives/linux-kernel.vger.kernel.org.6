Return-Path: <linux-kernel+bounces-515300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3FA3630D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DCC18969A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DF14D28C;
	Fri, 14 Feb 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6rE+ieh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DD267703
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550382; cv=none; b=mLK8TrHgQj6u8nfCzTxX/Npqdw36R4Kf/b7acFid8ncOQgGMb+NXtq+Tl8kN2/ilruKgb+6RPAorFbIqOMSX5o/7JWFWWEI4H+92IV/hTWu5rgahAvSTghWtXRlisnXHbp2qGENhh9+samAZWiAWUYZXSc/8GvV/jKoUcIbPROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550382; c=relaxed/simple;
	bh=RdevOzly6prF9MIZ2eWFLCR3amtfHr8cOSz/Kq6PTf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIwHqzJUI9/9Fic3xhct+mTWF/tM3fij7DaylkctcB42DY7GbFU6YKZCDuYMQzqxobZIl3R2E/PCXFILvfDIkNpyTg5m+7FZ1U8LXDnmXTO30XeY9Ef0nqq0QQsnEQkCsU2X7pmiM2Y1tJbUqN9cyR90jBEEZvF6AnWR6TesC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M6rE+ieh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54504bf07cdso2215408e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739550376; x=1740155176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRwOfh6tgHaZL3+E0zLATKEm7zWEPnAJi4nv5EHJNOA=;
        b=M6rE+iehW35zgIn79hV+5pWMqAfi4H1+yzaysEw1kLordizBalX8ObmWRHoFusehHS
         vUNti38QPXcaOLPZVAYQYBGgr/j/OP0eNWevjitkz7dV0yiDBRUk428OHj+KQ9VFymIV
         S1W6QDITiEe/asJwr852+819z7fQWnT3X/sn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550376; x=1740155176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRwOfh6tgHaZL3+E0zLATKEm7zWEPnAJi4nv5EHJNOA=;
        b=S6k0i38PKkAu85SKBsVkzWtfmn76y29asDQw5NoJdMdb+gtkXjBK9130Z5rDOfiY6B
         8kF+FyR9Vdy9x9nEiqhtdCe6mcDHRFGH1AJSV9FGJDGo7Ia5W+Uv2kjh/25GZDkOztKz
         fXXfjJslBXzmhaNOJ0XEjxj5zvjUZuN/PhNRjVp2XdfUPYARH5l+deHnKoD8jGM/MUFx
         4TcHfkmCGPDN/J9InxC0dcSohKUJmyJNMnlAdhyOe5YBoW7iw5SRGYNs8fohYeHorPXt
         oKxJebgE+xipgrBeOFro66lHVU5J1ukvUwNNBLviya1ntf4dibjuYpvWi617ur7m0GbY
         XDRA==
X-Forwarded-Encrypted: i=1; AJvYcCWFWW2bV0CciUn3PqZkx7c6J4PvJx6koq8yykY6T9oQL2MjzzPN7fNk6UbvJJZhmPJ3juA78djvLzEq3qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiY9KTtv7rTbBUhRKalT9MvvGvxSDTs+1moFVrgE3y/O6pXEhk
	bST/cs0erSvKV6G5iggz9hAXjX8EEQbyvWo278PptyEh96ovyO9mHJaIF7M38qRBRv1s1Uvlijs
	cQA==
X-Gm-Gg: ASbGncvJD/soOmqWZHYDBtnPyzqDTeZppZTielHFaxVbT6tuzg6JuWLuqN5dGu7v47e
	maQB6VUAo5zIr2HxkgqOr1UN1eiWAjUxcerAXBDsmb3zWkdGgtdn7x1qZZKe8uMyjPACrS1EEQO
	GTHva+WIDwi4VWUfwFiHUe6Km7zWH4HsNrzxoYwnjM27kNrnLzl69rJiRyBRozRRrvP4CRq8V0q
	q1ha72CxOr1zrZ7AmvOESpO3IC3iirpozb1hhhGCH2/46u68RltRt8Qq9QRPQH3hh0ZhkDtulWm
	qn8cUepE69DScz9F2qWqn4C97+cDfpBS5E3oKKTeFP/3Oj2xMGb2uXKV9BM=
X-Google-Smtp-Source: AGHT+IHnbuaFl3Z1WWBuDHy0eut1LMjjEf/Xlu2p6r1j7ljVW5LtWe3hgwIx35/lIe/m52cZXMDsug==
X-Received: by 2002:a05:6512:234c:b0:545:a1a:5576 with SMTP id 2adb3069b0e04-545181094c8mr3509269e87.22.1739550376073;
        Fri, 14 Feb 2025 08:26:16 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cc28sm572303e87.201.2025.02.14.08.26.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:26:14 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308ee953553so23392481fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVItRPG7hoHD/efEltPUU0VVl8laNDpdQ8m+2lDrDEaItlWkThxY+65wFECorkwXBgABxsiMtQfBuV2W1w=@vger.kernel.org
X-Received: by 2002:a2e:a163:0:b0:2ff:a89b:4210 with SMTP id
 38308e7fff4ca-30927a2e355mr545351fa.8.1739550374272; Fri, 14 Feb 2025
 08:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
In-Reply-To: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 08:26:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>
X-Gm-Features: AWEUYZl2UQnH588l_o4dR5jYVzX-zOJ9t0dVCpEUG6Ly_Dd5CIEQRbUnuFK0DTE
Message-ID: <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
	Javier Martinez Canillas <javierm@redhat.com>, Jianhua Lu <lujianhua000@gmail.com>, 
	Robert Chiras <robert.chiras@nxp.com>, Artur Weber <aweber.kernel@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 12:44=E2=80=AFPM Anusha Srivatsa <asrivats@redhat.c=
om> wrote:
>
> A lot of mipi API are deprecated and have a _multi() variant
> which is the preferred way forward. This covers  TODO in the
> gpu Documentation:[1]
>
> An incomplete effort was made in the previous version
> to address this[2]. It removed on the mipi_dsi_dcs_write_seq()
> and mipi_dsi_generic_write_seq_multi() with the respective
> replacemts and not the rest of the API.

You didn't seem to take most of the suggestions I gave in response to
your v1 [3]. Specifically:

a) I asked that you CC Tejas. I've added him again.

b) I asked that you CC me on the whole patch series, which you didn't
do. I can find them, but I'd find it convenient in this case for them
to be in my Inbox.

The first patch conflicts with what Tejas already landed in
drm-misc-next. See commit 8025f23728e9 ("drm/panel:
xinpeng-xpp055c272: transition to mipi_dsi wrapped functions"). The
second patch _also_ conflicts with what Tejas already landed. See
commit f4dd4cb79f9e ("drm/panel: visionox-r66451: transition to
mipi_dsi wrapped functions"). Later patches also also conflict. See
commit 0d6c9edf9e5b ("drm/panel: ebbg-ft8719: transition to mipi_dsi
wrapped functions"), commit ce8c69ec90ca ("drm/panel:
samsung-s6e88a0-ams452ef01: transition to mipi_dsi wrapped
functions"), and commit 7e3bf00047cd ("drm/panel: sharp-ls060t1sx01:
transition to mipi_dsi wrapped functions"). Maybe you should sync up
with drm-misc-next before submitting.

I also questioned whether this really made sense to try to do with a
Coccinelle script and I still don't think so. It looks like Dmitry has
already reviewed the first few of your patches and has repeated my
advice. If you want to help with the effort of addressing this TODO
item then that's great, but I'll stop reviewing (and start silently
deleting) any future submissions of yours that say that they're done
entirely with a Coccinelle script unless you address this point and
convince me that your Coccinelle script is really smart enough to
handle all the corner cases. I'll also assert that you should review
Tejas's submissions to see how these conversions are expected to go.

[3] https://lore.kernel.org/r/CAD=3DFV=3DWkPefg00R_TAQQA6waRqGdD+3e84JXfPLk=
2i9BRzW6Yg@mail.gmail.com

