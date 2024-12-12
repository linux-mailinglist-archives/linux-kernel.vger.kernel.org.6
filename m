Return-Path: <linux-kernel+bounces-442792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106019EE1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB891674EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9E20E014;
	Thu, 12 Dec 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2vpnqAQ"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3020DD62
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993550; cv=none; b=fhVfkzzOWDKGNjpgnKpum1njnZfQ9NEmLfbix0cQbQ8pdLfrzCDF+PQOvnVfhm6AVXP+XDUusT4uBsHpwUPSYBqfmqfIP7F19R/R/lEgWzxuCfPTvfPR4pdma+GfUZtxPrb8ZL/QH/fQ+YA/+KN0Fu8idHHqHCNNUFkXog+U7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993550; c=relaxed/simple;
	bh=N8A1LAPfEi1fYfnhkG2YMY5LQLbZ7ppndxjdGbFuh48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qjajpb3X+CkoRByj00XllVldL6dek0Nno1bxlG0dMblwkqbGX4DP3sVETjyOTbIRCsKMAuHwCob+g2ijgRdyLGvsGD/kgVHno+TP+iaKQtZez4w8fcs1okfNXWZN1hHSrK6ra22yiQGqaTV98H+/ZjA9DYmpa3OvFMkkvPfyy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2vpnqAQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef9b8b4f13so2776897b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733993546; x=1734598346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBYYfU/SUdPVtHo0D4rKIxqkiR1eC0tO3k5fmat0Ujc=;
        b=o2vpnqAQXhyZSbflXvWyYVVk8M7/qFCho60/iZ3xagv+k8aij2xGTGvveY713pTPfP
         Rt0X9zKV/vNIXWBnPUfHpHm9ftRV8k/XSCneGOaI39I+had02Am2eykz7ztNMDQ68KMJ
         rjL80NtFx14Af0EqI8y4QluXt61JjRQOULacTaGHyrtvGfI+EIXsNKj+gG38zf15dy/1
         ry5AAlFKURsW7hLz5sXKMDsyVIJlKZXz8PMzTT9RaiVed7UoC5B8XrpVKXs5xap+7+7V
         h7sNiHqTHWUo89u/TSDqq3RGILIKuQUVTYRzWjI7aDL/2H9vaqfUqDpV7yUGP3I7wAxz
         zFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993546; x=1734598346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBYYfU/SUdPVtHo0D4rKIxqkiR1eC0tO3k5fmat0Ujc=;
        b=N66sYE96UyUre3AYkEYit9j1zIxRYPSAX61v0pVs+OZjg9rsJTuyvGq4vwUjKgMExz
         vzXPIN6WhFugk748XrRscI2ouMShJkgUPgdhga17oZTLzkXcUfVqbh61G+Hu5n008N7h
         5wLAO2UuFJaP/uRUtHL7rPVRKjiNOatUlksWwg02v9GhXAPNvTj5jJLW1RMaSwSWF/rw
         acuOdkCNbgxNehQh/j65VB71uFshjrGxk2/b4bqPiRBtthcQgZie4YjJsKhrGV9uaiRL
         7ZUF2NKVdNcZHqyiai6sxcoQABVZZrxBPyzIu4kfIXYcI3WArlxB0/Eg9n2hVXe0Z9m7
         ACbg==
X-Forwarded-Encrypted: i=1; AJvYcCVhRkS7jPAbs7/fQdOig2GXCOQAS0pFAMviNSprtteP/bYWfFRZg/NAOC87W0vNpOWvNQS+qSAa9NRm8V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNUw4XXlYOg7OSiAOG+pKIOR//dOnkuolBPJO7WobC2/ch6M7
	ZiyarR9u1kFN6s8EvNY7G6hDz2ZZ/RhQGsXya7tTxIbM5yv1PadIeWvfimmOKbH2KyaGrrS6QKI
	qltlGaVAKs1TePR3QsSWRCIdfMDtCnDDE0c90sw==
X-Gm-Gg: ASbGnct8Exsbn0IPGrJy5u5Xqs9W6E/4X/8nOaRenYpLU2H86KFWUyRqSx6mJEPIyP8
	qVw3NPgAq58/oT41tQF2sPzKHgP7ZZPs89Q9uew==
