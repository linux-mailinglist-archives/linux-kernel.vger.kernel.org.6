Return-Path: <linux-kernel+bounces-337703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1C984DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B9B2854D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314761494DC;
	Tue, 24 Sep 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3tF4NI7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4C139590;
	Tue, 24 Sep 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217127; cv=none; b=MyWpj3hNd16UhqCeNFVUH6mhWK9CQDrUYsYCOLFt0kdeLkRf7RzRLs8hVZPHyBVf8GVk64uG2P2tRchp3uMhzJXqA0jrpySvh7mPhtODe/5/pOtSgb9wpa9KSl338if6K7eLhKoQCAn2JGr5QEvZ7Pzl2thKPcZJ8hPyUJjv8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217127; c=relaxed/simple;
	bh=Ly02WqJNxGTfZzM1lZ6NHErfasHJ2QD8n5ZRPITToHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAUUJD1g2pw/fivE+e1OKO1PjuE6CfMagYemSJEBpo66h6KSwHgTo3wvMh3mrGOaXncf2VATMEW8gCeTTkk7pms2HzSfmE7V1JXpHyTTc7dK4WLTLIRo0Y4irhbY6DelIDvx3l2eZAXrC3boY96Oj9bIBjZQTreeoi2mzqBWKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3tF4NI7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217126; x=1758753126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ly02WqJNxGTfZzM1lZ6NHErfasHJ2QD8n5ZRPITToHU=;
  b=g3tF4NI7Z+2M+afPINoVMAKSe3TvUKvUVgM93smWrDTlzaxamNKPtiUY
   xdfWiFdb7K8r1ntJp8HTR65flUN3o+cKyfQK6uVyBnITyvXYhvykx08In
   RqV0eMhzXa61pvneo5izcnuBkeB/YyfmTz5B6ADy1cKXbZj/kPTzjUQ/C
   WoMLwZ1xN4fOC7jA8KI3me5NCA63uMZR9GAwh4VSSvTl07QOsPyjZRgKA
   1b66z4UIYcFw7D7EOX0V6CYYunkbEZY4zP+awctXllH0zsUtpkocMk74W
   unOny6Y2yxDP8FireXA5+By0EDIivh3GqbrKrb2uCSCaD1rrat957bFAZ
   g==;
X-CSE-ConnectionGUID: V3iLP53mRBmvC7fXmtDdbw==
X-CSE-MsgGUID: lyhvvBQHRke6BPPeYhQY2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908027"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908027"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:51 -0700
X-CSE-ConnectionGUID: YMoINEzSRnSC7GW4UCWaUw==
X-CSE-MsgGUID: /8jAJD9gTLy1K+Zvq/vRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384747"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:49 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 0/6] VERW based clean-up
Date: Tue, 24 Sep 2024 15:31:34 -0700
Message-Id: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several mitigations that use the VERW instruction to
clean up internal CPU buffers.  Currently, each of these mitigations is
treated independently, but if VERW is needed for one of the
mitigations, it's on for all of them. This can lead to some confusion
if a user tries to disable one of the mitigations, but it is left
enabled for one of the others. The user would have to disable all 4
VERW based mitigations.  This series aims to make it easier for the
end user to disable VERW based mitigations by introducing a single
parameter to control all of them. This makes the individual parameters
redundant, so they are removed. It may be desirable to keep the old
individual parameters for the sake of backwards compatibility.

Daniel Sneddon (6):
  x86/bugs: Create single parameter for VERW based mitigations
  x86/bugs: Remove MDS command line
  x86/bugs: Remove TAA kernel parameter.
  x86/bugs: Remove MMIO kernel parameter
  x86/bugs: Remove RFDS kernel parameter.
  x86/bugs: Clean-up verw mitigations

 .../admin-guide/kernel-parameters.txt         | 143 +--------
 arch/x86/kernel/cpu/bugs.c                    | 287 +++++++-----------
 2 files changed, 118 insertions(+), 312 deletions(-)

-- 
2.25.1


