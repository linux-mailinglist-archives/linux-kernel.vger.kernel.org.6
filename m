Return-Path: <linux-kernel+bounces-231205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6891879C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7170B29478
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EAC18FC75;
	Wed, 26 Jun 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMx82WwW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0841F94C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419902; cv=none; b=ApVDb4usv3gul8Rz3vCrCRf8yV5/zhR8g9HCbhiPo9m/fOtriYCmLYXbiYAn64JQQtANrt5jnA7jU6qNirsjuamUqXvy6GB2Q4I0dpU04Puce92xFaQiYwRgJJ6aotIytabwAxrkppY1P90IT98JrA9GtPO4TMomuRSV1pzXDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419902; c=relaxed/simple;
	bh=vzvHU3Zr+sCfwD3eG4p6gIXM8d16KhRHBSa5b00y0fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=raxWzfxOZc6poxdV6YkxemxM/B2J3TK8nq1ditWtl/o0VuKXdcm2E8Hrnl7VIQXHefHfssl/uVveMRZ49X7Smx+yPxNKRUJE72pqvRgehhaZR/XMKQoBquCf4mO4qU+MPsPu4ad39I4JG6gDKuTi8KrHD2kuXDpAlkqYkQPPmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMx82WwW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424f2b73629so9531845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719419899; x=1720024699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK8ZwgbL6LYDc0eMMmr6fIedoCitRdP77aKOY/LsSyg=;
        b=SMx82WwWyLYbQqAoa31NHeRoz+9rC1P9f3zvngyTjmNI1YNGx2zgE0DNPPb1L0te4t
         yeGazgscBcFLHQENGuxF3gArH9yKg7i06FWGQyfo6oHWnipHLAOTzwHX+HTc0BFqyMQy
         CYSVWazCMA+X+uXBwFwe/KJt5nIMWfcgkPzXyZzpg7ADWefIWoNojivFlMTqu7kv3J9f
         ga9mAiZdDe/m8i+0XNd76hQc1sxfJZrKu0nW4Hfx7uZDH5JxXSTcCDlP0+ynkdBTQgNV
         xE0w1qVkIWCPeuOH1igxJWjUQQb+ucZtou1LKbyBmPAZb8pJJBIR7oJaUcxwuaf3j8N+
         fDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419899; x=1720024699;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK8ZwgbL6LYDc0eMMmr6fIedoCitRdP77aKOY/LsSyg=;
        b=vJrLjRdg9FV4GtW1OnB8DWTAB02BKb8219PEEVvJtT4t9Wb4Ozt/3+azMPik0NHwIk
         irPQZ6FynFxe9YT1SEm8kQA3Sv6v9/nYyfaXbuV1wS/TycyqXtroGtT9tPSPgjMcb0k/
         Y5z/jjgPGPOES9Sq6JQrb+PzYt2czT1EgB0Ts2KZj8zfG8gzhIo4CWd64XtJJhAR47D/
         Y03BG+bpdKYtJdWXS9TYdZXVJg3WKV+URxOPv9MvGEMTgO9+VXm0RvdFCc3S0upGhCvY
         qWqzOFKpU2mpB34UoUUaZ1F7t4n82k7/JNFq0yQDB8YkAH+PdIJXO2kEZK2uDgv/c2u7
         Q1rw==
X-Forwarded-Encrypted: i=1; AJvYcCXEMb2bjOo+RcR3mVQlycq/Mdy1hPE5ovixCyAf3Qh2CiOyXffG5dLBflcD+ks4fXG4wQqbwYThNNtuboD3nE4m/t2Kzqgs6HxActVL
X-Gm-Message-State: AOJu0YzEm3P+NgM/Mm6qOx6sWe8ojXP0XtSdsmdw02EPhSutKOXxpRH0
	M0VXXf+BU29gnYXba8dcYp5OuGQay2RSYGYEy0XjC37pQnedSB+iwWfcBN7OJo0=
X-Google-Smtp-Source: AGHT+IEh9dwmVlXYdT/VAhLvEh3BWrTtA0dvQ8UydEp5cZMMa0QzrXse2isw4cn968FkP+UNppKeng==
X-Received: by 2002:a5d:64a3:0:b0:362:4f55:6c43 with SMTP id ffacd0b85a97d-366e937f048mr12488829f8f.0.1719419898567;
        Wed, 26 Jun 2024 09:38:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f66bbsm16387206f8f.78.2024.06.26.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:38:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: agx@sigxcpu.org, kernel@puri.sm, megi@xff.cz, quic_jesszhan@quicinc.com, 
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: dianders@chromium.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626045244.48858-1-tejasvipin76@gmail.com>
References: <20240626045244.48858-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH] drm/panel: sitronix-st7703: transition to mipi_dsi
 wrapped functions
Message-Id: <171941989755.3024865.10038573806045518625.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 18:38:17 +0200
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

On Wed, 26 Jun 2024 10:22:41 +0530, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for
> sitronix-st7703 based panels.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: sitronix-st7703: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/68145ceb9b6dc5c11ecb470ccdab8e146ebf294b

-- 
Neil


