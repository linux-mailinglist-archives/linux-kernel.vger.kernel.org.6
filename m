Return-Path: <linux-kernel+bounces-271079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A158B94493B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8912825B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716E170A37;
	Thu,  1 Aug 2024 10:22:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A0446A1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507725; cv=none; b=M7hzBP0Jn1LIYs0NVN0dm20XeFbB5KHNte+3fJZE8MpI9hBdxFrXSoMNhJtg3ZS4CqRMUSadBD+ZRlUhIDdxHr3cemThIAKqzWdE5hI/bDl4UaSufI8gSjEwWAcwvJh4UUw41GZ5pm8FvgzrDDKXJhzw8fYNOtIE3S/miYRi60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507725; c=relaxed/simple;
	bh=xOxSBq9fcLxGsiF96swtNvGY73Cp09IRhe+kAFeAPws=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TBPinY6+3pvJk0MY6XAR7qEcDR9RVdF/GDCIfT4Un38HHFz/+8FNNFUVF4K7oh0EY0ZpTBWTSdwfRrFs4FdxS827Wnb+pGDtir0dwY1KMbJvMMpQ9ndAnC2IzAIopOD6FkDyFBxk7G/pMDOHXRmaijAAn+9crjhD2RNYNVdK76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso107136755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507723; x=1723112523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyO3Jrb5xiKFJXSo67B9innE3Y1M9WbWkS0ndyWhe/4=;
        b=Hgow4DnE1xtnCg6hDImxoIHDI0fepQELdjvWjujXt8f6sVaTWBDjot7tLtKXurznFd
         o+UXyOEGYDHZnarbV29IdRreLOkafsJ4hsf8bM2IWO4iq43X0nWArZccDc2xUCdwbG/N
         0mc72BKuTkh9Dv8t6iOl+zy5HjimyrYcLsDMTN9zxg99lAO6m15kzOanaduvLLntSkTg
         6uEzdcPJvJOcR8R5xSy6iMb9i6BDPCvlZemBW7oQunflVdCJPPl1tIWT0wnKgQUj0Fut
         m30ld8skc7iL+Pb49Br33uLkWeJ9LqD8/CtVs+Rpkf+v7Hpr9kCMf8N/gpohpiq/0eNC
         LgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsuZUSL4C31XzXLQ1ngu6QypKtKDxK0gz8fAV7YVlZpGAW2YUz2V9wudmWWTqbNPjpBzB4zokcOcBpTPsjun+9OT5m6rt98sjjyb3+
X-Gm-Message-State: AOJu0YwhHIVkvx41ETZAos0jeMU404wBkHbI/riCbnt9zNwQcLkV/2St
	hmmd4fcJ9cigDtHzOKcsx8DugICfGTOGrcgEqVdetCUqmrlxb7EVCXOlMQBqOQdnfXIthzoo79m
	X4dppZYTHGpmgBIY30CanZSyUbSACVrN4s2RlO3qi6boTdQiGBmvkVV0=
X-Google-Smtp-Source: AGHT+IEqTb5eqpEVjvxK17qZ8yOUws8AlV0mflNNr5cozPINELIjnoI3ZazLI3Nu2Ok7cKYRrLRP8L2IvRE0SZvsQ7NBSo2XC9R7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39b183d4a03mr680145ab.6.1722507723074; Thu, 01 Aug 2024
 03:22:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 03:22:03 -0700
In-Reply-To: <20240801095632.49339-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4fdee061e9c94ab@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Tested-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com

Tested on:

commit:         21b136cc minmax: fix up min3() and max3() too
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1194416d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172317a1980000

Note: testing is done by a robot and is best-effort only.

