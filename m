Return-Path: <linux-kernel+bounces-395102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6189BB88F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601741C22501
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2931C07CA;
	Mon,  4 Nov 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJq82RLo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C01BD027
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732831; cv=none; b=UaMEgkdTS5bHhY6OHooB8dxh1cbVGu7qMboHax51gLMvgLQoXyrGCNOOSg28BORdBH4nZ//v5MXXurJYHqv2iWTy5Z48uaRXCDVMqomhkD3VjQrXYAx+NIO1ow9euIi11NVLMQYqZyzCu6xH5kaOHTqLgOFiqjZ1gcqg2mxV8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732831; c=relaxed/simple;
	bh=bBi3eEagGynygSCsFmlC0cyd1x+9yqO1PwoOsnMFHKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyRbFEZyhjJ77KtzUnZ3sp0Wb9px6S6kLygwtbxIx5KBpnI9mknmQflVSkycz0oMPXZtFBHD7VQuRarwj66M4RTmoMVkdMU7Izcovr94DkUQqPqIPuYtJO/0VikwwZ54FYTT1jdF3wgG4mAVf8+Trh0cVEViiI9cPz/ldRtzzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJq82RLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730732829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bsQTGmzGwW9e5hU3GFun0rMiD47xLFfrx9YjBWP30Ns=;
	b=ZJq82RLos8P680gpNDW3svyb3agjtMbBx9zO9cL1H3ubqmqZFGMHcqcWLFHv50i42L8xym
	ACaoO2APy72sIVrDvIIjeihYDv9JPMScW9tccRihxA8MyTq122z9dhYuaIjneElFvkJzZx
	2680OpwTZh4Mpekdu9Zs+Mx3Klemgac=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-z4pnGF1EP9SgC5oiNuuzAg-1; Mon,
 04 Nov 2024 10:07:04 -0500
X-MC-Unique: z4pnGF1EP9SgC5oiNuuzAg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E02C81955F42;
	Mon,  4 Nov 2024 15:06:58 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3142300018D;
	Mon,  4 Nov 2024 15:06:56 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated i2c_client
Date: Mon,  4 Nov 2024 16:06:53 +0100
Message-ID: <20241104150655.41402-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi All,

Here is v2 of my series to add support for non ACPI instantiated
i2c_client-s to intel_soc_pmic_crc.

Changes in v2:
- Consistently use the filename as driver name for all intel_soc_pmic_*
  drivers
- Use "intel_soc_pmic_crc" as i2c_device_id.name

Regards,

Hans


Hans de Goede (2):
  mfd: intel_soc_pmic_*: Consistently use filename as driver name
  mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated
    i2c_client

 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 drivers/mfd/intel_soc_pmic_chtwc.c | 2 +-
 drivers/mfd/intel_soc_pmic_crc.c   | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.47.0


