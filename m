Return-Path: <linux-kernel+bounces-511843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B53A3306B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5676D3A1E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC5201259;
	Wed, 12 Feb 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhrYC47G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CD201013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390772; cv=none; b=p5c/PvzjOnynuf+6ze833Xbb1SCg5oDTBifvzut00lQJWkGK9IAYG3ms9S0ZJ4yweiI7i8EQf0rzrAlsSRlXyZ31WAwM/llY+aAbHwmCkgE2oI6A4TGKC35XPrbXpbkB5IZqxx/JcBEl4qgHfwct9AQ4Y1ObgjauUhTXgI3bwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390772; c=relaxed/simple;
	bh=asPsjfJ93s8xZX8uMGYNQdUgRg6kPjTaMYqujLFIiio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDAlmXsU0geKXMtfPZW7C+/lkkLBhtlB+0cycqpUemii9wbblgFZAMELSsXbSOfLlqvpC+FIBvefdqRDX6kqmnQWx8UNt6CxVoyse6T8+h8ngrBNjCvUDj/2gIbMkACRD3Vktpc5Hm+82QQl8K3Nty5Q2Pjl01ty7ZaaYzFyVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhrYC47G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390770; x=1770926770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asPsjfJ93s8xZX8uMGYNQdUgRg6kPjTaMYqujLFIiio=;
  b=XhrYC47G9GVUqcfr8qA+Gk9nnBAG9P+neQMijOWHjaM3kMUIW+nYgjwT
   PLWZjYXtenJds2irpONf9AL8BhqbEHzOafgD6WYk2cegEf8RYIXHyv+68
   bqMHWWqzXuGy4aIh7Pk8IVPQFIUe0DjPff+Q9Re16VutRmyycPR+4UO8O
   5btDNvhY6gmr0XWaEyKlOfQMNYRP63MpayE2RYHbNqdKD4t3g01F1PPf8
   aO1iGSt3EcQJfPXqpYb7n5nkZZ9M6/R7IHeEmwK3XV/l47JKG+0ivnMFv
   GSOfn18k5IP6jD1d/KPCmcNBhFNEXKVhkLFHIa/Bkr/bYlZKB7491ZIlj
   g==;
X-CSE-ConnectionGUID: l0EHHlSYRBaaUVJv+kO/jQ==
X-CSE-MsgGUID: yBTj5rFZRGew/vhCPuho8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718496"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
X-CSE-ConnectionGUID: mziKP4TcTWyd52lsoa6x3g==
X-CSE-MsgGUID: e+SHg10+Sh+ngqOWmjOKpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010760"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/6] drivers: base: component: Add debug message for unbind
Date: Wed, 12 Feb 2025 12:05:39 -0800
Message-ID: <20250212200542.515493-4-lucas.demarchi@intel.com>
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

Like when binding component, add a debug message to the unbinding case
to make it easy to track the lifecycle. This also includes the component
pointer since that is used to open a group in devres, making it easier
to track the resources.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/base/component.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 741497324d78a..5d10600bbc25e 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -574,6 +574,9 @@ static void component_unbind(struct component *component,
 {
 	WARN_ON(!component->bound);
 
+	dev_dbg(adev->parent, "unbinding %s component %p (ops %ps)\n",
+		dev_name(component->dev), component, component->ops);
+
 	if (component->ops && component->ops->unbind)
 		component->ops->unbind(component->dev, adev->parent, data);
 	component->bound = false;
-- 
2.48.1


