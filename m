Return-Path: <linux-kernel+bounces-565955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED1A67194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21473AA652
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6D209689;
	Tue, 18 Mar 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj+GWgVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86035957
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294403; cv=none; b=rnJVY5rycTqLdlNq3PfrXLRT43TQE3U1vLcoBZlGpWl7JIdSMdZZnmU5TCzEIF++paugQDG8Z63MPcF3MoyFRsy6XvJMn8x90ElK6cGk3k/atfoLZLcKgVT2W6UPlmqGdukC9PsYj6UUCfTiEmO+rTG635E9CuKoXgWaRxLjWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294403; c=relaxed/simple;
	bh=x4ZfUJ1dTXVbzL8RRo44yqAIAd/xoE2IKgTqAylCCj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lwiKg6FGfuSh6ak8EQZ3g+MkN1S9/5MK1MCoFQ8BpT01sKvhvtuRl0zWkuo2AEmR7kbz8iPPHA3sAifkcSh1zzmgBX6zsjs+BJOL8MsMRdn3dviGrUCw7EaLRpKkWV2wY2fA01aLx4qtkFwb5a/Y6S6rX/+gRN5d0TLWhvRJesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj+GWgVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7EBC4CEDD;
	Tue, 18 Mar 2025 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294402;
	bh=x4ZfUJ1dTXVbzL8RRo44yqAIAd/xoE2IKgTqAylCCj0=;
	h=From:Subject:Date:To:Cc:From;
	b=kj+GWgVlWMqMXLT/pjvi+8+VJWBlOhy7Jp/yHtyHD3ED4evaustyMWDtjjXzevlH1
	 TRyLbBLTSH2GzT6ab5Z+PlersZaarxTzQNyoyS8IRYxq6BYfuaUZdv01UKyu5sjkCw
	 2tg8AHXlpBHPebQHHC/9bCUHgX0oc2gqfehhQWRwHj2+NrRiv22Kya2i8f0V8LGQkf
	 bibmmctSCkZmZR1yCHrzkiVl7fPNzSRH100zt1EuQTFtE0rm8BGCArbCo+5ts1IFj2
	 O31WoScsUVAHsJdA/RiYLlOhWQ1bz2D26u+0O3FILUDaa6yxDpZxjFGu5dKWM9+mSN
	 e3oq0ImBwWumA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 00/18] nvmet-fcloop: track resources via reference
 counting
Date: Tue, 18 Mar 2025 11:39:54 +0100
Message-Id: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpN2WcC/13M3QqCMBjG8VuR97jFvprWUfcRHej2qiPbZJNRi
 PfelCDs8Hng/5shYrAY4VLMEDDZaL3LQxwK0H3tOiTW5A2c8hPlTBKXnjiRVg/ej6RW8lyKqil
 RIeRkDNja18bd7nn3Nk4+vDc9sfX9QlztocQIJZo2phJGClT19YHB4XD0oYNVSvxXC8b+ap7rV
 kuqGyXR4L5eluUD9GGuv+cAAAA=
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

It turns out v2 had a memory leak, which sent me down the rabbit hole
once again. The obvious leak was easy to fix. I took one reference too
much on fcloop_lsreq.

The second one was a really tricky. The fcloop_lsreq object are allocated
by either host or target. So the lifetime of these object are tied to the
lifetime of the host or target. I tried several things to avoid UAFs but
everything failed. Eventually, I decided to allocated the fcloop_lsreqs
in fcloop directly. All got way simpler and the mem leak is gone and
there are no UAFs anymore or blocked processes.

Sometimes some blktests fail but these really look like existing problems
which got uncovered by this series.

With this series the fcloop and nvmet-fc should be in way better shape
and hopefully most of the UAFs should be history. This allows futher
refactoring/cleanup/improvements or more nasty blktests.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v3:
- fixed memory leaks
- allocates fcloop_lsreq in fcloop directly
- prevent double free due to unregister race
- collected tags
- Link to v2: https://lore.kernel.org/r/20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org

Changes in v2:
- drop tport and rport ref counting, use implicit synchronisation
- a bunch of additional fixes in existing ref countig
- replaced kref with refcount
- Link to v1: https://lore.kernel.org/r/20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org

---
Daniel Wagner (18):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: sync targetport removal
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvmet-fc: put ref when assoc->del_work is already scheduled
      nvme-fc: do not reference lsrsp after failure

 drivers/nvme/host/fc.c       |  13 +-
 drivers/nvme/target/fc.c     | 153 +++++++++------
 drivers/nvme/target/fcloop.c | 435 ++++++++++++++++++++++++++-----------------
 3 files changed, 376 insertions(+), 225 deletions(-)
---
base-commit: a149420f548dc8e2258461522f498252554c0bbd
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


