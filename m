Return-Path: <linux-kernel+bounces-412310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892979D0760
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389D4281E04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6F14F90;
	Mon, 18 Nov 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQwmfwxL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4871C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892113; cv=none; b=jO2rRB9/iuFQX0z52RgTbM2hmU8cH/Rms/xETMbzn1pHDSgbHGjQPx91XlfzYqfxeUhCOkrkhuyFP+Gqhac5kpwBbrqasihHiXQHXOmXeg5fuMiDghsaIpZMOmn9kPgWd/97R5YFQ51N3fc+w/p0S75FY0+zcS4St32/0az451I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892113; c=relaxed/simple;
	bh=13EApEFp+MRamoTlROyPR3wJrVk3fWM6OR1FNLkpntM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=IIZlAfMNWxfdFtX6CJC3vVUzKS8VEaan05dc2vjKGi7OM9xh1NKv5bBvNxnOVG+0I4Tu9b0Nv9jba6Fw3nk3rEiER0Tuz0H+Rg5AdPfWVerLwJkh4cR31Z66OrJf9nlHHkfQqiZf7tTngkl4HKqAxihRy7dgRWEj1H+/sVB/qeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQwmfwxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731892110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y8sySyDbtF6LW6S646QaDshfA1xRahQNAvGopJ+RtuA=;
	b=DQwmfwxLO6+d1Zdxs5gAsBAzH2PyQIe/5FxYNYFNKpifR6akzdwmhRpcN6BijJuMA56FSA
	tlbSLjOapy91WVxm8iR2UEiYiIksCeDE/MGDwMOPxAHmEBG7bd64H5otVdUE8BVvps//Mp
	trFm4nz253unZToUzd41UihuSLqXOwk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-pVy07r0OPpaMLy-He4GqjA-1; Sun,
 17 Nov 2024 20:08:27 -0500
X-MC-Unique: pVy07r0OPpaMLy-He4GqjA-1
X-Mimecast-MFC-AGG-ID: pVy07r0OPpaMLy-He4GqjA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 733101955F2B;
	Mon, 18 Nov 2024 01:08:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC2C830001A0;
	Mon, 18 Nov 2024 01:08:22 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	bp@alien8.de,
	thomas.lendacky@amd.com
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] x86/ioremap: clean up the mess in xxx_is_setup_data
Date: Mon, 18 Nov 2024 09:08:17 +0800
Message-ID: <20241118010819.46602-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Functions memremap_is_setup_data() and early_memremap_is_setup_data()
share completely the same process and handling, except of the
different memremap/unmap invocations. The code can be extracted and put
into a helper function __memremap_is_setup_data().

And parameter 'size' is unused in implementation of memremap_is_efi_data(),
memremap_is_setup_data and early_memremap_is_setup_data().

This patchset is made to clean them up. It sits on top of tip/x86/urgent
commit 8d9ffb2fe65a ("x86/mm: Fix a kdump kernel failure on SME system
when CONFIG_IMA_KEXEC=y")

v1->v2:
- Remove __init from helper __memremap_is_setup_data(), add __ref to
  helper suppress mismatch section warning.
- Merge the old patch 1 and 2 into one patch. 
  - Both are suggested by Tom during reviewing. Thanks to him.

Baoquan He (2):
  x86/ioremap: introduce helper to implement xxx_is_setup_data()
  x86/mm: clean up unused parameters of functions

 arch/x86/mm/ioremap.c | 117 +++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 76 deletions(-)

-- 
2.41.0


