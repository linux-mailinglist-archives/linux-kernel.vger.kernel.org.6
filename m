Return-Path: <linux-kernel+bounces-557063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B94A5D323
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B687A98D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360B1F4CAC;
	Tue, 11 Mar 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlR7ZJNb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452942A87
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735870; cv=none; b=hZR3KWsU8HDyFWkwBvrlT8JOz7Yz/HLx/9qLf25UlzOhw5EfbpR9XxwaVmiU1U8Lsbxn0X3T52jcGKHZb4X2P9Xk8+1VJNgkEbqoQ+/q0e1IkoWgz35wWnQEa6+Hpjeedu0a24JIECGHU+PSxfGCzRMx6yEj1A1Ran/d3K5QCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735870; c=relaxed/simple;
	bh=TXCz9c5vqyf4TNECR3umdgvdKeHVHm/ZrAggdghCYf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UjsPKurevdNisxjto+0FgMqTnkDbZRTaHE6ZqNwERJNaoCpHWZhCaRn4Ro7maFaqxP/vKGFkjogK9fQl0pjo4z8raSrkeGClm3SJJe0yi5RiTQXXN312sxJm22s+7shyYVzT2HEFywBszpeqCplwMktDRdtLu2i9SwCYaeGiECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlR7ZJNb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741735867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G795ykRv0pXH7z9UZRxgzv4WXx9ttT07lek5z98TzIw=;
	b=QlR7ZJNbDNqy7y/e0EqgwK2idtDa1cVzojNlHy27jCPFDbyZOACutFWnizDI7mEl/B6Nnm
	Z549NjXjdqVWH6/Jt78kwwND/D9PL4L2wSOinp9AGa6Nnilt+qi5ZPbqFthawBBHuXaKvg
	q3zjzN1rQssv+W91IgbveXMeBkKywQs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-lECHd-0fOxCpDl6mW4NbUA-1; Tue,
 11 Mar 2025 19:31:04 -0400
X-MC-Unique: lECHd-0fOxCpDl6mW4NbUA-1
X-Mimecast-MFC-AGG-ID: lECHd-0fOxCpDl6mW4NbUA_1741735863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96DF719560AB;
	Tue, 11 Mar 2025 23:31:02 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD73B1828A93;
	Tue, 11 Mar 2025 23:30:56 +0000 (UTC)
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
Subject: [PATCH v3 0/2] drivers/base/memory: Two cleanups
Date: Wed, 12 Mar 2025 09:30:42 +1000
Message-ID: <20250311233045.148943-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Two cleanups to drivers/base/memory as below.

PATCH[1] Improves add_boot_memory_block() by using for_each_present_section_nr()
         and droping @section_count
PATCH[2] Corrects the comments to match with 'struct memory_group'

Changelog
=========
v3:
  * Combine PATCH[v2 1/3] with PATCH[v2 2/3] to be PATCH[v3 1/2]  (David)
  * Pick up acks from David and Oscar
v2:
  * Expose for_each_present_section_nr() so that it can be used
    in add_boot_memory_block()                                    (Andrew)

Gavin Shan (2):
  drivers/base/memory: Improve add_boot_memory_block()
  drivers/base/memory: Correct the field name in the header

 drivers/base/memory.c  | 17 ++++++++---------
 include/linux/memory.h |  2 +-
 include/linux/mmzone.h |  5 +++++
 mm/sparse.c            |  5 -----
 4 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.48.1


