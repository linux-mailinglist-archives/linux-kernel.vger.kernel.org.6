Return-Path: <linux-kernel+bounces-400951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8E9C1466
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CE9282210
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF86A33F;
	Fri,  8 Nov 2024 03:04:58 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980F2033A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035098; cv=none; b=V7ra3zGBa/1f+GZoeGu5tldIK4qRN608SAqh2Zzt/9sXWuA6UGlSWw3jeBd4MJP0tFdfYOtDMENr7Lft3//Ns1kpsU2KZ0cYdxZd5SlVFhkd9mwjwvQTcuGrFtPRxb9gpA4tqruZ4lXoOFBGQVFBw/fVIbWuR6/Qc2cHzTMcBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035098; c=relaxed/simple;
	bh=DMvGmfEDvtElgqHmXKOgpSbLud9yAAR8K01mbx3UyNo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ntOKIv/hA7WYrOiFaBNnuOoJLZAy3QE2whxAYRecthVYvClLS/EP9pJdv2t9v7SN0X+Otq83jtMmeiQNIFxxYNgx9k2rV9Nwz7DolNS6Nurh0IlmVCpVVJSXjxwKN/BTgZ6Rk0KRQ5Au0UlC5vFY/kSgEMCdgA+IY8NcFuwqVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83a9bd80875so185464439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 19:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035096; x=1731639896;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlFBqFKm0gW3F5gYh+mJb1nrd1ShSOYEgH021LpBOnI=;
        b=MLyy6TEja7wg1e0MYHNOp1lI+6iIrhU7pMhgho1y/WPZNtlQwKF12fUsP+EZ1aXYml
         909C3oKqJVzD4laPdzpkarkzVFkOOfnA4V9cbQqjMlfFshYVbHJoMuDZo7AgYRNKyDMj
         cos4wSq4rrCpcHoG8ya80vOCbqbilBbF7ia8bexCzyX5J5L0C+NTHBD3QKgq34/kkZDu
         aumaiQORiceQys3csRM5ajbrMFb/uQWYsBPxbtJCoz+R9fe+lWC6f3l+pNefjAnJtI3S
         ehHMWlBvL/dUggh0YUsl3XlQYxmA6ELSzvrkhErPsAxzl/0AzthDg70yqUUpbkdjcEEI
         Zodg==
X-Gm-Message-State: AOJu0YzulpHTBZVe2LMEjIlsrvDt/dQWi7pkNe7XHf5ydP2MzMhqKnOj
	cPgm/k0JRE5UQ3A1mva03f+fKxQfbKH9s5JqWoDElAjA0SkcgpX9FlcUcHJFoAbJqAAMxuebfP6
	nAfl4NiOiTY0rniG2PRz84B/Xb7W6gXpXaXRbsT4IVhyqHI3e7+T7IQQ=
X-Google-Smtp-Source: AGHT+IGHdjs//BvUCcDWRohyIUfIN+RCsbSEB5ZB6Oo7JERIfF6nF7a3hY9O/IujwE/ucFw2/Gqg8uBHjxndJl6B2R7KqBTBQC8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c8:b0:3a6:c24d:c2d4 with SMTP id
 e9e14a558f8ab-3a6f1a4c451mr16276205ab.20.1731035096377; Thu, 07 Nov 2024
 19:04:56 -0800 (PST)
Date: Thu, 07 Nov 2024 19:04:56 -0800
In-Reply-To: <66f76648.050a0220.46d20.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d7fd8.050a0220.15a23d.01aa.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+e4b5080f1e963225063e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_btree_write_buffer_flush_going_ro()

