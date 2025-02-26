Return-Path: <linux-kernel+bounces-533115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F45A455CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F2B3AC33F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A5269891;
	Wed, 26 Feb 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3+h29xm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE519CD17
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552018; cv=none; b=la+tBzrCu6Xa6h8J5aG8tvn5IGMJyVTTYP522vinavDVZK+9KeURAyPuVoIugf6ojfYfG2WXFYeHmtt0t/VJgWqmAP17Hs4MzsQGKBz0x19PJlUPW7+Cg+6/+kW4RAvaqdcBn9mpDg8F3HNUZHarsmGngocRRrJwLwoZbWY8GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552018; c=relaxed/simple;
	bh=xkG4hcHiCn+64ZLfOY7cOIxp9KhkRl9K1d+epai0vjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVziPEVt0YYmEBknlga9F0En0Gex8ZqXt+ZtwDVFT39K9VwCpVTMVvYkRuv/YwrqUBT7pL2mgKNgBn5ow++DxwtdheS8fslLtIwBcP7XwjVaXVqd9+C9EWcq8/0AZw3He7QI9bnbTeWmbAnwVzH7pOafVlWQS0WZpq/qFOdK7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3+h29xm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fcfso59269481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552014; x=1741156814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnlPPa2uUCO1zeFpt71gVitBbdNg+Xjk4s2scJwEBqA=;
        b=K3+h29xmg0mUiEsZvdFvytGV0+s3t+WiSLIrLV0UTvncrpBkte9caJYSrRhKBWyDe+
         wzALBSC3SLI2wK1fwgcbnz5ZNMB+HQnVUJLQPkT1RLUOUHeYRLSsVBQ5OlNEo2zcDY75
         wB2vn26rf7UrUrGdoNR53nyemHC97NSdNa9DEMCGL2ug0FKb1UEph7Id7JZ+HbmYNP2d
         D75Yy7KjmBDkBMh1Ww67OX3Syszpb7+YNs45V1D6pNgpXesQJ+XSk2q2gJ/MqK0kxYyB
         Qf+TVX3O8Wg7MmOGdcrqBHV4bocmwST3PZzWTdEcvpWVYSqL0aRu72vN2ZMeFkxZJXn4
         3fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552014; x=1741156814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnlPPa2uUCO1zeFpt71gVitBbdNg+Xjk4s2scJwEBqA=;
        b=vD9x9/l3xqVoHcQ/Z/bB8DiHhXTDVAFotL5nPmYmkPD+3NSPGjRcSZXC5m8yCMSx2W
         Jcip/RuqBU6JskzpdeF6gs5vbJQUqvCSdIml0PrVdnR/vsyc3xzLZ/rAHnRcSHQeG63M
         +4zHEkg6lgb6L4EmY/1QHCbNHLmW3atCyZUTRNjWQ6NdQsi4PZ5mCjBqrpiwkr8pLLaG
         iFtK2okrrZMwsXegkKuuggyMS9XoBQ0KaDGrhhvFhwFEEPp5T8U1v8t+PNjrT5qb8V6y
         VPUfxDkxvOX2NRvIP6NiBk8U64ki2df0jcNPpBg0gCAYeuWCrwyHrjlBti0BaKT3WzrU
         E4pg==
X-Forwarded-Encrypted: i=1; AJvYcCVTdYWOR6TV23YSRq0xhTiOGcR5c8y95TxEuypL7BGf7LDktFKiKKsSikHQirNC+pYFpVBR0xwwyo/02Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZ9dAbm+UH1I/zsfB4elS4ZUQm97cMf5kBoPTzsZ1Hi1sNFyD
	bFB80iCQrKghQ3ukfPvRSqi1zBI2um5CQCPX4RFrteXEVBtv/CZcHjjQbezQ23NQB0enhrSiC2b
	REOo=
X-Gm-Gg: ASbGncs0aE4sUPKYIkwnbcQ55PlAWi2NM9UEV5X1ECus4xJMnNRMAl+H+9aVgvjByTK
	mT0/VGH5VvmIzKqkrXwI6ZmKh4jbYH4XkT2iHykJ/uX81qIRrd83AnPWzH135wVhfniQ2edgp7s
	wtK2plIiucszlbiMPQiiiinHU5wszIB3URpsH34xT7Ahq9wkC1lrpUrAszmXzbBmpPWGsK1jHxC
	cmNUk9ecIFjAgblXjDznjRs+zOhHYTVDAqrKFnzmq7ZD5vBgK8ENuAvGoQ6VPvBCRBRSZdrNgqR
	tDfxijnEcBvp3Zd4dgt8piDlqP17rPvTPQ/H1F9mYYhnc1S+vvBTspee0cGtEwebAvnxSJmukVB
	+lAi6iw==
X-Google-Smtp-Source: AGHT+IE6dtc85yOD3cihprIvVpH/1esWLa6UQi+5Gc9+xFNYCSpdxtNBXemRzp8sO2ffXNDZ9U28Yw==
X-Received: by 2002:a2e:7d0a:0:b0:308:e521:592 with SMTP id 38308e7fff4ca-30a80c984afmr34851781fa.30.1740552013753;
        Tue, 25 Feb 2025 22:40:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ac2f52sm4211421fa.65.2025.02.25.22.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:40:12 -0800 (PST)
Date: Wed, 26 Feb 2025 08:40:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] drm/tests: Create tests for drm_atomic
Message-ID: <tadc6spmedblkzuuzrtg6wj4l5me4gvfdps6dmmkt7riytop4n@sbqabl3stbqv>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-6-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-6-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:54PM +0100, Maxime Ripard wrote:
> We don't have a set of kunit tests for the functions under drm_atomic.h.
> Let's use the introduction of drm_atomic_get_connector_for_encoder() to
> create some tests for it and thus create that set.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/Makefile          |   1 +
>  drivers/gpu/drm/tests/drm_atomic_test.c | 153 ++++++++++++++++++++++++++++++++
>  2 files changed, 154 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

