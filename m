Return-Path: <linux-kernel+bounces-216894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02A90A82D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA2D1C251F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEE18FDC8;
	Mon, 17 Jun 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRS3kOqJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3218628D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611873; cv=none; b=Pu0og3BNbU8PsNxGkmuZ3510LCaaa1CbgrIkrbC/jQ2gUd8z2iuC6UnQHX2ShRHO2DGsnOE7x7PcwUELx0tRMQI8YJNO14/KczXoYi8ThYuJvojahz1FkAQnrtIOo10hlYruwpugzH/gNsBdKoHz3cEwcuYmowOOAjX/tMT7P/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611873; c=relaxed/simple;
	bh=HAiXDoKqVXs+uSWzovtRFwyvGgwwqOriPzYUxH1i6tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Fv3a/eo32UWp60K4TJNqy8kgLFzmD0rUTnRoZIYGHop0efBFHwrkVUPnmg9oST0YeQzvS/Lwq7P7k/tHCIjs3/n/D+QRmpfIp7ytlykZv4T1FWR70hpDgWuj/ctTuM+zchvH1Q5bQonauKzN+sVnXj4Z3UV9RdGnA9HzlkdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRS3kOqJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so46168531fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718611870; x=1719216670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K25N/3U/fOedvyckwiUPgO04fDA/X3bUf5ZT5QtlvDQ=;
        b=XRS3kOqJhPDAxq7zBLaAv43VtoagFB3E9RYxq4DX6FCJEzfHZhc1dwAeihB2a4T8PU
         iN02U3FHUnwNwgV5XxqZGCAYKB+xeEPkAcUp8BL0MdOmstP2Dq9en5LAyF4nwtdRSQHn
         EQzKWnrlDtqIrAK83YKmzC8QrLheoC1D3BBnlv4UQNqtpfZgj411lt4Zg1O1ROnka57C
         TsZRAgzQ1dYFvUXIu5zqcfYWLZeWlRq/s305TpkEgVO0DKLJ8FDDpfbTkcpWdFkSqLba
         KaaGb4YjzR5YbUdfz/PM43wEawWBx4m8SHJO9xeSaVJbWHbSaEz8x6Bg/pUSlH+Z5e1B
         zMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611870; x=1719216670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K25N/3U/fOedvyckwiUPgO04fDA/X3bUf5ZT5QtlvDQ=;
        b=SC+rUu1VDI6P2vo39xYFoAyRft2FWQy65MpI8xdBDnnmb01/62/qQAsQs84Gixjd6d
         sRvdeXGlUO6yV/ExBg7wfz+KmBRia1IXcqF3YlgbPD1kDFGLZ0dJY7Y9z/r1DTUNMjcB
         lbCFlhtKHDE6Nr3ZBRne36gpW6cqGh40feGJo0PqE6PX56TBkbg8DEC+e7s5nTHEFst+
         +fXMi8K8cHg78dRejNxUFUGzZUPGhYlc4xRPTgH+NWxKmsNWqb+JK/YSddbz6baT1yGJ
         N06Te16pUpK4L6asgTied4FlLnFZ6npFH/8ocioTIbpleQH1HenlygwbGjh0cUCIvRQe
         JrVA==
X-Forwarded-Encrypted: i=1; AJvYcCUZI1YgIEZ0CJpC8xQM3yc4AqK1y2nOzwNGmu6zV/uN+VZ/WejROq1beKUqWBmtzhaWTQMQJM6mswDNjFZ7Uy8NuU78mLmU8MXTpPdy
X-Gm-Message-State: AOJu0YyonNAG7CbmIJxScf0G+OyOHBIRR9Q6BkSLFhn56YfkbpFHZjMg
	0QNYGD1/L9bukooaRh1eXeDe/VhLKy1ovUwn+7+xP3PiX2X30MOMKrfyy8ovYQM=
X-Google-Smtp-Source: AGHT+IFCbU4wJgy3KJBNKr1vrp/thHriy4QxTxqnakP6BZLSA1eJsbZCOXQs+4n8+TiuKo2DRzQnXQ==
X-Received: by 2002:a2e:9a99:0:b0:2eb:279c:f87d with SMTP id 38308e7fff4ca-2ec0e60d841mr56864551fa.48.1718611870063;
        Mon, 17 Jun 2024 01:11:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c783cdsm13348901fa.96.2024.06.17.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:11:09 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:11:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Marek Vasut <marex@denx.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Message-ID: <o4bwopeuyxm6344oqqm3e7p3xcx76aw2trsiuhhfyhel2e7po7@sz2jaj6i7kqd>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
 <3277848.aeNJFYEL58@steina-w>
 <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
 <bc96c6b5-a7f8-4ef3-a89b-bf577943f11c@denx.de>
 <36ef53b6-57a3-42e4-95ef-a10eef4ca1c9@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ef53b6-57a3-42e4-95ef-a10eef4ca1c9@siemens.com>

On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
> On 16.02.24 15:57, Marek Vasut wrote:
> > On 2/16/24 10:10, Tomi Valkeinen wrote:
> >> Ok. Does anyone have a worry that these patches make the situation
> >> worse for the DSI case than it was before? Afaics, if the DSI lanes
> >> are not set up early enough by the DSI host, the driver would break
> >> with and without these patches.
> >>
> >> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so
> >> I'd like to merge these unless these cause a regression with the DSI
> >> case.
> > 
> > 1/2 looks good to me, go ahead and apply .
> 
> My local patches still apply on top of 6.10-rc4, so I don't think this
> ever happened. What's still holding up this long-pending fix (at least
> for our devices)?

Neither of the patches contains Fixes tags. If the first patch fixes an
issue in previous kernels, please consider following the stable process.

If we are unsure about the second patch, please send the first patch
separately, adding proper tags.

-- 
With best wishes
Dmitry

