Return-Path: <linux-kernel+bounces-313440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025C196A57C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997FD1F2548B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB318FDB3;
	Tue,  3 Sep 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPGzeyAA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500218E35D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384899; cv=none; b=NupFjTc2a0Kr+EhjjX1FTu+xEcfDBQd+AD3vgeIEcWwWkbHlq6Z3rt6RQvDk2Y120aff0qFRn7yj48tbcfvEIqyoPF4iu+FCZGx7VXQw6H4S/uab/r5TvVjIs2lhIi0G8iW36POX3NoBts87wNo2jCU2OPosqgfdgFNbnhTT2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384899; c=relaxed/simple;
	bh=3HatNy0EiXgMB0mRjaLU9jaxCkRDJ6yhI6gNC2cHskE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4czPNHGLTDgulqph3zyGAwBdZR5GjI4rczxt5gYroZp5CNbbduIALQf5b63Frc+rt9jyl3l9OuM0vtw5qE7KXbqCZbPaSfYdbuEJptWbYQVtHP9wPQpfJ0+0Qxr7tYnbBrZ3Oi6wcovSbnJ1zdFPzzUqpTUHymNJdYTagQN3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPGzeyAA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725384898; x=1756920898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3HatNy0EiXgMB0mRjaLU9jaxCkRDJ6yhI6gNC2cHskE=;
  b=hPGzeyAAi0OR2dK1FkkLMvFbvF2EnYjmjt+o/NsBy1VQNt8QxNJcw53M
   Z6DpMVizz9bknpWItkOkusD9ZSqzVvSXcJ9pGXEfNidDtvrPzp5N8QR/2
   2yfWsfFV7BPRe2DK3jYM56CWOjIl4C4T4vHeT1QX75z7+YaaX92lYKT9f
   ywzMLaIlaoxT7GLg/7UGjwc9UIeuIX92jcTh9lTdxFvi9IicNDyyLZ/5Q
   rb4VURdwla+o1ww9s8vtiQ3dqPBK0jBYyO7L9fG/EHq/PITw35wYu0mx/
   vG//eMtc3s3mu+GO4ccaWm82X485Nf6LU/wnEBtspP+wJk+fPfpe8mt25
   w==;
X-CSE-ConnectionGUID: xbrDYMlDSR2KcyICRtqI+w==
X-CSE-MsgGUID: e73TW1xmTcaU6MWVkdQiiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46528531"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46528531"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:34:55 -0700
X-CSE-ConnectionGUID: H+J+SerOTU+18tkVZdPW1w==
X-CSE-MsgGUID: jqrGXztaSsSWD7R4DXjbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65715873"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:34:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 1/3] extcon: axp288: Switch to new Intel CPU model defines
Date: Tue,  3 Sep 2024 10:34:41 -0700
Message-ID: <20240903173443.7962-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903173443.7962-1-tony.luck@intel.com>
References: <20240903173443.7962-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Link: https://lore.kernel.org/lkml/20240611174016.352953-1-tony.luck@intel.com/
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a703a8315634..d3bcbe839c09 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -108,7 +108,7 @@ struct axp288_extcon_info {
 };
 
 static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.46.0


