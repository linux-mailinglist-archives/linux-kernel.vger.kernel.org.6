Return-Path: <linux-kernel+bounces-191630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA208D11A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863EE1C21656
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9EDDBE;
	Tue, 28 May 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n9QISdfk"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E013C17
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862508; cv=none; b=YvlZdMf1dbPB+nwwUNWQq1V0PtGHkX1Vd+A02CxvhBr4mZa49gpOypAURME0bAYeOmNd1SELAcvwo834bkcfGT7vsuR6z4bpCb6GMA0dClTM9gFoDZmWfrSE4Cpm9a8VdL3jbjYHhPSujznxLzdWc5hupTxy2IvZZ8saFl64yHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862508; c=relaxed/simple;
	bh=t8/LJ8L6h0+PIyw5VJ5KkZ4tvRkXejG0UTzWn+qi2+4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P8WK3mbj5iMK5+JwYHr+5vNiniD6+QiifYgrJJh+6HjwTVIA0yMhePEyCgRoMKKb8R6GpI2ShEdwdYcT43ct0qbg1UpSybnnv1n4f/NaoKhSqveSsOMTnZyF84qhmcVsfKw7ec+ChdPv4I2eZGveI1mu0Mnn8nmBwz2kzpMkJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n9QISdfk; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716862496; bh=mlF9rXzPzcXAxRx+cJXgPkHyZabDkm26qlONQvRgT24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9QISdfkpHvAB+Ox7A0QTo648ioa34GG5uKdw9Th8+eOINHddLQqalZea4OF6+w2V
	 qSVyWrwFRnzvovgSi3Zi1269oXW7hy7M1M4BG/k3KEZTuBJxuNIJM3KcBdhtmg0xwJ
	 5m4WhwQ0ZL9a/9fgNrf0JXvEU5ztq8WLclsSKIwU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 3B600C85; Tue, 28 May 2024 10:14:54 +0800
X-QQ-mid: xmsmtpt1716862494tkpl9v87b
Message-ID: <tencent_0974B3778B662A3DDD36E0973636FE4B8609@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6a68qvbgUUYSm2DO+Ym3ySiJtxG+YNzVa1x57O+VNnpNEYpgWBF
	 jQuIXFh5JnaXF+sNmUsyYyON9iHTX8iBTXKaYejKNcjAi7ba1dftilVtnNJNwJRERyzjoDoowHvi
	 gU0hF/b4olF6qGDAyiJ/TMJ0CawkSjfiBZrJtwM9J1WGLt3ogIKf2eroWiytQuK9AM8c4zl22VyO
	 diSIjI3laxcxyGBUKRKgRVFB4jxhfasIG/IMnR2c61UmaWXW59P9RjGkfpYE8Cax2TXuT4xBYzya
	 uLORnwB1oQwkk896qOjmDJx/FZVV0bam1Zr54iVuTimwEpMPL0jU6iH1elOZHnG2ZoQcURcZlHlF
	 yTq1+FzDhPqJCQg0+E4bxIPlie35xxiE4CywAESVz8n9LXejEHK+xs694eCsZLrn0DvQT1H7WP58
	 vxc3oaDroOtxmY9Kg4NWwJu0fs1IGv+zXxKoFHqXnH7HDKFi+oKf+HNunrdbJiJXiPFa+Pwdn5RW
	 RLiXWCMhZluAhcAhZV0Algo8v58A/XWA/tfwvfnrQgEZQGlLksic+Dn8K6RWChCfDiYTCrft1cA7
	 fJ1LBnRNH/eg5TC9GqorPUFd7R9pYDwvmn7cFZVCmn7XreNdUT6pTkjxXno+UW1j5aRNqGoluxxZ
	 +5a7cYaHf/+hGuu2Z/F4lKBOE0stUIh86gaJ1TmKWmM5BQgGcZUKNzSwQVh3Blxkh+oWiYndyuio
	 0EQ4AA0x4/pJxofB4/b6j3cPHdfvIhUDWNXjJ3NxokjUfgolW15qsgQTE4jjc5DEW5IzIl5R+P9V
	 W1bcQ7PXVAcFjPXY/7+0IDNBtC2rcqC/gSjN8a8C1mtbQMrcQ/uhIZ843aNkQRsy3N7mwN4qnYQ3
	 5pwCjKQ801VlhpyT5I0q8CHXcbng7AYXSi25vCI0Gfhu6x6IuVam23yjW/hgzqeA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nfc?] [net?] KMSAN: uninit-value in nci_ntf_packet (2)
Date: Tue, 28 May 2024 10:14:54 +0800
X-OQ-MSGID: <20240528021453.1105390-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007018c0061964aa67@google.com>
References: <0000000000007018c0061964aa67@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv in nci_ntf_packet

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 614da38e2f7a

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 590b038e449e..6b89d596ba9a 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -125,6 +125,10 @@ static ssize_t virtual_ncidev_write(struct file *file,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
+	if (strnlen(skb->data, count) != count) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	nci_recv_frame(vdev->ndev, skb);
 	return count;


