Return-Path: <linux-kernel+bounces-237571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A3923B05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7556BB23E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92DB157488;
	Tue,  2 Jul 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g1tJa76q"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57924153823
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914619; cv=none; b=Yni5zSy06WzysuCV4UcdUMWAD+WmSCFFnIhCmDNHmvalwUCcIYgMK1ywQIwPvFAwIW1cdduo6/ZI/GoiSASULx2UHAyHOeOkPNE3s6EmY4v7XYK69pPfrJ/G67xaGonZlyBES0YvsXTXmmMQcME8XqkAHTvJ9MniQqUzbWld32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914619; c=relaxed/simple;
	bh=EBtPDBeaywnYW/+2LKB3DHJ4zg4paAIBx22m2ppCcA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ly1+rbniX+DdftTz7bLfLsgbHT/XjY9LPM0JM/bx1AsJW4ijQk6ANZpO9bNRoKmSHyoFinSloys/oZwLnqvpTMnPBEW3qZ8lJ/LkqS2b0PzERltimT0Wj0Tp/xIorkHjLv/7U1NcUI6COFzdBd7zRf6/Qf4P85eY8tM5JoS6TVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g1tJa76q; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=H8E+Sy95f1wvg9QrRX1Lu+FTsFS+/TcipMRWQA1B6NE=; b=g1tJa76q6qe2y
	O1ICk0Tph2/eQ4o/z2y8d4IQVbWdVeG7TqWTV0ZoraxpK1IdU/LLXsNGyyQPbdd2
	TV5Nss5DQ5u8DffCm0NWOahcufmG4bneu0IKSDqaep67ABbirYaNXhtH8W4WbxKa
	gWU+hOCT33pbW3aisu1rUXqyuz498Q=
Received: from localhost.localdomain (unknown [183.192.130.164])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3_2Vb0INmpmSMBQ--.35615S3;
	Tue, 02 Jul 2024 18:03:14 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
Date: Tue,  2 Jul 2024 18:02:15 +0800
Message-Id: <20240702100215.2265-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240702100215.2265-1-jacky_gam_2001@163.com>
References: <f9828eb4-39be-498b-8b90-2cb7ce42d3c7@grimberg.me>
 <20240702100215.2265-1-jacky_gam_2001@163.com>
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_2Vb0INmpmSMBQ--.35615S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DCrW8tr45XF1kWr1DGFg_yoWfWrc_ZF
	WfJryDGa1xWa4DtFy7KryrZrZ5t3y5tryUuF4vqF4Utr98Xr1UAr1UAryrCF1xAr18JF15
	JrnxAF4fCwsxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRmzutUUUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEB0QKWXAluk-igABsa

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


