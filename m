Return-Path: <linux-kernel+bounces-235754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683491D945
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFF2281D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6C8120F;
	Mon,  1 Jul 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iM6da1CY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B647D08D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819879; cv=none; b=KzjkvwOeHlg4ISwJL6hZn7XCGXjO93A6qcIHHWUzzn3YReZBFrzWRHlcmbW3I5T+2EZihoxyBgp3qa8zTCUJKwonIPp6OB5prvi0vTbAtQ+OW52muTPwHt1BqzM9BIGKM38cSyDn6POOLgnKb3XKoH+9MpFJIVCuLptg7H6VwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819879; c=relaxed/simple;
	bh=EBtPDBeaywnYW/+2LKB3DHJ4zg4paAIBx22m2ppCcA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4PF5ZsdG9toy8nvZbCasxxj0o1V6nZw1JsePE5ouDwk6WW1a+/pJu3fUGns6fj9OCPt9EFF+xDM5Cvn5RAtyI8lv1nL2hv4D/0RWVRNhtHgLChUYzjmyVwOqSkxmUHuwB/uW5lsYvV/sKFmb2gJiREiuSwgX/OureqBSR+NTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iM6da1CY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=iM6da1CY9oYSs
	ws2niEEAtMzcu1/BJCDCrG5FwiVqrP5b2oAi3KyO9D0EAZuv0OEnyUTaUmxTpiHa
	MVFt6R+/Qmc9zLhgFpdhg3eLXr6v2HEH/TgVnG8VMbXBoLa6UInr5UAPXDiw5SKs
	H2/Z7mZf7RJnHCbo8HvQ1+FZrSKUZw=
Received: from localhost.localdomain (unknown [223.104.212.168])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3v3UpXoJmVPDIAw--.64400S3;
	Mon, 01 Jul 2024 15:43:45 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Mon,  1 Jul 2024 15:42:45 +0800
Message-Id: <20240701074245.73348-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240701074245.73348-1-jacky_gam_2001@163.com>
References: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
 <20240701074245.73348-1-jacky_gam_2001@163.com>
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v3UpXoJmVPDIAw--.64400S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRk9NztUUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBQPKWXAmCk5VwAAsg

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


