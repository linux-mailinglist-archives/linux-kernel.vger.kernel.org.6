Return-Path: <linux-kernel+bounces-360904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF699A134
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B24B21C93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBAC21265D;
	Fri, 11 Oct 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="zGS6x4dt"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC22210C2C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642249; cv=none; b=ryjJfSOAfh270fuRIUS2A4glrl/GVK+10bo3tcqHVpre1QFllSEJ6hXm1XYbiL60LYWdynATVft8tcivY5XlZ/D01zAr97aAygmplQYp2Pi7kJcXCjgax4XfV7ky4t0U7z3en1ja4WHU0PZC82mCIOloBFJnu/ZXdiMUZTVDV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642249; c=relaxed/simple;
	bh=Wd4pj46/twq5DBK2dTHcgkCEQf3kgrw1fVkR51iaR2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UH/5V4Ad1Vv5OiMNnN0QqZCSE5NpAES2i8FL/MzaAtWNW/X8+5Yi571a4WQ4LLQaZu2AwuJO+XU86Mk9OJzGATYwECNd1s2c2zPw3i6cLPg4NmpRApH7SgsllW9dJLz1Vv1HNvFYHTajIHHgGFqWtcdNZkB28hU+ewgOhi7QTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=zGS6x4dt; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728642243; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XaH+HrDOONCnVrlgIRr7EJ0vjGugHLu4U4mCg4db9+A=;
	b=zGS6x4dtYrPCdEXNfto78Y73idVNRAXRzno7Tb1MbdZMqzozMpw2j4hM01fG00OyFkJ6BHysTYsXPawpARYXUzx1NhBLUtKTMh9nuWtmD/Y2W9q+HHnftcZGm+YpVSu1Mz7JJC7FC7wb9azi/2Kx4eoF3hJ798D4A2sWTssSTF8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeXjAEj_1728642236 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:24:02 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/2] um: Some page bit cleanups
Date: Fri, 11 Oct 2024 18:23:52 +0800
Message-Id: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Remove the unneeded "if" (suggested by Johannes Berg);
- Collect the "Reviewed-by" from Benjamin Berg;
- Add "um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC" (suggested by Benjamin Berg);
- Add a missing comment update in tlbflush.h;

v1: https://lore.kernel.org/all/20241011053843.1623089-1-tiwei.btw@antgroup.com/

Tiwei Bie (2):
  um: Abandon the _PAGE_NEWPROT bit
  um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC

 arch/um/include/asm/page.h              |  2 +-
 arch/um/include/asm/pgtable-2level.h    |  2 +-
 arch/um/include/asm/pgtable-4level.h    | 14 ++---
 arch/um/include/asm/pgtable.h           | 75 +++++++++----------------
 arch/um/include/asm/tlbflush.h          |  4 +-
 arch/um/include/shared/os.h             |  2 -
 arch/um/include/shared/skas/stub-data.h |  1 -
 arch/um/kernel/skas/stub.c              | 10 ----
 arch/um/kernel/tlb.c                    | 74 +++++++++++-------------
 arch/um/os-Linux/skas/mem.c             | 21 -------
 10 files changed, 68 insertions(+), 137 deletions(-)

-- 
2.34.1


