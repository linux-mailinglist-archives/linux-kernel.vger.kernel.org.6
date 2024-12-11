Return-Path: <linux-kernel+bounces-442122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0E9ED83E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330A92825E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0220B81C;
	Wed, 11 Dec 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHayRsOZ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B32EAE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951684; cv=none; b=BBM5q2J0HO6gCOzJqL1HsP1MPcmtg4TUfWD5GJWMPRET6YObItGK94JSD/+s4XR4J6d2em5bw+lFL4baPyZip1be1YZCAL7CIPVidLB1uj6USbC6Zl5h1z7TmhnWeefdGgXMzaaFctHc7qxlrTEF1III+9TJU9x+C936s5aFjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951684; c=relaxed/simple;
	bh=pQxLX0OpRdmEKLujU7po1ZyE+Iuv7dvTeQ5pTjG0L2s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFoeFtYKwQSq7b89K86WVz86SmUnNubucuPqlYxPPMw8I5cUqI2jiU8pnCnr2/V329+Z6uYXcrjiL/MKVWpxgoYGOoDaIWvER9HW51EwkTw4P1Rmdy8uDbvPP6NPR4oepUed1l+0E2aB4fGlyK9YsmRWqRzO4xRyBGv4dT7RFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GHayRsOZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3988fdb580so5861635276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733951681; x=1734556481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezBwnwc54xrxIW8WnnX9hiVaqGX6VzJ/z+kaEQox7Lk=;
        b=GHayRsOZLwwS0Fv39Tz+Iq0puNCt/lLqmHxaV8CstxgKlAN7/z+IbBTNanMfgzeYhA
         IlRwbhYqfwHZq1Dhllh8hDEKxcilGpIkwg0EpYEa/e+vd99bO6gW3f3vawRB2sxyS2DR
         ORGg0xZ/+OGlpXneALwlOFJylERyACw6djoSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951681; x=1734556481;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezBwnwc54xrxIW8WnnX9hiVaqGX6VzJ/z+kaEQox7Lk=;
        b=EkW5k5OJpIgXEo5rHwQdALkcjwZj2ouJ9eFWmG82USBK57DTWBebyGsbRCqD7YC82l
         sbYiIfSZpSW5NdIZpejLTYg1N0iL/t01aCKfZN8H9z7+gcvKpxQco1jEmX5ILnQAbK7j
         dMlxxn6l2DZtRccai1PXahbUbIroz/5CT/6mHo3ssA85uVgL4PIUmEa73UerWoo1ZFi3
         FGbfEeyNJesfxJenpXxxvxtaT6l1ObYQpQK6qWa/6fpPK6b1OpkAFas9B1+rFsGSyjt/
         G9V3UyNZBbDvw1v7XKiTZVd39iLnDU9WpkRPDKqPtb9Ks67Dkx3z381Y24VulifN7Vs0
         35kA==
X-Forwarded-Encrypted: i=1; AJvYcCUsfkVqM0vCtOQcD3RuYKdqesdIaQ68gYQfHni8ned1N88y1nELqEVRc9tYub7UiWQKnSZJI0CHlH3MwJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wbIlIJF6BpX6q3AufOt8xLZag3iNlIIW/ZyJbU+XXJymYJMp
	dOk4Sxww0df1Z3XpAvrAAyi3icuFYi2xfiLOh2HfYVUXpZs0DI89NSpocO1+iRwPtoZJHW4JGQe
	Pdi8EXdgUSwjnA1CFclN2AjZXOYNoAFyHuT4+
X-Gm-Gg: ASbGncuiSA+zoY7ARsSURAOrlU7vMCwsP6NT4bMhKawgsVBwATQ3LUOhPD3qTDBNIEh
	XO2P9AVxYEk7HyFHHHrgsMFiaJkbgNq1Irzf/Zekh2IC/EjEuVvW9cu1Wl8bia9c=
X-Google-Smtp-Source: AGHT+IGVGcprZk95xhhOtOKM+7JPgPvLrPlsxoiz5xiivClwV1s7VtMi2gtLbOTTJ+cbuh16Xk9oGKjJ+Ksx04T7VN4=
X-Received: by 2002:a05:6902:1447:b0:e3a:5820:febb with SMTP id
 3f1490d57ef6-e3da1df70c1mr852810276.32.1733951681689; Wed, 11 Dec 2024
 13:14:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:14:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-6-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-6-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:14:41 -0800
Message-ID: <CAE-0n52+nKDyzUPzg_uFsLXRh4XQW+TngD6PyuvetTKXthi_tg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] drm/msm/dp: move/inline AUX register functions
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:36)
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index bc8d46abfc619d669dce339477d58fb0c464a3ea..46e8a2e13ac1d1249fbad9b50a6d64c52d51cf38 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -45,6 +46,73 @@ struct msm_dp_aux_private {
>         struct drm_dp_aux msm_dp_aux;
>  };
>
> +static int msm_dp_aux_clear_hw_interrupts(struct msm_dp_aux_private *aux)

Can you make this return void as well?

> +{
> +       struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
> +
> +       msm_dp_read_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_STATUS);
> +       msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x1f);
> +       msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x9f);
> +       msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0);
> +
> +       return 0;
> +}

