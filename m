Return-Path: <linux-kernel+bounces-368574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067F9A1184
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453DC28839E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CC2144A5;
	Wed, 16 Oct 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxKECxz0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017B212F19
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103208; cv=none; b=OJF2OfhQjUxmVxqPulJv/k7wVs2l4T8pS0xKOxZJ4FK4XtpCxi2ZiJFVO+1aumUAV7iZxwrA/k8SYISHo5Fzrjru4MkGfJCkxuzlkd8ufuP/H5ireaeETQz4b1HpOqcPHp6RwOV5mbMFYTc7KdFV2upmAkTYKFxzWsw5qrztb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103208; c=relaxed/simple;
	bh=Y1pvPzSz6TtO0NwNOIptufkDVrOTI5EKhsiPz7J6yYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOBurDxQL3+aE1KHZExVs15uq8qYzCZlf8ZEBkEXi9fsfCmEJAAmRypSJmMEhAM7yFdwBIovJ3u78ndIoKUxoRnVxtz1l0bqtCUm/XAnTdMaCM66j37uayTHe3I2tVtBp9o1T8w7wQliNwsHBvabVBYjDl18esULLrrSKooMwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxKECxz0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729103207; x=1760639207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1pvPzSz6TtO0NwNOIptufkDVrOTI5EKhsiPz7J6yYM=;
  b=PxKECxz0GFG5PpDCa/nmVkhyFViFn5QIt8MJYwYGRP4Xu1UVWKy4i+ld
   Aof4HhiHVsJRW3UQ2JfRSq02i1ow30B+jTZHAfDkJAy2TMz8CrLwXcwG+
   /MxHzMDZ6oDHvaoTAaXOFaKluqyvjfUKDb+k3zfJ4C/U2/TXYGCR+0iv6
   U4q/BG8tccHGVEkxIlh+O0DEDQONKrS1N+uXfU6IsdW7E8JDFI3IW4/iS
   ye37t/lGfbip/o3jsttlEC7txE3i+fxGqhQ8XkfEbApL0ib0jXfLuO44j
   5T3OiDH52N+0MdwkGpEUrwGrVoil/vZ5UYl1CI4OreaINnPj5G48EdcDm
   A==;
X-CSE-ConnectionGUID: 2un4l6/NS063sYYi2k3vuA==
X-CSE-MsgGUID: +nutd58cRP+fB31f3qD3ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39686006"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39686006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:26:43 -0700
X-CSE-ConnectionGUID: MK97uBo5Tn+tcSA03kCSRw==
X-CSE-MsgGUID: gIKrOOOwSb2pvAmcsBYolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78269523"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2024 11:26:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6A6CE159; Wed, 16 Oct 2024 21:26:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] x86/percpu: Fix clang warning when dealing with unsigned types
Date: Wed, 16 Oct 2024 21:23:51 +0300
Message-ID: <20241016182635.1156168-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016182635.1156168-1-andriy.shevchenko@linux.intel.com>
References: <20241016182635.1156168-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When percpu_add_op() is used with an unsigned argument, it prevents
kernel builds with clang, `make W=1` and CONFIG_WERROR=y:

net/ipv4/tcp_output.c:187:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  187 |                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  188 |                               tp->compressed_ack);
      |                               ~~~~~~~~~~~~~~~~~~~
...
arch/x86/include/asm/percpu.h:238:31: note: expanded from macro 'percpu_add_op'
  238 |                               ((val) == 1 || (val) == -1)) ?            \
      |                                              ~~~~~ ^  ~~

Fix this by casting -1 to the type of the parameter and then compare.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/percpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..e525cd85f999 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -234,9 +234,10 @@ do {									\
  */
 #define percpu_add_op(size, qual, var, val)				\
 do {									\
-	const int pao_ID__ = (__builtin_constant_p(val) &&		\
-			      ((val) == 1 || (val) == -1)) ?		\
-				(int)(val) : 0;				\
+	const int pao_ID__ =						\
+		(__builtin_constant_p(val) &&				\
+			((val) == 1 ||					\
+			 (val) == (typeof(val))-1)) ? (int)(val) : 0;	\
 									\
 	if (0) {							\
 		typeof(var) pao_tmp__;					\
-- 
2.43.0.rc1.1336.g36b5255a03ac


