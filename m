Return-Path: <linux-kernel+bounces-514452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B2A35731
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C83AD9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5220127B;
	Fri, 14 Feb 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5J3UFFB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3A1487DC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514927; cv=none; b=ZFlE/BBBrJ9nQMRtn7lPnHguk8uC/UzwbcnSXhsMc2ejPObVWxqVWB+VHO4IyVus7QUxmYPxl82H3nPYcPcBiZgoj085KHQw1cQSphmMLsg21vnScfCOzIbFEB2efB9ATTRQRr9XL5BguvcN5gtXygC82wlI7JLFukJUDfa27JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514927; c=relaxed/simple;
	bh=lIQypDVX3e9JiB6sIu90kXlN2u3dhJK+G57scObJZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnl9cxVpT1SClHWOwGKh/fqYhleN6AoNSLnyc81D4dBqcbB/dVHKfLCP+o5sM0D3JoMwOA9CJYWtTZ/Bup40DFQZUFGvP64UKWjXAxHlm77WBARq8rox0lUrV5w1RvnvH39GbB8iGhRbi39ym7Den8rTSC5WEU69lNxGMh9QMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5J3UFFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739514924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xYos/BN40MRaoN+H3HHIi+saSNK5H9t+/9FzP6cCH6E=;
	b=W5J3UFFBqbLcibbj1VsWPHpSyGAwW9nAny6Sqd1Gav8tdMjiMs4/bY+afxbetxHb4kKtVW
	I4IDzdplGVk6mlp+DqJDmviuochNQ/1HUUv+qipe7+9Mb5/vU1TzF1toqDckejllfhEewD
	ycqjvDQ2LEdpi9pht4UdSh7VXGe3Eng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-dhEcRTVHNf-aHNG8aBpXrQ-1; Fri,
 14 Feb 2025 01:35:19 -0500
X-MC-Unique: dhEcRTVHNf-aHNG8aBpXrQ-1
X-Mimecast-MFC-AGG-ID: dhEcRTVHNf-aHNG8aBpXrQ_1739514918
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52B5E19560AF;
	Fri, 14 Feb 2025 06:35:18 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00C7300018D;
	Fri, 14 Feb 2025 06:35:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 0/2] drivers/base/memory: Two cleanups
Date: Fri, 14 Feb 2025 16:35:02 +1000
Message-ID: <20250214063504.617906-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The series has two cleanups to drivers/base/memory as below.

PATCH[1] Drops @@section_count to simplify add_boot_memory_block()
PATCH[2] Corrects the comments to match with 'struct memory_group'

Gavin Shan (2):
  drivers/base/memory: Simplify add_boot_memory_block()
  drivers/base/memory: Correct the field name in the header

 drivers/base/memory.c  | 15 +++++++--------
 include/linux/memory.h |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.48.1


