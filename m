Return-Path: <linux-kernel+bounces-553065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03FA582F5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A1E188EA9D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D4192B71;
	Sun,  9 Mar 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKU9ErPb"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126315A864
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515497; cv=none; b=VCzilBPV0WxnVsV2h7JnFkugo51s9oQztj6EqXYqUgp+5I1OxbC/VviUez6k48ashoIiXEIFAGG3bH7mXl+aBce2y0LJdnHmWiGMtq0DVHGh5Sj44DxuKzksOKzFvSZFAhH38qBN2cZaWpOkczopQvyxHNVVVn4JJ9GV+j9oRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515497; c=relaxed/simple;
	bh=tbakmBFv57E5lkmqJrVg06hqBp2O6DSckhxtVo8uVgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2dtoQWN9Ks6BQEn6T02waAlqrPJzfZglSqcUd3NXJiP2nf/KsO8V0adDrb3OangRWxDWrsdRCWy5tHyDEEjD+D/JOQyB8yo0FvC0eU1xhaNBz2E8s56pn+NIdTnpjUdaDV2HBzA1q7be3I8i8KTaB5Mc6hNQo3OZmpiXhQvhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKU9ErPb; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e609cff9927so2115577276.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741515495; x=1742120295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axZ+5e4ppBNtE/voflpOoIYftm6X1RtKy/F9SCoP6Ps=;
        b=AKU9ErPb67CQbwC+rDvCWap6ZzM0wWrss+o++faqIws6plsoVot9z5WXjlKKvItBIB
         qXCYp6c/t1V8CMErQIFJS44oXvHOq4tdtQgkqe3LyAUxTlEY2jZe2uNdKThl3NCI78iD
         uNowwwNNnRVGz0ppVw9zrIA3RaLqBPzVbBSQTuP3RnJ/2Nwh/JUFVsvv11EyzmINhoP9
         6VmlUaVmWRnI+UzFxBEshMee5xQwS3XaN9Nmnmq/cFBaciE8QywwhZdI2EOhb03j81gG
         +XkR/NKmpAZn4tadWWeBWA5FvFM9wmDFe4SEH6mVjrVRJhxmLktQw8b6UyShpKf1woP1
         Pi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515495; x=1742120295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axZ+5e4ppBNtE/voflpOoIYftm6X1RtKy/F9SCoP6Ps=;
        b=Gb9TH6R1PcS0Pd8xNhvAmt7fYXcGOxhJQX8WT5dxG9pCxgbXSkk7O71YA3pXvJqLXB
         iSxi4IBeAXkkdxmcX1ahPJEFLQMf0V3c5WhfvECmJZ7e16FQX+TFbSKVnSige4b+tArb
         aPzOQOwK8Aeb/2hNGofIIfJBNBjsJqqJQPVMIiGD3Ded7kckBqA4LbBp8hraRs1NDvVc
         nGDd95m/HqhzIZ3doF4jvVHBvFmMMRjAR0/dDrEkj/+wmkXMYQtKy/2rh52G57iElwAc
         O+95OQGLaHMiySE1FRkK1VdnWfaiZGL8zHMj7WcHbMyfoMXfX5MF3wjnwXzPL3jUuYRA
         GQPA==
X-Forwarded-Encrypted: i=1; AJvYcCWvPXdGIgv1v03rvNJF7Llgf9EC2D8rN0NwN5iSoaA5A1OSth2O5w3g6Btk5EhBQkRPviRnjK+c0DET+Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcohT69KD0AW6waQbQ8sDBUayvAdrgVlgnS57pUWYjrOhf77ww
	PYKEom2Iy0HTCasjvB9W3qmGPs5cnZpd6B1ckUUX8HYZNzNvEXd1Kf8qMJH8l8O4rnWY7rqgjNB
	umxjlujoQsvzyoyJRGVQmv7L1KHVg9M1jb6ypQg==
X-Gm-Gg: ASbGncuQbuUyxnJEtMZeCZCZqZ9C+vt9KALPcXYKjD2CFjzTUSy4drw3sH009C0i2qI
	Ejb7ng/mbAas5zcc2C5cc9akj/KK6PdTA1etQdePNRkvWZtOMrVXhUFPW6wM7TPjkEsjIQ9Lxek
	4QxO5QFWDw42vrtmPoh9WfRIpzEMUnXdtHKhz5M4QO
X-Google-Smtp-Source: AGHT+IHzYJUEBCseRpB1AtkBRhzVmaX6lTysQa7mEET1BOVVRq9VxSIkWUm8rz2mPA0ndjlMDQlVJNKo7thzq+TTMXg=
X-Received: by 2002:a05:6902:2307:b0:e5d:e04f:f2ba with SMTP id
 3f1490d57ef6-e635c1ea9e1mr11547764276.40.1741515495265; Sun, 09 Mar 2025
 03:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-12-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-12-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 12:18:04 +0200
X-Gm-Features: AQ5f1Jo4_HBXJ7xLHJUnhsvem1EBn8fTfXsqaT-YVMexvyivzGMAkeYh6r_Nz90
Message-ID: <CAA8EJppo29p+8a5VUbr6dwaE9ywgS+-VcuUH_sF+NdA0xGU1Zw@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>

Reviewed-by: Dmitry Baryshkov <dmtiry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

