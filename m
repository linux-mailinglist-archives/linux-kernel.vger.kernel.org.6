Return-Path: <linux-kernel+bounces-195401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2CF8D4C39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F97287B06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5E17F51E;
	Thu, 30 May 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnspboH8"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A61E488
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074167; cv=none; b=h6S3+NqXnEVY02CvJpVj54TFw2pAqi+SeVXWz650ZeReDvbtjKyGbEZPfB0zzo2jmAnhUrQ4SpYGtjYK80bHRzPsiEn1aYWoB8ThDrkx22cwDa/FJ8NygsH9Pn8c0y3aAp4DVOskNBS9Ymj3DoPRt+/+BuLPkbQATEFo2Cne6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074167; c=relaxed/simple;
	bh=9vnkikzwNsTLhzs4okPcSYMp94jwRq2McQqFXH0Vs+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rqMU0MOCetGdsyuU5NQlmikiLTgCGxS/kcdXzLMUaBUmSnCK/GdL4FBkpE4Hbsv5ILXeNxkmK61dF9hJVEa+X3BrlFkQ1jxWs3bIEf7DbF+9qNBy9Rmxj7uIqKqa9JN2zPOTQID19qEi66pAUFI1OgaFdW9svUCaarCNpcWxFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnspboH8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3550134ef25so874948f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717074164; x=1717678964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49+GMxNWhLkVW4rmL96a1CAqr3zak+IQF7tujObyMU8=;
        b=nnspboH8UBEmVtMl5vk1JbizDmcYIYXXjwI6ezu17RPvlE/h2MlGRP7TcE/5WeDBIS
         fSRP3DbNrQ+6Y30imZsOdwS1trndR7YhsVr/k+01JyxFDbrNiu+Mc3pz2ZJUTtqkKdKB
         DTrkPRQ0BUoTA0OMrGrrWYcggcLj19kyfnzD4gvummH9E9L58UKS9uHnXDquJsT2GHEk
         WqYFRTWwoQbE0yHKhOdwOe3ocbjorMETP4puNRBqFlb0vqkdpNs5929EEkH+RkDOSJzZ
         5M7rgHJotBW6FIhG8RR426pIdJhYKlTr5jTHLQ0anA25N3ReAjipSQOTjTX9Bp2Y6zh/
         r51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074164; x=1717678964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49+GMxNWhLkVW4rmL96a1CAqr3zak+IQF7tujObyMU8=;
        b=UHGpHOf4F5UpiuOwWZFOtIhnS/b5gPJnvZQjLh1eprL668zezdh5+kl8f7sOvNYpHm
         kCO4CRYclC/uQsVc2vqCYobKoACDlMCH/qwNLW++VIbxs9oT9PPJP34ONcv2rQNF/8aR
         PY7OHUKdj7zQTDAJbsQZALku+r8otg8dsC8h6piy5nyK+sybhGgRVxtAbqsgEtI72e1l
         ezW1yH8lHwV9Ps5l21Rl4x05d1xJVkx4Ppr/dM/n7AEQWPdUXgbPXPjrKU3tBp+sz9xf
         GqTT2kK+Uds9jOYHMO8Jk3BM6y+HtghsTe5kh/xXZx+BW2w2X2uXub6tZK3dNIn9ooyE
         pduw==
X-Forwarded-Encrypted: i=1; AJvYcCVOwqjpYPaZnYPejGh9t9vWFlLbAo7I6uoFvo8anoqfbSc75uBvKSVC+RxtHiOGJbWa/p+/nXKm5lQit9ubL5tAz00/ohaeXaevZsUC
X-Gm-Message-State: AOJu0Yy4UEF4c+ymlHVmNkDV4q9z6osNMavqe43eoThB3TChbxCRITrk
	QhiacxVEF/YOhgvqTBGMj9JHeiydlrztVTvGPeCbEMZB2rdSqlzOEf4xi6HViD4=
X-Google-Smtp-Source: AGHT+IHNGCVX8UsXryv51jGEZDjnSTfAQ7QHc5uIJgMOYfUdLU99pXCIdvPzL4LOxkd6BoZkmXFpDA==
X-Received: by 2002:a5d:58fa:0:b0:354:fb1a:25f5 with SMTP id ffacd0b85a97d-35dc00c9a4cmr1567928f8f.52.1717074163561;
        Thu, 30 May 2024 06:02:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35c19618fa3sm5708331f8f.52.2024.05.30.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:02:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-0-e4821802443d@wolfvision.net>
References: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-0-e4821802443d@wolfvision.net>
Subject: Re: [PATCH v2 0/3] drm/panel: sitronix-st7789v: fixes for
 jt240mhqs_hwt_ek_e3 panel
Message-Id: <171707416276.4156460.9937231106022840438.b4-ty@linaro.org>
Date: Thu, 30 May 2024 15:02:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Wed, 29 May 2024 16:42:44 +0200, Gerald Loacker wrote:
> At the jt240mhqs_hwt_ek_e3 panel, noticeable flickering occurs. This is
> addressed by patch 1, which adjusts the vertical timing. Patch 2 and 3 are
> two more minor fixes for timing and dimension.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/3] drm/panel: sitronix-st7789v: fix timing for jt240mhqs_hwt_ek_e3 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0e5895ff7fab0fc05ec17daf9a568368828fa6ea
[2/3] drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2ba50582634d0bfe3a333ab7575a7f0122a7cde8
[3/3] drm/panel: sitronix-st7789v: fix display size for jt240mhqs_hwt_ek_e3 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b62c150c3bae72ac1910dcc588f360159eb0744a

-- 
Neil


