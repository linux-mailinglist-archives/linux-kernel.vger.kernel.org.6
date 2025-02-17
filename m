Return-Path: <linux-kernel+bounces-518186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FAA38B28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D611893B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8373226870;
	Mon, 17 Feb 2025 18:16:46 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124C38FB0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816206; cv=none; b=kqyS4fmS36iINnV61urfXKmNrsXH7kR5TFWrJjQUOU/LcDH3T7Wz8Vu0AZKKganbr9+DPNGSHzZcGtSpBh3lM/PSOIhaT+TLl2jozenW3Ds/O3W4ihG206r+uVsgoOL00FwRcETRaIq564cvxOVqeGwuezQoPV4KT2N/VRhq0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816206; c=relaxed/simple;
	bh=M3aNmsZjJZLYUGS3ElWTUS/mfTa/4pNcn72ELrVEzHo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TZr1w3lhZVpxXv4BwcUNTlDcOdtJtPm+8OX7hAXYvh0slvBS2eqbUnO2SGG3gnkQppEQAxtbIcikd4AxJVhTNcg9RVPxzMmukb1mEymfNh2GwjZS2PMDKpAJTI62yrXi4+sSgbVxzI6HJgpXgzxVgWN/u6cc/qjw2GZgC1L6vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso5419175ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816204; x=1740421004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfUM4i3woVf0UXugrGrKwiS5qCUgW9J4SSBSO0ly1Js=;
        b=Ag1IAXfEdJAuVoRQ5U2JxWz+wgQOa81sHjsGJnt5hM7mfAMHr6/afQwRaiZNE9YdmN
         qTy1Ly8VEF/rrDnNWdivSON8Z/8EVqjajiAnHrg4JNpZhn2qzfS7nAOkEwffE5euUtlb
         ozrsVSaIUcFZcYZkBavJ9/5I0P+sZXKgzcufsFSji6dSfqGgvIoh1SRx59eJEy14Mph/
         1uRwnzQSYGhTRg619qYrG7lOWQhWqeIO7mD3UEfzUCU7PEwS4iqcmr5feZY/jHCcW317
         lQsR1AJ0oqIfBr5jC8ZoWCVqVUMJGtQxHKCkCpJX0Sgnf1RGAg/lv2a1gLOP2xsSVpQn
         5oBw==
X-Gm-Message-State: AOJu0YygPPx8LdpXUkpzo7bgPbzKNHJb3XVxh6jukbkzW+fW0Zj7Yg8P
	KW99JSNQPqwOJPIPiT2JdEeoqSchIWIxjGqEpa++l7kvvN5Zx8qSfPsF1COtnZ/F6WndqoWQFT4
	tU57k6ujq+xjQo9H2KtUBba/cqvMpiwpRvWFzT+ikHmjgQtJuombDXzA=
X-Google-Smtp-Source: AGHT+IFOkXEYq/drTj63U7Tzdfzj0HJgcb8Kmb6pZ9Jfbh5QgBn1dZ9wzEuuF9irlON4YpQVJ4TEn9YQB762hSZUgrc4O31VPT0B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d281fe0962mr59564755ab.8.1739816203976; Mon, 17 Feb 2025
 10:16:43 -0800 (PST)
Date: Mon, 17 Feb 2025 10:16:43 -0800
In-Reply-To: <67b323a4.050a0220.173698.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b37d0b.050a0220.173698.003a.GAE@google.com>
Subject: Re: [syzbot] [PATCH] can: ucan: Correct the size parameter
From: syzbot <syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] can: ucan: Correct the size parameter
Author: zoo868e@gmail.com

According to the comment, the size parameter is only required when
@dst is not an array, or when the copy needs to be smaller than
sizeof(@dst). Since the source is a `union ucan_ctl_payload`, the
correct size should be sizeof(union ucan_ctl_payload).

#syz test

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..1ccef00388ae 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1533,7 +1533,7 @@ static int ucan_probe(struct usb_interface *intf,
 	if (ret > 0) {
 		/* copy string while ensuring zero termination */
 		strscpy(firmware_str, up->ctl_msg_buffer->raw,
-			sizeof(union ucan_ctl_payload) + 1);
+			sizeof(union ucan_ctl_payload));
 	} else {
 		strcpy(firmware_str, "unknown");
 	}
-- 
2.25.1


