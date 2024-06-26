Return-Path: <linux-kernel+bounces-230298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB0917AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2A2884D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B0161924;
	Wed, 26 Jun 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XLd6TTiN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B423BF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390603; cv=none; b=HQfsL5D8oP4zkXXyrcIUVtBtQw5YZvzVmWhza1N8q3HatH1RoPSwgVOp7RppXmt0+4MJWNukWMIhCLs6qi2DTt5YljpiBN8WW46Kzw65lpCX4hHPO1L7tzGWj6OcgWDT8ji6GNhLMjTm/JKyXTRKmFdhVR2GO4KSPGrODssyrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390603; c=relaxed/simple;
	bh=EBtPDBeaywnYW/+2LKB3DHJ4zg4paAIBx22m2ppCcA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h91hsM/hbzLISk6wJwF8aIs6fyz5fu93FVOMCZx9B8VbJutsOf8urofYsn4GSOGfvkrPscTSkKl+EX4tzp+Qt6s+jTbXXaRxpDJE10YmyzjThQhOd4V5p+RkVOMLX4Yh/g/JyHtMwkIQIEFB6+DWASwUm/G6AbV5+ShM50gKAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XLd6TTiN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H8E+S
	y95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=XLd6TTiNyw3hUu6nc0IGn
	TVNP6HWQzGY6Y05aAJHV8R8SbbM+zMr5AZRufyruURRdWymu/2Zvx4y8VlMgSR6A
	2m/eyHNMULIoZzMiXpt7Un/nyBoVAPVp7qP8xFKXltky19/VMsjnv4IBZH/WIEr9
	MDdIlS13utgMeqTGBIbFzw=
Received: from localhost.localdomain (unknown [139.226.176.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3__Ve0XtmGuclAg--.42928S2;
	Wed, 26 Jun 2024 16:29:18 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Wed, 26 Jun 2024 16:28:21 +0800
Message-Id: <20240626082823.48326-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3__Ve0XtmGuclAg--.42928S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAwI63UUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEAEKKWXAln0mkAABsL

When running nvmf on SMP platform, current nvme target's RDMA and
TCP use kworker to handle IO. But if there is other high workload 
in the system(eg: on kubernetes), the competition between the 
kworker and other workload is very radical. And since the kworker
is scheduled by OS randomly, it's difficult to control OS resource 
and also tune the performance. If target support to use delicated 
polling task to handle IO, it's useful to control OS resource and 
gain good performance. So it makes sense to add polling task in
rdma-rdma and rdma-tcp modules.

Ping Gan (2):
  nvmet-rdma: add polling cq task for nvmet-rdma
  nvmet-tcp: add polling task for nvmet-tcp

 drivers/nvme/target/rdma.c | 331 +++++++++++++++++++++++++++++++++-
 drivers/nvme/target/tcp.c  | 356 +++++++++++++++++++++++++++++++++++--
 2 files changed, 665 insertions(+), 22 deletions(-)

-- 
2.26.2


