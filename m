Return-Path: <linux-kernel+bounces-392072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28639B8F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D516C1C223F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3719CC2D;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F819B5B8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=H2M53z0r5RTgprr+DztWNpLn54RklE4/e+ZVSxf4czU/i3+0ToEN6wkYcz8imlDpQqBw1AQSnTA5zLxNsIcxs86RxEsWypXTuX0JaE4sHGFX6mqurXcft6ogwEKpIwOAWbIE5v9PPL75+l8CaYi17CT1bMSagYtEfwBNq7q9y8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=95zVCe3LTNyFUw2de0ZA5FJbzmALpCG7UjAKLiG8h3w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oyOvc6qTZx+8zlsnEUYQmUHXRsPMzYVJTqmRFYPhN0CypL835i65nsXKDquwe8UQBbi63n4pIgsXAJc08IVduoDLzbp95AmdelY3B2IBTEfNN+ADmwFqFs6vcIfnPC4nnNDvONb8Sy+wVIUq8N2c3S7J7Fii/Xr+f/lJp3LkPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DC6C4AF0F;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1f-00000005S65-2SOk;
	Fri, 01 Nov 2024 06:37:07 -0400
Message-ID: <20241101103707.445466201@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>
Subject: [for-next][PATCH 04/11] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yuran Pereira <yuran.pereira@hotmail.com>

The function simple_strtoul performs no error checking in scenarios
where the input value overflows the intended output variable.
This results in this function successfully returning, even when the
output does not match the input string (aka the function returns
successfully even when the result is wrong).

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strtoul with the safer
alternatives kstrtoint and kstrtol.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Link: https://lore.kernel.org/20241028192100.GB918454@lichtman.org
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[nir: style fixes]
Signed-off-by: Nir Lichtman <nir@lichtman.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_kdb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 59857a1ee44c..1e72d20b3c2f 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -96,22 +96,19 @@ static int kdb_ftdump(int argc, const char **argv)
 {
 	int skip_entries = 0;
 	long cpu_file;
-	char *cp;
+	int err;
 	int cnt;
 	int cpu;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
 
-	if (argc) {
-		skip_entries = simple_strtol(argv[1], &cp, 0);
-		if (*cp)
-			skip_entries = 0;
-	}
+	if (argc && kstrtoint(argv[1], 0, &skip_entries))
+		return KDB_BADINT;
 
 	if (argc == 2) {
-		cpu_file = simple_strtol(argv[2], &cp, 0);
-		if (*cp || cpu_file >= NR_CPUS || cpu_file < 0 ||
+		err = kstrtol(argv[2], 0, &cpu_file);
+		if (err || cpu_file >= NR_CPUS || cpu_file < 0 ||
 		    !cpu_online(cpu_file))
 			return KDB_BADINT;
 	} else {
-- 
2.45.2



