Return-Path: <linux-kernel+bounces-363105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B999BDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE21282098
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC713CF73;
	Mon, 14 Oct 2024 02:53:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BD211C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728874402; cv=none; b=mOggpZOK1jcX8YoHUQfEQHMIZ4kNMVq1uGdrpydMF5ABHuRtHM8JHnEsgE8ZKXftBnOfDcD+NeKrtPW9u6YMMpkqL7tdHFQd5pRUJiOuNkEm2pRpX7NtNwrcTQe6D4QLwE50PP8VAx2m6RiKeBlsPRRpssVkVdgfx5Gd9QczqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728874402; c=relaxed/simple;
	bh=R6hGzBCoQHqgx5D5HroXMi6KO5JhsAbpCPcLdtXxLbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P1rhHn/0NqPtce4bzssjoWUYJ1C9kMCrCwDrLN/Drs0ovLRvlxI2KPe/oZpRWJBHhv/r5gvp5JcG4YrqT/fNbWO3B9tSAblfTh2ubopfTDaDr6xXFoUm8Xtwp1Gf7mlERtgOmXxLMmxmo9pUP0epePHlMKhh0i5AWlkR4tq6muQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so11736665ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728874400; x=1729479200;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8d8+1RuqEFjVBY5OpWhdPI6dJSauJdky1BQHlh+LK9g=;
        b=Mxj8B2Ze+IHzmq5S2mXkDSRdrrq/ndp10MTD07GAqyabJkQvCN9exAoi2i5gE0S4Yd
         5rtq7AyRp6FysPXA353Vlca+6sZhZS/W1f9jafMVlni9rWidWFALeY+T472eimj8GnAr
         kejo98XAafY26dfjriIyyb9eQr78uCdUq2ZPDh461DfozudgxvEEG4EFO17VOS41emGA
         Pq3BA00r5EWse6rUixDnOQI+nMFe0jJL0cpAPNd0EeGM4BgvxFtp3R+JJSfxAHLMQ8uN
         BvJ3l1ifI1EjZMlTkzecc3KA7n0EV6ahu8ouTPvCu6zl8OcM97U/4n0r3dzH2gz6/qCx
         nPjA==
X-Gm-Message-State: AOJu0YzZn+KECrqb68xA0PN7WO3Q2Gzq7zpCOZF8uKHRn5YeNgGune9M
	ANeepBGBdkYgb8Pv33lqbCt7yUdg3Lbu+TsDq6b1QYg3lN1PcRddPUwAhkqq4OxT+Z7ELzMV6ja
	tb/a16iRiBq9cscgFHr6g7+Rp9m9Xx25nY4TPbg2+3g9wROf+6Qn2ydk=
X-Google-Smtp-Source: AGHT+IFmSF7420bqwvvVqUzSpFCXAr3XjvpPkiF/PALBE++ndIEhlkpdbruhxvMRbqzLxgLsBTiVDQZlqdq6o57Bf0vYuBgs5BB5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a0:4df2:52e2 with SMTP id
 e9e14a558f8ab-3a3b5f1b47dmr70424195ab.4.1728874400215; Sun, 13 Oct 2024
 19:53:20 -0700 (PDT)
Date: Sun, 13 Oct 2024 19:53:20 -0700
In-Reply-To: <6707f07f.050a0220.64b99.001b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c87a0.050a0220.3e960.0050.GAE@google.com>
Subject: Re: [syzbot] Re: [wireless?] INFO: task hung in cfg80211_event_work (4)
From: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [wireless?] INFO: task hung in cfg80211_event_work (4)
Author: lizhi.xu@windriver.com

When hwsim and regulatory are used simultaneously, a race occurs for the
lock "wiphy.mtx", it cause hung in cfg80211_event_work.
The hwsim is a developer testing tool, so maybe using mutex_trylock
insead of mutex_lock is more reasonable.

#syz test

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 661adfc77644..4e8a6c76b12d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -331,7 +331,8 @@ static void cfg80211_event_work(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    event_work);
 
-	wiphy_lock(&rdev->wiphy);
+	if (!mutex_trylock(&rdev->wiphy.mtx))
+		return;
 	cfg80211_process_rdev_events(rdev);
 	wiphy_unlock(&rdev->wiphy);
 }

