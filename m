Return-Path: <linux-kernel+bounces-339056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D2985FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157551C2359E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393361922C7;
	Wed, 25 Sep 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo+3RQrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4122AA99;
	Wed, 25 Sep 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266672; cv=none; b=lDr/a+ZswSiPyTMwUlrH9RJSW4FpBnBCS41AHZOUwM5zD5FQtdWgKIo0evWDwUrLT33udDXqpTMM5PjNmYkX95XtBzye6jflojpkHxh3LDxDbPyCbOrFpT7K5ylYEEV1vrepyrAO9VI2a/wF6O15+U5vOhv/sZbwefRiyEMJVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266672; c=relaxed/simple;
	bh=qRzraMmKSRQ6rNn40RBbsR+OY9fu0/blSi7MZIOwHxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq3m3/a1v/sg04zOBcxlq7eZuOuwm1Mkywt+Qs8Z5gScwCWkYtdyI6g48/n27+pWwzRRzCwHcy2quosyYt+h23tZWMEGOI4BBaRoISpPxdlyBz+wDgXngGaRSrnU+ZUivDaXtJE+ZB01ukeLzkh4W0vx3I/QTsc0QhLcXW+bhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo+3RQrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279EDC4CEC3;
	Wed, 25 Sep 2024 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266672;
	bh=qRzraMmKSRQ6rNn40RBbsR+OY9fu0/blSi7MZIOwHxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vo+3RQrjxb7MnR9jmXuwysFZ82fTt69DH73C+6S43MG5wM8AXORER024xQ10QicGB
	 TbicgiN/EARBufQxWlp9yFZ9h2D79cig2gz1YrEa1Cs8WLKdxU1Q5yY5DtuWqXv9TP
	 ieDatQBX63CrCarQxmOj3Bo1PkchpwZwolJjg7T/ns8mcJIZSPLpWS+1YldktOZADs
	 03wfB0+40HXSjbxz//AORzNr2PIM3t8faSDXHqDjZLfwe7j/7X6dEjg3xrJlBxJqXV
	 EX0IdPQjO/m3CXJ0H/Lq71kCSew6yngipQ8OTt6B0v/9UPUzyi4P74C0e1UbYM1un5
	 UKdW3n7WMCqMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 129/139] platform/x86: lenovo-ymc: Ignore the 0x0 state
Date: Wed, 25 Sep 2024 08:09:09 -0400
Message-ID: <20240925121137.1307574-129-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit d9dca215708d32e7f88ac0591fbb187cbf368adb ]

While booting, Lenovo 14ARB7 reports 'lenovo-ymc: Unknown key 0 pressed'
warning. This is caused by lenovo_ymc_probe() calling lenovo_ymc_notify()
at probe time to get the initial tablet-mode-switch state and the key-code
lenovo_ymc_notify() reads from the firmware is not initialized at probe
time yet on the Lenovo 14ARB7.

The hardware/firmware does an ACPI notify on the WMI device itself when
it initializes the tablet-mode-switch state later on.

Add 0x0 YMC state to the sparse keymap to silence the warning.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu
[hdegoede@redhat.com: Reword commit message]
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo-ymc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e1fbc35504d49..ef2c267ab485c 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -78,6 +78,8 @@ static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_pri
 }
 
 static const struct key_entry lenovo_ymc_keymap[] = {
+	/* Ignore the uninitialized state */
+	{ KE_IGNORE, 0x00 },
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
 	/* Tablet */
-- 
2.43.0


