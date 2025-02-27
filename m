Return-Path: <linux-kernel+bounces-535578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89BA474C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60D67A390F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8C2222BF;
	Thu, 27 Feb 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJk3wNCD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF921D5B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631067; cv=none; b=fQ0nkAN6gq30vx4DqfbP3GGcdxwySYsM7sZ00aeQxsWTnd9BMX5lKZX3RHlGtiUIxvVu+T0k5CYzFGefMbfUhQuO3c0q9h7KE2aq0YQ+n9Mw33fdRaAqRV8mY8pYJJ/VK1dk6htYqx/MRqBYzghI923f44UX05gevD5SsNnSADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631067; c=relaxed/simple;
	bh=UAKk9n2MgbyCZoN+0ucDNxhrBHryl2KbQSyyMlhtXZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYZVHL4CtmKg76hslyOdkzM41Pr/6O3rVZfSFcDqM4PmLT49OlD+5/AgkqCtn8vAIE8JXZWhfJ5JnH9r2Vza7AyXQoEG1+Ib3EyWU+Y1h7yeG9EDAOCvM8cEj7xtgNVnjQSCBjof2lhS+wvPrZmHrnAUsOruvUdwpN6jbJJ/vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJk3wNCD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54605bfcc72so1943359e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631064; x=1741235864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRdSFJ0y3J8w0/MIT9m/pNCngOvo9+w+cz68lIRPZQ=;
        b=qJk3wNCDcBenA1zw9NZiXPn9QcJU6ef9qZhEJ2OKo1L6PuZwO5qpiNI3RXRs2Di0LV
         7VSdDJzVQbvAk+hHWQanPtaPqj1ZfLoAF/jUNDt6fXHLoZSINSt+bCSC4q4OxeIOFio5
         sBYSKxpCl32ywjmUFNERgyA/zix0nUV6bFkBj64D1UmZvO4SxNUdFsnIuuNvpbgnQrA8
         8NDoF8Ca/jgveY5pEXj76PtAavMvv8kjJFlF7DIB5xjbi0T7n91I3GqB7LeB8aS6cP9o
         XMTUFaa8ZfvD9DQONqWmmbJqXHnbkkTSg9DNOzDt53qKG/wqBZgYxFqHFtT5667fq7kU
         bHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631064; x=1741235864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYRdSFJ0y3J8w0/MIT9m/pNCngOvo9+w+cz68lIRPZQ=;
        b=bLVgVoWtyqtUHXPfMxLQlpgCiYPiCxD19kFxw8PC+ns/QzwFrX8mjpZgx6qveq62uv
         ROyM2uzq8ebE0KMV+BXGODW6jpQe/hktSky9Vckr9a4L0Qu5dymNCHmiIhLKTFYbRhS7
         c0WrZCL91kthc6kSl1N8/KgvDbBCaV1AMgLnAh7jR617ZhrToFfEUb7TafhRmfxfKtca
         YE5uAhyQClSJDLEikWYgjT1FclH1VPCniKO2ZX718KNfHWnnfw6OjfLVDgTgCgxH1Vv+
         hzWfsEnjoDKFn5R0oMYwVYUe7yzv8kptIjGIFxy+YfhpJfdvvPLrwsT4+hCwlXg2fT9m
         fQmA==
X-Forwarded-Encrypted: i=1; AJvYcCV4/9D3JAbR9DWR6QJhwUEQcE1Ud6vec39/mtZ2xi0RJCUKjkynyWRM2bU/Rje7rv9l62WiTiyXS6EWrbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4oNjdmt/D8aoZkSPobTOgx9ueeEDwr++PUGLlKtavNwge5NY
	6Ct8SX99ebvbVaCEirYmsfro4KRqFzbictJ+6k0D0A20kIrlbPfx/azSuoyIs7QcsGsI6rKOTj0
	QaNTThw==
X-Gm-Gg: ASbGncteUyweC0nqc+MXu8YhQUUoPAH2dFYgAgPkjFAoGV2rBVK30Uy3/jIucJvoilC
	GiQOkGUniDEbkaYJyO4VNtJeCtXlK8lfZTys7J8v7h1PrBmt+XzW/A1jmDL/tVKIW8HWE3OOM64
	umgdtacjDPmHmIBXF2GcHVGrAr8JzmG/BhDfwgmJPpQaiG7u6c5ySBWgx+MU6WGx7ixlzeNlP91
	MR132Tcp6fB9/RznMj7afyKMh4o38Nvpc4vv0JwGpXeXwta/gPZMpaPSXGzs5gCZNZPmDorzjDF
	PpAF6wWpuLRg+wvy3KKJUR3q4ZM6vKy5P/dEwRSAZA==
X-Google-Smtp-Source: AGHT+IHInNYeeu7RJnY0u41TSawSb/sSqGvIZ8wxvnotJqXxQ14P4JT9/11iwOVMUCOL38JGxUNb9Q==
X-Received: by 2002:a05:6512:3054:b0:545:5d:a5c7 with SMTP id 2adb3069b0e04-5494330bedcmr587647e87.21.1740631063830;
        Wed, 26 Feb 2025 20:37:43 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	jonathan@marek.ca,
	quic_jesszhan@quicinc.com,
	konradybcio@kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Add check for devm_kstrdup()
Date: Thu, 27 Feb 2025 06:37:24 +0200
Message-Id: <174063096227.3733075.13590017200932514746.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219040712.2598161-1-haoxiang_li2024@163.com>
References: <20250219040712.2598161-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Feb 2025 12:07:12 +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kstrdup() in
> dsi_host_parse_dt() to catch potential exception.
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi: Add check for devm_kstrdup()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/52b3f0e118b1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

