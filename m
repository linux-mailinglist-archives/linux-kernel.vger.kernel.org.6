Return-Path: <linux-kernel+bounces-184090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00058CA26D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855AE2821F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948411384BD;
	Mon, 20 May 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bAPnp4Sp"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDB11184
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231534; cv=none; b=sWlUJ7c96ms1EYbnfTiHcYImGPQSjzPshlgjsf6HhK/xcUhCsxhBt1T2rzcrYPMIMzk3cxHxRiM8zqrxE7jIWLg81jA1OQRxyESWjk0VJGj96si4sngqCd1c/MxA/E2n2fR+NCvXaGA3Qt7V1LD/kyb1wpaODK2dwEAy/zbV6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231534; c=relaxed/simple;
	bh=fBnCjpKJ7CF65HGWNGXJZSrAbDCCX00X0RQT571Lttc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gws6h/9KYOWh+S28/7Si6JgOurc8G3iLeKQdeYPd7H93OxNIZgGVjqDFcwlWKUO+7II0PhQYQNi9hvPPf9danYTmUr0jfHw3WKNR8vy1SKOcFhZj7RFRyP3gC9I0WIqtSssTmBJlbwMtPIZZ2AYSZLxrxCkX06+mLlnsrFQIQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bAPnp4Sp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43e0a5e3c08so20529201cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716231531; x=1716836331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df0l1z5z3FCtw3Ch204FxFA5rR9YqNy64rwyV2fw88o=;
        b=bAPnp4SptxmoFbRkuGl/PzzDsgHaUGsjy39ofUdnmmyevTSzfewDziz6/Of40xjtzg
         l35Dfp1U9E8PyIfqd2SkXywtz6vesOwcDLdGFmRNBawkiqpzo+7cDVsWeCvKAfoZqH43
         BbIm6em4fSGrDT4pEy3jOT22IXwqXiod+TU1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716231531; x=1716836331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df0l1z5z3FCtw3Ch204FxFA5rR9YqNy64rwyV2fw88o=;
        b=xUWSt1TSqIKAMR8cF0YjNtZcEGQZQeWcI2zGEdO5T/AJbfeYwq0OBa3raKGo8mCsE1
         d3SNOdeQQCDjkDFeC6cl3IiMn9q5/Vc7jmPkQU8S59vcJn9SvT+Bfzi1Q770Wmmw//QJ
         6X4jttdhj7qeiIxjvhkPKzCaCtgv9NTFkDvURYgBOrjfCYYLxgQWAMMGiQqhkHexOuay
         w7CV4yqMQulSBKCrup0xrL9zGt+SiNHwHrNpJO7T8wkYeuWr9nQ6XmwPT0TsbTAdTH8J
         tGiqWNzSfFXaG2gioScNPSwDJpHChwDne60q/cxhd843slCZlW+q5Z35OGBYkZflwe6T
         sInA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7qFL4ZhOobaZiqepI+iOETsJ3Z2JvuQ1ouOdg8r1RylXQvc24Yvk3zkOyLKw9xg7kaknsPxTOvJhv22n3xKSJQ3iyAkcoC3S003k
X-Gm-Message-State: AOJu0YzavS8w4f2i4eBxjnXWiWmP3NZy4BKbCGJZXpYarmtH4e+WajvQ
	DBIunE9YRc2L9TfQytyM6Ix0XGgUF2zTxOC+w9Q5jxCl99wfbFsHdVk1BMtJ4049eGYaoSO9xpM
	=
X-Google-Smtp-Source: AGHT+IHfKwfNpdR4WsLAPFOHhpvYawTecsP76HEnxHAia+Dz0c18WUMloAFv0aUVYAd3LFsz4VnYIA==
X-Received: by 2002:a05:6214:4598:b0:6aa:cd1d:1fcc with SMTP id 6a1803df08f44-6aacd1d24a1mr37224936d6.56.1716231531170;
        Mon, 20 May 2024 11:58:51 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35c7e4cbbsm52502536d6.128.2024.05.20.11.58.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 11:58:50 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e14f0bd75so489041cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKFgMb4Yacl+to9jc+cgT/PlEPtw+XMnOe/fSHrd/HRJzi/bs9raQDAUBynQrefM+xnqdLvPYHs/BXTr8grMZtsfme12Sk/HFdNGre
X-Received: by 2002:a05:622a:1918:b0:43d:a002:b with SMTP id
 d75a77b69052e-43f7a91b195mr5561141cf.9.1716231529626; Mon, 20 May 2024
 11:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 May 2024 11:58:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us-459kG-h1xT2+ffuSGuTLJ-UrJBD-5seRh4jAeHxmQ@mail.gmail.com>
Message-ID: <CAD=FV=Us-459kG-h1xT2+ffuSGuTLJ-UrJBD-5seRh4jAeHxmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove python 3.9 dependency for compiling msm
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, seanpaul@chromium.org, 
	swboyd@chromium.org, quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 4:05=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicinc=
com> wrote:
>
> Since commit 5acf49119630 ("drm/msm: import gen_header.py script from Mes=
a"),
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

FWIW, it looks like the commit this is fixing is now present in
Linus's tree. Is there any plan to land this fix? It would be nifty if
it could somehow make it in time for -rc1 so I don't need to track
down this patch every time I need to build a subsystem tree for the
next several weeks...

-Doug

