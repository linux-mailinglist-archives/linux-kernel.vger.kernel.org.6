Return-Path: <linux-kernel+bounces-446781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F489F2924
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D344A1885BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D321CBEA4;
	Mon, 16 Dec 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BadyMFb6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313B1BE23F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322075; cv=none; b=bmSR1TA4bgX1OtSVPgI33Ru+fk2JiVaZRjq84/j24mc7fOuty4JzDrB04EH12P2BpCytUlEj336x7CvbER0+QA4ONfnxGpzGMcpYU71nZ6XR/pO7nyZ2AqHeaur7SxRTsGH8wp7M5OeghqYCo3Yo1VJCWOzLqNW+osyirlh0h1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322075; c=relaxed/simple;
	bh=kSKaIzakyLMOLTGavl1YigRi/jhUzDBr+KHmuegXLT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Obd+6fB3LN9E4N3dHlUKNddpHGMPtkenb/2RqIv174X6IHJf2CWhCxDSBkA8VkUBOk0ZwYnN6n9XkJe4PZLkaJQGWWn1coNAAi+lWn+qApxhHu7bEgwqv45HB6NELuuafQe8pxCT0yZlhPTq7D8Ic2YAJGjOSmdEFC5WcMPHdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BadyMFb6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322066;
	bh=kSKaIzakyLMOLTGavl1YigRi/jhUzDBr+KHmuegXLT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BadyMFb61RzPUtsPOslUvj2r9ugXcqC+cwewH7uzQHDSTD4ypCnzfheaLXoLct+XU
	 3a37PgP5LYlGYqX1Mw+ZU52qb2ow3Z1aB47tmlmDcplSGHIhppUK6lM7W+HMdWKMuW
	 dDOYQrmdm5wKKVXVoAMjb6BSRgZNFMbPVAvKlgT4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 05:07:47 +0100
Subject: [PATCH 5/5] powerpc/perf/hv-24x7: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-5-bbed8906f476@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=1832;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kSKaIzakyLMOLTGavl1YigRi/jhUzDBr+KHmuegXLT0=;
 b=nxzBc5603KmXdcAfj1ul0CWTZ3mnR0agqe30xCjxbiQhQeU50/tSIF00ai6WtgSME2KlEmf4V
 y4S8KHR5rTBDpW291Kll/z1PKPHWSHp+5aDhibQSkoSY20ZK4n2g9ox
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/perf/hv-24x7.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index d400fa391c2765cf201ee4dc754007e655cc74ca..b0768f3d289300826dcd454a8e397a943572fd45 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -998,7 +998,7 @@ static int create_events_from_catalog(struct attribute ***events_,
 }
 
 static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t offset, size_t count)
 {
 	long hret;
@@ -1108,14 +1108,14 @@ PAGE_0_ATTR(catalog_version, "%lld\n",
 		(unsigned long long)be64_to_cpu(page_0->version));
 PAGE_0_ATTR(catalog_len, "%lld\n",
 		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
-static BIN_ATTR_RO(catalog, 0/* real length varies */);
+static const BIN_ATTR_RO(catalog, 0/* real length varies */);
 static DEVICE_ATTR_RO(domains);
 static DEVICE_ATTR_RO(sockets);
 static DEVICE_ATTR_RO(chipspersocket);
 static DEVICE_ATTR_RO(coresperchip);
 static DEVICE_ATTR_RO(cpumask);
 
-static struct bin_attribute *if_bin_attrs[] = {
+static const struct bin_attribute *const if_bin_attrs[] = {
 	&bin_attr_catalog,
 	NULL,
 };
@@ -1141,7 +1141,7 @@ static struct attribute *if_attrs[] = {
 
 static const struct attribute_group if_group = {
 	.name = "interface",
-	.bin_attrs = if_bin_attrs,
+	.bin_attrs_new = if_bin_attrs,
 	.attrs = if_attrs,
 };
 

-- 
2.47.1


