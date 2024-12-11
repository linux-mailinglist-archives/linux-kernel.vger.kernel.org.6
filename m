Return-Path: <linux-kernel+bounces-442285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0989EDA38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DEC282D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276131F238E;
	Wed, 11 Dec 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGw0QeOQ"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6C1F0E4B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956495; cv=none; b=iyzJJwbdx5DQoZETZFaHwSU7BkoCrbLsn5SopBOTXwqwTy7PPN/V5oZKD3spnhIIBRLSXIGhhmUn+HBGjKvKt4iKfkVZ40sfkMvuBiDAKyFQiBST7NWPceAV5PfJHgPA3CfklbVzg9grJ96XoEjuDalHajaHPhsPkitB4gvQnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956495; c=relaxed/simple;
	bh=tDf4ejwfEGIsqo0gECgqbJNHrXI26Cw2gJA0n3bcwhE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEq9iLtmUGq3OfC02MEG5X1llQBGD4K+M9puJjHdBMTnosMUVRFz9vJ81IhrVF8mqGNYjEnE7C1jysQtuFjE6dAnZ4Oeliat2NV+D8WyVDVKyMUh0dh9f9TTM3o3AbQW+KMjeZhmkLa3YGUGaUGbFIQEmXIr60xS7wDBrHwSi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGw0QeOQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso41258206d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733956493; x=1734561293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk9mjVxKh0Cpv8VTlttHozyBPYsnqFLG9k7nQi8tKJA=;
        b=fGw0QeOQVU7VJTzKmZvZqdm9GA2U9ba5DisWL0rmigRG6FhOOpPEO9mDaGDEPmsct0
         Hdn83XICMJmzHpfS8ezDyM7w3Jz1TxwoIwu9soDlfMRZhVKDw5NDWR7IPkhwswF8ckLg
         szBiJH3g7MChELUg9TDg1XIKTYZy8OOP0TWVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956493; x=1734561293;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk9mjVxKh0Cpv8VTlttHozyBPYsnqFLG9k7nQi8tKJA=;
        b=vOW8Z/KvkMhgPSvXZkyXhuvC6rpl0yKC+A0P3RUCC+p/UIj1Zs3CWjS7EDcDmI6mYa
         5rswtV2qBlnCqztGl7ldFj7MrVOSBkzvyQItLrEr6cfjodxRp+c7H6E5twlfct36qXvQ
         gExYkAnWlwMpmDRibs5JnDQfWvFWGQ/yEB8okOQD97j13HCStCEgtsusLGhwwM9ADhwt
         o2akg8QI9dYQzEUsqu44K59eQENWc7U7FYDN6ZVXTNLQl8xSaiswWIWwf3J5SdaCn3/k
         Umzjia0dM4xMS3f9i84fOm7pEa7QwVd50DSxv79+uN54lxDkjJVu97g1Xu0hvj9Tn4SL
         fP7A==
X-Forwarded-Encrypted: i=1; AJvYcCUOJM0dkGVvGlPfDn4F4lNEAauYrMuX6o3/ykGoxnGlxIzX/47CUPFHggcqM1wTeQSZ9RrVd1yH82oLw6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GJX4jBQ0ROrvCatzM4nAyuf14Ju3OwiKiygb5WwZvCDAJtbo
	iahsT7+R95TokSCJbE3idEKw8yKrLcLx/eS5twoIpWanItku6LnxdVpATb6LB7LJdMP0YfgNOX4
	MGjgDfTV2prsHwQMRTEgbxkboLN9ZFpVLV1JwX9JXjt+LbSQ=
X-Gm-Gg: ASbGncsEbOgHKBfhD7kTfWOVub1941iy8RgHNwv8+PW2nWs0t2RQHwsuryyQxX2Oyb7
	ZSWgkcBvIyMDDbwQJLD94rHtcv8gIuzG5jTaG03tYSN2+ev32J+zNU+Yrkxdg0lY=
X-Google-Smtp-Source: AGHT+IEmNl1A02u+Et+QaYelQl7de4pzHAlegixn/lag8TVHIDn3QbqOGZ1uvtk5TAuOj8J/cuxjMvpZP+M69zQwnG4=
X-Received: by 2002:a05:6214:d83:b0:6d8:9c50:52be with SMTP id
 6a1803df08f44-6dae39a1d71mr15934046d6.44.1733956493056; Wed, 11 Dec 2024
 14:34:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:34:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-9-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-9-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:34:52 -0800
Message-ID: <CAE-0n50Ei+DodV6VRmm_aSEZ_DdeMZ_vMnK7Mq0=X441B+YreQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] drm/msm/dp: use msm_dp_utils_pack_sdp_header()
 for audio packets
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:39)
> Use msm_dp_utils_pack_sdp_header() and call msm_dp_write_link() directly
> to program audio packet data. Use 0 as Packet ID, as it was not
> programmed earlier.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> index 5cbb11986460d1e4ed1890bdf66d0913e013083c..1aa52d5cc08684a49102e45ed6e40ac2b13497c7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
[...]
> +               .HB0 = 0x00,
> +               .HB1 = 0x06,
> +               .HB2 = 0x0f,
> +               .HB3 = 0x00,
> +       };
> +       u32 header[2];
> +       u32 reg;
> +
> +       /* XXX: is it necessary to preserve this field? */

Maybe qcom can comment.

> +       reg = msm_dp_read_link(catalog, MMSS_DP_AUDIO_ISRC_1);
> +       sdp_hdr.HB3 = FIELD_GET(HEADER_3_MASK, reg);
> +
> +       msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> +

