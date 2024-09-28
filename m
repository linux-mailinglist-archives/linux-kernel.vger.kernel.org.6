Return-Path: <linux-kernel+bounces-342390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70260988E66
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08701C20FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8A19DF98;
	Sat, 28 Sep 2024 08:10:40 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6012E75
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511040; cv=none; b=aM5/zxQIjWLKngAiAe5omGJWXxx0dUw5AI/PXUbwyt0yo+TPTJvbI5aKrIfTdRew4L5Uz+aNzYIuXbCjYMYLGVoNy9GdKFG/k7kJq7lolVw3S3VrqczI1QiFSs/PlM3OC6NlT1ucQXJmZ3+9GQ6U80MMxuhrVld1knCtzQE60EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511040; c=relaxed/simple;
	bh=fRfIT8CvIN9d9jK5p8f0+xU6O6H0GGw8T7y5yiFomYg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rChr53hIUZQsgzJulUgC3aUyJdUfkpFfyKpeq+s/Pg97S7cA/AH7E7HgyBl72ksNLM5Jx+mPBwSHxPfjGxKGUhuWGB+AIcDYe+vMsGFIV8h8iXjLP5YtneJD8G4sjCJ/qHhwNLbQKjvgBhTNWCVTSX/aNtZyTYM+SnqA1/L1JPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3440fc2d3so23991725ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727511038; x=1728115838;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRfIT8CvIN9d9jK5p8f0+xU6O6H0GGw8T7y5yiFomYg=;
        b=Q9Hs44CLLNC/xwA5WQ1MvVz/K4L1xma9rKdULbxlCgqQxOzTeXWRC7ho3301kZKonP
         KWtLshZAZ19Ty8NUV6iFw+7VVbm5iy+MKAlm/6X4izJ3z8Fm+4uoic5nQJUxN+vwp1IY
         pvsdk5QlsvNYTKK5JpJ9FRaFKpjNaY9+nbTBnuUOro+4/8yxHBy7FVsMhhbBrzS6Os2J
         jmTjk5BUtNxt15fXpHdkwvOpdgKq4ORpo3G33xE+eCEg9Kw3hgXQlSuIQVDW1Kf64INp
         GQxsKlv3iqRUB3KOloZ3+/KGYxRBsDvN1LY/8tqN97Xlq1tSWjPWrBeDk0Zv01t5iSxw
         wKXw==
X-Gm-Message-State: AOJu0YxpSZXl7P1cIqVfrOMxK+pTeS0iWewlh1hJ07IQoxTV8afwAs82
	0HUuRt6o3X+CvcWCxMyH7mqqHh4WwPly1LLfb2FcBKqdftGbUSZ6bj2X9CRw6UgBS+ihfi/GipB
	ugQ6SZyHKxwZFKy7yrwWO671GeglqLO0gu+vamT2aCrVeA2tz8JH3ta4=
X-Google-Smtp-Source: AGHT+IGL3SCRZBsM8U8ixOuU8bTmJej1u1bFM0jrlwqx28l2Dzv2YKh4RueC2aHcyGMTkN3814f/l1DibFHeLl6Z2qoZo6EOgsSl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a2:7651:9850 with SMTP id
 e9e14a558f8ab-3a34516eadcmr57785525ab.12.1727511037720; Sat, 28 Sep 2024
 01:10:37 -0700 (PDT)
Date: Sat, 28 Sep 2024 01:10:37 -0700
In-Reply-To: <000000000000bc46690617606123@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b9fd.050a0220.46d20.003b.GAE@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in dtReadFirst
From: syzbot <syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: array-index-out-of-bounds in dtReadFirst
Author: ghanshyam1898@gmail.com

#syz test

