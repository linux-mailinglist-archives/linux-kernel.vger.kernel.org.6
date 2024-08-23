Return-Path: <linux-kernel+bounces-299170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A195D126
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EF31C23CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3E18890B;
	Fri, 23 Aug 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PkvYxWxJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F0188903
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426071; cv=none; b=b6qc+OP9XZ9D4raO+SvZZYPyjLhjF/HbJWNDBJK4Jz/IPhdNqyztbILc07HWNOQkasmWqAn8RbDEQY0Ea+m4gMMy9XQMmGLirfOVX55WdfOBzLx4Hy7HDvtAiLkkmhq7rU5CX6ys+mXc15skXJ1rcZxnGZLos56EAOhnp1Tg+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426071; c=relaxed/simple;
	bh=N/p0U8Dss4OKDiKL37MS5w52w8fjxH1xypK3JJgvE/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tJfKZn8UlXZL8eX9TxPZKsCadupggkVXfhZlPUE6RZgy1+rYTMDbwjuyl5Qh++CwIvCSj03hm8qtm2wOmk5Fo6RS3nZhzWicgYMjiZciWJznJYFP2jnAi128SRt8x73H0VbzZEpb+dPqsd+fII4ZLZztMPXLMrpU6ONAE7dp5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PkvYxWxJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.29.25] (unknown [IPv6:2405:201:2015:f873:55f8:639e:8e9f:12ec])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1458D2D5;
	Fri, 23 Aug 2024 17:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724426003;
	bh=N/p0U8Dss4OKDiKL37MS5w52w8fjxH1xypK3JJgvE/0=;
	h=From:Subject:Date:To:Cc:From;
	b=PkvYxWxJMKxLX6a9u9xzLvCjVlm1JTIE81IutKGr3IO12M6ACZApTa2J7cKyEQtnh
	 RndLlq9rTUK/0x5fHX1tQcbxM3qr28AfltojQTPQywtkLED5ETZmSQ3FcQsyrceDQ9
	 3KG4q0gbebT4rk9ukItBpStGguSTjWwqgAYW9mI0=
From: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/7] staging: vchiq_core: Refactor vchiq_bulk_transfer()
 logic
Date: Fri, 23 Aug 2024 20:44:20 +0530
Message-Id: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEynyGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNj3ZL8+OLUvBIjXXPTJOMkiySLZENTMyWg8oKi1LTMCrBR0bG1tQC
 OisOKWgAAAA==
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724426064; l=2910;
 i=umang.jain@ideasonboard.com; s=20240731; h=from:subject:message-id;
 bh=N/p0U8Dss4OKDiKL37MS5w52w8fjxH1xypK3JJgvE/0=;
 b=H4xcZ8Pf7HBWxh3pgc6dwiB/I9GLi0ReSXwwpR0rPXI+II1W0aFk+WzA3ea9+7k9lTx1i1fwL
 9QommX3+8CvA8/SQxlLgyiYnjQjg8YxOu3Gb2Ayzz/m11oe3yO7dSwV
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=7pvnIBNsDpFUMiph0Vlhrr01+rAn5fSIn/QtDeLeXL0=

Series mostly refactors vchiq_bulk_transfer() code according
to Arnd's review comment from [1]:

> You can also wrap vchiq_bulk_transfer() in order to have
> four separate functions based on the different 'mode'
> values and have them only take the arguments they actually
> need.

I didn't wrap vchiq_bulk_transfer(), instead created four
differnet function, one for each mode.
This will pave the way to address his second comment:

> Ideally this should be cleaned up in a way that completely
> avoids passing both user and kernel data at the same time.

which is not part of this series and will be done on top as
arguments shuffling will have to fix the sparse warnings
that exists currently.

Patch 1/7 first moves the VCHIQ_BULK_MODE_WAITING logic out
of vchiq_bulk_transfer

Patch 2/7 then moves the core logic to vchiq_bulk_transfer()
which can be shared in subsequent patches

Patch 3/7 and 4/7 refactors remaining bulk transfer modes

Patch 5/7 finally drops the vchiq_bulk_transfer() as not needed

patch 6/7 and 7/7 are drive by patches, noticed during development.

[1]: https://lore.kernel.org/linux-staging/3d3b7368-93b2-4c0d-845e-4099c2de9dc1@app.fastmail.com/

To: Florian Fainelli <florian.fainelli@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stefan Wahren <wahrenst@gmx.net>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
Umang Jain (7):
      staging: vchiq: Factor out bulk transfer for VCHIQ_BULK_MODE_WAITING
      staging: vchiq_core: Simplify vchiq_bulk_transfer()
      staging: vchiq_core: Factor out bulk transfer for blocking mode
      staging: vchiq_core: Factor out bulk transfer for (no/)callback mode
      staging: vchiq_core: Drop vchiq_bulk_transfer()
      staging: vchiq_core: Remove unused function argument
      staging: vchiq_core: Pass enumerated flag instead of int

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  20 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 324 +++++++++++++--------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  16 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  13 +-
 4 files changed, 236 insertions(+), 137 deletions(-)
---
base-commit: 3676d01bda1ed48ff15fcf9534897dc4640ec826
change-id: 20240823-to_sent2-75b3b8b8c156

Best regards,
-- 
Umang Jain <umang.jain@ideasonboard.com>


