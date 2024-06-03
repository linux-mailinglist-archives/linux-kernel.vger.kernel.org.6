Return-Path: <linux-kernel+bounces-198626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C78D7B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB91B21722
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6A028DD1;
	Mon,  3 Jun 2024 06:10:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D920DF7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395007; cv=none; b=HeFXR5fFQ7DkQeJnpWxqz628v26oaQFjiH18VO5LtHhp105KKXx7pNLUO3Q42tuXUW4zkcJTENs+Muv/ExzpeSXkM8L5K9vvEAeU9Tz1XbEFvyjFdkHBDpFGuYX6x7SHQH3Wy8fFgTBxh0ez1O9tkKAM+CqSkwCJGH5G//83nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395007; c=relaxed/simple;
	bh=OXpp0NRX7B7Hkct7kdWr5aCW6VZ+hYOhe1YPBCqD7GM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HComTFECs7dwnz4Q7zD3bx1qthstN9+ArDa7KIs4wW1iKsKUWLb4RiJlvFwfWZzGJ/+nDHHU6LNROikOMphvHjaVY2rvEbV/MXm+cpsH2UaWmMuarbpjV3rcfm55xPMVSkXb+OlMUbCoWKjdAQcBgVzNkLAnlGgYPgyB29+Pf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374914d7836so17827885ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717395005; x=1717999805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl2UGl4Sha9acyHkeA4Si3O7QvUlxJFA70RCFNZ2FGA=;
        b=N8lGEo0jVGM1Jde0/fJ9LZq3DXDMVLwdt2NuX+geA6vRPwll9EeFNyzAYDoYSZHaSL
         0T507At2wteMFziIBpKrklQOYKVefUYhbG/uAavr5/SsRg0ThErFUSIZdb+bYyChr6in
         IMNz+0J0aMCqFq4O8hzaUmPnPmsEGq/ftaQ7Nhh7ZIqNA9TQyxtYByE2C1tdwuLclvWB
         0yUnaAFewAYJfSfBmtPKAc/yaxgBsKIoc8WnzYu0KriFLojY0kzb2CfoIk5/5JsLoVtl
         DhLWbF9JtqFSTvczq/7zv8QsPDWr0eue/YO5RPVA/kn1SwXUGbMZGr47qa+FeeP6a6gp
         FPYQ==
X-Gm-Message-State: AOJu0YyDOQKabgKQ38u4IBjrSBxP43XJ5mwSPITs+gEU/xLFwSEmGjsH
	Vr/W2zmuPjq7AuDvy/misIR7gKJU4VhdzO0GWInFfpnOUv+wNhlRgwgNM/i9VV8tOUDNdSSL4pm
	IYskiydY8TEhRH51+rDclLFGrcbpu8aV6DiCYbeQlwhBsFIk38sM627g=
X-Google-Smtp-Source: AGHT+IEA+uAk7TL+/yMYUp+d9PMhqZ5bOzPSQjTcelAftnuLV1EEMetI2nQODSIScCBHtlRsgnAryPzIL5CVUhFtuUQL4AhSTh4s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:36f:c675:fe8e with SMTP id
 e9e14a558f8ab-3748b9e5cb8mr5770125ab.4.1717395005298; Sun, 02 Jun 2024
 23:10:05 -0700 (PDT)
Date: Sun, 02 Jun 2024 23:10:05 -0700
In-Reply-To: <CAN-2BNRaHxnr5_nJ8eu1h2uBYOFnSsRJF=dpvscvO7H=b+mX-Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003aed000619f62fde@google.com>
Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nightu.pwn@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/dma-buf/udmabuf.c
patch: **** unexpected end of file in patch



Tested on:

commit:         861a3cb5 Add linux-next specific files for 20240603
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=b2cfdac9ae5278d4b621
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1106fe16980000


