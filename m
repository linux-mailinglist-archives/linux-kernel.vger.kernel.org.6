Return-Path: <linux-kernel+bounces-364450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814599D4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154ACB23884
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14DD1BE854;
	Mon, 14 Oct 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F38Muk8+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA27175B1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923858; cv=none; b=cbzAptdzD9pjlGq9iipYLfgtl7OMFT87cuU9LfdMqLbiTyXFtdg4tHOPboMxB6ZNZxTrIBjMJ/FrxYBLrCDnV+QAckmLbQepwHkbDpzzTmYJifChPqe7nwndOrg6mvlkL4KrCaEDmIbDW9qR5a+Z6WO45mj2BI9dXHlLoVoBJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923858; c=relaxed/simple;
	bh=2/hmtua87SYdIDexDgVCKHz9vUkiTbZvg8psKON5ws8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoOs9b6ed2Gj2IpXGuWFtihpbHbT4BLpf6M2DigAXr+/J34uCGXifbJ8hRiOewWmutpBUDknTBgk9wpe/HfdRWBDDtz+yiueVJwNl4whu2BuWqlOb7cLa67fH5Qjhf6tYHnz/ywx2/6TFnxrLEduxHVdchj8jYxkagXCqzD7Ui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F38Muk8+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e427e29c7so1688581b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728923856; x=1729528656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0QDCUs/8D4jixu/KfGYmNxOa4c0mSZ3kXKt5t3/Xv8=;
        b=F38Muk8+ubO/O1hHJJUXOviHhlmfLWadzyoLHpbrlQr0n7+4u+qlkKa2PH7XxStqYm
         QM5P+hPgiwRVMKvOz1w7rDzj5ouWe90/xHTzS8ipJIhWEVRhdjuf1SKG6EXJlUc3q1pt
         OpL7MgrHofzaIVt5M36A3ou+ab51zyx8FHHBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923856; x=1729528656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0QDCUs/8D4jixu/KfGYmNxOa4c0mSZ3kXKt5t3/Xv8=;
        b=hhQTbgG1Bsuww7LwZacQDE5ntlKq0yHn7ugdj6BMeJXJBSg17+zOe6N+7qKhAPukwg
         WHJvSWWpv9yYtu76Ox3nJB2pUq8+ME8CSGV/DxHOopkLioVTkS62vjld5Dl2AN7N3krN
         xfIuPCS8HltNeIQ7LkrdlouZfgzTBswhY+Vyvgi5nZpdWPuv3L1mvXtklGh3J2qGzOdE
         JHVqYo0F6eFFmqzosBW25QLwhqS/uo52UA+nRgn9Xg9ZD/8Lu8UWm42EVd5IxLtMkzXg
         a8m6YeJf1P8Jemxh/MhF7SIeWoY55W73XPBWVGTRA4IVser2MXg3PiiYCrW+4ZCKLKYQ
         UuEA==
X-Forwarded-Encrypted: i=1; AJvYcCV+qeQURyxAf7iJszsUSyDy2SC1d0fx7mmJILijBUqV7SZib3ia65nXIIj7/CtMEyDEm9ntG5eByTuotpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGITYIUG00IC1rzssFFFmSvCLrRCqLp4LZx68nw2TGxydXAGV
	qG6rwe94ijouJ2rAfmJXNU9eBFtQlN1N+TN7HO1pXutKlYeORzFxD43sH/Oq9A==
X-Google-Smtp-Source: AGHT+IGux4tneH6GmBs7wM4quuJ0YGWj3+34YGtAX6dD/SdcV19l8y70Ofmfq5jY72pPsYNjcr0LjA==
X-Received: by 2002:a05:6a21:168d:b0:1d8:bbc9:37c7 with SMTP id adf61e73a8af0-1d8c969074dmr13073659637.36.1728923855948;
        Mon, 14 Oct 2024 09:37:35 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1e71:8a09:a3b:1e00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e51dc0617sm4383693b3a.165.2024.10.14.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:37:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/msm: Allocate memory for disp snapshot with kvzalloc()
Date: Mon, 14 Oct 2024 09:36:09 -0700
Message-ID: <20241014093605.2.I72441365ffe91f3dceb17db0a8ec976af8139590@changeid>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014093605.1.Ia1217cecec9ef09eb3c6d125360cc6c8574b0e73@changeid>
References: <20241014093605.1.Ia1217cecec9ef09eb3c6d125360cc6c8574b0e73@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the "drm/msm: add a display mmu fault handler" series [1] we saw
issues in the field where memory allocation was failing when
allocating space for registers in msm_disp_state_dump_regs().
Specifically we were seeing an order 5 allocation fail. It's not
surprising that order 5 allocations will sometimes fail after the
system has been up and running for a while.

There's no need here for contiguous memory. Change the allocation to
kvzalloc() which should make it much less likely to fail.

[1] https://lore.kernel.org/r/20240628214848.4075651-1-quic_abhinavk@quicinc.com/

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index bb149281d31f..4d55e3cf570f 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -26,7 +26,7 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	end_addr = base_addr + aligned_len;
 
 	if (!(*reg))
-		*reg = kzalloc(len_padded, GFP_KERNEL);
+		*reg = kvzalloc(len_padded, GFP_KERNEL);
 
 	if (*reg)
 		dump_addr = *reg;
@@ -162,7 +162,7 @@ void msm_disp_state_free(void *data)
 
 	list_for_each_entry_safe(block, tmp, &disp_state->blocks, node) {
 		list_del(&block->node);
-		kfree(block->state);
+		kvfree(block->state);
 		kfree(block);
 	}
 
-- 
2.47.0.rc1.288.g06298d1525-goog


