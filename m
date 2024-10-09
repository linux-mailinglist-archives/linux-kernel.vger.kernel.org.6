Return-Path: <linux-kernel+bounces-356472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57584996197
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D30283381
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67923188917;
	Wed,  9 Oct 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXyux1GE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920C18859A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460564; cv=none; b=hugrZswA4MxRH/e3ee/q2oxtf+sJzAlAxFcWhdpPIQuHtwDV03MJFkDr4cEb3sGieXbklXW4oOLDPDk1XPM2YdarZvBb0rut3tfbAF+q0Vov5oMROuhf/8TvYEpnzJBthClW2p4KDknv6KNpQM5RWS7xGMoMXhW56yEi/v6i108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460564; c=relaxed/simple;
	bh=5bDrW9FeH7jow12z7JCCd0C3C11s2ZFK9uhE9mhsRg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KdBCO/rgQ0OxxRMdxQ1ek3AcZSWL6GKCTphFiEtns4R7nhEUDtPgQ1RXoGsmx8971joKGDlMJtWnN1Y9dkLsSHDDghq7sp5TJENd7OwjnYpTXjKW+QOuLaYtSNw/nKYMN526SbOqnbGCrO3re1FBJwAIl2bYmIUwz7Wi+za2ARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXyux1GE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430558cddbeso3523865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460561; x=1729065361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y07+yBgcOroVjHiX9PPEthxZxo0GpR0R3sF3xpne55c=;
        b=JXyux1GE6TV7cTJNrIO8828F7lwEKI0oJ3LPmyitrwht8jXnWfrBLiUCaB1v73m2nK
         B+csatpmawL4fOiIVfiyl2vlAgvd7NzgMbV2tuaCZ8jdc738xViMBQgKKHR5XCcTlBns
         IYwkrXcDVYAnmwn+nRViHwD6wpkTeHbrZqAwCnVx9+DSAFizIX7/09/91mT+L4d2eZZU
         7TcKo+O8Rt8gMcXbqMlwfEBvJEsQKJxVoQJMroV5yxgSCR7GOCE8lYzD9Wo9pVw1K+lu
         O4o6DSr8LZsdVulvcQ/hGAa25FDMhDQ2S/79Lf8lC/AciLduVn8YHhwNypiciMPCgTxo
         46Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460561; x=1729065361;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y07+yBgcOroVjHiX9PPEthxZxo0GpR0R3sF3xpne55c=;
        b=r1znWrGAQwdtjHZtmOEMjmEZH1BVh4qcYwHo34elHgkhY2tVpBGv431kL7OBCAoYF2
         //gf5jAFiHeVsKsUj1tjO0PH0Cv3mE6YwJh2om7VROfuLJCzJ4HMLxRYOD54rIBbxk1I
         zQy7ph22g8fixamVLSMQAi1YXBKdm/QB2EpFT0m3Tqpq/FaEPDhhFRvoWQwa2DXZNoiI
         oQuDc0Mqn+FI3oYEH2wT3Du1KDh0RmAdXjaDreSnx30KWrCINdeuXRq5OAE4gDh2w8ma
         8mlPfFxJ2Bhz9N4ElDF0WzZ7esVg+AnWRkoIrw7th+oO0l38+gIcwvav2ry0q5R8V9CI
         4o6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsf5GcWjbga+QiIfUG1Act5+FikgkiAVp7Ap0jKtzaJsAO2wDpGKQRF2iRtIctQyDfU3AqJiTcbYqbCZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1h+NJHoppXxt8LP/c0jL8GfR6uSq+H5BuPvXU13f8X04gYiqm
	PQ5FK6bNNL+xD3Og9EY/93o9Osg9qkrQXPXdspwZoKQGZBvmvUtnIUluqD2/9c8=
X-Google-Smtp-Source: AGHT+IEUTMyWoKYDFs0XFyBJ4bnVk79FYy8jhwf/yzMlTPUezsEK/9UOX2RPBUTNm5wGJUbXCAro6w==
X-Received: by 2002:a05:600c:cc3:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-43069960b49mr10023845e9.4.1728460561547;
        Wed, 09 Oct 2024 00:56:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972fd9sm9660342f8f.104.2024.10.09.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:56:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240930170503.1324560-1-hugo@hugovil.com>
References: <20240930170503.1324560-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: Remove unused num_init_cmds
 structure member
Message-Id: <172846056007.3028267.12851544842489974284.b4-ty@linaro.org>
Date: Wed, 09 Oct 2024 09:56:00 +0200
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

On Mon, 30 Sep 2024 13:05:03 -0400, Hugo Villeneuve wrote:
> Now that the driver has been converted to use wrapped MIPI DCS functions,
> the num_init_cmds structure member is no longer needed, so remove it.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: panel: jd9365da-h3: Remove unused num_init_cmds structure member
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/66ae275365be4f118abe2254a0ced1d913af93f2

-- 
Neil


