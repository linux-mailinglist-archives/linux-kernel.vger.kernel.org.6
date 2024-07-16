Return-Path: <linux-kernel+bounces-253222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61B931E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EA1C21E56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE34687;
	Tue, 16 Jul 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="B+aAEDHR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fg04NuQI"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7617C2;
	Tue, 16 Jul 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092303; cv=none; b=KmwcEUQnUAxQywd9GO2zd2+P9oFjH3V7nB3hu034irW4iKAQgvV2ECtVVvfivdg1FGf/BjsG9EgaReBLdD6ucoYrZolGu7Gy1qSYsKvXBBEe+zH012m5ms7MKphyFX/q733TP7/+XoeOzuygWQamN/WRpyaqCHN26j4XtIJafyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092303; c=relaxed/simple;
	bh=pXXV0qeclD2GERXFKg8FbBk0SiSz1gqFqQ0DPMAQ+f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUJWiqGsC/K212b0IhXKKDVaBZzqOjxZKracxIOdrDV27oj4A3FcabpuaVTKbDOhWhCDmo6iZgkGnhjICj4LE3hD0oPzm64u76gfTh4IxzBfauQ+UHwUk/cMR0OpXHPL1W+9i0CrT6d6sDlBzLJ05OO4OmsluV58CmTZ2AB8wQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=B+aAEDHR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fg04NuQI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A92AA114787B;
	Mon, 15 Jul 2024 21:11:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Jul 2024 21:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1721092300; x=1721178700; bh=cejZWtPQO0IwGLaSTev7D
	KSh0JNRB8ZGedTPGjBRKrA=; b=B+aAEDHRdFuYgHsTcVqkA5u+N+HtV4XajmsMV
	NKGVYvPtcBFFbMpagaHXaLhju3MsSZS0mlg7ICX2lhmxQ7WfeXjXhzp4nW1yMefD
	VI/3mN777DhWcv1LeDPa8q/WRcF/n8NCaOm5n0Ncm/VnBr1OVD5A9Bm3sPkUUeFU
	kOlhJfQ9VrV97OIv6nno+mGDsgQxjvvi3W67LDTh+OV6dZU/kLgKmTQCQwlMRpwy
	ZVih2DFUmJj8atM5Omj/Io2u8X5q9q3cWI1kGxobx8Gennm/OT76WO4dgcW+9r90
	qtoFhQqopRAUHseCzJ4GP45RR1nnfP0wgvBHy3amKytOkrVww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721092300; x=1721178700; bh=cejZWtPQO0IwGLaSTev7DKSh0JNR
	B8ZGedTPGjBRKrA=; b=fg04NuQIjM69d56aKHYaXFZNEDa8+k0aV9uJQp+g3Xxh
	dxVdWenjbdRr0jEgc6WJrPluaQrqmQIoPeD3irHJa45cu9ftmXiYp9z1fDujIAmY
	1QKw+1W39jmxAn8k0AjhhTupGiv7EQjAx2jI1BNzn3YES+L0mJJZASkVpRZbdeZ3
	wa8DoZiCZFyUYrV0C8jMd/GqK8ayeQYJRi+FU3/QFED0293BTX9ZyLikXg4A9xyk
	KXbhWkV1cMOz7Oux0QL3HUVs/6RZ+p0dVV6oKYq/1XIXm43QeZHpPnuc5HkpWKGk
	71mjhydUJYDjq7AL9w55TNRcD2Io15Nmygki+wf4yA==
X-ME-Sender: <xms:y8iVZmJrc1LKhLy7ApDQQ6wKluFEzYCJpa29_OjczHbuEpPLh9SxlA>
    <xme:y8iVZuLg7A8d2uv-_AcyXjtkqUClm_ASSRbWOD2vhvuKifDFgPIHEp7Etx1-BFNBD
    d50SlcF3OXyRLkDjzo>
X-ME-Received: <xmr:y8iVZmskn92TI0BhBmQo9Cjd5U4HgOtlFY-b2lhzhEAz_hUTqZOf71YDaRja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpedtheekieeggefgleekueeffeejuddvje
    evuddvhedtgeevfedtueegtedvledtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:y8iVZrYPAvlUG3iS672u50lvMPsAwHX1q68pfvsB5IeH4xUz0ADmkg>
    <xmx:y8iVZtb4CWwqFEQ3t-M7M8WH9KzMmgU2rzH8TuqyMuwaa6icHBymdQ>
    <xmx:y8iVZnDT_W8VQImxcV5KECxBgM9XUJKjoyrdbOV1LnVgc68iJHKrjw>
    <xmx:y8iVZjY45zgWnMXqCVvv7LzX__IHbLFaBYzo5W8wu5emdKC2eSk6TQ>
    <xmx:zMiVZgxTkI_HSkvRSSdjoWdl1rpLwzJynR044MltufXXUrn4L24IF8gt>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 21:11:36 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 0/1] platform/x86: asus-wmi: fix TUF laptop RGB variant
Date: Tue, 16 Jul 2024 13:11:29 +1200
Message-ID: <20240716011130.17464-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
- v1:
  - Fix subject and fixes tag

History:
 - v0: https://lore.kernel.org/platform-driver-x86/5c4ef8d8-2806-5bb6-2946-368cf1ebbac6@linux.intel.com/T/#m9ceb12d4d135e28e71e4d74ecc9a78083a6c8745
      

Luke D. Jones (1):
  platform/x86: asus-wmi: fix TUF laptop RGB variant

 drivers/platform/x86/asus-wmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.45.2


