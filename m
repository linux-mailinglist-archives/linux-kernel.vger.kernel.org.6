Return-Path: <linux-kernel+bounces-375032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9069A8FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC0C2846EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3A1FCC43;
	Mon, 21 Oct 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="kaQoGZz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmTpB6cj"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C61F7091;
	Mon, 21 Oct 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539529; cv=none; b=l1+KxgfPGX+VHBWaKagTZJ615bhriQDD+W2iKF4cs01Oba6lRHd53RUaK+HUtuNsaxptAfU9xvkVq8KpB4WZSxliACNTcgXhRGb7H2QkPH92wwuKphQX06ivw1SWaQTSK31wes1Jo77L2RHGkQ+Dqt4MVCJlHCYDofSBAVqOtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539529; c=relaxed/simple;
	bh=lZwCDmTUI6g1I9S6SAz3J2/xTEjocHuMzIu/W4MxzkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEzRp3vbkLHxf/C6CrMNPsgBrZZPubz/XzL77lRos8ALUKcPw7ewsx300JZm4l7D+6/FtCTYR2UGjIUp/mi0/cSrs8bp/MM3Zy2NlINU24krvDH4WxwoOH6u+FXjtmaA5KUfzvXAZk+FXBvlYWwCbq3SqzOoaoQJUATVPu5D48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=kaQoGZz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmTpB6cj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F7E613801D7;
	Mon, 21 Oct 2024 15:38:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 15:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729539526; x=
	1729625926; bh=X9MLRegjfbLwd211osFWUaLWw79vYWXYz6OILq6zoV4=; b=k
	aQoGZz0nC7tJqwr+DOL1jZmfAtmsQ8YWsaasB2ZVHJrOA7wDl+j/lK7KpG749EHU
	lCR+Y4saHQ+4vJOt6Mrz+AfQskwpR24NEcFh/tb0YtlSCaiCsh8PWglLUDALxG04
	+gTEomO5dXDQPEudgTcOtz+EjsB5k5irOZSFw3rNWHHa4eaS2YjxeJz89/ZzOJiN
	xOZknKFsLKXwCs0zIWQwP2os43BSCoDr/fe38a86UOXkYvYvTmcLrLFaHQshLKWM
	3J3+Ds/s0xDgNMKo4WOMu+E/5uuEvCxtgyCoGojtrcdbI+hfBAupAvsVEY4TiWie
	ilGRhwncSdbQxJv2Oj/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729539526; x=
	1729625926; bh=X9MLRegjfbLwd211osFWUaLWw79vYWXYz6OILq6zoV4=; b=L
	mTpB6cjzVkHZlOHhDugCPAggYMfxSE8MBEsppwNX7Zfy6JsqrFtElIeRCVWTNceQ
	HZcfi5PMZUIwYt36c5OJ94XyttYtOL+gmAaVdqWdRECMsuT78LS5fz5QBPtzcCMP
	VN03+9iH79tMo4Adntx5FzB/7TL//KwhYao2e2735VjR5mrg+6fbaRGFK+63HSOQ
	5dLBNAt1/Aft67rEv6286PsX6Hmta7ZpLhfvptjVkyoq+AM6I4eAfsaL24kw/15P
	da/odSzFr7p6mV25hW6btQBy3dbYabF/E7zVx0xSl5MLbe1pnQLRtTL5kBY/EBfL
	mR4DFBP0tSYS0PcOcp8JQ==
X-ME-Sender: <xms:xa0WZ0XaKdwS4gDwXmtn18osr1ZUX6DcDQLxbCYg_2NT9TNtzA2XMQ>
    <xme:xa0WZ4kJfq3x-3QIizFYA56eT7PGRs4Xh4WrhEj2eM7EvyRuytdb-UMrIABgxero4
    Ey07kviyI2MVzHej9w>
X-ME-Received: <xmr:xa0WZ4Z956qr0lRlS7EnMZccPkicMUEzUxo5x9F44M1o27ZKtQTzxsAwUChvmS5geIC20QhoHnGhzTF_JkELOIoK35g5OBpHR9DolBdSEds2UlXsd6FYf99BPUokZg>
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
X-ME-Proxy: <xmx:xa0WZzVCwu_-9slOPbaHdNHtu7mzrZpfMo9SmCk5IckzKYe3UtycjQ>
    <xmx:xa0WZ-mSUdhdsc3h4e-8OjOFd-cLGYAdWB3p6bcd4l_mm-EsCGdKOA>
    <xmx:xa0WZ4d_a2IZwZa1VZhITDGPz-ivvtdHGn8NJvcKcdeoym7Drvjy7A>
    <xmx:xa0WZwEoapEhk90MqdzsI5L9nKFWTS2QkTHj2Wj1R5RJZdlBDC_RrA>
    <xmx:xq0WZ1stKccSpkwBMge_wVdEy4aIaE0XBlpLXeXgNtlzMcT4lsCjjsTA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:38:45 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: think-lmi: Allow empty admin password
Date: Mon, 21 Oct 2024 15:38:25 -0400
Message-ID: <20241021193837.7641-3-mpearson-lenovo@squebb.ca>
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

SVP = BIOS Supervisor/Admin password
SMP = BIOS System password

If SMP ACL is enabled in the BIOS then the system allows you to set the
SMP without a SVP password configured. Change code to allow this.
BIOS will return permissions error if SVP is required.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/think-lmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 46ab82fb2898..751e351dfc42 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -469,7 +469,12 @@ static ssize_t new_password_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->pwd_enabled) {
+		/*
+		 * Note admin password not always required if SMPControl enabled in BIOS,
+		 * So only set if it's configured.
+		 * Let BIOS figure it out - we'll get an error if operation not permitted
+		 */
+		if (tlmi_priv.pwd_admin->pwd_enabled && strlen(tlmi_priv.pwd_admin->password)) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
 			if (ret)
-- 
2.47.0


