Return-Path: <linux-kernel+bounces-514549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D2AA3585C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88153A5E97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6B21E0A2;
	Fri, 14 Feb 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPpiH/bF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EE1632C8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520137; cv=none; b=u/8KMMdFYWg6DMxfVRkFz4gzcGCyu1tcNYwTAnJdz3eA7Lma+OeQGGASBKapBbx4LSLAI69mPrhaW9wVclL/ZqoMZX2EjpdA84nMdWT53HEKV54uTxJVK+79sJMjg2q1qQb0Sk2padbh1kL77hj1YZvt6SNVziklMz9g8zmlxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520137; c=relaxed/simple;
	bh=+DvmIDAFvzsza7cyWGZSUdLzfYbcKamkNgmexqX3s/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oNwBgsutSL1J0/XSo2IYMETdG8QPF38yUgnDDn8X+ttxyQeGQBidzXZmq8Pt9r9JzHPnzaBJq6NRiFaxsz93Fylb+lhI3SwtrBE77Y6fhyfdedKTGSmaBEHp/kH4kmtidheEteERrAPzaPgHWroLPo2zSlFSaAVW0oMn/dkvHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPpiH/bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D68C4CED1;
	Fri, 14 Feb 2025 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520136;
	bh=+DvmIDAFvzsza7cyWGZSUdLzfYbcKamkNgmexqX3s/U=;
	h=From:Subject:Date:To:Cc:From;
	b=uPpiH/bFpw69xtS5sKK7gmd7o3r520yn2Q4g6FCCcXrbg04d3qMiGCQumJX780sZ4
	 hrLfPK1CsFy1cDR2UXju4iGl9IWXCA3PJ+COggZYHsJrWlxWsCGmK6aH+Gl/8LYiDd
	 jVSCwb/QmPmlxUObac7iLlfbjrOe92aQEq54MgQLVVjtOvyIIYylMDDAtCXuK5FaPW
	 x1xF7Ksgkwk73xWPb6DZeYTIh2BS9+yKQ17qMATO3AuCJHN+PD5lWhPRKfMOv5+QTU
	 0t3VqmBFtmtHiokSxfcACSpe50eREKjRivoVKm04S9nROjzfgdu2HC5G15skRLyeHq
	 xSH1bGxo7yylQ==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Date: Fri, 14 Feb 2025 09:02:02 +0100
Message-Id: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHr4rmcC/x3LQQqAIBBG4avIrBtwlDZdJVpI/tYsslCIILx70
 vLj8V6qKIpKk3mp4NaqZ+6QwdC6h7yBNXaTs260Tjzn+wCnlZM+qIwYJIiNSH6k/lwFf+jLvLT
 2AcszEpxfAAAA
X-Change-ID: 20250213-nvme-fc-fixes-eda1a10def35
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
introduced a bug. I didn't spot the schedule call in
nvme_change_ctrl_state.

It turns out the locking is not necessary if we make the state machine a
bit more restrictive and only allow entering the LIVE state from
CONNECTING. If we do this, it's possible to ensure we either enter LIVE
only if there was no connection loss event. Also the connection loss
event handler should always trigger the reset handler to avoid a
read-write race on the state machine state variable.

I've tried to replicate the original problem once again and wrote a new
blktest which tries to trigger the race condition. I let it run a for a
while and nothing broke, but I can't be sure it is really gone. The rest
of the blktests also passed. Unfortunatly, the test box with FC hardware
is currently not working, so I can't test this with real hardware.

[1] https://lore.kernel.org/all/denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m/
[2] https://lore.kernel.org/all/20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org/

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (2):
      nvme: only allow entering LIVE from CONNECTING state
      nvme-fc: rely on state transitions to handle connectivity loss

 drivers/nvme/host/core.c |  2 --
 drivers/nvme/host/fc.c   | 67 +++++-------------------------------------------
 2 files changed, 6 insertions(+), 63 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250213-nvme-fc-fixes-eda1a10def35

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


