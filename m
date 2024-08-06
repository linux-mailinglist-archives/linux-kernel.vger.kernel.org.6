Return-Path: <linux-kernel+bounces-276051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97041948DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3062E281DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A791C3F2C;
	Tue,  6 Aug 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gzFyxmw+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0E1C37AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943960; cv=none; b=R2rtfcXsZRxzy3UGf8AGxPdu7523w5eHE8bBUWENqEzZ7UOs7wOtiDmvl3glIXfaX0ASYEAJGa8VYxJ37AjC+nyaFE+/6HxIuW93x5q/mg6mVXizRalZ7A201vl9E/jZ991WeE6D4kI7SmIcN7mLdQ/zm1cAHbXI23mWrVqYTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943960; c=relaxed/simple;
	bh=bw7O6XpHC7r+m1CC4YZziOd6gskK8nQ4ogco5AG2D5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A89QF8hS4M4G8pVyGq10gy0vQxVl56QO2i6JZZ1b49QdopASQQ4XfusKoTHFj+ZhilFtPoTEyO0e4ITxZH6wwiMe1NGuUrcP2lPiLiu7MojHWy3sIsHofGXHhfEczXWG1x1JvWKgTKzkjIgfq3iXkdeNzC0aXTrQaXqI0BEuYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gzFyxmw+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710afd56c99so316394b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722943959; x=1723548759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3d7qHXqlvdC3QbsQBCsXeOqWxtvBelleMxdV+48O40=;
        b=gzFyxmw+Iky+a3VsqQhQRccntlv94QMZgB9D4RSELzMTABaDoN4YGTftCaQBZC7fn3
         UHybZbLfY4chLLxXLjHi71nhOpgVOWYEaMpGgJ0NkyQ1EKVgdAgKQ9CSCes2pDwwaYrr
         TvPlze5Gq6XWITU5bzV3j1go4r2MY5Ew3t+AjYtpxKZPIyAOxpM6dorriOp17KrisoZP
         5uLNaQXFVW3wAlaIsGolrZyKxlNOi27T47oxT7MzPBFrc0Zr1IfnpRO4xDh/Un30psFS
         1RG3z1HWAx0Zm1yA4USxtR4qZ8Q71NUz3Nx7mRwHQNnnkBEs+jqlMRg7XubSNzc1yzEd
         iqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943959; x=1723548759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3d7qHXqlvdC3QbsQBCsXeOqWxtvBelleMxdV+48O40=;
        b=Wl+A1UsOtAhYlQ/amulKdV47EyFp5lJH79iq9Urb+L+F5MBOj/7Jm810cwwu2uiDbz
         IJIoY9jbQwer1XcNrtHbsy88tN498dk2gYFMQ/ZfiPG3ClfJsIw5Svn9npcDz+e5oCw8
         6aYZ/6rLHGdrQ56VjNeyPSOzhUn9152FjCHhCLVxP9RFp6Wg8BzQ3r/GTfAx8KK098L6
         4nqhJrnY4/aOGi1+i8ZYqZUOE2ToZneG6fafnn7gCX/B4yPLubGUpxesKkexdQFz4Nac
         ftDkdVlwxnRvwVHSDGjxIawE20I6ce813CB8rmMcSJucMuHj3MqIlzDvf2gyvvMRWFAW
         bdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYPe9KLfa51wwKFlt7e9l6D2spZrHnZui2DA5WfVUYcumon5p1cTOoOTJAnPHrGO2gbyKng3/mzpMpEsAdqfEkejgRP9b2OyyGh8hE
X-Gm-Message-State: AOJu0YxwI+C64MfHC2ufSstNv10LCxruwNSt5SC5QDDcrtluOx5sLVIa
	d1vZfFOjV/f/wa3CWKKHEW9cUgTN2izwT5G0+tGnLlFsxzJ12cyFgINMoy+1354=
X-Google-Smtp-Source: AGHT+IGqyXhOwbbxASKs3xPLtrpmSHfC7s3rObvLhLPzu6W/OCCW9ob084bsPdRxfXVrD+izaXegUw==
X-Received: by 2002:a05:6a00:6f1f:b0:70d:2ab5:8677 with SMTP id d2e1a72fcca58-71065f1d9bdmr26800444b3a.10.1722943958615;
        Tue, 06 Aug 2024 04:32:38 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec010a9sm7037636b3a.10.2024.08.06.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:37 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 3/3] perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
Date: Tue,  6 Aug 2024 19:32:10 +0800
Message-Id: <20240806113210.1649909-4-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806113210.1649909-1-yangjihong@bytedance.com>
References: <20240806113210.1649909-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 3796eba7c137 move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
code from dwarf-aux.c to dwarf-aux.h, in which die_get_var_range() used ENOTSUP
macro, but dwarf-aux.h was not self-contained and did not include file errno.h.

As a result, the build failed when HAVE_DWARF_GETLOCATIONS_SUPPORT macro was not
defined, and the error log is as follows:

  In file included from util/disasm.h:8,
                   from util/annotate.h:16,
                   from builtin-top.c:23:
  util/dwarf-aux.h: In function ‘die_get_var_range’:
  util/dwarf-aux.h:184:10: error: ‘ENOTSUP’ undeclared (first use in this function)
    184 |  return -ENOTSUP;
        |          ^~~~~~~
  util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears in
  In file included from util/disasm.h:8,
                   from util/annotate.h:16,
                   from builtin-report.c:13:
  util/dwarf-aux.h: In function ‘die_get_var_range’:
  util/dwarf-aux.h:184:10: error: ‘ENOTSUP’ undeclared (first use in this function)
    184 |  return -ENOTSUP;
        |          ^~~~~~~
  util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears in
    LD      arch/perf-in.o
  In file included from util/disasm.h:8,
                   from util/annotate.h:16,
                   from util/block-range.c:3:
  util/dwarf-aux.h: In function ‘die_get_var_range’:
  util/dwarf-aux.h:184:10: error: ‘ENOTSUP’ undeclared (first use in this function)
    184 |  return -ENOTSUP;
        |          ^~~~~~~
  util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears in
    CC      trace/beauty/fcntl.o
    CC      builtin-probe.o

Fixes: 3796eba7c137 ("perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/dwarf-aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 24446412b869..d2903894538e 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -5,6 +5,7 @@
  * dwarf-aux.h : libdw auxiliary interfaces
  */
 
+#include <errno.h>
 #include <dwarf.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
-- 
2.25.1


