Return-Path: <linux-kernel+bounces-193760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067418D31A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298641C20D88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9915D5A4;
	Wed, 29 May 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQgiv7fc"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8F1E86E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971908; cv=none; b=oJlvELcqJTmyzVEkjQZvYFQAkgxhjsXa+howSHW6gozK7grLafXbyIn00ULRh/KuW/njHZvpnNumGPIaL2rWyZnZE+695Bx2aFqKwqu/ue2ihCgHgcgV+cc47/TpcGsuf8r8Xt+ESITKHd1lmPqBBOrb3JR0nADBEeUNQdoFNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971908; c=relaxed/simple;
	bh=FIHHFu50zC0KtqEF0nrsHQUV5eFyTtfNlZFvDFH8gqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK31feCQX1ct/rOzSGVwBoPEmpGKECDLRGYCI+5IXu5uotatcLf61bEeyO8mgIAm2JS1fTduIUMQRoKLdL+tPBezLqdPS19IHzhHm9uNzwJQqtnDLYrkxSzCF+Pt87W6W8BEKKlXOCLzuhUNUG0tUWfGK+8Q6PZmtpQoOL5nYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQgiv7fc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b03d66861so391335e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716971905; x=1717576705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqrQnHagTsqc8XSpxu+I+AI5vFFrCWmKxdpq/9RvgHQ=;
        b=xQgiv7fcJUpWYxi1KqJwC0ESX4QUdVnhIAAO0cJ7J30olrqJaj7v17Kd8lFnZCMILG
         DpUID0392TCnEFKd+f7h7HHqJyNqXjIEfvdCbEhXyPcDpSLO8ZpZz4OHRzvD8hTOtNcW
         SYGw9TAklX1Jg+hfhvkEa/ib4PFHec/O9F/Gq8rClXmxlC4A6olFvXKAb9urS4fhZzEt
         tGigLUK4v7JvivQHzrZxVkIpsMd7rCLfaVQhMciLQS6TAI+5cUVl7hButS8q1AxHRJOG
         eyBcnk39iH73YVk0OTHDIJTj6zWlLjVTqalusphb0aoXLJ4HeBlI4/kuR0o06W/qZOAu
         +y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971905; x=1717576705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqrQnHagTsqc8XSpxu+I+AI5vFFrCWmKxdpq/9RvgHQ=;
        b=E7cb47xnygNgkCGZBHPSqIdOvcMQYUhqIfnQZI4Oa/ZlHk69Xnno5W+9xthMo6c7Dt
         PQkaYURWIhaV473GUfFFxAXpVPndPtrB3L4icG7Qxv5VlFdb6IutJEY/y8CuVVslWowM
         hLBEwl0uIXuP3gumPnK5gITnpH3y6QzYUkaZjriBWm7jkGHX8CnRsqFpBHaj/k7FXs9Z
         UqiDHIR81jCqOKvjKZ/CEOjjp57vXmaajP9OaGPQJppV8MmyRoYFhGfBKhCU3d1j6jbM
         HHMBn2FgEwnXTTZnaapA7X+GHKBh5r+YCCyor0RIFSiOZurZ1Gk92daJpfQzhNygd4rX
         MIZA==
X-Forwarded-Encrypted: i=1; AJvYcCXQGOJKAOBJ6cKjYh1cw1r/suew9QPPBRQnMhOi2wBv5wWCu/iF2PGqrCVBzuQpYGS0g0ZWqqLmXnm0jEXpnZE3AzW/b/9YQ7WRT7W2
X-Gm-Message-State: AOJu0YziTbkJdD6kCQ/kHjMQ5ndPfU1BbqkA2umRgSZU70TIKrCahi5z
	CxftXsxhOJUOjZj9SsNDwBlfBHrPXJk3uhtDh7ifmnqy6CKIniEA/v2H2PfKGSI=
X-Google-Smtp-Source: AGHT+IFxNS9ivx6ftoot6k7b4A5XcOe5Biw65h+SXYi89WIc3qRRrD3Vy3EqpcmprR3+hTvfeKjCOg==
X-Received: by 2002:a19:f613:0:b0:523:ef21:8e2c with SMTP id 2adb3069b0e04-529664dac67mr7731487e87.51.1716971904911;
        Wed, 29 May 2024 01:38:24 -0700 (PDT)
Received: from eriador.lan (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b3d918a5csm59684e87.257.2024.05.29.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:38:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Caleb Connolly <caleb@connolly.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	kernel test robot <lkp@intel.com>
Subject: Re: (subset) [PATCH v4 0/3] drm/panel: two fixes for lg-sw43408
Date: Wed, 29 May 2024 11:38:22 +0300
Message-ID: <171697189027.975427.12036219693814257280.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
References: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 May 2024 22:39:17 +0300, Dmitry Baryshkov wrote:
> Fix two issues with the panel-lg-sw43408 driver reported by the kernel
> test robot.
> 
> 

Applied to drm-misc-fixes, thanks!

[1/3] drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      commit: 33defcacd207196a6b35857087e6335590adad62
[2/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops as static
      commit: 8c318cb70c88aa02068db7518e852b909c9b400f

Best regards,
-- 
With best wishes
Dmitry


