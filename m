Return-Path: <linux-kernel+bounces-297760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA995BD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3CD285D91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647791CEACC;
	Thu, 22 Aug 2024 17:34:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D81CCB4B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348072; cv=none; b=UhZLxAp6nbDNyiiXVc/yhop95lDamGPScV5h7NKleh7Ruq56sPp7MpsMAWLkQ+bAHKDo+dXt+WvzCyZCQ0Nu6eEBiHHUf6DbbHnKvkCl1Sm8lfNch86tl5NJSdtah1kHrIA/nNFB751WNFZ0GLm1jQPTP0+lEXUTXThUV//Bv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348072; c=relaxed/simple;
	bh=78Ge9xdFVB5SJQtWsDq34ATddoaZ8hq7Mv+q/MAADgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r6SDj/cNmwrsh/xhzjky2eL22seGuY4q2JZrPGPEKC5CtrNW4UkpZRFmZzXfkc4QIzDjbTYfSwzthZrsm0LmybEK0NvYEgP1S2j9ro2pKEFNwHTTN+i5lHDlUzpwLp+Rykc7Zk6PxB+Oxfk3ekcophYp8ZEWfH4IQWLnj/fpgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8252a16781eso108639039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348070; x=1724952870;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78Ge9xdFVB5SJQtWsDq34ATddoaZ8hq7Mv+q/MAADgc=;
        b=o0oH5l9KB0Ag/lF8IKfb5jLDnjwVuv9WCITq6QbicMFkh0deGKHp/PUZLApfPcS+pP
         lQ4LlBsu8CtOKvnOXQauktgTVSrx6vmTEUNrhjE9tibc+h6qey9yZ0WegGMEgHPS+7yX
         geiNbDMdZU8mNiG2Nz9QVsP3uVtm2+1741qXki4IIA2/s+f4HMKguChyL9qKB6oR3C5i
         msgalI9TssKLBfLH0QWYAqqmaX8A1ix/dVgH16acFlmpf+0dXhhRIJee1vJr5k5Jnr//
         2iq8G66Lc3Y9C8hmVSoqYjJp2Mk9U4rJ3RlKz96tzmYzXeH+dS/nM8EFCfn902miDp7r
         9uPQ==
X-Gm-Message-State: AOJu0YyKO9xU7JrL8Aw5+mw2eLujHaGSOb1P14G0tbWCeSX6Lxn0/kZf
	fFapR4MTydAr5r6ZEj94F7ma/6D3KTRfFrHfNJss1ftOeOhuSDqe8TjoIIhD8YI7LtL6Qnilj87
	FJ7nfr1kOKdyLOy18Yks5nP7Qneai/FcClgj0VPXI1Hs6+KxPcz82ybk=
X-Google-Smtp-Source: AGHT+IF9Q24DoIeXkpHNugN5mzqzduTydU0uymBk0TFXXBaUjWIs8BrUZdrRyVlguGHr38IOjpNuz3YUaXgfmsNq3OE0bWgxJ8Cx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:39b:3c0c:c3a4 with SMTP id
 e9e14a558f8ab-39d6c37d505mr2891145ab.2.1724348069655; Thu, 22 Aug 2024
 10:34:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:34:29 -0700
In-Reply-To: <000000000000d38be106186a5e45@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029482306204912bc@google.com>
Subject: Re: [syzbot] kernel panic: bch_dev->ref underflow, last put: bch2_get_next_dev
From: syzbot <syzbot+a96175a4ea467a49c546@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: kernel panic: bch_dev->ref underflow, last put: bch2_get_next_dev
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix ref in trans_mark_dev_sbs() error path

