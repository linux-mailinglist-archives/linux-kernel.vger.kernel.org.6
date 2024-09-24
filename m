Return-Path: <linux-kernel+bounces-336600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76618983CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E29D1F211B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7945005;
	Tue, 24 Sep 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYr/ejGm"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640E40879
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158577; cv=none; b=VNf896ru6Dl7xCT5lFp1VQq3UqRQ4LpscMTJe6Lfr4K0iLa/hppQWf5XiPCqucJ+DNJCKNrFL8il7vRywyZZ0C68/edplqbB/PztqYLEDGHQm4RcD0rUdNdlPqrjZI/xwBIDsfz7d0UmJgcftKbEymx1Cxu2a3jRVqnFIATHWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158577; c=relaxed/simple;
	bh=UWkBmgjGskvL8GNtm+Gp4JAUuWrilvjBC9MJ9j+d30Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwRL+akV+VsGbVRghBDn+jNAQLPlKUcCt9BkDmlatkWMkoA1fKeLdl3q+COEI1wbPAsUt3yp1TGDc87DLY/uiFSR7r33cFB6rWEQAkjT/QGs7LZTyNwDX6VnPSttZ9tIs1WdhMMEMya/DEqQEk7o3Txqh5UjXeq7nieS4jpJKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYr/ejGm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e249807cf13so538937276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727158575; x=1727763375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
        b=BYr/ejGmuqNAT62wgFzI47R26keNMk9vLsHqH42aF2M0vXmEJcJAzcvC+ZlCUsoPQD
         PBc4Skfexg+x5YgfpMEmHKt9pvLdL+p7poyWLOZbhLGh/kxFnNHjAgqfAOe+FRHhCnWX
         yXCNKJ2CcVRq/c0lnuvt2xQmJlKSOmm/nkiqtMbrVkxHa3aM4QCfuA9D8FxD+KJLdsZw
         K7l83tVXCfXsK4sDkePNF8YAlTcATbVBCDNtLyoMuDLpxqy5wVTSX0YgVotciInua1RU
         /mSOxzvJ2/AF8d9fv0YFczIRIjQp74AGcsRtkMR7BYig04UaWxU3assUm3U4wQCVzmuo
         j2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158575; x=1727763375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
        b=VYULKiDuxZkUxdsTHeGtqkygQbN7WyYCqXwbDdUAsigM9E/kcxcAZepp37zsLyx2JD
         2+Bd3kWsGSHI0SQPtEqN/KGMJ87CxO5Nj1n+0qhmYjNNKBiKT0QBqwdQYEgOPD3EnFgv
         Tntw2eSIDo28iBZXHwFz26XNV3NmHP0UMo7aGgSfJFe7qjENLssZQCYG3EOlATtlwbYq
         8Nf+/SoE34A38meDMPZqba8DwxoOWOIXFi+TJNihblCtspUiKOWwgj40A9+8/Ma630By
         cebEd/Qnv5MhOJhFXhSRLK+cfSdz/1BkTu0I9W137BEqS3unYIV81qjA4DywMV0HtGlP
         fQJg==
X-Forwarded-Encrypted: i=1; AJvYcCWy8FPP5Uef5xDz5ORN9ZmdnSTO6AGrFzhemhYsjNZT1fKJLP5sZZ08qATPAf5a54/zrnxYss2hhYzbYZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHda5ycvf7P2/0mF4366lRzyG+o0zyM/71q7ZJwEcA2d/Fi7M
	tFSgYamJnXNiw3qYS1Y6LEfjuLeUy3ZAZq9GXF/YMrm2UBcdHjjJg8L0hQECf2MQQ9zRaeYIWx/
	HqJog3oseBt/G9JHVxaPG6t3pFIIfitxEzev3Bw==
X-Google-Smtp-Source: AGHT+IEF5j0JkBVAgP1jTlkYufGIlKJxFTmmd49IaW+yK41rQF/NpMRTMvOPM1xHJnDTOa2dEHhH9wuEn2USXNPEeWM=
X-Received: by 2002:a05:690c:89:b0:6b1:4948:f689 with SMTP id
 00721157ae682-6dff290379dmr105980107b3.34.1727158574971; Mon, 23 Sep 2024
 23:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924022600.1441969-1-vignesh.raman@collabora.com>
In-Reply-To: <20240924022600.1441969-1-vignesh.raman@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 08:16:04 +0200
Message-ID: <CAA8EJprUUUc0iDph-HPrW1anrdnzYju7+JERQdHbwxvznq=H4w@mail.gmail.com>
Subject: Re: [PATCH v1] docs/gpu: ci: update flake tests requirements
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	mripard@kernel.org, rodrigo.vivi@intel.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 04:26, Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Update the documentation to require linking to a relevant GitLab
> issue for each new flake entry instead of an email report. Added
> specific GitLab issue URLs for i915, xe and other drivers.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  Documentation/gpu/automated_testing.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
> index 2d5a28866afe..f73b8939dc3a 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -67,20 +67,25 @@ Lists the tests that for a given driver on a specific hardware revision are
>  known to behave unreliably. These tests won't cause a job to fail regardless of
>  the result. They will still be run.
>
> -Each new flake entry must be associated with a link to the email reporting the
> -bug to the author of the affected driver, the board name or Device Tree name of
> -the board, the first kernel version affected, the IGT version used for tests,
> -and an approximation of the failure rate.
> +Each new flake entry must include a link to the relevant GitLab issue, the board
> +name or Device Tree name, the first kernel version affected, the IGT version used
> +for tests and an approximation of the failure rate.
>
>  They should be provided under the following format::
>
> -  # Bug Report: $LORE_OR_PATCHWORK_URL
> +  # Bug Report: $GITLAB_ISSUE
>    # Board Name: broken-board.dtb
>    # Linux Version: 6.6-rc1
>    # IGT Version: 1.28-gd2af13d9f
>    # Failure Rate: 100
>    flaky-test
>
> +The GitLab issue must include the logs and the pipeline link. Use the appropriate
> +link below to create an issue.
> +https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/ for i915 drivers
> +https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/ for xe drivers

drm/msm for msm driver, please. Otherwise we can easily miss such issues.

> +https://gitlab.freedesktop.org/drm/misc/kernel/-/issues for other drivers
> +
>  drivers/gpu/drm/ci/${DRIVER_NAME}-${HW_REVISION}-skips.txt
>  -----------------------------------------------------------
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

