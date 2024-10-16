Return-Path: <linux-kernel+bounces-367557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EC9A03CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D411C29080
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA241D2215;
	Wed, 16 Oct 2024 08:07:50 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1181D014E;
	Wed, 16 Oct 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066070; cv=none; b=G6jF9wI+dFgvibD+P3Y/pePldYuL+TokItaptNgV/2/YUD9c9Hf4apkxpYIsjUPfKtHOGHEMPjin5X0xGC34CSot42HdOf77qXRFDYcooYu5p+cFqJfRAXRhfa0KQSObwGUhwU8fGzLHRoW63KFFUYzvDxrop9d6yPE5ffexEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066070; c=relaxed/simple;
	bh=80u1tV/1D3WvsQ1F4ktEYJvsK5e1rSsqmZHn21wbl64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bYvJxwUImXpD3leOBuSJu37MB9tsP4ut+fcuBBfAFQG6+rWCMqCebwJaR6HGRA53Ymt7sjZn9c+FDE5PNICH2pUPFk4+QGHdMr4W2vrA4JlKXPWwJb/8qF+y8U107cT4+loZlwl+hEvYajkGnioU6JdeTpbx+DoCQAswxgHNiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2571F2F20247; Wed, 16 Oct 2024 08:07:39 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 7ADF12F20246;
	Wed, 16 Oct 2024 08:07:38 +0000 (UTC)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP EliteOne 1000 G2
Date: Wed, 16 Oct 2024 11:07:13 +0300
Message-Id: <20241016080713.46801-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cached version avoids redundant commands to the codec, improving
stability and reducing unnecessary operations. This change ensures
better power management and reliable restoration of pin configurations,
especially after hibernation (S4) and other power transitions.

Fixes: 9988844c457f ("ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2")
Suggested-by: Kai-Heng Feng <kaihengf@nvidia.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/pci/hda/patch_conexant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3a647f3c65d1b..e7107a14fa9dc 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -330,7 +330,7 @@ static void cxt_fixup_update_pinctl(struct hda_codec *codec,
 		 * This is the value stored in the codec register after
 		 * the correct initialization of the previous windows boot.
 		 */
-		snd_hda_set_pin_ctl(codec, 0x1d, AC_PINCTL_HP_EN);
+		snd_hda_set_pin_ctl_cache(codec, 0x1d, AC_PINCTL_HP_EN);
 	}
 }
 
-- 
2.33.8


