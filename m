Return-Path: <linux-kernel+bounces-425154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59419DBE40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6637A281EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DD9461;
	Fri, 29 Nov 2024 00:34:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF95258
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732840488; cv=none; b=Bi/x1+cl8Lu45wjlXd8eh0zZ17sQdRga85FJ4R063nKCKb/aHeQ1YWVJkx+5PDFia7iOLn+nla3I+L5OsqfYPpOwiWMG38vq0QnHn1JBW1FslRthHAnA2/5xZcGPePF/7JLSpDEiDhgxYrgxxHWqYWpEgYDFN5ZFKAgF1JgiC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732840488; c=relaxed/simple;
	bh=V9K/ge1qlQnSKhn6ccF42ZIM/oT8f3EOwpaIqdyy6Gw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jAp2DE5AGIahidvUsCBwjZwbh6jPWQ2kZcokxpB9BqdbuxktUnELLI6qTHLyiyj8ASKZvIu6FYUwxy5YPXfv+YGCC3EKRHQzP/JIegp8QAr8E0KiAcTqJRe+3ZuF9Z2zEXiTJdju5OWupKtJdvgszipJV4LZq1BnyEqOel8BDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a1e95f19so12506635ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732840486; x=1733445286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROsKQyWV+gF1wJoPhIsVEHfYp5GcUChhj1uiGH7BP/4=;
        b=QPbMjZ6TiskawzIv49gYNV+eEs7l5hurvI/KeeMneIMEloxlMoNH+gSkqVrbq5d/QA
         phdBVSxZDr1+UqaTo/AJj+zRo5oWYjVoD+o7LDTZ7ve1xbAEhtN5ngf2rDPRL8kXbPrQ
         LqpCyd//mOHmf+8yp8DDju5K0lwLXB4ld0FfuJiszRSgwtRUD+G2DHp5TMuJ/xW84aJ7
         qYsu/fPE+ZGkKGwpf/lKt0olPstwvev3DoYCuB8I+TWRKH+qRUJpUUBtay6g0IKyLvCe
         5oQIDraQmGG5iQg7vBSzyd+F1COjYa9NW9JQLOWRWSIizo9V2DXbfCXCEs5ASv9VDs/s
         xZ3g==
X-Gm-Message-State: AOJu0YzVD2JXTP4ab563njgpAl+zAQeOKMbqcEzLzt3+sHPmwLdot43d
	p7B2oDqaSM6hghQGXEvZn6yNC4V8NmlbKP/NbkmACqHbtwUCvVn4fkGiYoYhH5YV1h2B8h8vUAT
	Aq8L6tMjMunTqlIcQdNGWZeZSLYOYWDYgP2EiwpDD94FWDLsuQTikvRc=
X-Google-Smtp-Source: AGHT+IEGwuEWWE47rW0ClJ6LwDCo8ZoWA9WLr4NW9U7vS5H836Wr3M+uLV7Zj0ZGu2EczuK7Iuo5uGehbEVi0cCJZ8+GK5cNZmm7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3193:b0:3a7:d7dd:e709 with SMTP id
 e9e14a558f8ab-3a7d7dde903mr2107525ab.7.1732840485913; Thu, 28 Nov 2024
 16:34:45 -0800 (PST)
Date: Thu, 28 Nov 2024 16:34:45 -0800
In-Reply-To: <6732caa7.050a0220.138bd5.00ce.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67490c25.050a0220.253251.009b.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+d4b38c802ea425ccf857@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't recurse in check_discard_freespace_key

