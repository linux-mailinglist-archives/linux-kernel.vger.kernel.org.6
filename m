Return-Path: <linux-kernel+bounces-379885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E249AE580
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249801C21988
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47161D517E;
	Thu, 24 Oct 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyIDBLxt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186961D514C;
	Thu, 24 Oct 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774859; cv=none; b=Y3M1gvep2o5OmrZYuN4xILpJojVbm7OV44lHpSHSLpiN4zZVx9eO6YWXRg7kvFyhUgLLBkiEMLU6GzvqaBjgLjUHhPKUHxFqOAbx3yyVnp114cN4kU6CiQEz2Gyul+WW592mva4lTQRVQgOysG9ef6nd0E2+Mx2KOw0l/MPZG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774859; c=relaxed/simple;
	bh=KqGf1sgWq73SVzkXhBsxSdnJ5RxsROkgNjzFTPC8Sa0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DyQne8GPS1ROb4EejAO0slsTlm1GSyEYNxOVgCkQ6vHE5YVYLK+IUyZ7tiXxC6IbuVAwtolMiCA/p2KxMim7zSf4OugjQ0okhcvnIzwIksvEkYT1MtpOtj5wCetJbSx69ziCKOenCrj7kM+vnrwoom46Lv1rUCRRnIz5liY32vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyIDBLxt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729774857; x=1761310857;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KqGf1sgWq73SVzkXhBsxSdnJ5RxsROkgNjzFTPC8Sa0=;
  b=kyIDBLxtRhCfjoqA2rTawlMCoz72VOp/3HYs+FNeB91tnSxtVCoIOaiF
   f37YUiR5uGxcZaWhAabO94s4kq3WFIL2A9+dknexHPDidlWlmlfxy5SIF
   ds7ehi8RBxImofoNHKU1gj5/KQrTikdB86jM/n3dk167cnESXFKLfybbw
   4aYfJFN/OFwQfR+6+bsqPqeXbeVpH846tARoEMeGz/qEHqpzZrZNbeRED
   Dlz6J/POLA9m77ZOhQNgwvSu8aXv9aZL1toEB6I2bklHrGnya8ljXyuK5
   0wwr5dZ2NfKgtMzq8eDzlDdE+83Vt2/iuodTcVKJuH/5w5DNvSZVL2Aue
   w==;
X-CSE-ConnectionGUID: fNjF0en/QMKnq+jyzp9hmA==
X-CSE-MsgGUID: zK0BxfGeTVi3gd9F8i/j0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33094655"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33094655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:00:56 -0700
X-CSE-ConnectionGUID: srOYIqpMQJWMyc3AqU6puQ==
X-CSE-MsgGUID: IvpvS1FBTFGnJdwpyU+KPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80569541"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:00:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Suma Hegde <suma.hegde@amd.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation/x86/amd/hsmp: Fix ACPI dump formatting
Date: Thu, 24 Oct 2024 16:00:46 +0300
Message-Id: <20241024130046.31753-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hsmp documentation added into pdx86 for-next branch triggers these
error:

86: ERROR: Unexpected indentation.
87: WARNING: Block quote ends without a blank line; unexpected unindent.
90: ERROR: Unexpected indentation.
91: WARNING: Block quote ends without a blank line; unexpected unindent.
94: ERROR: Unexpected indentation.
96: ERROR: Unexpected indentation.
97: WARNING: Block quote ends without a blank line; unexpected unindent.
100: ERROR: Unexpected indentation.
101: WARNING: Block quote ends without a blank line; unexpected unindent.
102: WARNING: Block quote ends without a blank line; unexpected unindent.
105: ERROR: Unexpected indentation.
107: ERROR: Unexpected indentation.
109: WARNING: Block quote ends without a blank line; unexpected unindent.
112: ERROR: Unexpected indentation.
115: WARNING: Block quote ends without a blank line; unexpected unindent.
116: WARNING: Block quote ends without a blank line; unexpected unindent.
117: WARNING: Definition list ends without a blank line; unexpected unindent.

Convert the problematic ACPI dump fragment to use preformatted text.

My plan is to fold this commit into the original commit.

Fixes: f9ad7a2843a6 ("platform/x86/amd/hsmp: Create separate ACPI, plat and common drivers")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/arch/x86/amd_hsmp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/amd_hsmp.rst b/Documentation/arch/x86/amd_hsmp.rst
index abf1fa3230d9..2fd917638e42 100644
--- a/Documentation/arch/x86/amd_hsmp.rst
+++ b/Documentation/arch/x86/amd_hsmp.rst
@@ -74,9 +74,9 @@ The same is defined in the amd_hsmp.h header.
 ACPI device object format
 =========================
 The ACPI object format expected from the amd_hsmp driver
-for socket with ID00 is given below.
+for socket with ID00 is given below::
 
-Device(HSMP)
+  Device(HSMP)
 		{
 			Name(_HID, "AMDI0097")
 			Name(_UID, "ID00")
-- 
2.39.5


