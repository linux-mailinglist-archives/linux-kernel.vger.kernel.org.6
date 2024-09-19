Return-Path: <linux-kernel+bounces-333132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9997C45C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B231C21BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670218D647;
	Thu, 19 Sep 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="auQZD6cU"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8377345B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727732; cv=none; b=AAJkoPzqO3D3/oRLbaWbyctstRe3nWZ2t0JINMZrYRB2pjo/nTDjwa5WAgsx+hNi2LqUYnOfGwksUl9faJHpZhGZCaJ4ZoGIpISeDWVbe56ToMje+Hklt5wDfhdJ6B2mPqTNjc+sLHPGFbivP6wIuT3ctCI5wTc18b+dTaq1jRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727732; c=relaxed/simple;
	bh=sempV5BRGDq+ntFWUOn9QihcdK7u8Tcpq/+Ady2a+w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FITVwPOaDALDXY8PMt7lctLO4f5aKcA8EryP+FB/Ml47a6cFSHPSF0umN6fnlRZzJdRkc8vroxLeocXYiFV2XMPLhZvjspOBt1JZNA6DtKGtwBFje570FTZq7F6UueB/dMoyGfLzAGY+YUjpaTboq3aOBSVBsz8Dge5+cl6v+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=auQZD6cU; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oBYpkWszY7tggqf79E5F5PPG229HgY/r22zB1ZJnXhg=; b=auQZD6cUqKd5EA5acWo6rsIj9d
	A9kH19tYjJxdrNdRdzdz5dNI595piQHgeNnTxEiBlwqtZJ74uasCETar/Qh5Wg8+ZGchiBO49Sjq0
	x0Jtg++D/hqyCUQNJDBeh58i9kJR6F/QBUnj7MfTvYHtTKUJ0PXUiZR56sVLAO0v1/UPVr8xMXRKh
	98fhjTF9q2beJcRmuKJi68pXYhk5Jvp6wZM6e/FClCoIZQ4Uw4/SManec1N41Bhvgt0/0uG89ik9O
	QH3li1zIpbSRmfA0kmofMfDeYQdel4ugKEBmGucaG1K6uw/KZu3XYNkZM8hAuk1PG8S2rzxP8FdWX
	IJRGjHQQ==;
Received: from 81-223-238-147.static.upcbusiness.at ([81.223.238.147] helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1srARq-000GL2-9T; Thu, 19 Sep 2024 07:15:26 +0100
Received: from ben by rainbowdash with local (Exim 4.98)
	(envelope-from <ben@rainbowdash>)
	id 1srARp-000000016gP-20OG;
	Thu, 19 Sep 2024 07:15:25 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	charlie@rivosinc.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] riscv: make riscv_isa_vendor_ext_andes[] static
Date: Thu, 19 Sep 2024 07:15:24 +0100
Message-Id: <20240919061524.264007-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The riscv_isa_vendor_ext_andes array is not exported out of the
file it is in, so make it static to fix the following sparse
warning:

arch/riscv/kernel/vendor_extensions/andes.c:11:33: warning: symbol 'riscv_isa_vendor_ext_andes' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/kernel/vendor_extensions/andes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/kernel/vendor_extensions/andes.c
index ec688c88456a..51f302b6d503 100644
--- a/arch/riscv/kernel/vendor_extensions/andes.c
+++ b/arch/riscv/kernel/vendor_extensions/andes.c
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 /* All Andes vendor extensions supported in Linux */
-const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+static const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
 };
 
-- 
2.37.2.352.g3c44437643


