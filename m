Return-Path: <linux-kernel+bounces-577183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5EA7199B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134B0174A07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4671F3FF8;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1021F3BAC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000917; cv=none; b=Sva1r6UOhr6A3WVlkB2zE2z0a+QHoRlgOuZJScyMoxmwmt0VjULS8WDeyUG+wHMDSfa6TFTckH0KcYF1al4K4L/pfT0NaPfyLpTnjEi/qlIfDXwZy+NsPc+MsR/Onwdm+MSjIvkYP+PKCZNJaFf+DCE3V9Uuc0LfG5/86aAQYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000917; c=relaxed/simple;
	bh=XCe1plkqFiS5Uoutw1qfxrhgFmIAmpmwLkSClR/e7vw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ie9stJcsW/RV7KgqCs+nihipP/dGhVbfd0d1HVo8ildQZghQhMRajBj32gUWECdDQVR5+FSEcjZKlWWetq3ksCDh+Dl4uWEHpfu+mJisqweBqVI677h+8p9q2wl4YjdLwAWkyJMbJGTP+O0PEIzKTGK9s+xA/8TJpmXiBPIjweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E8CC4CEE2;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAm-00000002kEZ-2eJj;
	Wed, 26 Mar 2025 10:56:04 -0400
Message-ID: <20250326145604.482508283@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 5/9] rtla/osnoise: Set OSNOISE_WORKLOAD to true
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

If running rtla osnoise with NO_OSNOISE_WORKLOAD, it reports no samples:

$ echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
$ rtla osnoise hist -d 10s
Index
over: 0
count: 0
min: 0
avg: 0
max: 0

This situation can also happen when running rtla-osnoise after an
improperly exited rtla-timerlat run.

Set OSNOISE_WORKLOAD in rtla-osnoise, too, similarly to what we
already did for timerlat in commit 217f0b1e990e ("rtla/timerlat_top: Set
OSNOISE_WORKLOAD for kernel threads") and commit d8d866171a41
("rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads").

Note that there is no user workload mode for rtla-osnoise yet, so
OSNOISE_WORKLOAD is always set to true.

Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250320092500.101385-4-tglozar@redhat.com
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 1735a36466c4..a71618d876e9 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1187,6 +1187,12 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	retval = osnoise_set_workload(tool->context, true);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
-- 
2.47.2



