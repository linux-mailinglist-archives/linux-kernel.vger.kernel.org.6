Return-Path: <linux-kernel+bounces-252847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A19318DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CAB1F225F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0E208D7;
	Mon, 15 Jul 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeXjmhat"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D5175AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062524; cv=none; b=dSLXudHBZ28WIphBaH/BQBJ3smffi0T8ewtoX2+h3qmAN9XHlLDlY2KJMA024L6IadDaPcZvTdGDM0t2GaSj1QcKfEBH7dAnKVUdJHsrOFb5SLPxhC8p3PLWfMM7Bs7/2Aj73TkpzEEyXrEOcT6xGP10mamxoGCIZzBjsw1MQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062524; c=relaxed/simple;
	bh=aE6yKi7dPET4tS4j83msbQcxhUAawST8Rx2fkVQBCFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r2lS13gXXClZAjMZy10ZqPZpQ6h78Kxh3Csh6pFa+emabzFFg9s8ReM0wYpP61zUxrf0g7AlSXbdzWLUh1+EP1n1+BFKnT9uhjAJUjyMIohfDMZvOYx2iQxFHR0yWZ9Df5Ur1aG3W2KQYg/UYW5iLi2VM6bBl6ngwR0gMwoYxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeXjmhat; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721062521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XMIv1mtz93g19iyFIr1rGeUjzzJtuEefPD6XIt0a1/0=;
	b=TeXjmhat1LflSSG2VyGrzQ/QhgVHaqmq+FAol8Hny88NBhfuZs4W6vhcbVF2pMJ44LhfKa
	UbxdK9H8vgRr3iZ+ujTFkzjI/6lBedPcH6lDL4j4RAF6Lp4Nwk1oSpiqcsq7+z1W8+KLQJ
	lC/slqGWEDWnwCA4rD+P4xrtHpgJghI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-GSltMIc9MFSytx5rKUp-Ng-1; Mon,
 15 Jul 2024 12:55:17 -0400
X-MC-Unique: GSltMIc9MFSytx5rKUp-Ng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC8219540EE;
	Mon, 15 Jul 2024 16:55:16 +0000 (UTC)
Received: from redhat.com (unknown [10.22.17.217])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7C219560AE;
	Mon, 15 Jul 2024 16:55:15 +0000 (UTC)
Date: Mon, 15 Jul 2024 11:55:12 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.11
Message-ID: <ZpVUcCId-3JUmz03@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.11

Note, this set includes a patch touching drivers/md/md-cluster.c, acked
by the md-cluster developers, making use of the new DLM_LSFL_SOFTIRQ_SAFE
flag.  Overall, changes include:

- New flag DLM_LSFL_SOFTIRQ_SAFE can be set by code using dlm
  to indicate callbacks can be run from softirq.
- Change md-cluster to set DLM_LSFL_SOFTIRQ_SAFE.
- Clean up for previous changes, e.g. unused code and parameters.
- Remove custom pre-allocation of rsb structs which is unnecessary
  with kmem caches.
- Change idr to xarray for lkb structs in use.
- Change idr to xarray for rsb structs being recovered.
- Change outdated naming related to internal rsb states.
- Fix some incorrect add/remove of rsb on scan list.
- Use rcu to free rsb structs.

Thanks,
Dave


Alexander Aring (14):
      dlm: remove scand leftovers
      dlm: don't kref_init rsbs created for toss list
      dlm: remove unused parameter in dlm_midcomms_addr
      dlm: remove ls_local_handle from struct dlm_ls
      dlm: drop own rsb pre allocation mechanism
      dlm: move lkb idr to xarray datastructure
      dlm: move recover idr to xarray datastructure
      dlm: use rcu to avoid an extra rsb struct lookup
      dlm: use LSFL_FS to check for kernel lockspace
      dlm: introduce DLM_LSFL_SOFTIRQ_SAFE
      dlm: implement LSFL_SOFTIRQ_SAFE
      md-cluster: use DLM_LSFL_SOFTIRQ for dlm_new_lockspace()
      dlm: remove DLM_LSFL_SOFTIRQ from exflags
      dlm: add rcu_barrier before destroy kmem cache

David Teigland (2):
      dlm: change list and timer names
      dlm: fix add_scan and del_scan usage

Dr. David Alan Gilbert (1):
      fs: dlm: remove unused struct 'dlm_processed_nodes'


 drivers/md/md-cluster.c  |   2 +-
 fs/dlm/ast.c             | 170 +++++++++-----
 fs/dlm/ast.h             |  11 +-
 fs/dlm/config.c          |   2 +-
 fs/dlm/debug_fs.c        |  10 +-
 fs/dlm/dlm_internal.h    |  60 ++---
 fs/dlm/lock.c            | 568 +++++++++++++++++++++++------------------------
 fs/dlm/lock.h            |   7 +-
 fs/dlm/lockspace.c       | 131 +++++------
 fs/dlm/lowcomms.c        |   8 +-
 fs/dlm/lowcomms.h        |   2 +-
 fs/dlm/member.c          |   2 +-
 fs/dlm/memory.c          |  10 +-
 fs/dlm/midcomms.c        |   4 +-
 fs/dlm/midcomms.h        |   2 +-
 fs/dlm/recover.c         |  78 +++----
 fs/dlm/recover.h         |   2 +-
 fs/dlm/recoverd.c        |  14 +-
 fs/dlm/user.c            |  42 ++--
 include/linux/dlm.h      |  17 +-
 include/uapi/linux/dlm.h |   2 +
 21 files changed, 583 insertions(+), 561 deletions(-)


