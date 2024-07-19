Return-Path: <linux-kernel+bounces-257126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C829375A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE27BB20BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6081AB1;
	Fri, 19 Jul 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3FymKGd"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41718B647
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380900; cv=none; b=KCtiaNz0hmspKQlpn2SzR8NatGZsIGVDDlI4NA6CFRbHzskmKRfpQdd2yznQgGQsmHS3+tXhc0uLm50u5XjA5OsDY+1+jQIGlRxNgFXwzRIgdQ40NPBwPRF3CjBDFqqLupFXFQ7wLt7jTyn2KYNEHj/lKtRjgJOTj9gd1pOJjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380900; c=relaxed/simple;
	bh=QkXRAqGqH5C9BtUXUT3ymjEgM3vA6TGf9u2BXIrf0jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYAJvZyj4d4EESc00xQ9wTjOY2HTCXV8QLVsaAd+2AEGoJ1GXIXh8WPVhgq6py60/MxlqXWiAFnlXLzSmd3+LM3ATwS0PfxS5h8Tm6q3r9dy4Fz77z5D0jba4GSWNwjF+Uz5bQ9qkzbv4uVJolTuxbogFtT+E+RDO/Q3QR5qzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3FymKGd; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eJGke
	Z+B4lQnntV/5x646tpUJDSE1ijXYU5aHYM3cAY=; b=E3FymKGd8kQl+cVgNa7Qn
	zymGlkpMU3MqRQia/VfyNrWZ4Th+9McV4tEwKe+oWNuQogIDqcxLW6BBobVQXPjB
	NDNHSkthi3Q4zXjMO4J213PIfLXZz+TOeBGXDaqe/yPxNnecuje+afdCTLXwsLet
	S7Jy3zLTJ8t5LrC+x/GOiQ=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S2;
	Fri, 19 Jul 2024 17:21:00 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Fri, 19 Jul 2024 17:19:57 +0800
Message-Id: <20240719091959.17163-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T3X7L5pmYK8DAg--.13202S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCry8tw47Zr4xtw45Awb_yoWfGrX_CF
	Z7ursrG3WxWF4DtFWI9a48ZrySyF98X3s7Jw48tF1UKryrZr1UArWDCr95Ga48ZF4kJrnr
	Xw13J3ySy39IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi1xR7UUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQABsQ

When running nvmf on SMP platform, current nvme target's RDMA and
TCP use bounded workqueue to handle IO, but when there is other high
workload on the system(eg: kubernetes), the competition between the 
bounded kworker and other workload is very radical. To decrease the
resource race of OS among them, this patchset will switch to unbounded
workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
get some performance improvement. And this patchset bases on previous
discussion from below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Ping Gan (2):
  nvmet-tcp: use unbound_wq for nvmet-tcp by default
  nvmet-rdma: use unbound_wq for nvmet-rdma by default

 drivers/nvme/target/rdma.c | 2 +-
 drivers/nvme/target/tcp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2


