Return-Path: <linux-kernel+bounces-424865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655819DBA76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4161642CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7E1BAEDC;
	Thu, 28 Nov 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBX07XQr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81172847B;
	Thu, 28 Nov 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807561; cv=none; b=VZ65j4zMAkH3IP//y3egyuwZvevTU4/a+eG8GHjx9wQNhovHsb922ataQyXjS8k0MsueD4i6wR/ilat9ZJR6JZCT54iCUFDIVYhRp7WzJzKr+vF/shnHBFk7VCvn7lOL3NEzuxSk/PMakpqnAy/FuCq37CaGwhkwLu0sTXK8KOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807561; c=relaxed/simple;
	bh=WwwOsD1I9iOK/UnkE6OYjg3rpCKYQMyHP/d4ocpEP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2UzTLkrDHqLOQy+Un2K3q99WOPNMBcnnyYZQYNnQzxC/lc05XYKc13oHF/LuR4eejcMKGcjKj+4NnuF8eeJlTB4OqHWDC5yH/sptm2Uho/97KXfmk58TD1zB+KBHcRnFGiFii5xyFfH3od0YELhJjElMRY0zObnNjtBwpt45LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBX07XQr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732807560; x=1764343560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WwwOsD1I9iOK/UnkE6OYjg3rpCKYQMyHP/d4ocpEP2w=;
  b=HBX07XQrcPC91QkJ9XLYczCSiGt2Ayvvb1jhrXGetSQqntyEzsz+o8lu
   LLAjGwPJqfZjVaFKkya5jZtRWaB4uZymXkoAYVxqKSp2ISNLtphwmex4x
   93DgbQTzWYLrfIXjFwJtrJLENJTeJ1W8elvXWZIPEPkGY2zTaX9huEauR
   rEESzq8/WS+1HOujBBD8j0THzyVdJMHEmuWNuL0Lmudi1it4pfG/pBxnb
   /JLopZV1fWB+KbIWJ5zGWlcNuxhkt9JGYuNTHK2Gfyc8kM1Gbgx6rdfZ6
   F1Uxv5aLYV8g0gDbQloXvAxM88tnp1BtjdG2fY8Oc06ezVjIxD+uqrtFa
   g==;
X-CSE-ConnectionGUID: Bd8TB8/KTtez9I176bVx/w==
X-CSE-MsgGUID: wx+MzW7YQX2npUL3M0gN0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43711926"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="43711926"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:25:55 -0800
X-CSE-ConnectionGUID: 0CEig2qUTnW5p/HIqwPkIg==
X-CSE-MsgGUID: Ta4Yl98oRPCi6BV/B3znlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="123119561"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Nov 2024 07:25:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 81A1A35B; Thu, 28 Nov 2024 17:25:50 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 0/3] x86/Documentation: boot.rst: More style &format fixes
Date: Thu, 28 Nov 2024 17:23:37 +0200
Message-ID: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boot.rst is combined from the pieces of different epochs, hence has
some inconsistencies in style and format. Fix (some of) them in this
mini-series. Rendered result has been manually checked for PDF and HTML.

Andy Shevchenko (3):
  x86/Documentation: Make Literal Blocks to follow reStructuredText
    specification
  x86/Documentation: Align Note Blocks style
  x86/Documentation: Elaborate Intel MID device list

 Documentation/arch/x86/boot.rst | 369 ++++++++++++++++----------------
 1 file changed, 184 insertions(+), 185 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


