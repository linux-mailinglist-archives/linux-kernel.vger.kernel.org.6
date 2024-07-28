Return-Path: <linux-kernel+bounces-264474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30ED93E3DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6732B1F21B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E328F6C;
	Sun, 28 Jul 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n2s+v4TB"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C838C07
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722150185; cv=none; b=jKWtt0FxnStVE3VkGJNMsHCPaeCqHroocRybM3/UhQJXXGQGRJMUc98e4lSYb3oBi93fsWDBJTcxB6ONjczOpXZFc2Z5UbATVIRpv6AJ7D52ONE+cbUrK3jKv9p+QSZq2TLgRjWbY1xhtNhVvBbnQrfDeOnQDCRzSoKES1gRxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722150185; c=relaxed/simple;
	bh=3Lk9QPyMjT9AnKkiVgkQCgIDyaFJvAhKIDHQPfRcwlY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UVNmuTU5fUZZ7KGabSMS+6de2QNp9RjR4qEG7mYyPi2YBzX9VCrNfgCwEQTOxRolYS6k7ufMOg353A9ox1icAxYFz7J3vIGHP8uw0UDNkqWAUFwXmhrOLBXDbLVevJIxVJLRVlGZd3ghAXq62WRhE4dL69wOH+iH2tKLyzVrLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n2s+v4TB; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722150171; bh=QQl161VCYfjUgThuPFuSEUJUlLukZjLOJrg+mhVqy2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2s+v4TBcLUMc8fmsg6HJx58OaS2pjNcm+zKX9HqiSLfQxv7rG8onkIoypckFIZmG
	 92gXhDD6o2q3c5ckxGGEHhbOxUnfp+TGRFb8MVYCFoX164SlQe+RcUCCC8l7PcOcwQ
	 /0HtLeZ5CRGqXaui+9BrXzr/w63t94n/VAoQEMsw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id C5F88673; Sun, 28 Jul 2024 14:49:31 +0800
X-QQ-mid: xmsmtpt1722149371tru2iibxu
Message-ID: <tencent_31BC2C256D0C94CCEAB2EEA6CC8478066D0A@qq.com>
X-QQ-XMAILINFO: MntsAqBg2ZZ5rPXIuQ7DVnC8wDnc+MU1oNslEGGFRp8Hy0Pgss1RYgkd0i2sOF
	 +vhY9n43sGcEZGP0F2BC42YH8DAbSLJ9sy25AGOlFWks2/2yajTovj5htv2jeBMeuTjYsQdeBAwj
	 B0eoTZWcOKeSJ6SvAD424A4R68Kn+5WMtT1HcTU9ZcrUmO4xQA5sZbrK3aQ6aKztmMD8DHe0t7lw
	 px9JimLw0VZPFS/p21ezdPpHry5Ueki4u/Hzb8fFxxyB96Me310rLHKoJTe2RPayYjXCJLVK+u2c
	 wqw6OpDmn4OoX2+s6/db0Fqf2f2lwNhRgJRx2uRY/tiey/sXXJturT7mSNBhOHntPwPskr86OSE0
	 m3Uk4BcI9+MztL7lM3QdIqZ3Rg7y2G+mPkdCAK/x6w8cagVuDGU9EleFXPGtXJl+F83iMsfje0OL
	 Wp0Ry5dMHIqRqsx9Kr7vpFgEDhAoLOGM5sfei0oeVcY/IVAModAKdCo7jhD1OpHNAa4Kcl3Uu9as
	 0FdoWFg48TSK4hk1HoP6YBnBhcqnCGUzHUhMuQX5zw4KMfTpikE3pURmXSc3WJTwFQ24y61/lFdC
	 dV1FElnkeNDAna7LHzp6MrvRSY5wLJcSMoT11ipbT09VTkeGDrvEzcwmjGElrRb+YGoof9tYQJR7
	 pomiOIGF96VPNyrtYH1oGIyyuTVLmPatULVfqJYJVN1ij4n20TaT8qSZVvFqUVdZtEUyz9fbhTkA
	 PpDLYaKxTGFytUsRGf2cIM2WV9KyjdqMW/qgFAVB/Tlcp7S0nyraeaitZInOcncyJHcoyxNQ2oz4
	 RPW1KpckEdsYJ7GQsOpb4kW8D4BDdwESe8pzWrwMpl1SbaGqYrVngV1UqD/XrVWKt1UECgSw1Gr4
	 9ReUgQexOwsK8+KtxCya4N/znyu7rp0wyofv+0ShJEvtLMq8ZZCTI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
Date: Sun, 28 Jul 2024 14:49:31 +0800
X-OQ-MSGID: <20240728064931.3461960-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008a971a061dde1f74@google.com>
References: <0000000000008a971a061dde1f74@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in cow_file_range, only ret == 0 means succuess

#syz test: upstream b1bc554e009e

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d62c96f00ff8..a82acc9df20f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -762,7 +762,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 		return ret;
 	}
 
-	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
+	if (ret == 0)
+		extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
 				     clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1043,8 +1044,15 @@ static void compress_file_range(struct btrfs_work *work)
 		ret = cow_file_range_inline(inode, start, end, total_compressed,
 					    compress_type, folios[0], false);
 	if (ret <= 0) {
-		if (ret < 0)
+		if (ret < 0) {
+			unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+					 EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
 			mapping_set_error(mapping, -EIO);
+			extent_clear_unlock_delalloc(inode, start, end, NULL, NULL,
+				     clear_flags,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+		}
 		goto free_pages;
 	}
 
@@ -1361,7 +1369,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
-		if (ret <= 0) {
+		if (ret == 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
 			 * with this page and already handled the IO.
@@ -1369,8 +1377,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * If there was an error then cow_file_range_inline() has
 			 * already done the cleanup.
 			 */
-			if (ret == 0)
-				ret = 1;
+			ret = 1;
 			goto done;
 		}
 	}


