Return-Path: <linux-kernel+bounces-379284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B89ADC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F59B1F21BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B4175562;
	Thu, 24 Oct 2024 06:45:49 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2F158D87
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752348; cv=none; b=iotDN+p19ezGIzxqrW6uqK88eEv0c2lg6X/xhyh49X0I6aFD/n1Z/EYr2ER1W3dV31aPXIy8QyW0ZdJ6zeUb+p+xGsQ2pMzrtT8wKV4l8Tu/b7I1zhHG+Daw6ZVZIZtxuBB7I16YB+MhUdRzyQBjvAupYB2Mx0PHTAcp9kvBX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752348; c=relaxed/simple;
	bh=oU/NlqJ8cbq+FQ5pMZB6All+XyjBRZm+Kidk7Z2cNmc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FBDMcNi4fzYOHLdiYYGBFeuObL7MGHwesz1mTdU+QuA6XlrRnHgldB8B4DGP53YC3gmFC6BOZQeHo9AXx8e/SydJHTr4+8x5OKESD6JM+3dpIlSTXkl+gddp+64yJHWLWQQICbWMqvpP6fbnzWQrgmlS0wFmVZpkqi8rOdCrTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa904b231so57812739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729752346; x=1730357146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXGVhOf3/QStw3Cuxprmqpc+lENqtiztn4mXURLwOUE=;
        b=qnipS13ltdby1/rfzu+EzugcUkaSwNU/CM6xecngH3hFU2gBv8iv5ITSx82vg/hdwe
         TQDMdocZ4x3mPaWLejYLQTKMvaYI5vauBzvKNafFIJkiNpSKsI3DTmBGH3Uo9n/8yn2Q
         p7jeKC+NHbaoqJpfzM5d7vp1+I6NGA2yLzKlGlGuY1E6khLA+xEtywIDSCwLak+VhhPB
         q28Z4ItXg0e0a7UOrQibpz19MU7rNv2JKDRu5QQBafojQqCWDKLE3SRSF8jjs8gNzTcv
         J/viCDhHoXh0BSyiGOLVChcbhgA16uwivg8Fy6m+SFk6GPA6oRBc6KZogw+Xd44dkA3a
         F4hw==
X-Gm-Message-State: AOJu0YxhkaJ5KILn+pPtrybAWBzYE0qm7g+4SnayZAWlvShdCXWqAYub
	lTGn2kzPCTvzFMwqbipYCSUrordk3SH/2kFP0vtTaXDBkwP6L7nycAga5VIFd3mIs9gfvgNVqo9
	0fhrrsfrey3RhLLjHEDyN+M0hfPYHbjjBoBRlfxLMnr3qUJMcyjbtuxA=
X-Google-Smtp-Source: AGHT+IFthRRTAN8FX00hh6CGt2huGxEvJpt/GHsCdtXUjRtoeZNK4+z9VHHSBsExHsc8zAY4JVeZ9apL7VFpyjluBbQG/daRc15T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a4d5945f81mr53387035ab.7.1729752346358; Wed, 23 Oct 2024
 23:45:46 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:45:46 -0700
In-Reply-To: <671907d4.050a0220.1e4b4d.008f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719ed1a.050a0220.10f4f4.01e3.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read
 in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
Author: lizhi.xu@windriver.com

sb is changed?

#syz test: upstream master

diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 55e1504a8130..b9a3a8e6acd9 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -95,6 +95,7 @@ static void bch2_reconstruct_alloc(struct bch_fs *c)
 	c->sb.compat &= ~(1ULL << BCH_COMPAT_alloc_info);
 
 	bch2_write_super(c);
+	ext = bch2_sb_field_get(c->disk_sb.sb, ext);
 	mutex_unlock(&c->sb_lock);
 
 	c->opts.recovery_passes |= bch2_recovery_passes_from_stable(le64_to_cpu(ext->recovery_passes_required[0]));

