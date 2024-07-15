Return-Path: <linux-kernel+bounces-252605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D59315DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D281C210AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B118D4D6;
	Mon, 15 Jul 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Blp8ciTC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9RD8IrN"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A018C180
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050544; cv=none; b=Mr0T5YGYx13j1yx/Dxhid5foenDQklvn1eVOGgwoacIwWMTp1QiXkK+lsjH7K21x8xeRSNoNhYKuZy1nwWIWLWmkPWkUyECgHxcPh+R+oOohqyCxUsPJ5kFwrKQsHHITKuRRLxv4Z6d2c2HJmasVRiU8USEcmeVZbRwo3fflzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050544; c=relaxed/simple;
	bh=9N4VK6OlleUkPElKSufsTNigiHYKreppFGb0UZluLu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K7KAE0a/d3YO4SyhOTxFrQnFbRM/eAaHvQ4mvYyHIj966W2KHUY6SHvK+fVz69wZbAChEbIwH2N/W392LP7/uygWRQNob3lXNTYvo8ZyzpN0supwYKWZm1rT2NNBSOczuOTiaM46kIDw9rqyMuAOP3VDBGB2DTKWz+Qzt+X/Z5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Blp8ciTC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9RD8IrN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 44CF81147F5C;
	Mon, 15 Jul 2024 09:35:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 09:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1721050541; x=1721136941; bh=fy
	uIMYFAg4AM7SgVMKD6ENJp3aTbBjQEdLJ7cpZAG1s=; b=Blp8ciTCySOTgIDuNM
	Bqb/9gKPM56PDvPGLwEZ7188Gu9OYi31V32dgI10MjgdODbgng8orcL+zUBGAygF
	y4CpWOtroJ+NdtdKYROIGkzc+0qLTsIwQFD8ecdawMSAPk7YBXxnorMJU/y162uo
	0zBmwHpOuZ4EQJX+M44YC745AthGv4/3r9gGI+BQdbkNLVxftoEK0uCB/sJXcENu
	rnWUo8MXR8qG/PXw80vKEqZUSYSr4piLtXYP1BsulaGOKy6nMgkvF0/5Ni8Ri75h
	NsQ7aifzA3y9VI/f0zvBpDqhhPiw2OQs4bBiRfNpv6rhRYpWywXYpddHd8E2DRfd
	BZVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1721050541; x=1721136941; bh=fyuIMYFAg4AM7
	SgVMKD6ENJp3aTbBjQEdLJ7cpZAG1s=; b=i9RD8IrNeWb1k51dHWzqa8PRJ77k2
	IQaeHFWxzcgoSlj2GK0R4G8/A2aCn4HtcQsN/I5Lpdu8iebXhmdwUmoK0t2qYAcE
	iyg2+wQ4wnkckrX5NL7k5TOw7kWI+5lXW+V1g1uBQZQZIu8+HjJWuBgo5yJyVUnr
	IRZ5nEX0JLgTSw/Cuhjocb+zSs+HMT7Wdbuu3J2v7ZzAzVNB4O+QkwoGBEZmmiDc
	Q6pYdiz9ZIhC+Bfg8ChuWv5bAFL7mDhTRfwJ+Ldhk8DwbYgu7zpTYfdvRMtH7Rvb
	+j+bOeZcKy2ZB4Prdvqy4BzUgkbVCvEONIKeNAXxpmWYZ7zE+IysiFBfw==
X-ME-Sender: <xms:qyWVZkFL68RneisTHfMhjs7x8lJ95QjhkGu-jw3CRY779qLScAfPSA>
    <xme:qyWVZtWMrUOEqDNQwnpCRsapRyqiv0BGKmLHsPD_NU9y3uMrFdCePoDfsjBbErXkE
    058qBy6aK_wd0RpJ5I>
X-ME-Received: <xmr:qyWVZuKsKD9KSuvlQAwQfe-gAAgUpJYUKZ4Bi5sN-qn-W0Rnc849oE65KDb2P3i_zAaS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefhuefggedvueeujeekjeetkeek
    vdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:qyWVZmEU4BAY9jgHKn8IZ_wzvI6Vk9FTj0kFCoGRJEh5rf9VpnF_gQ>
    <xmx:qyWVZqWXZ6Xbkq609fEmLEoKQPACAAR1udYVYk6tqELTwVDc1Gohxg>
    <xmx:qyWVZpNrXOIoC3jnqgs-v5h6yNWC_5z9jKr7FyhFHpY4ZyLkFs29pQ>
    <xmx:qyWVZh1xIYLXI3wsXRa9GDZ9HY54tq5H-xxCLpDlV2bDe3KBTqwH4w>
    <xmx:rSWVZlH2Fy33ORYUMsS8Fzz2vmsHZTdFvqkrH6E2DQWhpWZmYlH_mpw->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 09:35:36 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/3] LoongArch: CPU parallel bring up
Date: Mon, 15 Jul 2024 21:35:27 +0800
Message-Id: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8llWYC/22NQQ6DIBQFr2L+ujSIVKGr3qNxQRGBhPoNUFNjv
 HupSXddziRv3gbJRG8SXKsNoll88jgVYKcKtFOTNcQPhYFRxmlHOQmIk1VRO+Iwz+FlSTMKwdq
 HEIo3UHZzNKN/H817X9j5lDGux8VSf+2vdvlTW2pCSdsNUvOOSqXkbQyrRZXPGp/Q7/v+Aetj/
 IO0AAAA
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=9N4VK6OlleUkPElKSufsTNigiHYKreppFGb0UZluLu4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSpqise35T9c+0Jk+mynASr6b8lVkserH3l9fHObXHOu
 dH3vnq+6yhlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJ3FvEyHDW4t1lz8czRTjm
 JL+z2FDs+r13lejcTdMiqje2Hb7Tv+QUI8OUs2Wuyx8/3iov8Fwinb9PivHnIo39Enond91j7Fg
 8s4YPAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series implemented CPU parallel bring up for LoongArch.

Being the first non-x86 arch enabling that we need to fix some
infra in patch 1 and 2, then implement everything in patch 3.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Use stub functions (tglx)
- Link to v1: https://lore.kernel.org/r/20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com

---
Jiaxun Yang (3):
      cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT
      cpu/hotplug: Weak fallback for arch_cpuhp_init_parallel_bringup
      LoongArch: SMP: Implement parallel CPU bring up

 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/smp.h    |  6 ------
 arch/loongarch/kernel/asm-offsets.c | 10 ----------
 arch/loongarch/kernel/head.S        |  7 ++++---
 arch/loongarch/kernel/smp.c         | 35 +++++++----------------------------
 kernel/cpu.c                        | 16 ++++++++++++++++
 6 files changed, 28 insertions(+), 47 deletions(-)
---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240704-loongarch-hotplug-3f8826b88a43

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


