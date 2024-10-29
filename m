Return-Path: <linux-kernel+bounces-387496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CD9B51F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B9B1F21879
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF9204F66;
	Tue, 29 Oct 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCgPtw0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EE200CA5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227215; cv=none; b=hH4Idp0YqbbnIST4xmMhicC5DFhG9T4nGrcgIslTJ3/3V4vGzoMCIEDZZXwRCAHmDzhLCRSvZSzj5e32Bo3bYPomJHPvt8y+/MUwP+rn7SjhnC3xYzPtdyQIASUYTCcZ6XSlCN3b8FHVNQulLZkSMIFm599QMSXzEfMQAZTTvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227215; c=relaxed/simple;
	bh=i+Vf8LQzRaMP1d0Nly2QkjcRobxa8yt1nSL0ap/n09o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qMbYADIro2PXFeKDp8RmjDgpZFcEX0kS0/NTYzb1Ib+WGyy+4WrNndVyZ/fce1/98aiozd9qHMifltD9MnrKYUZiG16gPaGNNcLISoD504y4EjL+YNLgpUYlXdcJ4Ua4hHASIT/ZQGohqLeMgQmGeYrYXl/58XgD+kfco5Opw3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCgPtw0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D36C4CEE4;
	Tue, 29 Oct 2024 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227215;
	bh=i+Vf8LQzRaMP1d0Nly2QkjcRobxa8yt1nSL0ap/n09o=;
	h=From:Subject:Date:To:Cc:From;
	b=cCgPtw0fhXbw70rFFzwS1LZUAGPeFPSOsXel1esNwwf8tHuZcSATpk1FhcbAD7rq5
	 BXvVIEoQ/lLNYF9Rk9O+qzYvCeewnJDJ7LFugdNOpMvnC2M8/HbBxN1t3nrg1efbFE
	 wYStwGssNUahi05GTH98ihXKNE94G2dx5Ag9Mjszm5yHfsX9JCmFHtAF9U9WLpcV3T
	 fXgLhXU9795sphGA6mW+XrD/HhMXPCUsCery/XAvY3wUO9zv9d+6v0i/0RuEpgNHm6
	 Itm9avEhlXZAW63ZgLcJuLkljMCSI4tL9C4ybRNchNlxHwSGdSry83WKbLa+j+VeF9
	 yU3qOv1s5qfGQ==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/2] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Date: Tue, 29 Oct 2024 19:40:10 +0100
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAosIWcC/z2MQQ6CMBBFr0Jm7ZBOxUpdeQ/jorYDNIFiWkQTw
 t2duHD58t9/GxTOkQtcqg0yr7HEOQnoQwV+cKlnjEEYtNINKW0xrRNj51HGMDL6ecJxLgvahwj
 2aFplHcj7mbmLn1/5dhfuspjLkNn9e8oQkVWmOddE7ckgYXi7PnG+llfhOjDs+xfzQzp5ogAAA
 A==
X-Change-ID: 20241029-nvme-fc-handle-com-lost-9b241936809a
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

We got a bug report that a controller was stuck in the connected state
after an association dropped.

It turns out that nvme_fc_create_association can succeed even though some
operation do fail. This is on purpose to handle the degraded controller
case, where the admin queue is up and running but not the io queues. In
this case the controller will still reach the LIVE state.

Unfortunatly, this will also ignore full connectivity loss for fabric
controllers. Let's address this by not filtering out all errors in
nvme_set_queue_count.

I haven't tested this version yet, as it needs a bit of tinker in my
setup. So the question is this a better approach? I think it would also
be great to hear from Paul if this works.

In theory the nvme_set_queue_count call still could pass and later
connectivity loss could happen, just before entering the LIVE state. In
this case the only thing to observe the connectivity loss is the keep
alive handler which currently does nothing. I think we should also
trigger a reset in this case. What do you think?

---
Changes in v2:
  - handle connection lost in nvme_set_queue_count directly
  - collected reviewed tags
  - Link to v1: https://lore.kernel.org/r/20240611190647.11856-1-dwagner@suse.de

---
Daniel Wagner (2):
      nvme-fc: go straight to connecting state when initializing
      nvme: handle connectivity loss in nvme_set_queue_count

 drivers/nvme/host/core.c | 7 ++++++-
 drivers/nvme/host/fc.c   | 3 +--
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 5e52f71f858eaff252a47530a5ad5e79309bd415
change-id: 20241029-nvme-fc-handle-com-lost-9b241936809a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


