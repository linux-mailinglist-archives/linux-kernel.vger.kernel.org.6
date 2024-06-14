Return-Path: <linux-kernel+bounces-215445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876739092CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C05D28407B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304441A2562;
	Fri, 14 Jun 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a04Wl6j9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADB1A2C3C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392096; cv=none; b=jb5856kvzQbaaRaTKwJdgTVWHR2SO4ksJU6+c7QmYxCjEl7HT5jK05zcCnYRupHCLy/d3fgX7lzIqjpNAyjH+JcGxETVUsijxt2fpkDOje1sF97Uiziy2FoG1FWcvqXyqV2gXFh/AgTFJUfa52MYTGElqDE7lFSyks30/9jHKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392096; c=relaxed/simple;
	bh=SQ/YQJdOFpW9+EoBypMmkzS+5zxvUiRg5Z5oH8yhL00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hy9tdJLEVxv8TcMc6JDBkRrqZ3TJFgVwF1+PJ3IV0/M9c9/vN3LVdZG2Z13XiyxAXpKu2KS1xL3kPsF+OKtjHfOc2Fw9ockeejVJMfFcx2NpKRc04P5GAlk8Yrzzhr8+c1U2xyk7kMotG+a/YprJBFMBZvmGR2vW+IgmeSExw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a04Wl6j9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718392093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DwSn56t118gnsozrPMNHvwFUxMQgx5fcblRLcH107/8=;
	b=a04Wl6j90G+qNx0f3PwLq4FsZLEk04VL86lpnEwrAmGteUqAehd4fftFWAoZWRjhSIvIBT
	/GmY7Ai5/GwG6OxUyl9qrEXyEVuzrxcIp9yseyTLGCTxEG+eAfXuATf+uDhRzQmEirg6Jz
	KUUkQei05tXPuOHfbuc1+m5BMu9hwN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-cYgAlWJEON-cBqK9V1LgOw-1; Fri,
 14 Jun 2024 15:08:12 -0400
X-MC-Unique: cYgAlWJEON-cBqK9V1LgOw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAC4195608C;
	Fri, 14 Jun 2024 19:08:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B3221955F2D;
	Fri, 14 Jun 2024 19:08:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH] Documentation: Remove unused "nps_mtm_hs_ctr" from kernel-parameters.txt
Date: Fri, 14 Jun 2024 21:08:04 +0200
Message-ID: <20240614190804.602970-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The "nps_mtm_hs_ctr" parameter has been removed in commit dd7c7ab01a04
("ARC: [plat-eznps]: Drop support for EZChip NPS platform"). Remove it
from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dd8436c98735..f58001338860 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4143,15 +4143,6 @@
 			parameter, xsave area per process might occupy more
 			memory on xsaves enabled systems.
 
-	nps_mtm_hs_ctr=	[KNL,ARC]
-			This parameter sets the maximum duration, in
-			cycles, each HW thread of the CTOP can run
-			without interruptions, before HW switches it.
-			The actual maximum duration is 16 times this
-			parameter's value.
-			Format: integer between 1 and 255
-			Default: 255
-
 	nptcg=		[IA-64] Override max number of concurrent global TLB
 			purges which is reported from either PAL_VM_SUMMARY or
 			SAL PALO.
-- 
2.45.2


