Return-Path: <linux-kernel+bounces-262453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42C93C755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2001C2201A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CCA19AD91;
	Thu, 25 Jul 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="UCfgD8hq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyVQskfe"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C917588
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925919; cv=none; b=Jmhq8p0Q6nXD7jhYmAdoE6+VMAdm6CAltwrYvSJiNtmkdl3mHEEkK08SHBwdv3R+h2L4/lELtprGXC8vDNC5lGdoLCiVFevgGr2nQ6ofL24ePLKa9WPJsZU968whDnoZb+iLsVGkTX4dXJ5tGjftXFtkI9ugsw045BlYz5bnFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925919; c=relaxed/simple;
	bh=OWWDd+9HdGNESPSKb2s7WqI4gVoccQhBa/YTGEXqjjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8SbO74hF9zHVLiVzDhsaYcWZ1vieM0c9Ac52OvuqjY2UqWZh9rBZONrKqb5ls+S8ZIT8QgP41BqxHGfR1RApxVO/pemKf6NBPvYusZCSCE0PSXDjo2dr+7G9DkXjRDRJpkfR1PbfdTnaHtao0yx4Ox2e01XrM5Jz2IdMCCz12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=UCfgD8hq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyVQskfe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5F5E71380143;
	Thu, 25 Jul 2024 12:45:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Jul 2024 12:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1721925915; x=1722012315; bh=zSrUIPHKklTXI0aHpsL9x
	GRLorPnobuR/CAimIpM94w=; b=UCfgD8hqWtbScaHXcrJmjigjm6zNNVYpLJ/ru
	TWF3G175C3YVrpMuw12t5aa90wXx5lUOmR8bmxmnCLbSck+g9NR4dfiWivkXuS/7
	WcLSmNKDc/e4WsFC7kKHJB5DwCvYMGG2Q43jUX4IzdLj1aQV+c8GxPGScqcwTuCZ
	XiQXfgBJoKJu6w9ntvaeo58xhIWubCK+BCPY9sEHgr/HkY2ZhlV/NtndIauRpkYq
	h3DoCLY5ID/M7cIikKS8oFwrh1rC04ynPaJv5UqnR7RgCOCXJxA69Fo0bb/kj7dN
	Fw8aqO13jVaZ7ToLEvh83kgwbnQetvq91/8kln1p/eM1kN7uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721925915; x=1722012315; bh=zSrUIPHKklTXI0aHpsL9xGRLorPn
	obuR/CAimIpM94w=; b=dyVQskfeRA7veJkXVHIsY59yjqjkKpOBCigPVsPpCJoP
	5vGdqg7cI7ueqkLp3euZ7CPr7x+6O1dA+2iOiAL1wrplyQeiQqGv+AOFIC0TW+rH
	VqwTnpoE1inwllEWZdvsb8vXSy/8P8FdRWaQJygzmUVXJu+gpwHjVmDMmIAIQo0a
	/4TNUeooq/lVrX3npznUl05TIthWHncMzPGlgOinzMixv4LGK8XPiV7w+jlt8vX9
	NGZNuMb7C8oSRZ9abj1Dck5RSHR3AwgFEhR7h815/XScZJnAdFYHUR+UFSE7ALYB
	EJ5ZuqeqPIoEckcArvT7vgBkJdKvwwjq5Xnt7Ni8pA==
X-ME-Sender: <xms:G4GiZnIY3fyS6McOKZLwtWJyoDhSlUNvgnHaoQeo_oL61C0KBBFg5g>
    <xme:G4GiZrLwJ_sfkFuiYISl-FMEu9vGfyEz71YnDa9zZRJJPBxREhNtNRbLiR3NzurXZ
    F--MX2pw71yANsSbQ>
X-ME-Received: <xmr:G4GiZvu_uQnpYadLsWbuSMKLjODpRsqu2THsNiSxkQbfXuSu0rYGxZ8-zz6KYn4LfBxBjisvL2TjffeOUW8PsrJvgaNK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepheekgf
    dtveettdekuddugeeugfdujeehuefgleegtedthfffudfhheduhfduuefhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
    drihhspdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:G4GiZgas2fBVjsebcjfQ-b6f0QET_Bz1n60Cj59HQdG0xnF1SuFI3w>
    <xmx:G4GiZuZmByO3aKWpEouQ-zk8QWJCB2wHngyOnsLNUWF_bqUUPftdEA>
    <xmx:G4GiZkAQiGEWV1QsTmUPUuAECeW2P61usAYgoBpVn_pJ3SUaH13h0g>
    <xmx:G4GiZsb8JbPSUXgVTut3UC-GSCb7S4p-E0FMpPv6EvfgLH4blky2yA>
    <xmx:G4GiZlUedIeIfb1BrLV11FzPG2x2X_O5a-xThIdfnzsfq1fAkXIIGSb0>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 12:45:14 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id C1BF134DC; Thu, 25 Jul 2024 18:45:12 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-kernel@vger.kernel.org (open list:VMWARE VMCI DRIVER)
Subject: [PATCH] VMCI: remove unused ioctl definitions
Date: Thu, 25 Jul 2024 18:43:56 +0200
Message-ID: <20240725164357.7026-1-hi@alyssa.is>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCTL_VMCI_SOCKETS_VERSION and IOCTL_VMCI_SOCKETS_GET_AF_VALUE were
never implemented, because VSOCK ended up being implemented as a
generic mechanism with a static AF value.  Likewise,
IOCTL_VMCI_SOCKETS_GET_LOCAL_CID ended up being implemented as
IOCTL_VM_SOCKETS_GET_LOCAL_CID.

This isn't a UAPI header, so it should be fine to remove the unused
values.  I've left a comment noting IOCTL_VM_SOCKETS_GET_LOCAL_CID is
in the VMCI range to avoid unintentional reuse.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 include/linux/vmw_vmci_defs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 6fb663b36f72..c2df94696593 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -453,9 +453,7 @@ enum {
 #define IOCTL_VMCI_CTX_GET_CPT_STATE		_IO(7, 0xb1)
 #define IOCTL_VMCI_CTX_SET_CPT_STATE		_IO(7, 0xb2)
 #define IOCTL_VMCI_GET_CONTEXT_ID		_IO(7, 0xb3)
-#define IOCTL_VMCI_SOCKETS_VERSION		_IO(7, 0xb4)
-#define IOCTL_VMCI_SOCKETS_GET_AF_VALUE		_IO(7, 0xb8)
-#define IOCTL_VMCI_SOCKETS_GET_LOCAL_CID	_IO(7, 0xb9)
+/*IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)*/
 #define IOCTL_VMCI_SET_NOTIFY			_IO(7, 0xcb)	/* 1995 */
 /*IOCTL_VMMON_START				_IO(7, 0xd1)*/	/* 2001 */
 

base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
-- 
2.45.1


