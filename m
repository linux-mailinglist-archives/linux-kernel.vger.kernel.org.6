Return-Path: <linux-kernel+bounces-319997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EB9704E7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7ED22828AB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B81446A1;
	Sun,  8 Sep 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RUcLKxey"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0A3A1B6
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725763762; cv=none; b=jIx8GNsCbrazKmrdUVT4W4pUehPgSWfXAG0qWHzllhwR5IqdFUjI8mWa2DODoYPVTwRmzljCltq74tDlvgDgd02VftyCcdgVn0YcnNt5OA7wsEJCMo2sPHyeL+J3U76bzgeLu+Tn+nBA/XZlNkQwYmYrPtg+B/ROnVZQUFm3jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725763762; c=relaxed/simple;
	bh=m1mPtax5f3fuV7CDsZcLErbknRkvR50bW636SWhKZUk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jnziov1jMF9+sLYU7AzYH2WvaoXKoCnF7hcBZpgWyZ2HLBEvp23u+vmXQ2DfOWtEKt1kW2dPMfarOrK2FyQCCffcvHASAAkoULcoexq/7s/PW7UqvKBiPkgXt2dBEUzJyp+q3q8qDZ/QHRLJ4pMuqdFSRZEhOKShTpu/gBHY4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RUcLKxey; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725763755; bh=RoHWqxodH76a6PALgHDW9+kez05jg/j6g3lMbnKMHtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUcLKxeysT5rpuqBk2lETmwtZODBjGFvui8stCgio02s8MJZOV1H/FRD8qt9eHn5F
	 V3unhh5EFYePBOuxtTZSmqCveNUj9bvG9SQiZ6OKhbvMZc1LJV0YGYrOu+cIpaQLV9
	 U6XHBfTtQ46oMQXeELN5aoWTS4nhzKSQWepTfsxg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id A450B8D1; Sun, 08 Sep 2024 10:41:05 +0800
X-QQ-mid: xmsmtpt1725763265tf0fwe3uh
Message-ID: <tencent_891763176DE6D7D3632361C96023BBE44F05@qq.com>
X-QQ-XMAILINFO: M5Jk7qYLFVj1SBJYeUp4z6O3+GBQl8K/N1xACpPhmbuhlyWdy4qXbZQ0f5UugE
	 LzdSkYr4bQhivwcywCCBlUpw1IAW7flpKaAqI6VLglANVc/mezAovoLuE1Zf88OKhD5yF3hwSBR1
	 NXlxlRvCLIfMdKtv2JYELtYenlsgU33pRSTd9Kuygx/PuieeY+HJBK1B8664TMCUaeP1tOzLyPVw
	 02tAsxgkPVHLAKl6M/v2fjRyATSb5apRbVL4/HTwxXcd8CVWdbO7creYtqJPviyQRD2Uv70ajuXl
	 wl0oZv5NXW+7QUJOA10ontOyOU0MHaT4Nv5QIUQ7+WhADS12GreN+IuRK9EZrZg9RjguDE3LRo2l
	 QkQ8A9BGGq1lnjcbRmj8va0MkJr6HJJ1RvzpPmB1O+zlAE6ymbkEYtg/Ktl9RqJfI3CfKHR/zLAe
	 YdjEjxBtpNr/leQ8LFxs5R+go48tb/sSna+tZaePF9jKa7K7hjD2Qb+II7ZwlNWq1LTzp9Ved8m/
	 dXxAHDXTHrYzsvTZ3/QCuJ4WcjtDUW3YS4fVhhgWZwwIykkxaJGetRS3j5R5sLcY7JuvRfxyHUqf
	 6WxDR/mDyyLzGVYtDwSz1rj3rO70LGEBiKKs6hK9J/ZT/T5G/FCDXsumIBFgaMUgu/v22DV+B04V
	 FQxtQymX44mW98GEeaKfSjjNStIp3x9Uq2F3RpBuoVQacheckH7EYNaO9uhTdp7RBHitVOiEbNtz
	 F7E+eUtijtVsvlstO/RF5Juz3I8DsR9Z5O/TPVx3c81sPUDniFMnbCKj4wdTGpLkxGE5LBC+II1f
	 7MavDDD5synAmIkELLObjM5lPW7OlStOJG4WqdOSHne5WDWd6msblHEolqL84DzMPuMjHfyJgDgA
	 DVsiY3/c8CpuaIUq3p5LLLFT7fy0vJDN8J/3ekTPQ9xH/uyyI3jLHPZhsv1j7wzaKuFrxJsAIh
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 10:41:05 +0800
X-OQ-MSGID: <20240908024104.1302012-2-eadavis@qq.com>
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

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e79cd40bd079..6d95e07d9ddd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5499,7 +5499,7 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
-	int err = 0;
+	int err = 0, failed = 0;
 	u16 handle = conn->handle;
 	bool disconnect = false;
 	struct hci_conn *c;
@@ -5543,10 +5543,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		hci_conn_del(conn);
 	} else {
 		hci_conn_failed(conn, reason);
+		failed = 1;
 	}
 
 unlock:
 	hci_dev_unlock(hdev);
+	if (failed)
+		cancel_work_sync(&hdev->rx_work);
 	return err;
 }
 


