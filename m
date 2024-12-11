Return-Path: <linux-kernel+bounces-442129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35B9ED858
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406C7282D39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22301E9B36;
	Wed, 11 Dec 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8/wlLoJ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150686326
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952025; cv=none; b=ju69pcJixUf2bPSy7K+THMK3jE2JiwBUI0TqO4+s75K/GDZyQClAaFohyZnliOgGiczVBeBYOWqWwOc3zXl3uIegnQ9XKTATUSzXFweNBomUl8R2oojVtkWEkCPL1PWdaS2H7+8v09+8mm0S63zcgDMaNiPrTEL4blx5gnoEDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952025; c=relaxed/simple;
	bh=SKfxs3pDMj3GC7YQPCyoK1BtKC5bUlyrggnykcN/Mw8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3nqlptMIFnUIrOPZDY35Qp0bs6BMgTQnTQezvKa5UbTdtG3Nz/4Yn27JTUE0GfGNWQreI55uD2JdeInzGghOpMo4dwpIUz4Jq8kLmmSTq3wC9K5QFAvZkTZ0KGTwIX6PZWA4k2WyfGbDpydWaM5UHYh7nmLocQ5fV5nuTCoJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D8/wlLoJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef9b8b4f13so69922067b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733952023; x=1734556823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKfxs3pDMj3GC7YQPCyoK1BtKC5bUlyrggnykcN/Mw8=;
        b=D8/wlLoJgzEP9OfIDjcP/mvD0diE3K+8ECn62GJ5gE5b/1iKTJcJUimAzaiFRRCgdq
         WFCRfSCqvGB/rEFC1lMl1VZ51gmAZBbSZDde9aeZURh0ccN+VSkKpikLIdEPltcM05wX
         enjKNPH8ZzW5nn0n7LsnJp85ZWOKlF/jxffwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952023; x=1734556823;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKfxs3pDMj3GC7YQPCyoK1BtKC5bUlyrggnykcN/Mw8=;
        b=AomoHkoKV4OLB/zaLMuNeW6X33wXP+Ha3A7sR8OhEQ+GV8N23LFv6FYrfUpMdP2pdc
         s4d5fkpRP44ZcD2w+NmF0ukK5UEq5MayYFkbmX67FOPIqmYSmDz6dAj8voX4IBUEEHWX
         KLlBkj4VJWXQQ77SNVmL+XHtXzOfh+/DDym44bdn2Ot+CTyVVoa/YHO47dM9XFGpbjVD
         1MQDxhMqOd2yCG+STm4EMwoMLWa0npyjnf3/YcoZlGV6u+3LJv794Zrq5V4bN9E8/OYN
         sAn3q0Qr1rPfNo6nw4H45RfZAyhljRf+18zbDQlh4NK5hw8oZr15PGv/PKy8IdtV7inn
         AJkA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Mew/EA8wgOERYn6H4f6fWWLEWXeGYO2a1tcUWxNP/KVIAdZ+TJvi8ltddlk5hiSBPb6R6M6Ga3MmA8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnS9vBPk/HE54rp38IuSwi4UfnfXpQgNxZTKo8hNwemBQAHu/p
	N+AFu/3kgdNmt1XAqYx6bJ7QC6wC/JKn6LGEtv/1jUqvNAgNxycmUYxpCpQdhCwMiLRd9rATV4P
	oHpGmxOwNKuxIUa2FCXVSLHAE75wyjptth0Qr
X-Gm-Gg: ASbGncuwcRgtpoGJSPLc9+W5Oo0u2Jvj4zqPU3PDf/91IYASds2LNtJwaNJLFFAJk+3
	gWLo2I8lGrl+tXRWyWdRPk3DUGN1HBVlQ/Gc5ygH6TV3g7U2gFGBZL6J/MKXl/NU=
X-Google-Smtp-Source: AGHT+IGiqcJUcizFAGyQuCjc5BPiqK/fm5496Pa//h9SFBYiB9+QTvjnCAELvBpBSrKYiF5MVCjIFkIU1R/GLCyr/Zg=
X-Received: by 2002:a05:690c:6e03:b0:6ef:8122:282f with SMTP id
 00721157ae682-6f1a508837dmr10285587b3.24.1733952023136; Wed, 11 Dec 2024
 13:20:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:20:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-2-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-2-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:20:22 -0800
Message-ID: <CAE-0n52dsQko18bY2uu_k4AFNdeirQ0FaE-k0Jy9=Re_fGV+-Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] drm/msm/dp: fix msm_dp_utils_pack_sdp_header interface
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:32)
> The msm_dp_utils_pack_sdp_header() accepts an unlimited-size u32 pointer
> for the header output, while it expects a two-element array. It performs
> a sizeof check which is always true on 64-bit platforms (since
> sizeof(u32*) is 8) and is always falce on 32-bit platforms. It returns
> an error code which nobody actually checks.
>
> Fix the function interface to accept u32[2] and return void, skipping
> all the checks.
>
> Fixes: 55fb8ffc1802 ("drm/msm/dp: add VSC SDP support for YUV420 over DP")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

