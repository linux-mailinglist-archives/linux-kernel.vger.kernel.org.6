Return-Path: <linux-kernel+bounces-533561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BAA45C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DED7A401A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD42459FF;
	Wed, 26 Feb 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSu4PZX5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6272673A3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566518; cv=none; b=DxN3arL3Gu6wcRz8OVjhyUce9uZzaxNif3jcHS/Nu0Ar+bEB+OylTFVUkwOX8NbHjPDK4vP/Z4h8GMLt8ZBMasmfHmEyg4R7rVWIdyov6wkoa7EoB7E7gcbdAYZK4SfdyblIV0YkW0EZXDWR5DNp+2o55uXPzGT5h8YQZ9FffA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566518; c=relaxed/simple;
	bh=5EiFSMpBB+dPmpFSiJ5l3QtjK6IuR9uOkZs1Cfqm6ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBdkwCx3Gu/cI+MlfTvKh5qnLFapDo51rrvTicPDjPlh+zUjrWyGSY3Jx1eXj40ruXergt941jL0OkeCs+13LIza6KqCProgo1JoV++3fVybWq/IoolOLhBrmSCQeNjmT/KPGkpGtn1gEXerpzFZoH1Bf8FI9LNGPAZ2g2x89fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSu4PZX5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so5446471f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566514; x=1741171314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnPKi8fEvcW6+/UgkZDLw5oR2nNK48/l+H7XRSgcBmA=;
        b=HSu4PZX5mBXaDI/iO3DD9eO05Y9TYCkk9SC5Q/DPcOHPTbpn636JJFUqwVBsMegTXu
         RRSnV2wo//emxyMTWQ3K+ni2F3xIymrj184OUKPVGzUR22VmWskrxH5Zi6RQ860kmhfP
         vQeLwGONDWutvsmIwQFgd9rms65z41vfcOWXhHY2pSfEhzj7MiR6Dsy0K87EwM2KEO34
         PFZ/HYrZHUdXM/1d21kiUz2NTmhxh8WoesZwctKZ57c2S0SjhDgpeLQjbfbFTi4Su4MC
         ivt3gwyIWNBapq22jax8dCuFxh6TIVtLSO76j4G6eN3bnFZWbXEVqIQgxBdY9FdOa3cK
         SKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566514; x=1741171314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnPKi8fEvcW6+/UgkZDLw5oR2nNK48/l+H7XRSgcBmA=;
        b=ntOVlf9n5Fehv5VpYmtJKgf2NADvcKG/K/b96waMV7xsqkfaTsGJR867bDYspSKK9J
         eFPvvDZvwhbhQINRayXDV5RngtO/2+NNCKke44TPGPHNRbb6JbZGWDA2toJVEVEEgl71
         PEBH7gl+UHbC4Lp8yGuas2dJ+PtK5fGC24ONTiWlsT26M+2jg/lMqPpf17vfgVQCVVug
         awEUK8UYQqVmVio4Tn1+5yZFVS6+nOwvdc5JpyL7YuVbnkS7bLmPhd2oBh7yXLrqT/aR
         j0Kcw3JQ7w3/Hu8MXm8rKHJqSMglrmajKr2eKjhxKMh/A9ifeFqrF9/WZKQlouFORu9S
         jtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69swrKkWBKuwgL+3hB0bih1/4p9zL46Dq13/JNTdnkFzCPefQB/G3lD/AU+4JVdbFX5QkapdosRzRtjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyatqhj3N2QcRk4W/JxjPKGmCyaWd0dMi7kcLEyXTVf6glqonQ6
	Y+0TSkSZ/Zuk0ESvoDTdljmgxtPchMcUmDPMzBL9Ug8yj9NDQn0qRYS380IL1JM=
X-Gm-Gg: ASbGncsmYlyN1I4hUty5u9rlqJ1TiEFJVV7Sd6yuzwuWynSnoU3zYEzjUagoRkbO1so
	gLKJHeheverEwydf5k1RK7OEAn3nd9Q3+nLyrhk0FsfBV9Kdi3ajmCxXESKf3q+M1zSCGNOXlIE
	pKG/zPwLQJmPzBbuXk4H4MliIPxhWY1mDKLQIRVUeIKcTkKnMswOOXQTI7HuvWvkHuuJRtVlLPF
	E8NWPhJBG52krVEDK+/Q5xLXD64esmKE4hX5FXMgaiR9+IMOD4cLbQeDJ+TkiYXK3uBMlZntS/7
	yhfHv5ix9vql8bTTd3bLyQk+TRM=
X-Google-Smtp-Source: AGHT+IEOgLtlZFBNQI4Oefdb5y95WXLrPgz8hQbQNHAnUUq8U8VNjZ/k0l10FRBjyvMEjkLPnHcY7g==
X-Received: by 2002:a5d:6483:0:b0:38f:2a71:c105 with SMTP id ffacd0b85a97d-390d4f376famr1997877f8f.1.1740566514106;
        Wed, 26 Feb 2025 02:41:54 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] perf list: Document -v option deduplication feature
Date: Wed, 26 Feb 2025 10:41:02 +0000
Message-Id: <20250226104111.564443-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226104111.564443-1-james.clark@linaro.org>
References: <20250226104111.564443-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-v disables deduplication of similarly suffixed PMUs so add it to the
help and doc strings.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 tools/perf/builtin-list.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index c3ffd93f94d7..8914f12d2b85 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -27,7 +27,7 @@ Don't print descriptions.
 
 -v::
 --long-desc::
-Print longer event descriptions.
+Print longer event descriptions and all similar PMUs with alphanumeric suffixes.
 
 --debug::
 Enable debugging output.
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c19826f218a0..fed482adb039 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_BOOLEAN('d', "desc", &default_ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
-			    "Print longer event descriptions."),
+			    "Print longer event descriptions and all similar PMUs with alphanumeric suffixes."),
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
-- 
2.34.1


