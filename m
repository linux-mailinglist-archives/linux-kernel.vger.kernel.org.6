Return-Path: <linux-kernel+bounces-182571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC408C8CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECD51F221B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AA140368;
	Fri, 17 May 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6g3Z4Je"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFB60B9C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974782; cv=none; b=j9HExS5ZI+zCmbD1ZvPmhwJ9oc6i+DszkJx6HiwP/t4WEWo8fP07ZOeZtp551XF8iVg0i6FVhBCh/CIfQY3mHE2F9xB3PkuT+hM6ilNWSZ2S0ahKhgvwXpAZYjRQyh19aA7b5aZjhx9B9bNMS2RZuf9Meb0VHMMaoLCffZIlBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974782; c=relaxed/simple;
	bh=C8pKzvw/5hNHJKtlhX6/Y7v+Xr0n3EsItrpKEUodDHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wc5rkrqk/L+jko2jxrlpD6aL75DpI0PWsvLyp7I06w33kKhrD5bReZFykCc6zlZqH2gPQmVKkhZWKQ26lo4s3I9mgPnICq6hWhu04/uaWnJSXnAsJJlrEd50OSVuWUnQh7t1sGkbw46sJ6ESofGXBUAPYLQaeNxsjH/KQ2ude3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6g3Z4Je; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so322348f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715974779; x=1716579579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUzOmIQGxK6ydFQshiBfQGlmu9MnDcgDBCtLK/DC/PU=;
        b=y6g3Z4JeCb7ZYY05nbH+e61DBAUsoXnkXT2P+O8O+VrME22pZgofEoYw+8C0SLDeKu
         fr3QFjGbpVlhs4yQkvWxOCdjM4QugwwGzYg/qr6JvCMBEN8xz2dxgxI0BPbUh3wXaCpN
         sZbMSb6kFQWBswW2yWruOv2aKkQg68TMjtPGAZF/3cPxO5zcEKCrJnlQjI9fl5gCV77z
         K14uOF4cItJIBfAt5US3cVFJDddcEKklbetN7JcC1ZTuD7VWj6LiwWKQE6NeG/7zAJ2A
         E9biuOfIxUXiQ22zOMI+eVQRQjpUYHUh99CxKdga1E1vMxVeJkyBkO5qw2Zl8X6zusVW
         L0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715974779; x=1716579579;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUzOmIQGxK6ydFQshiBfQGlmu9MnDcgDBCtLK/DC/PU=;
        b=Rh3SdwgJOs/jRt/hs+p+xyzuFV/mS6THIohntH8y5qzFZFOnmRcIlExkM/glZC7cVz
         3KWRyUotjef4Sg9BoHXeQ10iNwOnzq4c/jNpXSVH59g06qymD8/99E7Ob5OILvxP1yLI
         5f69hHUcg6a3u6S6+K1X7udPSjkdkFnhiZ8VxB7rFfug1TnwdSBla8qIYyCCIxgoPY2Q
         w2cTbzRmq/zVsFoASaQBlYgygDL+46aKqhr7xIOzBNGL40kryyF0qG5ZG/nktCAhz6WM
         RM1HKmuEoezmtrR8JN3Ns/uv+6zNH68oQUh65UrTmyjuzzlx2UL8pQpsgQolr/ROajix
         3adg==
X-Forwarded-Encrypted: i=1; AJvYcCVTNLPrZOs0lPjNjGsumtfV4zsVMkVSRJOuMPsz+eoF1RT2lt5i4d696zsLdF3FKtbJEKbfE3Ayg6h4+NYmjsk1aYG5AqADMcSMOUql
X-Gm-Message-State: AOJu0Yx03n8pN1bA7c1y0oRYJzNebMwK3V8rGS3UIC03a4hC3Yd2tirp
	Hd1q7c3XI4qitc4a1z9GZ+kig/DOzoiSWAAlJaC8wfvyHF98jO7FQXXxBXuHja0=
X-Google-Smtp-Source: AGHT+IFhShctHyp8EaDT1M5vh90xyK1Rl4BoMfuMGmFlgl4IyMT0z2z4s9u4Lc/iZXmU6IVZDQbEcw==
X-Received: by 2002:adf:f652:0:b0:34d:7bbb:8d73 with SMTP id ffacd0b85a97d-354b8deacd1mr80637f8f.2.1715974778795;
        Fri, 17 May 2024 12:39:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7748sm22436970f8f.49.2024.05.17.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:39:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
Subject: Re: [PATCH v2 0/7] drm/mipi-dsi: simplify MIPI DSI init/cleanup
 even more
Message-Id: <171597477767.956878.712053114259327285.b4-ty@linaro.org>
Date: Fri, 17 May 2024 21:39:37 +0200
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

On Sun, 12 May 2024 02:00:17 +0300, Dmitry Baryshkov wrote:
> Follow the example of mipi_dsi_generic_write_multi(),
> mipi_dsi_dcs_write_buffer_multi(), mipi_dsi_generic_write_seq_multi()
> and mipi_dsi_dcs_write_seq_multi(). Define _multi variants for several
> other common MIPI DSI functions and use these functions in the panel
> code.
> 
> This series also includes a fix for the LG SW43408. If the proposed
> approach is declined, the fix will be submitted separately.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/7] drm/panel: lg-sw43408: add missing error handling
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/51f9183e4af8c7f00e81180cbb9ee4a98a0f0aa1
[2/7] drm/mipi-dsi: wrap more functions for streamline handling
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f79d6d28d8fe77b14beeaebe5393d9f294f8d09d
[3/7] drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/91329f921283b995ac125a0c6e61be0c1399f66f
[4/7] drm/panel: ilitek-ili9882t: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/510ba36e86eeb3ca89326dd51da32806e1ede693
[5/7] drm/panel: innolux-p079zca: use mipi_dsi_dcs_nop_multi()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0f43988fb9c1c0a0c2f5ccf2d1bdb914f6e4e79b
[6/7] drm/panel: novatek-nt36672e: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/67ba7a82d99a8a8b4bcc1b8124b5640c63dd51bf
[7/7] drm/panel: lg-sw43408: use new streamlined MIPI DSI API
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85cb9d603953d77de5cb311d229a79c439ff6bfb

-- 
Neil


