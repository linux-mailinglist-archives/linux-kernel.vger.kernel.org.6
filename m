Return-Path: <linux-kernel+bounces-251397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41370930464
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7D41F2383B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4B446A1;
	Sat, 13 Jul 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="VdLMYDq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsd0kaxa"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9181BDD3;
	Sat, 13 Jul 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720857593; cv=none; b=gy5sUesREG9XStr6BK92Ya8BgvHAN6oa9tWO6oV9MD1JWIehDqSV6eV3ejfLWO+9vqo5S/jcY9NRzJtrdhd9t10IEK74cA+GmdhoyB7VJB2LPTVa5hVuu6mVubNCZoyZmRtjSPWyHBOLi4lYMgd0RXO4DZwdS2dHYpHkqrwbkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720857593; c=relaxed/simple;
	bh=lJto82Eqyiw8TSB3TU4mBH5L865OKyP+/4aE8WRQ8gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ist5/bxxKWrbsCeTMzdb4FuYAjEeoFACzgZrWu7ZFVL+jHGwvxofvo/bdF/QbK25RKM8tgEWBQQk22l7MSC7QhN5GbiQhsctJTWaV02MB34ypUPEE7NYoio9Q9crK8yg4bej37hQOqO23Zs+6dU7UIXuVk6E9qgXDAV6ceBs3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=VdLMYDq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsd0kaxa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2C931141C9F;
	Sat, 13 Jul 2024 03:59:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 13 Jul 2024 03:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1720857590; x=1720943990; bh=UyJdcL5I2jTZpZtJ0CTh8
	z94ivxfbD/L5Kj1mFmwCSc=; b=VdLMYDq3a/9FtqZGr6iiW9Ho+b7i5wmBeN6F7
	N6CLhGkWdLNRNs4Q4E5RbVXc67LgvUJNOhYnY8s+gzBKqKFhj0eTMbN2EpUQpUEP
	t9adYXZfmbB1QfBdbNLcVtHX+mfUzTy9ML9RWeScz8Q+kSQGGJouwlMctFDnnJVL
	12aoKvTEJd6uPAIuB5e34wtqoKFFd6ghZDKeWEEj0XZSRvtB0e2M8ZitOe9m9bxO
	x33CD8t3BiIbsJIAshflyv4RtyvrpGO4QqrNjYYOGfmdSBHa5bnlbug9bIC1THWC
	UFLDQ4Df4Kc7rIAOTA5wmlO8pzMg6em9bxX5WOVhqq87vLy9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720857590; x=1720943990; bh=UyJdcL5I2jTZpZtJ0CTh8z94ivxf
	bD/L5Kj1mFmwCSc=; b=fsd0kaxa7qkK08Y1iVe9DGzNL0Ru0n8WObQvGXR9G5A4
	Sl/q4CdJjG0RMGN4BqIICaups5VZt3ICZt/zEZ37xJM0ZBFIaqBqjsNi9DhQNGMI
	JGIMF+wVHgSaV0t0FKWOiT4eu5pq3vBdm+he+LCNuDIRclvF8U8uGeAAfZXQMr8p
	lgd7gxQp7WNyomrPe9lLTD5w5aTb+XYLZLI0T1+lIBjYgMnhfOOevbV1L3+vDop2
	s8hhZhVG4OwxzBlTtPWW0/47hOVzVM+jy7td8LI46+JqtiQvUqOB49na1BndXCha
	z4cDoyH+baWPIhdRw94npZAAU40jmlkyg5sgCeNG6g==
X-ME-Sender: <xms:9TOSZjgQd-w6neUBc71acULdpmN55-vuwJLUQSwYDaHf6_Y4PBkG8g>
    <xme:9TOSZgBU2nLxe-QPZAPiVkrBeXTzYHBGicd_ST925fKJdZI7Oi2syI-Xrfnw-rY94
    0U-Q1KL-1BOJCEojbs>
X-ME-Received: <xmr:9TOSZjEcznUv2-30LrA_i62gsF19tsVYIkHtVLiHdWmlra5M5zG1b-xI0Vv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:9TOSZgRzJRa-77MFkv3JcSo1LDzK2AuhhWaNT5jIcqoQbWVNNA0LHA>
    <xmx:9TOSZgxVO8_2UjOXlMwyyIiOv6NvW962xq-gpJtJeE3VYuZd2czvoA>
    <xmx:9TOSZm6aotoE2sULKboLD0ZtNz6YTEXOu8fdUmHtBah1_Wk9dgTfVA>
    <xmx:9TOSZlwmAGI2emm_GP_l3pinpyPezHKN-xZQiZLDrtLscds3ejQOWQ>
    <xmx:9jOSZvq0Fa0CWbQRRswu3yJZRyocfakmzc2WUAiiUlIBLElpXBE9ryMH>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jul 2024 03:59:46 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/2] platform/x86: asus-wmi: extra debugging and a fix
Date: Sat, 13 Jul 2024 19:59:38 +1200
Message-ID: <20240713075940.80073-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are two patches, one of which is a fix to prevent certain situations
from arising.

The patch to add extra debug prints has come in extremely useful to find
causes of issues for users such as when a WMI method is returning a valid
value but which must be masked.

Luke D. Jones (2):
  platform/x86: asus-wmi: add debug print in more key places
  platform/x86: asus-wmi: don't fail if platform_profile already
    registered

 drivers/platform/x86/asus-wmi.c | 67 +++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

-- 
2.45.2


