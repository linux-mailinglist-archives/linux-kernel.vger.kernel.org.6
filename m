Return-Path: <linux-kernel+bounces-213828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F83907B51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E82857B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EC14B949;
	Thu, 13 Jun 2024 18:30:14 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092314B061
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303414; cv=none; b=RdH9CHF/JdTqWcjBZgPHKyKde+fh9/7yccvHfldjXAU1rL3J20qo9PWLZZVHuDSAC1iGJdQk2vyePG1eRKsJOwmYPTCa+TTOPqUjai6mrZ/bF2LTD0gM3O0HRtTtyuCFN/JCRK18Lgt8by10QlMoZHJHHzOLYJ72uisfRCSDhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303414; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lYZsyJTjPoHlQM8Tm0UMJ5eNOwNiyYMRoGzUbEthSjY1Gq07kA6vIWgEc1RYaNhRMb8ybHEN9xqV9vgXNo5SAn+sBIGeKZPEGPI/0P2SnwSQVpulH3J5PB89DHTvCvuptOrjNEPRLHnzgmXh6fbXo8/QATYWxgYnGP6JtbOeGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3759d2440c4so11287515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303412; x=1718908212;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=n0+wHLkk0iJcLfST3xMahkd3Brnoq3+RXC7Ekf+cyjy6JSZGvaQfvTjl+sTuy8OLjv
         LWQqz32dIvlQcE8WoCrelthKJVU345Dk4eQqUQzbVio88GE5C0ORIYAliZEAmlMiwMWA
         ci4FUx4tYQ7PyjQVlMgfCoOW2JO5LjFXlkxBF7tfxt0KKs42drmsQucEP5btvmdPY6W1
         ysgrvvygh7f+/mFSV549IL1oQyb5QocAbGMqZHIU7aMr8gi3RU9V0SC4Ry6Fh8GWxhZd
         CNWfi/9SBuVpw9BXwExjxd+ll81laFy8r4x0KtPdkFkXD66gqW6+qS1sX/pgJqzonsyf
         9BjA==
X-Forwarded-Encrypted: i=1; AJvYcCXIle9UsgkkOeAJoJ5uwjcFEnT0xRXu+w019V6EfB7oPN2BIBWzTT0DkwdMR3KiA1zT4rZDWRWjEta8YiWgZnUsBb/MPFbjG+270I0j
X-Gm-Message-State: AOJu0YzCiE2XUjUbpbUz3lVkHRFBdJ43832MHKdb4BB+RDG+VARMwNgQ
	m6QV01tmjy4tVJy7yfAiXpsWIh+84tsDobGATrWUwtl5OQpx9bp0l+BReqNHsX9uabiJKFlcYf+
	uH7rVhWS7pwI1TlEoiFSKG6vw/xAd9RU7QGxPnHbhxNFaWttA0TumFO8=
X-Google-Smtp-Source: AGHT+IEJlGFfCPmrxyaBrcHzU59nuv55jCruy9LEhW2H2ynnEHqyLgyvFo36S7EeYSuZK+jHM/JkDgVy1sD23M7tBuFlGOD/yqoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:9f67:6e7d with SMTP id
 e9e14a558f8ab-375e1021197mr238355ab.4.1718303411783; Thu, 13 Jun 2024
 11:30:11 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:30:11 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079de2a061ac9b02c@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

