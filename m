Return-Path: <linux-kernel+bounces-174928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB41A8C178A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE0D1C20429
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D83127B5F;
	Thu,  9 May 2024 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU92U/+J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718885C56
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286603; cv=none; b=hNyFCSjBsVcSqJImYTTuszkzaBvHY4KS6b/xthpAJRN9Wo2FM+BsrKaJtC8oom8NLdEJ+dHKm3y6JVPgtt9quxia2xtEcvc9qtV+8XpnZ2K9Yb8P1tcPlVxKnnyzxpb8xnM/KJ68/Hg23nMmORibzFgvLHOB3g/L4BKAyvUIZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286603; c=relaxed/simple;
	bh=eEDN/BXh3FCSWDVV3j+pNRmC+1NuT17r62C9duvSG7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=WKkIbc4ph7rH7R8q1JJAonGu6sd9sMxnv8Z75IMrb+xr+IP0baY5a3sa6z4h0Qbuc4naP6MOTIpC6iO65yCUYch82wcl5nUo38q97ug1Ji1jz2phDTUH1aaXfMqlViOEvCzWnDzz29nZ+CQCLgpXywkEiqRNdJymBcASqN0116E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU92U/+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FddXm199VtUfPB6J9EsjicQftuZ1DGKMjcorbhxjq/s=;
	b=CU92U/+J++14y9OUvtMH34mGlGf55HFfW2dIAMy3nm0YMh7tcgQARlOp8+uC+FxPr8ZDzl
	C7W8URjI9OhlJ+yedDKsihFKsUZSkdZRuheFrF4DYIVKE0wRHRRPSrZHKTqyyrwUNt8a8L
	HqlBQHzbibAhpvPxTjKgs5adnT2vvAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-CRnDHCYCOvq7x3XNpCOBEA-1; Thu, 09 May 2024 16:29:33 -0400
X-MC-Unique: CRnDHCYCOvq7x3XNpCOBEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE4C3185A78E;
	Thu,  9 May 2024 20:29:32 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B76920C5674;
	Thu,  9 May 2024 20:29:32 +0000 (UTC)
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
	hare@kernel.org,
	constg@il.ibm.com,
	aviv.coro@ibm.com
Subject: [PATCH v2 0/3] nvme: queue-depth multipath iopolicy
Date: Thu,  9 May 2024 16:29:26 -0400
Message-Id: <20240509202929.831680-1-jmeneghi@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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

Ewan D. Milne (3):
  nvme: multipath: Implemented new iopolicy "queue-depth"
  nvme: multipath: only update ctrl->nr_active when using queue-depth
    iopolicy
  nvme: multipath: Invalidate current_path when changing iopolicy

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 77 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  8 ++++
 3 files changed, 82 insertions(+), 5 deletions(-)

-- 
2.39.3


