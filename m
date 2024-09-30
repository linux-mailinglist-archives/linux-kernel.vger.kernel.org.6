Return-Path: <linux-kernel+bounces-343824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF8989FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974DC1C2282D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04718D63A;
	Mon, 30 Sep 2024 10:57:36 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2918D62F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693856; cv=none; b=XWkHl09p08WP4L8ZRaub4vJelVFd57QH/yDlz5KLKcQwpwkYX6vVPxi566muEUfR1KvRXirye4dyzqfyS/FNEruVgatsul8AZr3AgSdSk/Lhy1QXM6uxjj7Ub7gmUUCJ5KxZdLyHgGpxrILmmJbBMhH3QcYzOVoW/ucy3WKGP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693856; c=relaxed/simple;
	bh=HI6S2/shHtwmNGEY6RhLLnKUCTKJY4JtOE5CPXZpqpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWCk6Lyhxyoi9on0skzK6CtoswKmMHxiGDSjRfw+TU9RfjRuVSC2N7mTVPkyXKErnPmhUP1i4WOSHNFPqx/mtK6o42vfhAOEwwDxWC/Q64k1NM651Ly6jM17Vmg+hHs9LeTbaOTFzUvcv4yN2WAF54uVYwVTp8Oc+fg+Aim4lEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHHZp1dHtz9v7J0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:37:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A7DBC140381
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:57:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHmC8OhPpmdITtAQ--.60189S2;
	Mon, 30 Sep 2024 11:57:30 +0100 (CET)
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To: paulmck@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	quic_neeraju@quicinc.com,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v4 0/5] tools/memory-model: Define more of LKMM in tools/memory-model
Date: Mon, 30 Sep 2024 12:57:05 +0200
Message-Id: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHmC8OhPpmdITtAQ--.60189S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw45urW3Xr4xWrW3tF4xJFb_yoWrXryDpr
	Z5G395Kw4qqr9Ivw48Wan7ZFyfCa1fGw47KFn7Kwn8u3W5WFy0yryxKa1Yvr9rurW8XayU
	ZF4jqr1kuw1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Currently, the effect of several tag on operations is defined only in
the herd7 tool's OCaml code as syntax transformations, while the effect
of all other tags is defined in tools/memory-model.
This asymmetry means that two seemingly analogous definitions in 
tools/memory-model behave quite differently because the generated
representation is sometimes modified by hardcoded behavior in herd7.

It also makes it hard to see that the behavior of the formalization 
matches the intuition described in explanation.txt without delving into
the implementation of herd7.

Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
other tools implementing WMM, and has caused several bugs and confusions
with the tool maintainers, e.g.:

  https://github.com/MPI-SWS/genmc/issues/22
  https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
  https://github.com/hernanponcedeleon/Dat3M/issues/254

It also means that potential future extensions of LKMM with new tags may
not work without changing internals of the herd7 tool.

In this patch series, we first emulate the effect of herd7 transformations
in tools/memory-model through explicit rules in .cat and .bell files that
reference the transformed tags.
These transformations do not have any immediate effect with the current
herd7 implementation, because they apply after the syntax transformations
have already modified those tags.

In a second step, we then distinguish between syntactic tags (that are
placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
read and write of an xchg_acquire() operation) and sets of events (that
would be defined after the (emulated) transformations, e.g., an Acquire
set that includes only on the read of the xchg_acquire(), but "has been
removed" from the write).

This second step (comprising patches 4 and 5) is incompatible with the
current herd7 implementation, since herd7 uses hardcoded tag names to decide
what to do with LKMM; therefore, the newly introduced syntactic tags will be
ignored or processed incorrectly by herd7.


Have fun,
  jonas


Changes from v1 to v2:
   - addressed several spelling/style issues pointed out by Alan
   - simplified the definition of Marked accesses based on a
      suggestion by Alan

Changes from v2 to v3:
  - addressed imprecise comment pointed out by Boqun
  - addressed the backwards compatibility issue pointed out by Akira
    with help of Hernan: improved version compatibility by adding
    an error message on older versions of herd and relying on a new
    flag -lkmmv1 to select the version
  - integrated recent patches, like the herd representation table
    and primitives like atomic_add_unless or atomic_and_not

Changes from v3 to v4:
  - removed a litmus test (submitted to Paul's larger test repo instead)
  - fixed several formatting/naming issues pointed out by Akira
  - updated the reference herd version number in memory-model/README.md.
    *Note*: this may need to be retouched after herd is updated.
    I also did not update the table under klitmus7 compatibility, which
    I took to refer only to klitmus7, although its header is "herdtools7"



Jonas Oberhauser (5):
  tools/memory-model: Legitimize current use of tags in LKMM macros
  tools/memory-model: Define applicable tags on operation in tools/...
  tools/memory-model: Define effect of Mb tags on RMWs in tools/...
  tools/memory-model: Switch to softcoded herd7 tags
  tools/memory-model: Distinguish between syntactic and semantic tags

 .../Documentation/herd-representation.txt     |  27 +--
 tools/memory-model/README                     |   2 +-
 tools/memory-model/linux-kernel.bell          |  33 ++-
 tools/memory-model/linux-kernel.cat           |  10 +
 tools/memory-model/linux-kernel.cfg           |   1 +
 tools/memory-model/linux-kernel.def           | 196 +++++++++---------
 6 files changed, 150 insertions(+), 119 deletions(-)

-- 
2.34.1