X-Google-Smtp-Source: AGHT+IHkVQ1Yt+kY8VtgAgi00tlSfxYbOT7T8OOEuC4FleojTSZwOUMMM2zASe42MRgtPnns3I6Kz1HZiopK744q4ng=
X-Received: by 2002:a05:690c:4489:b0:6f0:237e:fc4f with SMTP id
 00721157ae682-6f1aa5f58c0mr24536087b3.35.1733993545838; Thu, 12 Dec 2024
 00:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
 <20241212-fd-dp-audio-fixup-v3-4-0b1c65e7dba3@linaro.org> <c5090fcc-d7ec-4d49-aa21-8d1aa7f6a1c7@quicinc.com>
In-Reply-To: <c5090fcc-d7ec-4d49-aa21-8d1aa7f6a1c7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 10:52:16 +0200
Message-ID: <CAA8EJppOjAjFVUFSEXJMbJ4aV_MvzpeTuKDkL7P+t_Mw47YECw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] drm/msm/dp: pull I/O data out of msm_dp_catalog_private()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 04:59, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/11/2024 3:41 PM, Dmitry Baryshkov wrote:
> > Having I/O regions inside a msm_dp_catalog_private() results in extra
> > layers of one-line wrappers for accessing the data. Move I/O region base
> > and size to the globally visible struct msm_dp_catalog.
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_catalog.c | 457 +++++++++++++++---------------------
> >   drivers/gpu/drm/msm/dp/dp_catalog.h |  12 +
> >   2 files changed, 197 insertions(+), 272 deletions(-)
> >
>
>
> Fundamentally, the whole point of catalog was that it needs to be the
> only place where we want to access the registers. Thats how this really
> started.
>
> This pre-dates my time with the DP driver but as I understand thats what
> it was for.
>
> Basically separating out the logical abstraction vs actual register writes .
>
> If there are hardware sequence differences within the controller reset
> OR any other register offsets which moved around, catalog should have
> been able to absorb it without that spilling over to all the layers.
>
> So for example, if we call dp_ctrl_reset() --> ctrl->catalog->reset_ctrl()
>
> Then the reset_ctrl op of the catalog should manage any controller
> version differences within the reset sequence.

The problem is that the register-level writes are usually not the best
abstraction. So, instead of designing the code around dp_catalog I'd
prefer to see actual hw / programming changes first.

>
> We do not use or have catalog ops today so it looks redundant as we just
> call the dp_catalog APIs directly but that was really the intention.
>
> Another reason which was behind this split but not applicable to current
> upstream driver is that the AUX is part of the PHY driver in upstream
> but in downstream, that remains a part of catalog and as we know the AUX
> component keeps changing with chipsets especially the settings. That was
> the reason of keeping catalog separate and the only place which should
> deal with registers and not the entire DP driver.
>
> The second point seems not applicable to this driver but first point
> still is. I do admit there is re-direction like ctrl->catalog
> instead of just writing it within dp_ctrl itself but the redirection was
> only because ctrl layers were not really meant to deal with the register
> programming. So for example, now with patch 7 of this series every
> register being written to i exposed in dp_ctrl.c and likewise for other
> files. That seems unnecessary. Because if we do end up with some
> variants which need separate registers written, then we will now have to
> end up touching every file as opposed to only touching dp_catalog.

Yes. I think that it's a bonus, not a problem. We end up touching the
files that are actually changed, so we see what is happening. Quite
frequently register changes are paired with the functionality changes.

For example (a very simple and dumb one), when designing code around
dp_catalog you ended up adding separate _p1 handlers.
Doing that from the data source point of view demands adding a stream_id param.

In the DPU driver we also have version-related conditionals in the HW
modules rather than pushing all data access to dpu_hw_catalog.c &
counterparts.
I think it's better to make DP driver reflect DPU rather than keeping
a separate wrapper for no particular reason (note, DPU has hardware
abstractions, but on a block level, not on a register level).

-- 
With best wishes
Dmitry

