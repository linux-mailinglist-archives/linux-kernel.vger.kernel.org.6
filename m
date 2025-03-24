Return-Path: <linux-kernel+bounces-574089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57759A6E07E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E833B37DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192B263F40;
	Mon, 24 Mar 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9r8P3Fz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EE25EF8E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835816; cv=none; b=uVDgmhNyYoHi/xQ+oOgP91UorRjUWr/AgF7XmEtQpxztskLmFYFEbMdILjFIVh7IGMHi3Hacm3M91kmSVJzixXIiJcCDa/n14iU7knxBYjGn5VRet1Jtvsdf8/4mUzkdlKV1mq9TVx7WygvdOullKCj6YjmdXAzmzacBwiJBxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835816; c=relaxed/simple;
	bh=mqrCv2Po9KXP3CMWzXWHloJeS9zpChWNQf3+cBGsIzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQbQizhbpL+a4FaCor0P4rDn6P7oaooG0RjRNimidHo7r8ogxjAjibBkntm8imUA6jp4K1SrNOA2j/nUhlyOqEo0uJVLUeDqwU2gmHQcCcstFuE3GOpyAiIPVoTwEO3u0wxFohyr23HngYSSgeJmhify+2lzPVEXvfLbqA9zaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P9r8P3Fz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54acc04516cso5008771e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742835809; x=1743440609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeN9WfYxC0Q4TCphxe2JDxLIbtUvxnnWqFPYQRJNGz0=;
        b=P9r8P3Fz6ms44GFHVxppa9wnY/vMIhWitRfL53WUmncE1SrMyXEHMhKI4wOg6i3I91
         GSdryimcvu1aWtjKBIUcbNXnhER6GvqJ6iMfS7n0sVTHeyJqKS0060sKKT89lW2LtwzL
         fhnqeUycg37buBx8Ig+wvm3GwrYmDgockPWN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835809; x=1743440609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeN9WfYxC0Q4TCphxe2JDxLIbtUvxnnWqFPYQRJNGz0=;
        b=lfORJqYNw36sqN0UR3onKnTqIGq8+T8X/gPOjLOmKI0nnBGLn9N0qGNfldauYBjfHd
         qnIE322EcQFI9qrdfSgsSEjVc+euy4fcB3EiGR59nSkzKzmQpaqQ5JiwmvPM/FIRjz1z
         A5an1yZtU/L6xrqVghBrUH8ZPi3xih40fxhzLU3Mx0N8JlAe7QtDOsogdJJ0nSSpNYCv
         bBu7fO/nhLHP+tPxK/Wr87KW1h6WnBHm0Nr4bpCg3xiUDYnYulWf804pfhFyCZXH251B
         euUilmSSqjDNMcCM42vzRzE4YmznZ33qRXCdmkvMgXGLC3R9wKRK+OQWTNBWOcEQpo8B
         cMkA==
X-Forwarded-Encrypted: i=1; AJvYcCUFS/cnR9LNyAUwYSlud2e7knMxpLm6EIYqirUDOc8lRcJFPedqAk+mymrVrvBDTnZvdOgb0+ZSmzGKAnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXoIMl7qnqdxj+5UaBukVsLZ8s6n57+CJaRTeY2ruO4WxV3Pe
	KgBTY8vPLRhAZXOFrAakUh7xzOlSQ0D9tjUrXXGsBD9rCBgvfsNdTIfZ6amT4o7VMkXSXPvPdEz
	G5hiE
X-Gm-Gg: ASbGncuRd3tYyBV5KArtJnTJBb+95jjzPVGODhWqn1e0uOf+kKbcEaSkBxdLXQCA5Kg
	/QCbIHvP1kG4kLBHj4jrVMou+OWsyOnoledfI8Rw8F8c3jT+zgY/xNVAiA5KLU+QQdwRAw+TFK+
	BVBrToMnLiXlXd61hM007KMGxs6MyUIOlxtHsWrN7Zmz9FpArRl3aEE2munUeOKz5rfuXSIuq4t
	D9ZvwqvwFevahX+7/pPThrbqnHM7ldCz57IGbdC3L4R2bB2Zva2u3f3NHn/TMpqC2S6RDLjeOij
	/9Hcv2s1/78XdNlUNCyPAYLF7lb6SQF2LZL0UNTzA1uDyKswQH7yAlD9WgBqUxSdcV3YA6GcSqI
	S7d0KX2A65PKvuCFZGXU=
