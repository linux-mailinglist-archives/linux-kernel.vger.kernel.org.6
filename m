Return-Path: <linux-kernel+bounces-305964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8596372A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895E7B23D06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1517BD5;
	Thu, 29 Aug 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt4jjeis"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A958522A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893267; cv=none; b=n6asIp3CV/mcY2aE5130SxNY3pR4kfgQGSjt8DXNJ74Q6tf0Z/7E45PPXObQZvN/7e2Zr3ydHWz7ValYjD8t+XEBETJHqClwU+XOVonzVDKSrnbOo0bho8874cKxoM8BnpIntQxMHZJZpUPSpJjsOoeOJUN530Br70sD/XOxVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893267; c=relaxed/simple;
	bh=bqXZXf9yz0O0dscvtWAbabQB1rBVFzVxRvi6wERMx4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uytxMiVTYRYYDd27LDGU1v/RY06yNWrJKPlAczwivdI+snnBzbz9jQsjwAEymTTbQ5yzU/202gZqx9pOJKqGNiBx++KTVuAwWdHqO67gBjyjzwGpCLM9QFKncd5lA0yQJKSYUgXG3GTpwAKLE7FSQX1oRy+48mEv+V3n9TSrAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt4jjeis; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724893266; x=1756429266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqXZXf9yz0O0dscvtWAbabQB1rBVFzVxRvi6wERMx4I=;
  b=Pt4jjeiscMgQkIpMHhoUBhmdNSGtJSCSE5oM5QefK2ZgJfpG+HKeDp3T
   Ts1efBKLfgmxkNfxVVxp6j+Cc2t2SnTkgT+4mZ28fZzE3jcr70Nhq84Jl
   H33OPYVNwDGY6+QJXm/Uhwy3Wwsz+R0aZZgdq7K2BTg4Dy6g+cbl6eihp
   sPzFGVTaEdaz/FZA1UKSqh4eXktZdiZ6M5Ei/7kNZcyZ4M2s0YlBYJRPA
   uNdGbOs1plS/UPqBaCxavve+rU4Z3Ng7Ee9e0VMasCdEaMm8fWmhZxT7e
   oWLMmyJZ3pmlmKe7GPMYHW5wZy50/FY7yK0fm6DSyHoZj1tTnwmJRBpOu
   Q==;
X-CSE-ConnectionGUID: fKljMjrzREOKt9Ic+XIJ0Q==
X-CSE-MsgGUID: B/LQGfWyS1qk/8h5Im4bzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27252255"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27252255"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 18:01:05 -0700
X-CSE-ConnectionGUID: Vt5u9kM9Qg+mclWo6seLcg==
X-CSE-MsgGUID: 6ryyHb03RB60OhrcaW+uZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68239384"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa005.jf.intel.com with ESMTP; 28 Aug 2024 18:01:04 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	zhengtangquan@oppo.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
Date: Wed, 28 Aug 2024 18:01:03 -0700
Message-Id: <20240829010103.7705-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAGsJ_4wGK6pu+KNhYjpWgydp6DyjH5tE=9+mje3UyrXdFJOuNw@mail.gmail.com>
References: <CAGsJ_4wGK6pu+KNhYjpWgydp6DyjH5tE=9+mje3UyrXdFJOuNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shakeel,

We submitted an RFC patchset [1] with the Intel In-Memory Analytics
Accelerator (Intel IAA) sometime back. This introduces a new 'canned-by_n'
compression algorithm in the IAA crypto driver.

Relative to software compressors, we could get a 10X improvement in zram
write latency and 7X improvement in zram read latency.

[1] https://lore.kernel.org/all/cover.1714581792.git.andre.glover@linux.intel.com/

Thanks,
Kanchana

