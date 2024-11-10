Return-Path: <linux-kernel+bounces-403070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC99C30A1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C221C20B43
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A32145324;
	Sun, 10 Nov 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIQDnAAa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0C5FB8D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731207069; cv=none; b=e7X/iuDlnwFhpTrXQPRa4w9X4L5OYUEwR4eN9ABew04BARcAHLrEm0Dnsc57pzumH0w83YsfaMX1UTLvu7RuW205t8IuDCQw9uYc1OlzMiZSnJFJrr2sdv24V5CIs6HbruV3Q3bRdPw//MLS9infn3/j/P+KjmnbI/ny7JeViEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731207069; c=relaxed/simple;
	bh=xCHYEBLskj/H8UxrrsGFp0MCso8Nv2IDIIYyD/FAZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKh9YIHaNCWzdIVFHC8uT9Yy99TnigXYm4BV+ok0RJxXXwmiaIn+Gbm0I7wzoKfotoivNyS7zYhS0Sr8Q8DN7+n5Sbb4tpGvWAt8rss9EcwScAVs+k9tNXPEF4Oc+rFqctOv3EaGaH8S7lpRsxdJ7inOYlBMN/WvEpPQW1UeLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIQDnAAa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731207066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZkge2p7n+qtz9f3rQSaeHXWAmHbmzD/SPamdcAzZh4=;
	b=FIQDnAAaWDF/DzxREtSiEUrI/rK4ZD6G9Hfhqg30S4ZHvP7BfoJuuEzrqfrxXKfX6Q2iSD
	Kt5qa6/ENmtLLjgibd5mF4/ffezXyNdWvjF48FykRB6d1NDZszTkHN1WtsXQXa2CtggS5J
	1aliSlVSOvGwaFLlp4FMoQkq9dpP0cw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-Ya0NUqrdPpOlFVwe1wab0A-1; Sat,
 09 Nov 2024 21:51:03 -0500
X-MC-Unique: Ya0NUqrdPpOlFVwe1wab0A-1
X-Mimecast-MFC-AGG-ID: Ya0NUqrdPpOlFVwe1wab0A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 928671955F43;
	Sun, 10 Nov 2024 02:51:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69D2C300019E;
	Sun, 10 Nov 2024 02:50:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] cgroup/cpuset: Remove redundant rebuild_sched_domains_locked() calls
Date: Sat,  9 Nov 2024 21:50:20 -0500
Message-ID: <20241110025023.664487-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The main purpose of this series is to make sure that there will
be at most one rebuild_sched_domains_locked() call per cpuset
operation. Juri found that is still not the case. Make use of the
existing cpuset_force_rebuild() helper as a replacement for a direct
rebuild_sched_domains_locked() call and check force_sd_rebuild at the
operation end.

The last patch is for removing some unnecessary v1 specific code if
CONFIG_CPUSETS_V1 isn't set.

Waiman Long (3):
  cgroup/cpuset: Revert "Allow suppression of sched domain rebuild in
    update_cpumasks_hier()"
  cgroup/cpuset: Enforce at most one rebuild_sched_domains_locked() call
    per operation
  cgroup/cpuset: Further optimize code if CONFIG_CPUSETS_V1 not set

 kernel/cgroup/cpuset.c | 121 +++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 58 deletions(-)

-- 
2.47.0


