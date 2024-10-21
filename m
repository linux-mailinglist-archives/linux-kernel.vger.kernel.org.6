Return-Path: <linux-kernel+bounces-375031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42399A8FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD38B21B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F101FC7C3;
	Mon, 21 Oct 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="dpfujiBV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCn1CRmK"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87B1F470E;
	Mon, 21 Oct 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539529; cv=none; b=NWqRceQr8CIsMPXS2KYT4JBLHZY4dOJ44I9fwh1wwv4MslModSoPc7EOl3Vgr7lItHt51DcVlgzg6H/kqTQl2Ws63js0WS7gQ+5aTh7u0xce+WVYNXXBWEY9mH0l5zZa7PDi/YBOBObIZcQyQZIvt0txAu4NaEHYVy+kFvGcpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539529; c=relaxed/simple;
	bh=JOqGIJUy+8+O0XbTcmFBJZzS+v6x80z8AdZpFds3QhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sR05Mhj20lYlwLYaMJBZHHc4QHXgV+cyWhCRD4RU1W1Jue14J/VqfktQ18M8BsLjd/p7AoxHbddNCUTRDJTEZvP0JQyE5hCWhYAz9gHn0ag/9kkdemml8TygkNe3OeopuNiBaxNA8u3mZ5mqU2mPg0XBBONz+oeNU2SmwZEHUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=dpfujiBV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCn1CRmK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 72A6E1380307;
	Mon, 21 Oct 2024 15:38:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 15:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729539525; x=
	1729625925; bh=yOzTdihS8e5sBdwni/5F9R9burodzXe4NHoQUPQN5ZQ=; b=d
	pfujiBVBIz97vFUSOC65/UPBpXL5MDukDfhn99PzKfDCfpB3Y1X/arBtI8mcqDPO
	qOhpKeeZTIY4K1DX03gMf90/XVgepmSr63v6grSqJEjy2lMHrWTpDVJw7CdcPu+8
	hVcIAJXKHWId5YFuVYbQthVZIrVEi+HNDkmK7R346UGTQThaNKkBJycYTpX/XBc5
	XX2tjZtdfhpPQNtJWnaBQTEKDvqaBlg5lPu6eIKo6AhRy8ND9miJp4lrgFKpfYXY
	rzg6hkQubuTKPFbkh/NE69URGpc8Sm9C4aulq41R4NtIgWM1d8yCUkZakhJmsJ/q
	fAMwr5p5D1lZLIZy72Qkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729539525; x=
	1729625925; bh=yOzTdihS8e5sBdwni/5F9R9burodzXe4NHoQUPQN5ZQ=; b=L
	Cn1CRmKQ3S+ayMkONfXdfS8vJUsR0fblkjI6Gmc/io4sLtuuvPwjpKNKM5koDdN4
	dZ03DbkbE1QoZcBcUiFSUngvr1H7vLMZRmerSxsPa7JbWyrS/CHRQ1Bb7MXEFfvW
	eoFPLGcTN85NcxMzGvbuJqW/OuZJZ2xUSPgpgG9u3uoN4OtNewXpdatYS72kzhY2
	/VE50ylKreetGIGp0CrGO6rkUAqURFVq+pOqd5CuLJx7rWmIJIbEICKklHortoze
	UvIkfwnF0LYHOd8ZwXuqdZMAD8puxxqVgxNYP5xOT/p/y/M8zUflCpseF9CQdyAC
	4AZTRqHpRcD8ODcQxGoMw==
X-ME-Sender: <xms:xa0WZ6StS8RRnkMvjV6ykGA9kRTrYD0Daj2HkI7yKZNxSibQi8bzqw>
    <xme:xa0WZ_xiYCWq09NzQRAMdZb8MvU-AS4oMXlGapVXXfSk9PRJ6dLHivtJL2bVKdvly
    CsiQJb1_5PuP6qhBpg>
X-ME-Received: <xmr:xa0WZ33lqEKzL08S7qW5EvHg6j3b7B2TofPolDEAwaZZstEm1FvBh-MXQLCb_T-HVabWXY44nxE4J7Q9ZMeSH6YMZhDQC-mqjxM_REWnvzQeerDexw1gB9Xtdw7JJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduuc
    dludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peforghrkhcurfgvrghrshhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteei
    geeugfekhffhgeejudeuteehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohephhgu
    vghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvih
    hnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhm
    qdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xa0WZ2BwN1oo0wFW2MLsuZsgCWiDOI22RWgVHWNmLr-mMSYwzdLAMQ>
    <xmx:xa0WZzjdVE0jocG2N2aMn-sP-PgEIm-T0BQWHSc9Jt03r8npJy2_cg>
    <xmx:xa0WZyodaSxietXxcsn-6j-30Qx29Nji6h5AuTF2NoMHQdp7-TZtPQ>
    <xmx:xa0WZ2i4ShrzmdS9vQxPKt8SieWQFZCZ-DuD37eWJayqW61ju7Mp4g>
    <xmx:xa0WZ5bzgd69Axli-P2fNda_EBPpQOyIXfU0CHInTBzpY5G2enFPymVK>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:38:44 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: think-lmi: Add certificate as mechanism
Date: Mon, 21 Oct 2024 15:38:24 -0400
Message-ID: <20241021193837.7641-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As both password or certificate authentication are available as mechanisms
update the documentation to add certificate as an option

Update driver to return correct mechanism appropriately.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 Documentation/ABI/testing/sysfs-class-firmware-attributes | 2 +-
 drivers/platform/x86/think-lmi.c                          | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 9c82c7b42ff8..1a8b59f5d6e3 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -193,7 +193,7 @@ Description:
 
 		mechanism:
 					The means of authentication.  This attribute is mandatory.
-					Only supported type currently is "password".
+					Supported types are "password" or "certificate".
 
 		max_password_length:
 					A file that can be read to obtain the
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 727a9400d406..46ab82fb2898 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -524,6 +524,10 @@ static struct kobj_attribute auth_max_pass_length = __ATTR_RO(max_password_lengt
 static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
+	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
+
+	if (setting->cert_installed)
+		return sysfs_emit(buf, "certificate\n");
 	return sysfs_emit(buf, "password\n");
 }
 static struct kobj_attribute auth_mechanism = __ATTR_RO(mechanism);
-- 
2.47.0


