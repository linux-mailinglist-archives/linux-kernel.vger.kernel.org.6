Return-Path: <linux-kernel+bounces-398288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A79BEEFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA755286AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6AC1DF976;
	Wed,  6 Nov 2024 13:26:40 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783E191461
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899599; cv=none; b=n23iiZFVBRYdxWvAiNYRzKXA9RtYJ9PXO/yDs0vevH/iuuQI4HQIqlk3tBfJpcGBGE9xyh0S1gHYRrAGS7iRDZ3CJWQS4v1YLjs+Ybup/dLzqvQzvZuvfv+pzhCkF/VJKtMiMWz/GjjFiG+gAHm4ykbLGz25pNn1ycdYbNjL65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899599; c=relaxed/simple;
	bh=CEvR2wN90zI8nazSZ3qTAEzn6FARJPmdgsYn3mybFr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJbGumdfEbs2oJ0tjCCyNObsAIM8/MJ6vOg8coDAOP9EEgp5NhBgOGxke09GPLDUrnv8oAua2ReVet6dYCHw/FPRZR/O76RcrxAF9ZV3Ygi0PupHZQJAwT2EwklGWmnLm3SDmjd1sBla54SF749nwgAJ9IK4DML0bCUKLWz/9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2473:2222:191a:9acf])
	by baptiste.telenet-ops.be with cmsmtp
	id ZRSS2D00e52sj0y01RSTcZ; Wed, 06 Nov 2024 14:26:28 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t8g2x-006MWd-2p;
	Wed, 06 Nov 2024 14:26:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t8g3G-006VYZ-OI;
	Wed, 06 Nov 2024 14:26:26 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] powerpc/ps3: Mark ps3_setup_uhc_device() __init
Date: Wed,  6 Nov 2024 14:26:25 +0100
Message-Id: <31fe9435056fcfbf82c3a01693be278d5ce4ad0f.1730899557.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ps3_setup_uhc_device() is only called from ps3_setup_ehci_device() and
ps3_setup_ohci_device(), which are both marked __init.  Hence replace
the former's __ref marker by __init.

Note that before commit bd721ea73e1f9655 ("treewide: replace obsolete
_refok by __ref"), the function was marked __init_refok, which probably
should have been __init in the first place.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/platforms/ps3/device-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index b18e1c92e554ce87..61722133eb2d3f99 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -178,7 +178,7 @@ static int __init ps3_setup_gelic_device(
 	return result;
 }
 
-static int __ref ps3_setup_uhc_device(
+static int __init ps3_setup_uhc_device(
 	const struct ps3_repository_device *repo, enum ps3_match_id match_id,
 	enum ps3_interrupt_type interrupt_type, enum ps3_reg_type reg_type)
 {
-- 
2.34.1


