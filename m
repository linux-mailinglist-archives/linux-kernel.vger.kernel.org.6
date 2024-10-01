Return-Path: <linux-kernel+bounces-345286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082698B41B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E21C22BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66571B141D;
	Tue,  1 Oct 2024 06:15:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E31BBBF1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763304; cv=none; b=e5EpBroWUStORVdT4gUqNH5216vvGaZ8ii9owP/Q2CpdwviyQr38Cmr4Z7VhziHzCmUIDBiGg/RsBbctdmx3pLHKgmuN2VKC67/Vmz9jS2Vs6BYnz4an+DnVldoo2pH4W2sTDuxNlm/E6OOicrBgJwZVzYyJYIXJ29TS6Cbbvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763304; c=relaxed/simple;
	bh=D0Ie4Ogh5R5Uh7TzF39J2tmOW+tWhLcRijkif235W78=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MaygiO4hD5c0Gs8zAWbLTQpiN8PCJCC2JPadsvZdC49Gd1BAoDrPXh6POVKFgntYSTZS6hrrGckOHIc7s3houPBzJaMAYkGgVgaFhcXTA6maqpv9q6A9E+8NKowyfDmsYMjz6ZgLM2wOrjWvxzJriWkJPWSo5T2LoaW4crkBnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso498021139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727763302; x=1728368102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw2+s3n1CIe4lFrjRuTpjJv2gcXAJP8p2Hq5YeL1u9g=;
        b=tqwogX2LwWPE9HXaDNmJNBmXGvuP/yYRC2ae8UyKUItnFLYZy/jxoi1MjHxL9wd9of
         TBK1YxtmKM49zliHvkd0jkGudvwzcbePw2P4SAL8WscW3gkP8ob9ogaaq6UOH0emXebQ
         xWawQezbZ9lnodUTFX8jzkoy+cc9x/4A11PhhskDn0ffhPb9POsETQ8WlCIpMYtVEKAz
         aab3aH3+7Gvas3ls3qwFQW/iZi6buiEwsU9RSdK8s29no6dJ08Rqmp0K6bbZjaCjyQL7
         /H0OT/HqMYnfFvZGZuNViRJTXWPJ3NvsvHUBAn1wp98HC8xSH3Ca86RbFdhIe55Crfn+
         HRTQ==
X-Gm-Message-State: AOJu0YwxEbuawcyAxvFurjSaoPPAzRl3EXhs/VsEOhTn/2GROVi6F2sm
	jHxS5DxyfG9yQrciWc4A1Cf/G59mDF3phsmydYHdIjOEftlaVBrOMAamthIe4nTrTkkvTVPZR6C
	4VKfjB/GXZDuV9xE2FAxAHmeg2ZAfZ3SVPYJLpehHK7c+fqvVyC7Oe/M=
X-Google-Smtp-Source: AGHT+IEFQ1xOjHOMNJRkrEgcRq4njvx2UFSQXLpSuMTVEocbxXh1rGUqki8/g0CuUo7f2cDKqvO+I865cdQ40z4/5dhPUJ5meqYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a0:9244:1916 with SMTP id
 e9e14a558f8ab-3a3451794a8mr138704655ab.11.1727763302272; Mon, 30 Sep 2024
 23:15:02 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:15:02 -0700
In-Reply-To: <ZvuMuLlgLz54KUlw@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb9366.050a0220.6bad9.004f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KMSAN: uninit-value in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcus.yu.56@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Tested-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12200927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1fd45f2013d812f
dashboard link: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178c9980580000

Note: testing is done by a robot and is best-effort only.

