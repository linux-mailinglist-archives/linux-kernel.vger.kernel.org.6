Return-Path: <linux-kernel+bounces-382266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928879B0B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D051F287A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A95217453;
	Fri, 25 Oct 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQERRMzy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC7215C7D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877001; cv=none; b=coIpQXCh+3HuJhoIwbxR8J4JHQdjVcR+3bMbvef8GvBeNQUt5LhyWg2mSfB75VvgPQM9IeJRPsiUzgwOi4viVqdHN9hvMeQJLeObgWlwAe2utCuxRxjSTGusu3L0bcQ8822XVHEjUm7+ne6uxPwC1xqziQa0FGV25/pMicTrPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877001; c=relaxed/simple;
	bh=GBM4ZicRscGoqeRG2umNjcjdQ21UpmRmU+k4VWUF7rE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bhDVKJGEaCOWTFjWQsto4KoRcctgdWqXzNzjamlmkplA+CEnOPI1CtN/UIVVTYS9wdvSpIIE/NTwS5U1YeWFkJnQGR5bsf6MvXfnh/1EI47TSkOu4yhS7zROSTHgUWhtCc2TAMgasDgaoo4tNznz4SUpd8Trveaeq8l2kUDkw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQERRMzy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so47026317b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876999; x=1730481799; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tDa78t8ycfTpXeP4Xg4vb+EbbxD0z0lIJ18k3gRsWI=;
        b=hQERRMzy+dcJjFGP7GY2FUYLOhBxAL6ApOUvoabDJpNlj9bjqEYvSzBa+4yaHlaSnc
         fvHD9/XKdCzZ2jSFI2wQcSzh/lzRAcDaEBDTfPeN5smpZh3QXB5T8q7OklkZ7kOvZPhi
         tvGSDu7Ah2SiYGqNxuFElCeFWvdN/vBHQtH+lW+a260+hQAhArHaMTDw0Oyel8n00v4J
         cQuZPJ+sgsAtiuEwqVSaOBmCBJlFgogUBPAbn11hvY9/8+atG7dNCfRNzfLYzUYeK9M3
         LG7LiXU9EFVlTupwAfCIVj3aAJSDr3xywWezbud57jLzcKzvIzXKQyNVdecDx14PY7wM
         75AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876999; x=1730481799;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tDa78t8ycfTpXeP4Xg4vb+EbbxD0z0lIJ18k3gRsWI=;
        b=MKqh49mXhuHyCkiyQzdmzsuB+AD44rP7HYudYvsUhOlWEKqQetoTdC+fIuASqMfPFa
         uEAAQFF6ksHaUgtdjLWYTFrDaO8Axk8NWiXOisYaZvslQO+q7wU5Nh5uOSTfKO4UVF4R
         k+/iQyohaibDlbyYApBiDszoQWE44VhQSqurpEcK8YofkFh6athg+oEcQRW3ldjRawZ+
         dCuw0+IvhSCwSi5Ct/T9a4CdP+vb9kgqvDqGSXC3QAm5MsnWCbsm7+rU8iZKrb10WP9I
         E/3f3xmMzG/FMw0va/RYX+4D5lF103hQvI5NJN27/AvKU2/RG4KqyTL1EZV/c4A0LMWG
         L3ug==
X-Forwarded-Encrypted: i=1; AJvYcCUln9cmeOMxvk71hGBiqcvWtbnZCfyynuGmlCOfdqoxPaIhDWVUY1VB5NvbtybHKGmqhHImN4T1ctqPARg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtyk9Tgr4Rj1CV5GpfvmPsUV65R18JEfW8gw8bAKAIzQ7Ccpn
	LM5Nz3m2zxe+DKT/ff9r+J4XRUuv5PdVV+NN1jaR/Iv+013QQ4bQbrY95J6H4/ppifslZIpb8vG
	z5CQT4Q==
X-Google-Smtp-Source: AGHT+IEaZf1v2yI9/Za5ZHqS0DAFR3/KKmYp+kS4oGJPHqjPKFClcc6w5G+qVcN+YOlSFNHhya0UY86aEUKp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:f:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6e9d87b4522mr10297b3.0.1729876998917; Fri, 25 Oct 2024 10:23:18
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:02 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 5/6] perf test: Address attr.py mypy error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ConfigParser existed in python2 but not in python3 causing mypy to
fail.
Whilst removing a python2 workaround remove reference to __future__.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 3db9a7d78715..bfccc727d9b2 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-from __future__ import print_function
-
+import configparser
 import os
 import sys
 import glob
@@ -13,11 +12,6 @@ import re
 import shutil
 import subprocess
 
-try:
-    import configparser
-except ImportError:
-    import ConfigParser as configparser
-
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
-- 
2.47.0.163.g1226f6d8fa-goog


