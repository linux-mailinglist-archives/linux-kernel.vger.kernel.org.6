Return-Path: <linux-kernel+bounces-297309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532FE95B603
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D8AB22D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A01C9EC5;
	Thu, 22 Aug 2024 13:09:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8661C9DD7;
	Thu, 22 Aug 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332161; cv=none; b=K0W2wgjmdTS3CmBwDC8ciFu9qhrruKpdJrIwOwQOo03Vk3ynO6hhMpUjsKs6N5dNVSPt1HpN3YAlrRuGTEU0iq9AhaZvCD0RKZeLBNGpBi57HEFLKz9MInkBsQu8A9RLZ5A/tD77fYZUerHGQ6aYiXb2njHITYFGI2xx9TWAUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332161; c=relaxed/simple;
	bh=JdMd/DXg3+nidYBW4ZJW+mDLDbVuaNI8/8OkwiZDvaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQoKseKB+Heih002eknWd0BpflhD5e4tyGayoLKAfo4lr2CSMzMNE57uTdZsKo4TesS84btN5vF8nxYkzNCsMO0oUikJAIzQfaH/dP64uH+dDlUWbHAs2Khwu+lmN5ldZxGJOpOPPU3ds5df/Vj4aGn7cqqkn1O5kKIBdtKT1hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqNn10CnhzyQPS;
	Thu, 22 Aug 2024 21:08:37 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id B3D561800FF;
	Thu, 22 Aug 2024 21:09:17 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 21:09:17 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-usb@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<alcooperx@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<heikki.krogerus@linux.intel.com>, <stern@rowland.harvard.edu>,
	<justin.chen@broadcom.com>
Subject: [PATCH -next 0/4] usb: fix module autoloading
Date: Thu, 22 Aug 2024 13:01:09 +0000
Message-ID: <20240822130113.164644-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Hi all,

This patchset aims to enable autoloading of some use modules.
By registering MDT, the kernel is allowed to automatically
bind the module to devices that match the specified compatible
strings.

Liao Chen (4):
  usb: phy: phy-gpio-vbus-usb: fix module autoloading
  usb: misc: brcmstb-usb-pinmap: fix module autoloading
  usb: typec: fix module autoloading
  usb: ehci-brcm: fix module autoloading

 drivers/usb/host/ehci-brcm.c          | 1 +
 drivers/usb/misc/brcmstb-usb-pinmap.c | 1 +
 drivers/usb/phy/phy-gpio-vbus-usb.c   | 1 +
 drivers/usb/typec/anx7411.c           | 1 +
 4 files changed, 4 insertions(+)

-- 
2.34.1


