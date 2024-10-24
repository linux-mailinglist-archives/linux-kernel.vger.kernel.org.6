Return-Path: <linux-kernel+bounces-380592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8799AF310
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8441C2221E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D32170CF;
	Thu, 24 Oct 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="iWVqc14L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSRDkfjX"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA098189B8A;
	Thu, 24 Oct 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799753; cv=none; b=bxQ7MNowMHfYMKaB2I2cJIXloEJwiGH0QxY6YJRm3kFtCwcLAl91fJ5itUS/Wh8uC0vI+t2t0i57dJbtf0VsEKRYWqh4WeXpaLvBwT7zySJUiRX3aIPRLHhq+qaS/O8IUma/IZTkFJo1oVcXy174NbmdrBEbcdnhfFs6ANiiBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799753; c=relaxed/simple;
	bh=cNItNOWjJcKHWD6PKJrACMiAxAP1ZvTWKMf7UtZgE/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGv3wZNptXplAza/Azp74vmarsk3pNa6H4ibBaBhnBETnN5ooJNmT5oxrhn6rIM4DmkWVzhpTASdlQkks2GAIUa04ak6OWqH7eTc+CTsoXdF3ZHjpe4KX+nf+XS1pocTC3EDy3+yldhARmr96cMnwwT3Ux+q8phVkvGlA7Rh3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=iWVqc14L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSRDkfjX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A37AE138025D;
	Thu, 24 Oct 2024 15:55:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Oct 2024 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729799749; x=
	1729886149; bh=4YJ0wLKoi3fAP+CIrF55huJWdkySH5/7mNToQJVRcuw=; b=i
	WVqc14LhZN099GJ/GM/PeR/z2o/WSdRgh1uA3wNlppRcK+gLH2TngWJ9I4V7ih13
	HzJSGdGm8bsp7eEyAfl+tKRZaaR4CVhUmDKOMrlId0oJqm9LjQ5iGRnncMVFNAWH
	UKz/sCzAB4nW/8WWNolLn4gmC2MsAMjcFjE6C3/fjOZWcaiZjS8GsrDYZmp/hMoS
	oSg8CJtRrs8/xmZ9+mnSkUhDUslKDCBTfVF55c6d3pEme/4c0utk1WFnpkHVVGtB
	v0TtRbo7yD9WM2eL81RvD9eYg5ZnQ8iWKzEaPIue+xmE1i+oJCioIAMOdTzZd16M
	DmcDZ+Cc3yYUBoctsq79A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729799749; x=
	1729886149; bh=4YJ0wLKoi3fAP+CIrF55huJWdkySH5/7mNToQJVRcuw=; b=f
	SRDkfjXGV00lZ7hKSFvX1VQqW+QGbKFnKejywFksYqUsm4+xBpuoj5T8dS5Vn3Vb
	u7nc2dBumpbwK21zcz5XJHj6yZBFs8S3lFCFMdzAZVIu0HmgWJqHf++GegbQBFr+
	fVoxEm1AeJwnnpQkatT8YzisDDvyWag7hvEvZpTQ+XYmTHqAaUvgUFctLs2NGsy1
	LhkkossiWtHK2HfABCm9yUm2xCxeftcHsz7tttgYakqWEJLCh7KYJSW+MIjHbhBy
	vYkuNOBS2ih3r4aU4dFFlArMjyxK/IfE54hlKa1u7aucpiNTOXV8Dl/5u/fBAeN4
	E5AAv/L2gQBpo6CkSmLoQ==
X-ME-Sender: <xms:RaYaZ13V5M2q4tABH6fgdSFWnDI4Lxe7jyuzLxbzMZg71aie94Pc6Q>
    <xme:RaYaZ8GC0uHlhqdj2sjF8fzn3DDTAcmK8Lgf-pJZ3DyeM_ZYgOp4yyNCR6xfrlovr
    7IuHD2Cp9JjZOSid_s>
X-ME-Received: <xmr:RaYaZ15qZycYUMv294YFZhXDIp-d8_b12INHBnxTFbsFd7eH7mtNPO1GBt2oqH94KlrMDM9utXn0eE3o9ynoWPzbEHF2tmuxRUAcjjk7RAtCtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddguddukecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:RaYaZy0qJIjTbS4bNEF7SOVEQoxGYu2vVf1z76LRj_sgkVxA42dfwg>
    <xmx:RaYaZ4EnCplU-VJdE9UyvuzNVCJyhAWeigmtOwIl4aMZLbBxRpIWGQ>
    <xmx:RaYaZz9UoxKnPGqjk-s1EQ5_F3d5LjeNuIxC7Zz8KEtK2fmmdgmeDw>
    <xmx:RaYaZ1kK7WvikScKEKAQMBgHevMqmqa0SO7bmW1fcu5iSV3Eszd_Jw>
    <xmx:RaYaZ9MToHwYNif9hTgNAC38EWJBymdLZ1U2t7D5RJLj_c29XifsA0RU>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 15:55:48 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: think-lmi: Allow empty admin password
Date: Thu, 24 Oct 2024 15:55:23 -0400
Message-ID: <20241024195536.6992-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
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
Changes in v2: Grammer changes in commit highlighted in review.

 drivers/platform/x86/think-lmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 46ab82fb2898..c316b1b592d6 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -469,7 +469,12 @@ static ssize_t new_password_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->pwd_enabled) {
+		/*
+		 * Note admin password is not always required if SMPControl enabled in BIOS,
+		 * So only set if it's configured.
+		 * Let BIOS figure it out - we'll get an error if operation is not permitted
+		 */
+		if (tlmi_priv.pwd_admin->pwd_enabled && strlen(tlmi_priv.pwd_admin->password)) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
 			if (ret)
-- 
2.47.0


