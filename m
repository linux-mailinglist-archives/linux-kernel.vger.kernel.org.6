Return-Path: <linux-kernel+bounces-242047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D939928317
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA501F245B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F59144D01;
	Fri,  5 Jul 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyvSDpbV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DEB143C7B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165746; cv=none; b=es0us6OWGdOIHzNCj6bD+ipGUDADSB8hw4+16669mYYrd/UN8ZTjmzbcE4B519rkqycW0mHH2yFYvcSVlQTHQuk2BxObISeR9g8pUv8AAfiiDUhbkG60JkWePQ0zsSc2IqstFJg0B2bc1y85LSlEwb0DnvEWlaOKWjlY3fs2zVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165746; c=relaxed/simple;
	bh=5PZSYDowGylZVqi9njrgUIvPfZx2sRxsmqqmRE3RdVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xv1epTfEETmK799Tnz3BSGwUUgqXuJounfpbq+/RIJWVKqS2FBivEVAsDq32vcwHk9SGb1o5VAn2ueilIYhgCWukWrs+6FoXr8Ul/kNSHdFFOuFBumQgcgtq1PbZm7YdkiII5DR0WYWycsXS95Vux1xseX6I6Q/TwfhBhgzgVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XyvSDpbV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso9753055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165743; x=1720770543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROBwS1Ob0EBr5MMqmDztekW24IewkNmMB71M91TqFx8=;
        b=XyvSDpbVeNbajHzRgo7s52P6ud+1L7w3RXlrX6Ng0HmN4NBmNUomq9hkJqriQPuXcS
         g90Ord9pzfnAyScXiIW9GTN9EfoPD9qFwcb/B/2/Z+Rs2qIOCE3hj+ms5FIaHmAS9dGc
         SIEqGjtIoTHkUuHgrrBnhoRLuKaN2zu458Q/Vt0bkMe2HMB8+pDViWnLpK/5L7kyRAgH
         wULpjQbk2X45kvetvhN44K69y+GKLYMsIdLjXNnFjKY3Pl4yF6DAM7U7vf6rPLvgYD1Z
         c6Vxnh5X6B+M8Ru8vVlMkLtgMhr/FfwWOH2h7vu4zXUkrXZDWErFvuMznPkO8yPraeMu
         x9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165743; x=1720770543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROBwS1Ob0EBr5MMqmDztekW24IewkNmMB71M91TqFx8=;
        b=F20yPm6qQpx1gENs0rTsmlR+vpcz0PMMdmZ67mM3cauiwRUce3kdp9NXvG5iTckGQ3
         rmOdtMq3eemNX7OgEG1uMD7LVmHxLTT13bxFqEXMrHbtokZOaB4lzOPWN6b/8KuPe5Zx
         gH19Z5cVakSCYSdEUWnAh7pkRHOlic0Kp4DvhXhQ1/nqN9da0YYZ1InRMxDUqay0rdp9
         s7IPx6uZpJ1yqnrbASvz/WzYlYRQx8Fk0Qn+AIloQslWGEKsvndXHc+fGrX1i6fE58ur
         90g7YOVpschuHFAm3F4rt4I5atrC1UsldeboGnmhGhnOlhYp7vBBK8cOOJhyxUAvzqUT
         0tpw==
X-Gm-Message-State: AOJu0Yx9uZzMzlz7QnNGbXGsGXuKWG7jdiTwFIMkYMWKbvwGDUj4AbpL
	2UBL1AdQ1Kehcf3m7C6pEWKq/hTg5H332d0JtPeskXQ8E/rO1pTQ4SlgMpLlM0A=
X-Google-Smtp-Source: AGHT+IElTpru/6DwY+Bx+b8q8d1Q7red+6vnh7YzAxoQt/WFykX3Gdt0fARm4QRi0Ti8WO53lA886A==
X-Received: by 2002:a05:600c:480f:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-426593c93camr2480235e9.6.1720165743481;
        Fri, 05 Jul 2024 00:49:03 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:03 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/15] nvmem: patches(set 1) for 6.11
Date: Fri,  5 Jul 2024 08:48:37 +0100
Message-Id: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in nvmem for 6.11 that includes
- support for force_ro sysfs entry
- enhancements for rockchip otp provider
- support for MT7988 and MT7981
- few cleanups in the nvmem core

Can you please queue them up for 6.11.

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Heiko Stuebner (3):
  nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
  nvmem: rockchip-otp: Set type to OTP
  nvmem: rockchip-efuse: set type to OTP

Jeff Johnson (1):
  nvmem: add missing MODULE_DESCRIPTION() macros

Marek Vasut (4):
  nvmem: Replace spaces with tab in documentation
  nvmem: Document type attribute
  nvmem: Use sysfs_emit() for type attribute
  nvmem: core: Implement force_ro sysfs attribute

MarileneGarcia (1):
  nvmem: meson-efuse: Replacing the use of of_node_put to __free

Neil Armstrong (1):
  dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional power-domains

Rafał Miłecki (2):
  dt-bindings: nvmem: mediatek: efuse: add support for MT7981
  dt-bindings: nvmem: mediatek: efuse: add support for MT7988

Thomas Weißschuh (3):
  nvmem: core: add single sysfs group
  nvmem: core: remove global nvmem_cells_group
  nvmem: core: drop unnecessary range checks in sysfs callbacks

 Documentation/ABI/stable/sysfs-bus-nvmem      | 30 ++++++-
 .../nvmem/amlogic,meson-gxbb-efuse.yaml       |  3 +
 .../bindings/nvmem/mediatek,efuse.yaml        |  2 +
 drivers/nvmem/apple-efuses.c                  |  1 +
 drivers/nvmem/brcm_nvram.c                    |  1 +
 drivers/nvmem/core.c                          | 90 +++++++++++--------
 drivers/nvmem/meson-efuse.c                   |  5 +-
 drivers/nvmem/rockchip-efuse.c                |  1 +
 drivers/nvmem/rockchip-otp.c                  |  2 +
 drivers/nvmem/u-boot-env.c                    |  1 +
 10 files changed, 96 insertions(+), 40 deletions(-)

-- 
2.25.1


