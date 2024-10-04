Return-Path: <linux-kernel+bounces-351367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9B991015
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F01F273CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6D1E1C0C;
	Fri,  4 Oct 2024 19:54:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034621DF725
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071665; cv=none; b=BDqPDBHxn+pQJyIOI4GkxUpBtMZf8f6WIUBCVZW0U8L9G6grJH9ylqDML5Wj236A4TaAdr523lVlzCaAVxN9t3YdS0E5yz/A46KuZNENtkuyI6+t2rCWPgnbsrqyuSxU2fckvbvKz95OtcQ6f9K4Or87G9FnEtL03bfIL/Y6Ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071665; c=relaxed/simple;
	bh=jccwev5i7Ky2EVWCY2hPTRFIWqW4xoaP7Q+TcriIPWo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mGm4aBmGihqO7oBiSqtEXyb0OslJrAiGTMjFzqpLzhjDyzPVvBKB1vSAm75xeJadXyVGH9dpex9qWDnOWfb/vQoBmL0TiavrBpFbJfPnOQjwAfZlaoae8qBFf9hGt6XR1ntqm4KpFR4p82FPLR3Ys5mqV71y9vuFxEtHk4aZfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so28015345ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071663; x=1728676463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jccwev5i7Ky2EVWCY2hPTRFIWqW4xoaP7Q+TcriIPWo=;
        b=aVLaiUwX+XmZbcyHx6Hl4b59CyV0L/Nw0WZzV8VUgWmUqL4UYJgpGykFdl/9WtpKAd
         ltrIQvKy7O4xvRN9jGhImugEAQ1PvsbFDnG2Q9DSANBvMhrwauuDwtDLUP0Uw9JoF8ja
         E1OPzAQYV9OihnwLiAiZhu0sno7KvkdLLDFlIM5n/WOToVruXobeh3cbUQgYBg88aDRn
         yWgSqxNHf1+ZpOlO5J8stNthX4+az4uAC6e3e+B+0Uf81q5M/3NVkqsreYV6zKQMmgJG
         xjBRZYaOcqJh6nGAtwtrHYTrcw/esOFn7XOaXJs0rQJN8JFwTEmdifu2B/d7I0c/pPZ+
         QMHA==
X-Gm-Message-State: AOJu0YyrAAaHHbeNAVog2oijn6/7aH3J6J06MEPslQY9yoWEowv0Nk/Z
	1TLeG13fNf50Z+hdw0ODfdDtWMuLCFKvv/yIhQ2gV7xgsT/w+g307SnS8foaqGqw2PqqfY4zAl9
	dYUXmkXXtt8bjj1osLC31mS7RDpV9iWYsWQrjm3qTXR1tYSNkoe+fJQo=
X-Google-Smtp-Source: AGHT+IEVt0ZT722O8kts5pMGqmPhp3qFUGHfZLm7lExSY1rCXlDCHfGgJ7xcftAjz87/Lma3TjriFrVNgql4FVScSsJQt0n/rxHe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a375bb0002mr37040965ab.16.1728071663121; Fri, 04 Oct 2024
 12:54:23 -0700 (PDT)
Date: Fri, 04 Oct 2024 12:54:23 -0700
In-Reply-To: <66fd2663.050a0220.f28ec.0510.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670047ef.050a0220.49194.049c.GAE@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: UBSAN: shift-out-of-bounds in __btree_node_pinned
Author: niharchaithanya@gmail.com

#syz test

