Return-Path: <linux-kernel+bounces-377566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320F9AC09F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA9C1F2519C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50315622E;
	Wed, 23 Oct 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNRV55Cy"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5066154BE2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669657; cv=none; b=WwM7FY55VrelxaJ5nsGaG5c4vwWgYCUaxK0W2R78UE3cR4NDK3jQ//mXT6M4RgkYLtS51O8agrk+00jKBw0+bJuBM3HRwqRNzXkZUdj/YwTryWU6infUrSzAhM/SP3lvVOOQVJ6UfPeJlANT14nRt1B9An2mkGMzEqyM+biV+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669657; c=relaxed/simple;
	bh=cPaa1vSKpyjDsq7qESpXZ8U2q/Y/Qq/8A0fFNXrB7Sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TQ8znamRI7ux3a0Bh998adD9mCTuiBOBPZXDMAS5Hg6NZFvfuDSC3zpNS/3QQMEH/YspaUr8g+rELK7Zm/0E/k50ksaX6MIkKyt/G61R8gLqmtqdDuFKjlG+wsCsnR1d0Bck/mpebSxMfRJOhRp+fGM2A2OOY309AF38vUX3j18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNRV55Cy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d533b5412so4468237f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729669654; x=1730274454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQWqOpYZeng+MXOLp1GWIruzuK+nBAFMns++2n6ESZE=;
        b=lNRV55CyQB4hQq4h2JA4oU+ZzB3F2pMTfrt3EyMas6EjM95xvnbMmcc7Q41BXoY8g1
         Jh3/hejXR0JcnmVdFSUYanhEOcTkuf8PIa7i+MaSirL9/rXbbL4tref4doVB63tkK2Ya
         cjHQ/aIH280eUZeXLAcOGZN8ilm26R5xp+D+c67lcX8KiDFA7yjb66TC/kUvz2Jqqtno
         f/rfzhWEyrUTLwUwWUopaUS9f/lDCDkabHA3dFysHukDEKECTsToaIuCKcEBdJ+clXpV
         4rJUXwCLzd9VXnlCWhQXpkBCBBpiSh85kSjwsnTOl5a3UJeHM6zukMzXaewEw4rECjhH
         780Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669654; x=1730274454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQWqOpYZeng+MXOLp1GWIruzuK+nBAFMns++2n6ESZE=;
        b=arc+cyrwrfupjC5Z64NgNxvQVolIKi3XisnKAsegn8VJQHHA68pX9+8k2XrvqSYN68
         y6vnRfUG1D0V9s5d/PP4phswBv9ZHfuw2/m4+8/GW3vZ/2EESHOOUQrYi2dPZNrCWGa6
         vTVZBKnz3gcVr9fGEXGZShhyDO/3yzK5YoAFWtLZmYYNiXlHTT4XxPBC+PX1f69TrOqX
         kVENzUuYvLDKAusyx9dGGegKNJ1tyzprDEbHNxhCeuHZLy9nToDvQSZjtsK4xPJ49KA7
         NZTOIG5RfXxh03OIWVzF0wL8lukVc6Vhd6mAMgJ36tzATSI2InA0hSoQATzjL5cNOGPV
         GicA==
X-Forwarded-Encrypted: i=1; AJvYcCViqnS98v1XUKgT7DZs2xi8tl1rQye+n1VUgzhTHzxSf+PtUIss3X0fzgRvcBwJgXJ6uGE0nWSELFtnjw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5s6blJDE1Y/ufJyzSOWcUf3/G4/3Ss93x4uqMSJQ6yF3C3sl
	l8Nl5/mH9iCQlyRLpI8yfIvXLHBUVT7ByjNDEYbEQib5aN3iTi8/1GRlZHQjJ2o=
X-Google-Smtp-Source: AGHT+IE7RVJxodr7X7GjUERSD075yzeX0Y1QzksGM4UPShCGHK/b6rXF19hQOYmqYhFnjt7jAjhz3w==
X-Received: by 2002:a5d:4e83:0:b0:37d:481e:fca with SMTP id ffacd0b85a97d-37efcf18bfdmr1090320f8f.27.1729669654049;
        Wed, 23 Oct 2024 00:47:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb66sm8244622f8f.95.2024.10.23.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:47:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20241021-starqltechn_upstream_integration_panel_fix-v1-1-81776e89052a@gmail.com>
References: <20241021-starqltechn_upstream_integration_panel_fix-v1-1-81776e89052a@gmail.com>
Subject: Re: [PATCH] drm/panel: s6e3ha8: add static modifier to supply list
Message-Id: <172966965335.2449641.10563615972532677611.b4-ty@linaro.org>
Date: Wed, 23 Oct 2024 09:47:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 21 Oct 2024 16:52:36 +0300, Dzmitry Sankouski wrote:
> Add 'static' modifier to panel supply list.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: s6e3ha8: add static modifier to supply list
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/91e21479c81dd4e9e22a78d7446f92f6b96a7284

-- 
Neil


