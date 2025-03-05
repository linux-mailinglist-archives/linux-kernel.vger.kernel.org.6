Return-Path: <linux-kernel+bounces-546864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D1A4FFB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EF3176783
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC624887A;
	Wed,  5 Mar 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzWEhalm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6589244E8F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180006; cv=none; b=mEWDAjgWd05h6k7A7u8kt9l+tyXLLDa6IiZhRC0M/wB4kFPh0YJNIz9RVNH0UsDXjlUV6bEM1+qYesYuVSkB+mbaDuDijt5+goh/zZhG9/kEDqK18nzHHYiyPrLmCn0EpzwSGlFWAREDKdBAzCXwUilUBeUkN9PHSrBis9ZQHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180006; c=relaxed/simple;
	bh=BvsTKZrTmJtBWMLNRcmoFZmyCAxTZH+npaWxoS3hl3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx3bT0I1b8P7k9d3BIdi4KkTRU2XBeeovFC/vwsd91muD8TF6tDfMslXif5lSggd8OfRykQIGMSU3GOLrWx2kw3v+oE471uyXb2mcT55Fc2pbGZD0UV7jXQLKo9/+rOYtcH4g7p8vKNy5ivrjwAXvTdwtnm4cdUtK4sSbHVO/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzWEhalm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11114398a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180002; x=1741784802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvA69GRM940nbh4WvjTd5eG8jH1Ow0PBoCzHHS2i3Ls=;
        b=GzWEhalmhDsyQTnREW1kBlDeGGPadjXbWIbImd9oa9hF6Mdi6qXYkYmwyXM9p9+QKH
         JNtjf6+QaefbYFq9mY7R2AGQhUEENJRW1x6s541XoHeSyeHwUfalyzUFMaNtZmbos/3E
         yOuueveo5CZJIvzIrnhPRQOuUKDR/lm3484SnOzruNqjB5zxclw38uq5WE9oW3QlpMmp
         tkYilKpdP2/ZKXFwSPOG5XAspUkX/Sq3lG1CJuY7EBGjLG7o48TVdGgO2RTaEZExJ8+K
         tFpGQtl9wAjBXtIbHn0lVQ0iBp0ldiwWFaPG5G/cHWbyi7fngd7JWhodzqK/Bd51Oluc
         1Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180002; x=1741784802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvA69GRM940nbh4WvjTd5eG8jH1Ow0PBoCzHHS2i3Ls=;
        b=ep3X94PI8lpy/qBJus6wI9Y2f1PKapIVrj2nPh+w34PvwnmTA7llVBUWOmEauUlt8m
         5oJmZqZy4VEQ4F6GV/p8zMZoS4ZbDEf/MaZHylEyRAsdR/2xf6EqVJKdAFuTCPFfwcHG
         Yfxd10RgV0u7QBPSkFkEYqWAn9wEWc1H5ff6IM4VM81EJfqCLqM6pH1bV96KoJsvgmKl
         XNiqkB7u0/4b0FBnx9og0N4QxTchkaAGKLxl5aFdCbRJViCZX6jfWRU1rSu6uJGoFv3+
         5ktRHGivtZwxOOCgnkZNCtsc/pukLXNyFrXSU5PWKOeBSkGLoa7gB+f1D7IWkD8z++uT
         lkzQ==
X-Gm-Message-State: AOJu0YwXTZ3LtgYBjHv0WdZRdJTjDYQ/kuIQ5YPUqx+AGsZP9krmmd8f
	QVT8qVNlCrGGHNf2VqzBqFZhkgdCAIKI+aQdffrc7SNw+TorFno9l/DtB7gAxX9Mm4GNffJwZYo
	wuSU=
X-Gm-Gg: ASbGncu9EyOeXFtQbvG4C6muNeDZGChdH/u19gfea8HFBXjZeTNk5bSoZBl+EJhG7tT
	yhzv3cpkJDVi6ocCwwb7+UHmnS2H3VIWhbQjEB25r9pmfZypTG8XjC4NCRBfNJZ7RzlTPrX4T73
	b5JLEO8k6Xp29bAJ2tgt/xmx9EV9ssVj8m8WpHzqiKuYM0Z6780kJ59L9xdlSUEiOyimj3sMXBy
	CqB3ZLvKLcqEJI/kslKoi6RpJgudFwzd0Pp278sXIevhbDTzPk2lfQZTog/LprQp8zIBLCy5fgi
	j5F9LpWkzfj8vn7P0BYFyOkEFL5Syh4qAUJsWz3ufC1eTFIk92cgKi3Qnrazu+QygkQSXy5ttcH
	oUmpc5bzukitf8oBUTbkp2A==
X-Google-Smtp-Source: AGHT+IEjtiBAYCTH0+e95UXzOpV6Qk/1lP6TuM4iQbwFmlqCq9fGF9wURhaIIhsi+UMHMk8/oJkTeQ==
X-Received: by 2002:a50:c8cd:0:b0:5e5:bcd6:4ad8 with SMTP id 4fb4d7f45d1cf-5e5bcd64d5amr155764a12.9.1741180002364;
        Wed, 05 Mar 2025 05:06:42 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:06:41 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 01/10] tee: tee_device_alloc(): copy dma_mask from parent device
Date: Wed,  5 Mar 2025 14:04:07 +0100
Message-ID: <20250305130634.1850178-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305130634.1850178-1-jens.wiklander@linaro.org>
References: <20250305130634.1850178-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a parent device is supplied to tee_device_alloc(), copy the dma_mask
field into the new device. This avoids future warnings when mapping a
DMA-buf for the device.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..685afcaa3ea1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -922,6 +922,8 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 	teedev->dev.class = &tee_class;
 	teedev->dev.release = tee_release_device;
 	teedev->dev.parent = dev;
+	if (dev)
+		teedev->dev.dma_mask = dev->dma_mask;
 
 	teedev->dev.devt = MKDEV(MAJOR(tee_devt), teedev->id);
 
-- 
2.43.0


