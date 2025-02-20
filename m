Return-Path: <linux-kernel+bounces-524361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50064A3E25A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE847046AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFC213E6C;
	Thu, 20 Feb 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="MLGiFGfv"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07C212FB3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071703; cv=none; b=ua4YffTrbO63+1wZ0eKg9tG+3Eo80rpobIXCVQgyBaK+hSHdh2/lu73CADG5gsPwgVOuMRpWM2Lz2Y0pgcOK/kXPpH8IR1lUC6XsKxDf28gMPzu5iG0EfisCvFgDD1IKDd4JGJnpwj9X4S5pvmrvyB0uEfLhI4r4C3nSsfvoFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071703; c=relaxed/simple;
	bh=QDzvTG6s8X3v7JBFs6BYnTXCw/eUqyjWci0yVfOV4Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwtwSuzi8395aolrk/IkeaVl94gsefV9JOSS99aQI3yjDsUNcYjGAngmmWSKVc/gC0DA5NVKXTEmQjASZ3p/Mzcj2DzJvUrb4FVBBFI+DoyiqWSyM74B2pUM673kJKcT0j1WP6hcZKSNW5v8iGo8p0B2cfSIVFXJazO935FHNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=MLGiFGfv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fb95249855so10289747b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1740071700; x=1740676500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwq4WmBNfvZIFl95mQweHpQSFemw3YwiC0sTz3/2Y5I=;
        b=MLGiFGfvUOXisQEdl5IaKupUBH92wcfmswLy55IghtEIqtMohZbFDN4NXNhG3oj14t
         DEvqBvieVxklJz2OlsFGl/zf9gIMpBQumfaO9JgiSUBVj+zETLx8vOV//424M6jdft9x
         VAu17OgfzIJYNwYrkUfFwqu45ap4YxO6GqXTgRHzzIqawGAoCXqOEYHJhGlxX656dndi
         Mo+0aYmp/hth53dsLn991+rbHWR5Vd1UnOupARV3XZJLTxYmIfEd3zifNF278NuehEIg
         R2I3tRSR1IARK48KMWOHVttX+ISGwDz+9pcsKv4EwOjvxYYmJqaDw84bvuwa9yCYwpRe
         x41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071700; x=1740676500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwq4WmBNfvZIFl95mQweHpQSFemw3YwiC0sTz3/2Y5I=;
        b=YFD1x+VMhRkENIaYKXLsha9Q1NuKgAyiIu+CJhfwGm9NIpOv8PA5aD3wA4Qr+dqfqw
         WDMub1KXzLyuXfmFAFYaPW6jXMWO3LJjJ8KEStzNvlbDnOkVOd6QK9urUZOUHJFVWs+5
         /A1196JRuSy1yzJvFkbBvJN612Dh24Ur7HUB+XdXK0IMK5cxGmU5u47k289RyaFqKuLi
         /GYqJitXIwBShTQz9zQ5qLIeiVIsBvUVj5V/67h78kzBHS+G5F+iHMbZpt1fpIa1sNZM
         w/zesJR1d/9D6zVRX8CYfum9HmqoN657Pes0yhOdjvEmTho1OenxbsCatJvk3atiEmnY
         JvDg==
X-Forwarded-Encrypted: i=1; AJvYcCW3z2e2fRozv5y9hEXeu417xTkeZ/wnBJBgSnhNpHvhQtsLYWASgwPKH/cl/8ZxcjwrOu0nQZkGyifI4+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ez5hbUOcUAf2gjPNWg7WzUVAjc0WUCjcT7OxoIQVeyBCaVfR
	o/mYNV6YPavAg8CAI3eesxF5T0e+NOEpe+X5oq+nKMNlqnkHgoyYBbKQFzsQbU4D8Y+zXGbxIIM
	iKDfmIjGgB5miPsUO/uvXsOdt6Qo6orOw8tpEV26ngVCrwMPM
X-Gm-Gg: ASbGncvHjPrOu5F3MfbzCpwjSbQFg1RwCN4/p9i0yI4+zfEZaHZBUAumJY31chNXLkr
	AVYl6KYnG3J62wnRLPu7GUiMoCaNElhYOXE/E31SOrJ4wKxx9fMkl1h2OQxrmcP0sq8HwhDbXgY
	dyUeXKwVoFDHHaUmod1wW4hgp2epyY
X-Google-Smtp-Source: AGHT+IFO49Zspuw3Y4wLu3ybRNvKs4qpn85CyMjYcPYJhNXmmry9pN/CTOklRPcKwt06H80cWgbXBccGMGOIS9WbEwE=
X-Received: by 2002:a05:690c:480a:b0:6f7:ae31:fdf with SMTP id
 00721157ae682-6fb58293a79mr195681887b3.12.1740071699101; Thu, 20 Feb 2025
 09:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220140636.146506-1-demonsingur@gmail.com>
In-Reply-To: <20250220140636.146506-1-demonsingur@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 20 Feb 2025 17:14:40 +0000
X-Gm-Features: AWEUYZkEoEHAzoYp6ApjAyCcr86g2Xt6MXZfxRvrXit0l0TR_2CU3wyUn3r-_Ks
Message-ID: <CAPY8ntBNtz__=otVz_7b4cWBiHCoimBwij0EUUad8EXvTJ+8hQ@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: imx219: remove context around case
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin

Thanks for the patch.

On Thu, 20 Feb 2025 at 14:06, Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> There are no longer variable declarations here, the context is useless.
>
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/imx219.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index f662c9d755114..fcd98ee54768e 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -947,10 +947,9 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>                                 struct v4l2_subdev_selection *sel)
>  {
>         switch (sel->target) {
> -       case V4L2_SEL_TGT_CROP: {
> +       case V4L2_SEL_TGT_CROP:
>                 sel->r = *v4l2_subdev_state_get_crop(state, 0);
>                 return 0;
> -       }
>
>         case V4L2_SEL_TGT_NATIVE_SIZE:
>                 sel->r.top = 0;
> --
> 2.48.1
>

