Return-Path: <linux-kernel+bounces-385638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867CC9B39C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149D2B22443
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48B1DF98C;
	Mon, 28 Oct 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hu2hXqir"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61E1DF728
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141704; cv=none; b=F0EIzf/E9MEJU51uT4DOUC2c0Rf5+y1ShJjZpUQNsI9bsU8v0YxNuWmOSeNKBBd7yaoIq/VKfl469cvssA46ugJ32x1HUGuIucxvT8pGFf2fPofafBklsmrfhLWE2aAumDkyTYWSzqYrdBYVYwJLVLDtcDXbWf2XAV6j1Cfn0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141704; c=relaxed/simple;
	bh=Zx531aRlqgZ/J6pjpKLchF/je8KckqLVRPg0b2OUlzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keAByCQOTkiFITUXFOCZf3pEyWZNfVI1W745w+oo6QI1JGfT6/V+kOyJ7YX+PaUfDT7UqTRimQJS8xO+zralL9Uek2P6AWgs92Uv0JReC8ixfenraw7aoOY1upQRVWXN9yB6KcO2bDLHs5vcV8qv+oWfw+x82YmPNnCIRLyDOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hu2hXqir; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fc968b3545so45105141fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730141700; x=1730746500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPm2vEW8xTYHQPK8zA4XdYIjeKKSO98gok6NxNxwW8I=;
        b=hu2hXqirMuU93sUFVhpL2JCCxLme4F/XFssGdGffAApKWhchUTlaDTbfSBca9cHpiO
         OQ3OShyZAeKjxR/mJy3Oguyt5vC+Ltoz51WFx4T0mrbvGKjC52xlHgygQWpFGmuaDVb5
         U6FA6Dqp1EBiiQTmyJZT0cqzzkMSJKzpVi1h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141700; x=1730746500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPm2vEW8xTYHQPK8zA4XdYIjeKKSO98gok6NxNxwW8I=;
        b=b6AavIJUJTsWBo5ojouNhT/QNVKWZr0TBVa0Yxlrx5FmUI5GZ1aXSGwbb9MwpYw9Yv
         eMtPdlN5qKJBEziE9n1uBQII/dHisc3QyKLGrpiQOCwpZFJ8nBgbQiSBX5WofcyY687D
         GdsGCRlWLiU/83qa/X/GhN4tK3YZ1tLG1l/knJ5HJPMifK5icOwHH7UNAjoLzzxA9YfM
         2f4usFO8CAyoFnGcp0gwnowcn22kd8y+wGe2ZPX4x0p4ip0JeYZDFQ78Xvj4PzrKPNDd
         Q0k0fsy/hmJlJuDCHwirrXqWBSeGUzQ/9p8TsBHcgxZAbVQVO+TxX9eMLWwqHNq6CZXY
         LZlA==
X-Forwarded-Encrypted: i=1; AJvYcCUEY4DjzWCnolxoFNzVBF7j/H6cOvaOSLzqduA3je7UEdSRmVCmyKMw4m4kDIDbFPz/j7Hn8bSD3d5ZrXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0gfRI6yqXuLpYudShG1N3z73Ph+Yq4n6L0f0PhTg2ca4GbxD
	7J6AACg+6GdlXz4H6jHUYUSUT4DE7sFiHybF/fKTqfEi5uHBghA2KAbh45ktqjNLEZ3Om222dLP
	iAA==
X-Google-Smtp-Source: AGHT+IGkFzp5qZmelX2fZizYJV9LciKyeiKwRAhf3mhghdAwxZNVGfuZCDPJCoGwYkaRXjerozCaqQ==
X-Received: by 2002:a2e:4619:0:b0:2fb:59ec:4a32 with SMTP id 38308e7fff4ca-2fcbdff75a5mr33213181fa.25.1730141700057;
        Mon, 28 Oct 2024 11:55:00 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451caa2sm12202301fa.36.2024.10.28.11.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:54:59 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso43115771fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:54:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBhxQhZ/K9x2r2jDWa1qWuJcJ9Y/U+lXr2AMK2Oo5ylVWAX/0UqewiXTyyRVjDt0KR/gOJW53P/bsMRJs=@vger.kernel.org
X-Received: by 2002:a05:651c:150a:b0:2fb:4abb:7001 with SMTP id
 38308e7fff4ca-2fcbdf61dc4mr37792351fa.2.1730141698498; Mon, 28 Oct 2024
 11:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
In-Reply-To: <20241026035928.183454-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:54:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
Message-ID: <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 25, 2024 at 9:00=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> @@ -418,79 +398,42 @@ static const struct ltk050h3146w_desc ltk050h3146w_=
data =3D {
>                 MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
>  };
>
> -static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int pag=
e)
> +static void ltk050h3146w_a2_select_page(struct mipi_dsi_multi_context *d=
si_ctx, int page)
>  {
> -       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> -       u8 d[3] =3D { 0x98, 0x81, page };
> +       u8 d[4] =3D { 0xff, 0x98, 0x81, page };
>
> -       return mipi_dsi_dcs_write(dsi, 0xff, d, ARRAY_SIZE(d));
> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, d, ARRAY_SIZE(d));

FWIW: the above might be slightly better as:

mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x98, 0x81, page);

That would make it more documenting that the 0xff is the "cmd", has
fewer lines of code, and also gets the array marked as "static const"
which might make the compiler slightly more efficient. ;-)

Not really a huge deal, though.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

