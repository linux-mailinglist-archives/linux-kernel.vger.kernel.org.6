Return-Path: <linux-kernel+bounces-295615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BD959F13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F7E2845A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30EF1AF4EF;
	Wed, 21 Aug 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Ta72rAEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBuQ98Vp"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59C1AD5DE;
	Wed, 21 Aug 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248269; cv=none; b=bjSqRM+bQQ+MqOiNHmDbZimGtnwn/PDo5gv+qWHFWzoA9adp9KNx+YMvAxO+/Dm+B0WFuYJ6+gIBKS8du2WHRfcMhW7PrxQe5BY8TWJll8fHf9qrT2fCp4f4uYHSgCxbHEgwgsJtbZt1cEjSJF498s1qnBDmIF3FWDOqaFOLvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248269; c=relaxed/simple;
	bh=VREe6dmeBlSWDixcHb6rWQ3okpY5wc40Tb/3plHA1kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AH97Kj3NtEOXJY90CZKjzMfgx4zaznTMBqg3h99yl48pUEM+T+tyO6vndUldWCypYkLKxTVQshZs8GgE7LT4xL4Bug4n1fUXGpHovC+3RxrPG1GHZkFTxEWbjxS90nE9ygzgcmbQJ8RdC7XVahrf/ECA7HWT1MAiNovfSRN0SkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Ta72rAEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBuQ98Vp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0B2211151B89;
	Wed, 21 Aug 2024 09:51:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Aug 2024 09:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1724248265; x=1724334665; bh=bT
	nHbaMxlSqh0j7gqkS8t5Ui5kNr3bqywopcDANcfpA=; b=Ta72rAEcRqAT8j3v1z
	bI7xHgypypRLfAmbLODAHVOBO2B5cvi1GkYTVN+Y1fIaAhJWbCuQ/JCdach8/rb1
	/7EZM3JgCkpdAPgJB9eMKUjYKn+493xmfj573uGeYe1FZkM1q23LTex+Ba21jt0X
	ulTpKZ4Fr4Kl2nnQKzkmpcIKDFjUrH+gWH3Yy9X7fWGwQ154Abhw9wjWT6MqxGLZ
	lKX8sEnhuyeSm4suB1Vc3AnWiRcw2JG+tRmxmejxZ/7lOy6cgWmSZQYrmZSZBk9+
	TZwxwfE7Iw7wKEOn+YH+sdAi/h00xOPkw29IQv2s26lSFhuKTo8m7D6NnyT8bMQO
	odLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1724248265; x=1724334665; bh=bTnHbaMxlSqh0
	j7gqkS8t5Ui5kNr3bqywopcDANcfpA=; b=RBuQ98VpGBxJf33RDGY5FxDaraayo
	Pt2QRtNlJgnRfuDaFXmwmNiltPkWxsWAbxkvcgkJdD89T4joZ+O9inaPBnMTT3Q5
	d1jHrAP1l1ejBBD82YGxv64/MwyWQAAGs2mRKraUfCyavywlwp2koA7lP36uWvgJ
	B8H3SqOlL2ZUxXbMXJ3XZGC0uiKgD1KGW75bWxTgNWPFDuM1dpjB5zwgprfEVcY/
	XBy+TJXLHmNxYayadU94gihQ3Of5DkGH4gTp3ctLCifjtRJWlPejZpRg0XX1VeYf
	kgbfFosH2vi19TQa10XhnOgB4VMzA2GJ1gfRpc4DGExIXJnrS3m0f0XCA==
X-ME-Sender: <xms:yPDFZp9iXxkrQiNGFnkgQ1XUf68_cqNttGWOB3fa6szmkAoZdrW2mg>
    <xme:yPDFZtvzwZRGO-6feaFi3SxQ65dfwKoCRYOeXItrjybi862Krt_j95hl0QcFvJQBj
    Uswpu_75twWIXVZGRc>
X-ME-Received: <xmr:yPDFZnDu70aUyfCYprOOLHfGj2o8kTkCbbPpf7h5AcvBB1sI7CTDqCq103mAeuphGr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
    hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomheqnecuggftrfgrthhtvghrnhephfffgeejgfejieeugffgudegvdekffev
    geeuteetgeejveeiteeivedvffehlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghnkhgvrhgvfihpoheshhhothhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjihgrgihunh
    drhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtoheplhhoohhnghgrrhgthhes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yPDFZteRhPhkW_XshafjUYucxvx6h_fFoSbbkjtjtarrh_YoypJe7A>
    <xmx:yPDFZuMG8QutWk8lZBvTVtuUjr3TEWUs5skEcLkRT3zBjbxbjQgbmQ>
    <xmx:yPDFZvl8-lUEWtMpxzUf5GfoqTAY7t-SIB0yotBUoxVmT_Qa352B_w>
    <xmx:yPDFZot9GD40aQ9oinvA1upeq8O6WtHuc54Lz2m4gAlqrWsOzg8wBQ>
    <xmx:yfDFZvhSNyWGCg8dbYpM3FvjM0wTmKTfwKPYJZzHrZWf6oo_kFuq_B-G>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 09:51:03 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 21 Aug 2024 14:51:02 +0100
Subject: [PATCH] of_reserved_mem: Save region name string into struct
 reserved_mem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAMXwxWYC/x3MMQqAMBAF0auErQ3oahG8ikiI+tUtjJKFIIh3N
 1i+YuYhRRIo9eahhCwqZyxoKkPzHuIGK0sxcc1d7bixGjJ8gmYfwwHbrQyeJ+dcO1GJroRV7n8
 4jO/7AbP4YQJgAAAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, chenhuacai@kernel.org, 
 Kevin Wheatfox <enkerewpo@hotmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VREe6dmeBlSWDixcHb6rWQ3okpY5wc40Tb/3plHA1kE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSjH47/E5kuum1qV1Tj95++B9VU3h458TYn7PQkjX7B7
 8xNL2fqdpSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBE3J4yMpw4L7un0uX1vK9/
 subemqJd23af112jdaktX9Oyfivdn3qMDNe6626zevz6GvvwYNa7bY9n5v68NbnKMtJMJytmb07
 APg4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Previously only a pointer to fdt string pool is saved to struct
reserved_mem as region name.

As on some architectures booting FDT will be wiped at later initialisation
stages, this is breaking reserved_mem users.

Copy and save the whole string into struct reserved_mem to avoid
FDT lifecycle problem.

Reported-by: Kevin Wheatfox <enkerewpo@hotmail.com>
Closes: https://lore.kernel.org/loongarch/ME4P282MB1397447C3C094554C7AF2E37B58E2@ME4P282MB1397.AUSP282.PROD.OUTLOOK.COM/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/of/of_reserved_mem.c    | 2 +-
 include/linux/of_reserved_mem.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46e1c3fbc769..22841599cd83 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -70,7 +70,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 	}
 
 	rmem->fdt_node = node;
-	rmem->name = uname;
+	strscpy(rmem->name, uname, RESERVED_MEM_NAME_LEN);
 	rmem->base = base;
 	rmem->size = size;
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e338282da652..ed9de36c9cc9 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -8,8 +8,10 @@
 struct of_phandle_args;
 struct reserved_mem_ops;
 
+#define RESERVED_MEM_NAME_LEN	128
+
 struct reserved_mem {
-	const char			*name;
+	char				name[RESERVED_MEM_NAME_LEN];
 	unsigned long			fdt_node;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;

---
base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
change-id: 20240821-save_resv_name-4f2e2cb8883b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


