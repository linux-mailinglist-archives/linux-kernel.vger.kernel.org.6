Return-Path: <linux-kernel+bounces-442115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB3E9ED82B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD56188560E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA97520CCDB;
	Wed, 11 Dec 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsLsZoKq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341071E9B16
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951376; cv=none; b=Lth70G5wq6WGH1E9WHYWrk5Yvn1fN9F5Fyi0r6wmYgCy2Nbbwtb/PHZ4OkZtmiJNrXh6Ay/HTUJeh1k5PHxxp1ocvF5tX9cH/D2Szwquje5SouE2EJZJD0DBlY4JNbHTyH6+nlSWynlfukg6u7vV641HVimLbYWdErZOR1nV0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951376; c=relaxed/simple;
	bh=M+SBjnr89ky9x9KqFq4DMNJhwJdrFehbl/hzoDeq7v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+uf1a0wRv0LmYzjQGli1WzgMBNKGOX56WTZdh3GCK0bLxry9tfiPkeAWkw5T2tPr7xWt5BJkVjxbpnblooHpL8VhjAoWGYeWFrhv0I/AREnwbKAMEx1W6D9vDldBjL+vrvhaRQIQ0fVXLBeWQ4+ebKQLbkt4BJtetb7FybWWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsLsZoKq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so3834994e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733951371; x=1734556171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zbqQN16b2aOiF9wSF0WnEQtgHo51A0jGYXUA3xuNJA=;
        b=zsLsZoKqd72pnw6Nmj8KvbcwLBEDmLccujJddAXkVt4crjhe+G9B8sbeku1Hn8AiTb
         +rW/auWpu78PgjuKukl2R5Axebe31Tp4GNSFbUXKs8CTNt+TA4bqhUkC1heqpLv89i/3
         HyzCk2HvQVNm2wfQ+f6f4M83d1U58qnny2Ilau0Ti3lC0zfCwqql0mnA5yRyfmErPtxQ
         iv4C6D5elBzLEFfyy03QOpIlDd5vdyxelZSjIqeudhluIttbzdUz08c2/TjhJwgegRnk
         3HHJznZPMg+UBephNVq6D0Qlg2ljXVertA8wj008ffjEik71O5S36qfjjfHxeeXmleRk
         AAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951371; x=1734556171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zbqQN16b2aOiF9wSF0WnEQtgHo51A0jGYXUA3xuNJA=;
        b=MI51QYp401IC6O+QcgxDRjBoTCdrcbk95oncbqnNByyPJ+gBfxSshAP8ePXbmoLw6K
         lWoAnDRqDc/KBHEAozJAZGeub/L13wDo3CPQsHmEdV7PZpRHRZRXWTnxR73msyl7NVLn
         jxo+FyAV6IfxE3pM+c6+bnNE5A7ivpG6pxphEKYpl2l/ESIZ6EECLxSI4Blp3SPJBO1O
         lZvZw4bRuUfgBog9QwhcTppQ6EndMFPF8C8TXWYT1eBcoVOgiZEUfcBatYCA6YoZvVjZ
         WTiwlA+WfndGpj/nWgF6icJ9URnQN3ljZmUAp7UkfcJUZoVMrhPin5ac2e/hrkhD1zid
         MvxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKoKxxSuE1xK5z3kYEhHglyBUeoqTG1WIViylztn/+OGwT/wz9t5DuBDJI1AsGTSagljVZdTgm54AriDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdZ5zZBBz2y4RkIW6OF7jmEc7Y+DSlyqKUvyqrB8+pApn+DCI
	xNmbM8nd8ZdmrBMeLGTld5KpfNZcgzyYUS8ydRAHkIxI6yNs0JrZHwBKpMnOAlk=
X-Gm-Gg: ASbGncscKqh2y9Tfu1tGXasEGVf+dYjwtoID2F5nlF13y8G8kwGLpXvOa3Jkof5DaS8
	fBESQFZhhtYiRXVeBmEHEekFhgFqP6cHd+LBjq1esCuZmrpC8WEOAPNPKA8KsEA6/uu75IZ5QUd
	fbickoz3WdTO/iihADYUnqCft1JGXnbV7FFdeAL7wUhcypFFPzn8hk5dWWWW8Yj4HwYQlGHmgWX
	xLHctba5nNo79aJAtOvGAAxEleG6qFXPIGfNVygeSij72pBFdgoQUD+oVJPH10UTXWhezRCgiet
	WQe7b302JbbARF0O5FDq/ormSO3qUj/vRw==
X-Google-Smtp-Source: AGHT+IE2nngXJnaAUtwl9k5Kp0+1aSGdWZRqw4X43BjQNC/SURzvx+f5grBltDBz9C5ghuG1lIXKDg==
X-Received: by 2002:a05:6512:b11:b0:53e:3bb9:5e02 with SMTP id 2adb3069b0e04-5402a60b1b0mr1317831e87.56.1733951371282;
        Wed, 11 Dec 2024 13:09:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3aa94b60sm1561872e87.114.2024.12.11.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:09:29 -0800 (PST)
Date: Wed, 11 Dec 2024 23:09:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2] drm/msm/dpu: check dpu_plane_atomic_print_state() for
 valid sspp
Message-ID: <rggt2smcj547el3bovp5djilydxe5wygqasborwunejihbqygc@xanqsyxqgyke>
References: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>

On Wed, Dec 11, 2024 at 11:50:26AM -0800, Abhinav Kumar wrote:
> Similar to the r_pipe sspp protect, add a check to protect
> the pipe state prints to avoid NULL ptr dereference for cases when
> the state is dumped without a corresponding atomic_check() where the
> pipe->sspp is assigned.
> 
> Fixes: 31f7148fd370 ("drm/msm/dpu: move pstate->pipe initialization to dpu_plane_atomic_check")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/67
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> To: Rob Clark <robdclark@gmail.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Sean Paul <sean@poorly.run>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in v2:
> - move pstate->stage out of the pipe->sspp check
> - add reported-by credits for Stephen
> - Link to v1: https://lore.kernel.org/r/20241209-check-state-before-dump-v1-1-7a9d8bc6048f@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

