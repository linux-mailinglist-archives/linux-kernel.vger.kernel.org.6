Return-Path: <linux-kernel+bounces-177602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08898C4157
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB475281605
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCE1509A3;
	Mon, 13 May 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHMS6AVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60273502
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605441; cv=none; b=rH3zgtG/BX7MCmN8HE4tQvWl7tUgXYHMj51x8NnvEZNN1FfIdrPrJHV/4PURHm0lEafRhHUIaSar9wblVW+CqsVK/icpvmzyP6gvGS1CzcclliUpXoduoGCzgpTzzUKk7RoelCnH6C3JVLM82hzt9wVUJC7zHUvoKdrDhO54kDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605441; c=relaxed/simple;
	bh=1uAlW7QKbeafzRlOsyIcTo0zraoTBDi8y2NInTKmZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muZsULQcKe2mqFFNRYpD/Rn38TrqjX7t9d8nynOc42Ugf306xVcc6sWBFTStwNdg8nL5gncBO/TvQeqf1csWkqFQcb7WwKFdcoq5GKXfRzQXOZ7kp+6I2ggQ9Tr8CX6xk1wcDL2E26IaxJQ1xtaAwqAgjRRc4J4gGquungnVNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHMS6AVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA27C113CC;
	Mon, 13 May 2024 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715605441;
	bh=1uAlW7QKbeafzRlOsyIcTo0zraoTBDi8y2NInTKmZIk=;
	h=From:To:Cc:Subject:Date:From;
	b=lHMS6AVZmgEVR8GQCJB3YENYj0XXl0hU2nzYPKfFSYHBCknoZBNYgRUm4JX37kcjC
	 bNYLWm3qv5jEicHIwGRN+dwfgp8/mPIaeFETsdLSICXA+0kg5ZM0w5IuRVrIFP90a9
	 jooDkQFBSjT4fCnJXtq1zANso/wRb28Kn0MZ/3u1r/a0TbbvjRxUdXDIz31zsWXeV+
	 b6ihBdjHs8HaSt+pzkIDUzfMr7rgvxhFNLZQbs8slDABoO1nTSkxgm6zoFrnVe595/
	 5a6seDiHmYYNM07daDUz7AR0A7IQdqETK42Gs6r2h6PI6JyT//NiUWUYRH3Nq0Ppur
	 WAoI/NbtLdY1w==
From: Geliang Tang <geliang@kernel.org>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: skip warnings for symbol links
Date: Mon, 13 May 2024 21:03:50 +0800
Message-ID: <7601cf2dd6fc5db38ebccbc0050be6103be6ee5e.1715604900.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If there is a symbol link in the given patch, checkpatch.pl reports two
inaccurate warnings:

$ cat 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch

 ... ...

 '''
 # diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c \
 #            b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
 # new file mode 120000
 # index 000000000000..5a08c255b278
 # --- /dev/null
 # +++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
 # @@ -0,0 +1 @@
 # +../net/mptcp/pm_nl_ctl.c
 # \ No newline at end of file
 '''

$ ./scripts/checkpatch.pl 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch

 '''
 WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
 #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c

 WARNING: adding a line without newline at end of file
 #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c

 total: 0 errors, 2 warnings, 16 lines checked
 '''

This patch fixes this by adding a new variable $symbol_link in checkpatch
script, set it if the new file mode is 120000. Skip these two checks
"missing SPDX-License-Identifier" and "adding a line without newline at
end of file" if this variable is set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..edf2d9dfde45 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2694,6 +2694,8 @@ sub process {
 
 	my $checklicenseline = 1;
 
+	my $symbol_link = 0;
+
 	sanitise_line_reset();
 	my $line;
 	foreach my $rawline (@rawlines) {
@@ -3564,6 +3566,11 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# Check for symbol links
+		if ($line =~ /^new file mode 120000$/) {
+			$symbol_link = 1;
+		}
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3756,7 +3763,8 @@ sub process {
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @ &&
+				    $symbol_link =~ 1) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
@@ -3867,7 +3875,8 @@ sub process {
 		}
 
 # check for adding lines without a newline.
-		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
+		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/ &&
+		    $symbol_link =~ 1) {
 			if (WARN("MISSING_EOF_NEWLINE",
 			         "adding a line without newline at end of file\n" . $herecurr) &&
 			    $fix) {
-- 
2.43.0


