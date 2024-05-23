Return-Path: <linux-kernel+bounces-187183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF608CCE37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF6D1F21FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF58249A;
	Thu, 23 May 2024 08:33:38 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E746AF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453218; cv=none; b=DKvbNjGFF4ajBo+MgrEFGzEd9k34ZEqJz61lX5sN/hFhrViA4B9RQyKdwC72HQNJN7m90g/hiBt1CDbYkq0UTivS1LxFDmw/sNS9j5SkfbGBUY68EBK4eyH67mkdhBiq725VynNPwTavaqncRzeH4ll1KOqrRJRczS47KpauEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453218; c=relaxed/simple;
	bh=v1Wpfd5pymv2nX9Revy1NHAYOMkvBeSoU+9s45OonyU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KZYz2cu5emaOmDEi+P+53KM/gFfsOKlRM/8cjnoeZXPaCNEVfE8FAKqTZXkFAKExul0sndtm4Pm490839QsZ0MX/8dDx3Wy2VojP47YMz1wdYfMZeghgIElQutmylwgwQkODVVMDFhvRzlF41D6UzSTnDV81K2ggbocGmkBnQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d3928fd4so132162239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716453216; x=1717058016;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySwK4GW7MrBSOkmkCOo1wVWVNGzzwCbDdwGNcEIbngc=;
        b=DRQRPdLRWfeTvKe6PczXrT+ynO7nIPbK3IV0OgzmZ68Vqiq1E9mvQcZdm9V1BP9x+k
         OznBcJFDjC9uosiTgbljXKew+CSjKK+ksiy9sXbLm0Tp4oqb3ETo5TTdCZs2CwjW7XBb
         RhouKzX75hrYcWyeHJeL6jw5w09B4f+jVibsr01GH70QHw6LzQJmtADeuSmiNaYGuAHu
         8+Labx5tC2JPzxjO2zZgMTYLFgujFixTbyqo58ccfvChmxAWfDegTDaEMyP5OzEdXOhn
         zcBOPtANMjZXOFDe49rj/Y18kJ22ZOyyFmL9L9adMd3eqK9Wp5NpBbM5pa0Kreqwqg5g
         624Q==
X-Gm-Message-State: AOJu0YxFKaPGTLcs1djwU3QxnS8uSRyM3YnE63m2mra34Le3BwS+ejX+
	ny3+PIlM+RUWEzIbQcX1ryAiiLCkGi36m3JyBmQa4xBsfdcVFqUKaAzaL1tGz2HeLOkrawSaPIu
	Ocu8V23Bt56NCxdg3A02D7k5cXia1P963EFYbU9lNzmegn8pp3dzSQK0=
X-Google-Smtp-Source: AGHT+IHbmIQFE/GYihol8gquRtVvReYzw04EJjwwXg51W7zoP8t2XOPblgAWQu76wHD46jMBGchCSNOEez1fZcncjjox/g6YOv1R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6907:b0:488:59cc:eb42 with SMTP id
 8926c6da1cb9f-4afe3c40ccbmr70028173.3.1716453216047; Thu, 23 May 2024
 01:33:36 -0700 (PDT)
Date: Thu, 23 May 2024 01:33:36 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037689606191ae804@google.com>
Subject: Re: [syzbot] [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [fs?] general protection fault in iter_file_splice_write
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..a7d59b2f1804 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,8 +751,18 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		while (ret > 0) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			printk("ret: %d, nbufs: %d,  buf len: %u, m: %u, t: %u,ring size: %u, %s\n", ret, nbufs, buf->len, mask, tail, pipe->ring_size, __func__);
+			if (pipe->ring_size <= mask) {
+				ret = -EPIPE;
+				printk("oooh, %s\n", __func__);
+				break;
+			}
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;

