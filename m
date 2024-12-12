Return-Path: <linux-kernel+bounces-443911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2029C9EFD68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EF2168163
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380811AC891;
	Thu, 12 Dec 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d13mGZIy"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A4DDDC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035180; cv=none; b=rJafhi8u0kWDYdNw0eZunPEhCAj8zbPKN703wd02jVmpazYFi3qtP6uKh18CIA40NBSCMbBR6ASXQqIAkQ4tsx2umD8OV9DTAe0SLR3UU+L1aEUmXmngERn4Iu6m203UlcT66nsWM6MiOWjfVAuIaODc0J7k4yx3wdap30+l/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035180; c=relaxed/simple;
	bh=NHTrlUxaL8vdfToHnmluTFj/u73SQePE/WFT8/rVGF4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enUHqWJF7/hamtgC0sPPHnwrDqUr8pu2aalyubPlNtJxIogiycbfbViSf7033/oQSD+D/4BP7bmL5b6mgHhZrULLKFdv6nzZIxOBAZVoi86nrhrb2p1hV5yyb3HYA+7ZSjJDtKaa86S2Re6RlUvpk7eyfsMng7t0Xw2Fd6kJcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d13mGZIy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3a5125c024so868654276.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734035178; x=1734639978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHTrlUxaL8vdfToHnmluTFj/u73SQePE/WFT8/rVGF4=;
        b=d13mGZIyUhL40Me3qOHRFB3+wVWS+fRI6TdoYJLgZRvBvHeJScNoYIdUTlODNrasgt
         zZzlxM45Su+vX5YfH5XODWivXwR/dZ85SzJpyI5oYU6iFM54vTBqgr0nRmA2/bcXv0oc
         r3Vu2falqooC7V6597HwEzqmHHKIOeUR71tHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035178; x=1734639978;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTrlUxaL8vdfToHnmluTFj/u73SQePE/WFT8/rVGF4=;
        b=Muj2QFvGZW6F692qZ4UthVHoBxqVQqTKlgitmvpAEAd22wt4j6T5yhLmQKM0LEnQJi
         vsHeivyK/sYd9AwtLhmE2g8kIyXyySPo6TcWkkzNe1NKyoNfuPU6wlme23lzeH05/VsP
         xDLUZPFlbjNfNn8qvNpzX23n7Yt9g6L8RmVFPJ4m2RisneuLUbv8thFDnxyEwonAPCKm
         OaD7MLCJEwFXndIRQ4Gabo5SkmZpyLcmjOuofxKpZSQqzMl0B9awtLoad2ywfLfGUkg/
         d6nk95otsb/XxVQJ+MJSoKSaga1rFA106ecCF6JuEEFW/y89w++pQhWAWWrpVW/TJsRm
         xwWA==
X-Forwarded-Encrypted: i=1; AJvYcCVaUeeVwJqGm2hxXzpEn/QYhQWv26SvviQOV2/UyIKQhJPlEtKDpbKtIVMFziWuSYvZxec0+58LA/QE1Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SPpRzZjWsbygx0+eQa38an/V6yDv3bymN1Xm0UVADBhcG4wr
	r59/e1PhOiY878Vj9BBv91Hnwql54uLtoi6uGTIyRfQHREdzUdCqQNAcVOvvboQV+W9bjhIAdQZ
	9xZkR+peEl3canUy4gfEwiDApKOhOxvKTOL2t
X-Gm-Gg: ASbGncv4sgK5QqSqrhgBmJFSY9uVt/oz+nqnKgWYgELKvY+I21Tl1Ab1G0eMC1783MF
	GjNtQcs9wgKe3/MgU0nWVzAXPegH1auBdy5wPKhCK6PUHU6Zw/OuiDg1vpJhWZ6sxag==
X-Google-Smtp-Source: AGHT+IGs4i6eqssuEGaehVKE7QOtcQ5CB1FUkhV3LRogQBH52O8B55VM3orOmTDcSA3soHh0ekrOCA9i5WdjzCvIzoI=
X-Received: by 2002:a05:6902:1692:b0:e38:b48b:5fc3 with SMTP id
 3f1490d57ef6-e4350ba9a5emr55975276.32.1734035178204; Thu, 12 Dec 2024
 12:26:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 12:26:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-5-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org> <20241212-fd-dp-audio-fixup-v3-5-0b1c65e7dba3@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Thu, 12 Dec 2024 12:26:17 -0800
Message-ID: <CAE-0n50N1m5f5vFD+ZP_DM8FbkTyBYP-VWy=yBNo+yd3_zgm0w@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] drm/msm/dp: move I/O functions to global header
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-11 15:41:40)
> Move msm_dp_read()/msm_write_foo() functions to the dp_catalog.h,
> allowing other modules to access the data directly.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

