Return-Path: <linux-kernel+bounces-256832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C58937102
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74131F228F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307C14659D;
	Thu, 18 Jul 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUN7n3kF"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175980C07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344232; cv=none; b=n+9IjCzQ+8yK/IxoNMf/X7cmSseul9miOT7liQMiLLJGMB3o200j6bDasO0eSJPJGsu4IA8/uA9D3S7tnLLSIQeTnTrzSq+/Evbcrp8ZYVxVLo6vaSGurub2Q1Qrzw5gOUd/2xO3uOy1tX7s0bl1c0BMz9wN6ccbpG00KhtNMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344232; c=relaxed/simple;
	bh=5RsoVd5sliGC6jDsRNW/LxfNCShIK7sBspxYM3SJnoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2ST5e4rUPfipGe+Jc2qGGg7MC5jTPLm9lPf5sp+JWxju2aDnHmOfC1SAwCdtgm47FoBAMotfvr7pOdmszSYIV5Dgqnf/SQX/OqymD3dkoJFqNoSvtAVSO3tjkW/ULJN4qPI3YkOrCEnMrssq1fOPaboPsgZHeolTGRbAM6C/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TUN7n3kF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44926081beaso4826571cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721344228; x=1721949028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8/jfrbQkF4NocC2ktC4TuqIHUerHtNF+x1nkqsRqBY=;
        b=TUN7n3kF0uiVRVuR/Jr9HNKb4EN9WCn3mySUMPX3brqtbq3jWa48lREn4499xLp2iI
         6JX7eXbKOGUSyWpmICFgMWvNFTRFq6AEHP7XNeqVN9hyB/qwScF54mNPM3nCdV5yujw8
         BGSqtW5I0qNvQyBKK+n9dpRJUDbvXGqc5yT3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721344228; x=1721949028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8/jfrbQkF4NocC2ktC4TuqIHUerHtNF+x1nkqsRqBY=;
        b=ETmt8NFD8xTqPSyhyx9kdqHsmC3sqbnOtpDUMoJFGwQ23xGrnMRHFDX9WJFLn3hB3e
         KHRV3DspyhEqvGHYcJ5cUnTh64SVtapgR0cpqYVVU5FI/6gN0HWICS/Juy1MqAyTw9cD
         4xcgJFHgvaqS6t0oiL8CHbgqccHV8R4/OZqQKH7Qo6XkgtP4wg9G9EeDCLeHA0uNVXPY
         geNXjemphZneyPX9cpW8joe7DsP8GEA+t10pEZDi0VLS59xI3H4S+i0/rSbInAYrd9Tq
         CXFZ4IgjRJ2YxxxeZQc6w1XL3IgsrqVf5V+6FM5FDhRIMnqhJ3kcFwz6aIjQsbg2OF7d
         5LTA==
X-Forwarded-Encrypted: i=1; AJvYcCVto5vvPoqYeE7ZJju3WzOlBVflJgshZxLZfB/hqqE6H2Mibq/jKpYVm03OCXx5+gk93Z6o4Jk+MjYNaSw45hnmGfA+kmumSDpmemAl
X-Gm-Message-State: AOJu0Yw6SPRzbLTuT9Vi+GnI6rfXtI2vmAm/ZipL9njjC69KYLL1ehxj
	ScaZR8Vu6Va1Jzx46MNJmPvK0GlP3rpd2IUTkNEVRUmsyeMNqXDWH7HaOkAUFVWbc0Z4bW2OR5s
	=
X-Google-Smtp-Source: AGHT+IHIOomZeM1ds33Hir0dudNe/YU73zw3klGNXCE5f6bOfPMsfGl4tpkG4/fdiLtX8hg7/pFOgQ==
X-Received: by 2002:ac8:5f83:0:b0:44f:9da1:7d5 with SMTP id d75a77b69052e-44f9da11038mr501581cf.25.1721344228243;
        Thu, 18 Jul 2024 16:10:28 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda7c26sm811581cf.69.2024.07.18.16.10.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 16:10:27 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f8aa87bfso141401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:10:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAFVBFYDIkTfClguT3lbzOLQfNvGbfFmlgWFnEuCPs0LL0EJ0ggrtGvqdAktObDopKwaT67fiKWAYlksFmqfxWZlSDPisUyCX7cPiW
X-Received: by 2002:ac8:4cc6:0:b0:447:e0a6:9163 with SMTP id
 d75a77b69052e-44f9ac92860mr946841cf.14.1721344226869; Thu, 18 Jul 2024
 16:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718184434.6307-1-robdclark@gmail.com> <20240718184434.6307-2-robdclark@gmail.com>
In-Reply-To: <20240718184434.6307-2-robdclark@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 16:10:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VmM=Qgm8e-uTF4OMk5-qnpdgb=6fFDFt3v=WCAujUU3w@mail.gmail.com>
Message-ID: <CAD=FV=VmM=Qgm8e-uTF4OMk5-qnpdgb=6fFDFt3v=WCAujUU3w@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/panel: samsung,atna33xc20: Add compatible for ATNA45DC02
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Rob Clark <robdclark@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 18, 2024 at 11:44=E2=80=AFAM Rob Clark <robdclark@gmail.com> wr=
ote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The Samsung ATNA45DC02 panel needs the same power sequencing as the
> ATNA45AF01 and ATNA33XC20.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 1 +
>  1 file changed, 1 insertion(+)

I believe this patch should be dropped and, until there is special
logic needed for "samsung,atna45dc02" we can just rely on the fallback
compatible ("samsung,atna33xc20") matching.

-Doug

