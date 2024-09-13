Return-Path: <linux-kernel+bounces-328360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDEF97826F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358B6B21F48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9077B672;
	Fri, 13 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="mfGfY1ZX"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8CFBF0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237311; cv=none; b=QJwe3iprFkOzsb8dFaoLk4fViGqI/m0Ueqnk7/6eWzRsOl3/8sDmLY4Fk0noadKJDST3FGRt/N+GMmPqqcpK+07HhisUqV05dnfMVrCKdPnNmez6IRX+EVa6nWX/rzfN3K1S6g6nNmkW5vrl2aAUjalio/VQTfZiQvg/udcm0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237311; c=relaxed/simple;
	bh=SZxN7hFa6A6GJwQgwLZpNPZwW4E09IcW1mdL3vc28fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z85RfV+GzL2vQ3u6JghPYDQ8ivrBr9XQiLICwQixq5Hi8dYiYM4WBJ1MGea4wVr/d8aVyGTZVwEVv8vJfdZVd2ZdZ8f4/BBtFs1cz/LS1FkUUSPVXYstmeZGxkvHg2rPiaSoVWAhwFf0PKsoxwW/wP7s//bBru6D9GHYoIDAgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=mfGfY1ZX; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237303; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8aQ9RylDAas01MNvGKN18LRMuLpHKJUl0/PpqJ20ye0=;
	b=mfGfY1ZXAsN/+iXTm5Cr9Jl2k5AGs3+msB+kGKFSMGsFPL1uwx76r3OdkE4xZl18EH518UkTMwkqHjhJVie1GmFPOJGgUKUDck5TZ3wuktpqzIhEu5oJ38b5QEvZ+VHuJ8eLJghmHMk33G4YGW9IM+hay6qUXIHQMgGzF8BWZF0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E6d_1726237298)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/3] Minor physmem cleanups/fixes
Date: Fri, 13 Sep 2024 22:21:34 +0800
Message-Id: <20240913142137.248245-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiwei Bie (3):
  um: Remove the redundant declaration of high_physmem
  um: Remove highmem leftovers
  um: Fix the definition for physmem_size

 arch/um/drivers/virtio_uml.c       |  9 ---------
 arch/um/include/shared/as-layout.h |  3 ++-
 arch/um/include/shared/mem_user.h  |  5 ++---
 arch/um/kernel/mem.c               |  3 ---
 arch/um/kernel/physmem.c           | 32 ++++++++++--------------------
 arch/um/kernel/um_arch.c           | 19 ++++++++----------
 arch/um/os-Linux/main.c            |  5 +----
 7 files changed, 24 insertions(+), 52 deletions(-)

-- 
2.34.1


