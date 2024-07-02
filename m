Return-Path: <linux-kernel+bounces-238184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94D92468F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AE91F22D34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415891BE86C;
	Tue,  2 Jul 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PthV+pGd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B51BE221
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941909; cv=none; b=BoI8G20zo7edHyCumtPJV+PZKGsmexLruEuVyQTBjUJoui2Zld4AKmPnbn4+RgCboeW3ViJsxQP/ctEBeIeyKoBsmZD76lzteB4jrHNUlRe0NpsEQO0pvtSHvDoWUX3yQ84iOViH2HKHqctscHPnsrqDIP9TTM/tijm3ppIyqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941909; c=relaxed/simple;
	bh=nL/XdwhX9E7qRbLS5CsW7lSGH7ty9mBabOAor4i/2sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJZFbCu2+lbWcmJE1MH+0DArZkUGVi1PR8Y/7SavLJ4lHAE48J3+9pDgqXqa/tdAi29ls2HvfM750LVdqS7758hql7O3AfIwmu5pqmZD/s4smJjwhYZksuyKuCq7IuqR/fZV1PeM/cNHO7MJBwtM1uD6Ry+nNzBzDTPlD3xoG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PthV+pGd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719941908; x=1751477908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nL/XdwhX9E7qRbLS5CsW7lSGH7ty9mBabOAor4i/2sc=;
  b=PthV+pGdNJoxGidZA3B5AVBAHg8sAxYYs9Nvafr58JTOLuKsubfySgoF
   X8q8nBG8ByMYii6VZX8M97dzfWHZURKnDhEsyZpj/XTQKOe9QYw4TrzLR
   aiWpB5Ba7M1OUHZDKRffJ3FWbrK/oOIeP5nXv48mOsrJp8TuBENI/fGYI
   ZVXHKqRJP2ZzVc9pmY0QcdQqbM5d+DA43NySd6gcVe/nwNxUQ5KvB/mx3
   UJzS9C7h8E6jOryg0cfELkHWL3jorA5OW2k0GUjqU9zYqPKKb7cgIKkot
   GOSL5Q7Sbo5jVP555XQn3L0cuEedOzBvquvs/MvANA7+7rZuTzjg4FolT
   Q==;
X-CSE-ConnectionGUID: du6hYIZ3SSicE+xEikSCQQ==
X-CSE-MsgGUID: AWMNzsiaS6K1ebhgaOfc5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20035374"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20035374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:38:27 -0700
X-CSE-ConnectionGUID: ljs7X7ZvQTazXCaxD4otgg==
X-CSE-MsgGUID: Tm2tqPJ6RBKi1waaGe8kyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45836594"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:38:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH parts 14, 17] Add support for Sub-NUMA cluster (SNC) systems
Date: Tue,  2 Jul 2024 10:38:18 -0700
Message-ID: <20240702173820.90368-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updated parts 14 & 17 addressing Boris' comments on v23 of this
series:
Link: https://lore.kernel.org/all/20240628215619.76401-1-tony.luck@intel.com/

Signed-off-by: Tony Luck <tony.luck@intel.com>


Tony Luck (19):
  x86/resctrl: Handle removing directories in Sub-NUMA Cluster (SNC)
    mode
  x86/resctrl: Enable shared RMID mode on Sub-NUMA Cluster (SNC) systems

