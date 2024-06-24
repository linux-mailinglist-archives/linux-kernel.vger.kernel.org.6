Return-Path: <linux-kernel+bounces-226925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF99145D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456381C22701
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE112FF8C;
	Mon, 24 Jun 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5GPYdPd"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CB1805E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219943; cv=none; b=PVPef+IzkRs2ZUa5T9H1HHykIT5WrZn9Er2DYYSCpcN+Ya6VJdDSj3oH95JMIQM4w2/sOQhysFUUDjJQI0y2upCHvT/sxiUVcXqEXnp9svutagW/Sf9GvjseIF6GlCRQHYxYoSxgRu+cVqc8ZMnS9C2ou4Qy0vC2uwEaaiC+nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219943; c=relaxed/simple;
	bh=1dLynjOzKPIIq9+uB1Tx3Em99pDR1QoIA5twnQYiv4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HMUWVXiFAH/wdLWn8N0Nvq6lBY2tE+ZYHL0l66/SsX0PsTRdbdHbHnJzRYV5f32DIgKi482UOh3GpfpaeHH8fIcRMVKzqXoxpe3hFEaQP8ohykNJXlgIP0PusOJryLGij/LwCv9mm92FdoHpxV+y3dm9buZPiA6bvRCEDGXkLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5GPYdPd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so1459878e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719219940; x=1719824740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGebS0vkuwx3hnzjLTve2Sw95b1MHPirmaMeFfxgZ6Q=;
        b=W5GPYdPdklYoLbY7CGdUX24YNey6308IizPF7MH1ZlPO+NYXEzEtBVZ8jAentaQ9YP
         iXtmMQdJW/jPaXI2G5E+hvksoOjPC3r3c+7oXem3BUUbKQYV/fXNRcA71XDj7hgCnXaS
         yuzVqaseyfowNkDvg9YINDNP3+v/LnLXaUgTFxW6mNezzSgiAwjMW8ikBjilgpEFlmxm
         rOFQIs8g6NB4TXtEV0oJVfux/tzBmAar9Fkxg//KuESgzkLoQmsYnpj4W0Urw/PNzMEe
         Zik1oz3NyLJxHaynCK+UXWYnXrnZet3Nc3ff7b3T+d9tufrGC29hjIonpijs1WtKQoTu
         g1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219940; x=1719824740;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGebS0vkuwx3hnzjLTve2Sw95b1MHPirmaMeFfxgZ6Q=;
        b=gOl16tVvuTojH1sSkl9DPsZyBgy3T2cvCgsgGYVQ1syPmBB2MwlNnj554+KgOWE0Hz
         UL7IvlPQmf2dfpb6DhNps5uMrjLjTON8oTxf/j1ncwKqZ1ftoUh2XhpEppXs+1oUyVh1
         W8DZyO//eOfIqd7d8e5gW5Y4zNBv21K6C/QpZUa+u1CqyolH6RPqI14NNP0vZ6rnqKb5
         LoyjetgfiR5ivo0zu8K+FXIvJUEP1qc4rPGRz0gFQdLuxw49pU02x8lkIt1MvoezdHmu
         WEO30M2nIWjexUKdvzFPsB4w6CvSAnok7FphP/fdZEFSbpcMVxAK3fqONwYjsjbQxNRq
         d8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU7N/Hj6rzw1Uv+FsqrTGUR08pHw3QeF8wxl88VdHxvSc2z4tY3g5+0RIDN82a/xD1UhpRrv5ExPlmuytxXhXHXoFCgTMqfXc/QgDC3
X-Gm-Message-State: AOJu0Ywn88kskVNKAcbJHpYXn4L/ef3A2XtnJtdovLHRcIfiJIxGn0JP
	KKlcEEqsqmGubFsNnUNeoMK2YDhiWpmnTknGwSs12gEtqho47DDnhc1cIfmypXU=
X-Google-Smtp-Source: AGHT+IG6zcGQsoxbWQCNE+7aa01TpZbpNJBjYwOYrGWeGHPkluLHLC42jKkkUz5io9dRYoS5RJ7lPA==
X-Received: by 2002:ac2:5617:0:b0:52c:b606:2b2 with SMTP id 2adb3069b0e04-52ce0673b84mr2577772e87.46.1719219939772;
        Mon, 24 Jun 2024 02:05:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3664178f5f7sm9323088f8f.19.2024.06.24.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, Tejas Vipin <tejasvipin76@gmail.com>
Cc: dianders@chromium.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621131648.131667-1-tejasvipin76@gmail.com>
References: <20240621131648.131667-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH] drm/panel: asus-z00t-tm5p5-n35596: transition to
 mipi_dsi wrapped functions
Message-Id: <171921993900.3622623.7767680483331122397.b4-ty@linaro.org>
Date: Mon, 24 Jun 2024 11:05:39 +0200
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

On Fri, 21 Jun 2024 18:46:46 +0530, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> asus-z00t-tm5p5-n35596 panel.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: asus-z00t-tm5p5-n35596: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/47e851ec4c02e8cbee95614c3acc746ae7551dcc

-- 
Neil


