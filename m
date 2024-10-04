Return-Path: <linux-kernel+bounces-351424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936A9910F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB61C22D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA41AE00C;
	Fri,  4 Oct 2024 20:54:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F36231CAC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075244; cv=none; b=XxxaurYYiQHm7bO/wQLbR8cpwCdIlc8f4WOmHpx2TjwKtbwuzounT6QIXYHEbx+xYApzcK9VGlirRlNPhJd+n6TPArAeAg3hETYlFDCgYSftoDI5m4b7dbot3C6Fjxgge4q4cTyxRI9QSDJYXO4CI9d70+xeO5GEXIjNKKCKp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075244; c=relaxed/simple;
	bh=sHrNFovkx7cIfUOdmMEBpo+snV8G9B0mz8ruz/fphSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ah9ns4LMpSLI1jFUsWDc4Y8XUPOcwZpEoW4H4fuWyD06wmQUODY7Ml94Q1uJhgJuIRGf61cqnYU7cP+oONxTjpKjjmpr3+/Y61gqVaA0WKmrIewoPYFLkOQFtAS93azBv0ecBfvO7jLJgpYxOOOEHT5G/Tp/SqeRe07WlK2C2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1925177fdso30082215ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075242; x=1728680042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le2JLJB1ZWwLNcK4vQGN5IO/HRsEugT8/CIAYs9lFSM=;
        b=wM/CGMbHpAqnCgXNrZfiU/sCl5l6mG946rDpR3vRCaGBWrHmS1nFCu4wN1VvLug0wD
         Kb3TlwVQxAkAGDgOTS0lma3PU0/Ym6ltAfd+aDhPtw6uVZI7griLWyzXla0QV5P3y8qu
         4l3kFoXhLm+jfmLyp+AsG3gNM+rkEtWmFdXaBXQcyIoo0+kl1pPtRBnZ7qbpymS3wxwh
         0jf9LXR9Sz7w6A7L6YoZvBoMWSTcA6GvfwplrEZHFuBUZl/2FZeGqTrXjwVZqW3wGH+3
         1xWl0VPOSa/bACM06bI1L1FH1f9W1qNGCZi2j2c9nrFtXwXsGZErPbIFAGbVaJ6WJrdn
         ZjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0GyrL6K+RKBpP/Af7CA4dUavE79yYvQuzxV2Ui2xVWgUA6Gh1fLqiYVa41wdQ6FVeM3iC8dmp+K96COU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93yQVPArHEb2p3p9X9vF7YZD1YIoBFBohWtbFP7Qio8EN4PnW
	7sVsGgVNQOcG6Qa6H1axa8d8M0ixh9qjcrXT0YXhZoMHWWkVv44FWlp5Hn39+nM0pnvRIU9IwvE
	pJTq1wlTHD+6PXKM/NafGO0sl8eHb0pCCHFarqji/mj/YwWmXpTOub0Y=
X-Google-Smtp-Source: AGHT+IHgv5TMs/7T7aq6PVZ8bJabIyYEU37Oudywg8Kmi+ABr5pCKc0/mWyTJLeSCIbUDmzgSMeSQPcoul6ZVlBdS1iliKDhzoev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a375be1cedmr41886895ab.25.1728075242253; Fri, 04 Oct 2024
 13:54:02 -0700 (PDT)
Date: Fri, 04 Oct 2024 13:54:02 -0700
In-Reply-To: <CABBYNZKxOsgd6FpfdOKGUD9tbSadCnBzzsnf1K8sVZQ5Tn0cQQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670055ea.050a0220.49194.04a0.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

patch is already applied


Tested on:

commit:         5c2ab978 ethtool: rss: fix rss key initialization warn..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cb079f980000


