Return-Path: <linux-kernel+bounces-201005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165C8FB7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C0E1F216CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9A145FF7;
	Tue,  4 Jun 2024 15:49:51 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9D143C7A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516190; cv=none; b=gbttHW57SYt/3UGDAhp6Z3spiEBEQ4O72Z1ER3IVhUS4Y86eokmUe1BwjvpKLtiiSsN2zfaYg7rzLwp9Gg0OQ5jfaj0Ifq4ZL7MhhbYhVIG8Fy5fkDRuCsckcpcQdHX6a0FmmR3sJKj1qXdQyxlBRcp7IViV+MLOB059mKi/I/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516190; c=relaxed/simple;
	bh=s3Y+StiWH1SUXcnL87GNEQTzrLSMMZXbkk3q9EZHmQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5Djn3KUAS2SqOVLB8UxLMGfU9ANSlSwd717ByO8TWiPdcYrGWn4B2COl4uSBhQWQXhNzJdSaMk9fkrUlNWAKJzc4IX0V7aYDukCQhxzf1hZboyAzwuJTLlVDD2D0jMZ8neyfNDSWDBs0gBQzT7mGT/WpTVBZiqSkjECTys0om4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtvGF4WWhz9v7J0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:12:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AEEB1140154
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:29:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwDXwibhMl9m4o6GCQ--.5202S2;
	Tue, 04 Jun 2024 16:29:50 +0100 (CET)
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
Subject: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in tools/memory-model
Date: Tue,  4 Jun 2024 17:29:18 +0200
Message-Id: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXwibhMl9m4o6GCQ--.5202S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw45urW3Xr4xWrW3tF4xJFb_yoW5WrWkpr
	Z5G34rKF1DKr9F9a1xWws7XFySyayrGw47KFn7twn5u3W5ury0yr1Ikw4Fvr97u397XayU
	ZryUtr1kWw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0
	eHDUUUU
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


Changes since v1:
   - addressed several spelling/style issues pointed out by Alan
   - simplified the definition of Marked accesses based on a
      suggestion by Alan

Jonas Oberhauser (4):
  tools/memory-model: Legitimize current use of tags in LKMM macros
  tools/memory-model: Define applicable tags on operation in tools/...
  tools/memory-model: Define effect of Mb tags on RMWs in tools/...
  tools/memory-model: Distinguish between syntactic and semantic tags

 tools/memory-model/linux-kernel.bell |  26 ++--
 tools/memory-model/linux-kernel.cat  |  10 ++
 tools/memory-model/linux-kernel.def  | 176 +++++++++++++--------------
 3 files changed, 115 insertions(+), 97 deletions(-)

-- 
2.34.1


