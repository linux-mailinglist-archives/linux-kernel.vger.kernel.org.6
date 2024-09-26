Return-Path: <linux-kernel+bounces-340223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07805987024
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067091C2171D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0B1AAE0E;
	Thu, 26 Sep 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NGtdJwD4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EC1AC441
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342985; cv=none; b=kq7eWsEog/zhNs7wztlAMmU6Nm7OAmzhTkWaaJl6RAzNimHLxdwnctmi7h4eSHLA2iYsLyqbTksIFz+BPmzHQwH33hmhLJS5VEhmmU4NTsWUgOFXWzgDvEkS3iqD4mH/BVNpiJ4VfJe7ZD9tPkON1jVnVFXyy5qzj/vy3TC7Zto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342985; c=relaxed/simple;
	bh=tkrxBATaBcqKod9pjIDQEXjlc5uLNRjLyEp3j7CQA14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkpl7cAbG2pJ7c5e7wNO2mAHmG9xFkCQYsTK5vBz2P8UybrLb9h+u8M8XFKmwGFOsckdqtd/j/0Z96f8OL0QPFgKxv/rUb8dSo4B5qS9/OQOIeNE70mBq8QKz5P1zqbciJFcY1mpkihoij3jqORFrgKuKjW1FDUoKizCeyFa2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NGtdJwD4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068bee21d8so7903275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727342983; x=1727947783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhqiIDQ5Jqu/fSndHOna+E70YcD1T5+jR0brWu5czp4=;
        b=NGtdJwD4mHXYbWYmQEyo7ok78zUOtpO+axlaDLXkajJJYzfprG1dReKutopXKn2Sk/
         pHvpl6Da9+jnfERM9lcFHAtAzk/v09IX6i8LW9uNUi1vga//0PT9w+c5RRWko6BrOsih
         W5j2qlFlUOsjVu0BQWFm/VzzvjQjupLf/R2wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342983; x=1727947783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhqiIDQ5Jqu/fSndHOna+E70YcD1T5+jR0brWu5czp4=;
        b=DkrROk+fH1yOdUwswp35TFxbsHYRoQy7UotUT+KuWcG+5XwDLOfE0GfXvHpWYRTmJF
         ZSj5ar68p271mECGWHMmd5XRTcGWrH9pPvZ6y2dDLDL5eIzEiroQwABO9f+dLbNg0A+t
         CVpaKALE/BT13UC0ipFyYFxc2PXkU4rIZb8Tsly+PKSvtCroj0BvIdC35PCfcHB9H5Lm
         GccNwy8E8WJlwSZp0sKfyXU3awIlnZFjtN/I6NX2K6hm2x1CVEFhdGV8+MMUOVGTT8AN
         vvgoRCR5D+YZmLEupHC4J2IRl+8ekPhfn9+rWDFh83NpjjObCpEZnFNWKUXN9H/rvxko
         jMHA==
X-Gm-Message-State: AOJu0YwTVd6DlmIM1qzIfOECO44cpK12CeYus488QBx1n8GDuWmbMBFY
	OyxPNIlz0tEiS1LMqvJGrCDXgBr1Hs1YGwJwLMAiGMQwwIdhhcjiMJ8yyxEJjw==
X-Google-Smtp-Source: AGHT+IEdG39v0Vfwfch9vcjFuBKfPvx9YOlmD0blQWme8C0zQJMHMM2ZuXN87DCP03QyVmgMacA7Sw==
X-Received: by 2002:a17:903:110f:b0:207:1737:2c66 with SMTP id d9443c01a7336-20afc4c127fmr79900895ad.35.1727342983478;
        Thu, 26 Sep 2024 02:29:43 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4234:cfaa:3b83:d75a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1720b00sm34819105ad.64.2024.09.26.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:29:43 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Xin Ji <xji@analogixsemi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/2] drm/bridge: it6505: Drop EDID cache on bridge power off
Date: Thu, 26 Sep 2024 17:29:09 +0800
Message-ID: <20240926092931.3870342-3-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240926092931.3870342-1-treapking@chromium.org>
References: <20240926092931.3870342-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge might miss the display change events when it's powered off.
This happens when a user changes the external monitor when the system
is suspended and the embedded controller doesn't not wake AP up.

It's also observed that one DP-to-HDMI bridge doesn't work correctly
when there is no EDID read after it is powered on.

Drop the cache to force an EDID read after system resume to fix this.

Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v2:
- Collect review tags

 drivers/gpu/drm/bridge/ite-it6505.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1e1c06fdf206..bb449efac2f4 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3101,6 +3101,8 @@ static __maybe_unused int it6505_bridge_suspend(struct device *dev)
 {
 	struct it6505 *it6505 = dev_get_drvdata(dev);
 
+	it6505_remove_edid(it6505);
+
 	return it6505_poweroff(it6505);
 }
 
-- 
2.46.0.792.g87dc391469-goog


