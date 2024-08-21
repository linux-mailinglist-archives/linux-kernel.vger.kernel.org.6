Return-Path: <linux-kernel+bounces-295554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD0959E45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77561282915
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90B199955;
	Wed, 21 Aug 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="6HoUwOoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQHX9G2V"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358B199934
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245940; cv=none; b=mMprJqjWSWxbhHBnifG0m/4pBjZ9ptkHSeUS1MJIpBMz2CYEXdXgH9GYNAgpN7Waf3tbX8WBZczvRk4ciknfVbNii+zM9j+ahzUtHAUu99crga3y1DfVkLGZfsybwU3Z0W90ydkB0mD7brgleAWFuEwnmJz1jDlYOgvhb+Yl8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245940; c=relaxed/simple;
	bh=uhEojgTCYuS4b3VZKYgvzOj1cIxoZL306kOA+EXN7Jg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Os9DoU4Y0eedUE64Ntwa2i70z4pcWUR/k6YqBTu9ovlrSgTIr6/W+qxtnvRDkly6ZYVzH5XJtmRBbAZ+7GPBEjymeK39av/bffsPezKdC2IY42ZgyOMkTj9ktMmSeczkIHpGZzamnCEca4SQJAWP6eSAw0AOEEtX9orlwtbq/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=6HoUwOoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQHX9G2V; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23D89138FE69;
	Wed, 21 Aug 2024 09:12:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 09:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1724245938; x=1724332338; bh=IZ
	1T2q2NbXU3STABROBiLXRJ9ALs+qhd/j21wZm0/zc=; b=6HoUwOoMJZs1pLCxue
	MxzlvfH5qEyKwA2p9kAFQQhPvMj7mxEq0BtqUAGbKIGFqm8uiANajo808iDfOqBL
	XEn/OOMRMG71Tt3w1DTOr2W1PJS32R43rVPZgKPKgjMRhUa+MaFFo/V5k2oF5Da+
	61skgGsQomMJ8gqJUbXcf7vkrRnwjPRkLL575z32HandbQ5J6uLhawJ5jNIEx6wx
	lR4Bb0nRiQIHqc2esWm0EDnz3+IUpgQI2nmGktaPMSo5Q2uvP6vXe6H5OoGDBzjO
	ApHlCjnGCoj/e3kJr0/jOgQq5nLvBsrLGcB21jLWx6s62OlfOqRJ8mfiHV+Iu+Ru
	BIDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1724245938; x=1724332338; bh=IZ1T2q2NbXU3S
	TABROBiLXRJ9ALs+qhd/j21wZm0/zc=; b=XQHX9G2VB2X4JcIBYkDUhLSpeRGQo
	PWtNOogFq7RzdrASO/hAPjqVmx+tBgDRSrdOBGg2ZN3TT67iIzk9a255y28KmPQg
	OGn1MVdDmxnTjTCCjIBmsArxJInpu2dEIBWZY2sPAPNKDDv7mTplzxg4a9MMLBMo
	6Xg4ofVJ/qCtxN32QPeDA07uKemsGTiWTGA9SsyhP+iGXFT6wFWOCPszLTNglauI
	fqNmMR6DTPk8so+ta8LNOHszztwwHaEmYUBw0gEHRjo1Z7JrYfjEzHW37NRdQVFg
	PUNMfejPyMCw9kPB3GOkZmNHNW0kReppoDf+SWoOlRxBN0TsSBMOcXeRw==
X-ME-Sender: <xms:sefFZqoPFDGGEArKykFIdu95rXdRPN1kEJjHzBR9lxW8BkQ2yAhTIQ>
    <xme:sefFZoqDSxAmBrOnR-qY-zVGnkzHqPaM8a8J1mAU7QASlSLcpFYioYhHDQVkWCXid
    UFWWnTqEwY14SvafmM>
X-ME-Received: <xmr:sefFZvNV7a5buyboqdVTR8x7FwqIw9mcBqRCkTYT5jrFr3IaWPuWFsfKYAlg2fwTGJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeet
    feegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    gvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggrihes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghhorg
    htrdgtohhm
X-ME-Proxy: <xmx:sefFZp5WLfE8ddyTEBa_isOG52nWElKNq_IglGvLh51uyxeO0LFVpA>
    <xmx:sefFZp6ZC4YrojJc2J3xkiDRNYU6kVRy_Yk0UBkXlsTKhuk00xp37A>
    <xmx:sefFZpj4gqFGY434Jr6x-jIiHUssEtX1O1T0X1dWE5KxMe55VwG4MA>
    <xmx:sefFZj762d6LXxVkj0rx6A2EgPhjVclhvNfQdTjwq3Jk4geT3G6iuQ>
    <xmx:sufFZnRlNXxOBX6LnOSRuHCYsJNMi-hv83jym9yGboPc_jUMV6xsXaeV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 09:12:16 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] LoongArch: Migrate arch_numa
Date: Wed, 21 Aug 2024 14:12:14 +0100
Message-Id: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK7nxWYC/x2MQQqAIBAAvyJ7TjCRrL4SEWZbLZSGUgTh37MuA
 3OYeSBiIIzQsgcCXhTJuyxlwcCuxi3IacoOUkglain45r1bTLDr8MGdu+GVms2odVPqCiGHR8C
 Z7n/a9Sm9WY2kwWQAAAA=
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uhEojgTCYuS4b3VZKYgvzOj1cIxoZL306kOA+EXN7Jg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSjzzc0R/B57t1xsE2tpeWjOmPmZvPer7MWFnD9WG6UP
 jV7a55kRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzEWojhn8aG9HeKrK3X7y9w
 k3lwq3m/d/nkVxfsxBeuvs8dm90t/5+R4e2dFL8Unvv1Ygu9VwakbG3fvdXwStu+xVn5WyvU/S7
 eZwIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi folks,

This series migrated LoongArch NUMA implementation to common arch_numa
logic to enable devicetree based numa.

Only tested against QEMU emulated NUMA system.

Please review.

Thanks
- Jiaxun

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      LoongArch: Move pcibus_to_node to pci.h
      LoongArch: ACPI: Introduce get_cpu_for_acpi_id
      LoongArch: Convert to arch_numa

 arch/loongarch/Kconfig                |  10 +-
 arch/loongarch/include/asm/acpi.h     |  12 +
 arch/loongarch/include/asm/bootinfo.h |   1 -
 arch/loongarch/include/asm/numa.h     |  50 +----
 arch/loongarch/include/asm/pci.h      |  12 +
 arch/loongarch/include/asm/topology.h |  18 --
 arch/loongarch/kernel/Makefile        |   2 -
 arch/loongarch/kernel/acpi.c          |  91 ++------
 arch/loongarch/kernel/numa.c          | 400 ----------------------------------
 arch/loongarch/kernel/setup.c         |  19 +-
 arch/loongarch/kernel/smp.c           |  43 +---
 arch/loongarch/mm/init.c              |  12 +-
 12 files changed, 77 insertions(+), 593 deletions(-)
---
base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
change-id: 20240820-loongarch_archnuma-64fab779176e

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


