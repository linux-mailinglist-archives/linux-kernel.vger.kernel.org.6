Return-Path: <linux-kernel+bounces-419047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC29D68E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2A281DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4341925BC;
	Sat, 23 Nov 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxO89fyL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867B4A0A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362158; cv=none; b=JV1e2t4OoAoROsYrJp4L/ngg31ZLR6WIIoTqMIWaqxaorTxJNCga9k5nj78Uu4I3x4KryupxwfQZL9bxMgMsYjx7KXUWtFfobnIKiXWlJyFBw1d9apIKZiQULdCLkq4K4//2uZPCV+c2q872VK1OhjW6bmWJxHStmy6rWCrmfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362158; c=relaxed/simple;
	bh=DyKf396WEcT1hxMXEZEmQC4l60wq64g80y2/mnfddTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=RADbP9BWTb7P4jgPFT7VYkBZvTWM8AEeKdSwX55GbeLkVIQ6r9xko55/QlOrWlO7zzRJkZz+ngLSnWPSlalyyqn0odGKKZEyEMiMnIybScE9PyOXOk5pXDsESyG77j+m2c8ei5z0bpQprVPWsMALUdz+Z3WIaI8fiyYitg/9sM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxO89fyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732362153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6nsMlOik+g3SsZO48DwCappSB37aUv74klSossMhf8o=;
	b=hxO89fyLNDg82ssE7see+qpDvu351GfpTixc7n66lxUSVD0U4eNlb4ICS+Eg45cZdJHEir
	5Ccog/6LR/RE7BR3pcyc1QrUeHu1mICtDh/SXYE4zSEjBCxBMVJBGCPRvgw5t+zi6TJo/I
	4iY6xGxpTp1MNyJDYnk3MK0N2fpDCUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-XuAl2ChKPnmgepIs5_i3ZA-1; Sat,
 23 Nov 2024 06:42:31 -0500
X-MC-Unique: XuAl2ChKPnmgepIs5_i3ZA-1
X-Mimecast-MFC-AGG-ID: XuAl2ChKPnmgepIs5_i3ZA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30C919560B8;
	Sat, 23 Nov 2024 11:42:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C767A30000DF;
	Sat, 23 Nov 2024 11:42:25 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: mingo@kernel.org,
	thomas.lendacky@amd.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/3] x86/ioremap: clean up the mess in xxx_is_setup_data
Date: Sat, 23 Nov 2024 19:42:18 +0800
Message-ID: <20241123114221.149383-1-bhe@redhat.com>
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

This patchset is made to clean them up. 

v2->v3:
- Add back __init to early_memremap_is_setup_data(). Tom pointed out
  this.
- Split out the defining and usage of SD_SIZE and put them in patch 2.
  Suggested by Ingo.

v1->v2:
- Remove __init from helper __memremap_is_setup_data(), add __ref to
  helper suppress mismatch section warning.
- Merge the old patch 1 and 2 into one patch.
  - Both are suggested by Tom during reviewing. Thanks to him.

Baoquan He (3):
  x86/ioremap: introduce helper to implement xxx_is_setup_data()
  x86/ioremap: Clean up size calculations in xxx_is_setup_data()
  x86/mm: clean up unused parameters of functions

 arch/x86/mm/ioremap.c | 117 +++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 76 deletions(-)

-- 
2.41.0


