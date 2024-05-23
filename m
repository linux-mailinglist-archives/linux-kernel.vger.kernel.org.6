Return-Path: <linux-kernel+bounces-187664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE878CD61F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413041F24799
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26483847B;
	Thu, 23 May 2024 14:50:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0A7470
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475800; cv=none; b=ZbblSvMCMJaFPsgRiYQYgkCIYEg6+tHLbas0axWoFPETFdIWYsVnixxuJHLnKYBfUe36uKaLesWtNXMnVW1vv1u7HdL0+zX/AN7BYBdoUukRe79XvJhZ14GosghwlH9O4SnqlNVgxPexDGVZt/eedXFYiCC0NMElA1Z+24UTbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475800; c=relaxed/simple;
	bh=ru3w+J+6Vnwg7ev/IkU4r/Z7zPmWepvVccSojIJNWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tS7dVhOpeNjFEgz9Lxs8J97MY0Jrek8ZD+3Cr6spS7cYRFoi+qDFEYgQJGEqKEPKhc5DU6JB1OuNvxG8UqmTGx4WCpW7XzS5OQeaAsNc+WHtLe5Emb/CcclLq2lkgt/tYWokI87AJD2p4P5OeH2unHVnpcKUWuVw00eU5n7n0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AE5C2BD10;
	Thu, 23 May 2024 14:49:59 +0000 (UTC)
Date: Thu, 23 May 2024 10:50:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-linus][PATCH] tools/latency-collector: Fix -Wformat-security
 compile warns
Message-ID: <20240523105043.2dc94825@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


- Use the printf format string with %s to take a string instead of taking
  in a string directly.

Shuah Khan (1):
      tools/latency-collector: Fix -Wformat-security compile warns

----
 tools/tracing/latency/latency-collector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---------------------------
commit df73757cf8f66fa54c4721c53b0916af3c4d9818
Author: Shuah Khan <skhan@linuxfoundation.org>
Date:   Wed Apr 3 19:10:09 2024 -0600

    tools/latency-collector: Fix -Wformat-security compile warns
   =20
    Fix the following -Wformat-security compile warnings adding missing
    format arguments:
   =20
    latency-collector.c: In function =E2=80=98show_available=E2=80=99:
    latency-collector.c:938:17: warning: format not a string literal and
    no format arguments [-Wformat-security]
      938 |                 warnx(no_tracer_msg);
          |                 ^~~~~
   =20
    latency-collector.c:943:17: warning: format not a string literal and
    no format arguments [-Wformat-security]
      943 |                 warnx(no_latency_tr_msg);
          |                 ^~~~~
   =20
    latency-collector.c: In function =E2=80=98find_default_tracer=E2=80=99:
    latency-collector.c:986:25: warning: format not a string literal and
    no format arguments [-Wformat-security]
      986 |                         errx(EXIT_FAILURE, no_tracer_msg);
          |
                             ^~~~
    latency-collector.c: In function =E2=80=98scan_arguments=E2=80=99:
    latency-collector.c:1881:33: warning: format not a string literal and
    no format arguments [-Wformat-security]
     1881 |                                 errx(EXIT_FAILURE, no_tracer_ms=
g);
          |                                 ^~~~
   =20
    Link: https://lore.kernel.org/linux-trace-kernel/20240404011009.32945-1=
-skhan@linuxfoundation.org
   =20
    Cc: stable@vger.kernel.org
    Fixes: e23db805da2df ("tracing/tools: Add the latency-collector to tool=
s directory")
    Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/late=
ncy/latency-collector.c
index 0fd9c747d396..cf263fe9deaf 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -935,12 +935,12 @@ static void show_available(void)
 	}
=20
 	if (!tracers) {
-		warnx(no_tracer_msg);
+		warnx("%s", no_tracer_msg);
 		return;
 	}
=20
 	if (!found) {
-		warnx(no_latency_tr_msg);
+		warnx("%s", no_latency_tr_msg);
 		tracefs_list_free(tracers);
 		return;
 	}
@@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
 	for (i =3D 0; relevant_tracers[i]; i++) {
 		valid =3D tracer_valid(relevant_tracers[i], &notracer);
 		if (notracer)
-			errx(EXIT_FAILURE, no_tracer_msg);
+			errx(EXIT_FAILURE, "%s", no_tracer_msg);
 		if (valid)
 			return relevant_tracers[i];
 	}
@@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
 			}
 			valid =3D tracer_valid(current_tracer, &notracer);
 			if (notracer)
-				errx(EXIT_FAILURE, no_tracer_msg);
+				errx(EXIT_FAILURE, "%s", no_tracer_msg);
 			if (!valid)
 				errx(EXIT_FAILURE,
 "The tracer %s is not supported by your kernel!\n", current_tracer);

