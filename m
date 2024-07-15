Return-Path: <linux-kernel+bounces-252387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620B93127A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45224B21872
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244B1891A3;
	Mon, 15 Jul 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="govAI4AB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A18188CDA;
	Mon, 15 Jul 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040074; cv=none; b=uzIm5Ldo6raWI4btPohqB/vDxAXlgo9BRAn8jgSwXbrscGhuAzBjdHn/XA28Bq6K6e127vAQxrkd3xKhGAApn9jY9/X+zmEtqydMTujbdlPS4Xq3eww3EjXXwvOQ4vtbV73Wb7oCYbU0neAivD5viAmGHwGhtA8drecvjwpWPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040074; c=relaxed/simple;
	bh=zBaf2cK0ZhM7ugTkfH69eGppJjdo2xu0C+QILoyxPK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WutX6Hk6uRAyXhFy7A7YytwhhAWd1DvbFwZ6M0jiny9samtjEJ6+JSdQh/de41fIFLszXnQiERsDJVvsqu8c3dqgIZs+TFad530/02/hPFWJ+u6rUlr2sCGHmZC1ASIyCMnQ7okriqIdJOnG3Sn6KuEVi8pTrJTbOdUVt47yCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=govAI4AB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721040073; x=1752576073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zBaf2cK0ZhM7ugTkfH69eGppJjdo2xu0C+QILoyxPK0=;
  b=govAI4AB55DdUF37Hp1as37IaNQ0m3HRgshghiKWiTo+JFucWQadit0b
   5SuO8aAXsHkGyyn8rSfUhl2uVJW1GtTWUEeLzH4+8UlgLSjO5hXzFGu9W
   fBB5U3u/AKzBpeQv+QCRYXc39B/7ChvLA6CcF9L9WQV4X+PyATBYgd6jL
   98l4qus6BNig+Ao3VtjhsRSBB65TrBO/AxCamIoV4XdEQ14i0qo4IN4un
   2E/RnBITAz6xj5asYKdW7+Jg4UL3wmJGkFh1Mhs0U91ibIHnWmDGlCeRz
   dIlRCilDaGINR/yiDG8NpHPNi0P1T4tEYFRLJ1nA2pefjwCHfhJDhqn9g
   Q==;
X-CSE-ConnectionGUID: tBrT/TojS1uPuE7dLmEWFQ==
X-CSE-MsgGUID: P0xtAXZUTkm4aoBpzAhw8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18279635"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18279635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:41:12 -0700
X-CSE-ConnectionGUID: TX7ZRgC1QCeuTSgpJeHD3g==
X-CSE-MsgGUID: ZiUCCAIcQZOCptoOxzhc/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="54118590"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.131])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:41:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/1] Docs/admin-guide: Remove pmf leftover reference from the index
Date: Mon, 15 Jul 2024 13:41:02 +0300
Message-Id: <20240715104102.4615-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pmf.rst was removed by the commit 2fd66f7d3b0d ("platform/x86/amd/pmf:
Remove update system state document") but the reference in the
admin-guide index remained in place which triggers this warning:

Documentation/admin-guide/index.rst:75: WARNING: toctree contains
reference to nonexisting document 'admin-guide/pmf'

Remove pmf also from the index to avoid the warning.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I'll put this patch into pdx86/for-next that introduces the problem
before making the PR to Linus.

 Documentation/admin-guide/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 32ea52f1d150..e85b1adf5908 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -121,7 +121,6 @@ configure specific aspects of kernel behavior to your liking.
    parport
    perf-security
    pm/index
-   pmf
    pnp
    rapidio
    RAS/index
-- 
2.39.2


