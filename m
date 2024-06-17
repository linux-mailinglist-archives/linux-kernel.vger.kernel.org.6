Return-Path: <linux-kernel+bounces-217760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E877390B3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9F51C21D27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592EF15CD68;
	Mon, 17 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bapg7JOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31D15B990
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635280; cv=none; b=qf4OGxS+7qyTLt2TKb2YgYgNPdNPpCyWEA+UMUCAelUJEOD0YhUfBPV6nrYR3wteyes6LUgHZSiR3DktoLd0mZHJB9nkPkzWR9UqG69uBR5EUijtkrv0fP6ivAeOZK/PyY/iiOod3T/BGMuVahjXXW37WG6oDFyh4An4qjXbMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635280; c=relaxed/simple;
	bh=5jQTs2lxCHcFprbF6CKPg1CLdTOcay7Z0kuZBu+6vXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9lhY1dNAGS7Udl+Jd7ynX8Tsa344dV4KtvjFThskFcCiz0uqzC/EBFmqObbWS5LLjLCus1YciosTQvGRjLldF8F+XN9Si7/klQpwhAeP21ANCXqb8Dnc+On/TqIpZqakDpc550+/gnSeWob28uhdY+MBMyjDQMIENY/EFDj+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bapg7JOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718635278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PvUM+GN/gB29YaibI3luJ34zEaRHwAEivDnpxaH0NNc=;
	b=bapg7JOvB6p5MLk5p4bYzsKkhaENcS4pdUgrAA7S0R2xmav4NFRzlS4ut4Q8B0J7W/CF15
	EnUHhGFSwPmbww3jXZ6x2ABdNiNjH9ynC1pfz4VflqEsLAMIA2MqPpwSLThtTOOGA9AHjS
	S0xypwm5Up0DHnLpF/W//VGj30Nospg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-t7EwKp93N7CRrMaxXoaWmQ-1; Mon,
 17 Jun 2024 10:41:12 -0400
X-MC-Unique: t7EwKp93N7CRrMaxXoaWmQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11F07195609D;
	Mon, 17 Jun 2024 14:41:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1E591956048;
	Mon, 17 Jun 2024 14:41:03 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2 0/5] cgroup/cpuset: Fix miscellaneous issues
Date: Mon, 17 Jun 2024 10:39:40 -0400
Message-Id: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

 v2:
  - Fix test_cpuset_prs.sh problems reported by test robot
  - Relax restriction imposed between cpuset.cpus.exclusive and
    cpuset.cpus of sibling cpusets.
  - Make cpuset.cpus.exclusive independent of cpuset.cpus. 
  - Update test_cpuset_prs.sh accordingly.
  
 [v1] https://lore.kernel.org/lkml/20240605171858.1323464-1-longman@redhat.com/

This patchset attempts to address the following cpuset issues.
 1) While reviewing the generate_sched_domains() function, I found a bug
    in generating sched domains for remote non-isolating partitions.
 2) Test robot had reported a test_cpuset_prs.sh test failure.
 3) The current exclusivity test between cpuset.cpus.exclusive and
    cpuset.cpus and the restriction that the set effective exclusive
    CPUs has to be a subset of cpuset.cpus make it harder to preconfigure
    the cgroup hierarchy to enable remote partition.

The test_cpuset_prs.sh script is updated to match changes made in this
patchset and was run to verify that the new code did not cause any
regression.

Waiman Long (5):
  cgroup/cpuset: Fix remote root partition creation problem
  selftest/cgroup: Fix test_cpuset_prs.sh problems reported by test
    robot
  cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE until valid partition
  cgroup/cpuset: Make cpuset.cpus.exclusive independent of cpuset.cpus
  selftest/cgroup: Update test_cpuset_prs.sh to match changes

 Documentation/admin-guide/cgroup-v2.rst       |  12 +-
 kernel/cgroup/cpuset.c                        | 158 +++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       |  75 ++++++---
 3 files changed, 180 insertions(+), 65 deletions(-)

-- 
2.39.3


