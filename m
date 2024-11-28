Return-Path: <linux-kernel+bounces-425137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7D9DBDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D97B226F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0C1C57B1;
	Thu, 28 Nov 2024 23:06:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14F1C4608
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732835185; cv=none; b=bdhNoJAdQKrwx6RhVEpx1PRFE+ovMTRzWjwYFDfohkwcmbFTpaQGbODF9TojhHKuQ7jgGiRCaQtTW0BmeUJrgtVhueFsFhjgbVjUzUIoMKorkqhbCeYlz9k9gFocMrFEVk/rJnjQeLxIhvJ2M8L+dqkkt2FnuCGGa8vjQBH5qpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732835185; c=relaxed/simple;
	bh=Ji0Y7oB09g6NMRmr8Ng9mVt+kHhXNlDm3xrOgTWzs8c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I3MoLXMcWw3+DoFQoYz5OCUiOABVsmyxSePGs73zcwpTzmFgQDmjsZvN3MdlZSsUA1Z8rJz1sXd/Gt10hfHwC7Re2xBQxxfhBhU+aKPfkDcCAQEkqZiCmdz9HzlsbZSp1wn+BD9xACF+5tPbFWQZblvABM7VSbeaUoBrQZu/D0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78e952858so11316015ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732835183; x=1733439983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KFV86nclJI4ltIT9WDI5E2cw2CtE+GqkmD4V28od+A=;
        b=vkIoUP1h6nBygMqQ10icmHvcFLT9zZJzjF404CxB7ANCAXoYGoSvw5wtkfBn4DXSQy
         EMlxIio6SJs6AUVhCZyjMfSDAuNuyNmisjVKZEr1Ia5H1BJCAdxEJ7xJcfrzq968JSnn
         Z2rIs/v8Thu1B7P+xEHptQ8D2BDrc+RI6NyvU9S9sRFIvxkmb5xqDugpxehmpGkXaW2i
         O0QxcRjOyVU3WfH+bde6R0kjHD6QuPNgvjYr4t8XFiD2wD0mMbBGrJ2XN4LFDhIm9tsG
         wA5PWTfFPqcXsL7+tEhms7953UCg+qKp8p6GeDPuG0LhlTEiDB4vK6/usjXftEjmV0CS
         UlmQ==
X-Gm-Message-State: AOJu0YxYkH9lJkAZnO7EEgYKy2oqyox6vS96IRqdutq+3sCMRgnYvs7q
	//mZ0iRrnpg7V4XRYiePRhp1iwlA6gZpAXiVurhXZ1QuxAyjDWUpAhEcUTGz9q0oh2xLv0piP/m
	0BfY+CHLYhK4jQvgyFldfm0akx8rMvDCI5sbEiRj7MSohuIOwZTPUJaw=
X-Google-Smtp-Source: AGHT+IHV4/CnXQ7HWpwU55gSGM9fILd99lsD8HVGyLndo1uO9NYRJClRC0j+gbLmvoez6FGaVEFEScTXIiRUH7XkXmrsiSmBa8MD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3a7:6f1c:a084 with SMTP id
 e9e14a558f8ab-3a7c55e2adfmr106328505ab.23.1732835182910; Thu, 28 Nov 2024
 15:06:22 -0800 (PST)
Date: Thu, 28 Nov 2024 15:06:22 -0800
In-Reply-To: <671940c8.050a0220.10f4f4.01c3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748f76e.050a0220.253251.0096.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+e088be3c2d5c05aaac35@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_trans_relock() is trylock for lockdep

