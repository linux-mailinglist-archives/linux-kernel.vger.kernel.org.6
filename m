Return-Path: <linux-kernel+bounces-425393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F609DC183
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037D6161975
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB7176FB6;
	Fri, 29 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2g3PDC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61814F135
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872509; cv=none; b=o01n/hkvajewT+zeSyEywzwszO7rf1TtsXhuiN6Z7pCtt2e5PP5FWg1zZWheleK9NPKTeFr7gnH7OcBOaO7LlD/bJ5FRrTLX3fk0Q4ffGIYO/n5juZTRsGAmtlVTHNdn8Jm+pptkXwRiLU56UFJ0UUS733QqUu+yNmFWoiEcvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872509; c=relaxed/simple;
	bh=v3qXPXvUm4LeQfu0uk/hjbFzCdAxPDZNggDNSWyJChw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uQAi1l32e9VQ62QE7dE1NNwid1z/b+IM7psjA/eoLC1KEno0oIayPMLgCC1G4NLqtCv6ocQJzbTeFlE1Q3eoN6pz/oos2xaD7s4jyLdDvY9ur3xLAJfI+61xpnEXv0/eLWYnQb6YWkQn21S7sXMqxfNvroQWn0k1YtkKFyUKAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2g3PDC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF19C4CECF;
	Fri, 29 Nov 2024 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872508;
	bh=v3qXPXvUm4LeQfu0uk/hjbFzCdAxPDZNggDNSWyJChw=;
	h=From:Subject:Date:To:Cc:From;
	b=I2g3PDC305GsSRmhpnTZo6vv48DvZk7qOnlvBNbmmJv396pHJKo3/Vo3SI5RA2XQo
	 xNZoNneMO5TuZLP8vYTi5wVzg41t5xrZugwE9CJihQV383hcSKDfCuJASbdy6DTLUN
	 9A1LdYz1XHCdPIP2scuGSvR2kbVHZ3oah1yk5DazN9tvH7r0Y+x8gGCFoMa3VZzVrM
	 jjeIhvs5b/kcMnlmWUYOhsL6OGS+vFBdzcthjLiOhfhK9CyOWsdhghCPs3KgkSAlJL
	 tekny0gpgE9rVR+5j+a84hhx4bg8ixUn3fmsC1kmxvW80kF/wGj7VCRfnQ6ZmucD8t
	 /jIlc4cDZrVkg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/3] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Date: Fri, 29 Nov 2024 10:28:22 +0100
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaJSWcC/4WOwQ6CMBBEf4X07JJtUbSe+A/DodAFGqE1W0SN4
 d+tHLx6fJmZl3mLSOwoinP2FkyLiy74BMUuE+1gfE/gbGKhUO0lKg1+mQi6FlJoR4I2TDCGOIN
 uUkEX5Qm1EWl9Y+rcczNf6sQdp+Y8MJmfD0sppcZyf8ylPB1KkGAfpvfEVbxHyi19RYOLc+DX9
 nBRX93/M4sChEODVhZHUgZNdSX2NOaBe1Gv6/oB5BfWC/gAAAA=
X-Change-ID: 20241029-nvme-fc-handle-com-lost-9b241936809a
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

After a long hard stare at the keep alive machinery I am convienced we
need to trigger a reset when nvme_keep_alive_end_io is called with status
!= 0. There is a lengthy explanation in patch #3.

I've also tested this version with blktests and some manual tests. Though
it's not that easy to get into exact sequence reported by Paul.

Daniel

previous cover letter:

We got a bug report that a controller was stuck in the connected state
after an association dropped.

It turns out that nvme_fc_create_association can succeed even though some
operation do fail. This is on purpose to handle the degraded controller
case, where the admin queue is up and running but not the io queues. In
this case the controller will still reach the LIVE state.

Unfortunatly, this will also ignore full connectivity loss for fabric
controllers. Let's address this by not filtering out all errors in
nvme_set_queue_count.

---
Changes in v3:
- collected reviewed tags
- added nvme_ctrl_reset to keep alive end io handler
- Link to v2: https://lore.kernel.org/r/20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org

Changes in v2:
- handle connection lost in nvme_set_queue_count directly
- collected reviewed tags
- Link to v1: https://lore.kernel.org/r/20240611190647.11856-1-dwagner@suse.de

---
Daniel Wagner (3):
      nvme-fc: go straight to connecting state when initializing
      nvme: trigger reset when keep alive fails
      nvme: handle connectivity loss in nvme_set_queue_count

 drivers/nvme/host/core.c | 13 ++++++++++++-
 drivers/nvme/host/fc.c   |  3 +--
 2 files changed, 13 insertions(+), 3 deletions(-)
---
base-commit: 029cc98dec2eadb5d0978b5fea9ae6c427f2a020
change-id: 20241029-nvme-fc-handle-com-lost-9b241936809a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


