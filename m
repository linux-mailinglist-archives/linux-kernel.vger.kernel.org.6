Return-Path: <linux-kernel+bounces-207606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3290199C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9731C20DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367EA93A;
	Mon, 10 Jun 2024 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CLjZgoan"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B07524F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717991596; cv=none; b=AJF9St82FNqPGNbn8eeMm/ZftfvbPlKvnVIYKAaUbwQJm7spshWAegCaoPfuM3cXcGn2CPXUzygO2DgexST6ohsephoGbB7/yZ7F9BHqYNvs0Ed/l4MACRFz1jmQem7C/vP1IkFfxy9WzSF8TOe1tVqs1JJeIgWLf9yR579B5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717991596; c=relaxed/simple;
	bh=TeAxseHgIhV4LlKAD9dMBGR3KEwU2B9+0vggWoEPqtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vq9XEqEfiox+mpqLHljD0gvBsJrTgU6QVdFqh6hhfWKSDK2whGx3eT5V4CY+JgjEZoGgkGY8zehEwT3SgQET1+Rbi5pdbRGBB463FSxnvA6nM5Q/1kp+xrZfY6ameyDhwIYcHG9Up4CEWnCeyJjuY8Q9lkZ2gk4uT3GUPQuXEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CLjZgoan; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 59B4D2C018D;
	Mon, 10 Jun 2024 15:53:11 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717991591;
	bh=oHUsjC71nJ1K+8uGaI0bP00jxm56WVzoCDEG5LjsoWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CLjZgoankl/0C8uAWsXAU2Er4sxjW5K7VWnCwQeseuYMrdRsIurHPBZbHBWwLHcwC
	 qQyMFkn00GrkoKAABvfGDSJPHqIS05Y3xKzylV1L8WCXE2/f7+PwjrREQDh2RFz+j9
	 zc/ob5yL9+sODsyVB4E3aAwpLI8rokwhTnx4paXW/n2M7rWQ7pcch/NkaF/1zcgxqr
	 cnRsBBdnhTwD2cH3BCCP0HkVkYozuxGy2NMwHmCXT8QhOUsTJbhpJVwBdjmbRtse5S
	 zP6VMljMrPVKTD5uNycDETwc502RMSz3vE8Svq+TtRkQTx5Na6y1H9y6Pij+yqHqhN
	 Tu8jR1/A4nGGg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666678a70000>; Mon, 10 Jun 2024 15:53:11 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 324F313EE2B;
	Mon, 10 Jun 2024 15:53:11 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 2F3632A2270; Mon, 10 Jun 2024 15:53:11 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Marcin Wojtas <mw@semihalf.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v0] net: mvpp2: use slab_build_skb for oversized frames
Date: Mon, 10 Jun 2024 15:53:00 +1200
Message-ID: <20240610035300.2366893-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=666678a7 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=nUjTbgbENZD28nTSGwIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Setting frag_size to 0 to indicate kmalloc has been deprecated,
use slab_build_skb directly.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index aca17082b9ec..05f4aa11b95c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4001,7 +4001,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
 			}
 		}
=20
-		skb =3D build_skb(data, frag_size);
+		if (frag_size)
+			skb =3D build_skb(data, frag_size);
+		else
+			skb =3D slab_build_skb(data);
 		if (!skb) {
 			netdev_warn(port->dev, "skb build failed\n");
 			goto err_drop_frame;
--=20
2.43.2


