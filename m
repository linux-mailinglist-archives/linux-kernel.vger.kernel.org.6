Return-Path: <linux-kernel+bounces-255123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB76933C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26DA282814
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C517F4F4;
	Wed, 17 Jul 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QDon7sMq"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021717F393
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216361; cv=none; b=mh2q7NChCjRhhN+OuWrLMxB+IL/vR0WqZPOKQtyI7lqS1+hPZwVN1DUgNezhHIGtiHq+0oIlHRwCrhY1pP6wJu+jf+Vh2d5MktiiE6TCDylAPdZZXlOgxgadkWaLRiCMGtHvlvMal5u7wQ2ZX6OthNrbjjveSJp8GWgmbEHZ0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216361; c=relaxed/simple;
	bh=o5xv/Quic8OyS6G/CZeZwnHIw4qoO5HkwGP2KsFr9lM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LSfEKEjVBqkSmhYJcp9OIHJfXttNaw9oQ0GU7HePfrPLM6hSIVhqJxt6qoD9VXLPUx+qbjzq6U8jFX7+L6UCrt9qXyPLOQCjNRlJJg42PCVRTZTmut4/dRkEIjAHOwkVQCVvNX7YJp1GHRIsqUZPsfAOiF6hVbuKif3xHaWiUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QDon7sMq; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721216355; bh=bWeafcqr85+3H/82ChXQMzxaY0GsN5RvhlbByzl/2rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDon7sMqUDy7M7J8AgyVGv/N4FRny+2NboCjJnVAsVFjYl5Ia+esz5OjaMjq0x5uo
	 IbbyeO3ixn0kuOm9Q9hqa7zE8IILkSC51n7CrbDf7zJSz6fkSQvLoRsfY3H64fDyZh
	 LagdAEgF+yAUwPBEsIvDS+tmbWQbqGlF0XNzQ3LA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9CD32A80; Wed, 17 Jul 2024 19:39:13 +0800
X-QQ-mid: xmsmtpt1721216353t2qaqfuel
Message-ID: <tencent_84396D049598E9E2ED52CCE479426DD02E0A@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJpCJehk2uHUnY6GE9zgBgCeqhh2dj1YnAYBmFAd6Rp37a2eoqyA
	 WDTD7dEiuSu6TbGv7JC51n9UzwfvYU4214x7ERb1ue+0CXyBgM1kGLrSCj80ZpxkqoCLSrjTjMa9
	 t60IZAyIF6MSTgn6UU4dBfbxtyubBdW807F+Y+0UQeYS22p5qD0KCVg2XT/lfRQaCFlsmNZZV39p
	 jLS1Ou/bPR15tbswaPoIPr4+YseY8N6xxpKAdXgklaZhzRMvdlXH8Av0rVOWMemQ8cu0sOWB98N1
	 ebTvubdRDuZrGiCAeRCsAPoaKtEgIBjNlojs/9ly3FSByOFyjFFOANPGFzYLRTITDYBPR/EnNzqi
	 F1J2l2v/bIYwcX9MAV43oB7iIhyfdKzbMNvlTtIgot6mz3fdbUew9fhyPu8t6Y4wZkKGg5Lbfi00
	 nkpUk1Fgv625UYz6hRjsMNW1C5BFRwfMv4xEZAY82fgiBuVzqD39EDkLjlY6LFn5I4caVSWTpbd2
	 TOtuehmV1QIPdhztY0hjNvzKq5cW2foJgTrSDlRuRhjE1P44hEZuPMcGGXu8CDQsAktyDSq2mnKX
	 Y44v/QiGdigDgQ4TXAyRJEa8OdBGSwbCznrKZZCDNSgU/1CEeBJN/DpJpb5K5jLTpNsgA/DsC83r
	 L+PkKAVTglz0DHBfN6B+nIHo0xhP+Vu9iu4Rki9AsOy/f8hIMV/m19SHUlEEh7E/lUaUt59usjM2
	 tzwacRMfxJrrzLPnoS+SpEK3SOS//5dbuEP1RdwJnln3hx/X+dzET1JO6Vyt83mJw4GseyUZrRMv
	 vnAOJd4UA7R9x/5Z5OhYsxAJuy4hYZC98m5460dWlL2Bwt9AYzs7VEaQnF1AZ9zubO/ExVQM7TJu
	 KF5J5gmbR0SLDhspj1qyjE6jfr/Kn0ubbWfMgTUTTPWaPkr/2QOyOP/qYIPL5ykQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Wed, 17 Jul 2024 19:39:13 +0800
X-OQ-MSGID: <20240717113913.616996-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
References: <0000000000005c6453061d53bc0f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

before remove debugfs_dir set reference pointer to NULL

#syz test: linux-next 58f9416d413a

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..fe29ba561599 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -113,11 +113,10 @@ void drv_remove_interface(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
-
 	/* Remove driver debugfs entries */
 	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
 
+	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
 	trace_drv_return_void(local);


