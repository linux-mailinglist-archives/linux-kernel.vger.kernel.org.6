Return-Path: <linux-kernel+bounces-333038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE997C27B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E1B21DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BA1DFF8;
	Thu, 19 Sep 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q78xypdg"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBA5FEE6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709755; cv=none; b=PLglSF0Z79nGOov2xk2+ottNPWJfTuugiD0QqgYrGzzQHQpNQBWTZ5f9LE7V9GZQH6OKk5Gljxrge1peLuO6FdxtGhoQ/i7giEquonS4m9mFUej9L+JwKPznS5phi4Bg1e3TqW64ytfl+v55ENlHtABWyZYUcdExvdHwfZlOruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709755; c=relaxed/simple;
	bh=quPAw/YDVglqeBc/pZOlGo1b4LH4gcDFKP2lbdn6t4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZ2DkbhsR5D1AhkovM6HDIcW8afK+ElUzqv0QMxrvR+ZoOmeJPnUzr8PHwKEW93JOC8yHMlAfmf61F2H+7q7jpIbzpLaI5vZQgqOz/00n4jcPHFk/lApvZo1eWeP4t9AdkD57O+/bVG5IVSGAz4nBdlRbOBbje3iJdACDS1kr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q78xypdg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d91eef2eso216593b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726709753; x=1727314553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npTyP93XedPkwqp1pklFR6c6ybhIMeDgxugJALQqnq8=;
        b=Q78xypdg+Rf2PqrM634/YVRwe6ss8TYa2ZTVXRA5TXGWZcldDfL2kisP5DYSDU8opT
         dwkEX/dX22mC3q/affO/eNEnGEeiMptGe/diSXkS7fU50Ob/bkpfUW8OiROFioPDL7v+
         M9VJip1S9PCM9+NtCKoaupP9aBH4jXH0yWhUGQROj463bmY5ol6TIYxU4B5xRzaRQ2pO
         AvpyrcFbkbOCGl8dgf0Y0ztr3bR/NrdTJSltYCq6Wt+MVAuS0gyM2QMKkYaVlsPqjHDn
         zWIu3CkLNrShkak3Tprk+AvaJ0VrFoWTjd53puUi0lL1td9XgWOftBEDnuE+s3W729of
         mAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709753; x=1727314553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npTyP93XedPkwqp1pklFR6c6ybhIMeDgxugJALQqnq8=;
        b=G4SsVCNu9NDNPzUKXmLytlynNay7ABri4UC/NXmUHfhovveQvdXhX8sR5UnHR8NB4E
         e1jW1vFEJ8tt5f+M8O1sItbSZ8NAsXnFViq6FNgL15gJZN8NvqaH1TugdkXokOB1BEmO
         WG9UmF23IG75KxX8T8VCGAk8xso0WeJiYJu5wMPV7E4HzxPVjnDKjPD0/LXn6QbHWLnV
         3R2a314WjUaFhfkXnO4Cf66T6xFHQjJtiH8RuEJkmgE3nCZu4C10e+p7EooDNNa2k/Xm
         Bdw8S4ruX1QAXaRmdX9snpiC6T2uWtL9nBCb5EfWZ17x8ZJrgMXHJDsAunvHIyQNUfJf
         a0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPY5FmMqMRbGxr0iAZ2vwkF0gZhrQq0W/DgK25jc2mDbyk5ezJ7Az+vjzs6a0kGl8V3E51GUihyx3fIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGM+e7nrsVQtunpPrB9O80lbH3KrJGFFrF9ZUSOV4u/cEorrVH
	YL5gnu0UZsbiPFJzgrFBpCrzPOwxelVyi9cRHSIwAHbrWxLKPNIBHQn1Aetc8fs=
X-Google-Smtp-Source: AGHT+IHxbKgK7PAsYYuZNq3ZCOnnJEros1Mxbwcwe7M8IhLy178PSrgisJMSb75ooD3rqXnIF3RmwA==
X-Received: by 2002:a05:6a00:98c:b0:70d:36ad:3f67 with SMTP id d2e1a72fcca58-7198e2dcef6mr2079730b3a.11.1726709753039;
        Wed, 18 Sep 2024 18:35:53 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc9ed9sm7282482b3a.209.2024.09.18.18.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:35:52 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Cc: yangjihong@bytedance.com
Subject: [PATCH RESEND v3 3/3] perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
Date: Thu, 19 Sep 2024 09:35:13 +0800
Message-Id: <20240919013513.118527-4-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919013513.118527-1-yangjihong@bytedance.com>
References: <20240919013513.118527-1-yangjihong@bytedance.com>
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
index 336a3a183a78..f0d702b9ad75 100644
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


