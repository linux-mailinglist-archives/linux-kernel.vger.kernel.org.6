Return-Path: <linux-kernel+bounces-262481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0F93C78D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818601C20CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E819DF6D;
	Thu, 25 Jul 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="BwefZ74Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2anQar6"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8219D892;
	Thu, 25 Jul 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927537; cv=none; b=cgh60ppiYCcJGonlSFc+kohEfWBNwjrOZJUtmme1zytXqeOZPcAmM2ZMnzyIJRZusVeSqd8aqbSBFIwapfZ83EcLZm4g57wEObP+HshIqskBrQj0R9YRYiSuo78mtkVcf0DBZRv9LlOrdPhw0UigESUjMaBlo3NWi9atXjm267o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927537; c=relaxed/simple;
	bh=mK6iScwJ8F7KzRYJg61toc89HTeuc6rf7zQCRiwbCwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzuNXzehOr0I5BGb2J7ejulbjaOaKQr3R3Q/omvgOo8xUaEhleVA82A61uvB/XWlE5wj4euViUFiIHIkEkms29DKy5STBl8uw4mGnWxKMx0UFeWR21SKKY7U19xNUnfBAmgAQDab095hVHoxSP7JyBTDl+dEaF/+1/8ftLuICRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=BwefZ74Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2anQar6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C08CD114014B;
	Thu, 25 Jul 2024 13:12:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jul 2024 13:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1721927532; x=1722013932; bh=yxlQWhz3/66ElIrpd99q0
	8wLX+YOObMdUrI3CGoWqYc=; b=BwefZ74Y1VXPXLui2lg55FHMPhxqZr0Xcjhx5
	ij4qo988WqAFR+Zwo31JJtoa8YUqyy05H6UV2bHrkzXwnCInQjTk6wYngaSWlhNv
	1YBBaxyQFdmb9ZvZcMiBOHOcCZ2XZKrMjq4DwPGWKbqJdP4eT11+WDga8vwMhsHm
	+hpmL9ILevb1ipYtSWLw7hfAqRMUqCnQwuzxMpR1baUKy6khs5xeSF5YgNJdOy+I
	IflKj4/VAWV6wcSQNRKhPj03BTxf22cXTW11ofe60/VSV4tJ+lVElwTbvNyVwTnc
	JEJUgMUXuthgKJu7AGEDfADQEU85mjGDfJoY9KDbLcXsuVDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721927532; x=1722013932; bh=yxlQWhz3/66ElIrpd99q08wLX+YO
	ObMdUrI3CGoWqYc=; b=B2anQar6valT38niQd9cXQVIzhjqkKeTW8/1c3CAp/0b
	RL5gGODaSUlbLwC9fRgrMstaImRypSr0t4Z/0qfRk4YpylBNOjABJLjy3hnINMnn
	KM1hR4IAadu98oPdg63jY862Sjg4nfwXkpWdkNx5DbSu1t6Lk5fGFaEuzC/H5Ml1
	PE1S5zHmkzgcbOJVh29y6QPe8L/WRIIKTbIZmRTOdFxVBrBrTYdojTL/1a3/akLf
	yh/iFqlThNV4JP7OrOAK+/h+3wwfztBLRXWe/KHZ45nGNWKQxpmwcbP2yNP5B2SM
	bMk/GzDSChTdBxVCjMwFSnsei1lGvypYzyfRbawOzw==
X-ME-Sender: <xms:bIeiZssogOYHjhPfrZ-3lMOZS155oX2bM6ZDkQqvusD0AE6HXIMyPg>
    <xme:bIeiZpfcUTY8O2lk_XaDewjhvKBexeQQ5cFuCCfAAH-nMZvDZqLGmQiQqiZREyi3w
    _zTEaqqWyKq6G_72w>
X-ME-Received: <xmr:bIeiZnzunvGqoQdXKLg6dciRBr63QbGXeuaYH8In2wKsZb9Q6bb5iBV1a7tc1pe6-XVQ4eIe4MFXfj0lt4L_4fQ7VyAd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepueefie
    dvheffveegieejjeevgfejjeduveekffeiveeuvedvtedvhfelieeutdfgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:bIeiZvNeIlLh88H60JVbO79xpfBM41E4qQdW5mm-mIX8jvnp5FPT0Q>
    <xmx:bIeiZs-DOFjeLw2Agjopq6tyK8baTYqvBT5-xDqlGhAHNx43alBlfQ>
    <xmx:bIeiZnW1Nty9tQRPKA3u3JnriAAK9r_F0k9LW1ASYvBZngRV7AXnQw>
    <xmx:bIeiZlfyyxoxwVFGYAVIrpJgrLOq4OCGVbN0s0xEreZCavCr8wNZ-A>
    <xmx:bIeiZpO6V_X0P052egUO5p7Tzv-dxHk23jk8eCKl0RGO5umhUedlNQqp>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 13:12:11 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 76D9B34DF; Thu, 25 Jul 2024 19:12:09 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	George Zhang <georgezhang@vmware.com>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Documentation: ioctl: document 0x07 ioctl code
Date: Thu, 25 Jul 2024 19:11:21 +0200
Message-ID: <20240725171120.12226-2-hi@alyssa.is>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like this was supposed to be documented when VSOCK was
added[1], but it got lost in later submissions.

Link: https://lore.kernel.org/20130109000024.3719.71468.stgit@promb-2n-dhcp175.eng.vmware.com/#Z31Documentation:ioctl:ioctl-number.txt [1]
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e91c0376ee59..217bdc76fe56 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -78,6 +78,7 @@ Code  Seq#    Include File                                           Comments
 0x03  all    linux/hdreg.h
 0x04  D2-DC  linux/umsdos_fs.h                                       Dead since 2.6.11, but don't reuse these.
 0x06  all    linux/lp.h
+0x07  9F-D0  linux/vmw_vmci_defs.h, uapi/linux/vm_sockets.h
 0x09  all    linux/raid/md_u.h
 0x10  00-0F  drivers/char/s390/vmcp.h
 0x10  10-1F  arch/s390/include/uapi/sclp_ctl.h

base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
-- 
2.45.1