X-Google-Smtp-Source: AGHT+IG3uw5ZljmhUBMWMoUtFB981cAU9Ucr5zX4BVxTEeY1GixiihrdK7YaRXRnBKK86hd8lD0hkA==
X-Received: by 2002:a05:6512:3994:b0:549:5769:6adb with SMTP id 2adb3069b0e04-54ad647981fmr4707373e87.5.1742835808440;
        Mon, 24 Mar 2025 10:03:28 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6511560sm1231005e87.218.2025.03.24.10.03.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 10:03:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54998f865b8so4696924e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:03:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkWNis3LH7oi3SDGD00/Dc4Nf/YMBXhg5PestXy28IVs0+u4pwWd9DcxO6WpyOz8GTXzpYROvSSZiXbDc=@vger.kernel.org
X-Received: by 2002:a05:6512:3b98:b0:545:576:cbd2 with SMTP id
 2adb3069b0e04-54ad6479e3bmr3997038e87.10.1742835804312; Mon, 24 Mar 2025
 10:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323053007.681346-1-tejasvipin76@gmail.com>
In-Reply-To: <20250323053007.681346-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Mar 2025 10:03:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UATxXTwbXo5Dd-dn89hos2qF7agP-v4aHTc8w0J+yyPw@mail.gmail.com>
X-Gm-Features: AQ5f1Jrvf4X9H3KMfnQA-dDxNR8O7-iaJ7OGTYayURB_ZWvj4ShNTJPNpGFxHfg
Message-ID: <CAD=FV=UATxXTwbXo5Dd-dn89hos2qF7agP-v4aHTc8w0J+yyPw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx8394: transition to mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	megi@xff.cz, javierm@redhat.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 22, 2025 at 10:30=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> @@ -493,35 +481,28 @@ static int hx8394_enable(struct drm_panel *panel)
>  {
>         struct hx8394 *ctx =3D panel_to_hx8394(panel);
>         struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> -       int ret;
> -
> -       ret =3D ctx->desc->init_sequence(ctx);
> -       if (ret) {
> -               dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret=
);
> -               return ret;
> -       }
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret) {
> -               dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret)=
;
> -               return ret;
> -       }
> +       ctx->desc->init_sequence(&dsi_ctx);
>
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>         /* Panel is operational 120 msec after reset */
> -       msleep(120);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret) {
> -               dev_err(ctx->dev, "Failed to turn on the display: %d\n", =
ret);
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +       if (dsi_ctx.accum_err)
>                 goto sleep_in;
> -       }
>
>         return 0;
>
>  sleep_in:
> +       int ret =3D dsi_ctx.accum_err;

I can't quite remember if kernel conventions allow local variables
defined in the middle of code like you're doing. Maybe safer to define
"int ret" at the top of the function?


> +
> +       dsi_ctx.accum_err =3D 0;
> +
>         /* This will probably fail, but let's try orderly power off anywa=
y. */
> -       if (!mipi_dsi_dcs_enter_sleep_mode(dsi))
> -               msleep(50);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 50);
>
>         return ret;
>  }

If I'm reading it right, the above is a slight change in behavior.
Previously if the init_sequence() or mipi_dsi_dcs_exit_sleep_mode()
returned an error then you wouldn't run the
mipi_dsi_dcs_enter_sleep_mode(). Now you will.

If we're certain that this change is correct it should be mentioned in
the commit message. If not then we should make it function the way it
used to.

If we do want to keep it the way you have it, my own personal
preference would also be to rearrange the code and get rid of the
"goto", though I can see some argument for keeping the "goto" to make
it obvious where error handling is... Up to you.

