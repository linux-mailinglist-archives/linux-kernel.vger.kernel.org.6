Return-Path: <linux-kernel+bounces-242641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197B928AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D4C1C2218D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE7B16B385;
	Fri,  5 Jul 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gzUiIEmQ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F814B097
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189953; cv=none; b=tb3FK9K40Iz5WPKn5rzhHqLQhpuc5MuzL00E/3ZZWGlAUnwZwn7dlhi12kK8X1nNmV0BiO9T2rlN7wauu1Tg3RCfyfjsNjaOLyu3TVFHVTX04Ei+qsfLSV2eMGaJeYWV7Xlfv1Ak5OuCnf61nDREPULE4cOd3IinAA8xoSyukU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189953; c=relaxed/simple;
	bh=/Ki3z7Mg9r023CndGYTmQ+y99sbHzRa0tY4Iwa/X0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGsP11RvikH79qjtNSsVR3EBQzT50+l8weDLDBWqg3zV8fWYlLIvDCmZ3HNUmcSJTa6nugnW4IdJkvc+ylPDqwNHkvjMAr2o5BlThKPzZbQISlwQs2Um2oxk4K7Pvlgd4DWrK+YE+vsEc19Aq9nqp11VZtnOUVJNhDa/IbtuWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gzUiIEmQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tW9W5aA0QL1+tEzKb3u8InAtf2ShZmmpt5/SKEpPDKQ=; b=gzUiIEmQlxSEBymvLZjiM6oupp
	yEfm7ZYdv3IkD3XYkcZzRczTzcslPCCEx6CEQdvt/VkvZ33WzooNp6y8Zkj/kVz8txfTNAz6BDfmJ
	KwFBFGChxTHdsgP+o/Cgab+18wyXI36WMl8JZcM6xB6dhGKjahuXiGpi0rWhLoFftVkiK7yccKR2f
	jhsQB7xotPiI7/eM2SpKvrQ6wIasROELhEy9RV9jGBbhqda9BLaWFyKJ89mgW3emf4AL4OuM7V4s0
	iwCTPgd70smH2lJbKpXnxi/+BUwdyEJkF/gyaf8rVH1LXJkQnIvUo8nRsf0iKdfaP4ztCfZXVfvv0
	gF0/+kNA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPjz2-00BSlq-LI; Fri, 05 Jul 2024 16:32:20 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] One fix for /proc/<pid>/numa_maps and two RFCs
Date: Fri,  5 Jul 2024 15:32:15 +0100
Message-ID: <20240705143218.21258-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Hi all,

First patch fixes the issue where NUMA balancing mode was wrongly shown
'default' and is small and so hopefully backportable to stable.c

Second two patches are more like RFC. Although they work I am not 100% sure of
their benefit. Especially the last patch which enables turning on NUMA balancing
with tmpfs. Second one at least makes the flag handling a bit more robust in the
sense that it can prevent future mistakes.

Comments and opinions are welcome!

Cc: Huang Ying <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

Tvrtko Ursulin (3):
  mm/numa_balancing: Teach mpol_to_str about the balancing mode
  mm/mempolicy: Use flags lookup array in mpol_to_str
  mm/numa_balancing: Allow setting numa balancing for tmpfs

 mm/mempolicy.c | 123 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 31 deletions(-)

-- 
2.44.0


