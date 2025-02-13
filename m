Return-Path: <linux-kernel+bounces-513469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD40A34AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E76B3B2359
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316F245B1B;
	Thu, 13 Feb 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7mMABg1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5A200120
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464741; cv=none; b=ijVac5vC4kxEq5uydf05uYQnevXlWw1Njudo7axv1p4iJPfXsmTlasgtWCJ/eHWw+qRXjf1EkH0xnJQphk81vDclvWFEReRwH3nYNkRBbGglNg4cqV0ReCZ/PKcr1B0skvHHff5v35NigpgjtED4gO9mKwxpiY5BP6S/7Xu2rhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464741; c=relaxed/simple;
	bh=44lcaXE4mZbp9Si6IyKQlcNtz9jCXuk7kEcj/Gs1qyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGyZxVdyyECB0e7LBlNxvHxOzYIiGFWjY0GtS4Gey6FDmIskZMS7Ycp2JbTn+zijftpeVu2gbPEf5q8Tc84xZExRiwygd9wWkincv49bVuOOnjaUSN1GxEjtjtR24ppjVLSjKVeGNJ6gySWA+BRF2unWVQ5hRYsa0XW/9IMBYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7mMABg1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30795988ebeso11666821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464737; x=1740069537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25pk+Y/rMAdCCmKfH8WB0VaWkCY32GRlTZdE3DT84t4=;
        b=u7mMABg1PPlkwVzBotvvwfGSldnE6O7OT/xh8cqFhvjDu1U/iCOkrvsC4ETb4LPpjb
         9HrFvCxn7m8VvuPfQlIzN/RrLEVfh+kjJZPU1N64baLRP6/mRrbUtmgmhQFNIoZHBiT+
         prwYWKqezo+R7UGCjYJuOtjGEt/tYXALggg5cTrXeCvqKC5RurrGewlGhOs2IZhtyRCE
         C2zjbWA9QCHLrYAyoo1rWoIAD76hHTxIKHY5yejZp+2yZuNFabmZ0I4K1KGRxRIqnlM8
         O+tPSVfxQIR/Z0gV4Hjvb7L1KYhKJ4iFLucoz686dtMiT4FUjWWCmFAEj0XvoFRJ5VcK
         sNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464737; x=1740069537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25pk+Y/rMAdCCmKfH8WB0VaWkCY32GRlTZdE3DT84t4=;
        b=c7j7XqOuqPemeDkCU3/n4SibFmNBtHOi3zQ4EJXdn4vjPPDEI8KIENS3l17DoEz6Pl
         fNreVS0YDApl02VO57k8DOQ7PCqgzD9Fb8R41K6kjuEc+9q25oHviod0X2qpUA0+Oxju
         mpyMxmjrRu7N6jVICbMYKO0y1g0Qf3ibSSM1GLaFrbFgHxLhktoY8vJT2lpPbIcuN3VJ
         v/XiDCYMDTWW0xe3KZxLuGI/OdIqUBnDHVpYDNWG2eBLilCML8VEYypssSQBkIo4+Ge+
         GQTKTOW35c03L/AtoIQhs10sMwQV5ZpPCA9kmeNJQN0hHGcnHh1FqP3kDhjwrW+6MSmO
         216w==
X-Forwarded-Encrypted: i=1; AJvYcCXCUok6dCxJ6r9cBhfTy2ewj3agmwcBRvhOVNW55HGdiXoaTA7hjnFhQ4LfSSipzOX68IAspU0YRe0UsOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzmdbPsiHho01uz0sXgaE/EV06IwybZU01illLZ5GM8a5OibT
	8FZ3eRsR0dBKPl7UaIMmDnPoKEVC4iXr+lk7owsEFLTRGUrOGg+46eU1vp2mhhI=
X-Gm-Gg: ASbGncv5BNv5H9qSiu1G9Dt4bCa6RUhNnapL/bq/0ZYSu/5jHDNrUn+mQSywnwj5zm9
	qBnFztETqomGoQ3tuZeou0GVEXnRou9tQTt6LIZWtUbxMHre5VFUYiXuuLLq9HrLPA0J+ZnQGCT
	v1yr/4CxaIRMeWPY8YKSxxomsCBkCMNNixCk2T8r1IbeXIPRQqSX2P/uXCAF5jLWIeCeGEAijXO
	dDeQ2GD3U3Pq9TZM8Uf+F0XVPuNxEtDgkc7gMYfXc2dhjqcBmjmN27rv65Rd7QQ/Br77ee3YKEt
	u9YwgGwqbwyMGPb6j2PvA6udwvOqUfOAnTLoRL1EsM1o3p8KVO3Kv5o402yluOd3tU6DvX8=
X-Google-Smtp-Source: AGHT+IFG26aozbwqiIe5TJo5u6EvRNj6wZxhVBO1uzGcxcCjum2AaOurE7QQZrKisXuepJZwYUmXcg==
X-Received: by 2002:a05:651c:2205:b0:300:7f87:a65 with SMTP id 38308e7fff4ca-3090ddce939mr16010121fa.35.1739464737383;
        Thu, 13 Feb 2025 08:38:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011f453sm2405951fa.54.2025.02.13.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:38:56 -0800 (PST)
Date: Thu, 13 Feb 2025 18:38:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_pre_enable()
Message-ID: <doyqz3odwcf6vxrmaitctcnwx723th667tfzpzmtialms4ymg6@og755erngglx>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-18-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-18-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:37PM +0100, Maxime Ripard wrote:
> drm_atomic_bridge_chain_pre_enable() enables all bridges affected by
> a new commit. It takes the drm_atomic_state being committed as a
> parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

