Return-Path: <linux-kernel+bounces-513410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7EA349F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FAB172EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645B288C14;
	Thu, 13 Feb 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQVMx0NK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E5288C2B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463503; cv=none; b=VLSUv44aywroqL7zQBo/kzQ/YXXP8/OcF7Ee55nnYOALjfxW2Wzcc94DcQ7JwWEWcWUrsoFDdhsTkbxZeNghJc/ujoAyo9tPtYI3GqI///PUEJGbwV5KJ80hqrX4wSSzBYhbNwkgXTJISRT/cMfOvQqx9zrR2sP0tek2HHpqa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463503; c=relaxed/simple;
	bh=8FRlYNJ3cuJXDSr7sQqOrKdEQqBSUZSSMCqz1zTh9uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP5zaIkhnR42CbSt+tgHWmq5oxKhpgGDs7Ho4i+e/qfk7jmfKMqe5b878Hxd81EH9Vtlh5lcD3bN+xu+duMDneIeZsjNAeI2Y8ltdxe7uj0a3CNNz/SSw0wuxW/BI8xiwgZXgfF5opLLlYte00FuhSgmCEWT7qWP+RqxkonrjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQVMx0NK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450b91da41so868157e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739463500; x=1740068300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=660cIh2qXJ+vc//CkK5JvvBCDsfnGT5N+OHMNTwvBmM=;
        b=HQVMx0NKuFgz3rAMEmIvd0FgkQSxbwahkZzWaKUSlpuIJMXxLzD1iJoXeYAiu5XhY5
         ydhpWQbA14nB2wP2HnbH4YLG25XQ8HLQl2NEZ9f+v5qXauNmaw90lG6FN22xD41GNVp1
         3jRPbHczfy7CkaWMT/STi+CxWi6rko51yj/6qy30uVghqUEAAfY10ygvmJFnmF6jArAd
         wf1FjTsgWaXoHZJ+JOpoPoDYk2EpzQwpR13qbclKcYY0fKQScWx7KY3lEbRy613eh6hj
         KIUuII+IYmqf0SMSDWO33bxgV4tWMWwhCN3AJgLbgjof3Pi+T58Y8Wy7eVb5trdUOIqV
         DfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463500; x=1740068300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=660cIh2qXJ+vc//CkK5JvvBCDsfnGT5N+OHMNTwvBmM=;
        b=LxrXRCbLyt3CLv7oiCHfhiD+RTdUa5Q7KDD0zpOzq6lFTDOzg1+plENhMJVb44FWet
         LuOsygGRsamHXU8ZfKsePIcLfMQXSbury0yV0NX82dyy4R+LVaAtwLcblR1DuA3Ch20H
         94H4VX16Y6ll+7ZId5+WOKlrhcS35n95OdbchYkhsyV0vu7plIE1ePXxhnNJHJBJYCgy
         zZKSXrGj4ejB3p6X59PzVC8xmraaUraCRfcmVVMi5M0QOM1talFyyaTBQQ+D9xlJpCLT
         dlP+rk2I7k4shRYzrNhxTxHsRkAbH2sqXcIjCO0FvnChy5xuzmqXb1pdi22q4K0buIXj
         byuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNBK8MFbD/o3E5gFKVfsMlq/NzqAxa9LrvW21gMJvBlBuEWvJN+ZUQcEX1jdaKOEdrERmsXa+tf5wvuGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkHKlnDncgi1RWR7OPvmxxvSpZxy5R55BVIX1qe9YL1xS4YLv
	tBtmTJJORm/pBm1esr7Fzok/TpGlUiLDKK3em6/LqZ6jhTtOsi+x0AoRZsZo4F8=
X-Gm-Gg: ASbGncuYHL2dEq6LQn8uQDAj+MkOyag1FPC8xQIgapXsJED9kR2AflquAKUoKC1JOyu
	XGqOnUga8A0RDo3u1OWqsbnepCZvdYXF9YA1HHFOG9n7tVPgNgrK0hs/768MlyxJ1B86dchSGPW
	Dmv4mpu2w+0AS4h/zOLPuxSBIpWfkXlPlMnFKk6GxAEgF1kSH5kX8zFUOcaMrMCqXaQIPFrVHw9
	0h33+HC0zkcb8YECleM/TAXcUMiFGjif/8/7Yilk4eizhGY02SPUBF6UC/dMoZ0k8oFEoZnxZCO
	T52hqu+dJ90h4xy4GSNqub5ohp+Jinr8RUDhS6b5vCWZF174CPaKOW4KtkxQ8RkPZrWt/oE=
X-Google-Smtp-Source: AGHT+IHX4xTr3i/hkeM2pq8heGQs61yR4H6uZ1XyLtjHKcBwLlumouD2n2aSpi331YhaTvIal/nVnQ==
X-Received: by 2002:a05:6512:124e:b0:545:576:cbd2 with SMTP id 2adb3069b0e04-545180de556mr2130058e87.10.1739463499616;
        Thu, 13 Feb 2025 08:18:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083137sm214209e87.21.2025.02.13.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:18:18 -0800 (PST)
Date: Thu, 13 Feb 2025 18:18:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_planes()
Message-ID: <vwkhzuek6g4kmhazk4i4tawbxbnqhe23f2k7tatxkhrwroqjij@qmiuy3fuyxcm>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-16-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-16-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:35PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_commit_planes() updates all planes affected by a new
> commit. It takes the drm_atomic_state being committed as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

