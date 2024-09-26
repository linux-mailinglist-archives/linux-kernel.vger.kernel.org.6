Return-Path: <linux-kernel+bounces-340097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4100986E85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB75282EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D64145FF9;
	Thu, 26 Sep 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar6Pl4SX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB013CFA1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338152; cv=none; b=F1/ttNbRorsJ5+VeTYpMLV9XCDfVSvBvMl8tBqntoZgBxCKpwFzRc1fsCd6vTDtFLRl/xqYgqpocQK2ejucSR1HH3unamAryoLjLpOc5YPRHt1pcEFzfjL3LH590npVgsBAFc+wikQF/CO13HJEJmIgJpBTDvkcBWZqnHVXO8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338152; c=relaxed/simple;
	bh=lN1FRJEaL1KwI8WMh6ZcBnUSoxftAoIqwmeDkTfdyIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJH3dZWnhOWomVXEmlk/hPjCWlNl4G0d9NICUmB8mCCSumE8I5OU39ZQhvhSSC8CnyB1IwqpGX++j8uMOkWq03LYcceLOXYxoCzceY7zVQV7PEK0LeKB4GBrWYVVM687co0Nf3Un11k2aFCDpdB1fb3UG1vc3M7m6TrnOjUH01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ar6Pl4SX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f66423686bso6654661fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727338148; x=1727942948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l9iStkPIaFLHxVt0ItzAGm7iNiw5At7Uj636c1Ihx4=;
        b=Ar6Pl4SXQk2Z3BFGoIHXpYFIbcVvr4bnmMDQBYl32GuG3HeUsNXDHutV3gu1473fkY
         6MzDxKiqpZrX9JcdlyNRiG9MkYf3OAWANOWfah3A9zbOzo1RBawJNlC1HgerRLbLF7nU
         tKW3hlKuO4Cwe6jkq4nxhBc1TShfCyH0hDzeNZqVnV5ZwQZbHTdHad6gFcrt1Re4J3ab
         sRI6m2m7MIoCo6+V6NoNIMYj9aemWT+/E435dnKGvh0WlwOrmSkHgMe1XehqNNlo299Z
         2hjxFqNEA78Cuf/1bPv09qo+n3j9C2qVmu7adtEiMjlpIKsfLqkVJh4uxrZHSPVIvTAH
         wD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727338148; x=1727942948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l9iStkPIaFLHxVt0ItzAGm7iNiw5At7Uj636c1Ihx4=;
        b=GQKXJSk5kd7o/NxWEQmxDJErnZoAabOwmV37i6usF7UU31kTzah5RYxWqu0UYFK6eT
         AUEbfGukGVwllHvBrrp7PsHMoqWs26PGVXSf5LDM5RSL5EkCllaHkLU4jzXqYWDkTXlK
         Cj5a+UNmaW9IgcDz6G4r/I/hNYnKpgMC6JBJ7bfDBYSl/lJ4dEpgajm1f4YYwFOisNff
         3o4h69u/FWGIngSQgUTLcrhqg1rwEc3dsV8BPWBSFaSaOFcxjN5NV3dioSPNekX+aFLm
         LeGMzABNCYXnedaWF6sry8PbZ+VnjGfGf8Gkkgc8bkcXTZszBW5Ma+cwcUR1y+uY3TrR
         KteA==
X-Forwarded-Encrypted: i=1; AJvYcCXZTXY+TLqhHFLwm5zcV31NYUa0xKySO5aXVsz3HlaWWxXBx8b1w17ZJYrH5hyyqYMkuCAIr6J9LYTYRKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqzw/0OldXL735Uk7xVza71UnN/4T/cto64Jfn8ntVrnFdhdnB
	rXcnofNVIAnrA5wSOuMy45lHdtKtwx/wydNLBFBpEkaMDaqK311a3luDuamOdbY=
X-Google-Smtp-Source: AGHT+IG3lTN+4Ke2+Q6A+sK/efesJW8egbbbe6JzVlq8PPbmr6MZ48pwrwyfUgBEjkJGM9d3IFV0qg==
X-Received: by 2002:a05:651c:1509:b0:2f6:61d7:ab63 with SMTP id 38308e7fff4ca-2f915ff591fmr30473561fa.23.1727338148191;
        Thu, 26 Sep 2024 01:09:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e5afsm7483111fa.97.2024.09.26.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:09:06 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:09:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Allen Chen <allen.chen@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/11] drm/bridge: it6505: fix HDCP Bstatus check.
Message-ID: <oed5mkjnyqnxmefxx2ahlrh4l73slgbwttum6hji6cvgf4zujb@wgo3h2r5jb4s>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
 <20240926075018.22328-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075018.22328-2-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:50:15PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When HDCP is activated, A DisplayPort source receives CP_IRQ from the
> sink shall check Bstatus from DPCD and process the corresponding value.
> 
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

