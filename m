Return-Path: <linux-kernel+bounces-374286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED459A67FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A301E1F237F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BA1F8F1D;
	Mon, 21 Oct 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVkU8iWl"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7C1F8EEB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513079; cv=none; b=QdBI0tMvIwEh/9W90j7S0qr0Eim+vKdBbk6FyVUPfIb8hvjWPUmO6H43Y1PYRVz/pf6mJxEpCr7FCfB2vRztop34OPhCuECZKT2bHaMHNQiXyESIs0XF5mR+YYaxAua0U1BckY7s+K4W186AR6QB8kQHpvV8SndFymIxPmRrmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513079; c=relaxed/simple;
	bh=4giwL2CaQe0H4v/rRaHyXf8blNfxXtNrj6bnr1BfiVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBI7WlU4VK7AkQ8mSzfyIJ+6C/pkx24JtjSa/Q8CHpUBG+h7Lq8AZodPlbX8rVQIbmIeBo1J4+0z/KwFH90sQ+/XiqtHA9I/VgiKOTanKqHM4qHUDQXmO5fNz0UG8OZsrZadUw9IIoZlmFOTLD1Uz5a3guAzzG8I3fesAtxCGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVkU8iWl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so5150929e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729513076; x=1730117876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prphtPU0Rb62bRXSWJ4X3+5cxLNBcE3V+GKAi8EyFnY=;
        b=PVkU8iWlwk5lmHO8BVlS4IkookqjZjx/4frfdt/rGE2Zlnoo1iIZgHwPgG6vWEJ4l7
         ytKNg8muLJqtluDQVKqK0kZawZCUxM0i6mLyM2ORlSdp7GsZSnE4a29HDo8kQFEBvVsN
         bKdcp/YsXJVqtxC1AUyJZtgX//tK63xtYkqRQOOKa9I77Ejm1hR27CRvK1IfLs0aDsUf
         qrsZNDcuqKvVLy0Lhe6H6MRZGnS35fWHRFHUJ+DqighC1QMG7IArPqHcoH8n4FdygE5a
         u4YVFM1xWGaRsmtqx48oHzgH54ve3ZH6EVcO2R3WKRGIZzqaVZtiCMD3V0wa9llUHhdu
         fYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513076; x=1730117876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prphtPU0Rb62bRXSWJ4X3+5cxLNBcE3V+GKAi8EyFnY=;
        b=lSJ4E57t+uTwy44Hyq2J00uY+s25Ux+gYMTXwnlgBkbZyS23lmyjbjxtW0HA411k8o
         +nMBUBzHUlnKtT7vcDmV+uirq+oAEuEuJ4IqSfvbiEqLRpnrHBSbKRuRN2X78KpKScZv
         jTjPKUJIyO9PV/9p0BtVpQjZ1REVaC548A4QpNye0Pfa7kxgh6qFva+bAQvtxLC1+QHF
         A3aQfnAhOYGJkRNaJ60iSYc+GyA+0/sORCOya///7e/Gtl4maftPPS4i0D5gVj9OCaV1
         jXJq1huSwONpa/j2K3TMJzPOWio+RvY9sH2fzSHgNn/AqyJQytjFBhXtQQBdX499v2kY
         pT2g==
X-Forwarded-Encrypted: i=1; AJvYcCWf07UcfP793dMAkJM3SBkpFYDgq4+s0igqIWgkNQ4q+J2UjabXvYYvqev3tEIvHxjEaxOrRTjVQmYMEMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkqz8JIPqpYTnUSBtzEwoMRVqh4cirLOz7irfXsc1sPS/zfxDU
	Gfj8mrydO+lYFXqhB8OeY6Oyii6jmMRAFGAkQ9OUd4bRdEJsUqBWus11ANqhklI=
X-Google-Smtp-Source: AGHT+IFNrDA2mdhvvKnYVCFjWkWFdc+2kOvP18TFsD7M+Ufianm1YsNMhkTyVIEclzmrFo67RWAnAQ==
X-Received: by 2002:a05:6512:3a8d:b0:539:f1e3:ca5e with SMTP id 2adb3069b0e04-53a154fa75fmr5584953e87.44.1729513075791;
        Mon, 21 Oct 2024 05:17:55 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431454sm464210e87.212.2024.10.21.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:17:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: quic_abhinavk@quicinc.com,
	robdclark@gmail.com,
	airlied@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>
Cc: dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] drm/msm: Remove unneeded semicolon
Date: Mon, 21 Oct 2024 15:17:44 +0300
Message-Id: <172950935861.2053501.17039063548411571436.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918023357.59399-1-yang.lee@linux.alibaba.com>
References: <20240918023357.59399-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 18 Sep 2024 10:33:57 +0800, Yang Li wrote:
> ./drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c:282:2-3: Unneeded semicolon
> 
> This patch removes an unneeded semicolon after a switch statement in the
> pll_get_post_div function. Adding a semicolon after a switch statement is
> unnecessary and can lead to confusion in the code structure.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/msm: Remove unneeded semicolon
      https://gitlab.freedesktop.org/lumag/msm/-/commit/00adf52efec3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

