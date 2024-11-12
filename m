Return-Path: <linux-kernel+bounces-405358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD29C5047
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8922832C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C920B80A;
	Tue, 12 Nov 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1v8fEkO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67939207A14
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398757; cv=none; b=toMYJarRMuSbestW7mq3YLg5gYl4MVf7+oZdwDAzW61p+A1M+ers1GhVIeKHnj+dvqqtsbld9TTYDeEM54hkkNPjPzmw0PTMztmJtKoIkDLl9091rm90DWG//GFi7hvpuRmriHsPf7thsqX1A92mU2oMWI/1t3/P+/x915Ucco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398757; c=relaxed/simple;
	bh=vmAkt2ZZ6BNg5ABDBVXJNgptaSA3K/tNZrZjfpJB6Rw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DfhQxyS78B10HOFQePCP1EIcc2GZFGxizYZdxTISGYDnflbi9BGNSJP8hbhxc8URGjsNuRlKZZZ59fYnm5QFQASGVM9XJ7NYaNlRReeCWIfIoIvNlk45+tOJwQOAVXxbDkbJ6ln/Q9EAhkXzPCyjFyrHTtH5FZtkDNplYs0rjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1v8fEkO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731398755; x=1762934755;
  h=from:to:cc:subject:date:message-id;
  bh=vmAkt2ZZ6BNg5ABDBVXJNgptaSA3K/tNZrZjfpJB6Rw=;
  b=T1v8fEkOs6Cru9ORtfew4PxRxWatEfymDy6NeoCTopPUvijPlrd/Bp1W
   J3ymVM5a9HiCfmQiFsy5VS486xhUI1UFYfbZAyNd5KJGmVMDhfomwsoXB
   KulsLfs1fjS4ys8PfASYNim+tKQtKgt8iUTI5qTJ5CqQVgQ/ctlJywoVj
   V+3W3hTbdbud/933+tfW+XBBuJCbnoOjjk03DwPvxws+5yzeJ9RgY5HIo
   m1CDs0M93TIGFLPotr7uaJlZPlXz6u9bEhTjRUkBDTSNJTkCNgzIdhlVD
   lrmkUSIBjXAlz3UXLYFP7cnkjbgq89ELvx9+5sKYUsUknFX/WmcEtOlxn
   w==;
X-CSE-ConnectionGUID: Qq2s3N5ETXiVy+0rQ1g8aQ==
X-CSE-MsgGUID: +2MNU98ESKi0kXUxasVCsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41780914"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41780914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 00:05:44 -0800
X-CSE-ConnectionGUID: C/bRrsGiTxGFgih0m0v6Vg==
X-CSE-MsgGUID: rU41Me8lRG2pwYVJzIraqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92099302"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 00:05:42 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: ak@linux.intel.com,
	tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH 1/1] mce-inject: Add an MCE injection case with the yellow status set
Date: Tue, 12 Nov 2024 15:37:29 +0800
Message-Id: <20241112073729.66059-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Intel processors with the capability of 'threshold-based error status'
use tracking hardware to monitor corrected errors of certain hardware
components (e.g., CPU caches). If the tracking hardware overflows, a
'yellow' flag will be set in the MCI_STATUS[54:53] to indicate that
the corrected errors of the associated hardware component exceed the
predefined threshold. If so, then the system may need to be scheduled
for servicing within a few weeks.

Add an MCE injection case with the yellow status set to test whether the
events of threshold-based corrected errors are handled by Linux kernel
or/and the user-space tools like mcelog or rasdaemon.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 mce.h                 | 2 ++
 mce.lex               | 2 ++
 mce.y                 | 8 ++++----
 test/corrected-yellow | 4 ++++
 4 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 test/corrected-yellow

diff --git a/mce.h b/mce.h
index d941dce85326..b23232ec6273 100644
--- a/mce.h
+++ b/mce.h
@@ -15,6 +15,7 @@
 #define MCG_STATUS_EIPV  (1ULL<<1)   /* ip points to correct instruction */
 #define MCG_STATUS_MCIP  (1ULL<<2)   /* machine check in progress */
 #define MCG_STATUS_LMCES  (1ULL<<3)   /* local machine check exception signaled */
