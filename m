Return-Path: <linux-kernel+bounces-238463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC90924B27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541251F28C06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D21B6A63;
	Tue,  2 Jul 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P61IpjSp"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBD1B11ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957544; cv=none; b=MNL+d6ZV9ARS4FB5+Iobpdab4518vSdYxg1HwqgbdUUKae2LqxLrWJE1pmJLHrUktCzdybmHVHm2MoATYYAAdYcvpktZW2fUZ+3Q75Z3yFWIRuDquVJIfpJX2sCf3GVMRwlUX8Z7bRtg5TCPgquWacjl36FmviGILH7wVtX5knM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957544; c=relaxed/simple;
	bh=hRx/V3N1tOC03q/ejC+f/u6Teuj3+AZz0SNmbH3aP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaSpNSzIvlMwSMMh564wsxOTVw5hbNnciw83SOE/Vn+/oRbEf7DpAqntyMssRAOhdlwmuhFMkR5VfTMTFwmAHigmiUxvLWbwH6+/coJ03nFLNTPbnkOU1+qe7+MS9ZRhTz3C8Q85A2aREYDOqc//KHr8dM0J3Rt4U/rUpi8mmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P61IpjSp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fab03d2eecso36554565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719957542; x=1720562342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS62etFpIYNGMrGCK000i0PIRfNlj81mNm/Gs9qD5BY=;
        b=P61IpjSpNrFO4Mhe/vSPn+HYxWf9wzZff49NXuEIUmGW8tYmt6z7T1ohloU+Dpcz2J
         P0trfgxN/r38uwvtDsJiLTdvgssqJahaJV3tCi9neHYRY3gyTPhve2SsCXivLBnJJRSu
         HnVKMUrzsSdDkh5ORdc/9HLXWyaOOXjY2wa1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957542; x=1720562342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS62etFpIYNGMrGCK000i0PIRfNlj81mNm/Gs9qD5BY=;
        b=R8eu7qPCsAODwAdYIj+4qnO0TW4z86omNfVuU5ITUSBSuZPMAXfqryB+JAgn/a730N
         MqYg20D76d2e2UpPq9hqfgcyJ3voImdkOfU7z0/izPR8xfR2G3e0rb+PiO6Ky3TNfSIB
         jOAC07Nb+VULpE5RNdpWr0VyGbIWTfIsT8sMjUoHV150RggpluT003J3TSqbML/F01Nr
         NHrWqXVebysQIR7ijiAnj0Q9fkxbnpsK08XmyUQ5X6nvaieXdZzXG7tepnFJWTDLFnRP
         BkVmPNzwEtfNVRqgV57HyQh1iKRMT3XPfDhN8t+5fgd1L/aZI6/PyPWEw+059DWJuz5c
         r00w==
X-Forwarded-Encrypted: i=1; AJvYcCXV77YjgicJekpxFSMNibACLzApQhsh+bkWKAExItexexTfeHapYa7hkmsyD7OGRIvg2bznFOkuDlEAhl1RIhQgb6nXZKwUfVl4ggSh
X-Gm-Message-State: AOJu0YxD/uhLFAdlKG1sPDfcDrQMOsEd6zc7W5B9AqrRTW59I+2Uf9pG
	d+3FrgoYZMlMaU4LHDo4dU+eT8RrlQIsXIeniTZVfwLjGk43/bFbOmj+6ICcUIGlyVuGum5x1Md
	yVQ==
X-Google-Smtp-Source: AGHT+IGhBHTd3UcyBZmHUjgYyT7fXHIhXEIAs1XDCCOIAV7kEK6DLojlLX7aVDeHN+pn1Pb84Pk4hA==
X-Received: by 2002:a17:903:11c4:b0:1fa:ff88:8914 with SMTP id d9443c01a7336-1faff8890ccmr18873025ad.35.1719957542207;
        Tue, 02 Jul 2024 14:59:02 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:5fa9:4b10:46fe:4740])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fac10d1498sm89565205ad.8.2024.07.02.14.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:59:01 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/3] tools build: Correct libsubcmd fixdep dependencies
Date: Tue,  2 Jul 2024 14:58:37 -0700
Message-ID: <20240702215854.408532-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240702215854.408532-1-briannorris@chromium.org>
References: <20240702215854.408532-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All built targets need fixdep to be built first, before handling object
dependencies [1]. We're missing one such dependency before the libsubcmd
target.

This resolves .cmd file generation issues such that the following
sequence produces many fewer results:

  $ git clean -xfd tools/
  $ make tools/objtool
  $ grep "cannot find fixdep" $(find tools/objtool -name '*.cmd')

In particular, only a buggy tools/objtool/libsubcmd/.fixdep.o.cmd
remains, due to circular dependencies of fixdep on itself.

Such incomplete .cmd files don't usually cause a direct problem, since
they're designed to fail "open", but they can cause some subtle problems
that would otherwise be handled by proper fixdep'd dependency files.

[1] This problem is better described in commit abb26210a395 ("perf
tools: Force fixdep compilation at the start of the build"). I don't
apply its solution here, because additional recursive make can be a bit
of overkill.

Link: https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/
Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 tools/lib/subcmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index b87213263a5e..59b09f280e49 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -76,7 +76,7 @@ include $(srctree)/tools/build/Makefile.include
 
 all: fixdep $(LIBFILE)
 
-$(SUBCMD_IN): FORCE
+$(SUBCMD_IN): fixdep FORCE
 	@$(MAKE) $(build)=libsubcmd
 
 $(LIBFILE): $(SUBCMD_IN)
-- 
2.45.2.803.g4e1b14247a-goog


