Return-Path: <linux-kernel+bounces-418482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D49D6218
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59479B28119
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D71DFE25;
	Fri, 22 Nov 2024 16:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3191DEFFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292466; cv=none; b=RdS8BALdPL60wjbTiVrO+c4/bATAX1Hu7LezcrpThlu4veVhhW0DQUqvmZK6pCPQ/KZPS6o/0+x+3+k49l0UidSq93f6PNYPskJY8vf5jYeXbBB9/dxlLr6jIQpw3khDRldpGyegEiyB1rcgAsfkQgxrfnjP1cCxHfkTR0e7j/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292466; c=relaxed/simple;
	bh=Lan+EjKOujOpI8p/J8qm/3IVFHqJlu3pGLDC6Itf0Tk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RhL7ViDrF4YUpDarbqehFfu3HVBPWqDspWQQ/yHZ7QANJqKWqTK59rJXzqHrtXDp4zPV1I82LJuud6vr6MF/+IyKoTv17ehb3Mi1OAxmArNcpMLy48OAgbaqCwWuBi/rQj0hmTqLMRKVyBAu6pzDIgtqLZCUKMlWWlGBq6QQjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a794990ef3so15703905ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292464; x=1732897264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsZoAdmQ+j++X+4wrNK3bU+NDjx3hcG54kcynzaVx8I=;
        b=Ox8YjJIkQW6CMnaoCa6nS8ZDVBk4As4UtGgttxnJQi5yvxfMFbe+wiswurz9HnUjqD
         erk1SiCh+mxZoLCmqKqe25SYA72aAlTe5227MCDrecMuqIUAg/n/mbj5352J7zLfxhRS
         e1wGS+iKQ4TM5X+ISaTv7Ev0jZKZAWlO54PV7hPZQyj88MoCLBJf5rSvkppO9uiFh28e
         3piESBhl0OD725BafbI/alKevhSPFXM3UmbLkT57gw+mvDpjGkEAOfbYuQRqAvN2/AZ/
         j9/57znMTfNUu7Nn8k64UX7pykU9aKecci9tLliAhLicjcNKIb3YDcXHmMatVtPMWO+5
         RTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnSlumbS6rmtt/OReM2kqatLbJiL9gy9mEkS9lGq//ri+HEKrdEC3GJMv/MTdSjSJ3FxjwYy5HqFsUUVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeo9qQvJOryoOCfL0SLlr0M4moM8orYnKrlggZQP4x72VIfeD
	Bt131a6Kdp2oWrn5LhpsPU4x4iZdDt8m5hwuAF951Ymfr3CJvhWEAL4zTodR/o+TW3jGzpnNb6t
	uNj9KS+TwhDRr0Zgho2q3RofiBtfUiWQu9mfHJ6WI/QklQNlwMUVUpzY=
X-Google-Smtp-Source: AGHT+IEivNJ+B/mBn7yxBiwWitSSs8xuulm4vc8gtLKP8KTfcmBIF2UXRGIZY7abdNNZsrgPXh/8wcyKTLXxD3I/HX3QZOaN29sW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:3a7:a471:cc65 with SMTP id
 e9e14a558f8ab-3a7a471cd36mr17616495ab.2.1732292463717; Fri, 22 Nov 2024
 08:21:03 -0800 (PST)
Date: Fri, 22 Nov 2024 08:21:03 -0800
In-Reply-To: <CAPXz4ENUgZteGDF3w3iFLA-Rdbfsm2e4XUYcfdHRgwATk5mF9Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740af6f.050a0220.3c9d61.0193.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: bretznic@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/ext4.h
patch: **** malformed patch at line 8: diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c




Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ea7ec0580000


