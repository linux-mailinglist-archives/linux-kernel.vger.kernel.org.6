Return-Path: <linux-kernel+bounces-413474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41FE9D1980
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836841F22936
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94401E6DFF;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C41E5732
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960867; cv=none; b=MQab1JeGRTEfWeZTr9LWn27MHQ/foHmV65a91rhvwWDXy21QptWFs5vsbhdbiNJ5RNfMpXoPBwnhnW+eDFmxbPaflUdFttKKWinZg1n1epDy7aHZ3/pNzm+rSH6Vpw1lUA89pldViib2wptt6U9QX59dow30/i7uS+v1Y4txiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960867; c=relaxed/simple;
	bh=EFXGenEvq+97XtCagTbKXm70xIu/0FQ5mQXGq+OYBUs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=auV7VRcw94HIDs509Ghl3yX0NdvwwEhz6MP8t1wWRv1miJUi/HPWkT3eB3kMaX/akJQx4orf8iT85dTtUtG+6/8l3zfA8qD5gFcpTAXe4IkelzUyc9bCg+2SU6oHcz+3mDpezjkDooIDb0Tn9Nz6JuvTBikHOijL9SBVt/yhA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47874C4CED8;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD89D-0000000D8y9-1rag;
	Mon, 18 Nov 2024 15:14:59 -0500
Message-ID: <20241118201459.296411856@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 15:14:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
 Furkan Onder <furkanonder@protonmail.com>
Subject: [for-next][PATCH 3/4] tools/rtla: Enhance argument parsing in timerlat_load.py
References: <20241118201431.871648641@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: furkanonder <furkanonder@protonmail.com>

The enhancements made to timerlat_load.py are aimed at improving the clarity of argument parsing.

Summary of Changes:
- The cpu argument is now specified as an integer type in the argument
  parser to enforce input validation, and the construction of affinity_mask
  has been simplified to directly use the integer value of args.cpu.
- The prio argument is similarly updated to be of integer type for
  consistency and validation, eliminating the need for the conversion of
  args.prio to an integer, as this is now handled by the argument parser.

Cc: "jkacur@redhat.com" <jkacur@redhat.com>
Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/QfgO7ayKD9dsLk8_ZDebkAV0OF7wla7UmasbP9CBmui_sChOeizy512t3RqCHTjvQoUBUDP8dwEOVCdHQ5KvVNEiP69CynMY94SFDERWl94=@protonmail.com
Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/sample/timerlat_load.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
index 785e9a83539a..d7341ed5127a 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -25,13 +25,12 @@ import sys
 import os
 
 parser = argparse.ArgumentParser(description='user-space timerlat thread in Python')
-parser.add_argument("cpu", help='CPU to run timerlat thread')
-parser.add_argument("-p", "--prio", help='FIFO priority')
-
+parser.add_argument("cpu", type=int, help='CPU to run timerlat thread')
+parser.add_argument("-p", "--prio", type=int, help='FIFO priority')
 args = parser.parse_args()
 
 try:
-    affinity_mask = { int(args.cpu) }
+    affinity_mask = {args.cpu}
 except:
     print("Invalid cpu: " + args.cpu)
     exit(1)
@@ -44,7 +43,7 @@ except:
 
 if args.prio:
     try:
-        param = os.sched_param(int(args.prio))
+        param = os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
     except:
         print("Error setting priority")
-- 
2.45.2



