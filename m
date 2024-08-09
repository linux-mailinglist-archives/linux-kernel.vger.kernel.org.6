Return-Path: <linux-kernel+bounces-281053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23094D270
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA011C20EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B3194151;
	Fri,  9 Aug 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8iq6B7Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272213FFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214865; cv=none; b=PYqN77yzQ1Tl+RmTEY7IorpsKAD9gy519Am3NiMiMnLCEnkrNqv/xMj3I1RR3/SwlHMqdeCoB33Sj444I1vvsVXCgPRg2vbru7jwntR1qO1cMrrToXhKVMCKu4FnurTMwWIYg3OxjjPHTlyYWXLNjVjdjA3i7v0bydcaSQ+qC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214865; c=relaxed/simple;
	bh=HZDk5r/OzkMUn6KJeM52VohzPFU+ywr6gwEGDDiDatE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qwg+lENSpozrkTIscyOmg4eKAafOXdIp9IavjbzcVDbVbP5LP4X+FwcxsDVmlGqXneJRPplQMCi7UPsLj8RO8SL/Jo15gzUdAKXaCqNbf1dCAa2ehWFrOr9wtIHhfhGm/Yr9WxW3O0GBpBy5HyG4XrExfHxmuISj10SnNbzUCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8iq6B7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57990C32782;
	Fri,  9 Aug 2024 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723214864;
	bh=HZDk5r/OzkMUn6KJeM52VohzPFU+ywr6gwEGDDiDatE=;
	h=Date:From:To:Cc:Subject:From;
	b=r8iq6B7Zh3jQ8gV3UadZoh10Hh7ZAQhKxCoIhM8b5SYLDpgUztINzY0MNp2G/+RRH
	 4dzEAHYcI2rdkUiS6ssJ65eSHRh3UlnT/3pAyPdbJXIukYpGVvQ0bdeati6ODKqSYY
	 8+UijovyWwslyAPwbYvnSj0IpO1wEWCMw8sLMwHpruAfGodHj4gfAj2vbvEKirT+ED
	 +xrPXlX+iQOkT3Z17Dqf0OspNMpBO7/uVfg++i+NF7mf5FzLiLUG7JJr0FKIXYT1Oz
	 hmtGnXgels6ApfuEVPPxPsuUNl1W7DaLuCUUkkNPSaATrrKf42EmNOCtm16HXtb2kf
	 8IyHUwFhDVeLg==
Date: Fri, 9 Aug 2024 11:47:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf debuginfo: Fix the build with !HAVE_DWARF_SUPPORT
Message-ID: <ZrYsDYh2VVmh3GMw@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

In that case we have a set of placeholder functions, one of them uses a
'Dwarf_Addr' type that is not present as it is defined in the missing
DWARF libraries, so provide a placeholder typedef for that as well.

The build error before this patch, a static build out of 'make -C tools/perf build-test':

  In file included from util/annotate.c:28:
  util/debuginfo.h:44:46: error: unknown type name ‘Dwarf_Addr’
     44 |                                              Dwarf_Addr *offs __maybe_unused,
        |                                              ^~~~~~~~~~
  make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: util/annotate.o] Error 1
  make[6]: *** Waiting for unfinished jobs....

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

I have this in perf-tools-next.

---
 tools/perf/util/debuginfo.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
index 4d65b8c605fc5445..ad6422c3f8ca3ef6 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -40,6 +40,8 @@ static inline void debuginfo__delete(struct debuginfo *dbg __maybe_unused)
 {
 }
 
+typedef void Dwarf_Addr;
+
 static inline int debuginfo__get_text_offset(struct debuginfo *dbg __maybe_unused,
 					     Dwarf_Addr *offs __maybe_unused,
 					     bool adjust_offset __maybe_unused)
-- 
2.45.2


