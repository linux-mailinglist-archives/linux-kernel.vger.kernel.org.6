Return-Path: <linux-kernel+bounces-366458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912499F59F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD09F1F22B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C630E20370A;
	Tue, 15 Oct 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mEMS0OG"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4708203707
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016970; cv=none; b=l0qDyPogBXhSbeuieS29rscNGwaVgnJq1MNPZ2gCeTXiDUd16WZIRlxcuPz+XCnq3z5v34/h7Wsdh/gdWUwJvX3ftMWoMDmu3eQ3GaJ1Dlva2M6x6cV1oR20cVej6fta1uwF0e6uDvlIJdCvrA1Fc7vIfU3FYaGU3zhXTcyxoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016970; c=relaxed/simple;
	bh=SgSSB0A79/lXmp7e1L5p5kJysoGd8jXJgdaDGKjEpII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q05dXkETvTNecjS+3PvRCBqNEEaO0UZNmAstMLvqPK6JQhatyUeC1Nfyw/Nox9AJ0eWkDfCajLIAaKRlNZ2NuN9PVirwa1jD/mTu2g+JX5Th+vWo99vO0m5+kk/tuO+0FtCOsmS0FeR+9P16QjIfUO+XgMyxyy87fWp51WSnccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mEMS0OG; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso1106815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016967; x=1729621767; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsx3rVKk6EHdFPE0feA0DgeAupvx9NOXATe162zYTy8=;
        b=0mEMS0OGEJjVEpQdYodTeE0q/DGZjI/0qDwuExi7qB4+TCeqLnQjVJw7RdiTxuopoY
         dWsnN+ZM4WbQroVwzN93seyawcOJJd4Rm4eOXc2f0G7CkrhFnYJyD36TJ0c1LYHmIyeX
         BOKU2RyWQr82yyPciPKyy2CvvNcIC4o595Mh9NbZhoBaJCfrIRIdod++BUpgt2P0o4DG
         cuS4FeI7vbjV3BzZoKZWzqQwzZRCgGNBhgnBmFd8hP1o8X/rpe8KbcYt6M5phuhL0Is5
         zsjnl6iTVRXrJHGUigRssPD8b0FuHICQnTmUBXKbVq4FWCaa3JKdUT/FsAkCFepO58AW
         INrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016967; x=1729621767;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsx3rVKk6EHdFPE0feA0DgeAupvx9NOXATe162zYTy8=;
        b=iWmSNcBHB5BBXPp1XJzOVkHRIH+MIRoVcJmPW1YKf5zGLic5WTdPGEmE0oP0bMTr/2
         zZnT0oQPsQZ9y1usUN/3GhRn9Cc6ZJk0poXpf9on29XbjHr2sKL0PKB3zubWUUqoGdg4
         fDKtHOkALIZZ7IHqqueUa+9LLvn+xPnE4Ln1PZV+zWZk9cNd7dOJEm89j1rVAWNdhV47
         /HlATV/jIRLiYbTRmtGxXcxZuIWi8MvUI+o5oYaeNG5PlAxz0C4SsG0QXLaD5T7+dHmG
         +oU9KMwDuxbeSJNszFvyl31rXEq99Ct6YfmBN7VUGuaxAS8lBF3hUAfG0oJeizWjYdLw
         0Djw==
X-Forwarded-Encrypted: i=1; AJvYcCUiQ9lgOVuwhjUMDG39zpVeecIpc7HTsUlopzq+ws7XYsGvt5hEz5+bPOxiR7V1qZDUv017GTjHAzl6qfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmW3V0ngOc1P/htlXjWK5Q594U3xoy7oRiLzp+DIKOiwu2blv1
	ZuIIAVrR5e5NaStzRjjah7vTuC5dj/vEA1z2PcrGEG1ukr7SVQrEzE/xS9QprZd9Ss0PjZePpA5
	gNmSXeVEBWU/ZfoNP6z3nfe3d0LYCwmuBi/vG
X-Google-Smtp-Source: AGHT+IHYZhCaFHMFZvkhdJXYDWIOjpmUHlhAQ02PJI3HGXk+yjx/FbcIgWVnP920/c5Dg1cimfTpl0cFaJ6Ky3iSPoY=
X-Received: by 2002:a05:6e02:550:b0:3a0:a75d:8659 with SMTP id
 e9e14a558f8ab-3a3ddffd5acmr185295ab.29.1729016966751; Tue, 15 Oct 2024
 11:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015182745.1012684-1-irogers@google.com>
In-Reply-To: <20241015182745.1012684-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Oct 2024 11:29:12 -0700
Message-ID: <CAP-5=fXanbFKK=mYZJc+prjyO8wZhrdquELWG4URYksuSaVtEQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm: Fix separator for drm-pdev
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The PCI slot address for drm-pdev should be a colon not a period. On a
> i915 GPU I see:
> ```
> drm-pdev:       0000:00:02.0
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Possibly:
Fixes: 055634e4b62f ("drm/i915: Expose client engine utilisation via fdinfo=
")

Thanks,
Ian

> ---
>  Documentation/gpu/drm-usage-stats.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/dr=
m-usage-stats.rst
> index a80f95ca1b2f..f56ca58312fc 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -56,7 +56,7 @@ Optional fully standardised keys
>  Identification
>  ^^^^^^^^^^^^^^
>
> -- drm-pdev: <aaaa:bb.cc.d>
> +- drm-pdev: <aaaa:bb:cc.d>
>
>  For PCI devices this should contain the PCI slot address of the device i=
n
>  question.
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

