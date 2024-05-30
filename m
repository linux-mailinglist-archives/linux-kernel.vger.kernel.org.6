Return-Path: <linux-kernel+bounces-195072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113F8D473C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81641B20AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B286F2F8;
	Thu, 30 May 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mb7kFP4k"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E93DAC09
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058136; cv=none; b=JOPorRo6/oBFJCfikQ4C7ypgZZ2+FOXm1B9vCTRmd0QA2sIDED1t6YDw0eIQkY//oOrAcILpdiTnqol4Aq6jyCg1mfhvsOJ3i09XA2w7683CzTOaxH9R97wFypPwddvZGeyoQMZWP1FPqo1q4SebgwJX/2y546z9pgDMuRciYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058136; c=relaxed/simple;
	bh=2jqS2JCggZmT/Bgw5cZ1HuqlhOXJkBLK/dNVeJwD90I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rv/IXwt4G0lmBWaz4PKQh+ZV4nxcz3+gkRsrCQcewrkDiI46ct5ySvsxJUh5LzpV5goLeIGlb2Cx8cmk9LZHBwl30H7luozBmvJm29aoKx6tlfXqlW83xNsFW2VAyIo7iw4KcPsLVNuoYFsdy0tkz9qkzUCzyOLR+XIU2/pTU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mb7kFP4k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4c7b022f8so5681465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717058134; x=1717662934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHkwqtBAKIh1FT18Wf08tYxtDsD9mBo3yYE6cpTa5lo=;
        b=mb7kFP4k07RT+0hqjti94eOC+fepMqNXnLQDy6aPVIElQIzcv6GHqSAijgaBmZp1ak
         pxepHxhfiA7gG3LQAZfh/Dc/VDsTSQzrsqYtP036OYsswtaO/JQbdLLsE8uqt4miEeXc
         Gl0AEhXWLLMOdQwroO55iN2TI68cL5VELo8Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058134; x=1717662934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHkwqtBAKIh1FT18Wf08tYxtDsD9mBo3yYE6cpTa5lo=;
        b=I8d1qH3VHhZBjrDItRJYF3K66RjuA6HMWqdRxcYoEX3uliWYR8K0dQVL7jYZjvYkEm
         NEa7VDs30S1t95LRoqECteEDvF8jjrj27ueccDx3f0ykv1DceFRPf0gzoZLhVo1Egy5S
         DToSHfF9ohhBP+HaeYkMa4owzjQ3gOVHOqwa/lo+VmHqchONy/QzztsvuqlSjqdRrYBW
         BPKJvoSR/hB3HDXBIPJ4lpWqownMzYFhhYyI/XFpPTXyx5gU6YUoXP3kpukmyNXVVNgj
         uVPOpEFVWQbvKu+3aDiJji0JeSA34OAn82z63xV7PWfxfVJEpqLP/zqH36HTSMIjLKdR
         +PIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXymggxn2qjj2405laAn++rYyAPyYI4TDuxgnaVstoFGSGw1H2YR0UwpQEr/0Fswqh+8fcEzq4zjB9Fq+rfOKo3gR5SmWJqeQ0SAcAt
X-Gm-Message-State: AOJu0Yxoh7cmTcjG6fGVIk9cUGl84M03gzrl5fUUd4ztjkqvmqMA6VTb
	ef6BrkVKmDtaXldcYjbp3pGZLDbMmyPc/TL5VQOg6hIL2NCdzlI9cdpywXWW4A==
X-Google-Smtp-Source: AGHT+IGaMXKlAuHj3tKDXFrEymwDvO07A1BRFroXZlN02EvX5mN7HsOfQHvylgHcYJoSPTNjRI9s+A==
X-Received: by 2002:a17:903:2095:b0:1f4:768b:445e with SMTP id d9443c01a7336-1f619605ee4mr11933665ad.24.1717058134222;
        Thu, 30 May 2024 01:35:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:65f0:63a9:90bb:50b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f617390fe7sm10950635ad.146.2024.05.30.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:35:33 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drm/imagination: Add compatible string entry for Series6XT
Date: Thu, 30 May 2024 16:35:03 +0800
Message-ID: <20240530083513.4135052-5-wenst@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240530083513.4135052-1-wenst@chromium.org>
References: <20240530083513.4135052-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
of the Series6XT, another variation of the Rogue family of GPUs.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c3b2d58d766..3d1a933c8303 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1475,6 +1475,7 @@ pvr_remove(struct platform_device *plat_dev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "img,img-axe", .data = NULL },
+	{ .compatible = "img,powervr-6xt", .data = NULL },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.45.1.288.g0e0cd299f1-goog


