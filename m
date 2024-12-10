Return-Path: <linux-kernel+bounces-440519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9E9EBFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F7A28376B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77422C35E;
	Tue, 10 Dec 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWP+8Wkj"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA11EE7BE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874943; cv=none; b=HDpMIcYzT3D998RiOZxjvlYH3TbtcmUZgtBpytzFeXucbxHqz1+bv2ghuzAYqVkgc429agkcgpODZVNytaQkyzeqlajqI0/YJOx0pw09IFFcccLS82iFheEKLlx9v3xAdUak+r8G5XIWtZ7zpAeduTL01czd6KwC6YfgOGinXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874943; c=relaxed/simple;
	bh=Q39/uuM60p2kxsPp+I1UPBqTH4q2J3WxmrE76ksQnz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYUzbVY27xvyvyl6apYd5OrL8sv0pyDEO3BRK+puCL6C5Tq4zwIRW+fKowokPm32S9Y7UoOdvIajbhJdVdYPPDktOsxmoJaWBx9/Qo97Ot9Y6DlijtdeD/xrrBXklY5Ogo9CskRjQg8BIVxzj9DtHG1b/xTnNB0WuJ1hrdJ5XA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWP+8Wkj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540218726d5so2262615e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733874939; x=1734479739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaZTccrFdwBnijOAV+VQJ0MabSTqdmlDkCUExpbfNic=;
        b=IWP+8WkjEuE0vChARPsKfkzb/MsgWyCGr1uyzX7igbvkIMbU3jaRhVPuJxvqOBnpXH
         G0NmFciIKiH21CLgW1NeldDgNpFO486v824q05KOa5r2H4FzjPleBH5FBEDA/PmYTz9N
         S7EqhNjrQgIfj0u+HzDZmoTBx1jrmX++yz3ARub2uViE/6Wn3LLKPQYk2jHzEKxO/0hg
         0j0om4xWfBfgEpbLvHIi1QepreLP3aADQ9fZ2PiJmzrbodPy86yEpzXfsNqPAJN9/COy
         FUpC28sOaIcq1zy+9C4idU7YsrG2Cvlm9KG2nQgsKFfmRiljb9huIdk31aqXTwOPOLwU
         r8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733874939; x=1734479739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaZTccrFdwBnijOAV+VQJ0MabSTqdmlDkCUExpbfNic=;
        b=MkOMrJj6OiKtcoqeK3abJbE7anBxT2g6buoQkjL6u1CB0OhCQyAAcetxOeGJXEjO7j
         r6llPi1+3sL2cc8bsEdPYFhXtcB8GuaoNciWZWmfQ+EXfFbatFAaL6ymrkn9I/8g/8dD
         WJ0udT6E5rZ58nFNo0IBwv2Tvb3lp+zFwPMeuy97wViKVkSTYY9KYNY+rhpDWNWcqbW/
         v/XO9yUOaBNqSM/A3SUG+BaTagpJO3wiy4HVlz04XqwVFOpSEVyN+fL5ox5g0YY7BXR+
         5hnOwd5OTLoWRjyao4Iwbn810eiktq4YcPEXEWkgdqRamDWN8Y1iyiTno4abn9anjL39
         gGYA==
X-Forwarded-Encrypted: i=1; AJvYcCXDpFBzCIHuBBKJXErZ0BM0zfzOSZDq4LYMwFwudYz2kpbee3dGN9/nebYPVSQx4JmIT6G0TvScopFZFQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbdz4Wyd4we2ufneg70ijeRY7i/CcfnQLICfF/3L4bSt16+NN5
	WMixsoQheH88elNFHGJpMYmZvhKGizMaoa+2k895Q1iX2T8jc0Gx/9bAR1HULC0=
X-Gm-Gg: ASbGnct5d4FMTKTcNHc4agVZjeODz68SMS4voN9macq5na3gJ/c1tVl9zssAzhNEALQ
	LhNsBHQeBthtYgV5MkhGbxyy6y/Dv3MQJ1TRs+73zpCmbfYEskA7ruuwZ8F/NysRplwiHALBmQ6
	7CZ7WKZQoE3yITbtM9yz7kW76VaydbuIvXxb151VRTxQBaUbNx8DVJt5uphYeXyBcSHU+dB9Ln/
	MQXI2LwbIuuuNpIYQGhELq9M7CI8njqjR/hYGUPe7YIVJ/fIMcKCfftWkDts6OrboLGLXoSaSXl
	vA+bM45nXPr1XrVjCxCUHvjvLZKR10uv+Q==
X-Google-Smtp-Source: AGHT+IEqR0S7rTS9VZY7JOisSWbtpL7N6GcbvhCke9+P/tEVld1+jhG0IU1pO+4oYFJYfFY5K9gtWw==
X-Received: by 2002:a05:6512:ac8:b0:540:1dac:c042 with SMTP id 2adb3069b0e04-5402a5d6c4bmr171539e87.8.1733874939550;
        Tue, 10 Dec 2024 15:55:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a5360bcsm1065405e87.174.2024.12.10.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 15:55:38 -0800 (PST)
Date: Wed, 11 Dec 2024 01:55:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/rockchip: dw_hdmi_qp: Add support for RK3588
 HDMI1 output
Message-ID: <vpy4foezirdhci4nvl5j4e7gf5dey3swj7xxzuzazzj6uhqnls@iyyhkpukb7yo>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
 <20241211-rk3588-hdmi1-v2-1-02cdca22ff68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-rk3588-hdmi1-v2-1-02cdca22ff68@collabora.com>

On Wed, Dec 11, 2024 at 01:06:14AM +0200, Cristian Ciocaltea wrote:
> Provide the basic support required to enable the second HDMI TX port
> found on RK3588 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 119 ++++++++++++++++++++-----
>  1 file changed, 96 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

