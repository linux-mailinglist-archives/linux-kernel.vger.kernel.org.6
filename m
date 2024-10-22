Return-Path: <linux-kernel+bounces-376986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DB9AB86B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D40284A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82B1CCED2;
	Tue, 22 Oct 2024 21:25:55 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF99130AF6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632355; cv=none; b=fYEwpFTBYxUW30rRrE9G9eFb3wuZBzBwXhvUHmedWb+aqm4Jn5XbVv6lezXu3AmKKFNrlU55pw056NgCibS5yH5IzCpnQ+jsK9hyu7aB6VnBvg5J2v1V78EiUNx+llp15ynRX9fTfprsFrOaGNoNp8h7rkhZ2qwnrmkZ9OWvVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632355; c=relaxed/simple;
	bh=2wr/FLLkj2nXSpwSVqp8Zboqciqgdlj9AT+w0OUBCY0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OCd3VLL5Doa332wxZ3p/D/SO+L/RG5c9xbHj1LXqRA4yqhbDcKjgxoSGSY0tvlS2StljHaWxH3JXUFw5HIYPFg+1hGEfbD8bvpzFxM0Y5bp+KeCM6y6TmrWQPCrYwg9eL7Ro1YEv6rczajGZnefj6V2f3QTBjGJ7o0rKmaOy+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so59693855ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632353; x=1730237153;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wr/FLLkj2nXSpwSVqp8Zboqciqgdlj9AT+w0OUBCY0=;
        b=vSdGTp9BPCt0wqWtChx9G61B/zaA+FV+bFKxari5rrc0LM8r8AGosHq1MRX2fGB30p
         BzGC5ZjtuWX1CBLbq4DtP7pA2oFJSv+q9D7jJZ77MvvgxxKv9XfjgV7RYO1Xx1bk+/WV
         xSClhZnkkPPf3E7p9LgCC2qPUW7Jc1C42bW4pAMt2uvvuEpagBZu5EHQgB80HK8oLxaj
         zf4uKXiW0JhxOHtJ/zWHZ90q3st9MfE1fSGuemPKo51DKqqkMV6Xn9G5ih1Z1aZfKzU3
         F08yXjHye0RaVRxttvb0MVFu2uL2SJvvVwAW1RHe0DGQJt+tF+CYICYxZjYKBC5ONYfq
         l80w==
X-Gm-Message-State: AOJu0Yy7NdX7W79PQraSXfsrBelmp1JWGUzjV/sg3/o6YydYEwrLqopR
	HQviuF8G0X5iTjZUljRaCVrqsVLXiiCTOY9HGswMCb65BO8akIRWvlxTFtPwInDRr8ZJcr8bSSG
	5ubTUIBayl8LlgQwhQhz7a+W6jmk+ax8eRsZDVS0KdC2FWDn0LGgqq90=
X-Google-Smtp-Source: AGHT+IHQFKT3TEM9bDTZOfoxes7UFB7agjg8undHUOoHUbGojV35BXzYFrPWKk93g5fEHG0mFkKyEiFIO5tC2MdpaepTnpznPWOy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8b:0:b0:3a3:9461:66a4 with SMTP id
 e9e14a558f8ab-3a4d597c798mr5870805ab.10.1729632353270; Tue, 22 Oct 2024
 14:25:53 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:25:53 -0700
In-Reply-To: <00000000000005d7e10617c3a3f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67181861.050a0220.10f4f4.017a.GAE@google.com>
Subject: Re: [syzbot] [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork;
 test if repro still valid
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork; test if repro still valid
Author: gianf.trad@gmail.com

#syz test

