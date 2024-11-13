Return-Path: <linux-kernel+bounces-407519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A99C6E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045AA281042
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935512038DB;
	Wed, 13 Nov 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MV1v+/8s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3B200CA7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499075; cv=none; b=CJYXyxItzQ13anRmt3IHLQjUPIOJGk5LwEgUmuYWn5qTyRJdVPWOFpq/B7X6LrGN14bIwOyBynOVxjRCwk26NDVTcK3BEQbG7v206+8XQ3w5zKf1kkaSaQ9lJudyCio3bByZKNDjAMwSzq90tC5m80wHRPl6Wim02HuOjHmq778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499075; c=relaxed/simple;
	bh=l/tx6drXiAgelgHqBNwM3hv3iSO7tz9rpGpCDs4Ltsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9oR2+av+I1aEcg+QuUS5tCYM9JrPC9kdM+kzGm8hxce9TYmyG970XaBstCwnBUAOQW9GUuxE5uv1g2A70wX4y31MKH0gB6AXWXceQuaNEBRfcntGBbxY64Rsu68XN8ZxmuZvTbZexvk8atMeFKn2DZFoUU/1wJf9vuCqQQDJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MV1v+/8s; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499074; x=1763035074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/tx6drXiAgelgHqBNwM3hv3iSO7tz9rpGpCDs4Ltsc=;
  b=MV1v+/8sliVc53AVAkb3X08gltMxgs4jZXw82GCQ20aRo2yyviWNW8hg
   MRmbKGm6YWH+RzsshAnN1UddyO2ECUhNhDMWijre/8jDbWDq/4SNdn4hg
   VuhDUikZfu0zJdTiK5DuU/6e3evB0y+Nwd6UHTBIv67AnL8Qa5UFOVK6v
   sBqduMeJGHWRSCsdwIPHPRsae+Hz7COocODdZkzAzpHl7eULgf230Bpvy
   F4dmJcfvZjd0vtqFiknbRzuEwiXAi8JvaJVT5RD45JTLfuH/MKgYjwhlo
   pzulTM+7CQ966mlbzCJq2ZPhbamFYRWPyHO5OKMOB47E2evH09UjHtJML
   w==;
X-CSE-ConnectionGUID: ON3jc4FoSOOPEXqQRJwQow==
X-CSE-MsgGUID: 1efY4bH3TVmG+zsij0dQrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630812"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630812"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:45 -0800
X-CSE-ConnectionGUID: 7973An+fSo2SKy8dKxAJIQ==
X-CSE-MsgGUID: AdKnvNkQRX2DVFH8mk/pTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323546"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:41 -0800
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	dan.j.williams@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	adrian.hunter@intel.com,
	nik.borisov@suse.com,
	kai.huang@intel.com
Subject: [PATCH v8 5/9] x86/virt/tdx: Add missing header file inclusion to local tdx.h
Date: Thu, 14 Nov 2024 00:57:10 +1300
Message-ID: <c839c8b33ec6396d9ff6a299f6eada7f6c6ce111.1731498635.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1731498635.git.kai.huang@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler attributes __packed and __aligned, and DECLARE_FLEX_ARRAY() are
currently used in arch/x86/virt/vmx/tdx/tdx.h, but the relevant headers
are not included explicitly.

There's no build issue in the current code since this "tdx.h" is only
included by arch/x86/virt/vmx/tdx/tdx.c and it includes bunch of other
<linux/xxx.h> before including "tdx.h".  But for the better explicitly
include the relevant headers to "tdx.h".  Also include <linux/types.h>
for basic variable types like u16.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index ec879d54eb5c..b1d705c3ab2a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,9 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/types.h>
+#include <linux/compiler_attributes.h>
+#include <linux/stddef.h>
 #include <linux/bits.h>
 
 /*
-- 
2.46.2


