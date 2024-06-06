Return-Path: <linux-kernel+bounces-203987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA198FE299
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421251F25228
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722513E058;
	Thu,  6 Jun 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4BeZsBb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A013C80B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665952; cv=none; b=hDqKntJaPBL7YznGVy/71F5kQuOb6YeuO9hiH/P+a58xX1gS9/cVM2cWpyHZtY4EXQPRXgatRTG334j+YenUrVnOvWCH//y9dFwcea+Fr1WM/WTbRbW/aqFA37dK+J5eR74BCiS8O51pVrEYdRRsjRvvZyWbLp5mKqiLIMRqa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665952; c=relaxed/simple;
	bh=uyl58san+NKMPwYZoSzT9Fy3BJH2QFV16QXFDLsu8+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VP8MM0HSvNvzPXZk+P2dA7lbEMW5JUTCh13L85WSSViCgzc7yMZmHr7ShXSQmQfOxmX4p+VDWM46vtf/Wf13+s+8gn6KLfiXw0lRabIFqgKsqKyKtm8Hf0EYAeu2FXMyco9sXQ8ND6o59gNPb256ce3DjVxonpL8ptI7cV/oPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4BeZsBb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4213485697fso8770535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665950; x=1718270750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcqdEefUwbLDF0Q15e/COsQkexWvEaGN2lXHG6coCLo=;
        b=z4BeZsBbQhhdFueUVphBakeM0fCBulvI7SQz/WSfOJHwdjd2bTeO8GYy5+2+R0bIhD
         OZaXJ3ywUko55x9BbfdvuNDAXFWztw/PoTp0f79UvMQNdxP55YJkZdQ5XGwUgcnoPcUV
         1RLuTNOwd5X+FHEpQHKaZMalpz5unM0tKzveI5FUmAhmZ4BeueXGmFVWw4AZrpajbSiM
         LIh1waUdv1K+dqq2MnsiKwMoehl7Oi2i67DBK3vNZqR6HQ21s3aP4GoMNe9FkRw0AZSK
         AWq40scDPtK3wK/TZcH5nbsPbh3SYyHywj6W6s5RmTKXXEhMIiKuDEiWyK199XqBlvYO
         mm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665950; x=1718270750;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcqdEefUwbLDF0Q15e/COsQkexWvEaGN2lXHG6coCLo=;
        b=oYpT2iKt4UdrzKlG88M/gxF64j/GHzm0h2tOkGW4/WExYpDqD3jKCcgNQIrMdKi2ok
         Ltqlyb/kdxLpjSJVmjxfPh/T0nWTUNdJ7SfftlvGJwk29eL58Bqzo64glUQPvefvrjXP
         gmsV3AsWFucYbXeI47fXctq5LcZfKofJ7QKDy47J0CdLZu9pOPgZFvToySvMuoYv8BLw
         ZScnCNAjjqy4h+phr9ByYKgGhVu90VcSsLWlCZRVgoT9eoKCAqxPir2uA4qumGOG17bJ
         GQlzpiS9h0rM5XmOeVS9lGOQOO5vuG5TRIVQt/57rx1VJK1TpzpdZSdP3QYubr0KqlWV
         QK4A==
X-Forwarded-Encrypted: i=1; AJvYcCVq2NntRP/jnSVTLh133i9pcC6FMergxgzu+LXNDGkocdcmYsBKZVQWE4adp0GXP/3tVDkKA/vZBHFUKaEZl22crs46vQKwqtiHGTDs
X-Gm-Message-State: AOJu0YyHDpzVrJPRlKJzo/L5ki29AZK67X9fI1vpAQ0LDnw/WQhS5iKk
	Zp+Ehc0hi10q7b3ChF4P/RAsnh/3c876qYwDPaWoh7IzIyYnTj0HoKAS3be4ukE=
X-Google-Smtp-Source: AGHT+IFbB8BHHN2WaElCWWkVsvsXwSQADBUM+mKiyFDG++QWWYRhOyBsyMb0orv0Unm9/QUc/7vtrQ==
X-Received: by 2002:a05:600c:1c84:b0:41b:143b:5c2d with SMTP id 5b1f17b1804b1-4215633fce8mr44418375e9.28.1717665949760;
        Thu, 06 Jun 2024 02:25:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e719sm15426995e9.3.2024.06.06.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:25:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, Haoran Liu <liuhaoran14@163.com>
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
 daniel@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, dri-devel@lists.freedesktop.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231129113405.33057-1-liuhaoran14@163.com>
References: <20231129113405.33057-1-liuhaoran14@163.com>
Subject: Re: [PATCH v2] [drm/meson] meson_plane: Add error handling
 v2(re-aligned)
Message-Id: <171766594896.3953723.13432230473582313779.b4-ty@linaro.org>
Date: Thu, 06 Jun 2024 11:25:48 +0200
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

On Wed, 29 Nov 2023 03:34:05 -0800, Haoran Liu wrote:
> This patch adds robust error handling to the meson_plane_create
> function in drivers/gpu/drm/meson/meson_plane.c. The function
> previously lacked proper handling for potential failure scenarios
> of the drm_universal_plane_init call.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] meson_plane: Add error handling v2(re-aligned)
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3c28b239620e249b68beeca17f429e317fa6b8d4

-- 
Neil


