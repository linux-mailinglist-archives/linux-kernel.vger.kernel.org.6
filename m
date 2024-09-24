Return-Path: <linux-kernel+bounces-336421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F132983A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95EF1C21F25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71B1B85F6;
	Tue, 24 Sep 2024 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XS17+XRf"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416D12E7E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138257; cv=none; b=Ow2knpjwBc05ZKPUr3KZWFta1jawz621lAdklnAC/7TKgXLopQst4w6cLrHD2XSzvqbETEALC0ctD1dtfp6s08cmOq8nzRS3TJC2OQik2XQYIGvmEamfSbo98OT9YdzAuUsuJRuew8mWqLwl0Y/mS+32rj/gUxlVDJhcivXndhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138257; c=relaxed/simple;
	bh=doNQHCLr3DHVKlHSPOr/SFJZMwwugvotkFRUhq87sZE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uVGcG7Z5w8QprZdjPx0n1bxCpeAvo4UDBBWK6U88UpXPBCfe8+NCjvB7N46rhXPsQIcXQYwjh1f71iczlK0j0iw/DDOdqetnkQz4GdYrp6A4yoDDme/Z9yTcbjhebYkA64cHq6q+XOaPCplnPKIs6VzGSmCFijBpIL9Uuyg9ngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XS17+XRf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20937a68bso9060977b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727138254; x=1727743054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sp6sXAla2GY+SvoZ3Iq1EGisUuOQIFS1R5Cs1D9l3B4=;
        b=XS17+XRfeo5+fWCNMmqdyrnuZS7CjGKGGTjsd6jS2xjBoFk+OgaSRyfQlCnfp9MQy5
         WiSsfzd7wD03zoXIkPDG31dycccvbv9Ye2+NGmKVTNIipib0TUSl1XxKAbCps0fg50Se
         GrK4azqA90k3XY9qSZSMuHEvlKUCFhBXszsoOUezzjxtqPU+6+hSk21DOol0cT+b0wGC
         tGZSsuMCW//m5CCUS4sqJLahdOV3+F1EN03HBfNACXhlcOq0rYoNF+0cJbSFZhC4ywMm
         jj0br7dcmGUPIhMqZ02hmWOQp/2B12onWiSasUMNc/6NtQACCA9U3C2SN0W+q0bDKyfg
         0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138254; x=1727743054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp6sXAla2GY+SvoZ3Iq1EGisUuOQIFS1R5Cs1D9l3B4=;
        b=qT/Q0v2ZGIx9Mxp6EaP9P97zdwuzyOuQUK/46F7cJuwJYSujah+seQgWn+HIxEVsXS
         R+1DgDLMPmBrw3um3dU1d1PsjKD+xYY2+e4n4l9sDhgpiWc3ccU0pVoNx7gbP/rP1YRL
         wiWiHvubRq5CCYJmpgDWybI4BPzfk+Hlxe1CkfqlJ99Li2/Fpm3qkGD+bYGcEQFhqEXM
         Ws9JICN0f5A+YUvjYQNScC+NBlZLj/VPG/B0/VAtabsq8DceLb6AhnhFwq6scIwOJ5V8
         OwOiv0/q+YclJnewzjAH4dN+0tKtc2PoAvUc7YnR2HJqwgxnwz0YNaspmJ1PeagZbQ/+
         kw5g==
X-Forwarded-Encrypted: i=1; AJvYcCX3N/TGEQvCcOvKoQbeuDTUXdTIwe7gtiRYnPMGd58dAAAToKDCc1DVK6xPcLB3wiy0IeXfNKUs5Tgv16M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaf5jYjG/aispNdf1mCK4TRpMNMpgS3eMLBxASMiguofdMdQN
	Z+aPYISDP4eo/PzyHV7s2BwKaE1b3SUAl67jdmns7k0XOmwoX5ZkMJd0vb6nP6zquz9nPuJDwYz
	b4ZiAEg==
X-Google-Smtp-Source: AGHT+IHIlOB5DfOGX/DAeRX3x66qG2gS9/yfEV3xex2xyR9vwzEtaBMU+fNEY7mUC8w+NH0cHkWubm9y9fxl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:450c:b0:6b2:6cd4:7f9a with SMTP
 id 00721157ae682-6dfef143839mr2392867b3.8.1727138254662; Mon, 23 Sep 2024
 17:37:34 -0700 (PDT)
Date: Mon, 23 Sep 2024 17:37:20 -0700
In-Reply-To: <20240924003720.617258-1-irogers@google.com>
Message-Id: <20240924003720.617258-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 3/3] perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"

Testing with a LIBDW_DIR showed some issues. In dwarf-aux.h if
HAVE_DWARF_GETLOCATIONS_SUPPORT isn't defined then the code uses an
undefined errno value, so add errno.h.
In Makefile.config the dwarf feature tests need the LIBDW_DIR setting
in the CFLAGS/LDFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 6 ++++++
 tools/perf/util/dwarf-aux.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4dcf7a0fd235..5e26d3a91b36 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -159,8 +159,14 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
     DWARFLIBS += -lebl
   endif
 endif
+FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 336a3a183a78..925a9bb9fb15 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -177,6 +177,7 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
 
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
+#include <errno.h>
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
 				    Dwarf_Die *vr_die __maybe_unused,
-- 
2.46.0.792.g87dc391469-goog


