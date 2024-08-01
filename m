Return-Path: <linux-kernel+bounces-271435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F87944E35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044351F26F25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365731A57C7;
	Thu,  1 Aug 2024 14:39:52 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A851A4F38
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523191; cv=none; b=Nr9gOIGecm0jhtZrEId58CrWB9OB+0gECVuE2MCy34wv6+hKKzCXEMEQelev15EO/YrxyZsCAVt/J1bc7mXUpPKOn7M8sZ4g/J84FoAFMG6FIx1+xe2A951DY7HtNN8TlikSMnXvjpRsgjXsc0LA/K4252NhazYfALDp9//IXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523191; c=relaxed/simple;
	bh=3yi1Lhs4nG2UwrvlA4B+tV591LMpUQXa2zkYbgKQ4Uc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uF1/ce59ZzVG6tTeqix+aZrdONbyAizM5LWhLN0KgbuMFKUP1vn7X7ehuuXnzNeX6sW9Yle2m2j3QkuomMHloFLvwl1K2CYfVN5KluQHNbxUrWm1FCtIxtd5gVAXjg3TWNN3zyPSQSpbOGWmvuDH3sVBBqNASdFL1+IWlZv9U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3971269bf67so104483655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523189; x=1723127989;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGnfHLgS6zEexKjr13IGzCFLUlnirn+nRnBK9/AtDbk=;
        b=QuywR0DX2KzojNqaK9edDW8d1b0YNXUQHuquhVgbNxsAPxAABxZPCBwUklt8K5qOiz
         enV1yQu4yl1m9FkfudW0PoVyYoPBCuaMwYPYJEWUTRc9DrzrNE3gpyFO/uCvFjSSQFHg
         OhcWEcCkmEbMRDe4+JiXR0RAdhP2lBJbHPD+Vnl/LHQ5vK5do1yyUeEFWNI06a2OkkOy
         HJhHVjTf1k2SoEJxqsmBWTO2cjb8Y2hQs3ycRaoozBsOiWuAdNy1/f+SYdpVx3pOhnSS
         n/5agR5XathwEfaCoj4SoYVQ/3GbZJlV63GeZxQi0Vxw6V4EBqV/8/nbwa+h9fGimYYX
         J0Gw==
X-Gm-Message-State: AOJu0YyviWXwBhmUWrH5gwkbSwNngFzpFvfC7CEKkJKEm0jNoKDkE4rL
	xdUIxw3Og8vqTkLrk93XyKW/LlRQarwwqEB3KwvwRvQLXlzI2Yw5yl/YVm/r1djELvyztvSHCKa
	eArGN1xrewCQY1wzaxstVXASG2+42B/anLcK9s0i99J0FIJpLOFJymFc=
X-Google-Smtp-Source: AGHT+IGULwNDT/Zhaqz5zqpxWpz0BM91hfIb9brto++XCG9ibxYTw6qHwS30dyccJMm15PSqyizLtp4he2WEzp0H1FbS0uQrUUO0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39b1fc4cdf8mr277475ab.4.1722523189622; Thu, 01 Aug 2024
 07:39:49 -0700 (PDT)
Date: Thu, 01 Aug 2024 07:39:49 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5cc9b061ea02e62@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

why folio not inited?

#syz test: upstream 2f8c4f506285

diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 6ef735bd841a..7cffc1059c42 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -49,6 +49,11 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 	/*
 	 * Skip index bytes into symlink metadata.
 	 */
+	if (length < 0) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (index) {
 		bytes = squashfs_read_metadata(sb, NULL, &block, &offset,
 								index);
}

