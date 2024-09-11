Return-Path: <linux-kernel+bounces-324146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40D974869
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF065288217
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071572A1A4;
	Wed, 11 Sep 2024 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbYt+3jr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D07B676
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023759; cv=none; b=SMwdwhBfRvqcDEHk6rkTHWKSb0Bn4NWksI5VQAEOwmPRotm0iVkgd88uoGYCxiXDvQdHpB8NM8hhQlAItTnM5qnDyw9IlSUcm8blB80uDZ7T8sm7FwWMps6dZFRQ4gNeOxT3hGXD98KH+xupB79N6QWntXAcBvOhwVpYdw1v9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023759; c=relaxed/simple;
	bh=Vel7AbFBzj78i/iHwdB+beI0cNjDQNzO/uiGE/5W2ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qMr2HlSJovB0aY/i6nMBv9cnZXxWrDg0svgBga8cG1Gc/gbhMJLSyjXmu5CLn8RUnizXMlUDwJ/id98gju8OoosSDKHF/wWBqL1c439DdfXVBMQm3BcSseqhnSRVhndoYkakxv6uc9Cd1VGM1ni5e+2datxUpLBGu6gVfqkW7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbYt+3jr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726023758; x=1757559758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vel7AbFBzj78i/iHwdB+beI0cNjDQNzO/uiGE/5W2ig=;
  b=PbYt+3jr6il+EElR4Ny4sZAMWoUv0X1KbnMvQEk4prGm1nYqrhd4Cnhi
   wfmlpV4yEd2WAazYIJynuRdeYvgpZ1CW9XpX4ZTM6CRxDmR4qelCOXHao
   JsYAd7v0jwp548Zh++r051zBNMvcSDgr6B65whQhxdjW2+sYmal5kib3q
   TpeGqkZlkhMaBRaQzHh5E/LOAA+c3WQQflbCy9OowGXK1DaOzQhzHpOS3
   ciundhE82fJfz8LW8GIYcQedaDr0suCmD4exmigxWGakOeAWxpC3JeEm+
   KGes3F/fm2fA8J+vVDHn5JcMBtEOi81KbRU79QMzQZ5F9izeZIgRWgAqR
   A==;
X-CSE-ConnectionGUID: lyq96khlR3WhYPq4vnq9ug==
X-CSE-MsgGUID: R7Aqkm7CRuqjR++9KgBVIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24907777"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24907777"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 20:02:37 -0700
X-CSE-ConnectionGUID: yvGIAWXRRW2SWjxt5lpXWQ==
X-CSE-MsgGUID: hN78Q4b9The/fWp3x5d+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67732254"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 20:02:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	simona.vetter@ffwll.ch,
	Philip.Yang@amd.com,
	akpm@linux-foundation.org,
	felix.kuehling@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 0/1] Fix device private page livelock on CPU fault
Date: Tue, 10 Sep 2024 20:03:36 -0700
Message-Id: <20240911030337.870160-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch should explain the issue thoroughly.

It would be helpful if AMD could test this patch with their SVM
implementation and see if any issues arise.

Matt

Matthew Brost (1):
  mm/migrate: Trylock device page in do_swap_page

 mm/memory.c         | 13 +++++++---
 mm/migrate_device.c | 60 +++++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 23 deletions(-)

-- 
2.34.1


