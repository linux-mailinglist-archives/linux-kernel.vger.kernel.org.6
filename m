Return-Path: <linux-kernel+bounces-442312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426C9EDA77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B3D1886CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA91EC4FF;
	Wed, 11 Dec 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAQqtacC"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C071F2396
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957688; cv=none; b=ruaD/b7qXaj8IhmZdnwGMTNiwRTUi9czfMcrDIVHWR8jUdMTl49f1rx/V2cdn+4iZa89TKcNxALEQtEt17kCGun8t/5xMDVABqwveVdQAPBMk6zNjxM+CbT6+RS81RuJ6kQsmbouknIg582KfaPGdNE1otWyk0BzxJL+kehzCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957688; c=relaxed/simple;
	bh=RHwlBu6Z4VBS0gNpoSsmbFxwAtZwdYd+jvGCWb3rbeU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wit5XvvDhu2VIIhRFdzfspmFwkIbnu69W4KqvD/Ou3Y5VIax8b4MC7k9y8BuCOGxSWpo45S+IKYErpoWzFJ2vIULu6zaefHNsbYpvkIISglOLDixniNjMxUJRyGno7KUggBmTQCvPwNOHLa2Juso16/b0X5fQrA1caI2CeHzr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JAQqtacC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d87ab49423so78506d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957686; x=1734562486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHwlBu6Z4VBS0gNpoSsmbFxwAtZwdYd+jvGCWb3rbeU=;
        b=JAQqtacCfPzXSST/08Ym4H1CBwnqvBkRARCcHKF8HaZvMyl08jSyeTPU19LRez91Tc
         J2dhxWTrjHYA5g1qPrfklh0mUSuPdy1DFhgUcj1NZQ0N/1uua/gvlJ8+sQd/WFe6Net+
         xmZgGG/PTqwSfDWWQgmwHDYTbhWKxHOjOsn74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957686; x=1734562486;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHwlBu6Z4VBS0gNpoSsmbFxwAtZwdYd+jvGCWb3rbeU=;
        b=moyTHn2UO76bQe8YE1/kQetnfsNdVx50klW356DGfSWNlxQweh1fn/fEV/+Q4FtT3F
         h/jFe1BUalPipZUQGS/ti2zZhjjsTVHsuTKDhqRQm4E9Zd4squ9t010YnAoPp+ghODVB
         oOJ5+Iwb7Y1EVNyMw2fZojJ+M9laobEdvzIwu7ZVHu1Y8SXkDY8huHHlv/NoSNFDNYI+
         jWRqViMBcKw8hm7a6Fnp8XLUhpedbWm3pfLQeXizmNernVSbz7mswVpIVZvRXk+nJBlU
         CRH2wLgZEUFWtmMmvsRhNg5uEys2huwKUx11IxeIdaoNhLnuZp3XkMhu1oUI41mp5L7E
         O1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVjbqgprg1ZwIrcqnZEBjmmWwIuFi/5b+fxq7yg3YFgulQgtc5EWrW6HwyT9K0DQ5yvI9DHaeZ8/ObOm38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFB+yNs7HaC1F0wbsLiioxhLbxTjZEfi3rk5psZRjb0XFphde
	sRP4AvfHbtr9R3kTYuQOOYnHC64X8KuNFcY/2WHR3LX25CcSX8QbTAhwTMp30wllCakohtvomHf
	scVJDZr0IGxfHXGcm63Zy5RRzwFlRGNcg52hb
X-Gm-Gg: ASbGncsIL8qBBvro/tMFDQrQ8iOqyPmOl3Zz4Edhq3pQYoWTQoDCu8ZEx94sWKvV4Wp
	mdJ5Zflp2Hnmbl3y2/DaH1GfOTuZa1vPC54ZwFnOzmkwbmP8c59dMwZ+W17hbpJc=
X-Google-Smtp-Source: AGHT+IEGC9lOWNlVRcNf6fxO1C9k5anq2FzZawxvc9QRt3uAELPSdgB+RMMmxVMt78OAlW3P2cd1g7RFAijwaS3fIQA=
X-Received: by 2002:a05:6214:27c2:b0:6d8:850a:4d6a with SMTP id
 6a1803df08f44-6dae38e5086mr22115606d6.1.1733957685843; Wed, 11 Dec 2024
 14:54:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:54:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-12-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-12-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:54:45 -0800
Message-ID: <CAE-0n509sQEBscLmRCBMBzgYpWX4=62+hKtHcdE-W83LjdcqPA@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] drm/msm/dp: move more AUX functions to dp_aux.c
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:42)
> Move several misnamed functions accessing AUX bus to dp_aux.c, further
> cleaning up dp_catalog submodule.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

