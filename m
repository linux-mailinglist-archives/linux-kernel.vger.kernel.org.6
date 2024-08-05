Return-Path: <linux-kernel+bounces-274705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD4947BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C938BB2289B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641915B10C;
	Mon,  5 Aug 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="w71qmPXg"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A07158DDF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863507; cv=none; b=DaeASR53Y1DWztJ0NVHVufaMEiX7Z5MIN+PU+T0fD+KCObwpodQqfq5YZ5QyrkvC7Lwhk5ug7YVfE+bHAb8CV4oYOJbcomnnuO6P13W+ZImtW1RT8zFzt3hAOxX+YpVx923TmKYz/T+VvDQHMaANpLwRIpM4X5V5L01/n2K/WQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863507; c=relaxed/simple;
	bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQDjZw1HbyyMg774ppwXZpVjcFGSYgwh2qlhwS3d5P4a+Ou9vIq4iPJwrwAa351e+N936Lh4rRqougFFY6HMlc7WVQZMr9GAZ0zlppVsQsbLfdQytfBJfMlgzcfZAWawXzGmYw7kyvDYoehT6XkSdmbjJU6a5EG/5Ox/e9q87wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=w71qmPXg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1da036d35so627224585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1722863504; x=1723468304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
        b=w71qmPXgaug5g1OfG+OLLabwUwyb11MCZI8GS0Mlhe0+7YZlYLSRcPEWfz7iADsZwV
         MjMqdAp6U326Il9TRJ7veVsFrhcJkuUysr1J02HjAhUrcMTYL1Pjpn/ANnWheBnYWJRG
         yUTUXqXlkr1yUY7PZjAwng/SDvzZBm9rve7mHnAREbkKyLqYJVf1sZmpnUW80qPceFld
         371Zdqs68A+TKw1xZRFKaYnqEuWvMq/B+MOnIMutSnWTViwRFYvHDO3ARiz2DSaRxDuu
         XSgITE70NukAI4QVIkPtkpKfVQ/sycnsu+7jDK/UMg/tpA9pahd2SXq0lU4/gneUvAVx
         x9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863504; x=1723468304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
        b=dK3dWsR+VtQwP3kuVD2Bl1Q8B+pXTnwHuSTypOzPjnfOjVUfHHduO5PTUUv059hP9p
         RQtNmwso1LpuaqZuACG0QBXKtwud5xJKtqeB6314vGZj262vA/5HFDIWM0mlXar/GwXD
         Z/nO1Km4XxZrAejI7tHiHnAV4k/2GorGxsZHdHqFbwgeo88llamEsZy8anBWji2HIHcB
         CoHs74Rr8dKshIMyUj13YalqVkt+DC2JLrgur74n576R+q93QE0wFYRfR3NeBDZfqKsf
         cN93Pqcl7WKPFPn/fxCuY5HA9bHAqGgokxlyDf8+2sGJj7tWtO/wVzpCbRxui3A/ADkf
         Nymw==
X-Forwarded-Encrypted: i=1; AJvYcCX3j9quHrir64Syc2SFhbe+k6rd5PGrEh4EcddQWZ1avIrOGZptYQzFvJrsEjb6WfyKNIMq67YhbAzPzQK6YY4CO+MuRw/Dc9PVRFWX
X-Gm-Message-State: AOJu0YzQdEVFkdIx2jTEvF1EGSZD835QGbgzksXHvqWb5w8U4Lx5oyBu
	A/v3D1FS3eHwpVQQ571gOPH0ncIv8fSbtdS2IjDoIvPtU/2j/R02KqjtBzIWjGWE5zf4Alncco7
	py5EhIGmmTkMUaeITCkHa6pnrnIBilXBSX9vKfg==
X-Google-Smtp-Source: AGHT+IF/O5ePVsP9F9/4LdJgMcHnbAiRBVz6rWucn4L0+VzzRP1U+YIN/SKoA9Ocbj/mAccdLjT4/BuXBtCo084/sM8=
X-Received: by 2002:a05:620a:24c6:b0:7a2:e6c:41e7 with SMTP id
 af79cd13be357-7a34eeb959dmr1463955085a.9.1722863504285; Mon, 05 Aug 2024
 06:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730021545.912271-1-vignesh.raman@collabora.com>
In-Reply-To: <20240730021545.912271-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 5 Aug 2024 14:11:32 +0100
Message-ID: <CAPj87rOYVCG2A10ruyYan9y6NmMY0fUM6Z5-9ht7dEp_THYmNw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] drm/ci: Add support for GPU and display testing
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	dmitry.baryshkov@linaro.org, mcanal@igalia.com, melissa.srw@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Tue, 30 Jul 2024 at 03:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson G12B (A311D) SOC, the
> GPU driver is panfrost, and the display driver is meson.
>
> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run tests
> for both GPU and display drivers for MediaTek mt8173/mt8183, Rockchip
> rk3288/rk3399, and Amlogic Meson G12B (A311D) platforms.
>
> Update the expectations file, and skip driver-specific tests and
> tools_test on non-intel platforms.

Thanks, series looks sensible and is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

