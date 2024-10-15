Return-Path: <linux-kernel+bounces-366208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B899F22F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0EB281E49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7381F4FBB;
	Tue, 15 Oct 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1lrf8Lf"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4B1DD0D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007940; cv=none; b=owKHpTHWcxsPCUTgf58eVhR8kWC5CZ83c20ZDFvzSPRUFhjD7eVNIskZTENPG7slsuMF3UBP2eHf1j/Mm8QCrbXQPM4llMAi5RfnSbBArjhGRSaRMwBPwzhXRbi0iZVhZ1zEhOGxvdFAyjoyjx188PkMU/Hy+lY3x2bVmlTtCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007940; c=relaxed/simple;
	bh=Ufoea8S6uikhI6YFc1QTKMiy+3BtUZ/7Cg2cwFKix3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLdXWnbseLoZ/DL7C0in/e02aZr8oCCZFwbRQnJwBbEs6UCR+NymoDSVYnUIfC5lMzumum0H9TlbmVY2kgemTE0oYWxX03AvcgkVOu2ZUokZ+DuC1NsO8UqhUos0kv3kFBmPFoESkORTrC//QpE2J29mSNJmopARcPAKjux71v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1lrf8Lf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so28312931fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729007935; x=1729612735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8q7MgnvGlQX6akYRxirKYZTLEprABkBbW76qdniZOI=;
        b=c1lrf8LfOXaMFknfH6JMdz53WBVb0IT4h5EGZVN31lY/ZdIvbXQ0cjeb1dgJKNhsUp
         1zgVKRvo9V35ckD2+9wHRBX4u1AyzeE7/VK3VF6z8LTBkk+3gyU6c1vhLZ44B//iWo6W
         Tk8ithjezGxU/e8nRSyTBGlhkidtLRDiL8PrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007935; x=1729612735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8q7MgnvGlQX6akYRxirKYZTLEprABkBbW76qdniZOI=;
        b=mui5cIz5ovIDHmcfERUBOjVE67zZRWjcvHiiXppBgtfOyKHmcGn0cjEUFGmCndsrZ9
         Qu0r69cnV+SX/roFY0K6k4O2/6zNDAkeM3rBwxlNzbPbLPTdtnnxhqBYQHDe8iYEsHOl
         bv71LhPQhLH/4+Z5SPKFZ+uP7nFGb/tt1Exv5y2zPY6CyU2/dMnlsWmzJg1ZG6uVjKcy
         t8bBdkAFyk9pSCM7mKM0riGCeZ74IuNGTOGGNRkhcvWQnYPx2bU5XfZytxahIz6WdBvT
         jjJ6YvyuaJj9ufPd8k7gEcwAVU1WicVHYUcKvq/XXX1x8UX8QefZ0GLYo89HYB3x/Qdh
         WVMA==
X-Forwarded-Encrypted: i=1; AJvYcCVaGd+lOeQLFYuxQ4pYhHcodCrTBn+T0hGhUyat5lRNNeLjwrKD8B3rKsAM8tU8+NRhaV1ebcMVO4rmjB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfxfALlmiIxCXkKGJ+Vs+nfKDS/KjFzVqhPfEeucEAUVzu29+
	76wgdTS6sn9W9/DNfIda28DIcjDNc5aHa9w4va7nEy41c9jifMRKJbhgcSANdlXIjAcKxaxudmT
	BMA==
X-Google-Smtp-Source: AGHT+IHlZpDyIbVZyzFbbHrwBzzLSko32Ml0SM5h4NqS67nL/nf6rmXRocpKWBv23TQzJLQ29rEujA==
X-Received: by 2002:a2e:a549:0:b0:2fb:58c0:de5b with SMTP id 38308e7fff4ca-2fb61b4c19amr6888611fa.11.1729007934620;
        Tue, 15 Oct 2024 08:58:54 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d0fe135sm1899651fa.4.2024.10.15.08.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:58:54 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c913aso2640401e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuB3Y/AEDQIvFJ94sMvQESmGUVOlcB+68QuaJvM6q6DH/i9cg3fOyunuLqH/CZcruqQuwQ4c8mVymz6WU=@vger.kernel.org
X-Received: by 2002:a05:6512:692:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-53a03f1af4amr688286e87.22.1729007932572; Tue, 15 Oct 2024
 08:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-color-v1-1-35b01fa0a826@chromium.org>
In-Reply-To: <20241015-color-v1-1-35b01fa0a826@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 08:58:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrrhUoB9=JuPY2erLMA7S-EREqvP5t8NNuBuUiA4rZjQ@mail.gmail.com>
Message-ID: <CAD=FV=XrrhUoB9=JuPY2erLMA7S-EREqvP5t8NNuBuUiA4rZjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix color format MACROs in OVL
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024 at 3:30=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
> OVL"), some new color formats are defined in the MACROs to make the
> switch statement more concise. However, there are typos in these
> formats MACROs, which cause the return value to be incorrect. Fix the
> typos to ensure the return value remains unchanged.

Right. I had a little bit of time figuring it out from the commit
message of the original CL, but I think the commit you're fixing was
_intended_ to be a noop and just a cleanup. ...but after resolving the
#defines before and after I can see that it wasn't.


> Fix: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")

The above syntax isn't quite right. It should be:

Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")

See `Documentation/process/submitting-patches.rst` which talks about
how to get `git` to format it for you.


> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 89b439dcf3a6af9f5799487fdc0f128a9b5cbe4a..1632ac5c23d87e1cdc41013a9=
cf7864728dcb63b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -65,8 +65,8 @@
>  #define OVL_CON_CLRFMT_RGB     (1 << 12)
>  #define OVL_CON_CLRFMT_ARGB8888        (2 << 12)
>  #define OVL_CON_CLRFMT_RGBA8888        (3 << 12)
> -#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)

Other than the slightly broken "Fixes" tag, the above looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

