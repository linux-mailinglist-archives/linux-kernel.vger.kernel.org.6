Return-Path: <linux-kernel+bounces-284128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84494FD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1749D1F21C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F9381B8;
	Tue, 13 Aug 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZgVaabZf"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4F2C190
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527658; cv=none; b=DOW0nt/dwkmcU6LQ0R5OsLPbR8f9C2Uo32FV2/A0uRdPWAKWnUzdNImanlIaN2rBFQXResEvpmEsXr+UCb7bBZFzQ7HZCeUICQxyG8oNsGf0CazFi6El9K/tk8izVzNanSG1tz9W+lsfoW09X48MOfzBRh3qn64PWL/pVOvxFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527658; c=relaxed/simple;
	bh=VIk0lEaUUhiW+DCj1n3E+zXyXxxpb3hN9JClSUe3l5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojGI7NZKHSct3YOYH7miRGjwMSxq5RGRwaajxuDgiGr2WQp4z4cCUaOLasercFC0M38gm4RpDuuyGrgQ5zheYFG+QC4zhZOz0BbyXu3lqTfy+qKZB59NYAb+0kAoluEmNW//j/p+XSsHpPxr9Rni8KzflOBFJccE+IL4hmieMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZgVaabZf; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024081305405273951f868ec6d0eacc
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 07:40:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+M9zDBvZEdUOGRMTAG1WyDuOh1X9fBikCvLdUnq//OU=;
 b=ZgVaabZfsZ/qY0KA/YUCMIcZNxCjmXJFcYG81JkcZlHtyBtN/gU3ppXF/Bh29JBimXAGbs
 nMFNE2yULb3fwmwTi2gH++tvoYiAVgrAF/4aX+2dXmkZ3eTKeeMk8DKNJUSvMjdzL3D0d7YU
 KtZ+VulSwLr8F7aC4J90E27Csl+2D2JbLbUjizwikJbbMxuF48CHsyOJzklZ4j76i/n/2XFk
 cyQzunkTS475egshNGb+Ln7/2H5SIBMPyWUd2loDzOKhTkVwgul6fxsnpLALId36A55WlhRx
 CLwJpNs6duNeaWKY5vwUB9kZACv2sOv2A93HGvfp5UEyaqwhPxV14WfA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] iio: Add Everlight PM16D17 proximity sensor
Date: Tue, 13 Aug 2024 07:40:39 +0200
Message-ID: <cover.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

The Everlight PM16D17 is attached via I2C and can measure the proximity
of objects optically. Model it as IIO driver and include it into the
device tree of the IOT2050-SM where it is available on the main board.

Note that at the time of writing, the datasheet link is still work in
progress at Everlight (product listed, link still broken). We are in
contact with them.

Jan

Baocheng Su (1):
  dt-bindings: vendor-prefixes: Add EVERLIGHT

Chao Zeng (2):
  dt-bindings: iio: Add everlight pm16d17 binding
  iio: proximity: Add support for everlight pmd16d17 sensor

 .../iio/proximity/everlight,pm16d17.yaml      |  95 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/pm16d17.c               | 324 ++++++++++++++++++
 5 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
 create mode 100644 drivers/iio/proximity/pm16d17.c

-- 
2.43.0


