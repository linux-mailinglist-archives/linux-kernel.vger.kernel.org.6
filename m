Return-Path: <linux-kernel+bounces-555833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DFA5BD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766FE1897D65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B322D7A5;
	Tue, 11 Mar 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMhHb+bJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70771E883A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687902; cv=none; b=jMcsSlUQSgQX0s4+JpxO0GQ/sR9/I/H1blukX0x237leYoCXMdC9LXbaPv8dm6+xLZ9jOBoM0mIo7cnSuKAX2OAsJYfZ+qvxobgEDUUD+uJeG3nk1+RYM/1e8DT2SgsAKkM8ehyxEy2F5vGq1WfxejD1FW4XdBwxgWxT3vpKx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687902; c=relaxed/simple;
	bh=eA0gXLdR8NU7j/cSciXgg6v3rrHW4bvlrhA6x3wySUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fCwCfIQmTbfZKSFyEMEddHuyVbCDewFPMnrqYGsGprfAn6IOMlacC9D4vd+jvMmjia9I7ykIHEFIR7kwiF7btv6FozzNgIKpf9air8qChHpgMm+WP9tYwgetqoM6Pqr/2oH8Z/XsJqvsJIoP70ANXJhSjPVbGnuzk08FYaqJrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMhHb+bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E8BC4CEE9;
	Tue, 11 Mar 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687901;
	bh=eA0gXLdR8NU7j/cSciXgg6v3rrHW4bvlrhA6x3wySUE=;
	h=From:Subject:Date:To:Cc:From;
	b=KMhHb+bJ5He/eENrBrmUIB5q+xURf8b+IsXJ0i1s71x1+UW4Dn3A6tBmw5ZztlG0O
	 0V5nFewuxswJjFVafY+ALYd3Fw5u7McbfB/Oa6n+/3JSFxKx9LyfWED4USfS9lkF8U
	 a26pEXmvOxHK4voDk+W+fu8g8X+x22k37n0Wuqlm9LsM8v6JPRgbWEmRBuISys19lR
	 sFr6ZakpUishNUrufE1Fxiq/yTBNbl60KOAm8CLRodTmuvtrzz290yEwfQn6c1zKc3
	 jtmeadc6Gp4wCIyrVIHnr1hThC/EzbJm9CxHPZSfHiORe2k3opxNz7R5KIG/W/XPdq
	 fqmuSTI46FCaA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 00/15] nvmet-fcloop: track resources via reference
 counting
Date: Tue, 11 Mar 2025 11:11:26 +0100
Message-Id: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4M0GcC/1XMQQ6DIBRF0a2YPy4NAkXrqPtoHCB8ldSCAUPaG
 PZeajrp8L7knR0iBosRumqHgMlG610JdqpAz8pNSKwpDYyyC2W1IC49cSOjXrxfiZLi2vB2aFA
 ilMsacLSvg7v3pWcbNx/eh57q7/qDmPyHUk0o0XQwLTeCo1S3BwaHy9mHCfqc8wcvlJnHqQAAA
 A==
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The idea to use ref counting for tport and rport didn't work well. fcloop
was to eager to remove resources when the assocication was torn down.
Thus I looked more closely how the existing solution is supposed to work
and fixed all the problems I found.

This also avoids taking references for a nport and a rport/tport step in
step which Hannes was not happy with.

With all these changes it is possible to add/remove the target side and
nothing blows up anymore. There is just one small issue left with
nvme/030. The problem is that the test case assumes that the generation
counter is updated immediately but for FC it takes a bit, thus the test
fails. A sleep before reading the genctr 'fixes' it:

@@ -36,27 +36,32 @@ test() {
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
 	_create_nvmet_host "${subsys}1" "${def_hostnqn}"

+	sleep 1
 	genctr=$(_discovery_genctr "$port")
[...]

There is another problem I was not able to figure out so far. When I run
blktests in a loop, the system runs out of memory eventually.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- drop tport and rport ref counting, use implicit synchronisation
- a bunch of additional fixes in existing ref countig
- replaced kref with refcount
- Link to v1: https://lore.kernel.org/r/20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org

---
Daniel Wagner (15):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: sync targetport removal
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: take tgtport refs for portentry
      nvmet-fc: put ref when assoc->del_work is already scheduled

 drivers/nvme/target/fc.c     | 146 ++++++++++-------
 drivers/nvme/target/fcloop.c | 366 +++++++++++++++++++++++++------------------
 2 files changed, 308 insertions(+), 204 deletions(-)
---
base-commit: 4bfed375fd3acdfa4324acaf22f7664e4819fbb1
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


