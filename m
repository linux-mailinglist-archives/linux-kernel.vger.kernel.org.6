Return-Path: <linux-kernel+bounces-297747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F275695BD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C44283DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B71CEACA;
	Thu, 22 Aug 2024 17:24:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41021CE716
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347447; cv=none; b=YEiHYE17HlnyDoT7jPtK+yS8lS+CYffIB2YSoCxzScbKuCvWlxooHA/SKEwv67cqIB0RtcEvTr/rwMeUrQeVAIIqFdKy9UCUsuVsmqrE14jVaGkryWWLZJzHo1XU0dtakrnU4xbbCjhFHx0lPe1zEnuo5LZNGKOkGOwxFudfGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347447; c=relaxed/simple;
	bh=G91Q9SLQcSKbC0zm38pGwv7rzLsHrRbNejIWvyfF1zs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pazbd9eGMmjFxY0t9IoIzXZKWeUwqdU3oFVlBxNzycg0yiJfYAmySDRQ3PUW6VBp/LX1oXgH0LaWUY17eINB31ZOpoZ+UFJHCREa/mh0RK4wCuEBNlFwOkgpX43P1V5nuNV1UrJspzzLIGw4hudFRTbGaHYBeP1hsrLvqoccz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d27200924so19302465ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347445; x=1724952245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G91Q9SLQcSKbC0zm38pGwv7rzLsHrRbNejIWvyfF1zs=;
        b=jqM8MylMmTTExW2sEKvZXYhpm2cstc4wnjdt+xCAR7YeihK8yAPS3T43TaudJUoAek
         TFNMw2SwMEcK44nco/w+sX+ic1LpDlIo8/DcACGcXCbB+UYgCUDlBo4TA29cbUjZFlHu
         gY6k99DY66ROLRm/5CtVL48Yk3W2UcrVpChkmRZajishcsfBXSrg3yXj1TfR/TJyUITJ
         dApU78RWBkqSVVI+DzzqyvZ/PuG4ZQFi1t3YmhRdyUlLa8TqWiolBs62NYP11MBtGkGQ
         btsG6UFTLoPI+YmKU8j5ZhW14OUtj73B3/OjdWFD13TuXXHgFtqP4wpbtdwTHlEY9lgn
         Lfnw==
X-Gm-Message-State: AOJu0YxxbXyYM5qWpBM5gR6lzyyIzeEN6tzKUsI3B8SLj+6avjkivDwU
	L+yTLPNGn2dtjfDEPACKCIRZjpiTQUaeTUpjjRKA5kGT1mGP3yJXaxH8xiwPT2A32DG2X+l7hF5
	ADi8yi+bThMlk/h8kh5xfalC3Mm6v+sICJRJf+WRsy91Edu0nSWvgOUw=
X-Google-Smtp-Source: AGHT+IEeQsidKPUX6GHZJzF0IlXPXFTRx/QB3O7EuxFirYcmHNQy/P0Et5UOkoNd5s7RreRL0j36bENGTwvXNrENr0SYC8QFrzFH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:39d:268a:e920 with SMTP id
 e9e14a558f8ab-39d752d81b8mr1961335ab.3.1724347444989; Thu, 22 Aug 2024
 10:24:04 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:24:04 -0700
In-Reply-To: <000000000000bc3c710617da7605@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eda123062048ec46@google.com>
Subject: Re: [syzbot] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in bch2_fs_usage_read_one
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Delete journal-buf-sharded old style accounting

