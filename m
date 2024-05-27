Return-Path: <linux-kernel+bounces-191061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5318D060E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BF029867A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B535217E8F0;
	Mon, 27 May 2024 15:23:37 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFB17E8E0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823417; cv=none; b=Zi/7zBmHdlIv4MaYnEU2HfVyY4tnxb0k+/ocCmt91lRWUMU11YNQiClS3lb5et2m8s3O9jRUkG7azg6tm2yon/CPyUkol4iTSrlEwuDbkTCEDHRjkEYkeL5rZojh6Rzk0HrH/DY5S3P8VKw9pUGIgDy9XkB30zgf+Bq98JgFY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823417; c=relaxed/simple;
	bh=ILc3BOxXaH/kwIL8Qcn6N/GOkvETb//XLO9U+cWG9bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bHUJCEbED4LiommAqKcXrmqddtE556Ag+oMn/CV9FFF64pb3FTLhCvj0F1w23n8TpRmT7qJTA95VZTjZVJxVlBlRGDPv2DchAKPrNPOB4GmYIz18eNIyIECI31BRGL7a1SOVuLRFETNas2dLVDhMF4ZnCXjwacJ/RLbN3qGn+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VnzVr3JXCz9v7Hk
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:06:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 1C939140415
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:23:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHshpgpVRmXLgGCQ--.41702S2;
	Mon, 27 May 2024 16:23:24 +0100 (CET)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [RFC][PATCH 0/4] tools/memory-model: Define more of LKMM in tools/memory-model
Date: Mon, 27 May 2024 17:22:49 +0200
Message-Id: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshpgpVRmXLgGCQ--.41702S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw45urW3Xr4xWrW3tF4xJFb_yoW5Xr1fpr
	Z5G34rKF1DKr9F9a1xW39rXFySkayrGw47GFn3twn5u3W5Wry0yr1Ika1FvryxuFWxXayU
	Zry5trykW3WDArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDwIDUUUUU=
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

This second step is incompatible with the current herd7 implementation,
since herd7 uses hardcoded tag names to decide what to do with LKMM;
therefore, the newly introduced syntactic tags will be ignored or
processed incorrectly by herd7.

Have fun,
  jonas

Jonas Oberhauser (4):
  tools/memory-model: Legitimize current use of tags in LKMM macros
  tools/memory-model: Define applicable tags on operation in tools/...
  tools/memory-model: Define effect of Mb tags on RMWs in tools/...
  tools/memory-model: Distinguish between syntactic and semantic tags

 tools/memory-model/linux-kernel.bell |  28 +++--
 tools/memory-model/linux-kernel.cat  |   9 ++
 tools/memory-model/linux-kernel.def  | 176 +++++++++++++--------------
 3 files changed, 115 insertions(+), 98 deletions(-)

-- 
2.34.1


