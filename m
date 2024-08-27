Return-Path: <linux-kernel+bounces-303957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF436961799
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BCD1F25D79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F81D279D;
	Tue, 27 Aug 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwkfc5vG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EA1CDA32
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785301; cv=none; b=SFx3XrN59z8Pz3Gxbygoo4J1K7A+hNs2pbkllyTd9cPdINMPls8W8Y9Up50qR/Zeisu3IsRL91YlGOqHpYoC6YcIzJnyYXuENLyCQtvT7V4Kd0pdcSzGb1nmJIQN42DiJTdtcJCcr6BjgQpwgZHNKz6etkOnXQGk9GqmahEFtFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785301; c=relaxed/simple;
	bh=Scmj5lzwn5W1lEPgR2uSiBEfwLH6KC7o702XtOLtEjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R9NFIftcAgLRiaC2O5tf7Osz/r0I9H1ihDcshlisI+gjvoHJLWcUOfS+lfyTiloPjn5/Q5t7l5mmpp4WGucASmVUCZTGwX9i+vEpFglOeeoIpMApLgMMYPRIqSJurhLgg+p8FiC4FzIxgni1SXNGF8QEOp000bHnW637fv6yB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwkfc5vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B656CC4AF18;
	Tue, 27 Aug 2024 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785301;
	bh=Scmj5lzwn5W1lEPgR2uSiBEfwLH6KC7o702XtOLtEjg=;
	h=Date:From:To:Cc:Subject:From;
	b=mwkfc5vGMvEkXpr5ZSCyaUdqbUg1CRbBh9aeOSV9lxFXIGp2jzSKsUNRu+xhPsFSd
	 X6ilszW4CFxTuFp2QE+F7m9h0T/RhYP/3Bcmcoj3igZBlkDeVflaidQj6vFuuWg6Cc
	 s6QsXKbS46/nA2BhI9Gb+VKR169blfQkKG4W4YzoehrpyXNsWGWPtuYOJSYol1xHm+
	 XkFID2S3Swyp6ZqixXesYJGiFnjLUmnfjAfPMxAbdJFu0klIXLAa9NMY8U9FiQcPmh
	 a3pqbokC/rF0BaxhEK9AwWHpW0s0Tyv7jE+omD77gjZ9IChwLawSqy9I05dZDPOu/C
	 7Oi5VImyQao/w==
Date: Tue, 27 Aug 2024 16:01:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf test vfs_getname: Look for alternative line where
 to collect the pathname
Message-ID: <Zs4ikTuT1WTC3orO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The getname_flags() routine changed recently and thus the place where we
were getting the pathname is not probeable anymore, albeit still
present, so use the next line for that, before:

  root@number:/home/acme/git/perf-tools-next# perf test vfs_getname
   91: Add vfs_getname probe to get syscall args filenames             : FAILED!
   93: Use vfs_getname probe to get syscall args filenames             : FAILED!
  126: Check open filename arg using perf trace + vfs_getname          : FAILED!
  root@number:/home/acme/git/perf-tools-next#

Now tests 91 and 126 are passing, some more investigation is needed for
test 93, that continues to fail.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index bf4c1fb71c4b8f12..b3802d9494b42122 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,12 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		line=$(perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
+		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
+		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re=" | sed -r "s/$result_filename_re=/\1/")
+		if [ -z "$line" ] ; then
+			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
+			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=" | sed -r "s/$result_aname_re=/\1/")
+		fi
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
 		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
 	fi
-- 
2.46.0


