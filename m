Return-Path: <linux-kernel+bounces-210853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443DB90496F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97450B23484
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4714AB4;
	Wed, 12 Jun 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com.au header.i=@fastmail.com.au header.b="UKUsHu92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXNOpqER"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635F257D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162142; cv=none; b=tUEiEdx5gP52kkCJjFsnxfqpvy198oc6CtRhQ0Ol0vP8p0AA4ilsDiKMuSQCSjW1zIQItxzsNDMIXg95ImfarZys1v7j/oNpmk6hYosrudggwhDOeCxUhY3s+mpLmG+Auk4akXb+KW3hlJDMShC6q+w+I8xiRMmtc0AHXgi8zhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162142; c=relaxed/simple;
	bh=Sv5rRXI0khWjS7T/iNGvbK8+tcfD9Cz0pW1TgjH6ha8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0nXOSJ04RUqOK3jmCRTZy4UWX1M9nzz1oc0o2yuaop8nZBjTxtK4nmFbIT36WdDDW1kOoLkW23pX062R+61ih5ZiKFNY5xH8pE5UQH+kK4NQR4OZq6/afNEgTr88C0Rf5ejARZJVBTePh4f/d+fEpCjWxTlP549Ob7N2wy+xnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnthomson.fastmail.com.au; spf=pass smtp.mailfrom=johnthomson.fastmail.com.au; dkim=pass (2048-bit key) header.d=fastmail.com.au header.i=@fastmail.com.au header.b=UKUsHu92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXNOpqER; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnthomson.fastmail.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnthomson.fastmail.com.au
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 995451C00178;
	Tue, 11 Jun 2024 23:15:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Jun 2024 23:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1718162139; x=1718248539; bh=zvLwu9Fi+t
	Ya2Qb87tnXmDFfyJhm4LTPbxoJiYbmi+8=; b=UKUsHu92PUSjutygmWSWw3DkGI
	ieX6a8QIpaBG+ihf0merrBG2lsh+g3jcWmmXCUzJMszPxc2ZrEpO0FMi9yNjKs3I
	M1dVfoBVfl9tQoO/siJ9lnYUXlw6YeTnL9oCpAQ2bXtVdS2SnFyrdZAUEvXgNl0i
	Jpa2hQ29Fej6xP7b19h5Nbko5CBiCSgxo6m4U9odK46ZgZTtlVDx+I1FqXgOqffH
	khtsf63Un/uUNxwXj9PanMHVS6WiEJxK3kNdE/YL+6A7lEn5DSeSQmlJObTer0Ti
	LVskW9TX2cklgBkh1aDjCN4ygxLpehnMpRxQPlJl4/1+I8OKH4L7K5kKIANw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718162139; x=1718248539; bh=zvLwu9Fi+tYa2Qb87tnXmDFfyJhm
	4LTPbxoJiYbmi+8=; b=ZXNOpqER9fUgi4eB2pioh8fOFeM6doawVMchqfoESzzD
	WIphSPpBl3T8Z5w9T6VqMgRlkCJXiNEBwOY5Bq0/n2aLB7fifSqy/acQsOoxz1vb
	yZR1lXC3TZ08Kji22RdknBtaKpIwaAFc6PKfXxtTS0xgCLxwTNKmmb0koF9rHN+Y
	1uZXylEZVZp1918QFZwZ1FvmmW6HKQlgW/NUGLZP3c+mPWnydkMv7jBvySQkdlgf
	KrEFuroPCt9ZePkFjmCqu2ADHvS456zlILZCj7O5wfVt1mGYcyhEMyM58ZOaRRDU
	lr0FxE2NmPwnxeJAb51oioWr8A1SSE1z3w7PpLqEJg==
X-ME-Sender: <xms:2hJpZjUVDzqJZnooVpJEaOKGROEQ9GJhGvJlrU6WSQNNaqAzhmKptA>
    <xme:2hJpZrnBSxAauqMRsRy_rS_E6msC4a7k6JuOWN9o_QglPWsx1hg_DeP8QyPzlENrO
    5kWq-SjWB-P0sXeKg>
X-ME-Received: <xmr:2hJpZvYJOvxmlrBRVU5ecjP1ilc6ifrGnkJGZpT5j47nJ05EZUh2s28SgUxnsuiJSFy1TyLRFFQ__AqBJQob_0hpdpcb65HL_bUX6aYeq5aFBLSCkH5c60RwCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflohhhnhcuvfhhohhmshhonhcuoehgihhtsehjohhhnhhthhho
    mhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeetje
    evgffggeekffduledthfevgfeugeelhfeuveeiueekgfegffetudevhfdutdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsehjohhhnh
    hthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:2hJpZuWtVFGgoO2BmYCktTxv4kPIIStObi29wRcTtXw4hf1uvNMoXw>
    <xmx:2hJpZtmMqdaLiJ2z1mLhGVoeEDmF4vW7dtV2-1UkufF3ECtF__z5wQ>
    <xmx:2hJpZreKrkGA3WYDQqnYxhSA581FOuO-jlhDOQ98IQ_IxeTAK0G53w>
    <xmx:2hJpZnELQ82UaOV76WFocfbqVlXRvWT-_Je_X498DoTsHS1DPEBWfA>
    <xmx:2xJpZmA3BkVWsYxUdmzqDlraae5es4mC5nBwlBHuYS_9NwtNI7oCwr6k>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 23:15:36 -0400 (EDT)
From: John Thomson <git@johnthomson.fastmail.com.au>
To: rafal@milecki.pl,
	srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org,
	John Thomson <git@johnthomson.fastmail.com.au>
Subject: [RFC] nvmem: u-boot-env: error if device too small
Date: Wed, 12 Jun 2024 13:15:10 +1000
Message-ID: <20240612031510.14414-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a DTB description of u_boot,env within an MTD partition that
starts beyond the end of the hardware results in kernel panic in
u_boot_env_parse, where the crc32 is calculated.

When mtdpart detects an out of reach partition, its size and offset
are set to zero. Add a check in u-boot-env before running the crc32,
that the data to be processed is reachable. This situation should only
ever be reached through hardware error or misconfiguration, but it is
handled gracefully at the MTD level.

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
RFC

Only tested on OpenWrt's Linux 6.6 based kernel (which has nvmem
backports from 6.8), but it's not mainline Linux kernel.
---
 drivers/nvmem/u-boot-env.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index befbab156cda..6e73d042467b 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -176,6 +176,13 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
+
+	if (bytes < crc32_data_offset) {
+		dev_err(dev, "Device too small for u-boot-env\n");
+		err = -EIO;
+		goto err_kfree;
+	}
+
 	crc32_addr = (__le32 *)(buf + crc32_offset);
 	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;
-- 
2.45.1


