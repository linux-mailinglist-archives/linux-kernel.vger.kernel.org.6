Return-Path: <linux-kernel+bounces-392732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF19B9796
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC4B21699
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7101CF281;
	Fri,  1 Nov 2024 18:32:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B2146592
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485977; cv=none; b=YKtF3/2eofzLFtSPyElcM+k7zqgIdBe3p42MNy/Ni9XagngH0auWK+2qs/JZZwOezn4XZbJimzE1I/kvkhYUAlfy1aIXe0mx/VKIPc8sKmuOVSLHwvbh9Pzjn5s1AWxErSq2A630gyaiyjzQsMb0MAZlIXtSiel/vZXbZMoWbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485977; c=relaxed/simple;
	bh=JBoTxHTmIi/CjVr6fQEh4WJHfT5qMw0f1r9bmXMLxHA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JBekGbCyU3eY/JZWOsFUqPZrvyNSoayWBz79rEiL9CrwIzAj5dMA8/4012Px//uR2KPQfAT4EoH6nDHfTzo1Vk2xxfLeYyYtFF9v2QSaelJuFTg9Vr4b3/ZuO0YSRSDWduzoyOTNC98UdJtRFvzK95pvsb5+tu5YLtgfsM5bKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE15C4CED3;
	Fri,  1 Nov 2024 18:32:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6wT5-00000005X4V-3BJF;
	Fri, 01 Nov 2024 14:33:55 -0400
Message-ID: <20241101183355.620763892@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 14:33:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Sandeen <sandeen@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Kalesh Singh <kaleshsingh@google.com>
Subject: [for-linus][PATCH 2/3] tracing: Document tracefs gid mount option
References: <20241101183327.693623203@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kalesh Singh <kaleshsingh@google.com>

Commit ee7f3666995d ("tracefs: Have new files inherit the ownership of
their parent") and commit 48b27b6b5191 ("tracefs: Set all files to the
same group ownership as the mount option") introduced a new gid mount
option that allows specifying a group to apply to all entries in tracefs.

Document this in the tracing readme.

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ali Zahraee <ahzahraee@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/20241030171928.4168869-3-kaleshsingh@google.com
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..2b64b3ec67d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {
 
 static const char readme_msg[] =
 	"tracing mini-HOWTO:\n\n"
+	"By default tracefs removes all OTH file permission bits.\n"
+	"When mounting tracefs an optional group id can be specified\n"
+	"which adds the group to every directory and file in tracefs:\n\n"
+	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
 	"# echo 0 > tracing_on : quick way to disable tracing\n"
 	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
 	" Important files:\n"
-- 
2.45.2



