Return-Path: <linux-kernel+bounces-435121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472169E6FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D4B283CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82961422A2;
	Fri,  6 Dec 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jFvcutz6";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="1yoHfBet"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC1322E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494735; cv=pass; b=hlrK1YrQFwbSK4/WMe3UanuMktBA+OCMzPe+7FrIpH3rmiI7YMJ5AE1fPQTPa8hQrqIe01OFe19aJMf26QNu0r3gC58s5cSQkwyTW6g2iRHWcErEyjN26UD/1U3ELa+q+Rb4d+jTdb5bWGJqN3t8at0cfSdgjjBsKngvszJ438w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494735; c=relaxed/simple;
	bh=XalW2c+XYVeD96ZB86jq2awk+W+C72TphxamegVPW7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5UZoQl7T467gKcwlC1uTUwKtGkcchPKVjZo801f1uZNO+fD66DQQJzjBVhuVt8fVvwuLbCqb5gIBHXCI5ZkySX6Tgrwvdj0/YbrHGZPwt6/zVLROBmjCoSBtd2JRKegFF4D+vrhST7JhHIHsVv4suTSyccdrKJbMNJepJd1da4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=jFvcutz6; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=1yoHfBet; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1733494542; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mft91VMrMqOPpdW0b7SKcYchr31zgpbOJbCOA8X3Xh0ho3mQ6rFCeTyhOmlj4P+jEg
    L1ym/j3TRPnqhSie82hwfMv76MC5DOFKt00iZXKxrtWMXyx48eEkj+CyC7HQR0sYVW1V
    2MI/llLJ/7J9LL0svlvGn5bHYqauos40Eyu+DHDK+ZHdIsi702/EKiDj6+2pOG5oLobY
    bTCp1ym2Jj9fHNRKqz+3cY38l+xXDw8iu84zh5Rar1QMfR8v1mBm+4q1Bd6rwvsuDAJC
    53q5BHHC5bXXeVHAondQHBbfWTvK4oiDuq5RlRqE5quppwE1reTHLiVDAn8tdBFKhbhC
    mK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733494542;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Z58+uiVgBPQkke6BcCMA/Ak1YSRMhYCJjTVUw2AGcec=;
    b=BnIdCibFXMZRPq+3fq+O2RFDeCenveNeStzpF93r2YTbwQ4jOMRbpUxP6uyjeR7crU
    XshCGcJT6++qNzV2icUYG5fg0UyQDvQg3aTXYP1aDiCed7eksPyOx+vne0rnQQob3F84
    v38e8UiqYQZuF5YxBmwr3wSaGtZvMJxcWxrkr0qTAq06mqhjf71NJTDV3LUfFNLZGk7g
    cHryS5FpfOihFLbOn1PAAyfb4n8wEJSwOGSjrehrXkfJgWPugv5tAvHUAfqaNniF6LAc
    pS0dyWFoOrNs8FLyNOpC2YduFxbrNO/iqmNbJXA8iwTPbxJnjgg8CyYyxu+JALhVo4LA
    fzuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733494542;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Z58+uiVgBPQkke6BcCMA/Ak1YSRMhYCJjTVUw2AGcec=;
    b=jFvcutz6RXCyfYwhyGr1jkrRUgx+SIgtsF/kbalTLUYAMVAFvpbV7D1/i1xaDboTTs
    sWUVs/4bwEykV5eX8AZCEosnONtdJePeXLZURq1wOFvQjez9Tpf0RqCgEDIvUlIkUQv6
    puH+AjlxpVhTBa3x+5zxSlo6d4srY/m1aS8tHs+dWCRSGe3mv8sMh5RF5rU1DSuR76yA
    bSRoTK4sV/gY6xcLItxKSM3uGCtCmFKio8hxNHsrlHTtlANP36rLImjcI5IfYVWKJPp+
    U/9LB27Tzcw2KuiooANHXmpVMukVE7nvPiArwJqPAxdQ16SWeDvdMAD7+otK4bzsXl/t
    mEng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733494542;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Z58+uiVgBPQkke6BcCMA/Ak1YSRMhYCJjTVUw2AGcec=;
    b=1yoHfBetc6222DtH2uP7I5kP8ZnzeQaoCUA2ardu61p2bVDHAHQYiNBLI5M2OL5tl2
    g0mZk1jQSyrnZuH+XaDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfjEZ"
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id Qb7e400B6EFfkqc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 6 Dec 2024 15:15:41 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Zhou Yanjie <zhouyanjie@wanyeetech.com>,
	Paul Cercueil <paul@crapouillou.net>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] phy: ingenic: fix unbalanced regulator_disable() warning
Date: Fri,  6 Dec 2024 15:15:34 +0100
Message-ID: <52768c120a6999ce9275bcb15d74a4255f2ef790.1733494534.git.hns@goldelico.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

if ingenic_usb_phy_exit is called the regulator is already disabled
through ingenic_usb_phy_power_off() leading to

[    5.367301] WARNING: CPU: 0 PID: 20 at drivers/regulator/core.c:2953 _regulator_disable+0x200/0x230
[    5.368209] unbalanced disables for regulator-dummy
[    5.370364] Modules linked in: phy_ingenic_usb
...
[    5.373441] [<8054601c>] regulator_disable+0x40/0x80
[    5.372952] [<c02450f8>] ingenic_usb_phy_exit+0x48/0x60 [phy_ingenic_usb]
[    5.374283] [<8050839c>] phy_exit+0xd8/0x104
[    5.373104] [<80657a24>] __dwc2_lowlevel_hw_disable+0xe0/0xe8
[    5.373393] [<80658ad4>] dwc2_driver_probe+0x818/0x834
...

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/phy/ingenic/phy-ingenic-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
index eb2721f72a4c1..35984dd8a1bd7 100644
--- a/drivers/phy/ingenic/phy-ingenic-usb.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -124,7 +124,6 @@ static int ingenic_usb_phy_exit(struct phy *phy)
 	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 
 	clk_disable_unprepare(priv->clk);
-	regulator_disable(priv->vcc_supply);
 
 	return 0;
 }
-- 
2.47.0


