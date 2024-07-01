Return-Path: <linux-kernel+bounces-237082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4091EADC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F2DB21BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3F171079;
	Mon,  1 Jul 2024 22:35:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E701366
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873305; cv=none; b=DO6+HdpxBUTH4Bxs7nAjNoTyiB/4lef5g8ag13qpaH02gMspP3kfa1UYiEmWYJRkaJ1/lOF1XKb7H4z91a7gfi0JrlfUkVcSk14OSudci535An1sKDtdVJ+2UjbS95BoXOevvLcjovnmgdWKwrp5/g2d889mlPZHfpKuIAMAiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873305; c=relaxed/simple;
	bh=ZwnJ812bWYfessAZisEV5XjB6uf335uVrXg57V7ELT4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EDXEwHvNUsfZEBBi8MEou8ejnbfZtG9oKMOTC7kqr0VVHRXmZzcZ5MZqHtr/s6UwCUJ98JWJriQRAFpihyGsWqCELtgIxSDDgoyWkwIXHn8iqUhwxOCc/ANqQnveH+NUsR1iXHWVfvLQtgCaYul6dPngdZ+1VfraQByR8GI+72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso376361939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 15:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719873303; x=1720478103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKU/p2SrUpG7b9a6JmhhMra6cEWx3fSBeqfE3gP2RUU=;
        b=JCvn5L18Im5FSwaRZXqFN2jf8rnIHlVmZMCUgCUwHEiu773Wwa6PTNONl4M8l+jYwa
         38u5QG54z2cVu4J/gvE2Zh57ASh0zOVqoSHyhW6r0PL8znJvrxjZbHza1PunxJio2h4A
         9Mh25OQENx/ZvE5Um4liLvVX4iITH1lnv4L9Ui3w+LGSsS8UMPN6gip+X/PGcLNpYSQH
         XeIbKvLTU68Srwn+bf0Cr3fbKWThJanHyLzFn0bBTWSPmxhNyAQP+4s15ZWWbs2lY9Ie
         Scz61frvEViAySEGccoKegYZhBLUqG+KJWaU/Pxxasr0oI+iG6Rwhjbg2m8yCwwG0q4Y
         IO2g==
X-Gm-Message-State: AOJu0Yzzu04whZOZ/UtfOMS8pIYVYayi+ooBFyMD2akvKbbdTw0a++An
	cf24wkocfpQ2GWf6kJ3+AIaFPYIgHFIv536Iu1rYUo+/UcXZnJ2+FAQ//F1ZO2ZqM+IzxyxQKVa
	NsiCIfWSDSxXIH2Z70xBWOEXOG/X123QoDUXI2kamrWX6IzqnR1Cwds0=
X-Google-Smtp-Source: AGHT+IFpMjhuJFPL+hWAnP3c5quSAH0aQO99Abos7uNj7UCVaCFUolGTYfM3aPzR85bloSw38RnJgTqQaI2n+tpFYYa/8+ibQkxZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1696:b0:7f3:d731:c6d1 with SMTP id
 ca18e2360f4ac-7f62ee18504mr50529439f.1.1719873303554; Mon, 01 Jul 2024
 15:35:03 -0700 (PDT)
Date: Mon, 01 Jul 2024 15:35:03 -0700
In-Reply-To: <CA+LQOUeqBUoayxCX+Qkmf5NrEepftimrTySacg=G==F-V=nvvQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051388e061c3735db@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in decompress_lznt
From: syzbot <syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mukattreyee@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/07/01 22:34:14 ignoring optional flag "sandboxArg"="0"
2024/07/01 22:34:14 parsed 1 programs
2024/07/01 22:34:14 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         73e93150 Merge tag 'cxl-fixes-6.10-rc7' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10221c76980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85e0ccada9ed7307
dashboard link: https://syzkaller.appspot.com/bug?extid=39b2fb0f2638669008ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

