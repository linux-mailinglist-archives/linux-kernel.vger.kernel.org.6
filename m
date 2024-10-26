Return-Path: <linux-kernel+bounces-382895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E779B149B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B401F21264
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676B15C139;
	Sat, 26 Oct 2024 04:21:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7213C80C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916465; cv=none; b=oiHsk+G0G2BVLuQiPQM99sGgvzAC6OziMcd16O7RttpcTSVYV7xTymqhBvK+Q46ZSEIl5cGwpeVTSyDVL8DAaJ1T6zHSfOhbhhcvMwZweYp1kKBT5vBJcUFeFnLZ96dvn842MJ0aXe4N6dV5YkKKFgm04y+G7eMIlzk5At8gPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916465; c=relaxed/simple;
	bh=Pbyg2SCdQ2qqUtv04NFHNcaqxZ5kEH/SxyJuQT5T7SA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V0PEBuZzycvq6nha+jR030y/w8+I04AMS1POrTrUu8EhvpeINtXEWtnBeLknQ3pc4UAnzTgERxtrTN6ZDV2rqrsXiGZq0ZaGPqyNxFWMtPorvGqCuTbRTcxbvFksUyilgm3clUcys+57qTB/I8dEspzOuVLpb2WBye4k7JuXBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so25230895ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729916462; x=1730521262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3gcCkXBQQlWgRggAy8vJNsOKnItlW6M0FPDFncLohY=;
        b=rlrjEb/s9bZgbtdyaXrDvcHXr2OWlnO47BsDSn6vBp2FQKLa6IUGvqR9eJottwCnTl
         m70gq5zRDQ0yWJCTjloC2WkvDx6nQVSrZeitpivjYZ0tQbpcTiAX2/3D0DkZuJ8wMQXO
         lfLJ1oEPMAVbHsCzWWKkd4okEwzvXgQsfyNRe8BwaMFTmcOEhcRoEKMeD+mpVMXOW1Rn
         7e5Isls1AdOjPgY+gmDABVKVIKOe+0Ybi12/S2XONHIg5jvE0ElYU9ni4Zc1CtcKsvJM
         AB/e2GuwQigqyeQlvo9rFb6yUskpzHwwAAD7jNTnZRBZHart82D7KnOub5mN6Rz1ZYpo
         uQow==
X-Forwarded-Encrypted: i=1; AJvYcCXDFMeTz7jCxCSC0BxhAL/rbjMcjeROGStMzHMve4WQngBSpbsFDssZI0gM51aodJkNypWGyLjc5eoGe+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99+rtNtNrS+hD2xDZ3c1KX5TJLaCDSXSp6TvWlCiR1mKE7WrO
	aHWhpidNZapKT9cBdP1oJh8ZMkvvIo9akhfF7bV0v1Dz3GHgSOzznoeOZby9Y46CRMoG9q7okGE
	GJUzlbrHhpjWNdEI1e/WY89Z1LesK0IR2nPaTgy3e1SivAD5C6SGsTzo=
X-Google-Smtp-Source: AGHT+IHNfk2Nkjjm8rK+t3UBrtBFHBbltaO6zrD43WQec1lExqtVuuFaRsw26OcSKwJNVSBrsXxO336iGvHoeskbdS6BcB+V2TA8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:3a0:9f85:d74e with SMTP id
 e9e14a558f8ab-3a4ed2f6098mr12546265ab.16.1729916462673; Fri, 25 Oct 2024
 21:21:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:21:02 -0700
In-Reply-To: <20241026041908.2739593-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c6e2e.050a0220.2fdf0c.0220.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/bcachefs/recovery.c
patch: **** unexpected end of file in patch



Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc4dac4775d07bcfe34
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c57287980000


