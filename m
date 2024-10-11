Return-Path: <linux-kernel+bounces-360474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DE999B85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C481F1C22719
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B44208208;
	Fri, 11 Oct 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="SwHu3Eqv"
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294511F942F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619827; cv=none; b=WmV5HWeAn9qHVLdBkyw8m7a0w1sCJl5Zr0nCOdRTTYBtwUnwBXzRDqhUFVnWTlOGFwnoM70XCdX3JjSw2HaYc+EhDsG+VYRd04k3bb9A8JpmGPhfegRKb+N5CSJKHYNXIOAX2LR90S4ksuqtLEv1GIilGHU4cANlLQbj0edvgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619827; c=relaxed/simple;
	bh=An5b94vrzHbchvof/Mqn7OCFdkkGopWJZjOtSg3ivn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJxkrJ4z5Hx5SG3b2MilZHOec3wtGpbZGdzGxj5FAaB5pXk4T9Ec+eAfVcWRMztZ8D1F0HXtMM22Xy7RP2qkiKZNjJo0T1OO9ZFMCaYwvtEHVsLsrcYV5Y8+AXd3UiQfKgp+YvIAvgkzBCLmwSzlpo9MvTEGr8yegobUSgg3MZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=SwHu3Eqv; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619814; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Se+HDEpWKr4lq3f8uBsVRYaVltXK6GKDvy+iKLq80QQ=;
	b=SwHu3EqvxJuJRkSuqbkUve/qZ7dD/7KLRwmkJE8TD95dAj+IM5IWpadFWluM3V4y927se/E1hhoqbkpJ2+xsSY5tgclIqLrAa/lwGeWyKnd/QJ7G4B716zyb919BN1yD0kL54zXgjybKYoMTvJFyVHLt8xJNcuKiOnKofscGb5k=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzx_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 9/9] um: Do not propagate initrd parameter to kernel
Date: Fri, 11 Oct 2024 12:04:41 +0800
Message-Id: <20241011040441.1586345-10-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter is UML specific. It specifies the name of the file
containing the initrd image, which is unknown to kernel.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/initrd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 47b8cb1a1156..99dba827461c 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -34,6 +34,7 @@ int __init read_initrd(void)
 
 static int __init uml_initrd_setup(char *line, int *add)
 {
+	*add = 0;
 	initrd = line;
 	return 0;
 }
-- 
2.34.1


