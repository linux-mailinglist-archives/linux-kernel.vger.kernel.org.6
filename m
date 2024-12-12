Return-Path: <linux-kernel+bounces-442537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D259EDDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CA11887CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B985136341;
	Thu, 12 Dec 2024 03:30:47 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0D33FE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733974247; cv=none; b=aaE4NRWH++iQzJbS3xU2fcOn0aLcjlxERy3BRZqXyg99NqvnYGYEBepYU2d0ithQ9S7N8eFC9stB43o1lhqcmpdzQ5huE0R3MfGobWDotwWcYLWJDPogMW7adawVbuk3DEMU/S7ICI0idoN/fGiQOS9cCM4dHPyrVkslH8/ysXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733974247; c=relaxed/simple;
	bh=Zzn958flKdEXohrM91j9mS70QUll81AeNGk38r8xf8Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HRC/hzqbijKLi6azZncwv2qt0DpIZ/APNaBmhhJQHr3pgwAbbdLlGuK6owVdHtI6VvWoz2SQ+rlgdybyjHGgT4aHx8lV+zjF61O3veZjCw4JEG97u4GBnm68FaPQQkpCc14Rzi0mN+hIzQKvMc+XqyVxMZy6Lwng9qWl4uQPzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ab68717b73so1778295ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733974244; x=1734579044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F86Lj6nWO73YR0P1wr3jfHnyH/2zYj8pTY80Efb2ImE=;
        b=LzfMpDbUxwEBTYoIuKUr7k1T7nK4qDG1qbmTVZebu9XYHDkJ9hrrDiyJsqw2NRuE58
         Ubt3OQqbNudZCzis0u4+lnpxctoPLYKqz94vrKgzayI7YDI5Kfcu/d8RF0Kwu4HeGfrv
         07H12ggM1bWzW610bz+6MSR4EP+SYJpNMAV+8LPhLzgtLrr78j5EdCXPv90iB47DN9MY
         Lr6nhDQHjtjEv8EXjjSa1NgjLALQfeytu+uLHXDUP2pmSsKBtz76IEWtCxrIOvQ7x2C+
         xG4zV04N+/dfD59+n3yeiFRmbJaCw9R0OOybGq4lTMEvlrUEQ+vs1+mynOu4pY46wH17
         /NjQ==
X-Gm-Message-State: AOJu0Yx9LpBj8XCJsesdacsW/XNLllF/t3QOGO7djma78e2WWjUdsLod
	mhRtJwWJ6c6Lp82RR/xxE/KCSyjpvBOypi2XibWwkDA+17x/x6E18y/EbjMeILHuIBQjHyrZ6lj
	o7RGkIitmYnpoO3ODAvVa9NrR7Ig31UVaKk3Nb12/Dj9pIWmwXiMzW5Q=
X-Google-Smtp-Source: AGHT+IHoxmA0dO11bHCK4dcJt5tC+LBrWIT8ch+8zVf2S/g4U0s2DwBJBkeJ/ENHcn7Es8RZKMY1RUZjHKfEUm4rAKWoCPQHFhXs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3ac488d1ee0mr16816505ab.13.1733974244596; Wed, 11 Dec 2024
 19:30:44 -0800 (PST)
Date: Wed, 11 Dec 2024 19:30:44 -0800
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a58e4.050a0220.17f54a.004d.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
Author: lizhi.xu@windriver.com

Clean up tx buf and sendmsg race ?

#syz test

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 5a543c3f6fb0..35be886b38c4 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -545,6 +545,7 @@ static void rxrpc_cleanup_tx_buffers(struct rxrpc_call *call)
 		trace_rxrpc_tq(call, tq, 0, rxrpc_tq_cleaned);
 		kfree(tq);
 	}
+	call->tx_queue = NULL;
 }
 
 /*

