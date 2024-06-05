Return-Path: <linux-kernel+bounces-202964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0D8FD3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE61628765D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8712F5A6;
	Wed,  5 Jun 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3GkS5Qt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0026AFC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607957; cv=none; b=e50wCY5kz9jZ8hk0fXnJSpMUkg+h6T+jFb6gRTHG00DoLl0XAn7zfGRLPkizYfNVIbRPMloMJQHgBGCw0AigPhO8Y3e+bFQjRvbPcQYAMKwi8uFHGJhwlAukgumltq5HHtgBpybRxbx4EQjxbM9k8dc8lBhtahDgMU1yQFyhGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607957; c=relaxed/simple;
	bh=W+wxBm3RxC5Ki14djoLkxw0QjNOmecFvYqeOqobZ7Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sebgPpvKAmCF71ZpywZcd1HhELkgF/PuwvEj8fqZgudbulzVHc7Mj3WIsfksRg0LsFQHvu29furmR7uPvcuVUBPFitrAQ9saffvxKaLPe9f+hTwtoD5OsQkoEabCskhjH/JVDoO01/hRe5fux5lY7v81xnEj0FJyBe9FGzZexYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3GkS5Qt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717607954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TS9fGEndQOk3FBiJhTOyAAupDT0mnziDl7E1bdw4eT0=;
	b=f3GkS5Qtv48X0WrLMmVwNjy5Blp00QRdmXeqb43OfOdJArVBg/F5nJe7/4YMqJJhUQL3rJ
	s5G1H8hwSed36ikW/OPEuqaBqM1hxPdzsIdaUhwq3rDd5bP3K9YFoL5o+Jp337+I+xzZwp
	pjOvxvkzgdIp6U+2Xxzb0DyGcW+6AXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-mfeQ7FoJPJmzF9TnQ3MmNw-1; Wed,
 05 Jun 2024 13:19:12 -0400
X-MC-Unique: mfeQ7FoJPJmzF9TnQ3MmNw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74446195C26F;
	Wed,  5 Jun 2024 17:19:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CDE31956055;
	Wed,  5 Jun 2024 17:19:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/2] cgroup/cpuset: Fix remote root partition creation problem
Date: Wed,  5 Jun 2024 13:18:56 -0400
Message-Id: <20240605171858.1323464-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

While reviewing the generate_sched_domains() function, I found a bug
in generating sched domains for remote non-isolating partitions. After
extending test_cpuset_prs.sh to cover those cases, the bug is confirmed.

The first patch fixes the remote partitions sched domain generation
problem and the second patch updates the test.

Waiman Long (2):
  cgroup/cpuset: Fix remote root partition creation problem
  selftest/cgroup: Dump expected sched-domain data to console

 kernel/cgroup/cpuset.c                        | 55 ++++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       | 29 +++++++++-
 2 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.39.3


