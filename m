Return-Path: <linux-kernel+bounces-439389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EC9EAEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1647161704
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5022153C8;
	Tue, 10 Dec 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVUmsYB6"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852C2080EF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827655; cv=none; b=UzmXFooZ+3MQYDsR+XXI98jSwOmvdF01DZi7FWbux/FVRXqsTyLU8iumuys//lhuBk9wR/iXeMMndY/lI7zAw3qCrgP3LwL6mq3o0rDIV/+ptnfJvIR444dl+a8qQGLWkDblhTijaG5sxMYpZpqC95k6cuoWtpqdrI1kmyCleeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827655; c=relaxed/simple;
	bh=Y6HOPzsah2UWH+doev7j6bx01djyqo2znX5vVNM5uw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cirZ82mwCRxcTsf6GjnbvZXJ1Y8SiuUUkn1p2DyfPx0f1GFRo34eAt03HmsEWgr8g1Do3rfX8LRVXAzDD8QFwBuJyZQVA3uFNEJtDfmrJD3GnYgkqbwkxaS5r/UwdVZEt471M84QQUluaojsbTpa887A5KjwgbBfe3NFAFVLr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVUmsYB6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso51513891fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733827651; x=1734432451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQDk0aXlh4sHYVGoJtmtywLEY715ubkw6Pu7A3p8NKk=;
        b=ZVUmsYB6+7B56ej2gFSH+V0OBnFVCs0RIkFjVGUAuReA86A1s2Koz2HnBdnL6NMRbo
         2OenBL1VX9oNsgxJ1k3k8tESf9wT8dZ942PwT7LMrtdQ2MWgW0elmrQh5Ef5jLogM3u1
         K2VkBL9NrHmPh6vkHQyudWjRAy0lywhKBZSGwkZ3Id0pPl6mCE36OV8x3zZCqTVrmZlW
         f007+K7OkMMHeYJfp8/yqt9wiupAJHDY6m4Y0vtUrRHUVc2EalEf90ScN8YpM5gyxPil
         Ho7uoKj3IWYV8/5VGumItf361dx/wln7qIBRuKIuMeByA+nkotmnSASNayHKFG6D3PFb
         ysjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827651; x=1734432451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQDk0aXlh4sHYVGoJtmtywLEY715ubkw6Pu7A3p8NKk=;
        b=Wm7Fdu6A4nr7mtxvImE+V9R/YkcL+oOu15xhL3rq3qes3anGswbn7BGkRQkhqUcW5a
         rJ19c6/Ui4Q5RiJ3joswQFYkEML5exQ+vXblOAmYR66QHhLnIXXyn6CsMFmF+MJXxJQN
         AJ7WXJS50NXw6hX/izFIZ1XlBSpAWz9+FVZsnFWzD0VhWCSnt43u9Rna9ynzQSrUHBTm
         7BVaIyyacYlPx848P7VwaSRI4l+2e7Y+yVIJ0sFj6BcjebHgFmTsigmcXAZU2RV5h7Kl
         OTe1lzPHL7u1iN2UUgaORrdsGdn2pkpkJUFvZWv3+mW7uGE+QzgBv+qL4B2NAAOd1isW
         Qa5A==
X-Forwarded-Encrypted: i=1; AJvYcCVKEVEkl/Zy4c2B18pgdFc8GKAaN5GTMLNGIWyYR+DXQ0NerjtdIoXuzi3q2zh0kFMv8Gfwvx4LF1sW/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiYq5jsigSG1la6kgv8+68AcMsrBn6/Py6tkhsdQa3f3lCrcp
	Se5lxYpLG7IhFvfgxO4u8M5ou8LS53yeTuG+WlqjvoWk69bsllDF5qwMJq3vOk8GSDN8g1srV32
	NW44=
X-Gm-Gg: ASbGncvDleg/hTrFS+uH3pOUhaOG2oG8WSkL2xFKZxyAtPPeB/pENcLXFJ59/6lvDuP
	zvjceEZ5WZd5eqasLiXT3CtJbVSGvdAujYmpnI3v4vcSR7bmEJj9ohBZy1E+mWJCXYXehNlYd+w
	N30WAkTSnmwrY+S5LuPiomcEGWPJ8Y9pGyFawPNishJeigCS72XaiKRB+aFNFc5bMMGQDlCpDsA
	gbNTkuLsT7jjN4Shi6ZDh85t5vrRZhjvDSwDynKCE3lQ+lfG2iiJnHxcRhZu3liJ8DdychmZ27D
	vQejr36H2s8+QTpA6Wy06Q==
X-Google-Smtp-Source: AGHT+IGF344Ued8JrzMd5L5Ep4dJci9pWWxlvAO7/v42icTHNWYLEYvoA1QE8P0FlmPmE+R6xjI7Qg==
X-Received: by 2002:a05:651c:154a:b0:302:264e:29e9 with SMTP id 38308e7fff4ca-302264e2d96mr25784281fa.37.1733827650857;
        Tue, 10 Dec 2024 02:47:30 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021cbf8d0esm7343141fa.55.2024.12.10.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:47:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ite-it6263: Support VESA-24 input format
Date: Tue, 10 Dec 2024 12:47:26 +0200
Message-ID: <173382759311.2854279.4096374868344930210.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205080210.1285385-1-tommaso.merciai.xr@bp.renesas.com>
References: <20241205080210.1285385-1-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 09:02:10 +0100, tomm.merciai@gmail.com wrote:
> Introduce it6263_is_input_bus_fmt_valid() and refactor the
> it6263_bridge_atomic_get_input_bus_fmts() function to support VESA-24
> format by selecting the LVDS input format based on the LVDS data mapping
> and thereby support both JEIDA-24 and VESA-24 input formats.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: ite-it6263: Support VESA-24 input format
      commit: 919b1458ccfd33ead891fa4ad1e1d06016f5a20c

Best regards,
-- 
With best wishes
Dmitry


