Return-Path: <linux-kernel+bounces-360473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58191999B84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876A71C226BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B571FA247;
	Fri, 11 Oct 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0zMdrGMF"
Received: from out187-15.us.a.mail.aliyun.com (out187-15.us.a.mail.aliyun.com [47.90.187.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A061F940E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619826; cv=none; b=XFGOpPu7Y+DOldZCjr7ezgmV8dmN9JRE+syp+TUqkCa2vwCDo2pS39CancOKX3lRaw0RiV5c4eUIQmuBvYrmNqGU66Csu2eRaxxzLYyREx6+bu9OePqLG9ilDSTj7ca2YVXTzuRoekUynyzwFLbdMCN3snMV7m9ZultSe5gUxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619826; c=relaxed/simple;
	bh=0Jdr0XE4NDl4Y6NZ4WrezwZHEAp3bvLB6qoaxEIk4SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqN7HdZy/ZvCBrkvFCV1L55i6nYXZFJ9IgRYTmBwpdhItGD6rZ/y21agBpt+G2veEomjYr+GCoCPzzV8vcYeSAewkhkR9IKUh6XOjtmD0Y5jDpJtkk7mus5oHBAODk14bdz+IRobt27X6xmDcxP4VEdRpATB5zkDvr4TB9Y/Ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0zMdrGMF; arc=none smtp.client-ip=47.90.187.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619812; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JqBp18vUFTJ52DrJam+hRUvSyDLMH764FRvn01AkcTQ=;
	b=0zMdrGMFfdjFZC+6W4CBO15v9HGSDRJM9mNyhNoenWXEVXLtXsPyTv6cHgL8fBmt9dHrBHloYzbRSaBqBMi16Zoi9Fs7fVlzD9+nUy45MCM15c+XxEqsgHtqkdYyWGSkLwihszFXG9anfACol4J/iTbD0VigQ8NX0u/PF16nKpM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyR_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/9] um: Do not propagate uml_dir parameter to kernel
Date: Fri, 11 Oct 2024 12:04:35 +0800
Message-Id: <20241011040441.1586345-4-tiwei.btw@antgroup.com>
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

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "uml_dir=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/umid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index e09d65b05d1c..eb523ab1e218 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -358,6 +358,8 @@ char *get_umid(void)
 
 static int __init set_uml_dir(char *name, int *add)
 {
+	*add = 0;
+
 	if (*name == '\0') {
 		os_warn("uml_dir can't be an empty string\n");
 		return 0;
-- 
2.34.1


