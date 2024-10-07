Return-Path: <linux-kernel+bounces-353162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7A99298B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1283F284519
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA321D1302;
	Mon,  7 Oct 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RAMVeHq0"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAD199956
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298440; cv=none; b=B3veGsb4zNm2jTbgfHJl/MUwf4quWj22VHHGjIqhg5ZROUkKQdSeGmI1peGEgu+pF/hV8Zc7gmiHGQ5B6u64vMqRv8C4twLpPudYzCAX4qUjbjjLDW1MuA0+iRggpa449TBcaze6C7yIG86Gt4wVcJKuyydURROUBOqYoRp4Gjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298440; c=relaxed/simple;
	bh=peJIajO8WRJeQMbCxFDKR4/zxLRRqanCybsIDi+aK5c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a8rPnav5oTSrDiqcTlHYDWJVOKeIBRG7Tw6Wbo0L16QCPqpVyPGaKNOlxuM96KKwWwqpV7PePAI50+tC/ma3WZRoXLlmxYgaB8D3OPGTjF4+KpbsUIrLGJKO9mEMhwj/qTAi3Kz+zKg6fkA0p5BA6VQPq9fD/tOc7y4TTDod3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RAMVeHq0; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728298434; bh=NjCxvZLPN5Hbo5qzhGaTXISfrWcAhOb8lZVBjLDB6fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RAMVeHq0gt7kRwa4Nxvpd6cwXUIa6F7cqvt1zr20Evb5LoqlfiKxgZnc81W/VeZHD
	 Pv2fvEhp0lPShTb9SK0dwKYXS/xCwd07hY7GogEbSn2P+4smlUeJmEKDwieggX7rhg
	 ux80+PmCG6OH+9JhpCXT5Ca+oJzVcvk6pGCMgrc0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id D748F098; Mon, 07 Oct 2024 18:53:52 +0800
X-QQ-mid: xmsmtpt1728298432t6vkrqgbv
Message-ID: <tencent_E4F3C6420991AEE0AEEB4C80A7CB06CE5206@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujOt0xq9n2i0HPVknZU67nxAyAWtV8DMysSAC4cq55am0Wygzfti
	 D7bgAxU4GbZYV695Hku4P/ECeQ0SIVFMznaSQMLGbXi0c6HLUkiSOHDraSlDVt5z/izMNm6fYTIz
	 Uk61wsDPXcyohLcldlv2U6fBuiGmw+BCwDzTW1mkEQxotrV+o8IPZv1KI8v3EneuxEYwJVGQqgse
	 QyGRYwvhl+rqwlc58hyRQ55alueVrPA64j9FNpw56LH6vf/5Mo79QynyD3XQAl6zlk1vT5s1AuIu
	 aBGWhTrvgEpzloNBB3K3nyj0lrC7SOlVNy/takcOQHDVjbglmKFzuZamQbzlQxNIjbQg/Nsg1+Pa
	 JHgCT/l8x2fI+aEkyV1gmm41fNYaJp47hUwqSxZQkF1MhDIQIYWTVnWnF3RXyeml1NU7rHrBt6pr
	 7/7IXywrTRrSWyQOZeLc85xiU6E83EcffdMEU100L/wx26ZkvlQUT6qaS5HuqCDNecJzVBl40ovD
	 rOaNZ3MOIOxuu736yQpNVBEqTmBdhyR0I38yQasmZaAyjy0a13+E3iIeySFcoJW6yGWHffvyR4LM
	 SdGJR1XqcjYRKg3PH0vAfC1SMJw0DmL6QZoaw34O3PMjQEGZ/bN4p8O4ktsR4nmiFsfw4MzR9aIK
	 ZO8uiOHWAnJ4uLqDjYNAG8+9ugORFyWpAdxiNRJLuOmXlfUDYDDf6cp+/z0XavQf91HGeOzl6gSg
	 MDH/JFdVQVIFvZggerBkM3rb3QqGACpreQHQ7JuFYhz6ooHvQCA9DWmXBgq/vqTRNShO64sMQ0e+
	 o/pnFOof20+6kZkwCcG9mV7Ue+6A8yaJet/ZN6CxxWoZmeQzrp19szPtp9h3Xbx/6EoLV7ljszSP
	 poQK7+ZMSsI6aROvdJrxmh2I8P1SYcHpQG3NHSPIJSojZrGTmks1VfA5CGCscjOQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
Date: Mon,  7 Oct 2024 18:53:53 +0800
X-OQ-MSGID: <20241007105352.3364661-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6703b264.050a0220.49194.0502.GAE@google.com>
References: <6703b264.050a0220.49194.0502.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set skb reserve memory to 0.

#syz test

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index aa6af351d02d..b2e99a83d6c7 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -492,6 +492,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
+	memset(skb + len, 0, BT_SKB_RESERVE);
 
 	pkt_type = *((__u8 *) skb->data);
 	skb_pull(skb, 1);


