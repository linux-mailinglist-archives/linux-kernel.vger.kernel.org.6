Return-Path: <linux-kernel+bounces-521515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC751A3BE57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096371894FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F71DFE36;
	Wed, 19 Feb 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="kFciqOF7"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3D1DED62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968948; cv=none; b=RUz1b4bmp1TdsSYAXtCymCVMuD1gNo5fHTvV/qegLTLQ+nPJf6xNL+jQxxwvnK97K92TAPKWdr1rfW1eIlV1e0QXdmEQu3MItsYJrsmmR34MJn4rMhW+NIR8x0MfCBesFnu54DS85ZM7eLVNdSTm7RBwiUacMcVkgCFRcFu6QAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968948; c=relaxed/simple;
	bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BUO9E1CFoU0wVNjL8HdRZlFedii3AX4LXgKBUKqNyb7QPjwTENSDyVuKRBcF29TQbVRVt4XzqhWmYZFaLrtmOBG9Xsko93dwOS8eKo6Wi949i4v3cp3CvUkkKshwnJfTZvDvgJuHcRLUCngaxK1XNiJ730i4M2lNt7KdJvf2Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=kFciqOF7; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0292A240029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739968945; bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=kFciqOF7S+S+lUYsOZoMYpGVAw2fVaHmSdIxpySR5gNUVensULp1uJ5+V6DT86iPO
	 HLddDm3YY1quwhj4J91Eten351mOR/Zf3Ai3gHP61PMbo5vc3eAhE5eqQGblVZZ9WA
	 4Sbsh7VUmZgD7bJPFVK72uJc83WfXHC+4G6PNCvOwmsfi85GOyLE0Z3AkDr1qX+TbY
	 K2SJWWq5s+e6smIHAurH57lx4478N9bxYf/k4/CxmE1mnlJYkfOSFG5KnaNNABIvw5
	 HqeI0arTI1C4pk4iQpvKuGXgvlcNJNDN+/wjQDtnXxs9rAe7jyE2EXNznr2FB97vig
	 +Juk5OicXaN8w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YybdB0TTPz6twQ;
	Wed, 19 Feb 2025 13:42:21 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Wed, 19 Feb 2025 12:41:55 +0000
Subject: [PATCH net v2] net: phy: qt2025: Fix hardware revision check
 comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJLRtWcC/32NTQ7CIBCFr9LM2jFAUYgr72FcVBwsi0ILhGga7
 i5yAHfvJ+97OySKjhJchh0iFZdc8M2IwwBmnvyL0D2bB8HEiQmuccs/iSYsC/mM1r1x5JOy2pq
 HOUtowzVSizv0Bp4y3Fs4u5RD/PSjwnv1j1k4clRyJK0MY5KZ6xpSpnDsvFrrF0cv2YG6AAAA
X-Change-ID: 20250218-qt2025-comment-fix-31a7f8fcbc64
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739968933; l=1517;
 i=charmitro@posteo.net; s=20250218; h=from:subject:message-id;
 bh=aEZmkm1hV21rp3YTZCGbmxtF7lznLzqBxNFTStfv000=;
 b=rjm5rN4NKlBBwxqtODOZ62E5SaiIwJVOr7MYv+DUdwOfAoKfVDgfiHI+azP52m/u1tkggWizk
 96yrORzotrkCAN9hSMpfRgWQviEksl+UYf1bvmTy5AvGN3kmPMY4z/8
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=tqvFF75nwS3URscujaAaCD+j9ViKh5jLMkj1mnX7Rws=

Correct the hardware revision check comment in the QT2025 driver. The
revision value was documented as 0x3b instead of the correct 0xb3,
which matches the actual comparison logic in the code.

Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Resend with proper patch subject, according to netdev documentation
- Add "Fixes: " tag
- Link to v1: https://lore.kernel.org/r/20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net
---
 drivers/net/phy/qt2025.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
         // Check the hardware revision code.
-        // Only 0x3b works with this driver and firmware.
+        // Only 0xb3 works with this driver and firmware.
         let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
         if (hw_rev >> 8) != 0xb3 {
             return Err(code::ENODEV);

---
base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
change-id: 20250218-qt2025-comment-fix-31a7f8fcbc64

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


