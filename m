Return-Path: <linux-kernel+bounces-314037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D696AE00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F43286ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA668C8C0;
	Wed,  4 Sep 2024 01:40:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE04BE40
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414004; cv=none; b=fRjUzRfgwVqKmZ4atAe3KljHcQd5SxtybRCdVmDtB52EiSpSyWCXEiI81cuEWnXBq9YKoUnHNTrA+d8RewnNMKvk4EEPv3ACWn+6AjjC1b7eZHjB9ifdkBG75xv7GPKNbDB3/V3DFZa3wwpRVsRoOQW0/ocOo4hEPeuxnjfDAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414004; c=relaxed/simple;
	bh=LX6Nn2J7Gn6w2QsI6dfaOTd6ANUkwJAbXeg9dMrEg5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DTKsDIXSODNqy9YM563KoS/YQivy3i1q/ojqslVlu1dMsAVcncNwM5Tu0i0TdWlYua+RlOuNyIsuJRH9fhYFANMbgychfvTx09HwCDuPEDr3SjjBTjnsTwBW9RMhwklLRRXy1nKktHoCEaWhSqrKWWkI0JHXvt9zqyhDuJCHeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a338f090eso540570039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725414002; x=1726018802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9b/9bPBq8CNIg4Rd0AYEmAEdGv0quvqp3NFZJqJL8w=;
        b=f5aliiR05WP+eYguA2jWk/dnzbJw3ODjZD1AVqK172FClizCcR3YJieKJ1Q5xW0Ak3
         c7guWBzdwHXVBhnS0D6o7WKe0+QmJrtTlEoVQqIMFGQGGbb4DVnJdrBxtcUYkyxvF+bx
         hGsJeSjeb3OMqbBmCLd3Zt7tjvcDvUSln3MvmL3b2EQAjfNFWIM2JoyAklEONoh/THHo
         Y8o0/g6dC2R8QNIHcwoKrcMhzV+Wy4iT1U8hT6oqnw/+nkWKXzmEfuIxPNbi+zPQ/sut
         sozTu1a7vXxZUjxrB1DUUvTNgg8sFwBtJO4mY1CkeBftvx7DPWL8ktiBncQnihS4D6T0
         4T/w==
X-Forwarded-Encrypted: i=1; AJvYcCXXW0nXYMKfe+d2QNgRO9iZFj0bnqBFeCtePTqvWhquKOJvT9wQ4HcrqskfgFBt/J9elUVfRfA0u8fTOjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIb6zBlZ+aAPXCpPjaZIT1/T7pPJLLssUxFZjRwfl1tXir+/V3
	lB35McnaZO5inbQ+dJRCQzkDXdFBE7v7AVtC0D5SpIm6sMnBXpl4kB+GFWdkANxnZQFyOf7ktYt
	/rzjbpObKSHUScETG5tVJzmLpFsX7x36bv0nFmb7PdK3dqr5rNVsHuVs=
X-Google-Smtp-Source: AGHT+IGVfXEspsI+w1ZMwbAhX1kWvSJiXOw3yxhUVlHinJVijRBXC009vTQfGjbFSyg9jQbgGIHm4f34B8T+wp/xwNGsMTcgZ82r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d82:b0:824:d6b8:8844 with SMTP id
 ca18e2360f4ac-82a262db7edmr77724639f.3.1725414002131; Tue, 03 Sep 2024
 18:40:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:40:02 -0700
In-Reply-To: <CAG-BmocK+_d1SA3Xkz0KJ+3wyD1YQNL-EQGwoDcSLvHkfMc7TQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0195c06214140c7@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/btrfs/ref-verify.c
patch: **** unexpected end of file in patch



Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c4531f980000


