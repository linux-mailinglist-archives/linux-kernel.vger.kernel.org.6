Return-Path: <linux-kernel+bounces-292057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47750956AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02752281719
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F316A940;
	Mon, 19 Aug 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEkuf8IZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515716132E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070087; cv=none; b=s4/+nWZqKjSNJapY4t29onQb0TUzcwVP6MiOWH9KIOl8j0RIfGtvKMfh3z6SCDjmJx5Ogzirq/s44swof/fL1W/wSEgF2FCmLvmxy32D6NWfZzrc3/CmjP7aNXtoRnQLcG1AFkcs6IP+OymGXnUtuv7DXtKZ/axBvk7ORhvhzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070087; c=relaxed/simple;
	bh=DdabAVvuZYhbjPooND4EaQbuaT4cUuU7h0KcGdPimcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOli/QxhMQk/LmllQ5lG78a4ouf+ITgzmc224HEH2GsbjBapLDlrlf4Qay6B7VZAW0/6gDPeywj6s0JReFaE03XVaRDhGZ0uU9eXCIyuk+c09oymory3tc5jjJ/HLHMQzb0wFAVNxrhC1zWowAV2wqNdy1jzrq60L7zp9IcX2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEkuf8IZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724070086; x=1755606086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DdabAVvuZYhbjPooND4EaQbuaT4cUuU7h0KcGdPimcE=;
  b=OEkuf8IZDeRRXIPnMlArgUjO1argpXMibXJJHqZc84jx/063X+t25TgU
   dpb6yu+rN2hKaqOe/bxpgOOrS79pNeUzurv2BOy62axiCe8VslpsZNH/S
   uLYC9XgwFMAMEVdyNtzj1SgRDoWotTfkEdBNy9hg/WZ/aVqC5eQHwBC2u
   VJlzoCyX8LM+wyv7xgHOoqviUTMQ/sF2JOFkK1GGqYACqo1uUTIbYsSD5
   wASoxTOL/iWfEdfMQfab40RgY93D9wxajIzIKMcop7doBctSbll0XrvR2
   w1tcb8Ic0pj5cgMJK1Dk1ngOU6B28eu+bTj6UeuD2FgpV9ORwk/f+oa/n
   w==;
X-CSE-ConnectionGUID: q4ywPe7FRriGEZPmuzmWhw==
X-CSE-MsgGUID: w4MErtCtQ9Gb4QpPj/X4Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39773631"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="39773631"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:26 -0700
X-CSE-ConnectionGUID: 0fiaUc0/RVSHOjjk93D6hg==
X-CSE-MsgGUID: X3oz4hdES6G70ZiGIK6dNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60658820"
Received: from tfalcon-desk.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.124])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:23 -0700
From: Kai Huang <kai.huang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	peterz@infradead.org
Cc: kirill.shutemov@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH 0/2] Misc comments fixup in relocate_kernel_64.S
Date: Tue, 20 Aug 2024 00:21:10 +1200
Message-ID: <cover.1724068916.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assembly code of relcocate_kernel() takes some time to follow for
newbies like me.  This series adds some comments to try to improve the
readability hoping they could be helpful to others too.  Also fix an
error (IIUC) in one comment.

Kai Huang (2):
  x86/kexec: Fix a comment of swap_pages() assembly
  x86/kexec: Add comments around swap_pages() assembly to improve
    readability

 arch/x86/kernel/relocate_kernel_64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: b8c7cbc324dc17b9e42379b42603613580bec2d8
-- 
2.45.2


