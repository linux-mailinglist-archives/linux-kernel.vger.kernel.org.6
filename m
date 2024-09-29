Return-Path: <linux-kernel+bounces-342727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945598922B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 02:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BAB2854E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F6F5661;
	Sun, 29 Sep 2024 00:45:57 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94928EF
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727570757; cv=none; b=jyGbW7fcZ4LFH31iH4ZkszaCOkQ8guMXVedwbuclSOWMS/nC2V6CFWuhoJoQsixUZ59VF7ynzSZL0+gSyoLas9CvWbFtUf4JfU8kuD2VBBiFBmXxY+P9DDBVrSVdGKJLNIgKWo/50tKkdEQE+eIoJ0/bfVZSK3BpptyNBN1z+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727570757; c=relaxed/simple;
	bh=jLD9TP3G8Y0euemK96tKa7fXwJSyflUP3Uf7M1NcG0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aKljW17keHQs4cSYn6lkMra9pncEat2CMCOIch/dXrWf9dr5nRwjUhiOULc0QkWPIpDSX7HdtGmYWrfP/kiqDmUDn8AprhmYuRi0+z+Miq3fXoKULcOfXUZiDk58dJP+i2MtkKymxit+1/KagaK1Xv2TjHY7L/3+/PFWTMolxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3466d220dso27379385ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727570755; x=1728175555;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncSuZTTtBgx90MQ60AafmT2E0IviF1JzCWBx2Yph2Jw=;
        b=s1qTX4T6N9C702tt9+D9x8gDL9a4HjZev/xOqZzgZpxu34j4qb+yOFqmeKl7Pt+C5W
         +J5HA+S57kwAyyUKi5AvkhemDP+E+jEB+wRN2g/Bb2c5RiS1Pd8Ui9RjiAZQQzccra+Q
         7OEHcFIdecbfgMMitVmyquJkcNsRHVWzuOnRFmlpPtl7styhDAaruWMcU/A94YPSSH4g
         HgUWEZlkbcBJTno4U4bmaswOkMLUac+Owj+Bn+62DOyBCnuWy0UUTypWTro3MJMj0gZT
         FzeQR9znIEFpKvDAxV4YgwdG9C0zHEpLIvQrUNRXrTjCXjs3iLkLLWWYT6JSf7fgbXxh
         7Ppw==
X-Gm-Message-State: AOJu0YxaB2lQiKCQMt8d/2KamLrTFGj0R7taFJ/dBw0vptsEuVG+cFE4
	WcvgqhjDkbazy9+YwqqUkHYNXEoa6GYJwn0L/fHEm5sr+Ild3JAg0it8+Qc3couuFxo6pqcOkPL
	EYIxbA9yXbs+wg8tAdGQC70lKOZzo56S62s6kxEYIAd7wXnQ0UaN4BLI=
X-Google-Smtp-Source: AGHT+IHdwqwEm2V9/v0qhoq8Vy79b11BBdUnByIsdWUcoH/Gd52rnzNs2inQ5VSAZtpN0UdAjDCrfVU1Id8AFNgs0IbOkME0QWpM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a345176668mr62318945ab.9.1727570754871; Sat, 28 Sep 2024
 17:45:54 -0700 (PDT)
Date: Sat, 28 Sep 2024 17:45:54 -0700
In-Reply-To: <0000000000003d5bc30617238b6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f8a342.050a0220.aab67.000c.GAE@google.com>
Subject: Re: [syzbot] retest bfs fix, please
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: retest bfs fix, please
Author: andrew.kanner@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

-- 
Andrew Kanner

