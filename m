Return-Path: <linux-kernel+bounces-416593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281DF9D4752
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25A5B21892
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0DC1531E1;
	Thu, 21 Nov 2024 05:47:02 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AE27447
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168022; cv=none; b=lYUrAcWTG0KlKr9AjAewsNEGfjGkbrDT/BAHT52HfIMXphP+1/9ivRVxiH8mJ6xx6oQvT6Et/0AFzdkisSy71FOkWiUilD/LXGEJhS17LiRx38D+8rQ0WksdCqPkIdXdEwD/iKng1VMrq8+Gx4TJ9LQnPdJ9RH1LtZ9Bac2wW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168022; c=relaxed/simple;
	bh=FMRMI7zjFYV296bX8HxzXoquya3ZDGU2mdluRYiyw5M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cu/u8wj1BNORJPWSxzzqkB7vgWfRxglxgoKGBmTcORJdv48GjvqBjCuJooBt2zssp5WBc+DCXs2fND4BGmywuYK7+XCvyqb8yytVdcEvoRra2QauPqtQc43nMKc/yoKjsQzgpWY36UQiyvSoybOL19Aq61tDCxuNEeZ6+POkdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so5764545ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168020; x=1732772820;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvdiQD0oJRFfhZlIEFX3WUb8SSdre8hcUH5hj5vTFQ4=;
        b=eczTLqCFLLnxqCWeuuQTiX31N17mQclQPpz39vLFylu8BlZj1MjjmTTx/Y7pvYV23h
         ZHOlX6mC8DSBYkilXKslAsknel7pf41voB6JvKESJwhs3ySIf0WD+GyGM+9AbN8d/5D2
         gn1QsiTAgUaCqONm3WzcmHvCg/QDJRV+7CdCsN0jXJ0D4wv3m3bcbMbV4Tp2Ai7Hd2cd
         cCb1TANykrJSBSjZZYyZG49ubTm1tF/+esfOStZvfqn7Ai1BFBqR/PXeEaE9S4UY184t
         iIMJGy4C1MiENxxJ6YayhgnJOpUT3QjPtz42wNYJmezLrTJML2vaWmZxWQVE4PRtbn2C
         gTFw==
X-Gm-Message-State: AOJu0YxhizBrouv0BAYxUkZGjfTWIq5KB/5aVa/6VqM3Hhw0gfuNSmwT
	gyB8NQZwAqJgUvfiazeefYMczD0B4yOgyS+pnTa9IJceETBWxq0hmHEXquDXxIU+j1kScqEZ6qy
	6jXWdpHs6AwbG3hUSZUkHXl4BNkIenoNQIYbhTnXyD8xaWsnP/WRo6a0=
X-Google-Smtp-Source: AGHT+IGRUSxjiEv0CO77xh724EFIH1i+LMQbdaLBba3Xj17Fy1/gPZtF96UbOwIbN2PSXM0VjX91sj1Tzy85PH7/L83gf21dsSOM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:3a7:7558:a6ea with SMTP id
 e9e14a558f8ab-3a786486002mr70542385ab.10.1732168020191; Wed, 20 Nov 2024
 21:47:00 -0800 (PST)
Date: Wed, 20 Nov 2024 21:47:00 -0800
In-Reply-To: <673e9f03.050a0220.363a1b.0081.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ec954.050a0220.3c9d61.0169.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: slab-out-of-bounds Read in led_tg_check()
From: syzbot <syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: slab-out-of-bounds Read in led_tg_check()
Author: dmantipov@yandex.ru

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git dd7207838d38780b51e4690ee508ab2d5057e099

diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index f7b0286d106a..8a80fd76fe45 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -96,7 +96,9 @@ static int led_tg_check(const struct xt_tgchk_param *par)
 	struct xt_led_info_internal *ledinternal;
 	int err;
 
-	if (ledinfo->id[0] == '\0')
+	/* Bail out if empty string or not a string at all. */
+	if (ledinfo->id[0] == '\0' ||
+	    !memchr(ledinfo->id, '\0', sizeof(ledinfo->id)))
 		return -EINVAL;
 
 	mutex_lock(&xt_led_mutex);

