Return-Path: <linux-kernel+bounces-266842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434C94085F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A791C22521
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51818E772;
	Tue, 30 Jul 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tGljWcSc"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABF18A953;
	Tue, 30 Jul 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320938; cv=none; b=t5/KsvBl35cRrYQo+Lvf387O/FNEJ/V/mMPbdolOozG/1TL7R2zhjDB1wBSygCk4RGu/XyTMY0s8ijhQnF2v148JAt77f/eYliL3vLil96QrDPm+dZPiSwI1zmnzqXufA3b/QwPbnIoX3PwIsIBOKbNxITq/bf69sIoBTnuJQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320938; c=relaxed/simple;
	bh=IqGHG0lNakwgEmdx4ckFdoSgTGrNLTCbxM8YVcfS1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIk0lJL1e2pF/vsclnyUizJzYjo0Pa0x1Yonsw7K/fYZprTSWQiF6VJlkMC3ZCSj46EapF9+93ZOU4tOa5oLDPKR9fzxkpQIxKlBeEzMvfCcobm31tuUoU66dAYigVtHekoz9Nli53m0UWzusYS+Ozm3MBCFSbgcNLnOySXrRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tGljWcSc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6a9DMxdHHhMB6jGi+pCb47kwfaA/bgqO3mknSzAgzUA=; b=tGljWcSc9Y522Zj46x5QAprZI0
	dj5QzP8Om9CFT9Nd2QgyBzJ1OqdLQ2DuBTFNB2buhIH7fpHlZee/V6eRNP6XDHfwUfx/WsBv5coRP
	V9oS/nmpXF9MkOcHL66aXRy9CQAyMYcxXnTKlUPR/8xgnHZ1zh1OLVPBxAKtccfBML8OlKQFtc9uD
	ig2GgYZmPOoZwRTmRT/KBNsjl5bl8TXpXEP4bWTZt02LMw/MkUkNh5vyYbIipwOuZliAm8vvnKgN0
	Dgfu4nmPkgIx2jEKlvB8yCyE0r+qiTcSoyWx9MnTGkx256ZOWAlDJjFjXHcW7FJl/Lhi3NP9e8hGl
	I1vykEyA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <gagath@debian.org>)
	id 1sYgLo-00Bngj-JL; Tue, 30 Jul 2024 06:28:48 +0000
From: Agathe Porte <gagath@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: vme_user: vme_irq_handler: name func ptr args
Date: Tue, 30 Jul 2024 15:27:54 +0900
Message-ID: <20240730062843.64977-1-gagath@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: gagath

This commit fixes the following checkpatch.pl warnings:

WARNING: function definition argument 'int' should also have an identifier name
+	void (*call)(int, int, void *);

WARNING: function definition argument 'int' should also have an identifier name
+	void (*call)(int, int, void *);

WARNING: function definition argument 'void *' should also have an identifier name
+	void (*call)(int, int, void *);

Signed-off-by: Agathe Porte <gagath@debian.org>

---

This is my first contribution to staging to test if my setup works
well and helping improve a staging driver while at it.

 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 9a0914636..218b19db6 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1265,7 +1265,7 @@ EXPORT_SYMBOL(vme_unregister_error_handler);
 
 void vme_irq_handler(struct vme_bridge *bridge, int level, int statid)
 {
-	void (*call)(int, int, void *);
+	void (*call)(int level, int statid, void *priv_data);
 	void *priv_data;
 
 	call = bridge->irq[level - 1].callback[statid].func;
-- 
2.43.0


