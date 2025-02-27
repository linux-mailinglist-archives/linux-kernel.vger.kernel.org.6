Return-Path: <linux-kernel+bounces-535640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B401A47566
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447F73ACA35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FD21516A;
	Thu, 27 Feb 2025 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4vfKdpM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19831EB5C7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635497; cv=none; b=YpUYMR6i3H+51wHlgcQs+N8ysTN2gK/AduORiFfNiEeJ962iq8IKsQeWoPJCrLso63GZ9dUkc93b6a7cX79ucJk3qI+zNW640PkcwHcB951KdjP1wUx3tzC+i9NlZLFqJLqqCm4Uvtrkpoi6e87lZmqbOsSA8cGXfDhgSc5ut/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635497; c=relaxed/simple;
	bh=GRubHh+cAb1Qj+ayNxZtTMqoz4rE/+FrEX3gjpeiJJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVrL767U2i1qmFL//7h41AHwUxgGRGMiBS5ID0iSL5neAi52b47xnUFIc2PcmMJaLJH74ti4xX3sThTbrGpwlf7iJXFAweQhoPkPyqRrpC1M2ZoV+4rNUbLbp1xaljEiCn6foc1e05mE8vRgxWFrXn9u8CtMeMqeZotEXDxg4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4vfKdpM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54843052bcdso459215e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740635494; x=1741240294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1U19xvVdCKVbh6i51+4ZDFXiDIrMz27FSxrW/i0pKg=;
        b=r4vfKdpMug86OeXLnt80d8gW4VtH+8nr30vRFJVbwid3DQLgQXGBdpK0evwCm/U7ie
         r8lr6SK4QDUFTxlyr3lM8GuQOrwhcyvgCbns+3BJxnO3j6I120xQbdw6L1za5EDo7INh
         Zuq8w9A1pwF3oQ9MM8ehf7r7w3+33vam5h3TzbXsNyRMGdAukh5nk3J9fh9C9XyVnvfQ
         ZswQMDMlz1d/YKMle+f7qJRvemHDwZXMa00cIfRTemvHZQshAU/6ZUf/Q5OgArsmQU09
         MiZvGNN8BFuyTO+zf+FTYLfzsylrUTvcZw8whF96uv7eVBOqR4vMgbbtKJlxaqSywWh8
         b3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635494; x=1741240294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1U19xvVdCKVbh6i51+4ZDFXiDIrMz27FSxrW/i0pKg=;
        b=L434lNsriwD3Yeks3efYWqVmteeG+9aGtPz4dw8Cqwq2h467siNMrE2781EgBL2p3Y
         JOhAjllYyg0TX7q3T80z2kd7RcJLoX7U3iNfCapCBHe2Ocled1FDTeWxU830zKqCVsgd
         BukXeOzrpFFn1ssaSM3k/VI4sBkvzoI5jZ26T4SJdku3By7QowehSlyEq1X66xzRafal
         ps1RBqNuBW9cmML7dPSR078YV98Ad/zpWlKfSQl8girknOfatI9G320VoYHoOKqUIKzh
         7JZkm03IWdM05TMMZNNkS9+q8eTZ5WJOnLBCUHNLP3Gm8xy3yEvjfJZXvbX2pAOwrU4O
         uWYw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Lg3obvOqlAvJDZ/R0sw3cLmTkLEyftugZzJZ/3OBaXhUncll4fcW/fDgjvT5NzmThEYL0SNi1PUMc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF47FrC6UvvWq8yHST0JwckAE8uZIB1HvU0/Sevd4WzfWVfOB6
	1MsPKw0Ra4fUuPNf8QR0/Oy4YTQzEfRnqA+Q6Uxr/F4DgfkMW/iaJlHmcyYK8k8=
X-Gm-Gg: ASbGncvP+G01LFUWtX5wlR/NAnIlkOvRLm0A52ksG6wcabWZU43Rn1M69TdVKiLtzX8
	bUFrN8Gvq3rCjQQy97kZ7/zl/abpitkRTQt6iZ1WfDw1Xi+P6AWEsK6MDaoxsroyMRW0ummRcIk
	xf4ScTCfpJy5pMw5xdVVe+WBQ1FqXJ8hQIPLEAislpHSKphvmHnYTQ+eryokfoWy1KmgGly1kK3
	uLRc51Wl3k3bUPe6B5b2Y9MhZjpIzYiv1d8A/7O+wYVDpc/uzSZY6OspYlBYnrbow3puwRrbrEW
	ZBiQ0PCq3wOz5/31KeCOOuRdY2u+klC/psr5DlKqh5sy181B4Kdk5yvShN/g3N3gPepJghXNDEq
	JaOUuIw==
X-Google-Smtp-Source: AGHT+IGVzSFVtQHVGFHQLcFNQCwlkvUFIDCBs957Ra7OLOtuklfdObqmMHtARrsJHtaIOaTCbUtWbw==
X-Received: by 2002:a05:6512:ba8:b0:545:746:f36a with SMTP id 2adb3069b0e04-548510ed195mr7100964e87.34.1740635493780;
        Wed, 26 Feb 2025 21:51:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b1213sm75514e87.155.2025.02.26.21.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:51:32 -0800 (PST)
Date: Thu, 27 Feb 2025 07:51:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, robdclark@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/ci: remove CI_PRE_CLONE_SCRIPT
Message-ID: <ukzyfymij2yilyy7ofyi3hj4urlrxxbx5rre3f7qg4zgkc65u5@vbutj63ucctc>
References: <20250227043640.411696-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043640.411696-1-vignesh.raman@collabora.com>

On Thu, Feb 27, 2025 at 10:06:24AM +0530, Vignesh Raman wrote:
> If we are not caching the git archive, do not
> set CI_PRE_CLONE_SCRIPT. Setting it makes CI
> try to download the cache first, and if it is
> missing, it tries to clone the repo within a
> time limit, which can cause build failures.

Please wrap the commit message according to the guidelines. 47 chars in
a line is way too short.

BTW: this didn't help with the python-artifacts issue. It still times
out.

> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index f4e324e156db..0bc4ac344757 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -13,12 +13,6 @@ variables:
>    FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where the git-archive daily runs
>    MESA_TEMPLATES_COMMIT: &ci-templates-commit d5aa3941aa03c2f716595116354fb81eb8012acb
>    DRM_CI_PROJECT_URL: https://gitlab.freedesktop.org/${DRM_CI_PROJECT_PATH}
> -  CI_PRE_CLONE_SCRIPT: |-
> -          set -o xtrace
> -          curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${DRM_CI_PROJECT_URL}/-/raw/${DRM_CI_COMMIT_SHA}/.gitlab-ci/download-git-cache.sh -o download-git-cache.sh
> -          bash download-git-cache.sh
> -          rm download-git-cache.sh
> -          set +o xtrace
>    S3_JWT_FILE: /s3_jwt
>    S3_JWT_FILE_SCRIPT: |-
>        echo -n '${S3_JWT}' > '${S3_JWT_FILE}' &&
> -- 
> 2.47.2
> 

-- 
With best wishes
Dmitry

