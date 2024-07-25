Return-Path: <linux-kernel+bounces-261637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9439B93BA32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60FE1C229C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A81CA92;
	Thu, 25 Jul 2024 01:32:52 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77518028
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871172; cv=none; b=NnGw7zpvIlWlQrJ5axYVVzZKYR5ytDFBC5MEMZanc3BtkQMVuqg00pBgl38hZhULcPbxnYYUaNNuUqhG2xMgfYxFeLMUn1mFHsogfou6xWNJouRyXRIixuE+rPvHuKXfiBx1+Cl+daWHBAv0GI1WpPQSAE1QP/e+IONYj/94wpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871172; c=relaxed/simple;
	bh=neiu7sYemI09fFJwdej5J4RO7WSD0AZ1pu3AhEuRVzg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r6uAuumwX+/4BGryaGkHI8xM4kNMaPy9Rh2yDIPJesyuJ7WDsE5NF6w4JpAD93Bkjgy8VEo+lDIv8AkZZX85YPpH/k7/Mpr6p/07A962jJC+Cxu/50zMdi+9CYZT4IprNI9p47OiRP7YTxa4LlUoB+RX3fW2KeOVnsSjyuT5kAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8148c1e1b93so51602839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871169; x=1722475969;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyr3j7eq92dQz+wRiiszROZan96pBaGI1ij5LzJPn4Q=;
        b=xOMHn54b7cdVVtFs8J/sFwtqCwwe4TOj1nHaDrqHHhN3Sqoweh3KTWqZ+zApTngGWp
         u5vyihBQB2BM4YyuMkz5j1cdPCFNR6+RhpScVafFxbHzfB+dCqtVyPyPVnVInV4tF7B+
         jERMcng54A84L+IjmPADNV2MgOVjPgQvaSa3XpciP3wrmiQt6th9DdCTHM/dRGZ6i4uB
         9CoVrUYxvD9Ldi0FHVEVq2NlX1tIRiekkcfeucY5yi93PpvvSXKyOcSHzNJcfFSqGjMD
         Vll9shSsvbqtBpkAE7aamGjY85zWxnh+1Nlhc7NOHxAwuGxO6P7ZWST/SfcptSx6bizA
         RLtg==
X-Gm-Message-State: AOJu0YzBzll5ZcUk3DxqUgtubyerukcJ6nfKL7twgZVp5luDTiJW0ZCI
	qIb2uWtH3mlXvLy+mk5tRJ9mnDmknOln3AAzhOavkKZOz0bGF16e0lPsX0kMhbJr3kJr3dnPGQv
	97LK04JBTuJ20zv61YZt8GzTSUz2bJm58aNQwkTg2z/MF9zbPPFUw3mM=
X-Google-Smtp-Source: AGHT+IFiFIlftsvZhrLhiBwvpxZy6bz2nApFyFjxnjHtJL0MufUgMJUeYFxOqrq1zfne2oFR7PVjO2jDPJ4dfmn7uMAYlxEN3wtV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8727:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4c29c35ebc6mr52790173.6.1721871169602; Wed, 24 Jul 2024
 18:32:49 -0700 (PDT)
Date: Wed, 24 Jul 2024 18:32:49 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069d6d4061e085f82@google.com>
Subject: Re: [syzbot] Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Author: lizhi.xu@windriver.com

shutting down f2fs set ro, and check bdev_thaw return value

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c1ad9b278c47..0e607cb3bc9a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2244,7 +2244,9 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		if (ret)
 			goto out;
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
-		bdev_thaw(sb->s_bdev);
+		ret = bdev_thaw(sb->s_bdev);
+		if (ret == -EINVAL)
+			goto out;
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df4cf31f93df..e507379762ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4177,7 +4177,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	 * RO by shutdown, since RO bypasses thaw_super which can hang the
 	 * system.
 	 */
-	if (continue_fs || f2fs_readonly(sb) || shutdown) {
+	if (continue_fs || f2fs_readonly(sb)) {
 		f2fs_warn(sbi, "Stopped filesystem due to reason: %d", reason);
 		return;
 	}

