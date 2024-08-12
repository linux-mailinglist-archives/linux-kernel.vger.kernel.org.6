Return-Path: <linux-kernel+bounces-283661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3994F77E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5343BB2182C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DD1922C0;
	Mon, 12 Aug 2024 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSbdjvcp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCC16BE2C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491070; cv=none; b=IPoU5EzSQPqK7ADAWFzHGLUYs16pp7jf+NP2daJrP1KsXgwev4U4cV1AacEhI1AHeJihr/UK1o8vjhlklk9NSHlkhQ4UYDD8zjbsjxl5AFHs8eHDKIHR54C35ZB9d13iZc4DCbpOAbfyRjWs3BJdOLpdBgykiI5J0adbEdUwA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491070; c=relaxed/simple;
	bh=zfDWpDeWWiQ4e/QNsmyErz/xKbrpLlGarNZsWId7S2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0zNjEy3ibhsTHdslksVM78LFzX2488yz2o24MjCumwGVGFruE3yqqGP2YgtzXA6qDVs4pWA3c5xx3ZV5gZwkBC51QzHRY7xha/iM0FrLgOajZIzLQv30YEa3IrZ2dDS4Pc6YFQG9bP5hFz+9Qfw0OaAf0AX/l3sy6MKNI1KdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSbdjvcp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723491068; x=1755027068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zfDWpDeWWiQ4e/QNsmyErz/xKbrpLlGarNZsWId7S2Q=;
  b=eSbdjvcpAUbkYO4T3+Sn6zq/Ca2hvsv6KigyVs83eEBOwL3CuED9eRvp
   N7NPY4q53cD8HMYsIHObtsz0HhCH6G7KR2sqVhnNr1RVgqONHY2A5rW1r
   y3SRA25vLpgVnbnUnVcx/KwWBo2kdwHmTVq7fzEdxUEO/u48I7rJmySwD
   kIp3AfXh2WSQK0DkzcrEh5tvqKtXj/NPpmehQT7H4zFOc4H90qhtDk+YR
   ERxPZHgT6BOdLufJyhuW747sl3jifygYqhXBCHQHDuhlhjqO6IbaFm3rQ
   FXjuNtRPcpfuVCvLjVIZOHz/fpPWddOosiWbRP8KzvzlU8H48/NBZOV/r
   g==;
X-CSE-ConnectionGUID: IsQZSHUST1qExS7+qEKbKw==
X-CSE-MsgGUID: tZK0uNnCR3aLgmn9FXkW0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32243193"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32243193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:31:07 -0700
X-CSE-ConnectionGUID: /HdOifOuSlmCYHWl5Klcmw==
X-CSE-MsgGUID: gitgAHEeQFmEGzJhcJ7NDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58311484"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 12 Aug 2024 12:31:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42D49178; Mon, 12 Aug 2024 22:31:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] irqdomain: Unify checks for bus_token
Date: Mon, 12 Aug 2024 22:29:39 +0300
Message-ID: <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
References: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code uses if (bus_token) and if (bus_token == DOMAIN_BUS_ANY).
Since bus_token is enum, the later is more robust against changes.
Unify all checks to follow the latter variant.

Fixes: 0b21add71bd9 ("irqdomain: Handle domain bus token in irq_domain_create()")
Fixes: 1bf2c9282927 ("irqdomain: Cleanup domain name allocation")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 01001eb615ec..18d253e10e87 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -130,8 +130,10 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain_bus_token bus_token)
 {
-	domain->name = bus_token ? kasprintf(GFP_KERNEL, "%s-%d", base, bus_token) :
-				   kasprintf(GFP_KERNEL, "%s", base);
+	if (bus_token == DOMAIN_BUS_ANY)
+		domain->name = kasprintf(GFP_KERNEL, "%s", base);
+	else
+		domain->name = kasprintf(GFP_KERNEL, "%s-%d", base, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
 
@@ -146,8 +148,10 @@ static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_hand
 	const char *suf = suffix ? : "";
 	char *name;
 
-	name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token) :
-			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+	if (bus_token == DOMAIN_BUS_ANY)
+		name = kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+	else
+		name = kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token);
 	if (!name)
 		return -ENOMEM;
 
@@ -166,11 +170,13 @@ static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus_tok
 	static atomic_t unknown_domains;
 	int id = atomic_inc_return(&unknown_domains);
 
-	domain->name = bus_token ? kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token) :
-				   kasprintf(GFP_KERNEL, "unknown-%d", id);
-
+	if (bus_token == DOMAIN_BUS_ANY)
+		domain->name = kasprintf(GFP_KERNEL, "unknown-%d", id);
+	else
+		domain->name = kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
+
 	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	return 0;
 }
@@ -200,7 +206,7 @@ static int irq_domain_set_name(struct irq_domain *domain, const struct irq_domai
 			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name = fwid->name;
-			if (bus_token)
+			if (bus_token != DOMAIN_BUS_ANY)
 				return alloc_name(domain, fwid->name, bus_token);
 		}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


