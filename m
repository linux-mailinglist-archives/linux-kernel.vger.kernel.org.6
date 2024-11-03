Return-Path: <linux-kernel+bounces-393921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69869BA774
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9E7281422
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF9158A36;
	Sun,  3 Nov 2024 18:40:48 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA613635E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659248; cv=none; b=sqKbzonLYEzJ7zY52cOo/DwnxbcTtt3UGl7F0bzjY8w8+jUeJSV/ySdlZtDNqhrYknduRAYZjmaEYcKfKbFcmnMANBrOrIihlI3ON4iA0RDAClT3rLjHSO+U68SS3WAlIrCkb7EmKyCK1eXCjX/v3KwST2/X1f7VTOrQ0BEEN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659248; c=relaxed/simple;
	bh=q3Ws8XESMPfzO0txYJRX4Z1w8UDW9ZloYKzrUqYGQbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j2QeUzle/vSl8Eoa8vZ1iryqm53SeG6nmCOwT6/nKY4VlII0i8UcSheufHt6hSQhMjxD+/x5rzQiG4iBBbrulcstk3OFE5DpYWB7E2ZM45RsOdWrtI+37ntpC+T8Ro+bPyLGLKte+Ay13MTg010VxMSK9ud5nsNBQUJmxnCId1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aaedba7b5so362727239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 10:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730659246; x=1731264046;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Ws8XESMPfzO0txYJRX4Z1w8UDW9ZloYKzrUqYGQbc=;
        b=rFyxQ1QiBdfoV+ny81ChmWk8YTka+h1sGUKtowdRD07mKD1NG5f39Ov93gIZItVmlh
         azg24ro6ccw2HrrSaNVSMA5K1jIdGC57nk9qBfUATQPlrK3vtUEEPnei9JmY/E5JGKVx
         FcOjGwXvRj5oY1BxmbvH2UXjW2A3smjBeENVgQrBO11lgINiity10+/xHzp22u72ECqV
         1T/wS6CKqO3crD2rAOJ68QoqkJj+qTHBG/EeqBuzY6Ht7Se6Fws7tZ5MuS32+4SXy0hR
         kOPeBOY1oaePhnqWi1Y5IHKOgMgBXdGUAl4ueZHnc6+RqOtwuCgcK58qSHEw8aNs3FlP
         yA6g==
X-Gm-Message-State: AOJu0Yzm+NiG6oDY+pAiGyHYY4IBjq1YgECSjDkm8UiNN2bP4rMNyODs
	YyFaZ3wUItF/DRHUViRtYsZ2biaSwBKvpMtilTv+WfmWjwWLWmx5P3reowcIjNGw9/7+Tr7YBNO
	tRueinClBMp1+NmPd6yDXS0Kzj1iQmfOcRZjP7EVmD4Zu5tTimOMrgbg=
X-Google-Smtp-Source: AGHT+IEvPAfuMncJa7uO/b+AxIC1mw4/NuVbCx2N9L1ODYpyi8yaEatvxMyPj8SGxaMWNnau++y52dGLYlLn/H1IqaajqDJ1IdWR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a6b0289030mr88543905ab.3.1730659246090; Sun, 03 Nov 2024
 10:40:46 -0800 (PST)
Date: Sun, 03 Nov 2024 10:40:46 -0800
In-Reply-To: <671e13ab.050a0220.2b8c0f.01d0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727c3ae.050a0220.35b515.01a0.GAE@google.com>
Subject: Re: [syzbot] check ocfs2_xa_remove fix [v2]
From: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: check ocfs2_xa_remove fix [v2]
Author: andrew.kanner@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

