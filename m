Return-Path: <linux-kernel+bounces-360480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC156999B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE52851B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C21F1319;
	Fri, 11 Oct 2024 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="W7Td8R8E"
Received: from out187-2.us.a.mail.aliyun.com (out187-2.us.a.mail.aliyun.com [47.90.187.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE51CB506
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620443; cv=none; b=ptS4RdQG6YQsQ4sWSB7JpHO6BembgyMV0XdZKnBfXeLfc/NTq2Yc8drq1Q2vvneFyb2ksc+aOATvHTjo2fWQiNDRDht+L5v/MWqXiqHKtAyRztpmUmwEtMhp5QGx0OFCcSoNTv8nKAjyULyRu43ps2ZVuUdAnVDmI8P68XZsnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620443; c=relaxed/simple;
	bh=Jq4jzYqKznKhRX0mWI0FKN2O5bHda7cDEW5QY8QlSSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSiON2pkh8C+uDc0XRRyajwH6JTxID3H1GXGwp47PwCQ+ZFnC9K+We/UoAeIErkxhNYwVh6vSeEgTKtd/JKmMLOrDUO5miiwgu1cuC6OTZ01eRWKCH4noV1IaKFoPXqGZl1ZKMyYsx21B3QjH9NdMu7Qn/5MekRr/oOzPw9Baa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=W7Td8R8E; arc=none smtp.client-ip=47.90.187.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728620429; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UXivylKKVZoaavgHJDWP6Lp6p/IoGhjIDtQtnWzg12U=;
	b=W7Td8R8EOtSGSUXkhdkxVtYKLq6g1Ca3h/VBz+GdV3Az/5BzXFa07DD7Ve70J+Ofn9iEd+4m66COonaSaU1ULTHa71HantfSEP11wtTEl7JrqjMt2dq9fNwmSol2FgeIGakO7XarzgpzXSES1Xpc5gNIuUzP9UMwT51SH8gjt7g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzj_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 8/9] um: hostaudio: Do not propagate mixer parameter to kernel
Date: Fri, 11 Oct 2024 12:04:40 +0800
Message-Id: <20241011040441.1586345-9-tiwei.btw@antgroup.com>
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

This parameter is UML specific and is unknown to kernel. It should
not be propagated to kernel, otherwise it will trigger a warning and
be passed to user space as an environment option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/hostaudio_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 09af903b75ae..0ac149de1ac0 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -57,6 +57,7 @@ __uml_setup("dsp=", set_dsp, "dsp=<dsp device>\n" DSP_HELP);
 
 static int set_mixer(char *name, int *add)
 {
+	*add = 0;
 	mixer = name;
 	return 0;
 }
-- 
2.34.1


