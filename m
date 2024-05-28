Return-Path: <linux-kernel+bounces-191856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9878D152E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C38B22B87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12067172F;
	Tue, 28 May 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kV7aKHzE"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B06D1C7
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880676; cv=none; b=L7dC3mbRl20l7k2M96Hi7KyhZ45ViEe6IUIOSyEanFae92RSPrKRT20dBHdIxxyqrQAKm4su7R48MqNJLENBkrHM5IHfrnFode4zmbHtPy129XlKy7NBZtcfkUH98Q5PixBdSlArDRBSdAtBLfNoEGbAybsJw6X4MVHZMQg7Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880676; c=relaxed/simple;
	bh=OZ5DpPTKOeYmRmewJm8DeqbT9X1fijbiXBtkd5dnmxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UL9pK42NZfFBrqWgZdxPoBhi51Pk2q4z6sQ5/R5BFN6jMRUSsUlPUJOYhxafBUC12dUPI711xgm0SLkFi41yrAoWMIy2JM0zZDM8PfC1S1/Dvb+Dm0wF5OjF/+ZXSsup1m26MRUZdjiBcsa/g2X3Eio9pp4w0r51/df+xeoCe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kV7aKHzE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716880672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7feK4Ti1gdCt4DnauJlBDFzIvKGci92/Z4f0PzVPY5I=;
	b=kV7aKHzEbmjU7Whem4qlMkHwF8i9TCoJhk66FKd5cT+Zjc3MVpLGzubn1bmH/bKfFL65Rr
	yfIenVJI1ywVQX1XTpiUvbrxBnAhqHt3yER7/rmW8eYsgc035kiUEKG2G4rqRHWS5k9954
	PxoxZubBi+FEwZhPJx9Kz1W9JkoT1xU=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: cl@linux.com
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 0/3] slab: fix and cleanup of slub_debug
Date: Tue, 28 May 2024 15:16:45 +0800
Message-Id: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6EVWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyML3SQT3eKcxCTdlNSk0nRdwxQLQ3PLtGRLS7NEJaCegqLUtMwKsHn
 RsbW1AMrJ5rVfAAAA
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716880668; l=747;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=OZ5DpPTKOeYmRmewJm8DeqbT9X1fijbiXBtkd5dnmxg=;
 b=sgAqoojnLdu9BIoOHOIkRSEXe7vCFnejNHnDyaGptG+JXXXF9a0COGbr39szm7dZig/eld72z
 wNgea6KtKoDAVuK8oFa6QxqLforUunyQHVgltYBckY8JTzQJ8o/WLYy
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Hello,

This series includes minor fix and cleanup of slub_debug, please see
the commits for details.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (3):
      slab: check the return value of check_bytes_and_report()
      slab: don't put freepointer outside of object if only orig_size
      slab: delete useless RED_INACTIVE and RED_ACTIVE

 include/linux/poison.h       |  7 ++-----
 mm/slub.c                    | 11 ++++++-----
 tools/include/linux/poison.h |  7 ++-----
 3 files changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-b4-slab-debug-1d8179fc996a

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


