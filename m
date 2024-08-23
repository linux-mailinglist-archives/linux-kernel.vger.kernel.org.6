Return-Path: <linux-kernel+bounces-299258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125995D214
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5F28355F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6991885BE;
	Fri, 23 Aug 2024 15:53:44 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD401586D3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428423; cv=none; b=k1Kd9KLZVs+5x3Hka9ZvHcJOX52md2Nxiho3bWDVEvsh7sHegoysbcVm83qTkVPQf61pl2JkJe6e/x+mL+upBXbcXs2bBUJBrgz5lmDNHem3ix/w22eQlM7Dfd/KRT/bRLGIOXiIN8FiCebBEvG4n6aVwoGpffDYulUz7e51IAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428423; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BNl7zZHQ7k7RGmIQz6c//0se6ZkjM5N5frQWon2NXW8r956GvPna4e7DGF7tm7rrBZRtC+LvAnq/TkhKWjLOOM2wmwMQ/6SYFJKpZGOoZM5Ia0qIwbzijop9zFtGzVFhSPxa+99F1yHiwpPjxHlbttY+JfdoWGysfl8CIjJBG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c656946so23489555ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428420; x=1725033220;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=GiDjTG3n2HkHEBLo0uXEkYs12/080/3aIwSwAv0G9D/sU0crowDaOQaXiLmcTzIaxa
         0xpVKsrKONSI1emvQvQMI/bio/R6dJBI7gVTCauLIcYWvdcwz+xq8suqAkyWW3v5iSXX
         4qbLRdVDdZ1WPY5suPbQa1Sw7X+3mNn5qTIyJPP2tCfEhJUmg4hfWa5wplY8YVf0IbD6
         Vg9Yz47eee6lLlUOXaK+TrK7BORUJ0vX7PNqVpYkRKwzvvs5L+MxqUMdA404byl0Zn8p
         oIADVibkxNnDR7r+1Bp+AuIm7lpL/OB+vypYsQpqwdFOj7GXxAECmXWBzxssz/kYcenN
         hGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMnXTvODTWvry6POal+yBJDHltwXk5Tz1ecpM4tYdl4z9+2407ClKdkQePjAH6RCa7fa5HBBy2rQt1nBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YXGYtWIQQA5aF+FyegycGEPAlmimk4kliL9h1h+jmBhRkxi+
	nA79RudS1uPX67VWWSBiqAzNyCiIJ2jCo1UUz0xuu7imSom10itlrYvmdxgjlHk6M3tXQ0dLSD+
	gBlSySQ4dKy4WiM9amEa+Yf6Avq9C/jv4JjFMtKveSr51z5B2OpoP4SQ=
X-Google-Smtp-Source: AGHT+IFUNCAglEsiUPV2yQaA1koccQdeKu3i0k0ZWH21zwGXJcr2rcuAGnz9gfIWA60l0ygedc/tN+wNhawTube1zkhS5ZmGBh0g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39e3ca01fc6mr1445915ab.5.1724428420656; Fri, 23 Aug 2024
 08:53:40 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:53:40 -0700
In-Reply-To: <c17970ff8aaf469db685f7e0cec7c914@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007442af06205bc7f5@google.com>
Subject: Re: KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

