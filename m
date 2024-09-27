Return-Path: <linux-kernel+bounces-342210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663B988BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C242A1F226BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79058176AAE;
	Fri, 27 Sep 2024 21:36:16 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722A27733
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727472976; cv=none; b=kiFlObUa1WLJShvLRR4GSPqEItIn+0p5dsupORmrd2SuAMF6t9pNh593fGioX0AgpC9cQDknI0GM2W8hN4ehwotlKOtUwIuLBlnWCp5oTIGqfcFO15qnCJyUJYy3YMdtgUH6mljX0m2kCucHat4WzBZJ2y3VG0ynerUYGmKhAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727472976; c=relaxed/simple;
	bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vDACLHbuOfAAI0pCrETWWXoRiTVB9p3ecLvj6uKzoDyvyx/uQvD9K0EU0e4B/wQWSM8xySzdCUzSk0847vNN6xlykfo8RiVM4L7KGcZyq7VyjX7OCDljUrMJfxdeGHRj4CvYQ62e6KEG1TzBHizsgfGy9EYDr7eUuphCcIekU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so32854055ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727472974; x=1728077774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
        b=Yq5CpJuvq/WQK5NbVpDLJ7ijto8JeUlRy1EzBG2g6gjZnQJ2ulc/vDwMmMbPjt+3t6
         fvOcjpbzwbR+xLJvikwCawblcGxuenz9WIhldF33T/lmOO/2X4V+VQhO2k+7j3vn8NCx
         TEOga50pOGBbm16GIPxV4YTDx1ZSwG/WZy3TgYD258n6UHoxGtSsoocGbtgkaHtsVLmv
         IVEpkaHPOnJVRTulD37xD10goUkjyBUgb+NHkTpQ2VsOVw86gJ8jGYt8rW9vqQGz1ocz
         W4nhdXw6OejKBp2sI9wEmD6bGNihH6yOKNrXCC+uTpWBThZtAVU6wcxzytjIFCiA8Lpx
         jp7Q==
X-Gm-Message-State: AOJu0YxXBDuHR8nxLQNaWCM9ZmUv0fJpShCAA7jKRn3Z4Oee4sP1VLX5
	iyD+iLzWzqGVNcXIicEiKqNbGyjk1qB8uiD5YGYyS9RVqLTke0h0JQVAxVOK5WMDjq8ZKtDnfD+
	6pcF/7e8IYkHI2ywDyohr7PIReN595Z5RTmonIdEJLmPX7ovwwqZJk0E=
X-Google-Smtp-Source: AGHT+IFocpiSlkCnONp1MDi+Ns6SlJG+8Qkv1yO3vV5cjY8VYhGtua9jh6NDbop9GXyR8YTkMzxQ156lzS/7e0F7l7Osn1jWDMPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a0:a21c:d2b2 with SMTP id
 e9e14a558f8ab-3a34517e868mr51041965ab.11.1727472973970; Fri, 27 Sep 2024
 14:36:13 -0700 (PDT)
Date: Fri, 27 Sep 2024 14:36:13 -0700
In-Reply-To: <66ef45f0.050a0220.3195df.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7254d.050a0220.46d20.0025.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_btree_pos_to_text
Author: pz010001011111@proton.me

#syz test

