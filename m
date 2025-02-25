Return-Path: <linux-kernel+bounces-531828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA165A4458A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AA53A7259
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84D18C034;
	Tue, 25 Feb 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iGWrr319"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B32EB02;
	Tue, 25 Feb 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499704; cv=none; b=D//gu3mG8r231LV9ODHBoWzMeXx8G2H6f79E3Ckx9mFcarefoeqW+8QBADgh30flpDlwX9bFngx2LGDpzOmIdkJM89VdT7QT21P+GWl0v15Wg0+3bH2UigfnzL1NVxxBUSv1uKMlleDhhipSnPjm+I6vE/Okro0TSu4m2C9dOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499704; c=relaxed/simple;
	bh=o17bnnQUEXgXrnp222u+zUnN4w91QL0V3CleEpaxZOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=roZCfnhffgU0EQ94reQDVn3hLDylrQxxIn1+Ospq8XnVY7XkzFEf47Sep3WpYU0ttdNsmB/DfdvBTZu0SHKc5qn6eMgoOdx7cOH5XiAECw6sgIPSsmtgYWfRpg6YE3ISHdGEN0FdzZl/4pu4bF9Op2g41t6XvUJpm0Di+z6e2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iGWrr319; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740499701;
	bh=o17bnnQUEXgXrnp222u+zUnN4w91QL0V3CleEpaxZOI=;
	h=From:Subject:Date:To:Cc:From;
	b=iGWrr319DTRYgkygkqseNbwdEGNgbtMrUWhx5OJcShHWoOsV6WRvC1GNwOP6Ld8H9
	 MyDVHGuB/48sTTHQKTZH79JMwbszVEUL/0n9BRSf9/xZwX6x/EA00QLnQm3HWQVyJF
	 X7RYO6R6VNpJ4CIBO2WUezLAKZajvIkf9Eisw6mFPL62xtm+qqbYjSucNPE1ZW/AvQ
	 X7yj1enYCamdNmbewkZ1oVHMhmvWvVOetkuwh6e9HDuxt6Gy+HdDcaSAIAYu2XEaXJ
	 PMorJ2P4M0yjaGga9J6hO0pSOx0kSYYzDFIyf5DoWN5L5AFxSq8wtlfBGSxZoqUHxh
	 pJ6Q6R8/A7x6w==
Received: from jupiter.universe (dyndsl-091-248-213-055.ewe-ip-backbone.de [91.248.213.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0155217E0CD2;
	Tue, 25 Feb 2025 17:08:20 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 83094480035; Tue, 25 Feb 2025 17:08:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 0/2] Rockchip W552793DBA-V10 panel support
Date: Tue, 25 Feb 2025 17:07:58 +0100
Message-Id: <20250225-raydium-rm67200-v3-0-d9e1010dd8ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN7qvWcC/3WNQQ6CMBBFr0JmbU0doqWuvIdhUdsBJgqYqTYS0
 rtb2bt8L/nvrxBJmCKcqxWEEkeepwL1rgI/uKknxaEwoMajRm2UuCXwe1Qyngxqrehm0dbosSE
 PZfUU6vizFa9t4YHja5ZlO0j4s/9bCZVWhy54i8Y5avByJ5nosZ+lhzbn/AWwbwqhrwAAAA==
X-Change-ID: 20250207-raydium-rm67200-eb92932c28ec
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=sre@kernel.org;
 h=from:subject:message-id; bh=o17bnnQUEXgXrnp222u+zUnN4w91QL0V3CleEpaxZOI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe96vSVn6Y7aMxiITtnCu8ax+TK84NwxHoEf
 weDzDjX4vspT4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnver0AAoJENju1/PI
 O/qaZdUQAJZTcEAUN2kjIn/5R4AAYf1JaSIzz7Jqj9GVDY1s1C4XUGnWp6z4hGih1GTKNrxWBQL
 Fm4XvnSAEAG/yfRuWRAdhiqrivWiVbgVtps1OsW6evUeF1nWJsY2421mIDTFowgeG4UI8HPwmrA
 +msmPizod5EBJ1IsO5mgqSaLsyLjBd7TWpyxsni8vA9UC4F5IvxdhqApkIADn0FXLVLVnxyEcIS
 6eDgrOP+nRLgaVOeLu6es9Rp72tyQimLZdue6JAfNq8p8cQK1Hym1Qn/TK+2iHoUbyc3TaWvM7q
 6F33ZEfZXCX+jhgAPu6gUY1vSRbRqmXv9kX3WAvJJTqqV8LFy4cG/JI5rZ5AM+bDT6Jg9K4JBfu
 veNbPRyL4yK9w+QQdJULG16T2Yt4BZZGDr4EjBdScD30bDuxffkjfBJ4ZxkpZku8afdcjIfp1DP
 f+GxzbKaFL7ZK35NysV8TM9agE1vN3tBDwjBDOPmJI+y2tk1KBv5ktStebn2KAmn4h5Yfb+6oUg
 hrCZ/+0FE6LHdmMogffZFoCLYtNtxftz7rHzpGDO0CwUDBMSruuAKJVdGcJ0T88Cg6SdvBrOcVJ
 E0xuW0cux5EslgY2fRQK3TySyTRkpGzFltrRt39rs8rIJPbw04ikwcH7RoKhNjGy44kamee9zcr
 n5jMRst00wVcsyOSj2gwyiQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Hi,

This has been tested in combination with the series from Heiko Stübner
enabling DSI support for the RK3588 [0] (DSI controller support has been
merged already, only the PHY support is missing) on the RK3588 EVB1.

[0] https://lore.kernel.org/linux-rockchip/20241203164934.1500616-1-heiko@sntech.de/

Changes since PATCHv2:
 * https://lore.kernel.org/r/20250207-raydium-rm67200-v2-0-1fdc927aae82@kernel.org
 * replace upper case hex with lower case
 * rework final sleep in enable and disable callbacks
 * return drm_connector_helper_get_modes_fixed result in get_modes callback
Changes since PATCHv1:
 * https://lore.kernel.org/all/20241210164333.121253-1-sebastian.reichel@collabora.com/
 * move additionalProperties below required in the DT binding
 * collect Reviewed-by from Krzysztof Kozlowski, Andy Yan and Jessica Zhang
 * improve Kconfig help text

Thanks for having a look.

Greetings,

-- Sebastian

---
Sebastian Reichel (2):
      dt-bindings: display: panel: Add Raydium RM67200
      drm/panel: add Raydium RM67200 panel driver

 .../bindings/display/panel/raydium,rm67200.yaml    |  72 +++
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm67200.c      | 499 +++++++++++++++++++++
 4 files changed, 582 insertions(+)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-raydium-rm67200-eb92932c28ec

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


