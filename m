Return-Path: <linux-kernel+bounces-511841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C6A33065
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EFA1886DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D7201034;
	Wed, 12 Feb 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKmJlkP6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F21FFC7D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390771; cv=none; b=CCJ6cotN0jAmqtRbTt5Y68sqv+k0tqYIkhzw5Z6sXeWIVGgQbXKfW9lpL5LTMiiAxi5iLugeSLdtyk98i0EVFPU90NozGX5QbZnd4jymF7KaMXtW7vPFi1Log6oCE7uaLLVOM/XbUDkVYKlTkjQmsT6wi+au0rVfrMSwkGrn0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390771; c=relaxed/simple;
	bh=UrP4+S/PJRRzsNR6LIvFEhiK0LIXEoP6w6Tk9R2XVTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKNXeM3ic126YAonezE0I0YqfLdsrzDOOKejGlhjFE/1kS2IFXDb7KMGdEcmjFWk+2BSAXjbUqXC5JXQrw40EiE4GlSq81TBkvl3VNiKw3j2td7ZeYCldVyXSsU5yZRxG+4j+ovhSiUn80tNIEYNjbx7LwBkdM/YM1T++hH11ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKmJlkP6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390770; x=1770926770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrP4+S/PJRRzsNR6LIvFEhiK0LIXEoP6w6Tk9R2XVTE=;
  b=ZKmJlkP61poIRYP4Zw4AdkcGt4e3/zCJrd1NFL5xPbEwmIDVZoB9sb7q
   nSAm3VMnlr8wlznTYZxVVrtYFR79yl2U3CPCR9+tDMEFQN28gbLC99hKU
   VRQzqneZiG5NAB2UcR/2uQNuSio7ixRKNXzFp70Dv6jkyHsNg5oqLDtDX
   uJnNxynbBfXUo1BKwO0WZIYVn3FDECqWuEBAzElGavipckDvfKAO8N6Td
   WYSzVbf3MtqK7ne9jqMuWjJwFREhRTAye+VHieIkxdhegX/ThyFbbBLbG
   I0VAbOmaG/ox+C33i/Ink/fSnsd0tN0tGsTKLNN8yVNz5kERlOjZS62Lb
   Q==;
X-CSE-ConnectionGUID: cx62/ekzQjy25OSYjb88gQ==
X-CSE-MsgGUID: PXagQGqwS36lyTyU1qRUHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718492"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718492"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
X-CSE-ConnectionGUID: jRDc34lJSaiZwqpzTgQxng==
X-CSE-MsgGUID: J2U+vyrnTMK/DUoGZf9pkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010757"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/6] drivers: base: devres: Fix find_group() documentation
Date: Wed, 12 Feb 2025 12:05:38 -0800
Message-ID: <20250212200542.515493-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212200542.515493-1-lucas.demarchi@intel.com>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It returns the last open group, not the last group.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/base/devres.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index b955a2f9520bf..d8a733ea5e1ac 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -576,7 +576,10 @@ void *devres_open_group(struct device *dev, void *id, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devres_open_group);
 
-/* Find devres group with ID @id.  If @id is NULL, look for the latest. */
+/*
+ * Find devres group with ID @id.  If @id is NULL, look for the latest open
+ * group.
+ */
 static struct devres_group *find_group(struct device *dev, void *id)
 {
 	struct devres_node *node;
-- 
2.48.1


