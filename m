Return-Path: <linux-kernel+bounces-420299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FF9D787C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED282AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB1175D39;
	Sun, 24 Nov 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="S/dhdC82"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885213A244
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732486491; cv=none; b=FgvToaoEU/N+zsNl/5X4UnGaS344oqhouGv0Ivs784dxxy+th8NerkJv4aArDlrtV4ykuV4TbhVnMXWQQ7ofkCIttHE7KYOJRNDSeWtuFehzczsCRHP814Na78YSYshakUneMp20+x4PuC8OIHgHwgDKLxeEq9nv2ijNRzQDy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732486491; c=relaxed/simple;
	bh=5LCkleFSbaQtCG4x5qMTLCfSc8sP2dhui/dkVkiMwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9htDjhogbgGaahhir2B3vlfJ97lb+9oX8GIDv87Y/25NhKLdKbp8HTT0oR0TngB95qyFDe37tgpv4Bh0clD3sC8vgPx9WZSGu89Pro50Ta17yxi9et+9wh3lf0oCnDCbPjENug2896l9GApN+kj3BpY75ti7pFoXgd1GQsbIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=S/dhdC82; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E31732C057D;
	Mon, 25 Nov 2024 11:14:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732486484;
	bh=O92f3zpvDXMuVRxHboYfiuDPDnXc3HizrQNIyXRegKc=;
	h=From:To:Cc:Subject:Date:From;
	b=S/dhdC82RKL8iLHFbf11HkRVSyYLF029dKO0Wr3EqDBstSXR/RtetQnHYnls/aSrh
	 L5LOeh/eM8RFzkbb+fT7zMXZf8j9C4j7hiuhqlmQfQLGopYozj8EEHuWst+jlIr6Hv
	 qvISQp3LbjxPI69eDGe1BWJ9jQSefynyVrMi2+zylelaspj/7QI0cYeMRv8ibVOR85
	 XqR0tStSwboM3+M99N6R9gpwsnO69FsLrFD4NkCetzUU5ro2haT8LemZZzApU9LLPY
	 BDLeTrcAnFiYwYSxqcTjXY26XP+S5sccCkehgkyA1AN4UH05O+H16yGa8XcnwFmcOo
	 BVZdWeEwyqWgg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6743a5540000>; Mon, 25 Nov 2024 11:14:44 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.16])
	by pat.atlnz.lc (Postfix) with ESMTP id BEAE713ED95;
	Mon, 25 Nov 2024 11:14:44 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id B2DED40678; Mon, 25 Nov 2024 11:14:44 +1300 (NZDT)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] usb: host: max3421-hcd: Correctly abort a USB request.
Date: Mon, 25 Nov 2024 11:14:30 +1300
Message-ID: <20241124221430.1106080-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=6743a554 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=9JeQPKVsZYsqtNgjPSQA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

If the current USB request was aborted, the spi thread would not respond
to any further requests. This is because the "curr_urb" pointer would
not become NULL, so no further requests would be taken off the queue.
The solution here is to set the "urb_done" flag, as this will cause the
correct handling of the URB. Also clear interrupts that should only be
expected if an URB is in progress.

Fixes: 2d53139f3162 ("Add support for using a MAX3421E chip as a host dri=
ver.")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/usb/host/max3421-hcd.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hc=
d.c
index 9fe4f48b1898..0881fdd1823e 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -779,11 +779,17 @@ max3421_check_unlink(struct usb_hcd *hcd)
 				retval =3D 1;
 				dev_dbg(&spi->dev, "%s: URB %p unlinked=3D%d",
 					__func__, urb, urb->unlinked);
-				usb_hcd_unlink_urb_from_ep(hcd, urb);
-				spin_unlock_irqrestore(&max3421_hcd->lock,
-						       flags);
-				usb_hcd_giveback_urb(hcd, urb, 0);
-				spin_lock_irqsave(&max3421_hcd->lock, flags);
+				if (urb =3D=3D max3421_hcd->curr_urb) {
+					max3421_hcd->urb_done =3D 1;
+					max3421_hcd->hien &=3D ~(BIT(MAX3421_HI_HXFRDN_BIT) |
+							       BIT(MAX3421_HI_RCVDAV_BIT));
+				} else {
+					usb_hcd_unlink_urb_from_ep(hcd, urb);
+					spin_unlock_irqrestore(&max3421_hcd->lock,
+							       flags);
+					usb_hcd_giveback_urb(hcd, urb, 0);
+					spin_lock_irqsave(&max3421_hcd->lock, flags);
+				}
 			}
 		}
 	}
--=20
2.47.0


