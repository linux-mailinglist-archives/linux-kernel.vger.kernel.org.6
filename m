Return-Path: <linux-kernel+bounces-333504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108197C9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565391C22644
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C219E830;
	Thu, 19 Sep 2024 13:07:22 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC041746
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751241; cv=none; b=f0D3sY71PyVi3EqAT6K1ppS3/5Dx2jU3tyefzxkrR+OhxS+/CQCuF2TvF8dhDniCAx1xti8bdME90fRGebELWELykpGxAUPGfazaFSrriyd0UCJ3pNV56O/LvqZxAQMX5tK4zFUXm2wSPnfrN6ua648KxVOZG7BVqebUdWBSwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751241; c=relaxed/simple;
	bh=xAYyOUZu5VrLtMeZwfppVF2iMz51plyd7LnCAKebZ4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=buDHBs5Q8Bj6zkmfmgwO8yeWRIZnIiKrFUrc3je7q6rQV8+lhvsUQfNuA94OVu/sESnw486gzjh0Iz45qt35seZJywOoQXWDdwYYBVBtHqh7Yh+YB4EFRNPTVYqhAAuWJjYsPsLzyg1ki1lQfoZ3s7xk8BMuh8U+1+iNoI399iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X8Zzm3JjMz9v7NM
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:47:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3E9EC14037F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:07:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsfqIexmRoM8AQ--.55331S2;
	Thu, 19 Sep 2024 14:07:03 +0100 (CET)
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
Subject: [PATCH v3 0/5] tools/memory-model: Define more of LKMM in tools/memory-model
Date: Thu, 19 Sep 2024 15:06:29 +0200
Message-Id: <20240919130634.298181-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnFsfqIexmRoM8AQ--.55331S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw45urW3Xr4xWrW3tF4xJFb_yoW5KF4rpr
	Z5G395Ka1Dtr9F9a18Wan7ZFySya1rGw47KFn7twn5uF15Wry0yr1Ika1Fvr9ruFW8XayU
	Zr1jqr1kZw1DArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
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


Jonas Oberhauser (5):
  tools/memory-model: Legitimize current use of tags in LKMM macros
  tools/memory-model: Define applicable tags on operation in tools/...
  tools/memory-model: Define effect of Mb tags on RMWs in tools/...
  tools/memory-model: Switch to softcoded herd7 tags
  tools/memory-model: Distinguish between syntactic and semantic tags

 .../Documentation/herd-representation.txt     |  27 +--
 tools/memory-model/linux-kernel.bell          |  33 ++-
 tools/memory-model/linux-kernel.cat           |  10 +
 tools/memory-model/linux-kernel.cfg           |   1 +
 tools/memory-model/linux-kernel.def           | 196 +++++++++---------
 .../litmus-tests/add-unless-mb.litmus         |  27 +++
 6 files changed, 176 insertions(+), 118 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/add-unless-mb.litmus

-- 
2.34.1


