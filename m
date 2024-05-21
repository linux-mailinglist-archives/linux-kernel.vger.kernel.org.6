Return-Path: <linux-kernel+bounces-184486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E38CA74C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6544CB2194F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6828DBC;
	Tue, 21 May 2024 04:21:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B76210E4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265265; cv=none; b=bOIU0uISvqgA2Q/beC0nzv1X4kYDfQj678XAPdopHxIpTfjRzDrIzTTlHyF6YwiiBPKJgE2/t3uwzpfUP0XICA3m7jpN5A4xLM1DA9VJnJjWlSjvAf0wiLYwvXzs4IE99hnuVOyc1MiM7THr0hmAVVTQtWz2wbmN+pA9odOH/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265265; c=relaxed/simple;
	bh=lUAsxpeONMhX1IC9R4qHe81NbisGOaZADbrjZP2G+Eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WmPltxC6TXFCTpM3jXe7C8JjQY25lpgMecrawcIcDbzaz6wWNf53P8Uop/aoOOiJZ5wQLqQ8rxeBrjCul24h4YZ9tb0BgB7LTOgXMs/nE+ultWyu3zRDDDByyRrfHeogJmbcR5xqKhqHmZhbLCuGACZ0tivaZjiVZl+qRMOIuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso1225816939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716265263; x=1716870063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSsHD2Hl2AC8EhhzRcg3ormCwiAPS1drALI/1hMFbes=;
        b=AjiCoQLzixabN/CJnCejWiyU3r/2FvPCDfgq42c92jkxWZ7VzRoiNCePfr8JGZqsiX
         ysAo9BQxYgh+WzHoROHqtVFLbkPZK2GKN2VuVVi+fQArscOltFNa5wjjA/U9qKMVLKOj
         mg99Q8HRKPwUD6IIJz8hijXxNiCtCzAnI3THK7WZRfvuLGkss1BPI+L71Nnffe+pI/Ie
         GXzRaHIa6crSRBY9yxYqAHekqSz6tplOUKWoUFBegghGesEpH3nFiI/xh2DDkXKY9pSB
         oyHl3iYYSswWGU6H2tUeAhtDj/KWgVUB24AbaWjX9YrDTqOdK/a0Pk9a6+GsGDSbWfpg
         dkrw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJeqK8RiU96IU+8JNAFMqtpsIzKsQfucIQy7j+8YRIJAJu5ZoPCgIOZvADMFvRXQ7Qw2713jsuNL2EIVjTl9aYcteJQKrzH65yjIu
X-Gm-Message-State: AOJu0Yxnx0oMQvp+9KaFs44UBSatOTXvBkEtbOLfFzqv5mDevEkxsgXH
	9OzFA6RlBy3feuuMwfH53EIDWBA8LepTIDE4HISEKj67Ja2HXSn8wGJxL6Oxk44w/Ie84NZZNWJ
	ws+41VeIkdlN0AxAe5gqLyZEfUl8RPK7ZvJaJxLOdgQkFGhPddem9CpY=
X-Google-Smtp-Source: AGHT+IFKJarv6jv6qN53kzHlc3UwfWgnQYEsSs+ZPGBExF17fUlgyH6YqwTwHxjg9xTKaWtkvH7Tr48NyQL9IAKFqYZQLVrCMVkv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8917:b0:488:9fae:e95c with SMTP id
 8926c6da1cb9f-48958e02868mr3107976173.4.1716265263041; Mon, 20 May 2024
 21:21:03 -0700 (PDT)
Date: Mon, 20 May 2024 21:21:03 -0700
In-Reply-To: <tencent_FFE5365E9608362A4B7474FF76E567C03C09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005823230618ef25bf@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
From: syzbot <syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com

Tested on:

commit:         a5131c3f Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1564ef84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e100d74625a6a5
dashboard link: https://syzkaller.appspot.com/bug?extid=efde959319469ff8d4d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12057dd0980000

Note: testing is done by a robot and is best-effort only.

