Return-Path: <linux-kernel+bounces-534689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E2A46A01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62983A30DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAE22A7F3;
	Wed, 26 Feb 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHoCcHaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB621A92F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595557; cv=none; b=ppNB+4uDyaUoCDmte4NPf46pqz2XxytTc5oZtyhhpTmki4lWZYId0rJy5O9L5lwqoJZrshojxB/oZe3MST6DXdiHlcRRn+mHX+xoUIyjhO9Kn7GPX69+oimhWSjYrNfXSEPh5gkPBW9QAbcupEI8bsghE1Onpq4wDVBAj5P6VoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595557; c=relaxed/simple;
	bh=l7UD7IetAj7BmrCoDO0U0uQx/vTHlH3SaHjBpIIiXwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F121YALFof6F99elxrAYZChHxCN3qPzkzCaJYzmlQCY77pljltSg56GLm50JfY85KYbDVPZ5J28Rz6ZtQZ7EG28K+5l+Tzi50Y/PCTm1SHDjLxc/h7qo1ws2/zFroCWFU621DnmJTUW7LkwLV95ko6765WNyFS40GU6mte+Z2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHoCcHaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC58C4CED6;
	Wed, 26 Feb 2025 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595556;
	bh=l7UD7IetAj7BmrCoDO0U0uQx/vTHlH3SaHjBpIIiXwo=;
	h=From:Subject:Date:To:Cc:From;
	b=gHoCcHaE6zHSuAJOBBTmSXgjrkQwNsFNU+3QHgpgWz47MT2/kNVqBR0KK6ILdr1Yj
	 NR+lhGDlUw6ppeSmY0xTyMvMGEm2OX7k5u0/cWa/YJJHx0BmMVZMbb01qRcGvLgIUr
	 bLOUyv2tuQnaGUPQqKejvmpYWOViVWCJOBV647o//9XYxpPauzd3EA/cICfkNutxeS
	 I8ZTcVa8UqdhUIKJmqg/Z40uFXU0NeFmLYGI3wWQognmPAO2+gwtjx8CgpCQ6t4Xyk
	 VP9agKNXiTXmdCT7y9CUj27BYAhINMi+HfCqqW0o346swVwR+ghr4aXF5fTFY69nqm
	 wb6XgpdaCQnFA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 00/11] nvmet-fcloop: track resources via reference counting
Date: Wed, 26 Feb 2025 19:45:52 +0100
Message-Id: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBhv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MT3byy3NQS3bTknPz8At1EMxNLc2OLJPNUs1QloJaCotS0zAqwcdG
 xtbUA6pQdMF4AAAA=
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The fcloop module is mainly used for testing, that is with blktests.
Unfortunatly, there are shortcomings when it comes to releases resources.
E.g. unloading the module can result in UAFs.

I've written two new blktests which are triggering reconnects. The first
one is doing this by removing the target while the host is still up and
running. The second one is trigger a reset via the new debugfs interface.

Both of these two tests cases work fine for TCP and RDMA but not FC.

By introducing reference counting on various objects the UAFs go away.
Also KASAN is happy. There are also a bunch of fixes for nvmet-fc which
got uncovered by the fcloop fixes.

I still see one UAF sometimes happening. When the association attempt
fails (looks like yet another bug), the test case removes all resources:

 (NULL device *): Create Association LS failed: Association Allocation Failed
 (NULL device *): queue 0 connect admin queue failed (-6).
 nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (-6)
 nvme nvme1: NVME-FC{0}: Reconnect attempt in 1 seconds
 nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
 (NULL device *): Create Association LS failed: Association Allocation Failed
 (NULL device *): queue 0 connect admin queue failed (-6).
 nvme nvme1: NVME-FC{0}: reset: Reconnect attempt failed (-6)
 nvme nvme1: NVME-FC{0}: Reconnect attempt in 1 seconds
 nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
 nvme_ns_head_submit_bio: 29 callbacks suppressed
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 block nvme1n1: no available path - failing I/O
 nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 ==================================================================
 BUG: KASAN: slab-use-after-free in nvme_fc_rescan_remoteport+0x56/0x1d0 [nvme_fc]
 Read of size 8 at addr ffff88810b662890 by task kworker/u36:10/1876

 CPU: 3 UID: 0 PID: 1876 Comm: kworker/u36:10 Tainted: G        W          6.14.0-rc2+ #48 d5f3bf6340950de08bebd912d815fcf6b60c18ab
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-3.fc41 04/01/2014
 Workqueue: nvmet-wq fcloop_tgt_rscn_work [nvme_fcloop]

static void nvmet_port_subsys_drop_link(struct config_item *parent,
		struct config_item *target)
{
	[...]
found:
	list_del(&p->entry);
	nvmet_port_del_ctrls(port, subsys);
	nvmet_port_disc_changed(port, subsys);   /* XXX triggers the above UAF */

	if (list_empty(&port->subsystems))
		nvmet_disable_port(port);
	up_write(&nvmet_config_sem);
	kfree(p);
}

The nvmet_port_disc_changed is a bit useless, because these event will
never be seen by the host. Anyway, more debugging is necessary.

I'll send the new tests cases for blktests soon.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (11):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: track tport with ref counting
      nvmet-fcloop: track rport with ref counting
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport

 drivers/nvme/target/fc.c     |  82 +++++------
 drivers/nvme/target/fcloop.c | 326 ++++++++++++++++++++++++++++---------------
 2 files changed, 255 insertions(+), 153 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


