Return-Path: <linux-kernel+bounces-568739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A0A699F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B153F19C3E50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F7214233;
	Wed, 19 Mar 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ES6aCqst"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07891A072A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414765; cv=none; b=ff1DSdAR4JVkcHSlZSVKsUhlB9ts5as9Jh/n7agPxNhQxeTtFDDMkjhs8zFQu+b4gn6Sj3WPV8p6QpnxgUNzqTxvjJ3ZkNmXoc+b13UEwbAdTTHGggeUJNSfa4kEgng1rILp/n16PwIH1yIwY9pi0MDS3L2RWxRZUCi2v5wkZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414765; c=relaxed/simple;
	bh=ktMKXyrEm90QxD5RMoSevXCop5BJEPQPDuFpUGyCcLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=makf1WiASiont9F4fU8k0UCZL5ksWq04xhxtfwpEtxWwNg9JKMzPZ57McOQXKrPogOKimdwIkWpvmSwikbSiRLecUVyCmgF1KgeUUHGzASEjP5rBhflNYdJSxALtqplyFdo2ju+IhJj+G12zzfyDwo1VCQhIM8ZN3TO039iZlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ES6aCqst; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bee278c2aso13018631fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742414759; x=1743019559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox+b86Mz1zLnyFGavaorxBWxZyepAXif0wOlqHKLp20=;
        b=ES6aCqstSxMFLmCo7nQBAXtNuEKEmQlXm7xTp/z25jtNuvJXO8rbVkRF89Ld8udNHf
         dUXnkRg1D7fHkD7FkCArlKl0UdMNK9MuD2S2xSUAvyM64zw53SBAnirGivks8HXYzjbJ
         lUEmsViACYQpwbkzs7yqen97NqNWhTQcZCYMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414759; x=1743019559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox+b86Mz1zLnyFGavaorxBWxZyepAXif0wOlqHKLp20=;
        b=V9goicMGt3XAcRkEUxHVNJ0MYc1xC04ej6RDL2qv96C7jk3VNM9nydYx6d2IX2WNhz
         W2mVclkYgCSg5z1id44YgrKTgsD/oWnRpwOxEy05+KPk6Aj8F+VVzPcpaIwjqbNs14Ek
         vmAlTT5BGAT8jkrzHDKU3RiSIcOnL/HwdB5ZwTKVAMjq/j0oH6JLbX6WWQW4rx9zczBA
         KIIOJkHDgy96EpU1govz+/ttMeCXwL9JcnoO2uTyr8Wc8w9eB7WDn0eHPb5fHNhVRMjp
         xdt97uq8N3lJ2rTkkAY4aDiHXhbYkk8FLlJXLDdCys4TUmM0sGylZ2BfjibTfKzgWIqd
         U+mw==
X-Forwarded-Encrypted: i=1; AJvYcCVzryhvFvepM9TJvWGhlkTe6SmEOoFQXr5eRsZMMpdVZhTpeZ/eTmtvj7p957c8W2ktnczKEBC6kELA+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+8B3eIb8Nmtz0fh3/ggIYcnPVT49rtI3q/auOC1ProlZL8fI
	l+6Z5HxORGzHfzjIt/Rt44cr5ociS7kDzyLhVgchXH9Na65/BiGzxoioR2igfRmmTDu+LSIdQRR
	Xsg==
X-Gm-Gg: ASbGncuSU8IyYwuOUQ+LTH52SmxDWdgvWEuQ3o2fSPIp0VA8Uf4MvgeioASfpvze9Zc
	9QVxJhjMvZe6ydcQMt4TB5RH62IRjiBdXvBUMWd8UzU9s6lBAFuwijXhIcuvPwzbsVMuFpCG1/K
	xAxTg2Q+cTFBjAOIyq5v4Gv1YdWOT+AL3sqchx6RkMk9Wew7Pbh4uIyOjm0CCX9nPmtvHQfhCqr
	Kd36I0iwo3dlkGsdFL6ziXOS1IKmOX4mPteuMpXkA1+qrx61qvK3BmJNnTzjjsPPpDhUeVcm2r2
	k4/dkJdIIzKQ2UnPBxx7SXTKESRGoRQfv4BkB0wXXXMOldAwn35rMR+olEDnxbjCrs17dWQROB1
	CRZL8C3nYVshV
X-Google-Smtp-Source: AGHT+IGnMyU9GVbf9pCgMy3F8SjhTymUWMt9OJC1GvnMAda4gOk0uvxdh/842M9KKzwocm7yWug95Q==
X-Received: by 2002:a2e:890d:0:b0:30b:c9cb:47eb with SMTP id 38308e7fff4ca-30d727a8910mr2295921fa.13.1742414758850;
        Wed, 19 Mar 2025 13:05:58 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f116a56sm24447811fa.54.2025.03.19.13.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 13:05:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bee278c2aso13017801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:05:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkwCSBbmizBlgHaR8ZjE/ZjbSsLf1msBrs1rrzF5k03qzrlR5DVSdSj25CkiHujfSP7GFiVlBQwrEdWPY=@vger.kernel.org
X-Received: by 2002:a05:6512:b99:b0:549:5a14:96d with SMTP id
 2adb3069b0e04-54acfadcd79mr273139e87.19.1742414755591; Wed, 19 Mar 2025
 13:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319183106.12613-1-tejasvipin76@gmail.com>
In-Reply-To: <20250319183106.12613-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Mar 2025 13:05:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZxF4CGSAAqSvs8XnLEvkXNEEv87V3ffE_uBfj-qWN=A@mail.gmail.com>
X-Gm-Features: AQ5f1JqO4W3z05cexRyDsYmMsA9GOM-V18xTmamNtYwVoiT6_fJtymxP1txM44g
Message-ID: <CAD=FV=WZxF4CGSAAqSvs8XnLEvkXNEEv87V3ffE_uBfj-qWN=A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: samsung-s6d7aa0: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	aweber.kernel@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2025 at 11:31=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the samsung-s6d7aa0 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Remove unnecessary early return in s6d7aa0_lock
>     - Remove redundant GPIO reset setting in s6d7aa0_on.
>
> Link to v1: https://lore.kernel.org/all/20250316045024.672167-1-tejasvipi=
n76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 222 +++++-------------
>  1 file changed, 65 insertions(+), 157 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

