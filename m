Return-Path: <linux-kernel+bounces-361573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085D99A9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D825C1F24036
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2A1BE86E;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C661B86F7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667817; cv=none; b=VsdE7P9790zCN4DzB2raiob0zzhGvREqG0wojdWWbR7JoRKdqu6o/EB1Lgb/Wj9+bFPKmNEAOA1K2TpIVxp8PfsGqMHtCutyvoORtwKh/46UIH4KHmg7pCGOTgTtZKcm5oHlsM9WDu3MB8EHwQVcqV55Fv17JL9a/LyH4Y5cM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667817; c=relaxed/simple;
	bh=4imnt4Y1RNNvYUBfcqZKWK5cNTtWSmt7hPOSiP+t3G8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q1uXjV6unrhBI1L0rSlpvI83yDij14qRVBuegvVZGRyNXxw6LCDGAd17r9IzfXAPHZPI9Y/u5doCIHqcyiJxfcVEGQ+IzGx5wZ+cA/R5wN167j13Z4ahFojcJ101BRxXHMxKApA0ZtqQq4Ojgm/EoS906U1cBaaRUV7Cz+1wvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B3CC4CEC7;
	Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001TyN-0DXn;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173027.913282122@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Eder Zulian <ezulian@redhat.com>
Subject: [for-next][PATCH 1/9] rtla: use the definition for stdout fd when calling isatty()
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Eder Zulian <ezulian@redhat.com>

Use the STDOUT_FILENO definition when testing whether the standard
output file descriptor refers to a terminal (for better redability).

Link: https://lore.kernel.org/20240813142338.376039-1-ezulian@redhat.com
Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_top.c  | 2 +-
 tools/tracing/rtla/src/timerlat_top.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2f756628613d..66e3a4382bc2 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -627,7 +627,7 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	if (isatty(1) && !params->quiet)
+	if (isatty(STDOUT_FILENO) && !params->quiet)
 		params->pretty_output = 1;
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..94a2f5bbaeb7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -850,7 +850,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
-	if (isatty(1) && !params->quiet)
+	if (isatty(STDOUT_FILENO) && !params->quiet)
 		params->pretty_output = 1;
 
 	return 0;
-- 
2.45.2



