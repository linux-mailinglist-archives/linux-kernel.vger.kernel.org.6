Return-Path: <linux-kernel+bounces-413476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB929D1982
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5241F22DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5521E7679;
	Mon, 18 Nov 2024 20:14:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A91E6DD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960867; cv=none; b=aY6boxqiJx+IxSL5uL2gVqvHZ4cIfs9hp8Re75EcEdhE1cb9sherSbzOjfMEmWWi6dEJfRDqcNIUIxS0156UqnmOSgAsapL3LQk4dE5XocxU/fNE3RFjZY36R33iAl6+2xKwjfgyG9/wKJR3ObA02g2LzZ6RbZqwowKZeUzadpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960867; c=relaxed/simple;
	bh=1bsicQsClz2mA5LGmCCz633UWz8AMxCoyQFRdHoj6LQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qMpWwcpcWoWmiB0f306g0aj3BZgGkKZsCG88FmGJG1s1WA6fZg2SdLclvELfD2YYZ9JABucX0ohaMRaV7PEnYJiARXA+O+MUjShqHUjgxg/xPLYGgioJ8ELCN0pvyjM+5S/TT6a90/2Kig8doGtyOWwreIE7Z/9dcgT4BdRjKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71469C4CECC;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD89D-0000000D8ye-2a8H;
	Mon, 18 Nov 2024 15:14:59 -0500
Message-ID: <20241118201459.464858475@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 15:14:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
 Furkan Onder <furkanonder@protonmail.com>
Subject: [for-next][PATCH 4/4] tools/rtla: Improve exception handling in timerlat_load.py
References: <20241118201431.871648641@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: furkanonder <furkanonder@protonmail.com>

The enhancements made to timerlat_load.py are intended to improve the script's exception handling.

Summary of the changes:
  - Specific exceptions are now caught for CPU affinity and priority
    settings, with clearer error messages provided.
  - The timerlat file descriptor opening now includes handling for
    PermissionError and OSError, with informative messages.
  - In the infinite loop, generic exceptions have been replaced with
    specific types like KeyboardInterrupt and IOError, improving feedback.

 Before:
    $ sudo python timerlat_load.py 122
    Error setting affinity
 After:
    $ sudo python timerlat_load.py 122
    Error setting affinity: [Errno 22] Invalid argument

 Before:
    $ sudo python timerlat_load.py 1 -p 950
    Error setting priority
 After:
    $ sudo python timerlat_load.py 1 -p 950
    Error setting priority: [Errno 22] Invalid argument

 Before:
    $ python timerlat_load.py 1
    Error opening timerlat fd, did you run timerlat -U?
 After:
    $ python timerlat_load.py 1
    Permission denied. Please check your access rights.

Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Cc: "jkacur@redhat.com" <jkacur@redhat.com>
Link: https://lore.kernel.org/Q_k1s4hBtUy2px8ou0QKenjEK2_T_LoV8IxAE79aBakBogb-7uHp2fpET3oWtI1t3dy8uKjWeRzQOdKNzIzOOpyM4OjutJOriZ9TrGY6b-g=@protonmail.com
Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/sample/timerlat_load.py | 37 ++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
index d7341ed5127a..a819c3588073 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -31,43 +31,48 @@ args = parser.parse_args()
 
 try:
     affinity_mask = {args.cpu}
-except:
-    print("Invalid cpu: " + args.cpu)
-    exit(1)
-
-try:
     os.sched_setaffinity(0, affinity_mask)
-except:
-    print("Error setting affinity")
-    exit(1)
+except Exception as e:
+    print(f"Error setting affinity: {e}")
+    sys.exit(1)
 
 if args.prio:
     try:
         param = os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
-    except:
-        print("Error setting priority")
-        exit(1)
+    except Exception as e:
+        print(f"Error setting priority: {e}")
+        sys.exit(1)
 
 try:
     timerlat_path = f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/timerlat_fd"
     timerlat_fd = open(timerlat_path, 'r')
-except:
+except PermissionError:
+    print("Permission denied. Please check your access rights.")
+    sys.exit(1)
+except OSError:
     print("Error opening timerlat fd, did you run timerlat -U?")
-    exit(1)
+    sys.exit(1)
 
 try:
     data_fd = open("/dev/full", 'r')
-except:
-    print("Error opening data fd")
+except Exception as e:
+    print(f"Error opening data fd: {e}")
+    sys.exit(1)
 
 while True:
     try:
         timerlat_fd.read(1)
         data_fd.read(20 * 1024 * 1024)
-    except:
+    except KeyboardInterrupt:
         print("Leaving")
         break
+    except IOError as e:
+        print(f"I/O error occurred: {e}")
+        break
+    except Exception as e:
+        print(f"Unexpected error: {e}")
+        break
 
 timerlat_fd.close()
 data_fd.close()
-- 
2.45.2



