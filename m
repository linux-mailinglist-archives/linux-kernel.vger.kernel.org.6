Return-Path: <linux-kernel+bounces-334797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE697DC45
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898B9282696
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5A153800;
	Sat, 21 Sep 2024 09:04:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E6F9DF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909445; cv=none; b=s+Uwv3bZ9yLcOYVmFbs2/a6rH0IwZzO7NM88I53VTOOkFqTukO3rZ9Pc2HuGf9khl5Xn09DC3yP3/cuQCD3qjxvIFamGcfs4MOqVSADnX9DYc3PAh8vLHLWqadCU7DGZTaPzhMN/ikcoRz1up7bTw6pQMatSodxCSSWIWpDJDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909445; c=relaxed/simple;
	bh=FjAXqBOq+CPPb4BT+P79g+jjcwids8X+giETE77YKlk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EMXzdY3jn+t0zHH8cEAwq8QQy9eBC3tOUsTgWoZ+OS9pqCVFGkZ2tGUo0LwBcfx4T9jVLd54jwnsjkWxJWZWxTtlfTz1qOF8r7Co3CYUVTAK4/rC/jQlFKRsL2VhUTp8DU8bOY+KD0CH2szG4uyjSVgGDABezcz64Fr8TazwB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cdc7b7debso274554839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726909442; x=1727514242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7C8sUsknAKI4dWXYDaWFFCB7+f9DNSi3s450iQOSGo=;
        b=D+d6cpPLdJNkV4j100SzLLzidA2Pj+6sd0NSr1IJ5SrEZ0UHyXroiO2v8hcj4H2VOc
         7kOQ10eL2P4Doz/fKV8bzbcFzI2JKA/VyWcLlgse0VX5ODp7Zvb8gpLaeJ4pVxTtHUKx
         UTL2ntodZBiTK6JuvW+s/OmG9SBUjjLVfHqmULOfgZN3uN5oW/QPQAz+gAQlm4phINSZ
         45Ys5wGnMXhrJ6qqy5oNF2x5owO+KYREMOqv1NvDoZa08RujEuqCajQG0GE17yQ9zGsu
         oIml7pJXbQZroPXMDKBBihW6VEPc1rSjUhMXE1YBShhPvKb066jrPb4bLI9e7vENZ6zd
         bOlA==
X-Forwarded-Encrypted: i=1; AJvYcCWlMva+JzU5m0qA7872XaC6XhGeYzsXxYikbKTpqC03MUK8nWAgVBAL0eN0gX3pdl33gsw5WaWcUNA2x28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalzZW9+hUg3tSJTJKiFw7RbsN5DbpufzasKFlBapOODKXL/pD
	n0LAd0X4Q80JgiVucRzbGIWAQv1TGxyB6GkJBcz/wtiKH8XT6qwhpvc1+iI02thEI43+otIYdS/
	vFR/pYuyOm2R9KK4u4wVmKYLn/aPe+PUJVuTXpjIj01sy0XJrf4GHJes=
X-Google-Smtp-Source: AGHT+IFtmZ2BIuyp1nsyCOgp/9XnNJTxSSL1J46oLWYLKdYfdEOp9mBn7LRABAD3LUQlw9cg7Wo68HeJm6Q38adEteMKJev38bjk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a0:98cd:3754 with SMTP id
 e9e14a558f8ab-3a0c8c5d347mr50671075ab.4.1726909441914; Sat, 21 Sep 2024
 02:04:01 -0700 (PDT)
Date: Sat, 21 Sep 2024 02:04:01 -0700
In-Reply-To: <20240921080949.909-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee8c01.050a0220.3195df.0044.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/sprintf.h:11:54: error: unknown type name 'va_list'
./include/linux/sprintf.h:13:71: error: unknown type name 'va_list'
./include/linux/sprintf.h:15:72: error: unknown type name 'va_list'
./include/linux/sprintf.h:17:70: error: unknown type name 'va_list'
./include/linux/sprintf.h:18:73: error: unknown type name 'va_list'
./include/linux/sprintf.h:21:55: error: unknown type name 'va_list'
./include/linux/fs.h:2666:9: error: implicit declaration of function 'vsnprintf' [-Werror=implicit-function-declaration]


Tested on:

commit:         1868f9d0 Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d85e1e571a820894
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165bee9f980000


