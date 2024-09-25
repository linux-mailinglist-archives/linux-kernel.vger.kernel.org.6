Return-Path: <linux-kernel+bounces-339114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638D98607D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A671C26347
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF018A95B;
	Wed, 25 Sep 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F9qdFkRz"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8E1E867
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269380; cv=none; b=Vs8FnypL2EUdXmL2gU4CrLGbosFTeji490gRA1BgkuCtOHvZ/A6MDO1ZwkL+7LedzC5SygSDeKHRqy7BhD491Pzw1NJAR3FV47gUifMI456OjKquFJwsv+ezi2X7ymqsW06W0GZw38ROjuFWcccvap6/x2jb2pCsSLBLuWuN7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269380; c=relaxed/simple;
	bh=KOEiUEctGQ7kI6Bde7OxoQ1yHJmuLqzRA9d9Robiz3A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qsSTTxoTUbNjdxj2LIQMZkq4c38VXikXzdv7stgjcpP2Fzw29WhqKf2ZfvmwyrHc1YXFt0svFBim0tRicBjUXBZyEIrI0Iklyo6F8SPtI91uA81eDVAUbOzF1cjkQkkN7BxZxC2LAZHesc4KCEnLCO73n40/505yxzYAWp5jCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F9qdFkRz; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727269373; bh=rRPUn0Evj9zoENz5GyHpnKDZyOFmbOKehuhdafvM5YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9qdFkRzKlVJLSAMnVOmOA0w+qoq8b7h/0+M/5yR1DL8hRozShtiYTtWbO3bHveud
	 bs5KgRRf7aRlE5WdZkEVvXcYD3oTyrEn7/n8iho1U7nk9AUGg7q+F31Kg7/ox+o+8w
	 104kOwVqPcx5RhJPourSeRCEef0r+R5pTnSwNIgM=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 652F0FA; Wed, 25 Sep 2024 21:01:37 +0800
X-QQ-mid: xmsmtpt1727269297t9dxcwaqy
Message-ID: <tencent_E8477769977226C7D37D8373E975C3AD0405@qq.com>
X-QQ-XMAILINFO: N0wO3GTqxQkwrH/+PV8ZxpkKyq7i1j0YCkqvUlmjdxKCfxKtU6aj01nDAHfNp2
	 j6bY8KCBdgiXz91sY2hVTKCMH1wsb8KdzblTzKvu2Xaqy2k6ecGfp/N7YdWb9zuUJledVe0k/BGS
	 6SyUUV0XLUFKmIT+PkX0cTWu1j2jweVDTSMjC5yuqMgti08A8vG7iWuwWKPe46sclFD0fhyJDqql
	 hH8AHdLsiOWnWT5HeEBpjUEaGIOLl7toKvogd4lf5MH8UFpn/7csMQ0BfxaNJvkxI/yGdHs/NS+w
	 yd/6kGuHCOo1+V25ngHi3KViLmPzJtFbf58S5IBq45zmnyuAXp6JBIhGbfGwdZmc4ukGGhOKxi7e
	 1G0ooN/ynG1hjwEJxa4xorUPzr28FaBD7nrU36godO8i2lW1oUmC5Qp/7JUnqmB+GSAsCRR9OVSB
	 aVe0IooaFaB13z4txFK4VZD5DVkbRoSmQbqYthkQf8z471GCRgR7rDO6LiiWey2KllMmtxhkXIhZ
	 7AnWlWmkmvqLucIs7jfW84g0L1uLWqDU1kpH6T1k4Rk7BtWPeziSDLlUIEkqjGeNV9bsR3Ss9vsz
	 Lb+mgCLaZJn4wgY1ciGto5je/uxP40fhmrJpcjqCKLcAAlBhSvkaHMRAePUKMCQZ7i7T92v3dWeE
	 p8nVdmzX7no/R/V9EMaSKf72j3miJZkaM+2lydeWbGHzan41prWX2zdokvrk1Waq6gPOexkuNu4h
	 Zo7FY11IQ9wWOtj0w7WLzdjtSoQ9B5HS4+9edrixKC1fSRaCTL//gdndK6/iKaBkbTMfExPai9qw
	 gAH+4CphznKlAS9mjIujxtDMZZX9rVjC/UONsGlmOL3pIPBBwmMr63fODbkQLSsiLaWq6WBQ266i
	 rwe81uE/1hd9a7Yn2+UY6nHjdaNwOMQrBGzVl2ujsQ/WEYuwpo2tw/e/yvdUySly2Hp3lJihxz0J
	 aGsPNNKr7T4ptxxrsiAFcy0eyV4YB6
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
Date: Wed, 25 Sep 2024 21:01:38 +0800
X-OQ-MSGID: <20240925130137.1511250-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f33aad.050a0220.457fc.0030.GAE@google.com>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread_run return -EINTR in read_btree_nodes(), it needs to be returnned
to bch2_fs_recovery(), not back to "ret = IS_ERR_OR_NULL(t)".

#syz test

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..df7090ca1e81 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -281,6 +281,10 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 			closure_put(&cl);
 			f->ret = ret;
 			bch_err(c, "error starting kthread: %i", ret);
+			if (IS_ERR(t)) {
+				closure_sync(&cl);
+				return PTR_ERR(t);
+			}
 			break;
 		}
 	}


