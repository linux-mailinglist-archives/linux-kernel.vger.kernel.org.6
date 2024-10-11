Return-Path: <linux-kernel+bounces-361577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A323999AA03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8DB1C23BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4EA1CF28B;
	Fri, 11 Oct 2024 17:30:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A071BF7FE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=UaS5G/+HD5UIJ13M4tnaifXbxNrOkFUsfMYEyHxnPxU3ZMXzr1foXXENcH6rYKwh+ly/4ih2dxS2GwCt9izR08JTjHLV9kKecbR5nFOQ5eGp9qDXfKeFu9N0752hqAvpELp2Be37iAizQ4YyQl+4bzxGuN5LQwp6YUcW/xYVjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=BNLvL2bN+2RdzPqjhwYAmB84r332uy5578mZl6pDUJo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SRPjgfIvNtwzHAMEIx4A+/Ttd3OQ6UmKFH6fKRvuCiL2dihL/pp19WsCtnHwY9m5HVLLX17/uznTd6pFmnac6/xzRvzSb6VcVoFBbHRoba9S/85h7dQuXz1s0kN1EaNWwRZaefj/ccLT0InNIa6MwX7QqvmcPHoLTkj/usFrSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFBAC4CED0;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001U0J-2skX;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173028.545123657@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 5/9] rtla: Fix consistency in getopt_long for timerlat_hist
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Commit e9a4062e1527 ("rtla: Add --trace-buffer-size option") adds a new
long option to rtla utilities, but among all affected files,
timerlat_hist misses a trailing `:` in the corresponding short option
inside the getopt string (e.g. `\3:`). This patch propagates the `:`.

Although this change is not functionally required, it improves
consistency and slightly reduces the likelihood a future change would
introduce a problem.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Link: https://lore.kernel.org/20240926143417.54039-1-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..1f9137c592f4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -778,7 +778,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
-- 
2.45.2



