Return-Path: <linux-kernel+bounces-214096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A02907F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014BE285B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38D14D2BC;
	Thu, 13 Jun 2024 23:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE45131E33
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321344; cv=none; b=SZtp/ZPKSKoF1acXBg9UanRCRviReBd2QbmC88Aczu8Db5tpPDsqW2dNAG41cpoJ9PJlb+AQtcg7wmKtgIUJzJK0fUk9fOE5cm8bGXjVoOiiwtDVbSpXdITt5gUWAXA7dt7F1fsEz8Ra/NJ8ZvMPd/uJ4wqyyktCFnDugZQgMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321344; c=relaxed/simple;
	bh=8qRkv4JDhXNVbBxzzCAqYqap7zwZhPbwcUkX+pgF4ck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nyTFQEplCxbW/JBxNY40aN7BXI7awgoIpBeMqKlVLRMFZXxgVicoFB4tGkS4Q7Nj8GjSJKemFil7dXgmrJs4HLpwsHObU39qKJgw8d1JI7KUN+k9VAbXZj1APN6O2frwmgx0MA5RDEk93U9PRPWpjaEjnx/eGKYWvHZnVFWyqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375ced380e4so15855745ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321342; x=1718926142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNCFKE8KjRWgs0jjtF3OmdpVV4maq/X63oowejSXhNs=;
        b=vGDtINOy1fWqmQz2Y36j3IT7gI2zqi9+yusxoabtlxpsL5BQoPPGbjepFYWKHdH6NH
         Kvr7lh+MxMhB6DcEsTjMGfuQMk4iBSM5jYr+CZ7t1FVJoEEo7jTp+FgvYE/EBYSBZcry
         4DPqQ2iotFKuaAhjDN1ZwzwZB9Ojw98VRyImhtbVyPGvG1NISOYLIXdDLVEcAK3ZdMlV
         qxzvguqDiZbvs4sDEe1DEcfSiGm2QLemJf8lXl102gJ8A1AW1WRcuNi0TuCy5zbC6FVF
         LYWB49GwAS95PtW8z76Sjw5RClnCNCWoGB6tWouG02HNJ5uDt7OoOOBoVb/jdWrG5XtG
         LBlw==
X-Gm-Message-State: AOJu0YxvdF0hbIq0RvoyZ9F/RLP9ImpirEreAVcg18wQYdYR2gTBY4Kc
	p6zad/z+GWKR+iLAuiaZMgF4s47p70L1IrENHcDz4NjM6OONEUYDZ//DD0ijg9LnI7e2RO8Rzz6
	lkvTsEc1NmlkCcZW6B+dklRw4svV3snK3tHGecGL3eUAVlA6QoxQ3jd0=
X-Google-Smtp-Source: AGHT+IH0wMl0cGmiWLcSxhu41ruXfJkh+q+YfXVjSH21s+UVSrYmpwN0JSzspToac2S43DqDHD4/UOELK8UWTTcADFN0jKFuTvkd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:375:a202:254d with SMTP id
 e9e14a558f8ab-375e0df97d8mr413065ab.1.1718321342405; Thu, 13 Jun 2024
 16:29:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:29:02 -0700
In-Reply-To: <c261e607-78da-4536-95e3-114b5d766918@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000396d68061acddd90@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, paskripkin@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/13 23:28:26 ignoring optional flag "sandboxArg"="0"
2024/06/13 23:28:27 parsed 1 programs
2024/06/13 23:28:27 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         d20f6b3d Merge tag 'net-6.10-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108934a2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f923e2980000


