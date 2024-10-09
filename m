Return-Path: <linux-kernel+bounces-357070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6B996B32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB372832B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA21A257D;
	Wed,  9 Oct 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN6JR+AH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232719340C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478681; cv=none; b=CApmEZ1dnvttPIqSmFA+QW5gJ0Cg0NDiwnPYsIVHLluD3LbCHnYE7G+X8fqvd32Eg0RIzH16Ac+EBtDXjPxsU/uEnnaMMPhX8ITvlWwvzFDD95RmqE1Ly81i2EUA7u6gbvNalIC1jLmmyIamyQDONW5tozOXN0Edw9kdunNXfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478681; c=relaxed/simple;
	bh=vgxoo8SwPBnYw4h2ei6Gg0XYV7dEsm1r+mUpn46aZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g86pI85NOXr4SLSAfUDa33/1XQfIiPt3QlrEJTZRX0m2soacF8Yb/kpSJmZyc3pIIVkWhimXUdkqHou3j1T9pKvP9fIoMs+dM3MFA/gbS78CGwcVJ6n1gXzlRUqahy6C6NTEill7mjEd21rGTYItyiz4T3clNZQlXBvSGFzGvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN6JR+AH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728478681; x=1760014681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vgxoo8SwPBnYw4h2ei6Gg0XYV7dEsm1r+mUpn46aZdM=;
  b=YN6JR+AHHX0ivV1j/mNFQeUh/UmFqkculie92MIRSc41aGSq9FWEKOBq
   LWwhvjNSDqQD7FDoBJKi26tprFqqpwBj1k/9EpPLkxCbgdcfX6EbamhAx
   2DEucWj/eM2wRU7beeXg0jB6oKCPVFXgOIhqo1K2R1CGScgiDTJm01Z+4
   jmb+o74tNo1lbleEPG8JAP3RrwTi7XZLwPNLYiib62Xkuo7Ixpipo3+i3
   0zKIoJDKbOGmlUYKTA3tBwiC1wW8eMpIJdofjaIG5UixcfnZ17tLiiD7K
   TUx96fGYEEUBm9mS2xrnDWBkx3jCB8c5GHWWniVc/XBn6ivIlV1htQriY
   A==;
X-CSE-ConnectionGUID: mmrSllwGRlOfAbrb2nsWOw==
X-CSE-MsgGUID: W+v3tkpuSkys68lrp7U6qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39134601"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="39134601"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:58:00 -0700
X-CSE-ConnectionGUID: EkGtXtmrQyuWIisRvEMBPw==
X-CSE-MsgGUID: BgC7IhVVQo6u5mUyyARE2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="107003952"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:57:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] resource: correct reallocate_resource() documentation
Date: Wed,  9 Oct 2024 15:57:51 +0300
Message-Id: <20241009125751.8090-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reallocate_resource() documentation claims constraint is about "the size
and alignment" but the size is provided in another parameter. Instead of
size, constraint has the allowed memory range (min, max) so change the
wording to reflect that.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..41747431b822 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -746,7 +746,7 @@ EXPORT_SYMBOL_GPL(find_resource_space);
  * @root: root resource descriptor
  * @old:  resource descriptor desired by caller
  * @newsize: new size of the resource descriptor
- * @constraint: the size and alignment constraints to be met.
+ * @constraint: the memory range and alignment constraints to be met.
  */
 static int reallocate_resource(struct resource *root, struct resource *old,
 			       resource_size_t newsize,
-- 
2.39.5


