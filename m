Return-Path: <linux-kernel+bounces-319755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C83F9701D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F141C21332
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DD15697A;
	Sat,  7 Sep 2024 11:09:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBA208D7
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707371; cv=none; b=C0EAbEmP0vY/sbL9DoGtC09GaO/V6BImU8ahsqyBnUCQaHF8iD6xib7JcLMsJzRXcM6uYV6xzWCp5+0C1CMeKoUc9yvmXOSxV/s6BHsdY/mt3+qzSDpw44Zbf6j84nMHZ45TsFpGZTa6rVTvneoFSt7q8SRekmuGFOaVPgzVBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707371; c=relaxed/simple;
	bh=BCueTk+p3HTkxSBE+HoDMy3bH6hAV50ewzaNywNVUGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kIRxmKs9g3uGd/IdTmEuemsIPXD0Z1ALibBEKGL+K7r8dEc+UwDdFdhdHEa0vytDvfluwgGDSNUcmEFVn5ohjdoQ+jBpZxz0O45Ydx94YsuXTwkkK9T6kL+pwhpbVbUB1rWpx/G4PvoZmvmnrsSj2nfbyxyZKx9Z7UhEqaCXmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f5605c674so60648615ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 04:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707369; x=1726312169;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1/UoRnDTtj5J8wWfUjGb7Zt43CcKepMak7hh1B2g98=;
        b=u3//bLJCRC49kURjMo/1MiYEl4neu8JSm0CKYu0CmkPDWnmGdsPR2ychII+q8EdjFg
         88RbE5ntvg1FywYrciiCdE8gfEwMjFwKe3gV+VsQOcbSM+bACtF6t1C+Jo29LakXfcNl
         zGjHCzm5k7lLtfnvfPQ6fkfd8YiV0sXNtlchaSwyMQ10DoLHZzrigLpJbEfFkjd1l7U8
         yO7Z+4ozVKb4JV4KNwTjrRaLpafuvDzR0+KQAlCQ7RlRcuzqzUekSjB31zJ19Me1Rsd3
         YEDLBpl5TRdn+gNV6O4OlMLjqzEwjwxOk0dR/IR++nJAqbXvMzGxFA9bhlbf89NesOC7
         rbVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xw7UwNSHk8fUSx9H32qLg6LwH6/wEq3smEeIWNjnDq/01ReK9QSj1y31HOCRuX8K5edrADLwq+SandQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CncfwsH6t/e9EdM0ZOg3P4t5mp3pus8cGwxfdEvzc9eMJa2g
	L84EvCfGSMrE4P6gHu7Et+s/QQrCkUrsPFIRsZ+f3lIj7Ni29l7tEDn6f0ng/qB6ndIc3LnYgXi
	+ujMznn63aB+CwfmdIdJH+jVNa28FEhNC499VCjRXVPZTdkLRYKIuSe8=
X-Google-Smtp-Source: AGHT+IHRBUm55l4CMd0Iomfht2mqyI7+fJk6TpiMPS3s+BFkIJbt3n16hYeBilhmK/qO6fExmFp3Avw940LCVm4ooVEjovdNB7NK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:3a0:4aa5:5235 with SMTP id
 e9e14a558f8ab-3a04f10a955mr2078765ab.4.1725707369117; Sat, 07 Sep 2024
 04:09:29 -0700 (PDT)
Date: Sat, 07 Sep 2024 04:09:29 -0700
In-Reply-To: <CALiyAom35=FOaBTWuqT-vta9PFuQAshkq6CkSJirK62oxuo7VQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b90a470621858e8b@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: hridesh699@gmail.com
Cc: hridesh699@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This bug is already marked as fixed. No point in testing.

> diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
> index 48d7d278631e..2e2bb22e60ea 100644
> --- a/drivers/net/usb/dm9601.c
> +++ b/drivers/net/usb/dm9601.c
> @@ -10,6 +10,7 @@
>
>  //#define DEBUG
>
> +#include "net/net_debug.h"
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/stddef.h>
> @@ -222,13 +223,18 @@ static int dm9601_mdio_read(struct net_device
> *netdev, int phy_id, int loc)
>     struct usbnet *dev = netdev_priv(netdev);
>
>     __le16 res;
> +   int err;
>
>     if (phy_id) {
>         netdev_dbg(dev->net, "Only internal phy supported\n");
>         return 0;
>     }
>
> -   dm_read_shared_word(dev, 1, loc, &res);
> +   err = dm_read_shared_word(dev, 1, loc, &res);
> +   if (err < 0) {
> +       netdev_err(dev->net, "MDIO read error: %d\n", err);
> +       return err;
> +   }
>
>     netdev_dbg(dev->net,
>            "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",

