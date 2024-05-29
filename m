Return-Path: <linux-kernel+bounces-193615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002088D2EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AA4286AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AFD167DA5;
	Wed, 29 May 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKCcpFy9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6175167D82
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968640; cv=none; b=sqJeSTjk/OyxKnptuL/uTjbQj67I41tG7M/bzPlfn01CKP4hR/pP7EGd8XmJKOUaXsOwutU625Cjm7yosLBOcVKLPeU8B3c7F6B3ArkvT0Gzmp4xpFOhmqWUxkLLsLnTJRDnmAZC72W5/omqsgNpQG1foFmtmV45XIo6ghJ/ifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968640; c=relaxed/simple;
	bh=+QUSnP/ngwbPQEWBZkzfhpGYUxEWZhbTwbH0REe7wBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEXh0ztDfQ+PWqt3rdtEPqRdsylikJRBoulS547uwlIKibbgNc+PbAF3yStFb0WjNGLS4AAR+FscG9oe3dLbq95vkRrrJKcwTHmrAIjPRLVr53hqahsv78mxg56rMRivzGsSX9ftyDk3xDsn1dIs0P2zrvCv33fQwmdqIh9Twk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKCcpFy9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b119986f2so273658e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968636; x=1717573436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
        b=YKCcpFy9OLhD3ykiha37ntqiOinXhwfbb+L3n+JNNIAINNliTIqZC3SLZo6yFOUK8f
         uVCq3UUficore1l2+t2Dx9eg9U+kdBDkOftunUnE4614+wVe75vkEGZJhWfarjZQrieV
         dt+FGqoEAcEb0pZAh4LTWFEkDmrIsYn+vfZp0Otk5/ZuGT81m2Y9m0uNcD8bA/tx6+aw
         Bygc0BdiX+EgqYnfKgV9l1sNOKeAOXstJIUO26ixx+4PdcTIlUFNeJ1reDouiiuKTb28
         9b77ylNzFUp0Qk34+SjUlfCKYkcx+6nTKnTaoWZQCeUwSFkozYCaZkbjbJf9sEbXA5eg
         JqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968636; x=1717573436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka2Maam5Ei5EuRcb2P0MO3/hFv2w3w7reQQ7Fg93ZTo=;
        b=wV2fV/VkoH2t6ncCzD/RcoWuJua5dyX/kbhs6ON2ZOtK4YeDeCVcGkBiyTMEwqaVzt
         rS4ophSqY14DA/IfXJGmpwaBVgs/7OHn/sGYWvX4Lo8kkbrcvHK+J6az/OoPtSwORqew
         WGC7ZpZJOo9YDxK+/m8Um4SvzC0HpJrlxuMiBDWQvbzedesPi9zT4JiQxpmoHJsAEPO+
         buQPs/Nn9B3PT1hfaVJjoBkRCUvbt5sRVM1jH/n83HPjhOxZGGQop0kGIs7zcSP2vAuE
         wUHQ00JHMceu9OasgxTsd38eaf0Tkikv/PnIGQMEQp6NDkmhPCaYU3eqerBhpfG4YaBG
         tm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUSZX4ZMbtP2juUlVLIYuoN4B9jOcdSq5sLUod4fdpcAIqjweIJHfQiBYVjbubO9DXyWIkLdbNRLm7YslEykwQUWiZbfNYDcKs7+eCD
X-Gm-Message-State: AOJu0YzDU7iNda2t8ux08ObWGSObqFy/lo5ZnZ28XIK8jvdUWf9KpoBb
	qfUgx0Fhngd52k/HlZNvj9HUBnLGwm4oyh2abKIVbhntDMelvcJVUwgxmKF7pr8=
X-Google-Smtp-Source: AGHT+IEpKoJxeYMMRmRHKz19pKO8ijGaGc5T6KYCnRuUNFgdev3K9Yfz0P6oPUoZ1/TYqG8Ww0hnig==
X-Received: by 2002:a05:6512:3241:b0:51c:df1f:2edc with SMTP id 2adb3069b0e04-529644ebe8cmr7988541e87.2.1716968635950;
        Wed, 29 May 2024 00:43:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a50b1d85sm978336e87.113.2024.05.29.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:43:55 -0700 (PDT)
Date: Wed, 29 May 2024 10:43:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] drm/ci: add farm variable
Message-ID: <xhdcswueynlctjznqnxo663v2k6q2lrk55jjdodrkd7ojijaiw@lg3e2e5qcnny>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-3-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:45AM +0530, Vignesh Raman wrote:
> Mesa uses structured logs for logging and debug purpose,
> https://mesa.pages.freedesktop.org/-/mesa/-/jobs/59165650/artifacts/results/job_detail.json
> 
> Since drm-ci uses the mesa scripts, add the farm variable
> and update the device type for missing jobs.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v3:
>   - New commit to add farm variable and update device type variable.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

