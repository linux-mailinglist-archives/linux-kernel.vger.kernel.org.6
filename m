Return-Path: <linux-kernel+bounces-342852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67198939A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8141C21A68
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E513C3CD;
	Sun, 29 Sep 2024 07:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0A139D19
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596565; cv=none; b=taAqADTM/5YuCzC6xVV1inan50NVSvGYEHiHC0beiCqpqtlnRAe1GN01D9g2hz6PDs4oR9dDxl/y+/jh1PMSjFgCT05Qy8POj50CfZ6B79vqxHEpZjciTojhg5LoX35AhEx1kyJZlAVLRTWaC3O6INXjkhjaoY14h+OtysGhCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596565; c=relaxed/simple;
	bh=ty11Sum61fZZAjO0DbGcRGKJQtdcSRbUgdO+NSSzQ6o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MCA5zxoPRou49bZmZtmuDUtVJhGm+gVTTwTmozgpAcTJv7wEHmukTTvE0QbdKmhmpVo+kqy/vTV+lQukkOr07n6A2S44vTJf2DGfiGzFJdvhf80tCGdK+hTDcFv0KZh4yjv+hhRgG7rrb8vis96KGm1mDKwemauV77VuusPybQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso43157965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727596563; x=1728201363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb0JKqGgD9r9rQYEL3wVj1eMjplqkOfPlrgKK9qB4A4=;
        b=fdiEMoDd00WHYTNr+8grMDZY3lYCbLXAHA/8IgaaqtADWEJH14lLMKOVHgsWb/yYxx
         zxQdJlUa+HMsJCWGNFtosvatBQPVEAtRiNIxIohMj3XPZS8WCnGtfZmZruNISDXvgyx7
         qDOzpMLT0NlVNYemBwFBJ93dxMTatqOA/JhTGXzOi0Gv48X8Nv1jBCj/yw5t4hwmYFif
         bPeIvkA0Z/6wYLaApmmYKZWl4cAv8Ggl6MH6uzE6V3ktE6eNUNhtCet1KDRQQY3tx1Vz
         NBc0kc1e9DECZTbu1Xfj3jTlyYaL05kMJp4bU8BLM4YhfEHVfV7cX0HJq9rPVn55u4dr
         TNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTggqNLMsQk/UBSP5g50nEh76hLASrJVjfCnlaUD8rf3AyedKyQx/4xL4NqaLrRESAObCNg6dw7Fq1CfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPpZ/9H7PHX1CLggRs0Ptgp2TFQhXlDWkD7WaB99dF8drU9pb
	/0iy71fPDaLdEo/QYgTUclM/iMQm+Q5jycu1VZ/4NOLqjnp3hkIXi50ik9b1HsvX0+K+2Xdqtil
	C//5IgPDb73DkQcIMvLhmrUGv5rAazwfYHxPCTijHA0ng6/kZ+9XTOu8=
X-Google-Smtp-Source: AGHT+IFpYbKMbWaIimcUUCh6mTXMJnK8saUavqWLDXVYvW/rO8nxtl1V40lsCBwDHa0AefvV8eRLYvsJTqe4OrFEROA28ftyZjhA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3a3:41cf:f594 with SMTP id
 e9e14a558f8ab-3a345172981mr80216355ab.12.1727596563182; Sun, 29 Sep 2024
 00:56:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:56:03 -0700
In-Reply-To: <e01d6067-7afb-4583-a65f-ae9519d303ea@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f90813.050a0220.aab67.0013.GAE@google.com>
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

commit:         d505d359 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15300127980000


