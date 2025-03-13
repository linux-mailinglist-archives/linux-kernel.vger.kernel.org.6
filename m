Return-Path: <linux-kernel+bounces-558789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A01A5EB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE90189BA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D731F941B;
	Thu, 13 Mar 2025 05:30:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218342E3366
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843828; cv=none; b=o545zZ9KxnDb4Pomx7QTD9dzWiJReAjw4salZ1dvy0gTB3vsie8pt3Mqe6x4SVVIR1TSeymeUqcqNff6rnOsPW0rsufd9iEFvwfxdr9rLFDJ0sCez73d8xyIzx68J/tf1WTSarOB+58BNzarERka3MnObyS2s8xC8SPH7okOuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843828; c=relaxed/simple;
	bh=30aCBK5Y3EwLeaCCt56U8SucBAP1ju+LCZ+XImsFJiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ea5PuNeIzyaMX58xsm3I5UhhgrKFv8x2IIYNngqG21DQOV2/2zuONEU1E7v117sfeiH8hvCIVKu+riAhcS5GZAtio7fZYnh3JhqIjPD/0FppPCxBWI2LjD7SlaGn/RtyVc/j2KiaBEEeqTGVYT3dqvTvYu9VDIptHfk+Dv9w/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d44b221f0dso11127995ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741843826; x=1742448626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFUpoOcIfBI9edJIfGqZKhyhYtjI3+X8qsOtABZbc3g=;
        b=k9TTp7m3G93FnspbWWuYa2HF9hHh8mksXVsVzgMEQ2ryJjezn0cPVUA+BWm/M8yWvI
         8l83QF+qJJ8bgihsHAZPw7dAd4adjNJ0TIIFUZB9AYLDXyqmKz+eaynj+JlTpe9mKjOv
         dkRG5rvUv6kqQib0CZzl1X8U9aaPs6qkvQ00REmATB9EXmISq8LQ1fya+FvI9TDlA0U/
         Z738m9dhYLoNU9I7jPvHtQDf8GoLUNxkRxHxmY63UhNeRsrf5kkfI5QIUybTyv5CVoxu
         SDJSECFrmvve6R18a4QbFotKUj4viKbxSo0Ry/Pzwa/b3QBt3bViAYRTUOCo7kfaTsj+
         L2KA==
X-Gm-Message-State: AOJu0YzZqlJcM3WlnNtn7r6qB6r9mPI94r0uB0wFPGrnRzNIo5rNPu4T
	pYOo9uNB1LlmXVWscFlHBq0urmbUtKMLHA5p0wuSFajry4M7at+EpS7c9PtB0sCEvFlQq8aBhkX
	Ftur3DcFJxJrfECb9pS53llSoILyVBrHZfOwrj0I+COHq7joCtXJBXJk=
X-Google-Smtp-Source: AGHT+IE6nJUWk2ozNZfxoSYrs2eEH3eA6D4oMWrclK9f+tTO2Mcq0DUgaEcvvEo6X7WJ1/H/CAvMVltyP1nBvTzLajPO47P6gSNv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3d3:dfc6:bc26 with SMTP id
 e9e14a558f8ab-3d441963325mr293435595ab.22.1741843826358; Wed, 12 Mar 2025
 22:30:26 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:30:26 -0700
In-Reply-To: <67d23488.050a0220.14e108.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d26d72.050a0220.1939a6.0045.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kernel?] upstream test error: KASAN:
 slab-use-after-free Write in binderfs_evict_inode
From: syzbot <syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [kernel?] upstream test error: KASAN: slab-use-after-free Write in binderfs_evict_inode
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index bc6bae76ccaf..9ac152548030 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -271,12 +271,12 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_lock(&binderfs_minors_mutex);
 	--info->device_count;
 	ida_free(&binderfs_minors, device->miscdev.minor);
-	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
 		kfree(device->context.name);
 		kfree(device);
 	}
+	mutex_unlock(&binderfs_minors_mutex);
 }
 
 static int binderfs_fs_context_parse_param(struct fs_context *fc,

