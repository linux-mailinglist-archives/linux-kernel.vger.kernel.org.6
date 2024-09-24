Return-Path: <linux-kernel+bounces-337435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDCC984A16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC0EB21707
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7445023;
	Tue, 24 Sep 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXb1Mvxc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3C2941B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197325; cv=none; b=Xi82GkHFvNanbgqb+wDzSt4hdniR1v296kv5v6XaZomro7Ey12ei5xGa2YKBLhPE/t4VE+C6kZLNdu9yxURZNz/hhuRU2VzVa2dwwCfmguI5DPIgyLvpDItN6BhsZlQCKzgGBYCXSlHRmwWToCad6w5cibDNHn1rKXG8MyV+ZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197325; c=relaxed/simple;
	bh=TTgWOKKY7ntpULN3jm2at7jE9jzdtocArhFKV1H8E1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLtqbIx3NpMXXqbujp5QLnSt+/rfo6dzuxfcFDhj5/12yVGm5omZgnaaDy+kfIw/dc+4ev0qE9TiY7MspzWbXjGu14GjSxlk1zF0is2NOfoqdO4kXVbNcDSTRXURX1QxMmP/sxrKSXIywWfRMAd3VgW7Tt5z1feuz517eN+pRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXb1Mvxc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727197324; x=1758733324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TTgWOKKY7ntpULN3jm2at7jE9jzdtocArhFKV1H8E1A=;
  b=RXb1MvxcCsBRW5SmAuad/CRsP2hn6qg5XJrQQHqDaZ7RNZUlXjlhXA+Z
   J3uGw8IZEWE8RRyepdaiWzBuVMKqWvlZdfDPtMgcp/usGBO/rbQnRMBbK
   33pIfVdeyvzJyl3X7/ZDpbWvcQ9SVq1ypWcAZKJcr4miCjMo6VdUnt0vW
   gLc2mqfOqckXZ4ynBh0FBdY5O8+iCP8/uhcB8lJFJy3TCKqJB/hJoKS3C
   A0QsI2+fyK7apz7tTqLEHoCSgGCFlsDa9ynM4NuaZfMtcXAX3iXPPATH7
   kElwwUshFkz5WpBzbmG3OH2qcPnd8jOI+v0AzrKRTGru3Ovt3MODUt5YW
   A==;
X-CSE-ConnectionGUID: vdnIVoFmQBqS2xC9tpiKQw==
X-CSE-MsgGUID: 2dbNpmYpSuK3JPv/R3dAPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25718268"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25718268"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:01:40 -0700
X-CSE-ConnectionGUID: x30tR19QTgicubXDTQ5TjA==
X-CSE-MsgGUID: 0XwcF9dMQBWcnQlwBd1oOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="108944270"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:01:38 -0700
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1] x86/cpuid: Add AMX and SPEC_CTRL dependencies
Date: Tue, 24 Sep 2024 10:01:28 -0700
Message-ID: <20240924170128.2611854-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some missing dependencies to the CPUID dependency table.

All the AMX features depend on AMX_TILE.
All the SPEC_CTRL features depend on SPEC_CTRL.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd84114c2d9..15c5ad01d1e2 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -83,6 +83,10 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_AMX_FP16,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
 	{}
 };
 
-- 
2.46.1


