Return-Path: <linux-kernel+bounces-573614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C3A6D9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B9E188BA16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66425E457;
	Mon, 24 Mar 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/AdqPnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737F16F0FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818089; cv=none; b=O/Z3ceGVLBb/2GdWtiBiqh+l519D9+PFmeyZlgj5c2qmTeukhJI2x7XVrsJOzILsz+uavvVc3e70j8eNfgSDl89f0JeAoR20qU05sFLJ6GKpal0heDUQhyIQH6FGia5b3dEJB9meJOuNZ8uipy24kQCq+4fN+pjaW8SXs5VNoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818089; c=relaxed/simple;
	bh=OlvIgwG9o9Mgg5UfvrGptadl8cs3cxfK4MQPyE15xoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QWsgxnQp7cmvndxiOJnw6PAqvwapdZ5qHEGBLqahrAH1LMvydPZ7uIJMvEvnh04v8BTI6StkXLnaHEun5YZxSpe925yaqmq8rALqkiC5/e6fn+mZcKkCCz1Ge3ALAn41TQJYbbX0Y/2fBS+OAME0r29bj8DLSMHLOHvCmS5GMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/AdqPnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC7C4CEDD;
	Mon, 24 Mar 2025 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818088;
	bh=OlvIgwG9o9Mgg5UfvrGptadl8cs3cxfK4MQPyE15xoA=;
	h=From:Subject:Date:To:Cc:From;
	b=R/AdqPnFbsDQDqxKjarxWEYEiifG+1lWk02leRhHokxzVCul72FIwPob0bDqlJK3n
	 /NHf06mMN5ElLSv1zcdOTUvNTbMGCiGVjWl6wKM4F+Qj3hOB7t0hA4UNZGVelQp7NM
	 2k1gGiCmqS4hWxEfYnLqVORqgaJ8W+lEWYXzDuQaKfkpXQOXw4kNn8y7z3jUuefiy1
	 mI2I5vBX1uusPzR8+xzw6YNX3N5q5VrnZrxRzfJvL3eZ1G6BxLfKFtgu/V0KPQOw6W
	 bymxIgMkFQAIuGFD3HfRxjWKgrEAMy6fyZplZv4Au7ALpkU6BAUb5Ofx1lMxxv28Pz
	 JbgQ2yLUfqVig==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH RFC 0/3] nvme: add support for command quiesce timeout
Date: Mon, 24 Mar 2025 13:07:55 +0100
Message-Id: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxL4WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3ZICE0MjS91EE9MkS0uLJCOD5CQloOKCotS0zAqwQdFKQW7OSrG
 1tQCt/a88XQAAAA==
X-Change-ID: 20241128-tp4129-a45b998b20cb
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

This is thought just as discussion input for the KATO session during
LSFMM.

The last patch is the interesting part. When commands is failed over to
the next path, it delays the requeuing on ctrl level. The implemention is
on purpose not implementing all the details. Just the very basics so it's
easy to understand what the main idea is.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      nvmet: add command quiesce time
      nvme: store cqt value into nvme ctrl object
      nvme: delay failover by command quiesce timeout

 drivers/nvme/host/core.c        | 20 ++++++++++++++++
 drivers/nvme/host/fc.c          |  4 ++++
 drivers/nvme/host/multipath.c   | 52 ++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h        | 16 +++++++++++++
 drivers/nvme/host/rdma.c        |  2 ++
 drivers/nvme/host/tcp.c         |  1 +
 drivers/nvme/target/admin-cmd.c |  6 +++++
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  4 +++-
 9 files changed, 102 insertions(+), 4 deletions(-)
---
base-commit: 25462bccac81486c2fff0fa4b4c2b1e56751b8de
change-id: 20241128-tp4129-a45b998b20cb

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


