Return-Path: <linux-kernel+bounces-234764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B672191CABB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24AB1C21ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59181CD2A;
	Sat, 29 Jun 2024 02:54:57 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E41C680
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719629697; cv=none; b=HcX9bt+Sb+pxyZIXoU7sbOA130OgX0EkF7zrToHVgRqujY2eXkM+vMVG1Y/AQda38mL3eNsnwEo7w4zQXDxtvdkm123OaxpTiasC8BfqG24tj6qgtdE7euT4AXyTr1cANH4Y2noT7eX3QTe5HovaEkliABESaIdmsuGidRV22Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719629697; c=relaxed/simple;
	bh=8aWGxhnyJPy6rtnyZTYuz/wRoZygSzi/ERqVcq6SiDk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lZntjE54iO7sMNpwrUgVgjI+nXBfYpkG5QWceKHk8PKeknTfS6fgvKPg23T4JYD7rQCXEqnGUmhnoHaKAzp8V7qeqJYiGs86WjaCFVoVSahoPFmezYE7JFozpKx5NpYRV9e4uT87gEdZ1w+fTY5vZbqLq+G8o0ambsXRh55bbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3d2d068abso135610239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719629695; x=1720234495;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aWGxhnyJPy6rtnyZTYuz/wRoZygSzi/ERqVcq6SiDk=;
        b=OrOdbr3H06E3sbHBFlKuYIKJWXpJN0WR/jFQiK/PQHEZRlfXSvY/WjUn3pcKJRGoIh
         Ru81RZG631xTsjpEkGg4CMsB79vnfoqcqeOyD5/vrKABlqqwqRmG7BXwYUSOaS7AVett
         ChlzjSXyQNGXsULpRe9i80FvMISIdCcNhhPQQ6NZjCNA3a+rzRpKJHTG2zQgkH53jJ9w
         vwpXUUTjuIJPZKDPnwej45yOJe8tHNMD1YZ3t62xBSKQv7z4oWSMduU9dvEzizfUTfz/
         8EQz3k7BSxaAyMG2RSIGHaGc2O+nbtj3uUdiBwKFea4O38LSFJhEERjxmBV4eMgm3GDV
         NX5Q==
X-Gm-Message-State: AOJu0Ywo9qX0ChtTvlb3fYU6nUb4Vsq/wRa6X47U/fEO7aScXTCHbk7G
	jzrtNsrqX0lC+qlCuMdK3YIW6EHflmZIwlHLPZF/yplPzLc1dmRIjGWAj6s+N2qhcx0sXmPMGDO
	sfNHjziGX4Mk+dhY4eVBdjInFFJrmz2f3LLaOXheESIvAC/ppuFrwGck=
X-Google-Smtp-Source: AGHT+IEPvfpg7enwfIMJGcgadRWnSS2CpZr8ukjhFOZn0Jv/to5NHiX/YMdGSO45sLv4B/ExlHG8DMQhlUn7VQrJRVb9RSfqlCjF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d5:b0:7f4:130:76ad with SMTP id
 ca18e2360f4ac-7f62ee09eb6mr791739f.1.1719629695250; Fri, 28 Jun 2024 19:54:55
 -0700 (PDT)
Date: Fri, 28 Jun 2024 19:54:55 -0700
In-Reply-To: <000000000000bc3c710617da7605@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002180c8061bfe7dea@google.com>
Subject: Re: [syzbot] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in bch2_fs_usage_read_one
Author: peili.dev@gmail.com

#syz test

