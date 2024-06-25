Return-Path: <linux-kernel+bounces-228335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC5915E58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA8283941
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE04130A5C;
	Tue, 25 Jun 2024 05:48:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5391DA22
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294485; cv=none; b=ZBgIYOPnYTxgNwVzDtfdj/cfUvQloDV0ky4XKBby2J7k7sXEbCrDyp5BILaiT/cTv/JdfaW0aHnSCBrEaVkYTiRatFDmu+9HH30hUzshZdczyz4oi0PfYotztcuOspV4MrFkYg+rFCQpFjBfehsT5IQ0i5KXrKN9CRLiqeVW9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294485; c=relaxed/simple;
	bh=dN62t+nVicgTOsL8SD8Q6dIpEAlF4B8mUFUlTso0HSc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mtQgNxSTOL6Yrfo0qZqOsuLEIG1m1e0rL9gaCm3g3HrthHEzfmd2aMi73NdnRiabwSdtnGfn2NmvH/i5erBGqmOzTsxIM8M5YQLKGHafi4T3Q9TOUuBlGKAyJTSgCn8cqDHaC4lXkBR95/bd/szZ1EXIIJNJO38GmeOBm4fhGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso709911439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719294483; x=1719899283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PTnpT4v3O3Zcrj9+u0OliNe536jKT2m1Hyt8t9QBF4=;
        b=jv9LhQlEuZB68WzAU3i4gCk6PeBKkTxWsNbfmULLJkPPeVtdoMQkcM2bPEf8Q8fR+L
         UlDppVRiYOVPDz7RW5qK1pFGG5iS2exV3C6uN+bTPdgLkKV1dSmyLiPPY4Eu07YvJmnw
         ltUDhOpxlVdSYcjWjBhmoDHk9otH6AKVGIGK/3jy7+xwsH9aiXUkRe2bOtLCq2n8YCLI
         MT/qIhWZBkKbmdhCuLnpSVshGeZ33ao4jYBMgh0tbKyW8J00LXWqNpcMydNC6b65zAkC
         pdi1jJI53LkZ5JlxbUlaNCx/yp73DHR/bEtjnvkggmxorjzSZRA7cK4RqGzDmy4a4Weg
         z/dQ==
X-Gm-Message-State: AOJu0Yzzs5iVn9O5mqBYjdB8NOdP0VZBpk4CE7ItT6NuitPRGk1e4++T
	F0AD1cxlSCg0FXRjN4KMwrEzdISa7CPq3PqffPthG/pbzW3yGIzo8PgA/Uu8RKM1BNvcop0GWIA
	MXO9vjLSCWGoRgyEqI5PSiPltLBiiDB6x7KzI6YwNNHJg1XmyMpZPz6g=
X-Google-Smtp-Source: AGHT+IE43kExsqPzY87E4wgyk91qaLzarWMmz817EbQ+UPz0D8zoxwtUkey02OPMps6IV/mVj257CAzZisX+33kn16xIn16CRXYh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:374:5d81:9135 with SMTP id
 e9e14a558f8ab-3763b0016c7mr8155645ab.0.1719294483087; Mon, 24 Jun 2024
 22:48:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:48:03 -0700
In-Reply-To: <CAMc0M--4BX1f1HSOh2jdc3diku2aTpewhws6X+Mb7AAvKScX2A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edd5ef061bb070ed@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbDiscardAG
From: syzbot <syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156fe751980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bff6f9b539bef0c
dashboard link: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1694ed89980000

Note: testing is done by a robot and is best-effort only.

