Return-Path: <linux-kernel+bounces-555303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22EA5B538
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400EE189531C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842591DE3B1;
	Tue, 11 Mar 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhmYZ6zn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD779FD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654076; cv=none; b=mjm+Gixxao/ytxDIcfDcmgac56uFc8ZSjagc+GUAqc0XFsFPXTx7V51TVpz8mwkUvncphzGw4nSfP0LVFu75E+8b3XsCX+xQ0dsgAkaDxEM3ZFouEpKM13S4+U88OfkaITxYwFpRfJ1gINe/TvM8Sz8zUzu3Am29tfavXNoNhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654076; c=relaxed/simple;
	bh=hKb1nkSfskOvbnuh27WrfrXdXKBnnb/Dd+dvDqLQiA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/Mc59iAGMmvWiU5xj8cIx6iyrph0xU5CWEoNgEX5LU++JloTPEBfrDnjeGmExUphhdp8VA4z1UIgMI2Rp+/CPiEHtakCPvdW3MZdKsOBV3uBbpOQefxMGQ2UFCPT0VS6It0yrJW2HlCoMYFIBuj6svvI1rvnJqG2R7S4+ahbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhmYZ6zn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0UJSPiafPhAfhLmtvi6+N9BkHI9IDTUVJ5mvWuzeDlw=;
	b=QhmYZ6zn5jN1SdF+CnUKQFoEayzYNQ5ttm4OHRl/STt83+F9m+lyDIDcP76rDpGLxM+Kin
	weliRaPU++lHCZ3A51LmTThQ6pfnuZJzMzoVYO/rYQALIcFBOlxK1ZHo9a665xIB5shhOI
	4QPc9sVtfjWHTuR5yvJc+tqcdG/3X/Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-ukpyojb3OraolW4NVV6vVQ-1; Mon,
 10 Mar 2025 20:47:50 -0400
X-MC-Unique: ukpyojb3OraolW4NVV6vVQ-1
X-Mimecast-MFC-AGG-ID: ukpyojb3OraolW4NVV6vVQ_1741654068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 610B519560B3;
	Tue, 11 Mar 2025 00:47:48 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D402A18001E9;
	Tue, 11 Mar 2025 00:47:42 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	shan.gavin@gmail.com
Subject: [PATCH v2 0/3] drivers/base/memory: Two cleanups
Date: Tue, 11 Mar 2025 10:46:54 +1000
Message-ID: <20250311004657.82985-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The series has two cleanups to drivers/base/memory as below.

PATCH[1-2] Improves add_boot_memory_block() by using for_each_present_section_nr()
           and droping @section_count
PATCH[3]   Corrects the comments to match with 'struct memory_group'

Changelog
=========
v2:
  Expose for_each_present_section_nr() so that it can be used in
  add_boot_memory_block()                                           (Andrew)

Gavin Shan (3):
  mm/sparse: Expose for_each_present_section_nr()
  drivers/base/memory: Improve add_boot_memory_block()
  drivers/base/memory: Correct the field name in the header

 drivers/base/memory.c  | 17 ++++++++---------
 include/linux/memory.h |  2 +-
 include/linux/mmzone.h |  5 +++++
 mm/sparse.c            |  5 -----
 4 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.48.1


