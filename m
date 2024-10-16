Return-Path: <linux-kernel+bounces-368722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5619A13F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E37B24974
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347602170B9;
	Wed, 16 Oct 2024 20:29:01 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0A216A31
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110540; cv=none; b=AWIB1k7rHyyJNPVhX0ZDi2CJuKvOmlAX84Sa8u3XpX5XY8xjVvqkKOiyjwP2EMvsRCGje4ycc3okE9wwU2YQ9U8xH0VSBbsYlvDgo+cU/RjWJTxGd3+WvfveB8DFmcTTe4AtNUBU5Ta6s8zbOJ1hAH56y2lBt3XWTlUei3qn9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110540; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JK/YhyeLl9asZASIJGdzLdQl2HRdozOHzPxpaE1Gbkazl1GrzReRWLQ3TWuMpQaED0gZymqGNGxdIMsmlCIIENYYblGs1moBXoWPZKiE7CHgLJNXwMjSY8nPLfJ1eYbEk3/OkjvmQUWEpBMW8GFBIOexs4gixfeKIZFaL5AQbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so2801955ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110538; x=1729715338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=ThCY3rQ+UCoN9YP0oPAmwU4EJEdIJsPjKZMg0uH9l8N+7RlLPDABqhmAIh9TCfKlqP
         s/x+co2K9bXIQ34DzEkQQyhY7rJ2hueEs7PiwwaHbEE9VqgN9QZwHaeG+x99/NobHfPB
         zCZHEKRIVFGWLiLRYicUMI7pmKRA+HBInjJUhJA5vmbmRYRFvK4mj4WOsiOV1mtjXQi3
         xmMMCKO1jhtP97w5It3O1VtaeMYiDXZXrfRpJV7jzmxxynMGB7HBa0kq6nUr5O9ex3fK
         D9wGWIhEKKF6M/GTr2d7gyKsNmzzAeu2Td+t/pG7zJIqFXSw5RwJDyo9sbf82A/K9Vpz
         JxRQ==
X-Gm-Message-State: AOJu0Yy5/W1/aiOfEe7ALHPlm0k40q1GwbpMCYZxAbXlClhm996ecQf8
	QnZUYWYJLgfdx2F54Me9lv5thMywQ/3J+DU2UKmpPId9HNyi8jXrc4fSnZmLrxI5GUCHndqtL5e
	V0WDU6U3jri0n2qaXY5HQ/jOm2dIFhSWgm2MsbhIiHbb3oEP4JxGUTzE=
X-Google-Smtp-Source: AGHT+IE0IrCksT1inz5LbG8nJJism+ogDQwyhMcvq8bxp0YzZ6lUm8FS38f2aeac2nxeIiv2kqT4E71SgyBWTfgNhR+B3Io4qXPf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a3dc49c448mr52727985ab.1.1729110538612; Wed, 16 Oct 2024
 13:28:58 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:28:58 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710220a.050a0220.d9b66.0172.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

