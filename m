Return-Path: <linux-kernel+bounces-184150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C38CA334
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC96281FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD6139562;
	Mon, 20 May 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7wIPFrt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C1136988
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236457; cv=none; b=T6fIa0hMZKuNNfuuRgw9QmCdyDHXsgYXw+VVMW5NQjswcBTPc5RHQK9HBaioGme6J91M4xw6iKRypMTlJlRmbZFck8ltuuVAykGSky7lHv3Vs37KwnIOLNmrLMTjQ+bim7JHuknm1z3mIpbjNmzQmj6/yis4n/aZkyAJgCNX5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236457; c=relaxed/simple;
	bh=YDCRg2Cm4geYhXAR/tMhisRKsyQxPL6umy7x/kacso4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=U+DqZZN4S59vsRkka4H7tIQYKhV3ZtYLirQr6f84srs9ZnBFVL4yScZ4rdoRGZtt3uoVQAC1EMb0hTp2SOwKsSBlkw9OD0WSNo7tPWyYI+6Hq9yvHMQSsy2ZdPtrLTZovMBZ/2RnjaaNDtbDFgKqBrHfvUR7OyctvNDwdTrABdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7wIPFrt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716236454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOcNyvgHjOWe2pYYsGkhb9Oi1HGWChOiFubUg3gEQ8Y=;
	b=c7wIPFrt6GbjMES+gs+eEdpySAtOso//wf30wqtkYhHL8HP3xot1hY0/cW1MItfqPsWGnN
	EecwQoWb+KDKogP7lgkueDEhCS5Lj6Hxv4byP6xliVrr1IIR1DxOWOiv7ucawfe2/Xthbk
	Kn+12sfZcAw5fXOdA1lFNFmthNGMrkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-J7ENc2GXNJuxF4Elx6Z0FA-1; Mon, 20 May 2024 16:20:49 -0400
X-MC-Unique: J7ENc2GXNJuxF4Elx6Z0FA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBB28008A4;
	Mon, 20 May 2024 20:20:48 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2460040C6CB4;
	Mon, 20 May 2024 20:20:48 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org
Subject: [PATCH v3 0/1] nvme: queue-depth multipath iopolicy
Date: Mon, 20 May 2024 16:20:44 -0400
Message-Id: <20240520202045.427110-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Submitting for final review. As agreed at LSFMM I've squashed this series into
one patch and addressed all review comments. Please merge this into nvme-6.10.

Changes since V2:

Add the NVME_MPATH_CNT_ACTIVE flag to eliminate a READ_ONCE in the completion path
and increment/decrement the active_nr count on all mpath IOs - including
passthru commands.

Send a pr_notice when ever the iopolicy on a subsystem is changed. This is
important for support reasons. It is fully expected that users will be changing
the iopolicy with active IO in progress.

Squashed everything and rebased to nvme-v6.10

Changes since V1:

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've codified
the tests and methods we use to measure IO distribution

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9

Ewan D. Milne (1):
  nvme: multipath: Implemented new iopolicy "queue-depth"

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  9 ++++
 3 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.39.3


