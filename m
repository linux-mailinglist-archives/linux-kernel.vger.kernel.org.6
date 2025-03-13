Return-Path: <linux-kernel+bounces-559126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB275A5EFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A271889B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB8263F4F;
	Thu, 13 Mar 2025 09:41:12 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEA14900B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858871; cv=none; b=Nv6ESyco143UUuO+pkjtJHceQJxl3bnlKMJ8nADHfJldO2Elh9NLq/sMRN5GdduC+Avbi8s0BxQPk0F1YxYKZ5b0LsCOTG9jy2aLpwlJwQej5SQ1QWlmuSfQqtN5yWWZoPu/I5HzPMDkL+yWn8cbYmW6M/pKR0Pz0hzesMKfQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858871; c=relaxed/simple;
	bh=RgXcO+sfu8RncPaaSKpT6Fm8+31lLvQmt4PsPSrtqxs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NWue3LxIplJwqxJnEX7D+HUvric88mE8vjMUtuLJM7oL+ObumHQRgBqjrNBvKhk0DNumOIK2c/aqyNgCBK0n6Q8sZBmeBiSeMnJToerohCG1AWjBnzBbvmpi4LQAFNri2wdqZD2Wo4C8HoP+Bde+BobQp64N7Er8dYNIbxUmbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so16911195ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858869; x=1742463669;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPRn0/0a+H4rngrpy+7lxl/kLQHJQsZLQyJ7BZiyons=;
        b=orOJY/0xyKBu01PBocoLvQAgV+p6EHo5T2daHdNNSM2dVrB5u9LEoR1BTX11nrd/LT
         yKe+qrCLODLwbmKpKMcF67TcfADyltPzKvnh++8g74y4JrAl7v7aUfTMGj05fy5MTsZp
         sosJCacn6LLCOhU9GIefyFi1QGkp+znbL72ZByBhjv2nKDS553MAZjyApICRBPX3UV2X
         z+DriQuYhT/3Sr/Sqloqsg0MgLlrpmUDOKhW0uznjs+Cm7o2Ka2iR6fM7MqkT4C/14Iv
         JifWUQn+u0myt6g99iRgUA4PyErMj3iU4bALQONyhYhlnsGgE0P1OO8Sf7+1tqsS6Mtj
         mJkQ==
X-Gm-Message-State: AOJu0YwwJbhYwvPxUxSKRgWJ+12xXbUS2AAUSYHrTegD9y6DXOVina6n
	l2WI2v5OMNLA9WjFO2VX5i6UzlUxBuXrw+GKhiyxhXiX9GwIv3WHH5BbNppToq2aITlJkOj0QEB
	Bn2ad5nbYAahxQih+WR2hlxMlxIk+b0boH0CGq4lJ5l4IsZKUQqtu01o=
X-Google-Smtp-Source: AGHT+IFuye1/ZqxMiz0p0PhQOEug5PatMdggjfpnBAzuVt03VHvchnHQepHnMHg9DjJAM5Va6fRch+uhTsToz2rDG8TnG2MtvUMm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d44195797bmr263998195ab.18.1741858869554; Thu, 13 Mar 2025
 02:41:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:41:09 -0700
In-Reply-To: <67d23488.050a0220.14e108.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d2a835.050a0220.14e108.0031.GAE@google.com>
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
index 94c6446604fc..21fd218796d6 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -271,13 +271,13 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_lock(&binderfs_minors_mutex);
 	--info->device_count;
 	ida_free(&binderfs_minors, device->miscdev.minor);
-	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
 		hlist_del_init(&device->hlist);
 		kfree(device->context.name);
 		kfree(device);
 	}
+	mutex_unlock(&binderfs_minors_mutex);
 }
 
 static int binderfs_fs_context_parse_param(struct fs_context *fc,

