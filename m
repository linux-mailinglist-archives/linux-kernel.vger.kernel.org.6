Return-Path: <linux-kernel+bounces-336545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12799983C28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C8282CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C42E62C;
	Tue, 24 Sep 2024 04:57:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA771B85D1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153851; cv=none; b=R6OfwWyBcjPW7K+yxBUUKwIhz/2pYibHmilo6wRpOmauiKnEhTcCRUTKmWAKYA7uWeQfZBKeDK3rmbn+BxxO1gxxSbLVzqUnHJVLO+4FgkzsCMeDog5qFnVAXoC1n/ne6MIi9xUY3c7kGJKhwNt2HyUsGzbKZ1yIKWbzwpoXa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153851; c=relaxed/simple;
	bh=PekNu6Q5nDU7BTkzWZjSbDMvG5SBVeX5+A035HWD7SY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V3NNDjKNzJ22lzAHi881vIOVn+kTnUvdsywGou0ltq8yzZ9kC5SwV63kXzXWLiZ0t7b9VyN46e7nyPAffs9dJJ/HvL+lR+S6IFsae15nwX3s4nyMWwj+XR+nybyD0OAU+5c6AfDO0hNaT/uOucxQBCfiEK3oYgJLSvQVL6a+pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0a2c95e81so58169925ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727153849; x=1727758649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PekNu6Q5nDU7BTkzWZjSbDMvG5SBVeX5+A035HWD7SY=;
        b=XNTYtrS3oGAYj6gZth+oHfAVXwA8T30WnRzGLEQSo9DygVmS6SUJn7DvDpXvaxnaUX
         URTils6L4+PenwDcTQylM1HeMGfte6+mAa+0tPuTUROX4LA9Gs/sMPoj3KaR+JFPsx1H
         rDm+DjEgSRvtXMt3C+UyV+i3j8AIUYyy+bCdjjXWUmepwMF/yil1sd2DmIIL3ZaEd6zB
         N4gWXOfw5Q6v/4bOUkd8lAiweygIif+593+0KcThtikG0vJqiXnu4dyLw/LRla4S8NWu
         2Vj+y7wkKOadu7Pu32NlAP3lE85t95dKbHLf3xi0W3sm+wOOKKlSbIINM1YvVOUEM1GO
         PATA==
X-Gm-Message-State: AOJu0YxNlONVHMlUToZjryu3xakuVVCNrIn8LmJ4U6YHbiwb5CVtBILZ
	II6Ck8KWyOgszPLY9af+/yjf31boAxkF5dhtV++3F0KtKAsRUO9GRgMrv3zyJKoN1ALtQJZYwB0
	KPXvUHrKXSo5kJCopQSufeRN2B3v7AGghKHybYpaR1qZqatWm7TJ9G8c=
X-Google-Smtp-Source: AGHT+IHR2h4sQYz1U4dEY43SUuBOxOCRBmsoYTsQh+kBEA0gAxTH6o0/ME6Y790UgWFCxgDx8MZFRKDnRroS9b6eCsSYL9KU91Jf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a0c8d1602fmr136627145ab.17.1727153848828; Mon, 23 Sep 2024
 21:57:28 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:57:28 -0700
In-Reply-To: <000000000000372171061cf4ecb5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f246b8.050a0220.c23dd.001b.GAE@google.com>
Subject: Re: [syzbot] Marking report as fixed
From: syzbot <syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Marking report as fixed
Author: ghanshyam1898@gmail.com

#syz fix: jfs: fix out-of-bounds in dbNextAG() and diAlloc()

