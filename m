Return-Path: <linux-kernel+bounces-241902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33179280EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0751FB247BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223F3D55D;
	Fri,  5 Jul 2024 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="l0hK18iM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XB3NGFDV"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF61F94C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150186; cv=none; b=Dha7gXt4QW/kK8pUGi0H1V6DiSNsu2EWtfdWM7fdKlfVsXXGms+0KmtOouxL4yFOZNL2ud2RaPy80l/v2KUka+qqTmszAgw4qIs6cGzCKgOHvzTQh2Kg2APpmcKP99XAnClD4EaAJvZovh4rvgf122E+FDVm6/iboMERZxXIR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150186; c=relaxed/simple;
	bh=JoiE69E1zlTXTCtPfqKhix7BSKVKIRCxzPOGKCLXqk8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2EtDU31298VRyJzWbqpdkdmMpoPZUE/Nus/Q5MMJsO2bqt0FTk9aGZ3Cfp95iI4LRygtT0bDv5E0pMmQNvLvSyfr8UXxmIHnrv0zpN3yi8WNjtPsn/H6tPkHpFgRwffI7H5Oi8CmmqDhI+NCUrJ+NLmeucVMNUqoazOz48mp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=l0hK18iM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XB3NGFDV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id BAEDD1380281;
	Thu,  4 Jul 2024 23:29:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jul 2024 23:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1720150183; x=1720236583; bh=gU
	cFZLI+jyclOePzN4QN3A7vaUMpYuUHDBMaek3z+nw=; b=l0hK18iMhG6/pzQnUt
	KdBsLylWJq8X235wCC57PA3edOfdor4F3lMmgE8GLbVlLkY9WKNLEMJyL3Jx0xM4
	tP3EUim1ifGsAqhjdBekvXOQScU+CV6QI5qiUrCBIQccHCedeMwdV7SN+Odw5sDM
	oHI8PNT2eL63qGA2Uzq7B75OOlTw9zRKqB9eRZgualL93Fyn8eIWh+un0L2IqXRZ
	C8n00lNXFU+HRgT545Q8A7aB3tRFx13Xluo0iJO61B5m0BQORaNi2OxKO+2E/LgP
	Dvg+KIAz8tcK9+QYwS4oiwvtcX15VZGvEyvXmx614Js3xSdzveYMrZfQOj8+D326
	wl9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1720150183; x=1720236583; bh=gUcFZLI+jyclO
	ePzN4QN3A7vaUMpYuUHDBMaek3z+nw=; b=XB3NGFDVCQl4rcqGnfHM+NviZVqwE
	4gALkE44simtGfPFBZVEnlbJIs4RZjcaqI1aqh9tXvr0qJx7X7CjJYUv712KCeTj
	xOZOO4GJtqlbLw1drHfMXK0r2Mp5Vx+ngEVxJN3JJIJzFo8izKUX1D7u95yoZLfv
	4lrac3jMNaz/h34LOT03iaMG/NbAxPlnM1p1Erg72+lEOAzWdp/mR+usqlEqFmj+
	dh7bfPK0FxrXZp2b7NpRy2+R6p0pGLTadttHtjuFYKxP1UYfLKW1dIaEd6R9J/0b
	Sg7vpg9Qu3+RshltfzkAHlXl/IyKI2h/wxq8sZQ6QnrBejZeVt2pfv/qA==
X-ME-Sender: <xms:pmiHZqEzLGltaGzYVFJ49y2py8pZf0If6cdKrkhJejMbZF9iPzNOAg>
    <xme:pmiHZrW9lvzZd1-RSS6ZcX92VfxHEippIIEzPkfOtoqhQx049b8cbCq4eHmVQ16gT
    mcyGxH3c-_YKgMz9FI>
X-ME-Received: <xmr:pmiHZkK828pDKy0cy2q0ort_n77Sxbr6Ja0fg4LNOR6XhKFC4fgl96rqpITm4wrfA0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeehkeev
    udevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:pmiHZkHgbdjh6n-ZleBq52iQy8drikDImuTnWPcadXn0ySIuyrp7QA>
    <xmx:pmiHZgWmcjSRTU18YZXG2eTx7oMaZz2YHXBj-y870gnaagEKsq7L5A>
    <xmx:pmiHZnPKezn2em2LVtmUnLT2ghJgRp711WnpUFiDLIm5Jef_RScMMw>
    <xmx:pmiHZn0WOoCoxHPAJZwFfsJmQhcwtJAsEMxyCJCLwjRJSnz2H8YOAw>
    <xmx:p2iHZjEfLxgdV4d3jL4GNYgNbvPGuOq5nRpuZhniIFTSz5hQXwKB1T0X>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 23:29:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] LoongArch: CPU parallel bring up
Date: Fri, 05 Jul 2024 11:29:36 +0800
Message-Id: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBoh2YC/x3MQQqAIBBA0avErBNMpaSrRAurUQdEQyuC6O5Jy
 7f4/4GCmbDA2DyQ8aJCKVZ0bQOrN9Eho60aBBeKD1yxkFJ0Jq+e+XTs4XRMWq1Fv2htlITa7Rk
 t3f9zmt/3Awn4C61jAAAA
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JoiE69E1zlTXTCtPfqKhix7BSKVKIRCxzPOGKCLXqk8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT2jCVBgWZc2cl7r0vfN1dtqU6K7tt6MylkJsefj5Paw
 v9sFXzaUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNhY2D477vFJujZzu68KUmm
 Gk+zmQRDj7ivO1u6wdF4k8iMMl7zCkaG6QIhDK2Zm0Ui0j7x6L9JW8HDu/TILfWvVT3Zm8/uDfr
 CBQA=
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
Jiaxun Yang (3):
      cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT
      cpu/hotplug: Weak fallback for arch_cpuhp_init_parallel_bringup
      LoongArch: SMP: Implement parallel CPU bring up

 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/smp.h    |  6 ------
 arch/loongarch/kernel/asm-offsets.c | 10 ----------
 arch/loongarch/kernel/head.S        |  7 ++++---
 arch/loongarch/kernel/smp.c         | 35 +++++++----------------------------
 kernel/cpu.c                        |  9 +++++++++
 6 files changed, 21 insertions(+), 47 deletions(-)
---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240704-loongarch-hotplug-3f8826b88a43

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


