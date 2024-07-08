Return-Path: <linux-kernel+bounces-244925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E192AB99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B996F1F21C97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90514F9FA;
	Mon,  8 Jul 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6xyNBxI"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745314EC61
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476001; cv=none; b=WBDL1UtC9XN1dRXBeWVhGRT7YjDZwPlRt+6UuAqbAsAED+Fpla32iyf55HMlukUV7LsrR6Eat+ODGoL8dAlYiEanMEsIUMql+SR8cHhdCUCLR/1LVjOvKiiv/J5Fpbqg9GiDzj5QnDDv7F57H0U5gXpJ4/KJ5/HYFRXqzD61+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476001; c=relaxed/simple;
	bh=UbiKeenkHpA93IwWe8dre1vCfdfXO9qWWUZTNjWd0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTuw9hBJASSAQ/d015g0t7VAipkAf7fW+un/PuiKmTYz6Ss3eWVN7cZiGgvxIutOTbpnpzvKugdgFwRhsGzB/kGgojztYdy9dypgGg34IxYZ2WxM+pHXDk5RIfoDuSjZgXSo0kezETYvYua0up9PHEzS4wFVRjE0CrcSo/Nm86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6xyNBxI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso4138924e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720475995; x=1721080795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltrpJ3wpWcI1Lsx4DkbvbSmrXoLvEHXjwbwXRsoboiM=;
        b=A6xyNBxIBIJ4wIFdE39w1Rv1R9IcBoLLli0ba2tT66kzjs+QzNtb6J5c7De/esivO8
         ZsOrU7danHmCWNwKgMcl1+rb2YYgim0G07f0WSNTlzvmXNMniodXdNzOL+1jkK7HIpBI
         EVuKnz5QejV0XX0C1K9W3pemUQkcRDycW2ABs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720475995; x=1721080795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltrpJ3wpWcI1Lsx4DkbvbSmrXoLvEHXjwbwXRsoboiM=;
        b=bPaEzrLTq+tSQlDsQiHMQDbRlmg2TCTD3yrDFIWiwDZ/2Y+ySh102eno9EcAMEES1n
         lDuLb+mlidPi1peD0Vo1oKxLOUsgTCtx09PJTSMn7CD7FDq7xVzz5GxhelzQ2WV8Fe/D
         xXEsW3pY/vSCo332YpXeUBZfJ6iYYQZ2cdMcexwRxfI/zHwe6Ybso8sMy1p8xzGRPncu
         zi6MmQXLO0U0NCrSWLuPDLvbM//vp6mIKelv83CQLw6qxlqNfbPoUcPsAoxOgxH7me56
         6AKGuJRYVyWI+ib4Vkretdlv9D0DEzQx0B/+h1V5994LEsoZK7HRjgGemY97DJwdadIy
         s5PA==
X-Forwarded-Encrypted: i=1; AJvYcCX4aOI7Amav2gJFSmaeEZByfaUiljrpuSjwP0MzXqOUd93MvA+Ta0cPCS3UeuJCDA8JuRbnrvuXrHR4hB1CpCvUjgyj48Z+hHWxFCuY
X-Gm-Message-State: AOJu0YwRkiOfUsrpJQ/rqpyUQs+VstVciuNkSMCz2OKvmKyF4UrcOgKI
	2+TvHHQcoHRZ2AgaQZNABQ4cBbjb0+vyG+ujMBDM6NxlAk1x2Kl3OXlnXlUEaa6SJcPbXEKK3fq
	ArA==
X-Google-Smtp-Source: AGHT+IH3bTKQ5YYykpzvQxkehsmVNtmYAA5slN4Z1OLoJmXN9ieL+1OtKgXm0OldoIr7FhFxsuunoA==
X-Received: by 2002:ac2:46e7:0:b0:52e:9f43:c150 with SMTP id 2adb3069b0e04-52eb99d4f47mr312084e87.62.1720475995207;
        Mon, 08 Jul 2024 14:59:55 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f2fsm25015366b.202.2024.07.08.14.59.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:59:54 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266edcc54cso28495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNEGw2uudNCB+vRcej4+30HTxuczAGQWufzcjavCUuAmSzIS+lgiHo/Egh66FVXV4ZQJct1SWQJ9HbTRkavSAz+8Z17qG97RKiZZwl
X-Received: by 2002:a05:600c:4f53:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-4267189fe44mr730175e9.0.1720475993130; Mon, 08 Jul 2024
 14:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
 <20240704045017.2781991-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240704045017.2781991-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 14:59:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLVC8OkP-MqNmzpU3_O7bPv_qJUpG2MVActGT14fP4Jw@mail.gmail.com>
Message-ID: <CAD=FV=WLVC8OkP-MqNmzpU3_O7bPv_qJUpG2MVActGT14fP4Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panel: jd9365da: Support for Melfas
 lmfbx101117480 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, swboyd@chromium.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 3, 2024 at 9:50=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Melfas lmfbx101117480 is a 10.1" WXGA TFT-LCD panel, use jd9365da
> controller, which fits in nicely with the existing panel-jadard-jd9365da-=
h3
> driver. Hence, we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 246 ++++++++++++++++++
>  1 file changed, 246 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

