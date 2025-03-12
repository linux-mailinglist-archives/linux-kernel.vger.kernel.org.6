Return-Path: <linux-kernel+bounces-558596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49640A5E859
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EDA17BD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C211F1927;
	Wed, 12 Mar 2025 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgORXqKf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B591F153D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821806; cv=none; b=VXZDTFxIqmRwz77GUIBNQytUUL0ZCDYTis/CBA5eKcGYoTte60FnAr1nqiS8wc2n9jBvw5bSpeG3W0/ESFxS40o7HjspuDyqk5DnE56TGPTnQ/cW/fC7PFgh59dBkCuHXIJHg3U+sxgiRFLUOuj1vpBN7LpMow0aw8USLrEP4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821806; c=relaxed/simple;
	bh=4YZluZGJ4DEMVE+2SA7gUODIucELBWly4WYu8TV+KoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnPVjH3T592Mg77QjlSO+VtrhPuFYeQp/dhgm2eZnoPHfdG4dyj/gf6eHRgSn7mRQt3yCHJkuBSQh3KjXDz2XOICv6S0bgnXt4CJNShdxtgZvfGbPdp6GF4I0TY5MT2WjcEsn/799NmNjUGUL+bd7Sopjh5HtGqnGld0lOAYt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgORXqKf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so511252a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741821802; x=1742426602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zrV7lfXICcs3l0g4L6oSOhAbz0Vn05AYlZgbp4rDoM=;
        b=BgORXqKfsyu6Y+MwYIn1M7hG+Ex6XibHbHD4DFpRmi+V2+VXaDRgWHreFZ1jDsUGST
         XVDGEWbrEe8CRjI4s38Rdo+j/uQ/syZH0f2cxM+a/++dA9t7ENlZiMIbmIU2/I8GFEXd
         5w0IkO7vBg27jswvr2DMgwOBBEPjD3RarAWKPfBB//RnRGDH2VnW5UFvrEkBVQ/pzyBg
         3nCs6u/qIWzrhYnZVgOypf9Uhk4y0FE0oqWhIGb9JX8DsAYgmpw0DpZkd2OQEoPU1Upm
         vkd/Syxc3IUZIgCq0DnR1U0ZLTC6uUD9iqi+FDz0LyB8nEnglbNuM3EqKoFbgKcB2Q8w
         AyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821803; x=1742426603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zrV7lfXICcs3l0g4L6oSOhAbz0Vn05AYlZgbp4rDoM=;
        b=BluXEwFbCegLdz3Kvmp7XjHPEMa/cuieJ0a/eRAeZt0uYQXpoceVrxuIU1bWGRVVeL
         UmBa5ZkZewW6PflVNdfnqjuakdiFzTORY/5bP6VsDVsW/eI3UUi4JHSjc8ut1Ml7LGJI
         F8vscrrD2S3Zkck11A2HfDhR8/ddon9Jz0H7Xql6hlZrhiMdx7LhO7Le3rWv1q8Vce6Y
         2PbGGwzuLouN6TBNsFDgbQKPmVRqrevZ9BNtTo5ZUqTvxT87FF/412BP8UfWBjebzUui
         FL9QwW4Uuv/mGs1ACgutQZ0cRF3+HG0NarpZYZrHcJH865qI3njEB70zmy2u7D+7Y8IM
         CEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtR1osLk2pZnCeE5ZAIYW8LHweGdj9m8PMl6PErykCZIq/g/SUde+XzFL3Rm8eEcMBIJKKhkgWeVXF79w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXKdoe3/OL+BtaSE+F4yXW9N73eWllk3jVLTkduTPHk6JGMip
	4JBtIbDv+CPxjfD6vi8bpzPr+9SVvGZTXVmNikxXA6gx0DAnI84O
X-Gm-Gg: ASbGncvjgxyd72HHwW4ApkYuiu12UOGf6Dp7SiwXR0wtsXWgj6zQcd/rbDe2z8R/AKw
	cGA7FqzEavSx3qoQnX49E/NdnXWArS+O4Lvz58VsiGYYjTtOhyyrz2wMQmst5z3Onqsq8a/HR+8
	iOd/UBIyyLvQ/pgUUdSl+uXwwuz4m/IQLP4C/4eRVpKBrW0EgiGcuY8nuok5jPv6alzvGWRRUqM
	e2Zi86eo3t/lIJmFtQM9mIk/2GbrtzzQKa+Loc5mLf5dNOugL1XCcPrMwhBesBkd/lq/1FdZ2vr
	d3/w7Ng3zgxc7FRl+6Cq0K9iR9ElAwqGBX1vJ4g2qAFuboJWu7/unDBmjQTk6VvSP1wQa7NWntb
	Elg8EzItb9HlAOu7+ddIDYLiUFeVxEIo=
X-Google-Smtp-Source: AGHT+IE/HS7pBbJiG0dtxqr09NjUVWMflt711bAAkhk0a2Jd0FhTvLGrwUMbdOg+tiQiWKRSLoGTNQ==
X-Received: by 2002:a05:6402:430b:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e5e22a79ccmr49699585a12.5.1741821802314;
        Wed, 12 Mar 2025 16:23:22 -0700 (PDT)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe223sm26732a12.70.2025.03.12.16.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:23:21 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] drm/panfrost: add h616 compatible string
Date: Thu, 13 Mar 2025 00:23:19 +0100
Message-ID: <20250312232319.25712-3-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312232319.25712-1-simons.philippe@gmail.com>
References: <20250312232319.25712-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tie the Allwinner compatible string to the two features bits that will
toggle the clocks and the reset line whenever the power domain is changing
state.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 0f3935556ac7..f13743fe6bad 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -776,6 +776,13 @@ static const struct panfrost_compatible default_data = {
 	.pm_domain_names = NULL,
 };
 
+static const struct panfrost_compatible allwinner_h616_data = {
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 1,
+	.pm_features = BIT(GPU_PM_RT_CLK_DIS) | BIT(GPU_PM_RT_RST_ASRT),
+};
+
 static const struct panfrost_compatible amlogic_data = {
 	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
 	.supply_names = default_supplies,
@@ -859,6 +866,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
 	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
 	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
+	{ .compatible = "allwinner,sun50i-h616-mali", .data = &allwinner_h616_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.48.1


