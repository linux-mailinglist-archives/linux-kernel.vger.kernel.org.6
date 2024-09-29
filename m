Return-Path: <linux-kernel+bounces-342853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE998939B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE1628658B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15213B29B;
	Sun, 29 Sep 2024 07:57:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90218641
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596624; cv=none; b=bt+OwBGzm6wFxGoJNi8OO9RLXzLL0sEyUOTDOfIeD5QMMTpbU4bK3YDP6rNqVLclgkp5SzcE0WrARF5QftOarGd1wpVlf4IYMHNx+iKIqT4IG0ZoQoeNH31xPffY+rgOZ6lzxW+SjhJpGb8n6ymTqsH06tWzkSWFKWsxFN6wE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596624; c=relaxed/simple;
	bh=TjLD1fGmRO6TDm+y0LLBayoex9fhwRyoHH58n4H0azM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obrdRrX88G/rEm5uOIczOGdfcibZpTNczEpV/x8FHF8wjmpqbI2QK7pWhhVdy3FKwRCEC6swYZzRsU6ElQzydcIBN+MoVNtRsmynscX7cfeJ0CYCETiphj0kn6QNnlJ/UZ2FYVTJt/HqJ3gpSY8D/OTgRKER/IkeWJjfS7aYahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a344da7987so30102465ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727596622; x=1728201422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJenpfBuGg+DH1MGQoWaM2GT6fCl3wvmmgcFnFj3eU0=;
        b=a13zjPJ9O5ZPVZwl63agCs7qmBdZCeJo1NHh+T1Y8uTXxbBldqhIDY1XT/dkCeroKl
         FfztxONyDqg6CyfMci88IItispuB9X1wZtqEMtcKTIdIGPBJs4z6o4h/5C/tPodK4qCO
         Y/2LDUGXZrvWz6IObo7R5jnxYKLRFtPKxKHSq4ehVng+yVN6lUixR3MoBUv8YV5i1iU3
         khjhne41FxF1MsZKoT6VkFDSGPfBQm8s4x1EJv4pTcqBhHr1OSvl7eKN+Vmaof4nq8bS
         iTbXkdvWFyXUfCJeqMq38vyTD62WnB3ylcAvudyeJa31jWTgwwE65ieDauifMmhAbZe/
         V/ug==
X-Forwarded-Encrypted: i=1; AJvYcCXzxUepHnuYWWLqrH/SsbVfa2NuVVrEV7jGU74XgTqM+xdck4ZF1CH27Qz8+gpI8zg5oUSJfWF9dfQSMg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemLBJxk0rUPmaY2LFt88137FEFbEERoiW1t/BfNJOzeO4Uqp9
	Kz0TX0XNeqNKYHKx7efhAJCtlZbeU+1JKGdIhh9ifGWHDmtbWaja10Df47qDWmauI/LVZpxggyB
	IvuvzjySaW1nBNFOy8x9y5FrtKi+bmVG1yN+9bBv0zAtcnHPk6iZB0ig=
X-Google-Smtp-Source: AGHT+IGou8bHj+Tb2WcCx0PdTkcmSpxK2Q9/7TmwjtlFydYRybATRGq4sL/cNfiLlqj1uZu9fPcdB7N1hashYGaH0WS0egpbi2Ir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152a:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a3451bc28cmr73046665ab.21.1727596622556; Sun, 29 Sep 2024
 00:57:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:57:02 -0700
In-Reply-To: <54ba4ba9-46f2-4ee9-a199-ee2661ab018f@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9084e.050a0220.aab67.0014.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/core/sock_map.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c824deb1 cxgb4: clip_tbl: Fix spelling mistake "wont" ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144ccd9f980000


