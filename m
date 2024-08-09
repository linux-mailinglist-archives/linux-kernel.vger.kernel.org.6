Return-Path: <linux-kernel+bounces-280914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB994D0D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEE1F21555
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D5194C62;
	Fri,  9 Aug 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc56MrNu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8611194A5A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208970; cv=none; b=CYk9WhTW1JX2sn2Beui9Y0nNaj+woAtfPGCqD6PgPg1UxpQIx19fkD3eQsXvXwxTn5NsOhogdAq68+gpoRQiHB2ussZZy6Vpd21jul+rf+CKEHSRLqfFVP6EvEi9VaUXF1RZLIwWn6nMexKYp//uYs3IGwi3bwWGFfuzmMcuxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208970; c=relaxed/simple;
	bh=PP8o0uXQr0k92CCJidXH4v3wHNxcydeY2QrhZ93Y2Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gl1rBOPoDjodvKkfBwASXa3xhZ0+6OgYu0By9VnFs4YJE6bSkc3ZBTrjj9p8Q3TN3FtX8K+TbQaw309C7jWWJXqZoZEcwM6TqB0TlDwQw9W3VJWn5vgRLN9ILvThOHfV32mBZxmlUE8uD6Z+4v4oin3AoiI3kzx9lYtDNhN/sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc56MrNu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723208969; x=1754744969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PP8o0uXQr0k92CCJidXH4v3wHNxcydeY2QrhZ93Y2Fw=;
  b=Rc56MrNubpVkY9OHosQpqrhiYsVNqcIvF7DoJBCph1JZIVR3y9WpF6Hj
   ABTKxItV4llTjwAPJvkSDd0OubORFKFMU4gBp0xBtOP6F002Zmf769Jru
   0g4ZlrpO6t+/HFZphMig1QYbcjZ6n4iKhrh41eUyjSjGH008jXeYH37GT
   ROFglhYBEdFrIK7wwtbovuUQqgEkwF0Pwr/VicoDYKq9ZI+M/CoYR+h1d
   AW7aw3k3BAPqunqrpZglbakqbfUyszH5kbgiwKJU4MOIPfHnx9ZAt0TcE
   sTAuyPjwC9A6fXdbETnr3tkdqkAT0Hr0BBoHTeMMIzMKjuJl+bqS4RODE
   Q==;
X-CSE-ConnectionGUID: 5OmX7DYhRbq2NDlF3LWTUA==
X-CSE-MsgGUID: +vS9ZQPhSHyKu1FiivU3Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46788160"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="46788160"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:09:28 -0700
X-CSE-ConnectionGUID: +Sb1hv8/QfWFD6q+tpr6zA==
X-CSE-MsgGUID: Kv7oy5IZQjmyXreJVMdOVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57651636"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 09 Aug 2024 06:09:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F177F597; Fri, 09 Aug 2024 16:09:24 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHv5, REBASED 0/4] x86/tdx: Adjust TD settings on boot
Date: Fri,  9 Aug 2024 16:09:19 +0300
Message-ID: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adjusts a few TD settings on boot for the optimal functioning
of the system:

  - Disable EPT violation #VE on private memory if TD can control it

    The newer TDX module allows the guest to control whether it wants to
    see #VE on EPT violation on private memory. The Linux kernel does not
    want such #VEs and needs to disable them.

  - Enable virtualization of topology-related CPUID leafs X2APIC_APICID MSR;

    The ENUM_TOPOLOGY feature allows the VMM to provide topology
    information to the guest. Enabling the feature eliminates
    topology-related #VEs: the TDX module virtualizes accesses to the
    CPUID leafs and the MSR.

    It allows TDX guest to run with non-trivial topology configuration.

v5:
 - Rebased to current tip tree;
v4:
 - Drop unnecessary enumeration;
 - Drop TDG.SYS.RD wrapper;
 - CC stable@ for SEPT disable patch;
 - Update commit messages;
v3:
  - Update commit messages;
  - Rework patches 3/4 and 4/4;
v2:
  - Rebased;
  - Allow write to TDCS_TD_CTLS to fail;
  - Adjust commit messages;
Kirill A. Shutemov (4):
  x86/tdx: Introduce wrappers to read and write TD metadata
  x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
  x86/tdx: Dynamically disable SEPT violations from causing #VEs
  x86/tdx: Enable CPU topology enumeration

 arch/x86/coco/tdx/tdx.c           | 140 +++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  13 ++-
 2 files changed, 130 insertions(+), 23 deletions(-)

-- 
2.43.0