+#define MCG_STATUS_TES_P  (1ULL<<11)  /* Threshold-based error status supported */
 #define MCG_STATUS_SEAM_NR (1ULL<<12) /* SEAM NON-ROOT */
 
 #define MCI_STATUS_VAL   (1ULL<<63)  /* valid error */
@@ -26,6 +27,7 @@
 #define MCI_STATUS_PCC   (1ULL<<57)  /* processor context corrupt */
 #define MCI_STATUS_S	 (1ULL<<56)  /* Signaled machine check */
 #define MCI_STATUS_AR	 (1ULL<<55)  /* Action required */
+#define MCI_STATUS_TES_YELLOW (1ULL<<54)  /* Threshold-based errors above threshold */
 
 /* MISC register defines */
 #define MCM_ADDR_SEGOFF  0	/* segment offset */
diff --git a/mce.lex b/mce.lex
index 81e950c16cf6..5c8cd51d7109 100644
--- a/mce.lex
+++ b/mce.lex
@@ -96,6 +96,7 @@ static struct key {
 	KEYVAL(MCIP, MCG_STATUS_MCIP),
 	KEYVAL(LMCES, MCG_STATUS_LMCES),
 	KEYVAL(SEAM_NR, MCG_STATUS_SEAM_NR),
+	KEYVAL(TES_P, MCG_STATUS_TES_P),
 	KEYVAL(VAL, MCI_STATUS_VAL),
 	KEYVAL(OVER, MCI_STATUS_OVER),
 	KEYVAL(UC, MCI_STATUS_UC),
@@ -103,6 +104,7 @@ static struct key {
 	KEYVAL(PCC, MCI_STATUS_PCC),
 	KEYVAL(S, MCI_STATUS_S),
 	KEYVAL(AR, MCI_STATUS_AR),
+	KEYVAL(TES_YELLOW, MCI_STATUS_TES_YELLOW),
 	KEYVAL(UCNA, 0),
 	KEYVAL(SRAO, MCI_STATUS_S),
 	KEYVAL(SRAR, MCI_STATUS_S|MCI_STATUS_AR),
diff --git a/mce.y b/mce.y
index 90149e046589..9a28fa77a41b 100644
--- a/mce.y
+++ b/mce.y
@@ -49,8 +49,8 @@ static void init(void);
 %token SYMBOL
 %token MACHINE CHECK EXCEPTION
 
-%token RIPV EIPV MCIP LMCES SEAM_NR
-%token VAL OVER UC EN PCC S AR UCNA SRAO SRAR
+%token RIPV EIPV MCIP LMCES TES_P SEAM_NR
+%token VAL OVER UC EN PCC S AR TES_YELLOW UCNA SRAO SRAR
 
 %%
 
@@ -103,13 +103,13 @@ mcgstatus_list:  /* empty */ { $$ = 0; }
      | mcgstatus_list mcgstatus { $$ = $1 | $2; } 
      ;
 
-mcgstatus : RIPV | EIPV | MCIP | LMCES | SEAM_NR | NUMBER ;
+mcgstatus : RIPV | EIPV | MCIP | LMCES | TES_P | SEAM_NR | NUMBER ;
 
 status_list: 	 /* empty */ { $$ = 0; } 
      | status_list status { $$ = $1 | $2; } 
 
 status: UC | EN | VAL | OVER | PCC | NUMBER | CORRECTED | UNCORRECTED | 
-     FATAL | S | AR | UCNA | SRAO | SRAR
+     FATAL | S | AR | TES_YELLOW | UCNA | SRAO | SRAR
      ; 
 
 %% 
diff --git a/test/corrected-yellow b/test/corrected-yellow
new file mode 100644
index 000000000000..15c8374cc41b
--- /dev/null
+++ b/test/corrected-yellow
@@ -0,0 +1,4 @@
+# Log corrected errors with yellow status (corrected errors above the predefined threshold).
+CPU 0 BANK 3
+MCGSTATUS TES_P
+STATUS CORRECTED TES_YELLOW
-- 
2.17.1


