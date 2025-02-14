Return-Path: <linux-kernel+bounces-515364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C8A363C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDE83B22B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3EB267712;
	Fri, 14 Feb 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYAR4c/O"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397113C67E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552440; cv=none; b=CFFEx8AvzWSn90xJ69b/U8PzsLQAP8cZv2EwAJSyR+2LW6qQS/GMDVADhalQWLSKPIk5U/4hN4z8Xr0xu0KWgsPR3o56jqvDtrpV0OJ4QNZGlkXR8BvwZcMAeURFr+3IJvZ5TFNRAZ6wtKOmaaVmD5T/I9g7e5luC5BOskN2Ork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552440; c=relaxed/simple;
	bh=MiFR3quRFEg087vBzbccqqMF50xWoSlOV/fK1lFI+w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOYFXcJalDfUc1k8Qa9fRa6vp2/XEUPdWZmWRMflzaSy6Byo+5vpbDTm27fzvH70FvqxPr20E7NrXU+df7PIQ3zfdY71pjaRTgQJmIV3TpM2ajTOWEVhEZb2B7r/OrDWCTQrCyxXTFrCrBrRdvIzcIE/V4PPx717mWPIRtUANdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYAR4c/O; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5450abbdce0so2391869e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739552435; x=1740157235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiFR3quRFEg087vBzbccqqMF50xWoSlOV/fK1lFI+w4=;
        b=BYAR4c/OE85xGFxVjZGINGH2+rI8nXwtPpmWluevBbC2mLLbXHoIoPO7xjbm8Nm+z3
         bYMumA2DPfPioDDzqSIKHiYVHBOVGH0BJrw4ale8pxlTvJ6sQtwIkl92E5kxSWwib8nw
         DfJ0E/kZomDAzfSkIA1BApV3Y5lhgNAQBgx7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552435; x=1740157235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiFR3quRFEg087vBzbccqqMF50xWoSlOV/fK1lFI+w4=;
        b=RkdjRfsHTSNjEqaNwmJvo/OPO9rdHf1+fYnBzVAvLhCnRWaESh0TDx4bQEHtyUfKYR
         0aRhOP/afuosxB37/B3HP0OOpMx5mr7Ner1vnUx68/kwBYDaozDnZZ9csMfIoBH8ENHM
         gLhS9wePmdXnswkSz9PVp2pSAt5R+khhc5GuH5nIE2glyYv3oU0dQ10qhq69lgW8CcLh
         iNGIAVEan1HwdzOI4dAo+XO8/RNz9qqyv6DqcbYP72ZklGTv+4TefAmShT9PsZcipU/V
         kmHm2ZfJgqS33bRPvNahbTCz/O5SODNUzPE8DBpvbyaK33cYyEYeVcbQ2+JTSUFXOinN
         B4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg8gc9qOH+0/X2Z/SvQqddBqY6UPFi7yTu1k1UB2Uc8AFDDpSeAzFrNhrxIPy16ySvNIs8xNsfLlI9ErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV0O+xUPOVWUGogWVirmgZ2YaPb4M/O5pDUJp2P5v2yKE8JQ4
	teDacKyUHtlYlG9ZJe8lOn60BALpSCSTy35Y/ImuSExaC6LQZB4SW8Xl5xz3qLfWM23/rmal+pF
	WjASS
X-Gm-Gg: ASbGncu4/8QOP8TbDKwdtgoF/bNiSqcx4F0M6es5sWdkMEZZMQ5d9XGdF+buw5kmFGj
	px4l40vvDFMnKnsZhwmDZnm2Mg2QdZIUitlcrNiCtxw8BrB2V5fjkgyGSbxt7uJhXP37NMmDqpc
	R12kM8IMo9tOodQtijMZ9XSkUfNzDFl/Dj9690T+1SxnAqgdk/hw20xbnL/qS7hUsiefMgRwh5Q
	82PSPFk6dtScVZddTvTg6knrVzn4AbJ6/AfG63mJjfocA3Lkir7WSuXbUE63Yn0hXiS8L9UNRuR
	qgiADKZVPQ/f1pHXlVXA4r3pHSOBt+ISHPhcP98esO6KuEzwvciRjZu4Pxs=
X-Google-Smtp-Source: AGHT+IEV02mDqyyuHH94IcEnj3+EP8hwt4gUmonutz/MZ5XLjVTFost/GQP/u/Rnb/ZWnfm7czgb/A==
X-Received: by 2002:a05:6512:ba6:b0:545:bf4:4bc7 with SMTP id 2adb3069b0e04-5452fe4e600mr27796e87.19.1739552434648;
        Fri, 14 Feb 2025 09:00:34 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ec95sm584630e87.233.2025.02.14.09.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:00:34 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-308f141518cso24660041fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:00:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp9S2EudhMWB+UWx5WqkB5nSaM2groZ3hq/CovIQNNrr09jTgcg/Zv4LDBKDqoMaHfp10IWShyPDbSSnw=@vger.kernel.org
X-Received: by 2002:a2e:9cd1:0:b0:308:eabd:2991 with SMTP id
 38308e7fff4ca-30927a3a12fmr938761fa.1.1739552432081; Fri, 14 Feb 2025
 09:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-3-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-3-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 09:00:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XE4kFwJcTd_zJ3g5eMw4w2D6dZh_imr9K1p+s=K9DS-w@mail.gmail.com>
X-Gm-Features: AWEUYZnF4y9fC-8_sEsNYrB6_o2BfDQWhIPmNhTZZs2O4VRlvUgwtwaAGfHPT9E
Message-ID: <CAD=FV=XE4kFwJcTd_zJ3g5eMw4w2D6dZh_imr9K1p+s=K9DS-w@mail.gmail.com>
Subject: Re: [PATCH v3 03/37] drm/bridge: Pass full state to atomic_enable
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:44=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> It's pretty inconvenient to access the full atomic state from
> drm_bridges, so let's change the atomic_enable hook prototype to pass it
> directly.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

From the point of view of ti-sn65dsi86:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

