Return-Path: <linux-kernel+bounces-301593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4B95F303
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670ACB21293
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A89188915;
	Mon, 26 Aug 2024 13:34:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30618785F;
	Mon, 26 Aug 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679295; cv=none; b=TmafVnl0Qd7ylFpY9SLke2lfH3CHNn7yPNo5n4WoWyHN0FZp9DWpsbuhaGfEl4FV7rP8x+021vZHz3d+j4+EuHKlvU8LSrvPTtNcOu3eoLuXJajwyjSWNzGtuXlkJCnXY+Mf5TbpM2bo4yn3vb+euBn+sNSUm9AdCnbP5cYGdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679295; c=relaxed/simple;
	bh=SWCCNzyFbi5G+VtT+iTzetETHaM657qBwvjvgB2qxW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovNLKo9N/EJujby9y9HqJH43a0GXqKlCdVe0kb+H4s3Fq8cBYhhUMA5gQLAQA1YUrrhOM3CBAWVbS26Xi/h/cwFuRv0uEERioT9TtVTmE5Oqmg2ZP4i7IfscuYWYKjVjwRQC2YMbHMPHMONtrcZyzaKs0WUyWVGvI2U0ETffTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wss3t4PCnz20ml3;
	Mon, 26 Aug 2024 21:30:02 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id D8CB71402E1;
	Mon, 26 Aug 2024 21:34:49 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 21:34:49 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v2 -next 00/11] cgroup:cpuset:separate legacy cgroup v1 code and put under config option
Date: Mon, 26 Aug 2024 13:26:52 +0000
Message-ID: <20240826132703.558956-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Cgroups v2 have been around for a while and many users have fully adopted
them, so they never use cgroups v1 features and functionality. Yet they
have to "pay" for the cgroup v1 support anyway:
1) the kernel binary contains an unused cgroup v1 code,
2) some code paths have additional checks which are not needed,
3) some common structures like task_struct and mem_cgroup contain unused
   cgroup v1-specific members.

Cgroup memory controller has already separated legacy code to
memory-v1.c. So it is time to do the same thing for cpuset controller.

This patchset aims to do:
1) moving cgroup v1-specific cpuset code to the new cpuset-v1.c file,
2) putting definitions shared by cpuset.c and cpuset-v1.c into the
   cpuset-internal.h header,
3) introducing the CONFIG_CPUSETS_V1 config option, turned off by default,
4) making cpuset-v1.c to compile only if CONFIG_CPUSETS_V1 is set.

---
V2:
- Update to base on the latest cgroup/for-6.12.
- Add CONFIG_CPUSETS_V1 for cpuset_memory_pressure_bump.

Chen Ridong (11):
  cgroup/cpuset: introduce cpuset-v1.c
  cgroup/cpuset: move common code to cpuset-internal.h
  cgroup/cpuset: move memory_pressure to cpuset-v1.c
  cgroup/cpuset: move relax_domain_level to cpuset-v1.c
  cgroup/cpuset: move memory_spread to cpuset-v1.c
  cgroup/cpuset: add callback_lock helper
  cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
  cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
  cgroup/cpuset: move v1 interfaces to cpuset-v1.c
  cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
  cgroup/cpuset: add sefltest for cpuset v1

 MAINTAINERS                                   |   3 +
 include/linux/cpuset.h                        |   4 +
 init/Kconfig                                  |  13 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/cpuset-internal.h               | 305 +++++++
 kernel/cgroup/cpuset-v1.c                     | 563 ++++++++++++
 kernel/cgroup/cpuset.c                        | 850 +-----------------
 .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
 8 files changed, 986 insertions(+), 830 deletions(-)
 create mode 100644 kernel/cgroup/cpuset-internal.h
 create mode 100644 kernel/cgroup/cpuset-v1.c
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh

-- 
2.34.1


