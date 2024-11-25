Return-Path: <linux-kernel+bounces-421341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3E9D8A55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF41B3C912
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5A1B4143;
	Mon, 25 Nov 2024 16:00:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065C22EE5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550406; cv=none; b=Z+gPN0buruo3xrBH16tF8r6XCAgQvsOxYNdoO7xnTiGyu/pY7mpj820gCCuVqBYgcdbdRGjv6unC9tbk1UAOmUVf6nSVTXtXeg2YYmwPyuRRanqI0uT2Xn4vVWx/jKrX6WMUJjqmkebKtUBIASqEErsO5KwGhhVLlQnMIs4DRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550406; c=relaxed/simple;
	bh=rCA7tN77oSxn4nSUCyaEPhyJDQp/cbJyX3dpxCtfg0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AxQgJEfeHRnQlyn9CLLO0srbViQ8gUA8U+lebZ6vxVaITuuKhxMq+j/LnC3veLOl7I3QyADdc4UVcuF764pCH8n2/V+8EN66P1jApHbq3XCz2EreJLnIgZ7y0+nDBAS104NzmzWh7eUHEY6/R0HbJ9WOU324RLOBSrmY7LCfhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a75c23283cso38219815ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550404; x=1733155204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ5HUgOXbILcqXU+BL8itF7OQWQ7AptcHc14ASFyUaA=;
        b=mbYnYlWzZwcGznL251ra8DOMXWrH0jIbqfBSA7CJhMWuA/cX4Rl7dSJR1tsFcqMvf1
         r4LULSZN3W8ngReYXNn+Y0/XXCnEMKv1HwQRTxykGujW8SuPd4bIK4Hwc5eCMfQzT5cj
         Z8KecYL/0856XQ5T5wlNccR/r/GPXzjBE9bNOBAYex3d13CreE8WC5uyj0WuhlTUSVm5
         7rMd+nTCFwTUSi5VOXddj3/ipFe0TzyLT8SsgU+/LJ1/skx37NhRVnEyC6tZnK8wLEWq
         42CNYczhSB6jdPKFNIdzDR/fvcXIyr4xhGxfhl37mLzEeKT/gDzPdohz0aQXq6Jp5oLR
         d26w==
X-Gm-Message-State: AOJu0YyeQgKzkgfVrnJdzBCRD5KquVrnJnJwwYCVbFOYnCXjg2Qoo6V1
	2ulz9BySFNeKouX4n1TNmhrSdBf2F2IiCgeBfWtKOqQKKK3fOBjQ6+sO81pzfDAdJJrz0vtkyXe
	0QkHcXVZm18CmnaR93O/zYMa6v84H2ygQ8mPI4pYcg4bVL4hd3vTlYys=
X-Google-Smtp-Source: AGHT+IHIb7s4QFOpJPxES8aDXyROD7H+PYUYM8HigaeeIl4gnxog0frKtM68oofnuvMKeonDgmxZEazp5VfDO3rF+al4zfPEfHan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3a7a58b693bmr73872635ab.12.1732550404057; Mon, 25 Nov 2024
 08:00:04 -0800 (PST)
Date: Mon, 25 Nov 2024 08:00:04 -0800
In-Reply-To: <21c2fc3f-e55a-47bb-a51b-b53e5cab1e67@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67449f04.050a0220.1286eb.0003.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in iguanair_probe/usb_submit_urb (2)
From: syzbot <syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com, 
	sean@mess.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com
Tested-by: syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com

Tested on:

commit:         43fb83c1 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b56530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58b000b917043826
dashboard link: https://syzkaller.appspot.com/bug?extid=ffba8e636870dac0e0c0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d465c0580000

Note: testing is done by a robot and is best-effort only.

