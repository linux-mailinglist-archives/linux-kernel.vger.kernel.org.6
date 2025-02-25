Return-Path: <linux-kernel+bounces-530747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B00A437C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606161893A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2D25E469;
	Tue, 25 Feb 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a4mR7q78"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA04215F7B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472633; cv=none; b=MC9uGU3y7qHpntyGT9FT9FOzQY0eaYq3kuE/mZDWFi6WmK0R3ROtqeN9AeYTw8OT1AyAggLLJH3AWnrMmFjafOhLTT0YTJR9sHFiiBf48RYXb4fqikCtYtbS7rHOUyfNUKV+Fp09IrfMfo9T6J34/1qzKbvc6g561UrKgDQ/rFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472633; c=relaxed/simple;
	bh=ElkRcRcC9BTO7H5jfSF1QHswt8xyaeS2W3ZojVAqfjg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u/5na/ijfTQMFlDeisxeZAHcJNUITpI/DgvXwvJrL7qxCbm9eMlZjU2fxvclg5vwvVbp+Q7SRqPes7C4DiK52sAIwOO1fXsJ3vChCMUWNkzJdP/SwxGk0SVxXuSFqWvVyGXNAqmlt4KAEQjrbsa3tR8WKI5a4xdrbvgsHKgQpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a4mR7q78; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740472624; bh=S/FFL1KTyAN1SCxYwd/nei5gKa0deIvjHt1fYZZAH8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4mR7q785cfwVk1vlwih9r8azFmuC65/pojIHnZGhuivkylVaxgstNIo9i7gvJ95t
	 Y2A96JO7Y78H5ZBoZ59Q0PDpkC4DnPXCp2grGBmdF5Y06V6tXOrYW7wbV4Dj/Sn1zK
	 aB2jXQPgiIS2oFtNXRk7YhhJgeCZUWAJboxHGNQU=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 94231688; Tue, 25 Feb 2025 16:37:02 +0800
X-QQ-mid: xmsmtpt1740472622tvrxescdg
Message-ID: <tencent_1C33E69E051B5B4B211B972571BA1CBB1C08@qq.com>
X-QQ-XMAILINFO: NDAhN78L72+TSkgFZK690s6iStuka/9NzeeaCPXYeeisv0ECEwpyqwZngQJWJ4
	 mPMNML6B3BWH+3bOmaasYxZySv2TY3nDKS/d8OmJMYe3GBRF1nOgLZ3on6Q4nsorWbHlHTY8NDHj
	 SE1mwq86SWfw7K179xAx5vg6SinRyeitYPMdsuPqDE1FL43y3B8Zli0Yz1qM8TcesIFv6P/Dua/u
	 DA+tb2w0lBl9QeNkonwZe1PNVpTgt2EMOH6VOwhkVKydAvr3OhxnW5JLx/pdB6N59xED3p882fZa
	 CKZXptiGOcGGwpZKYjri3isiz9/vXQpcjXX+0rVlCsZhIWkHSPSzhq21aJvoG4XL2efAlRo4c/mZ
	 yYsiC7JbxrY4rT5QobWTBEWBW+xMgkGJ6EYUphFkaA/uerZMi6voiL5vGRYsY4aFdw8QfydejdV0
	 /L1HxDwoV+9vdACVaP2oZ6KldEfp8zx76+tcmU6jUzqCe9vMb3lMeowstbgs5ggNRVUXTi9P8AOL
	 dFEJcep4XmxSgMAXpEUkD0JcQbSgvgNz4YdiM9RubTCYIbZURko3IqBSDzTvmFXeUQoMnOCKFIJk
	 oWEUwdXpt/Dpz9I81jlZSKRyaTLg4q/v00Fc8ujH0e2PXzeQpzLjCHmNQ3pZRluuKFhBMxiyjLHA
	 T7IlEv6Kw9FvcCys2bzJmh8XMwIPOef4s+ZE8EpiudG4llBTdZP8LU/4WLpRNdq8mACGY/uQa+bF
	 3Cg7zP/npQecFaPSL76RdWTv9AorDZ9BjJN2E4Gr+a2uII5daMU95EinGlvDadEI1HPGWzvla4nx
	 CXTUmAY/oMqzpSc3KuPMyjll4zsEN++V0+nuC0k+F7hKP0FfuCXQIK3oBM/O7zbFpfDadR5Ek0DY
	 uOHJqpbRNzOQ6CSnDBueU4y1M1oKhrM18p4S1sTf4q
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+556fda2d78f9b0daa141@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] [mm?] general protection fault in lock_vma_under_rcu
Date: Tue, 25 Feb 2025 16:37:02 +0800
X-OQ-MSGID: <20250225083701.1218150-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67bd7af0.050a0220.bbfd1.009e.GAE@google.com>
References: <67bd7af0.050a0220.bbfd1.009e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/memory.c b/mm/memory.c
index d5c4f932b399..a5b1832ec8f6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6492,8 +6492,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	vma = vma_start_read(mm, vma);
-	if (IS_ERR_OR_NULL(vma)) {
+	if (IS_ERR_OR_NULL(vma_start_read(mm, vma))) {
 		/* Check if the VMA got isolated after we found it */
 		if (PTR_ERR(vma) == -EAGAIN) {
 			count_vm_vma_lock_event(VMA_LOCK_MISS);


