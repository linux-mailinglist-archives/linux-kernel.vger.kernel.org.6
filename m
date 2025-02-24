Return-Path: <linux-kernel+bounces-529039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D4A41F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950223A4988
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988A221F17;
	Mon, 24 Feb 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZSChmxoZ"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4EF4E2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400165; cv=none; b=AW69hRHTKAd9jaSZEXCGc7agpOsTRhve26Kjt3zWXSQVpo0ra7g1dWcTovUbYYACkyuxVi6WtXVEvj/yqbKcWhxLKzqIDCMZ4k64wjfPPAm1s48R6Xro4eo+ZLGa9BM9Uyc/KWsskpm1e0YgmT2sE4sy+nwBLGiqt6ddd1fqxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400165; c=relaxed/simple;
	bh=RFe1ydalf8vwBdsFJ8Wj2bKVjLFoxUY1kMZeT2QhXSQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Xm8DN5PDvJh4d3q10XnOT/ZF2E3ETN+p56a/zxRames2n+RmTWh/rKL2URWa5DRVc2CuGFk6lc2dAXDkl7a48JYbX0oLLaD6DCQEh3yQBWfwuTED14tyG+hxNYfCsXEuJvH+xT0psFsDV5Gd86T8TgrOShMMNOKK+pmq8ZCwC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZSChmxoZ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740399850; bh=HrNFaY+qaUFsUEoz8BRLQ7nHOgdzdV7YqruWbvhJMXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSChmxoZr8nR/PmDHe2cydxhboeRMN01AVQMklrAbnVq5jkUpZp9uZBtGCQO2ruWa
	 SXfor48qgYCoVG+Tpg9YQC0HdJL92lE8MrE1cv40IGT/VSxN+27+Eyatcp9lF2PEXz
	 7P371OQ3E/k7DQH/il0zPQGVcSZ+ZFh3tTXi9Uds=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 6091788B; Mon, 24 Feb 2025 20:24:09 +0800
X-QQ-mid: xmsmtpt1740399849tbq3bwdd8
Message-ID: <tencent_52D2E1065D498D2EE42EFC0C9CA7C806CF06@qq.com>
X-QQ-XMAILINFO: OUWxYGO5ICDbYUIJy2A2CswdVOTQUjosA13SU1AZiSi98oek7BabcjBBAt1DWN
	 DSaL4mQjObz8+boOIx3yZcp1skFJsG69kfnP0F0G6Pfbb3VzqnyAQViEwN3iaeoi/bTkYHYBwOdp
	 ufQ3+HSP/kymEOTRTZuJDAh8LgHnkH27vITQazL8D6QI9eTFQae20Jp9L7IYbAPiGEU6QbyTXQMV
	 3gtLVPvb//tdO5K+NDQvqtHxvVFIZCQZoZqcv0vvxASk2ZbWvhQAsNyP/MY1NHtRD6eeDogjmArD
	 /Zz3YPfO4fQknPNAfONoXP+7Jf9M8UBkMLsz+iLUXs7kqa+Vw0e24C4NvHDpCein2P/XkLIRm7LZ
	 2ir8cMLV++md/5XkprX78+xELr99s72h6hm/4pHVLVcT3kock6C9pVcdC/6ZEHQTmw5uKnvaQXue
	 ktfVBNed0/eEYUMhN1nU3moF5iiHSVE3hwGJIfmwM3VOX9fzpPE4nIgXzfskw0/2FZzJMSma8Rw+
	 bgf33V0ODxkuHRG8HwhzVAt9afbCvllDneSkK3HiM6aLJ+C2mDCDApUdtVmfLAuwWtnN+RlmOq2e
	 YiqgRLKsjCpDPcd4HeriHpARkroOsG9+W4jOwyN3ByFoGj7pm6DYi6AjgNl58Ey0JtSBKtPRfeQ5
	 BDuao8LqWPreaBWGESsYncNGqEo8WUyrdSQpRl9/gR+nUx7hScSn/kzpBCKamZ5e4bvZzphe57ae
	 RO0AhH+Vw0xSURtqWDtJ4fQM7QRVrjcUSdQY933RB7pzrXzv4D/KBbE93RbyKkkMZf8iFDsvZdKn
	 CL3vssr4HAfVdTvMKxBuFDUmNbcYWWS2fcXv2RQlv5CWWbJcoPRZbGXpM4zvoTJNib05YqNlVH5u
	 N7TlWRygSHwsmF91HlICNalWnahfo7vgldm8s1EVo+xGapz5eJu7gmHfOIZgeXnuGj8t76yKRzMC
	 d59YJH7CfGnBzbwneVozDGrKE3OIKa
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Mon, 24 Feb 2025 20:24:10 +0800
X-OQ-MSGID: <20250224122409.639768-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index c9e65e9088b3..1d43e4dce14e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1139,6 +1139,9 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 	unsigned long flags;
 
+	if (!steam->client_hdev)
+		return -ENODEV;
+
 	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
@@ -1153,11 +1156,12 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 
 	unsigned long flags;
-	bool connected;
+
+	if (!steam->client_hdev)
+		return;
 
 	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened--;
-	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	schedule_work(&steam->unregister_work);


