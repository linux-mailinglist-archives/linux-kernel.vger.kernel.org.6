Return-Path: <linux-kernel+bounces-533113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FCA455DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2240D1899062
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB126B958;
	Wed, 26 Feb 2025 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO9FJhwd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85326B098
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551939; cv=none; b=X9N8uSXwZCUvxfMhjgfjbRPRael54t+XIccNtuvT9WsegEMvxBHEmcWwpee83M4sPUi2zXlNf8LsYRGDWBB/9ZUtH1swlGlNocPtOi3iygNxeGPtT1VD5hWjgmahbSFEwJUJzUl6oyowO83PomZFiuodlstIXWrG+Za5a6wQT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551939; c=relaxed/simple;
	bh=krbdbgBp040V7c7NwIs0hD7YC9c4fLyecP/y9S+5yh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0nJVEAUeYz46SzE5bo5gnb79b1Dfwz5PIiYF1k+7jMtr7e/ALA4Vl3Tj8o+3gIr26bt1UMbqx3N9f0zLy2roemYaI1+JLk6rw+Ce4xtuq1B4zTjzJNuCU8T1qmR8bPm7J7709OzzQox42mEYNlxjXF8Oyl1lp23rJXvtdJNsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rO9FJhwd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a59so66794731fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740551936; x=1741156736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eQhnwo64qzkTeX1x17WOeYQbFtEQv505e9/PvxsOZg=;
        b=rO9FJhwdmnP41a4fd8fTT71/EEnaGOkd6csHfuiu3s/0UnVr35+rJRyCk0FYaRkk3m
         maVISsZztOA6TF9tS+g1vqdkg6RmFmHus8yY6K1GV4EqkWuBCLeNL/7UhdUYKTbnAioN
         jXB+jRpWGxgxlMZ6dJa9uDpwNppgej16mytp1qd7DE5fobe6dUjx+yCFw2LRq8vuHhYl
         gI4f5evek2vbKPk5cQUOyZadzzJNaxGSpHkE3NvcYupMhdW1c6ZCQGJ+n+uJn0LNncki
         cRXNRrGDZtBGExfGpIp0gbDchEJqSfL334T6v4hOsZxnhVw+kZGyolihJKG8fO7K/Vtk
         iOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551936; x=1741156736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eQhnwo64qzkTeX1x17WOeYQbFtEQv505e9/PvxsOZg=;
        b=NNXMn55uUhDLJa8CITL2LEPEfFRZZ6YPes+PFMs1D+I6rmjSrVfcrk/4VQ+qkrMbka
         5c/+p37ReRLQjkO9aS+YPupe7gLQz7tAlAfmcjyXgKzcdzQCfTti3phjbpVpf+PfQZDY
         /ecTdSu0Fgw3Xl3WYVGl2JEBtsDQO1URXyqLxrXEt22SH70CdzmlHuov+1O4XxuVdeCM
         1h8RlRiwv52iwl4dkD12rvC2qkk65DxhqidBL+vAArl0OPXELT/+bpWJvgCttJAMfp5P
         oBPw0FbJpSXyBCnE2FGMOkQ7E2LyVHtvqOrdB2pY+20LsAJY73nE8So3PZSMFT4SK/s+
         oy5A==
X-Forwarded-Encrypted: i=1; AJvYcCUOdOcBWXng/2DGI+PLgLfzkpht5ro+2LARheU9sXwGPTmrZF+aiZGWSVTggo5zyjcxWfuoOSZE7k70fcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47wS1p8q5aST+77d7+1Ss/rM2Z62k3Itw3sYxhgyQrhqr+55L
	IfPFrp9/LVdyGWSzgQqAK0ZZrtib9VRX0ELe0wkDL1e2dAd9sDQ2L0pqD0Z8dec=
X-Gm-Gg: ASbGncsgMVLPxcKkbFQzJXuIEiW00+Rp/x+uI2iGQaPPE7svjLr3854PLCTAP4/9bZP
	XlJgNEb+BgRrWK9O1SNlpj3M5Cdud2OPEBoKdPy1p4XvcrcIH7xPom0sJ2cxFFL6sSCRWjU1xLn
	5H9oPpnoLXx7M5lzgKa8GUCMQ4mPOZ72JHhmg1pgwQg4AliEEn+rIJ84f7UhI23Dgv6jzwDku28
	efOxYdmJ2Hne4a3S8V3p2Y60NiN9Ab/IUg1eGy00FrS04+8ZQI0Z+LBDggVteEh2VgFJBmddepY
	vRMf/eNx7a5IewyL/POVTrrqPOXNhUwSHiGFKC9oCRgi9wwvrZWaZ86CI9pmI1jCQVoH4Cfjrau
	vUsNXlw==
X-Google-Smtp-Source: AGHT+IGKe/5S+/hxaWyU3JJxotCQJANZFDVGo4oTgujo3yDICmsxKIIeR9yVtprfkpzB915wP2OM1w==
X-Received: by 2002:a05:6512:39c9:b0:545:e2e:843a with SMTP id 2adb3069b0e04-5493c5b85e0mr2012329e87.38.1740551935803;
        Tue, 25 Feb 2025 22:38:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54852801130sm312953e87.258.2025.02.25.22.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:38:54 -0800 (PST)
Date: Wed, 26 Feb 2025 08:38:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/15] drm/tests: helpers: Create new helper to enable
 output
Message-ID: <du3n464fulvxszzn7hkx7ugljwn2ry44kizhbfruew2etqdxgb@bsbtgntp3skg>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-5-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-5-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:53PM +0100, Maxime Ripard wrote:
> We'll need the HDMI state tests light_up_connector() function in more
> tests, so let's promote it to a helper.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 151 +++++++++++++--------
>  drivers/gpu/drm/tests/drm_kunit_helpers.c          |  61 +++++++++
>  include/drm/drm_kunit_helpers.h                    |   8 ++
>  3 files changed, 161 insertions(+), 59 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

