Return-Path: <linux-kernel+bounces-513471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9EEA34A63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A406D7A5F28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498424A06B;
	Thu, 13 Feb 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2jfwSdK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1781FF7B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464764; cv=none; b=uhaZPBYGlWiRj7wfLxjxwseQIKGmPXOZ9sO41QvRKeTT+jlbIjjidtGhAKQVrBQ8Fjttbjw/B9Jw83C08iHpO890WfoO2JWHgs5oL3Zm/ltW+zGjY/PJ7rVqJUnVjO31iIFS3fp0SRKMvSCTP5taVYwNqMXONjRNNvCnacmzVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464764; c=relaxed/simple;
	bh=CUqVGCohJ87m1YLYS0Q3or/WzleH6K8IP1zLSzCUlqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka8ceqcXe/75jz3oVOxy8BxvFb65TnhGQff0ieyY1A2rCkMF7F5yrq/HEhs3Qg513z88BR2v76UHnXREZOZKxUtG+xSu7v8yNTAoYZQbZHMLSGxHArTfdt02PqaxKqFgWdCJurcwSAiIA3aPUfulA1vY+faYTYtzVQaA6dX50OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2jfwSdK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450abbdce0so1076833e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464761; x=1740069561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rM4Bt4PhDhPQUeuMylShfihGVwM3FjCJfHKMCS7m/I=;
        b=z2jfwSdKNQUA1Q6vL9nVDPjSo+YOvQW5j/3/nYrxwiaBDbqozOiqzfgESqGr/OAbeg
         q2fFQrOFnLrITd/Gl+sXjZ2Y/iWTw6NZRAY0oT5oGlAKwhQ0+T1NmLVZqIxbrg09tDQu
         +8g4XwRC1sRwK08PDNDs3OfTEvG5WXrQqyZwpjCor11CT364W+SvAcT0fj1lEwNwm4Of
         JvBjgolOLq3QNPplOuKJQd3a2uAqiQmZVsD/QqtZtBDrNkLPPW9fCDsGO3DEwQ1l3cXe
         mUz0nNQeZBcmprnFsiAPjA5yR9wsQs2UO4s7EFhpGlTqpDG/zUM5c1NGTNJ7LupclaOS
         Dw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464761; x=1740069561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rM4Bt4PhDhPQUeuMylShfihGVwM3FjCJfHKMCS7m/I=;
        b=KaJZMBsVfcb7O0ZYipbYE/jcMM/sIblg09NDAHQpKmk2DrOuYJe45Zi+g+6AtcQsVU
         i6LCTSGOqh0w9qUfJDSJQg8dV7RHS7gKYX8aS3ByxE6Vaq39dm25swNy+oz8vip1fmxi
         sGcFDRrWw7jZsAuWXTVdCQelTOTR5ERDu7Vl9UALr652cqxsBFicG1OGijfTF0hHji76
         0ZxvH05pruINQvvcRG9FYBzfrYSidHiEyD6KG1u82Au0qGUPoJftxRRLBNt+QxlnjXyk
         ij3vPi7YpxJk84lS+dmXL9AuBQUxQkJ8MORZDVrrzk+8vuXZYNk8tlTS7rMf2hd3GTWu
         r8SA==
X-Forwarded-Encrypted: i=1; AJvYcCVizGoCcss1KeYzYSEKH3u2IXABxyOBHhOanjK9Q2Pdzzz1TITBF6YW06a3sf1wnVJ18kHaEGHA24yXRJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynAjRdcz000WpxX7Lwy/fgFl6XFDVYGvbgqJ4ZpZnG1H5j9UBJ
	OMcCyb0hCdE8is0UOKyo9hBuzUKrJhk4MoR7NdW0108T9b2jdEToN78WdFw1JpE=
X-Gm-Gg: ASbGncvBkqgAmviDrCv09H1JAXV8hliIz914MhWpvE9diSmEq5Q+hsJtiMyHyP5GQHT
	oh9aZToxjx+DP3MucBcTVwGwwTIPQEXfZ/7JznxXoNfMAhtBoUwA3OlUxwsnD28dnD/T61GHIUP
	8ZTguGMWlTD9I6sR2O6/qFPyt0TD6nNncHCtmc/yDIMsVWP6qOU82nHcdJSibJQfQzTfqns/jAP
	EfRgQwEw4F06DXoIcAl/ChVPehTcgyaQFK9pSHTv7cE7V6EKy7YinkMpzzZ2b3UUhrj7XXky+mj
	ZSODs+m4Nm8hofDanRxp2PPXXvVWslYX/kEMq7IWsPQbXM2ZW85DvwHL5ErwUHJYEqqV/c8=
X-Google-Smtp-Source: AGHT+IGf17bKGu+1DYlb0j/jvgsMwXNXFwObJA13sDP2bt38E796iTxNMVbR5XUvItDk5swObX1lsQ==
X-Received: by 2002:a05:6512:1586:b0:545:d08:86 with SMTP id 2adb3069b0e04-5451826ea05mr2938515e87.5.1739464759138;
        Thu, 13 Feb 2025 08:39:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083266sm215554e87.43.2025.02.13.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:39:18 -0800 (PST)
Date: Thu, 13 Feb 2025 18:39:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_writebacks()
Message-ID: <ec63ymdlluzsudnv6q4raeihtegezg4mfcbjjufg6xce5ljmjr@5hnpo3dc5hqk>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-20-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-20-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:39PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_commit_writebacks() updates all writeback connectors
> affected by a new commit. It takes the drm_atomic_state being committed
> as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

