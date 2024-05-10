Return-Path: <linux-kernel+bounces-176271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222A8C2C95
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF57285961
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222213D24D;
	Fri, 10 May 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6l1lOgH"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AA15E86
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379939; cv=none; b=VksqoDn2laJicuEXZlDa7DrNUdjZZWNnptYfEebnyjjYKMuxlD7VeWRDxWw5tH8kAALYEe+RJ98fGaXimCAZw2AhvfIBWGegy3x+g0fDD7oxkMeRU3ubI6yrAdHdstyI+biV00YQRTXToyfiQoVDECLP8uTIPvutxVYvw2Geacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379939; c=relaxed/simple;
	bh=xz1FMJnT6STvw2K8nlt4UObpEN1TZgFZdWliO7h2thU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENhbhHJi6NokGbvw36tnqZIc5cW85eXceWy2f6J/f8GQcHA04iVfcSpRNpoea/5M/Sf+gj4Zv4iMLEH2piOQYl6HDzK50nKCOEHVF5DCQ3fKHApAywMD7SZS38syy5Vla5rBVjyWiyrKK9SYYTYfeunTss/AFV8G7InPlaepxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6l1lOgH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ef64d051bso3054911e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715379935; x=1715984735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W6HjquRKOFN+fNdCcBFqV2IKTVODauXieX60eZohwyo=;
        b=n6l1lOgH22p+sPw+eaHHL8ypLHm342ryflRtMvPKQk4OigawoDVi6XjVWhpnxyHQBI
         rjzeIJGaEaRw2ne4FlmfNxFsngtQPk4D4AS3XSISaqGRoMWBPcvUMYUlN0CSeazZd8SU
         wOXMi67WdjA8NkAO5u21xLhGMHoJPQgNwHvZg6drTKam4EzQQfOulUEop3pPYOHbZigL
         gRu/7x7WwSeq39DqQRmiA0covGTMkO4E80ei5/HqX25Tvz1AxRBsaeovGcZ124A/AT6B
         I+JkQB3XRAeFHGTOqjTpYwxUGwBohiL6wAmC+QEuCN+sjvUJ5cxQrxGNEj6a325re0Dm
         NX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379935; x=1715984735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6HjquRKOFN+fNdCcBFqV2IKTVODauXieX60eZohwyo=;
        b=krgw5IPrJMOsun28v0JOzCnuJmOkBSccQcH3BSswH7YGh0Y14zLcEtJQvFoE8uKGEk
         7KKG7+z/mvIJWSnby2vyhwf0ToJi+ZNI2nYPbS9KrueQYQ4VVYKXQn0o4O+QSwWQI84J
         e58Rn/c9Bl2oHNr3btJEMt6gpfaMsSkqlBCl2Wzs8s45R2iOiXMbCe+8VWs6NlDaAToy
         goVnowVU4/jVh0bSv5QQJABOlnY6R4ZmKEbJJ4WkYyBl0BIbKSX0O7RMoWCPADZL6xvx
         XmzJQmuA1Nxu7YHvP0QZGcsSAX00G4jP8QJJF8XwMBWJR/3knOyu0znq5hHll5mFHSER
         bQjg==
X-Forwarded-Encrypted: i=1; AJvYcCWYsEXJFqzjxQnkos2zsFxnhevK4E9dbWcZ4X5Vy5ISmFBPF5J1dhk8r2PEQG6YRp3NICZ4fHyFqdfTn8uZoKR/zIvyWHIDV5xJQB6r
X-Gm-Message-State: AOJu0Yw4rE/eUkX3AQlHqK1ybrTLDRx2rvQcgrpTPVocaAsCp/Iejwf9
	TcQKlm6SJhZlfGz07ApxsvEcYvElXZ8eDFtw3VBElYnYUekOwaVQPMpGh8h9UWo=
X-Google-Smtp-Source: AGHT+IEFoajKWL5Ia66X2EESRVbXuMiDkkxy0S8gKkoH1kR/jrIMoqoUuKrVGiU/0xgAGVyjDlJflg==
X-Received: by 2002:a05:6512:358e:b0:522:2990:7739 with SMTP id 2adb3069b0e04-522299078a7mr1051254e87.20.1715379935513;
        Fri, 10 May 2024 15:25:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad535sm835358e87.28.2024.05.10.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:25:35 -0700 (PDT)
Date: Sat, 11 May 2024 01:25:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/7] drm/panel: lg-sw43408: add missing error handling
Message-ID: <hf7u3rxard7yg2z3fkmntemhnnmwnsgmhmfhpt74modswg7nj4@7kwyba55x6o7>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
 <20240510-dsi-panels-upd-api-v1-6-317c78a0dcc8@linaro.org>
 <CAD=FV=Uu2=6c_3Q44BK384cgSLX=++_bBbg6=CCqBaXnqcEK=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Uu2=6c_3Q44BK384cgSLX=++_bBbg6=CCqBaXnqcEK=g@mail.gmail.com>

On Fri, May 10, 2024 at 02:47:05PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 9, 2024 at 3:37 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Add missing error handling for the mipi_dsi_ functions that actually
> > return error code instead of silently ignoring it.
> >
> > Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/panel/panel-lg-sw43408.c | 33 ++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> Looks right to me. Only slight nit would be that I'd put this as the
> first patch in the series to make it obvious to anyone backporting it
> to older kernels that it doesn't have any dependencies on the earlier
> patches in the series. It's fairly obvious so this isn't a huge deal,
> but still could be nice.

Yes. I wanted to emphasise the _multi stuff rather than this fix. I'll
reorder patches for v2. Maybe I should also rebase the series on top of
patches by Cong Yang. WDYT?

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
With best wishes
Dmitry

