Return-Path: <linux-kernel+bounces-327869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3D977C11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE856B2750A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648781D79A2;
	Fri, 13 Sep 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgHPoyaM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377581D5CC1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219120; cv=none; b=ZgFBBnrD/S9We0FK5sPjGoVnYCQ/Tvnbqop+tz5au57Q+gsPAz94W/HXrRUtJcRGRya7TAJHWSVQCfI3sDSXqCm7VC4KfihdbfQRhWBerS8qlOhoC1IZvRqXcLceEWldVVgOoT+n+7BV8zMJ3JzB66QzfxzcUe6R3X8YknubNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219120; c=relaxed/simple;
	bh=4VqzD1bF/dcoqi1G2tdQISJ/BOID64AQnGEkVlv1wy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=scpFQAWTt4cvK5JUhPRGSz68G3RvaX6KxPFzCuG2GxXDa8NWAtW4QS3aac+CmwqBR0qu4gyQyvx/UqQWWIOJebFFEeh5njtJ0PewiwfMT/ZkcPi1cn0+8VOdrql+LbCdV0McNZ26Vwk7vR7RRSYwoelVEQPFvHHaJSwrcP4KpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgHPoyaM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c5bab490so1938114f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726219117; x=1726823917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KD7pHCmBcsgB2DArG/S7aZbZ+GCS6w6lP+HY1VMGzI=;
        b=mgHPoyaM244VfXu04AZrFhCeW78TIn4W5P0y7ey+FNzT/FC1YQVj8HjwOjQx0jv1K8
         +7NkKRb5PQZSGGEue2u8rXgs9Y35JJkO5kRzoAJAgJtRS3xmnZVqnguDnHr5VMV/UGzn
         CIc9g/7qgInC6JRolOCSXo/D3LMKnD0NUn62jEaNLiD76tGdyUxrNtbruea7607Nh12I
         gEmwoYh6HeNsSvUsbrkEvLdnjXrEf1ftrVZCbu1ys2ecAXjlDplXkF9HfQJmO5x6YlL2
         WVVWXs/tLNHhNES8ADzq9O5ZJ2bNa04SGsqJcbROu16tD3fcEpXrSZj7oE8iEClOzeL3
         S6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726219117; x=1726823917;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KD7pHCmBcsgB2DArG/S7aZbZ+GCS6w6lP+HY1VMGzI=;
        b=s0EsYQIwlp0OpdTgPhmpAFkSzGP+ERbyN4aJXlCj/m54ePBNPoBoRM7xxj/xAwdAtB
         wviF6McmQCmhSu77/V75F9gr1ySqtpr/BWNwhsOIfs39In3xCMFhu3CiJIpwmnMHxT1y
         2ORyVeC0ZgIK3JgZ+kOGYyM6sHm4ENIXFfsftYSaT+KNs40zCzcCZ41lL12QCfKfnG6f
         suRRyhmhfc6V1aM+4sB6eI8DEgvhpF83t+ua5DbveO2iOQWp/Uij4EUStQ9SFRom4jwJ
         bMB0F7ShTtKqfBj1Flmf0sTrXJ+WfFSSWA9E5LGwp3e74KVz2byyYpaCIzFp+eP4t0fM
         mI1g==
X-Forwarded-Encrypted: i=1; AJvYcCUuu/QyG6H+p/SXqwPHDzzKdvMEG2MtRDgRzT14mQz0/qcibKI4m+hTMKCM1ZRTow8jxQW8tc3BG9WSGsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tNUmqqbOzsTtNvA88geyeNG5Bz/XnRVuiD1aGwKvqlk9IrV6
	9+d4RLNRlu0VbKPMhUECVVMdIDUgcw/y3iH6IgMO8W1ww6RIWdsOC1XXf9zEqUE=
X-Google-Smtp-Source: AGHT+IHMezkuVRNZUXSaSOzfE0wCiGluS32q4ou3UZOYqqvg/BDHgGPVBLZ4ko4U2Kzbn7syHXVa0Q==
X-Received: by 2002:a05:6000:bc7:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-378a8a0b864mr6850478f8f.8.1726219117307;
        Fri, 13 Sep 2024 02:18:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de0e2sm16258982f8f.105.2024.09.13.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:18:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20240911200125.2886384-1-andriy.shevchenko@linux.intel.com>
References: <20240911200125.2886384-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] drm/panel: sony-acx565akm: Use %*ph to print
 small buffer
Message-Id: <172621911647.1200554.4675756324644604163.b4-ty@linaro.org>
Date: Fri, 13 Sep 2024 11:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 11 Sep 2024 23:01:25 +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sony-acx565akm: Use %*ph to print small buffer
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9550e2394fc09bf105a246221660da980c2dbd66

-- 
Neil


