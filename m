Return-Path: <linux-kernel+bounces-174527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B38C101F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F6C28454E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8381514D8;
	Thu,  9 May 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeSSZTCn"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01344147C96
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260069; cv=none; b=CL9w1rnqx30RGf4zih54NXvJuo6PxgyAnpOVnF2R6+hGxtUvCdTiuksE/KgOxBstSaiVWfBJ1iyAWx5FG7fvgr6SdvIHb+FgRvOLf75zeC5ZkEILJ79iUAiicDhu+mon/aT438KQip13dUCgSWT45DjL7CRD5UwV7X9hQzkuhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260069; c=relaxed/simple;
	bh=qnwFbH6hbNfNo6t7d3oWIOBDIP8qMb2iCaLIEzvTNro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvoxPLM0q0Vm1DkVPbOnjgDSjg2f5K2+FOL3ljUMaiJ8cqglRfK49ZiWjwRrocObaxZqxpYJuQURI1dbBqIduQ3ODVlM5VTtG5Ppdyxd5IzK8JK91jlyR3i2BKWuxow+W4mdI7ZgHsXHmIMf7pKoVhh/Bq0WQdjWPBg+BAiDgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SeSSZTCn; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f040769fc5so401476a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715260066; x=1715864866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/7jv0B6IQSIW5ezeZnjPK1GMhKRF8SPgvddGu3eY8=;
        b=SeSSZTCn063EgJ+jsq7aYpWuvSJ+VyZNlkAOZ2o2rF/IHgl/CL3tGJCcGeZB4e4pFD
         RpHp66j094TZIIzvkwdvJOHxed6Bz/QppeaNzRqRt9hRyE5RmsMLIpglBHWFO4EfHUU5
         Uhqt05EfchKs8U2D3dx4he5UlevUlQ5fymIN4jphaTIBvAeia0vh4Pmn06n4Uj8I5lBM
         080j8p4M0ccP0Xlmnwgi5B1b68dzTk/AwNuLfhA9Nr8wK9fOcUNeXGV0AZYrDwYcAZNL
         DqkN9qp3spp1hKkmCaQwoyPLrwKiAN+hHlt80QMgXaTJSacRx2g2Yk65wyPjspFV+8MW
         AmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260066; x=1715864866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dq/7jv0B6IQSIW5ezeZnjPK1GMhKRF8SPgvddGu3eY8=;
        b=w13xsUuK03M2lJ+hizzeKc6Q5LJNt54McwFyLQaiajCozHt6UHYq2OSiTeapS+/JNd
         nHbCp7n8lX3r6GbyVCNyaqKFJAGm8LLT6gIDGLl/YERAHB43FHXk6z1YbtZWS4Y7StTf
         XurzyrD3zPtgcWiiRk+3oIfIsiEqDPG+uKqbDM7nFlXvMOzPph1j4Q9HkTPMbOk+nvTp
         iKTmWRCDyaJ7cjbkgByXSrsSrBVxmhk+vvfHGkAu/bv4q5sxu9iVbIcjL14wXlZSRGA4
         8LojOY/yfS/TbUYNMZCqYCKsDlwJImsdznLyOMMoAMGWuNW0s7CytpChRK5nYiDF14xp
         QQJw==
X-Forwarded-Encrypted: i=1; AJvYcCUUZX+8C7J+BluRzizlQ/lEqKIfVZZR5o01ICUNwLRQt4IknbvsFald1oPFDeHaC7R0PZsBPHIDo9EamAnMWiAY9rhnptfO9axSShID
X-Gm-Message-State: AOJu0Yzu+KPg5LncDjw87NixPAfWW+U8VHshPPHjdNQpBBJxLFkG/KO7
	RI0XFSxwelJUmK1xaqANsbiE51yGoepAMw5GhBW/DB+6M1+jDj0IH3qEwbs55caFAjFuDp+hRYE
	9XkE+vd0sqit9/JUNNz7IM3/Z5920KDKvtgk1/Q==
X-Google-Smtp-Source: AGHT+IEzWUdmpapzSIoFpj2DfAmoac8yI22Bh1WIGABq6d2/lIZ+FrGwyUl/xliHUdZ6iq0y1VIvQMAuV+fw1Y5IS0Y=
X-Received: by 2002:a05:6830:4118:b0:6f0:7e5a:95ec with SMTP id
 46e09a7af769-6f0b80e3a15mr6185005a34.37.1715260066027; Thu, 09 May 2024
 06:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 9 May 2024 16:07:34 +0300
Message-ID: <CAA8EJppJQOjMOPJYcEfD56knZzDed2ijp6HaQ5wP+UdC4Nw8FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove python 3.9 dependency for compiling msm
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	seanpaul@chromium.org, swboyd@chromium.org, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 02:05, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Since commit 5acf49119630 ("drm/msm: import gen_header.py script from Mesa"),
> compilation is broken on machines having python versions older than 3.9
> due to dependency on argparse.BooleanOptionalAction.
>
> Switch to use simple bool for the validate flag to remove the dependency.
>
> Fixes: 5acf49119630 ("drm/msm: import gen_header.py script from Mesa")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

