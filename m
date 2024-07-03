Return-Path: <linux-kernel+bounces-239185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BC9257BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0201F221CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E890142640;
	Wed,  3 Jul 2024 10:05:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881C17741
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001104; cv=none; b=H0ppJ0wi9/oHDl7TiohiAQYHHbZXHi7q6UrAshBi1MeShs6N3NepgqlqgYaii0nZCAp5tdo9Aa/9C0ZUxq9rRG8f4z8/XCpdYpzw2c5hVCNgMw9NDuemWOriyApy+Cy5FRa/pyWXVYAZwakydRTfaZ98KqXBwNXkk7JuvNIN7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001104; c=relaxed/simple;
	bh=lY02iI+B7TXFliWps88lhx90cA3byB256b6ITnKObts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rn9XoJ6596lDoNEANmm/t0dfcpKIIkky9Dn2mRgK9I6SI56NcAiuz2qZNEF5E1BLOi0P6TyYvisabr1wJO1N1fqjBHNKgK6mImImn0Du9Kq74YJOH/exXlvuF+EQ/lsOuMhrG/P/dUOhYhLQc1jhH3ad7xk3X7PJ20hTjT5eCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so591148939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001102; x=1720605902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OjQVQEuGrs6u3VMzFp1UubJUIckBsLReRRFoFVd7NU=;
        b=uh0zimOM2kVvFGnvOHrAxRqjLYD3bHyqu43aDlYyPifQQguKF5+SXDvfTdPhsy/prc
         H9so9SwVHnk+eMAhdVtac+cYZvNPgkN/abDRFYrAVOTDJ1yS5pqE+fU5iFnFOoezRHq8
         UGFObPE6k9e8wXLFRT8Ci1AgL7AexhwbJ1mE7ByuK8FgM5iPviAKviY0mGG/F8ZrY1ZG
         I/SpeSU7op6SxTN7CMmHjRZDxlEdC9X/8Y34MymdTDEfCr2IsAQ0LaKkqq2+DED8jZGu
         lIyUZl7F1mrvdnwzW61R7UXx3UCuf7HN2AwUtmWQfYb2n8DquEAR5LHmJMV2d69q4Gb8
         V8QA==
X-Gm-Message-State: AOJu0Yw4rtRmUZonGTpTtBPlg8EptDvYbuc8+SwbNbCY5LHs/aweVhAR
	lcIgjIvavN1i5OxNa4dEigG1XpCfZvlyP+QT109Cl5n7hY6cY7J39FDuc4rSWfzpjlvfJK3bSEn
	j7IsXQmLml0XAbvmhqmNl3IChOHxqYqr/LuYhVXPcHHrrD1fXNgyiteE=
X-Google-Smtp-Source: AGHT+IE+nWoimz/rt+8CMHech/8plLH1wFoD0v09eHstCt2sAJ2E5x9mSn6BuMlizRmYyIaeC8jc9qRfjlShB6NvWOevBJqDotK5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:7f6:1f4c:96c9 with SMTP id
 ca18e2360f4ac-7f62ee8d43amr87550539f.2.1720001102480; Wed, 03 Jul 2024
 03:05:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 03:05:02 -0700
In-Reply-To: <ZoUeCoDMkRA/9DSi@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba1a80061c54f686@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/l2tp/l2tp_core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1788ff1e980000


