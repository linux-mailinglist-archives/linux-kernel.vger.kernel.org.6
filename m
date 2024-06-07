Return-Path: <linux-kernel+bounces-205615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AA48FFE29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905C4283327
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CEE15B124;
	Fri,  7 Jun 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHn93sf5"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758D15443A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749650; cv=none; b=GpVpXc1Hux1TN+VYz6plfgJMqVhBD9ZwjjANtuR2QzYnAFoyPK+BXm0GDS3HTF7YzvnpUhWG6TWTL5mWeZ+qgujE8i6CEJrBjDqjDXfiStFNSqLaLP9K4a/Z5tP7uUxdg+KoVPMmMhR3f2FkMJ9mTj1QTZNzA5qvaBa6Dr4AYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749650; c=relaxed/simple;
	bh=xWj3wmt4wC1BQQNrhlB+vjoPdlDajm1Atq0xhzF45H8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=omPPhfetJz9ViFeJNG/DGgtlTeH2VhQGJfSUILCZSu6dFcKipSnzV0Il/+O/p3K6tpSeGbFRuMP43Xb2Tb+O85wkiHGxCTwoTK6eyem3yI2FPU84XEgghkom1s94anuEzmtXXoG0bVFJpueKoLqnSdIqYMlFM8XtFupTeECgiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHn93sf5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717749645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vvdtkhjCpRCbJoKZAWyq//G6mKukcuJ4c3ZSKqdPLsM=;
	b=fHn93sf5GqLoAwhaQmi3ZyFiRgs2vOD59ms2wlrCGkXR1EJZ8El4heOvKuU3Bzf0YPHmOX
	KUQkPhUgbd+NyII6q559tw7ncKHk15hNCpCmWxquFPhslAshgsmBVlBUSk0e9IDjQRcD+o
	WxYIwjEOuMd9Q3B/pDjgbw7moaR6lHc=
X-Envelope-To: cl@linux.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: penberg@kernel.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v3 0/3] slab: fix and cleanup of slub_debug
Date: Fri, 07 Jun 2024 16:40:11 +0800
Message-Id: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzHYmYC/3XM0QqDIBiG4VsJj+dQU6c72n2MHaT+lhAVuqQR3
 fusk43BDr8PnndFCWKAhK7ViiLkkMI4lFGfKmS7ZmgBB1c2YoRxIpjChuPUNwY7MHOLqVP0or3
 VWjaomCmCD8vRuz/K7kJ6jvF15DPd33+lTDHBSmoOnivCnL/1YZiXs4OM9lJmHy2J+NWsaCtqY
 bR1taT2W2/b9gbRUTSR6AAAAA==
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717749639; l=1733;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=xWj3wmt4wC1BQQNrhlB+vjoPdlDajm1Atq0xhzF45H8=;
 b=g40ViXDwcKmFj50AEuLOydGhbvCTB3Ri3LoiPVXTy00kTH+EHsdreEApGB1DMpDnpQqUid2+8
 xPvCamkkoShBlvaVYQ1cwGh+K/CVthSAzYA+9xMQs3r10aE1LouCTMS
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Changes in v3:
- Fix slub_kunit tests failures by using new introduced
  slab_in_kunit_test(), which doesn't increase slab_errors.
- Fix the condition of whether to check free pointer and
  set "ret" correctly.
- Collect Reviewed-by tags from Vlastimil Babka.
- Link to v2: https://lore.kernel.org/r/20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev

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

 include/linux/poison.h       |  7 ++--
 mm/slub.c                    | 77 ++++++++++++++++++++++++++++----------------
 tools/include/linux/poison.h |  7 ++--
 3 files changed, 53 insertions(+), 38 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240528-b4-slab-debug-1d8179fc996a

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


