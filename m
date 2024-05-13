Return-Path: <linux-kernel+bounces-177060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804F8C398B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBFE28130B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D21800;
	Mon, 13 May 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VPW/nhbX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590917E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559225; cv=none; b=bJaaL96uhacPP1rYQcZAhGpNoW2UoiEUg0emPLc1+i2CYlv8TX5AFmQnJsv/hEeleFJWGt+/114MgeftNKeoqOZqGoCtSnBMabr5t+UJSC9p4ScTkNh9OYNBgdMAG+L0P5e6uEEAXyrrWaP6GlaDQf50Yg1oX/HplItjMWkg4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559225; c=relaxed/simple;
	bh=yBPp7S7yh6RT5LOFnsV1L929izvs98i6FjXz8rjKkyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjyVKCTPbVqfoJTRYPFjUmZ2jtKuvUwDNqvn1aOienLLgkq0mM6197uVaFnPKH2ICzXP15nOx3a/X3JofZ3W/PzjWW1yL1psCdxBYLti+dMgd8O0/tHD5/71OYtRugDB5XkuK/OpZo+ERAuTYUOGdtDk3Dib4wOIfr9VE+BZ5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VPW/nhbX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715559220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XJY1www0AxrnCm+16UJMjjPkfXJT0ujI5r+bchZsf1M=;
	b=VPW/nhbX72YlHmO0ZRVZ7TioRdby1C6sMHM3Dd5CcuZx+1gprGSzmW39+/6rq6Rrfnepu9
	PCv42jxiQkKTrvR9JHjuHyaNhUU1IrsxpDSlFJfMmwyqY2676uGt/j/o/+8bIPSh5IG7HU
	1ecOjPtsP3k4Dfn8XoJOxtUh3bQeNCU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 0/3] drm/loongson: Introduce component framework support
Date: Mon, 13 May 2024 08:12:40 +0800
Message-Id: <20240513001243.1739336-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce the component framework to bind childs and siblings, for better
modularity and paper over the deferral probe problems if it need to attach
exterinal module someday. Hardware units come with PCI(e) are actually all
ready to drive, but there has some board specific modules will return
-EPROBE_DEFER. We need all other submodules ready to attach before we can
register the drm device to userspace.

The idea is to devide the exterinal module dependent part and exterinal
module independent part clearly, for example, the display controller and
the builtin GPIO-I2C just belong to exterinal module independent part.
While the output is belong to exterinal module dependent part.

Also for better reflecting the hardware, we intend to abstract the output
ports as child devices. The output ports may consists of encoder phy and
level shift, while the GPU and VPU are standalone siblings. As those units
are relative separate hardware units from display controller itself.

By design, the display controller PCI(e) is selected as the component
master, gpio-i2c go with master. The manually created virtual child device
are functional as agents for the master, it could return the -EPROBE_DEFER
back to the component core. This allows the master don't have to tear down
everything, the majority setups work can be preserved. The potential cyclic
dependency problem can be solved with such framework.
Sui Jingfeng (3):
  drm/loongson: Add helpers for creating subdevice
  drm/loongson: Introduce component framework support
  drm/loongson: Refactor lsdc device initialize and the output port

 drivers/gpu/drm/loongson/Makefile             |   1 +
 drivers/gpu/drm/loongson/loongson_device.c    |  42 ++++
 drivers/gpu/drm/loongson/loongson_module.c    |  17 +-
 drivers/gpu/drm/loongson/loongson_module.h    |   1 +
 drivers/gpu/drm/loongson/lsdc_drv.c           | 208 +++++++++++-------
 drivers/gpu/drm/loongson/lsdc_drv.h           |  34 +--
 drivers/gpu/drm/loongson/lsdc_output.c        | 183 +++++++++++++++
 drivers/gpu/drm/loongson/lsdc_output.h        |  38 +++-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c |   3 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |  15 +-
 10 files changed, 422 insertions(+), 120 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output.c

-- 
2.34.1


