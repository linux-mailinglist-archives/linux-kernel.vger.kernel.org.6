Return-Path: <linux-kernel+bounces-339255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89769861BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153B91C26C10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944661925BC;
	Wed, 25 Sep 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fua6v3jS"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAFC18C927
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274798; cv=none; b=itOKW9rCQSsj19DzlRiVs4G2LVBPsAkF04ChOx9G7f1rHV6Ce3UT0AezmjZTHyoNbh9dVFiSWStJDvVwZ5Ec5jnfU5fXn/I6jDUDYLryEJ8Fmj3fvP29ubYWNorrjBQt+PtsoNCUlzuM75C4w5v807JYqq1xLSZGUc9CvRrXFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274798; c=relaxed/simple;
	bh=YLTenKhS3xLclYZc+EScAxbqhF86plf5qeJH856RvYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPvdP9mLYdfNsj9MPsTsZ+p6To7dlkLYARci1gbjKvrwuswV1SgvGbHO1vkAGja+TakyNKLlyWPC/yEygUbRDZrCJQC4FFeOBparbu4ZR7YGp6m3aquVc1RCQRD2kOQ2KxyfoRcXDonefP2kpsYA96osSqbLUsWvZUEhsZbq2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fua6v3jS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so8814178e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727274792; x=1727879592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65VA0NQnFRDpybsCtjHAkUveWm0YvCe5g8L8mRc9rpA=;
        b=fua6v3jS8ahFMYpvu16oueagMTwbBv5gxvDvxwToTC3Rm6gvxprDL2njOnwBDVT6oc
         FXE/rUXYoItI9vGU1m10/cnNH4t7RC61zGQQM/KrJiapYW7fybTIVrJWGbEFcnHgBVOC
         nj/V4xW1l/knlwtbFLugDHbL9mQN/23uufeiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274792; x=1727879592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65VA0NQnFRDpybsCtjHAkUveWm0YvCe5g8L8mRc9rpA=;
        b=E3WYxy1gTlynxPPoxOWAn/uGVAIsry906DwrmF6KPaFRFo0Sv7HosDrdwV34KvfiJb
         7Pztst1EO0M+3bnG+d2pOf28ZIctKlPEpHk0vpgUjeXXYdQ1wQZBb5ECBddpO2uTZMj8
         1lPm8EcA9baBHUpve+wWJui4lZ33aC9Ks09g0W/qsuq1e27IF2XiSK4tXH8GDgtdzA/L
         18n1b5LJZW9mxCd9l46fDAi7B6bhcUW4fJXC6vAGzwW9ZMTXWThvg/JmVaPcBNiGRmRM
         UAPievXMQ+fWRlubKaj63W7AxudVk1N3Ix2hF5b5VOgofNyWOTqk5gBc9UNPL86hPD+k
         zskg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6sZhj+bqzF+oBMHpxsw3Dn+ui/2mjm5uOztIfI8g1ikPdlVaDy/+z3SFpu6nPYrZXFnAG6h7GJUODag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDsrTmDNkg16MJ1cF8IE4KEgwffHPfrRt36l3TSxtkw7WlxIt
	a8EZHELtwHTTkSfRVbmQqMz+Y4/EiMuM3z3EF1at8Yiy8iiE+WqRBoiBWgPBVAsz+cPflLUUxvn
	SZA==
X-Google-Smtp-Source: AGHT+IE49gZvqp+YYfvoDl83NxZmFVGGpDXxjX6BOkl0Et9bzX75vCvvYsLkrnRNpanlm3zjxcc6Lw==
X-Received: by 2002:a05:6512:1110:b0:52c:e393:6634 with SMTP id 2adb3069b0e04-5387753386bmr2207886e87.33.1727274791552;
        Wed, 25 Sep 2024 07:33:11 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864e178sm538231e87.290.2024.09.25.07.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 07:33:11 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53653ff0251so7831419e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:33:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGboBMEo2sOQxXHrLlLWoOEnMxkSa57sXKZzkDE7K6GkhMbjvqF71LS663sRerRwTPjlfS1n1BzbcQqi0=@vger.kernel.org
X-Received: by 2002:a05:6512:33d4:b0:530:ae99:c7fa with SMTP id
 2adb3069b0e04-5387048cec7mr1901357e87.10.1727274789474; Wed, 25 Sep 2024
 07:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925080003.1250448-1-tejasvipin76@gmail.com>
In-Reply-To: <20240925080003.1250448-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 25 Sep 2024 07:32:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZJCvLJMmx45zgfruNfRKSMndUm7X5DWTO=7MVmMpO4Q@mail.gmail.com>
Message-ID: <CAD=FV=XZJCvLJMmx45zgfruNfRKSMndUm7X5DWTO=7MVmMpO4Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 25, 2024 at 1:00=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the elida-kd35t133 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Added back bytes that were removed
>     - Replaced mipi_dsi_dcs_write_buffer_multi with mipi_dsi_dcs_write_se=
q_multi
>
> Changes in v2:
>     - Changed mipi_dsi_dcs_write to mipi_dsi_dcs_write_buffer_multi
>     - Cleaned up error handling
>
> Link to v2: https://lore.kernel.org/all/20240923122558.728516-1-tejasvipi=
n76@gmail.com/
> Link to v1: https://lore.kernel.org/all/20240917071710.1254520-1-tejasvip=
in76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 108 ++++++++-----------
>  1 file changed, 45 insertions(+), 63 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

