Return-Path: <linux-kernel+bounces-266813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81303940808
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125B0B23118
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094A18D4AA;
	Tue, 30 Jul 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J4IGhRv5"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5218FC88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319428; cv=none; b=iLaiH/PSh/BU3wWxkiB/EO5YFqBNGhjhi1liunpo6xpzAyQZqbwlbeSubFXEVIxomvZQFxGGbpPbWiLsVkNCDSLWF9QS/CvVw5TvH5jQLTo06XGcp2E+Uq5cn1pKWluJrXBbc+ywIJCd+WN434/KqnAb15xIXrX1bPPgxW/SAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319428; c=relaxed/simple;
	bh=LKgh5RKua6+MhfwSHIWpuhf55tMpq3rio90lpwD2h6s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HCM2BMKk90g7nuwkVUYEI7Z37a0RVBlg6haxSWxSoH/NpBAoM6wYWT7IP0eNXxyWpeICF4jD/BFlVgFULgKuynNfyTvwqdcQbm062NqvsWpA8gJfvIJAsKoTxu6hiwfnyasymYv4pEqiRaXmVAsR26TtbaF4i/DsrVy+XRz4nEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J4IGhRv5; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722319117; bh=xpbb7USSaOOWGLiNVM6XEvoq38OHFrV5kZVSEZEpbOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4IGhRv5M+ZRkTglI7fL26SLWb7IS6Sn9b+5ZpAGOKe1vjRwbvpM5l6Rncx8CoH+O
	 JbbZrVZE7kRjnmJEVE/yDQITn9g6IWgeeEKbXrm+V6yxm2P0mAFJ7v+Y5hS2Ce5OCM
	 jlK4ppPZ9WntmymiDv17VPjB4v0kTTzh5sOoSfM0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id EA41C227; Tue, 30 Jul 2024 13:58:36 +0800
X-QQ-mid: xmsmtpt1722319116tkfvlue0m
Message-ID: <tencent_A2209684364A4BE47431769567DA3DC33709@qq.com>
X-QQ-XMAILINFO: NiDupExshEc75RuHSY9L875wIKF7yqGUvHDu2vmpHIynfdfwb4JeH2FOdwA7jj
	 eFNaUxAc9KXEJ5VGnW34898RU3AcnOvX32W6fa1BR9HBpI8P5WhXHeA3KnFK2Z9dzZM9Y8ECM22B
	 98SIoPWrrspFroDU5xPuxlV5BYSpc+iVUMxtzO0jX+wC7BITX6egjInY9/lfkNBupumOTF3/WLt8
	 aYkm4bdqQt2iu8ZVi9G8O+oleK1bvqMEpZ7JkoXV1iOfSlLbVbiKp5vIDRL/rFXZzDdgvX9ZkqMX
	 2Pw7m/3smhNXf4dC+kOTfJcvbDig04pHo4uw1Vh/jhzrRf+LyUpd1TtbIv5qhv4+cwzuM9hSwAO4
	 PpY20F+SXBzG5jbDI+8RqL5/7mp1i5o6sY4hC1sAnnZdtqRpJzmJg9t7XDMdeHwYF7HLF72iyNsf
	 511XZGYn0fwcQNr5jXCh4xlImLb9GZDs0BpUmQDQTS1rMrxe32wGqYyHyLdkaO6plWfITTedzoI1
	 lIN12o+z93XZ8StFJhpEhaLUdQfcZ0Wdoigdf2g81nUufHTrHyajFImHQjPeODJOhbYIl8o15yZc
	 B2qc/3RThYxPWlX5P8ZkjuaAcft+606A19MG5/umc1hR4G2ur3jZF6J9P/9IInr0KeM335CtJiA/
	 Ak0zDCt7HTPMcbN5YcUcSDy39c4iBi1koh7IUrSBBcT9rNkjVl48RdKFbt7zN/DHUNFShEXq+dOI
	 YbODDfXvYcoACLDb8TdWh1QcKCaHRisrfltacMagtS+vuAkVB92KfTdbktKrbvzDjXO5saRNPuPu
	 5D5rOZYwpzPPOH3xyuCqZSaGigZpYNgoY5mT1Xb53kNdOIHeobjGVxbxC72kukDfQBROa70ymbqM
	 xuSG435jj6ccFvhuGiLMvylk/0L/IY99gqbMOifeVxEOL8YHM0WXZTjDcCNA07sR5fRaCydX99OZ
	 9t3P5SBaZOB9hLOXJnQnJnaX0NtKRIaMGn5+yod3plFUrK/5X7b7QqzLf/CYWB
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
Date: Tue, 30 Jul 2024 13:58:36 +0800
X-OQ-MSGID: <20240730055835.178643-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000043dc4061e61370a@google.com>
References: <000000000000043dc4061e61370a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the relase dev to the end

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..3f3abb6efb3e 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1118,15 +1118,13 @@ static void hdm_disconnect(struct usb_interface *interface)
 	del_timer_sync(&mdev->link_stat_timer);
 	cancel_work_sync(&mdev->poll_work_obj);
 
-	if (mdev->dci)
-		device_unregister(&mdev->dci->dev);
-	most_deregister_interface(&mdev->iface);
-
 	kfree(mdev->busy_urbs);
 	kfree(mdev->cap);
 	kfree(mdev->conf);
 	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
+	if (mdev->dci)
+		device_unregister(&mdev->dci->dev);
+	most_deregister_interface(&mdev->iface);
 	put_device(&mdev->dev);
 }
 


