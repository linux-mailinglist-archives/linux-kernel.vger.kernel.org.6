Return-Path: <linux-kernel+bounces-251105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC149300B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9289B1F232F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1C3770C;
	Fri, 12 Jul 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LL5V06nj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19720326;
	Fri, 12 Jul 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811386; cv=none; b=gvV6cv+B5OgPbUFb68i7ismpEBuKFhDQxFrTtiYdWrIJAsswcubYi8H4sckRZXDEOVYnoXSzttezkbURkIvy1obQRfpa1nb2x7+h61iaqAycbTnPOsKIUqls+GwaSKyfHMH3QGGr00jRbFaLFWSc4EUvSSYu8AQXn3bNVtUfBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811386; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+UmLFdV1rpv5ufJiJN+yFfnQSCgr4XzZexG1KjgbKmAkUFr1OlU7BILJlUqgjMiecBGt/kZNoAD3ouNxt5fhuIKdIKmTjl7wTtBS0JxoA//Sn4KocmZWAuOmpvsZluVN8mGCnaEzndx6DSJ1E3vWxb0j/AzoLpHx6qJh2YsZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LL5V06nj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720811384; x=1752347384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=LL5V06njrFVHr5HI/t9E9+w47kFg8lqO0cFQpM3PEVGfa2XqpkydimFv
   mphhd0gcalpN1GZ8+dvMSsje4QGJGFnsAtl97lbVilOBt9qPAaImbjJZx
   1hkN2czuCQubq+PDr8mqeMOn2H9SV9VA8IOqv2RlLYO+J0S2A6Kn9anQW
   aYb3f9F6AQa03KTlI60LDX+GKfjgKWhFcbjZ5sOovEbXAQ48oX4db3hR8
   bAkYR9ab3jtfopf0IPwMHGeyx1T81bUOaTVqyiXkp8ltJc90totki2ySs
   1WT1wVfVJhZz76DsUMOHdYiu6IZE6OLGACkGlOpQ20ltk3uqtCjPeH3XA
   w==;
X-CSE-ConnectionGUID: qgdAaMwzToqgjOY5jCKS2g==
X-CSE-MsgGUID: /Mg3D5NjQMOkXvZm2RIPdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="43683019"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="43683019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:09:42 -0700
X-CSE-ConnectionGUID: lUKC+nv3QtiuKlBt5e1W/w==
X-CSE-MsgGUID: iJovl0PxQKm5hwig7zZ2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="54187433"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 12:09:42 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v17 2/8] perf data: Allow to use given fd in data->file.fd
Date: Fri, 12 Jul 2024 15:09:24 -0400
Message-ID: <20240712190932.417531-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712190932.417531-1-weilin.wang@intel.com>
References: <20240712190932.417531-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When in PIPE mode, allow to use fd dynamically opened and asigned to
data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..98661ede2a73 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
 				data->file.fd = fd;
 				data->use_stdio = false;
 			}
-		} else {
+
+		/*
+		 * When is_pipe and data->file.fd is given, use given fd
+		 * instead of STDIN_FILENO or STDOUT_FILENO
+		 */
+		} else if (data->file.fd <= 0) {
 			data->file.fd = fd;
 		}
 	}
-- 
2.43.0


