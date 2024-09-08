Return-Path: <linux-kernel+bounces-319980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A89704A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72561282C9C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2CD27E;
	Sun,  8 Sep 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Uqdgc5Jl"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88D79F4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725758999; cv=none; b=oF7y6JvzOhsBVxu3iiTU+GhZPXn8fQkv/1VUkBJr2QrhR0B4k+Abqf1OQoyopXthdqr6QBiwG6ISiCpbGsgrVdbp5qSE1KZwG33cDkhu8stYOSuoCVn+fTQBCp+zdjD0fN+Q4Ye2wk89m2SI0sI+9BmeGD2/uqvn+N+UrRTCCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725758999; c=relaxed/simple;
	bh=OpUsbBx2/b3zFCp9GdTcj+plkMZuxRSjZYQZb6oXB8M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OlyaVam2W2vHPzo7ISc/y5MtX5zUC6vsyullHaxwWiA0rb2zZSsQOOrVjIgJ4o7baJldy8IK2/KULvfxtHCqVHify+6AmtLNixsI+Qsy8U7TstpqzFCPrZSwO+vKs3wvo5Epb3Jx3xQ9JgaL06+yrdlb7gjxQa1C9K8p1BgvS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Uqdgc5Jl; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725758986; bh=1o73BUYoUjXnjd4GYZXtKpU//ZL+y4RaK1TyT2mz77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uqdgc5JlKMZbKcWL3LdYSLNcd/Q0K9FQ2toyE5i4+7wlULiu0Qu6f3EaxtEtIEv6W
	 By6usrPzK3HrXH1oaBzKL+cuI2zEf5yYtRHGtXP1Ec/0npT+X+ODhDuG9Ghp8X3bNe
	 HjVud/AYzb2bZnkn+HsgXMUJ6W29qsU8lYy6C9Mo=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 71F3DA46; Sun, 08 Sep 2024 09:28:31 +0800
X-QQ-mid: xmsmtpt1725758911t5iijvrzj
Message-ID: <tencent_76044DF76E976446D4336AC37A297143A105@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z6XA/RSz7sNnIyA842w9ZZ0q6lZDSKG6lJItKQloHt3ulRGhgnv
	 0kGN+NJQGkEXszXoUbrquWFCCEtEzXi5mDlFRBEW/MfATx+eTeX1Q/n6Mx1dd3ONI+fhh5ENFshp
	 0uHsVIrGjxq9ZLgnkMlemsU5aZzDPICQtgYAahqiDzETXaQV9PCgAieNz8yB20LhxZXGRVY/HNms
	 UKdg/Ag99W4uUESE3o3WMKGuGrNuOVfRaxOr71+ZbBRXspq1Ya6Bm5n9PsgR0wvmQwTRYeU3SOJp
	 IM/x/sDhXO7BVfGfWm993LagbJ38NfZWiqrzu5Ylh44ykwE/Rhy1avoZ/4XFPuwHeYGadV5Vft5F
	 jlh4j7ZLAF+zN+GV6aEzJIIHnWGcGlISDMHuOKUNx+JhvDyzFr2ecIVePQLKRRjO9X8Ka1s/e0rJ
	 cM5Sk8ECOJXUn77V6iPO9JApjzoVlVQEVzVeSy9rx3Qu7NKYTjJchzx4Jxgd6CMvvqOH0mR2tmqd
	 /zsKXvyNYdjUiRMy1nbQYnVSI/Wl4ohtyeIiU/0aiLbcI1vpg/2j1XFqQjc6c0wA5U7XwUz/BBqs
	 dvoAuvgCbNdlyJa2yciD8uOvdkZeGGekHlbdq0NnSLNZhvqAfNJHHoi5t9mv2ufQMmfA4sQUAndG
	 TvEV8OwZviVDk4l6UPG8Egj+tvYnU2JlA/WZrvkoqDwDl3EzIyDTiCMGgGz69M42c24In9uW0moe
	 Fbgx8qoN6eMFtEw7E434pTkLub54i2w4DjjirATp8wgdw4bcQov6c09Pns7NZPmX4vgqgzzB33PM
	 7DxxGb70LeH3PGUj6bHsJfQUx/tp6oZdqT9wN15oLhN5B00YW27PDTX0Bynm5dAeUiVLqLsp3Zc/
	 2qDhkIcJG5RPTAbc8GU/7l1/gn+tjmx06+3nD0DrCwl/GcRFweA5K2UpCML7rxGg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 09:28:31 +0800
X-OQ-MSGID: <20240908012830.1245967-2-eadavis@qq.com>
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

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..afa02e0d7917 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1800,6 +1800,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
+	cancel_work_sync(&hcon->hdev->rx_work);
 }
 
 static void l2cap_conn_free(struct kref *ref)


