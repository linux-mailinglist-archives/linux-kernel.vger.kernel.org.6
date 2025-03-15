Return-Path: <linux-kernel+bounces-562444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE7A627E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB403AD9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAE1C8601;
	Sat, 15 Mar 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pxuRStWb"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A318BC20
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742022894; cv=none; b=YfNL2vhz0usItRQhkNPTBtvEICm53Rfr0JPZ9PaSi8LYg/tB5SJYgBKdpAN5F3eRw4tQJXVQvJHUTkKIWXlIb5SPJw/LqbrOwsNM5eFcpA8vXhTMKrmMXAwvAauvUT3DpLygZH8r1pl6R1Ei7jQjMJSn0ZD3Lf4bd0aFeiSgjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742022894; c=relaxed/simple;
	bh=BqpyBjj/C6fmmqvNOOZaY/L440LCyjg6hLZXIgIY0PQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Aa+Hf3ClUoBo3B/DxZ3hMaOJsQ55rZ8+l32P4PSiRd1YAdz/tcHu07+bTtcHTziW833c5Zcr3dDjCwPkGyY5rrcJ1KyFfTl+YhbpK8yvv5nBcLga7uP/XtQLSoa14yQUi1uClMgwYFeoo5pjuYSrh2qjPA1yhQxpH2ymvtSinKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pxuRStWb; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742022580; bh=gya+f1bF8z2Gxe7blk+5Do3++SKDTsHf2h2RgPQVl2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pxuRStWbs93o8xiT1nJrjKJ8XuRHI6OpErEw8q6xqlWryrjYxaK4+JLLq/vnrkU8o
	 ZgOJ+hvG1KZgXikcxJRpUDMHGAzSaWqCqVB7jqu5E57nAocWgowf2eoLcZ7/HuTjKD
	 Dc9R8dfz8tfnKfasGnBsk30CZVkgqyHytOSTeBeo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 26725C81; Sat, 15 Mar 2025 15:09:39 +0800
X-QQ-mid: xmsmtpt1742022579tykm6aqkw
Message-ID: <tencent_8B2EEC8C8567D4C6F652C48644498B2EC206@qq.com>
X-QQ-XMAILINFO: MloVbSLNOX5uqCKrTGZgHlJbVlCkVc6VOWo8S69lcW0GdJE3mfx/F0mqF3Uv9f
	 qFG+4OSLUOT8qnnMxlTiRD+tAQpVmFLffIE2wVn7h/LjxBlHUYUT/sq2a/gfhC3PCqpeXa0/gE3t
	 nY/pPEci8MY2TpmoCqYrnCAYSNFXyXUhNdh6XWD8C4dw84a8Y1RC3Bi9FpVw35ni7UeHvNMcUH2w
	 g+voY/CjL81rfacaGIQTIJ/DYZAf4zyHxyoAtt97rbn4KVsIbr8n8yXBnaveRKPcNDqv3YGE5jqY
	 tYXHudIU51Z59HWIEjflaoSPX1fR52CJLPP+wPd3bXl+I7mnMbfH7QXa3AMrkcRQ/iWE4EAIS8H3
	 dksDPSouCRB4ZyaL79HY5ZpqGLf3gvk8uDVSst0GGJC9/YGHENoRvqKnlyf4y9atfu/IPepn05ba
	 8YW+VAsHo03Iq0yHLJ/mcSvnb8BNTu6+a6l/iDAdfhdERXY6pyOnEFE87xilOaz8Ahwa0Co553+C
	 2A5lNa8SnzMtBZuEPeq+Y7WyYZRMvXlBc2xO2/bgKMBlLADv7jYUUlZY3D+hGlK9hU5H2I3ZGRY8
	 cazjTsQcxTq+4452SnWBifcxS3YKxehbDK8dLJUkB9tFbxQoz5tK5VH2fVwNO/8Ik9YgxUkomnsu
	 7f+D/VSOJOdz30BTNemoTqXwb8DFJ5D1U1t9MFXMFpsM6wkNlu7z16xxFsXVECBKeWW7nRHYT+19
	 c0iHmu6RGBVKpI9oPYxDTrBzXr1wznqjACYzseB+uGSWAMAwDiCGguKHd+OBR9eTlvWxPLzG68EP
	 zAllTc7m3Fj3uCDYrir6jhE7qRsSd+wzm7watHg6brJqmmLhJveP+HLk2/vxawAXGHwcbs07Hcv5
	 csGRnTUQcPOOqLlv3A1RZBEiw6dptHoq07ganrymY83zujgX7yiqw9Atq2eFaMkL4oZuQU+DI0
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
Date: Sat, 15 Mar 2025 15:09:39 +0800
X-OQ-MSGID: <20250315070938.1600093-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d4651e.050a0220.14e108.0048.GAE@google.com>
References: <67d4651e.050a0220.14e108.0048.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 12b780de8779..eed4c06cd40b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1477,12 +1477,13 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	/* we'll take care of this */
-	wdev->registered = true;
 	wdev->registering = true;
+	wiphy_unlock(&rdev->wiphy);
 	ret = register_netdevice(dev);
 	if (ret)
 		goto out;
 
+	wiphy_lock(&rdev->wiphy);
 	cfg80211_register_wdev(rdev, wdev);
 	ret = 0;
 out:


