Return-Path: <linux-kernel+bounces-537685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BBA48F15
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E295F3B414A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C137187553;
	Fri, 28 Feb 2025 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2+rMH7O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFA1494DF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713158; cv=none; b=NEVzU+LTPTpuOWdvXjaAfNEVqZ5WI9U+bFCvEhQPBCAUh6xvpZ7uycgqScTMJ2pxs8WGD7bsL3lh6dxYvtxWE68dadXx0X3j6scbMLDgoPQOj7U58ymgtF3GOPalBRI9Imkzo63/wbvmBDvKWAlwnA7UmPxRrnjThcduHYNtYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713158; c=relaxed/simple;
	bh=411Q2KbM8iwKp/IgT9ZWaAVrmyvvpkbCqL9jpzBfcXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=HP7pmtdkdPTb3IvnBm2hF5B7uXStiIpyXcsodrbdQRlN46jd8s1vvV9VdcdZjgNWBFrzkp+rsxGm0giIZwDcpPWQVpz7A9s1lTfre6yaFeGu8MplQlGuC1ha3SYtb0NHecsKkRMslkiHZblmKbtrjcYG8JZ3gGCS7hJ14qovAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2+rMH7O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mb26mU38SKiwkYcPSoVmGFcFJL8AA1v1BtKLUtjEM30=;
	b=P2+rMH7ONKvOUqYNS3dnJNkiv40Qr1wE4mq9rQ5I5H9pJy3ED4oFEI9QnMhps3gQsMo8O3
	eEQOkT20ZYmXPDtKc/QSOPFYNRsH2xRfmwj1ZzxR98k/4yfaWB5R5dGRuX8o+B4CLi7F78
	ptZB3EX35/1pI5tuJz1Mj5UmKzlq5j0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-JNoKCRgCN9m92Y-vFrUZXA-1; Thu,
 27 Feb 2025 22:25:52 -0500
X-MC-Unique: JNoKCRgCN9m92Y-vFrUZXA-1
X-Mimecast-MFC-AGG-ID: JNoKCRgCN9m92Y-vFrUZXA_1740713151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79CF41800876;
	Fri, 28 Feb 2025 03:25:50 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 059C8180098C;
	Fri, 28 Feb 2025 03:25:47 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH 0/4] nvme: make core.nvme_multipath configurable   
Date: Thu, 27 Feb 2025 22:25:37 -0500
Message-ID: <20250228032541.369804-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

These patches propose an alternative to outright removing the multipath
module parameter. Rather than deleting this module parameter we control
its appearance with a new Kconfig option named NVME_MULTIPATH_PARAM

Note that the default kernel config settings produce a kernel
with no change in functionality. By default both NVME_MULTIPATH
and NVME_MULTIPATH_PARAM are enabled and there are no user visable
changes.

To remove the core.nvme_multipath parameter simply compile with
NVME_MULTIPATH_PARAM=n.

Hopefully this compromise gives everyone what they want.

Closes: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/

John Meneghini (4):
  nvme-multipath: change the NVME_MULTIPATH config option
  nvme-multipath: add the NVME_MULTIPATH_PARAM config option
  nvme: update the multipath warning in nvme_init_ns_head
  nvme: add mulitipath warning to nvme_alloc_ns

 drivers/nvme/host/Kconfig     | 28 ++++++++++++++++++++++++----
 drivers/nvme/host/core.c      | 19 ++++++++++++++++++-
 drivers/nvme/host/multipath.c |  3 ++-
 3 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.48.1


