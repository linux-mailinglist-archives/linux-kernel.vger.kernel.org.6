Return-Path: <linux-kernel+bounces-277238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FDF949E43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401C228644F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591E017AE1D;
	Wed,  7 Aug 2024 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q+YfgxQI"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B218D648
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001013; cv=none; b=QVmr7x/yruQbpK70V76WtqQqARghGgUEv58RDpWUA+HgxHI9wWPABMQ8rA3cmXpGGwHGjzDNfj/fZjSn3C3pbqF6YC1VYZIGMvYCX95Hmw7GxsrJn3Iw73xbHjkzoyk6xc4+ZefMeP/5+QZPVfRzzzPAkZVJ40Spty3vdKZ4jbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001013; c=relaxed/simple;
	bh=MSZRdPB7tQPdZmenGNepOe2UXyZ6olFqWjSe40VO59Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kk0c2koO3L84XL4+Ucx+sFGEbrpVWc0KTLyVAEOaAghBGM/LQiC0jRiCj7crtBA3wdp5lHKYfxwSr4DZxZxmQxSE25T9gMojIBWIUX/rK+TgFdWohaHjgv3hpogfhExYO2CgyEvTLC2sinp8ihrnFq0D+IggXQ8EF10s6oFy8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q+YfgxQI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7b594936e9bso1006835a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723001011; x=1723605811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYiqLHOYT/UvSrPxb13rz+5rfnkguhZae8NxRF4xj0A=;
        b=Q+YfgxQIuDTaXtPe/qx0EW/lPHsvQseQ/t5vwVcGRafUPKC7fz7pGqEMccy9I8nDYu
         41jw/PdCLfsqXKP+t5csRT1mk7Uy/O1A8cPhgu3op8aRgVigFbXjzp4WZweciwKK/EA7
         JwyRikFj8gSHb4klnDPVEd8mBHojWuY9HCz2ac/b8A7Xr2Gxg9L5uq6tMfZC8lQZ0mlP
         zy4UqkdGht5u/zlqgyl+XO0w62HyIlzoH+9qhbJtnv7ogOyuQTzu5SfwA9mWN8jZRwbj
         N0Pnar4azBWuiAkQLkONjO9Gt2ZVWgr686A1YuvCaYc4ngbDylJugFmNBkbDwI4cgkIa
         M4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723001011; x=1723605811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYiqLHOYT/UvSrPxb13rz+5rfnkguhZae8NxRF4xj0A=;
        b=aTTk7SSE7oBenO74E/DfgAkkGwsamYsDZ6nNed1hEzEb4xww+oD2sGoA6RziY5fQ0E
         /71M6XPS1jThzsg7KaIuEXZngixBf+hSmzS44EtkGoYCzfPds7gEmDqMR6LO/mj4dXcW
         NJOlbvSiZO5xjarAyXTIS+VcRcmoVQeRh4OHEP1BCsJl9OafClEnfVIstsXNcen33rWn
         ZtTnc8uE9YjryMRqJa0YaQoS5RV6MjodYQrKPGQo7T/POqTK86Q9TAGHFttdcsUSV2vo
         Bt9GwgqQmJX5LgmP8XW8Mi08P1La9zPhWkDOU7HS07YvQYSUVOqJUFqLsFDndarE8RtZ
         co5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiHQ5MeQRjkBbEQMcDTa5UdHPo8PSbB5O3mFbKpvn/SCHkw7E/RCZZBLjrsrde/RlzY3JeoNzOTyS6AEK8yxKHa4oCcZpngaYasMHy
X-Gm-Message-State: AOJu0YzvGH0cnIKafTkMkJOaPzw1NdHHxnJ9UvXLHkzl3XJdDaT7BrWM
	WUzXsJB7x9ymvk3++qZNgc89a7worvQ+Arof7VnptwYv7osmf/dfORDIweafCX4=
X-Google-Smtp-Source: AGHT+IH7L0KNDBz70xq/NORMivPYJerKWa0aowDLP0OkhebCIuGFZq9AsCyfTZra7ipH77FI7JlrdQ==
X-Received: by 2002:a05:6a21:2d07:b0:1c4:8690:9862 with SMTP id adf61e73a8af0-1c69965eb46mr18256505637.43.1723001011569;
        Tue, 06 Aug 2024 20:23:31 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53832sm94679255ad.73.2024.08.06.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 20:23:30 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v3 3/3] perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
Date: Wed,  7 Aug 2024 11:23:19 +0800
Message-Id: <20240807032319.1828962-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3796eba7c137 move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
code from dwarf-aux.c to dwarf-aux.h, in which die_get_var_range() used ENOTSUP
macro, but dwarf-aux.h was not self-contained and did not include file errno.h.

As a result, the build failed when HAVE_DWARF_GETLOCATIONS_SUPPORT macro was not
defined, and the error log is as follows:

  In file included from util/disasm.h:8,
                   from util/annotate.h:16,
                   from builtin-top.c:23:
  util/dwarf-aux.h: In function 'die_get_var_range':
  util/dwarf-aux.h:184:10: error: 'ENOTSUP' undeclared (first use in this function)
    184 |  return -ENOTSUP;
        |          ^~~~~~~
  util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears

Fixes: 3796eba7c137 ("perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file")
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/dwarf-aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 24446412b869..277085a49294 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -6,6 +6,7 @@
  */
 
 #include <dwarf.h>
+#include <errno.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
-- 
2.25.1


