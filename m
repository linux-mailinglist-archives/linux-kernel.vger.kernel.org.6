Return-Path: <linux-kernel+bounces-254838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4D93385B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA3282FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0321103;
	Wed, 17 Jul 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E00qJGiR"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD272E644
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202815; cv=none; b=Ll2H1fatgTu4aF7jGu8q7J8JHgRZ58S/rNDlwwdpia2bkceJacvRTWwb4EB3PHweivd+pPSZM2hcnPiVN2C9/hdp676dQsuMp/HqChMkmnvz6+ZEqFH4J18Nv3Xw5DK4Pbqsz7JD7WbqvqqmClbOKMxeKmLXZgK1cp2WTFmk4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202815; c=relaxed/simple;
	bh=uJTaoRmglprtmgw++MqB+M+q+C56qX542mPheG/qdtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IlQfmzsmq5/WgOF7jCEtovO2Dk8CiijYQAZg2pUq6VSu4Alurrvv5LUJqN+tvlDxLEF8ZnKslW/aNI8b4zTgMXcVxi2lkX6KcKvgskq8q2vlG0wB47yNsMsCX7MBNOPR+z6DlXXAodO+2siFOyPaXWsHZba9D+PammCf8RlHUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E00qJGiR; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WISCA
	Ym5x4Ne2pkT2yciOq9HDZYc5vds8WQqUH95bt0=; b=E00qJGiR9bTqb7ouWngPC
	5yOGXdj0quIZJZIzrS/L+VDkoik29RIiWy+uZS+PFdGERH0r0tSXIBwBvX2MSw4x
	kkTrJKe5nVdd3KpFEVh5NajCkrYwgTAVA7e7zuDXsIaHtkYBLL5TexL20aDIwPus
	Kxg/5nDoAD8/zAead8nJWc=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S2;
	Wed, 17 Jul 2024 15:53:02 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support unbound_wq for RDMA and TCP
Date: Wed, 17 Jul 2024 15:52:06 +0800
Message-Id: <20240717075208.87324-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3ddeJdmTsbxAA--.36565S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCry8tw47Zw48Xw18Krg_yoWfXwc_C3
	93urykG3WxuF4UtFZ2gF1FyryfKFs8X34kta18tF1DKryrZr1UCrsYkr95u348ZF48Aw1D
	XwnxAw1Ik3sIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi1xR7UUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwABsk

hen running nvmf on SMP platform, current nvme target's RDMA and
TCP use bounded workqueue to handle IO, but when there is other high
workload on the system(eg: kubernetes), the competition between the 
bounded kworker and other workload is very radical. To decrease the
resource race of OS among them, this patchset will enable unbounded
workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
get some performance improvement. And this patchset bases on previous
discussion from below session.

https://lore.kernel.org/lkml/20240717005318.109027-1-jacky_gam_2001@163.com/

Ping Gan (2):
  nvmet-tcp: add unbound_wq support for nvmet-tcp
  nvmet-rdma:  add unbound_wq support for nvmet-rdma

 drivers/nvme/target/rdma.c | 10 +++++++++-
 drivers/nvme/target/tcp.c  | 12 ++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.26.2


