Return-Path: <linux-kernel+bounces-331951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34B297B363
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216871C23443
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3617BEBA;
	Tue, 17 Sep 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHCFImJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36B17A58C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592761; cv=none; b=BhH1Cc3I9g3xy7YXhQ781acyAzR6yU7Clwo8gmcUSd1e3Dw4VFJ6NiMUHq20J4HOc8CHm3zQODOhgLBx+RtFC4IUqNM/NFfyRKKV7VpAwIhyV2ypUv8oZnjg9Hu158XpcRl2l2oSvVJOgjO0laAKBGxJMTwKcVFjtKvrUA+EHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592761; c=relaxed/simple;
	bh=yofaqTlpDkZ3rM8UqrkeWaXbUIPcYHKzv6DpVeMdtJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BtalnRTLJe0dUcPs452gSdcz6L6gJ2CfSu28l0W99kXiE0kS5WXTHmHLoUXxkUK3CFVrOGwltg0hj55dsWVEk9Yr3/jjbS5NQ7vdtUn6CgNgAKpVbLPB8pmZTio8/3qM63l8f3uob+gK0fnBiwgEb91Z3+/D7dzXPQS2DWdX6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHCFImJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726592759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GcaVjrRqk5FeRsN7VHgUJ2H6ojvGJU2nwJ6HohGK7ao=;
	b=XHCFImJtPK85P4AK7m/1J38lyfRIlVu41gfnn2Re/u0JFcej7W5pmqstsZf0yCmREhaGYY
	lEcaYxxCxOC9vt/F59eK0BMUUWEwbljwP6oxCbCgUvv5OkXNQ7HFGq6HLtZCG/ve25jzqI
	avUNnXyZDZzN3lbuwQhTV6Y3qn5X16A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Zco_hSZBNKiFAW6Zfmncpw-1; Tue,
 17 Sep 2024 13:05:57 -0400
X-MC-Unique: Zco_hSZBNKiFAW6Zfmncpw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 298E51955F45;
	Tue, 17 Sep 2024 17:05:55 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACBF719560AA;
	Tue, 17 Sep 2024 17:05:53 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:05:50 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.12
Message-ID: <Zum2QP7hS1mDzqBT@redhat.com>
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

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.12

Summary:

- Remove some unnecesary hold/unhold rsb refcounting
  in cases where an existing refcount is known to exist.
- Remove some unnecessary checking for zero nodeids, which
  should never exist, and add some warning if they do.
- Make the slow freeing of structs in release_lockspace()
  async, run from a workqueue.
- Prior rcu freeing allows some further struct lookups to
  run without a lock.
- Use blocking kernel_connect on sockets to avoid EINPROGRESS.

Thanks,
Dave


Alexander Aring (11):
      dlm: cleanup memory allocation helpers
      dlm: remove unnecessary refcounts
      dlm: never return invalid nodeid by dlm_our_nodeid()
      dlm: warn about invalid nodeid comparsions
      dlm: drop kobject release callback handling
      dlm: async freeing of lockspace resources
      dlm: use RSB_HASHED to avoid lookup twice
      dlm: move dlm_search_rsb_tree() out of lock
      dlm: move lkb xarray lookup out of lock
      dlm: do synchronized socket connect call
      dlm: add missing -ENOMEM if alloc_workqueue() fails


 fs/dlm/config.c       |   2 +-
 fs/dlm/dlm_internal.h |   5 ++
 fs/dlm/lock.c         | 134 +++++++++++++++++++++++++++-----------------------
 fs/dlm/lock.h         |   2 +
 fs/dlm/lockspace.c    |  97 ++++++++++++++++++------------------
 fs/dlm/lowcomms.c     |  36 +-------------
 fs/dlm/main.c         |  12 +++++
 fs/dlm/member.c       |   2 +
 fs/dlm/memory.c       |  28 +++++------
 fs/dlm/memory.h       |   4 +-
 fs/dlm/recover.c      |   9 ++--
 11 files changed, 164 insertions(+), 167 deletions(-)


