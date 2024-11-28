Return-Path: <linux-kernel+bounces-425042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A948A9DBCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F81648A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD14C1C2454;
	Thu, 28 Nov 2024 20:12:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5688145323
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824730; cv=none; b=HzcE1TVWii9rP5dh5LBxU3ENgnNG8QjDrAMQu5R5Gu0vU4UcRYgSTJzNFNP/rUN67BWiZrxaSRl0K91ouEkgWLMBXg+GiPjk7MOdN1YI/me0Rfgf0LVCBuyIGyNBrBUlnCLv/x+VCHqivdkNICg8whYZ3j3Zat/GQWzk3rkTlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824730; c=relaxed/simple;
	bh=UlhzXH3k3ZIyo2s8RF89OEfKmICymZyLkIpFrHXY2XA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DAzKDB+wxamiWs02DGAIaKnnKxYZb0ZPY1JEDVuUTfkQtXC9sLVd+rtsfbzNcs1YEcodDNWC0W8or3TUYTzloTBkY59XnPoYyijtkP85QAdbUDDdzAzUS79++abF8dEN7bPwbabof7OmnjB0LQi0XCZ6x1BFY7X+c4WRLBHO+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a794990ef3so18591165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732824728; x=1733429528;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLj5n1bX18tT3Ex40HnX43sQGsjbsFu2fTrT8a19ou0=;
        b=IPd0b7yqcUPBAc8jc66BE9YqdmBxPVm13A1DkRbNsftJXf2I+uWhlMNN3wTGEMN/Hm
         gi5y6PdEDb7azrFTYaSxm50ElwNC7tOugOlj5Kvabp9y7+sDcPxE9bmX+5dVmKz70xQ8
         kM7Sq3zqdnjP1SdzgMLuYepnbuQWzHFGABPlsMDkbIP039H60ax8v7hzeYa0bEWl+PYZ
         b4P3zCEtnI64tzQfPTE52hFbuvQ65+MS4SM2eDRJCtI8wRUlvw5YdNMlBD0MCa5GVgK1
         WBxY+iFU1jaQXF71/eO4QZ6m2F5mxbKX21joxJfK2wVogW01pE/xm1pRBfD7Uwl5yCPH
         PndQ==
X-Gm-Message-State: AOJu0YyHqJj7wgqiNqNoGRcEgBj+PMiIJo2LGQj+RF0vEOdFW+DQlLhT
	wKulH23lFxhCASFaSiSdjo9Af+AKVtxFYq2NbGEGLsfDTLcd7vA6kFnOt5GWYRrd+2yyGsWQM1O
	uMD8ZJTuKHPniwdKHWcvHobb74WnW2AwkZAFkHmkhcaqgKCJy+MEk9Sk=
X-Google-Smtp-Source: AGHT+IHZJJOjIO4eGBxpcth1YoEUC9Lk+ICaBjNKPQZ97/T3ctTPxWeho9MHeKJka9Uz+S301a/HanuNLj8GXHJ3qOY2oRGHvkF6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:cfee:2112 with SMTP id
 e9e14a558f8ab-3a7cfee216fmr20021835ab.1.1732824728143; Thu, 28 Nov 2024
 12:12:08 -0800 (PST)
Date: Thu, 28 Nov 2024 12:12:08 -0800
In-Reply-To: <67447b76.050a0220.1cc393.0086.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748ce98.050a0220.253251.008d.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+2f7c2225ed8a5cb24af1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix journal_iter list corruption

