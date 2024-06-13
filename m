Return-Path: <linux-kernel+bounces-213039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4956906A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF2C1C227A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8B142649;
	Thu, 13 Jun 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiEskT6N"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877E13C9DE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275356; cv=none; b=T3K9c+3kNs7bWckdD87gGJbssm1+4ISeB/r4L4E8Mc/laPgLOWtj+60EkjpBJcM/JufPgqjkiZqcCXVYqpCTD9J3qvH3QJ8LUL771khTdzpEtc+BuikxX2CeQV+MPGAAvCdfRa7kd9F0CCqClbUUBSF6eW7T2e+z/jpxTnWCBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275356; c=relaxed/simple;
	bh=KCVaeYwZ8ciJAt4cuKAv16NlydA4r50qN/VMuGlDF4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rECBJbhPpeCnJz2Gxjsedk7aVbOb93ws0qMRzbPfEnIJzfLKT3/k1ukW57E0ZM+fAQBrTY29lp7DK91N2cvltWKiHhELp47rDKwZcvC7pOs6aLasC2RcwYXes2ZUGDD5zbztDqX4SzXU2gf1glu9X5AfQbP2y9N2tXJWNmiE4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiEskT6N; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc335e49aso1085725e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718275353; x=1718880153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF3NyOpnlOW2rshocUIQBURkaLEe4WA0cmtD1teWgII=;
        b=XiEskT6NqRd646ySNZFRCfckoVvHfcXM1dNg4vJh1UO91gfI0w0lvgTHCV5pCgBowh
         8i0kKDzdnizL5Vqoq/yuIucWSduzrEgjdjv31BVlHuUfcj7BP/m5yOdM3DIkmlH5mrwz
         G4sF+E1fScuKDxmghXc5Kuch1LbyXpQHehcY2oX2lf+WZIsAtiHkaajwR1GGxeSoLj+0
         CfOWocNUFy7ynhL6NFv6jHyLIWDxG3eVc2AYPzcNBWaFsqEoqCLDyvwTPdZ2VnVlKyrI
         CuxUN9tgzSUNR2c5xUCDFU912RoSEnjNH+t9/6fGN6k8gAt2402FgqtEu3IBZA7s+eJR
         khDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718275353; x=1718880153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF3NyOpnlOW2rshocUIQBURkaLEe4WA0cmtD1teWgII=;
        b=a3fin2QGbZvqSVEGIz/Gykw0PIwez705h85DjdVidp40qcQyo0KiGQvqMKDNDiYtC2
         edMWnYC+Ww6iiIESXce44TfwzjLS6d+xcl7vbn0ro5tkzhDsKIsOx6gFzMv/Wf3ggk2h
         fMAhwcWlDkW7nbdz8cl2o81cBDbTyGw1aRoAPFpPCTy4Q9jhRczTxxYLLtIfDB8hKO0A
         KflD4adXXUJvoiwmTncNxjNM7tRxakgYDDEfNL7oBpayAZrDEqDAIavmhBoDOE4+qU05
         YsRSe0O9bHkSIv7J/FIhKIYLze1kWM3IZaQ2iac9equUk114KZdlE72zc9BiiToJbXk7
         lWYw==
X-Gm-Message-State: AOJu0Yyb3OdpQP/5WnZMqFvIeH/u7MKOralXc520b/i83CizAMHUBwWA
	AwnJiMuMxPiG8aY7Aycm2tF/xwOaobOrXW1ZgxlQ1MI/1R8fq7OG06o6qFIBAMM=
X-Google-Smtp-Source: AGHT+IEv2lj7+kQqzbSuf/t/o/PixULLMReSLMuWfs+AvyIbe7S58yyPAAOAXLoL5kl0AJEYpC+T2w==
X-Received: by 2002:a05:6512:1245:b0:52c:95d1:87ae with SMTP id 2adb3069b0e04-52c9a3b7bffmr4087081e87.12.1718275353006;
        Thu, 13 Jun 2024 03:42:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872388sm156786e87.174.2024.06.13.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:42:32 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:42:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, sui.jingfeng@linux.dev, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, mripard@kernel.org, sam@ravnborg.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/3] drm/bridge: sii902x: Support atomic bridge APIs
Message-ID: <klupakbb6zgyctjtrxqbubc7qvj2c4vp4q3o7hqpfzic6dapjt@7kkl3g3sjrsi>
References: <20240613083805.439337-1-j-choudhary@ti.com>
 <20240613083805.439337-3-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613083805.439337-3-j-choudhary@ti.com>

On Thu, Jun 13, 2024 at 02:08:04PM +0530, Jayesh Choudhary wrote:
> Change exisitig enable() and disable() bridge hooks to their atomic
> counterparts as the former hooks are deprecated.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

