Return-Path: <linux-kernel+bounces-319985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 475AE9704BE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77DE1F2205F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162F15E9B;
	Sun,  8 Sep 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ACsM7TNH"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502EF9F5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725761565; cv=none; b=uNF66T0oIJj896m71AbiVTWmO1OM9CP305cJh866LnFlEnmn9OITqS6Kf/wX3A78g9To9ROitc7m0HbTag8RSAsHMkBLQMhLziy7MweQ9sBFkx2nikf8o1kfGnCPdFjzHolYefZar654MVcJwywvkyEz6eu7fKY9qkHYk+m+2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725761565; c=relaxed/simple;
	bh=dl0CxYg5UWc0APTyiv2Mkn+61/XGgIL/Vd1MVgx1xpE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cUdHQAHcPElepKxjghEohSKRMv7ti3RqtcUrFJSCObCJ2uBq4v5cWEomGZrRhpGl7UEhfaQ4nuISXvTNhx49LTJQjs+k+stvpmjrCJrHpcgbqumQKYcfcqG0EqTIJ2VPIrQlezS+jp+TwseZspgFmhT0oPCHiqFkhnSn5mAAT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ACsM7TNH; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725761554; bh=Bj+PqOqMn1PgroPj9aPyytxWchT5vSbBLKiYdIF/Z/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACsM7TNHI6Y0xWTdhEMd7nCSdUOtdmYK0zCL8FL2W04FoXyKyoLVjmFa25qp+CCwx
	 KTuQ+dhMQZPt6IYcMS8mUiwtOgrDPT3ycpSdB0lVS/BkZBRScXmQsCUEuXcM8hpArn
	 4rSEaUpuhDsVc7D2W3CGGQANy3GipW6PmQY5Wa0Y=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 195A922E; Sun, 08 Sep 2024 10:06:21 +0800
X-QQ-mid: xmsmtpt1725761181ta7csgfyd
Message-ID: <tencent_4264A96683BCC4583779976346D633660305@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XncBpjbeJLm4lmIaRcBDRNyUSyrywWLTTijac53ytk1Lia9vvJIF
	 7GXkK/QTj7ByupgqgR/ARj7PLkXis6ajATzjDS/y9B0n0KOhq/tpuhVa2UaL5ej0+33r3RFz6+Yq
	 In/aj7tc9JbfapPBCFkP8ruYs+qvfeHfyj8pKEhX14xsqDSjYeK0HCDJ+uGRUXm04oSztFU9shaW
	 VsETh7aQQa2GhJIOMo0Mz6rIdiR8I8yJzWOiv3RR3C1d0Qvks5o07WEVr+WuC3MSsdmEe2bCRSbo
	 gea5YZxXxIEbHJzOwNQqvxSuI82v7rRNjVYHedoj3IeUmagYdrL7SGUEiW+dC1nrk1HIOz1ww0Gw
	 rW8fc2H9xVfWd4I4fMmxp3H9yBjKWXUAjdDMlVvyTvbdK2VNHsw9t1nmyyUslW8aQGxsPUgEGtT7
	 sonDptkZ8fEc4tmx67cX7OG30b5TefmvNYDTWlwEocmk1huVNDWN7pnTo+hIoCXqx+FnEAQDtpFr
	 KmTpqP6ILqkN6ZNeBgKEbbBa9kDm0mh4+akNBQgVVpgZFsW+DxozVCxFsAw7+8myLYDbxRG20CrB
	 fYggmFDLtgHFmJs6Y4aSOcukACUvYupP048GJzQ4wZvtGYDp2kZkkayOud9DXsGEmi9n322zDY3N
	 Vq4Cc/TcKq63kCbIJoCw8ZSZKHKB6NPggtLS3AIvR3NqGfTL+ejWplKWquGmIBS04A9anHHTYHk2
	 CuO+bXxxzUOH7M22VqCB6oo+DlZ3FASpWjimwA3fn1J2iaS9HNJ3WujeK7lotUEWqoDSL5ocsFVF
	 +mqhl7sGAtpHLS6MWcWDswAD+WRXAzdfYEiNrgaSWBv7p9GH+RRuB0jGz/ZuKMCfEDvV6FgZhNt9
	 otNcWg9wLgvhZPi4Oz5Tq+DHnPblQsrUzLrgFrjIFtKS08016dBHVX/N8MZ8URrXEy42BONxnn
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 10:06:22 +0800
X-OQ-MSGID: <20240908020621.1275854-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: <0000000000004a130a0621888811@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

after release conn, we need to cancle rx_work

#syz test

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8e48ccd2af30..5050d20e9cd1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1264,6 +1264,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	conn->state = BT_CLOSED;
 	hci_connect_cfm(conn, status);
 	hci_conn_del(conn);
+	cancel_work_sync(&hdev->rx_work);
 }
 
 /* This function requires the caller holds hdev->lock */


