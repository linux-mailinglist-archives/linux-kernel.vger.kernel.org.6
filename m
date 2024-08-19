Return-Path: <linux-kernel+bounces-291635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD79564FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED581F243CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD11158A37;
	Mon, 19 Aug 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCGLuEMD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC101591E0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053792; cv=none; b=DJ9XUwBIRJHh+qecWE/0HCJBZkwfJDthWBIbmwTiAla768VyRQsFICB9u+rAlXkp2z2+jc8jsPbW/V5w0CDmvbRzGmn+a632qZjALL5YUDyhKMjSKgb59h+JFzfk7OfMhk1oJzNmgCV+xZ7FA+7NjkPFbim7iTACpiyOQPT1pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053792; c=relaxed/simple;
	bh=yXQfw5kmxH3xe2BtoM8uVeAphbxlIG0RJ6yArJxRlME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsm9gzU1E8fTFvpEY4sao+H8NvvxTe4JSnEDHbkvxLdN9OrjkyOk4Lda5bJcEqbx/EREN+WLpBQJKvT9cFTaln60HvT86zok8A3xASpqogo2Jmk6xao/DWNnywrZaN9hPG07Okm0EmB0jfIsmKvxPgNYKOLr5ZXhH4fK3/IQ6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCGLuEMD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724053791; x=1755589791;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yXQfw5kmxH3xe2BtoM8uVeAphbxlIG0RJ6yArJxRlME=;
  b=lCGLuEMDUP4Cz4K+YaFr50Vz5C/cec1vXj8mVpLJUPX1WVGSxOjNIYxZ
   /dHPpVqHaygHjLzpDF3h8UrYN4RIeNkIrsTd6D5Ct+/HcIKVbtSTxtTEq
   m/gFptD4Sc7TTQ6tQIc9dWC0Wrx5K2eS43IeOmNWlwbhuuy4/O7thMiyP
   mbAUfJzJKuu+W2ur57bbA0hBt/GGnTfaw3P9hBJjTCdaYSirM4Hg9EBSC
   9fXdzuVtdYQhPz/svCvO/mZxkZs1vX0jbxjkFipkFV5Nuzm+EFS4e6by6
   pRgutYHVAN6W2OozK7E+1onVP5v+kPkiECaZCjLlB4O9+nvIgcMZQY5jO
   Q==;
X-CSE-ConnectionGUID: S5xlQ+muRz232nFfRWJ+1w==
X-CSE-MsgGUID: gcS9/xODTvObvYfIvhFgOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26043706"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26043706"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:49:36 -0700
X-CSE-ConnectionGUID: asTOiE4QTIyNsuC0IRWF6w==
X-CSE-MsgGUID: FdIuexS/S0is/hp7S2MxtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60281715"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:49:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  david@redhat.com,  nphamcs@gmail.com,
  nehagholkar@meta.com,  abhishekd@meta.com, Johannes Weiner
 <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
In-Reply-To: <20240803094715.23900-1-gourry@gourry.net> (Gregory Price's
	message of "Sat, 3 Aug 2024 05:47:12 -0400")
References: <20240803094715.23900-1-gourry@gourry.net>
Date: Mon, 19 Aug 2024 15:46:00 +0800
Message-ID: <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> Unmapped pagecache pages can be demoted to low-tier memory, but 
> they can only be promoted if a process maps the pages into the
> memory space (so that NUMA hint faults can be caught).  This can
> cause significant performance degradation as the pagecache ages
> and unmapped, cached files are accessed.
>
> This patch series enables the pagecache to request a promotion of
> a folio when it is accessed via the pagecache.
>
> We add a new `numa_hint_page_cache` counter in vmstat to capture
> information on when these migrations occur.

It appears that you will promote page cache page on the second access.
Do you have some better way to identify hot pages from the not-so-hot
pages?  How to balance between unmapped and mapped pages?  We have hot
page selection for hot pages.

[snip]

--
Best Regards,
Huang, Ying

