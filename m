Return-Path: <linux-kernel+bounces-210341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4C90428E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50114284C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F14CB55;
	Tue, 11 Jun 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQgfZ3Ow"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590454F87
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127630; cv=none; b=NTNFxDVQ6KRyDBEvDUgRpj3RzNBCsTVUbuW2KXyRsdUK0Q7FeZznjgUo/B9xSIRB6nX7lThKmjPy//v5Wu8iM62TYsWn859okAZegkWeBdD8Xjqm4mS2Vs9d9k27fCkIqQUmFvh0NBh/JcACcDdDD6F+sQagS7YbqiLB/16FtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127630; c=relaxed/simple;
	bh=97DFckhjjMfBzy/3ADAZ+Y35CuvleTLYTO6QoxMTf+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsVGEtYe6qYmUX4Zj7R5ONPuooykc8vAsZjuDk/q11MXh5FFLju3uSeHJbV7iKkpcg39FGu0+AKz+YZkZh9WEpGibmhSSYSp67/dnrv9Dh8YyVxGl3HNjX/vy69tPCw1BiEkBozWAP+Lr6mQNPhRjkJMxhcKwmR1JwAldmcQ9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQgfZ3Ow; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718127629; x=1749663629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=97DFckhjjMfBzy/3ADAZ+Y35CuvleTLYTO6QoxMTf+4=;
  b=SQgfZ3OwdtwE6EbhHqitwK3Q4oqn58/hSAsZbOCvDO7FRcc/23eMO8eT
   eh3gYoZqT3w3SY4Zu2B4rbcSu/+daRz8OoT2guZ05ZdTopb+nR1iOSA4k
   INjkFfrdEjHJ2CHHU/CAcMmDGBD192yaIuwUUuY8LwjIMFRAp/AkGs2mN
   3GIgkpeEcAgaAT1F5qwNA7ZO/2dCftsipC1cGM866jbBciUauyqUMp3Hf
   cgjGC2iOO+8ID+4V8n4B10mIylq6j3e/wSmOCbJZGaMo9rE4cpMnBk1oM
   vrFQzKWPkw+S32Vn6dzbmIYG7XQoG8+D5DtylOp2iqpfGc8h4uWr0VF6L
   w==;
X-CSE-ConnectionGUID: lnDp6PZGQMybsNCiFZ+ZQg==
X-CSE-MsgGUID: 43B0jzk5S96VoIsfoMcRVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14982407"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14982407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:40:29 -0700
X-CSE-ConnectionGUID: LdhaYpJnRfmju9siYbPJPw==
X-CSE-MsgGUID: 2zU+NP6LQRGlwaxEEpJlQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76978030"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:40:28 -0700
From: Tony Luck <tony.luck@intel.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 39/49 RESEND] extcon: axp288: Switch to new Intel CPU model defines
Date: Tue, 11 Jun 2024 10:40:16 -0700
Message-ID: <20240611174016.352953-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
All: get_maintainer.pl lists ll on the To: list as mainatiner for this
file.

I'm tracking changes that haven't made it to linux-next and this is one
of a handful remaining. Which tree to patches to this file pass through
on the way to Linus?

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
2.45.0


