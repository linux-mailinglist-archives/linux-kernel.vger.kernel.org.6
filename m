Return-Path: <linux-kernel+bounces-523891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89933A3DC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AF9422AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65241FF7B3;
	Thu, 20 Feb 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcT7EYFq"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFD1FBEA7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061100; cv=none; b=d3ogoGynCSBE2b/W63555MaTXpSlHCkJRHZzLZWUgdCQQ1NOQ51N1MhyKRulQHa6BsQ2hld8ibIlj6NOPD668y0KVAcKIve41zj8CxPBcBxX3DufksUBfD0QHXb3aWkfx1KvkvZGGwQF3z7N+JxphUYkIL0gGE9qXmRgJagevxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061100; c=relaxed/simple;
	bh=grftvmDJeT4+GKUQiocyfXXL33guz2UdKXmdukb/6R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+dwM1kYP+krV9tguJ/JQMv2wQAWAHunfe6XrmJ1/22kD6zAGPHpToXRMF0DV/0WDQjJgea0OVq9OsNvMSqxDyURfKQGM9GRm1/uo+XQBQaJclwvBFEZPxiI+MZRUYByJSmadMspGnZiF0XYCAPO6dhIXJ3uAO11F62JSasx7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rcT7EYFq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-309311e7b39so9161561fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740061096; x=1740665896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W6q0MfsecQ/oZxWXdK7pjWIJ78Sycv90qisJxzpdi0=;
        b=rcT7EYFqWXQTOg5H/+Qrkr2BvwFVE4C6baJ7LM0YbIjcBJoCBZG2aYKqr9n3I6N8YX
         XdQz6Yd4az6boaqHtlTzMjmOQ1MAguxuOpGqaFGNpgIfc/OOQHB3KpYgdyJPypsFiRqM
         xOF92QnmmgiFBdyadHXyG/ijKoBhxLiifDJRQAiKh1yHQ8lzYCJpDUc9oKsc80h071p+
         MLqaXH+1KuEWB2bobYxHQuQkfIiHqAPYl0P2vfLLoBDrk1RcuhwhPr4Se0Vl6PhFq28c
         Zzy6OCiyZDejVWVL//2OtrWFSMoMXDSJCJvc/oNYK8bdaqbb3skg8fEo+/bjOzIQQkse
         gC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061096; x=1740665896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W6q0MfsecQ/oZxWXdK7pjWIJ78Sycv90qisJxzpdi0=;
        b=tN4XwegDui1z2A0CpGTiZifihk9gRqXdHmRRNc8YNtegAFleq8T6ReTknqT6+hzpiT
         f6AwHvzBGXRaixTJoZ24O5N7/rnGiweM2IeC4zekaKQY0DRQSLwEGJ9ClcYPcJHbpzQn
         wBtmMKjH0Zv1UWCgcl0KXzDWfunV+FxC6jLRopKlW0X6pus2LmCt52dR+/b14xfqRCsw
         sMe6zW+d/XYQLu8dY0Z11ZDFWzaQyv4p9rsqIjCVb/NNWSqkHdMr3+Rfm1dFrFkOv8dq
         oNDgCl34bHOz1+V/ys5snGXhdGqzVG9px1tqvnbtoTTs2tq0z1GwpsAUHJ64GOVD+zVT
         TWZg==
X-Forwarded-Encrypted: i=1; AJvYcCXG8NYJ2Rk/HhjEw4TcdpWCuf0u4FIhQiwdGv6MRxOwcVDOGApJOePtqm10NKujkR2OxjwF9G7DiWnaP2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32GLFI/NqlcDbVOh3N1KELoTKyZlk1xmI4pOo51uDedILaS/F
	Z/IrOfsqUea+3Xhjyi0tvfxnpRiyap+QGezvSgt3lZbcgehZDX9au4TKD6lAzXaIUV7THFCcA3B
	FHx9MM8bRdI1moUFzzbT4eODXAwFhen/MUvnB2g==
X-Gm-Gg: ASbGncssaRVRk5uLEu6+GjbG/nI9SxFeIdkLtIH08Cuy3urOdKPKNJuAyxT9pdySmxt
	bsP+OWNnyAal0Jof+/LFU941kfDHSbCfqPQ2IjUYnW7hAwrjGoGVvmHosIcmOZzQ0TaGfO/2O
X-Google-Smtp-Source: AGHT+IGvaL3ytQhRSizHSs5j4h7le8Pj+1Uowv4GhVkmMwx1FqxJP9kusc9px7K6w3SuVO6d4TkqiTGgCnF2ShOKQ00=
X-Received: by 2002:a05:6512:230a:b0:542:2999:399c with SMTP id
 2adb3069b0e04-5462ef20ef4mr2952842e87.46.1740061096527; Thu, 20 Feb 2025
 06:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217120428.3779197-1-jkeeping@inmusicbrands.com>
In-Reply-To: <20250217120428.3779197-1-jkeeping@inmusicbrands.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Feb 2025 15:18:05 +0100
X-Gm-Features: AWEUYZktLgRRDDqqdpWTvRvqxLtf5I0A9ZWzKOQDA0dj-HnUxbhAd-KGVcT2F_o
Message-ID: <CACRpkdaHodX8atqWL+BXnvZ5yDvruizkZd44wUTPwe0NNWFT5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ilitek-ili9882t: fix GPIO name in error message
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Douglas Anderson <dianders@chromium.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 1:04=E2=80=AFPM John Keeping <jkeeping@inmusicbrand=
s.com> wrote:

> This driver uses the enable-gpios property and it is confusing that the
> error message refers to reset-gpios.  Use the correct name when the
> enable GPIO is not found.
>
> Fixes: e2450d32e5fb5 ("drm/panel: ili9882t: Break out as separate driver"=
)
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>

Patch applied to next as a nonurgent fix.

Thanks!

Yours,
Linus Walleij

