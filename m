Return-Path: <linux-kernel+bounces-201853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4E8FC443
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C1CB28908
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A156418F2FC;
	Wed,  5 Jun 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NKUe4OPq"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C118C343
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571718; cv=none; b=QeOJEoiEbDK7lMZW2yweJdlOkgrv9/b8jInf9Iccs76TWV36nifNhboRGKfVfoUbyMei5aQOjjiUeVXw/xXO+JNjCgAq6fLaTt5xad2CTEPuvTuN3NaL+TpAXLlqHccJ9mhRFb0j/wo9ay8kL5AW5hu466MzQXVHwxdH0hN+etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571718; c=relaxed/simple;
	bh=NUq4hUMFyN/6UPuWAGO3h695blPsgWsaqsOr34MSY/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l9gt7J5FRFTlM75r6qZazZNxTPz0ensdRrZ69JTGZ/cgff3yvOw9JqfkXOEzQ5dE1ChAKY3YqIPmBiSDHBmtw3n4UNatM5kR5B/BjFC5nILfp6Yahg6eV4oWcaUFtmYA1tuEhH+1jfUT/O4dX0D23dRBWLZHjpc8vxOZRBrfR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NKUe4OPq; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717571710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MgQ54wqpPyu/de/IC92RsymjWefuXxvvmWin5jNjSXQ=;
	b=NKUe4OPqpSUR+OR0Mazu4CTFXw74QR/uNWe4nUmch5P9NkbUpRewOT9h9o33Kzh/vMMUcy
	grwy/JjedJmanJJ0m11fEWNiw1JJjOlIyRuA2rqQQ1wI3ojtkWashhBWUdjVg2FG2YRAVt
	kH7g5Bkga45BiE7fUFm/+FSm6ubcSpM=
X-Envelope-To: penberg@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: cl@linux.com
X-Envelope-To: 42.hyeyoo@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v2 0/3] slab: fix and cleanup of slub_debug
Date: Wed, 05 Jun 2024 15:13:53 +0800
Message-Id: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADEQYGYC/3XMQQ6DIBCF4auYWXcaINRCV96jcSEy6CRGG6jEx
 nj3Uvdd/i953w6JIlOCR7VDpMyJl7mEulTQj908ELIvDUooLW7KoNOYps6hJ7cOKL2Rdxt6a+s
 OyucVKfB2es+29MjpvcTPyWf5W/9JWaJAU1tNQRuhfGgmntft6ilDexzHF2LHNJSqAAAA
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717571705; l=1377;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=NUq4hUMFyN/6UPuWAGO3h695blPsgWsaqsOr34MSY/E=;
 b=+ms+kPaOg2SJvqKFwZFq2Vqt+ZOIoeYlDeMC/ug+gvORklv4nOem+bSIiRiBIk3E8HfRT1/WW
 RHu6lPGP1vxBwtz3hvdDs+7HMG9DQAe/q1avhaeuD7WC4Hx7rDdnC1I
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Change check_object() to do all the checks without skipping, report
  their specific error findings in check_bytes_and_report() but not
  print_trailer(). Once all checks were done, if any found an error,
  print the trailer once from check_object(), suggested by Vlastimil.
- Consolidate the two cases with flags & SLAB_RED_ZONE and make the
  complex conditional expressions a little prettier and add comments
  about extending right redzone, per Vlastimil.
- Add Reviewed-by from Feng Tang.
- Link to v1: https://lore.kernel.org/r/20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev

Hello,

This series includes minor fix and cleanup of slub_debug, please see
the commits for details.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (3):
      slab: make check_object() more consistent
      slab: don't put freepointer outside of object if only orig_size
      slab: delete useless RED_INACTIVE and RED_ACTIVE

 include/linux/poison.h       |  7 ++----
 mm/slub.c                    | 60 +++++++++++++++++++++++---------------------
 tools/include/linux/poison.h |  7 ++----
 3 files changed, 36 insertions(+), 38 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-b4-slab-debug-1d8179fc996a

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


