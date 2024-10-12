Return-Path: <linux-kernel+bounces-362244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B799B298
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F211F25505
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D414BF8F;
	Sat, 12 Oct 2024 09:39:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AD8BE5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725945; cv=none; b=ZD16STijGgxT1jYzpj4j6gLOWJa/JMMaDtNWIVZqDSAVX7oQngeJMnWteh1yeGGhSTPP1/ozhAw6edADbzlq8AVroCEqeWXw+gJKLDJ+ea9zLcdP7MPjrmql7bd7Mdgy0ykRoDU2QzuAHMxI91fsHh2G9aOciXGy3xJfBNnK1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725945; c=relaxed/simple;
	bh=cbR/N4XjPXJw1v8crxbXfhcBf7pNvKf7ONARooIn7zU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=arDDTtbUVTxlHBFS2u8EJXKpqOZ798BAyUpH4imDpjW9LjUG0wsH8TKDm6OCxMGfhEW9GOd1ZluOYSmTzRF9QgbKsndGWmxW1HLQ7TDmXZFQYXoO6UxwIL3W8JDTNyFS6RJNRvDPpuwUsEis4XRf1Yac6UM2NfUESnDSFD8sIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-835439ecbd3so225922439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728725942; x=1729330742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIEtbSinH1yiJIz5fBHM7Fih60iDpMZZnn2eAwPH0Vs=;
        b=MP8upfyIQX7vDKqVwOKhO1GfsN95UFSbPeeVyyZ1D4RB2CZvBeXTdW18apJ4GSiEq6
         QPxz+P5VpeHoo9zSjpQleTmocjJMI7qJyBd6t3w0Y46MJR/PHXw9o0rf5D7/GGGb0mJS
         iU0QvHZECjsHgQZ0RvBa/F7tseYRhOcoiJx8NNuq9q6O14FIYHXpGBWmpPYmzrgGu/YN
         /NuRoexUP88t6hKcvs00UmeMKSRszYgtCXVCBFVhYLwqEPjKVIh5xroV0Y0kJmeweY5o
         8pvhfYXwzKoUQcX/cMLrAQyHKzbc86bJf+wMVDfQCf+IGaUD02WMGu8gt+gdDFzWG/l1
         jtJg==
X-Gm-Message-State: AOJu0YyDuLxrfjb2fsWgRdupXf/hYoS6FjPZEDLWpbWZgh88ft//Q5UH
	3OcGBQrEGkUMsa7wiIDew0rqyzx9hEVvxPi9dsM/194z310jB7wmlticAdXz2DMraVwL+ErnUlO
	ZhXftTOIZqhnIUq7AuubYMvSI0x4Cjmp0iT9AJxiW4ab0EUeTQp9pz5w=
X-Google-Smtp-Source: AGHT+IG1Zay6hEfDdJjstvdvoPr5NNjoNywFVNd4nHOKZy8ZoTIwSilMNYFuiq1OX0w+C/zWEhkMx+xRFZu8YbS+TfE5INIHtkMo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d1:b0:82a:2053:e715 with SMTP id
 ca18e2360f4ac-83794b59828mr435129239f.14.1728725942468; Sat, 12 Oct 2024
 02:39:02 -0700 (PDT)
Date: Sat, 12 Oct 2024 02:39:02 -0700
In-Reply-To: <20241012091415.2172948-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670a43b6.050a0220.3e960.0024.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in corrupted (3)
From: syzbot <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com
Tested-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17fedfd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=90f31ac02b7ae5e8b578
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115ebb27980000

Note: testing is done by a robot and is best-effort only.

