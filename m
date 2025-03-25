Return-Path: <linux-kernel+bounces-575973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0CA70972
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9413AC8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3711FC0FB;
	Tue, 25 Mar 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSAPzkjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90A1F0E5B;
	Tue, 25 Mar 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928207; cv=none; b=lpgeAHFeFy7gnjfRsUNoP3LyS6kr2izylBXyFsnnC5+qodYt+dfyX4c/2/hn3+//5Oo3uJKKECe6m2aQs2u2KB3lAc0E5LgzqQGdA6gpCZidZO6dtQvXl8aL06dzR1+pSPlZKq9xEY2VnmbSMHE20aNy3iYFvDbBGvuwOL15+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928207; c=relaxed/simple;
	bh=YDQnXBii9ZTIwMRIdbdy4sMkR9kIMVftvK2/KqRgcwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gN+Qhxdo/0GeljcarWu+cB2nmfggP+OFkinCjsO+2bYRL/EYv1EW5ge2NZSUVIXjY48hxEMjNE8IyT8eHW+xHuc+eBLQ9bMT97IREt/vW4oSw37tmpf/Wxbeog8YGsSRkZLE2PvFIGNn7pChu0Vqq9ds/x/1Hr4MHVoJ2dYihGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSAPzkjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC0C4CEE8;
	Tue, 25 Mar 2025 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928207;
	bh=YDQnXBii9ZTIwMRIdbdy4sMkR9kIMVftvK2/KqRgcwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSAPzkjjsH0oCasaPjtiJjDuNqu1ViRM17xK+M1q4hv0tLBpLLzmNxiyWlkNbgM1G
	 1UF0gGr/LJrSVHvTj3BjjC/Lx8EhgYB6pFrPuPFntZwZQp2kuusSrmjKUhQmj8W95G
	 xZoD0UeBzkYA0LknNc2SCNnzH/8htgJcXN1MTT++B0zW4cVTVBu71h7t36FkKtPLmx
	 YV57A0g0deYb0YiYcO1PlCB/xTJD8emAoF/wJ82XswpTdO3RiGHSgKCfbEOD1KrC5L
	 l9lh3g76wpji+CFL9JC9y/MqnreRYFigxwrjhlu6Jyg3d/TewJDtNGuqkUEpg13sF2
	 57Fjn428z7xKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/2] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:43:19 -0400
Message-Id: <20250325184320.2152507-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184320.2152507-1-sashal@kernel.org>
References: <20250325184320.2152507-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Tasos Sahanidis <tasos@tasossah.com>

[ Upstream commit 815f80ad20b63830949a77c816e35395d5d55144 ]

pwm_num is set to 7 for these chips, but NCT6776_REG_PWM_MODE and
NCT6776_PWM_MODE_MASK only contain 6 values.

Fix this by adding another 0 to the end of each array.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Link: https://lore.kernel.org/r/20250312030832.106475-1-tasos@tasossah.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index da6bbfca15fee..a6b7919ab63fe 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -420,8 +420,8 @@ static const s8 NCT6776_BEEP_BITS[] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
-- 
2.39.5


