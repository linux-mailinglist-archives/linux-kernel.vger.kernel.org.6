Return-Path: <linux-kernel+bounces-380501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433C9AEFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C981C211F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C9200CAF;
	Thu, 24 Oct 2024 18:30:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9911FAEE3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794606; cv=none; b=QLDlB20qdHk4NBl20EThlPxxMuyHM4nKH5GbhgowxgzS4KwtsyIfq8yXhWuJ7+76yrl+EkLzIat3l50ZwoyWjRzTbFwlQ+2O/jh3KrhPctIPJU3OGxL7C0vTXa3g75zhAWUE5s9ZXXKCr8j7p3LSKCY3weeeH2bgg1JKBxR+t5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794606; c=relaxed/simple;
	bh=19oxF56MG/dvkfTzMrO6YCBefQeItzgXH8qE5Xg5IXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTfldLCa2EIX50SubOXuEThA7FsbdDe1iciiUqsTMmW8CIn6mKRexQn4JScCgW5f7a+1C/XrrrmpyctvGHgJ+5JnuaPzHODFGLPoLI8zv7DHVGWnk9OuaMCLcEtlk9m34QDt/ZTp1aeI7ZERVcANb/nToya4MEWp9Yc7TbucCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so11170875ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794603; x=1730399403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULUaI94C9ZBvln0bzmZyACj8nhhqDg+gEhUCA7NjALM=;
        b=DYiAUwni0JPsPHtZe8G9ijvJlnZwvqTYWoySRHVpDKVgglJt2oPEGGrTnPwbHKd4Hp
         GPZeu+fT9KUw3BkqoG5W/ws33fTilxwhHNIJ+mScCNMyzKDbmsLWEGlNmA5kqgfmjUIM
         vSZTZaE0c1ccSBTEwG2WmJeWGmocicl+jYuXY0xnZpr9Zui0S3zUlNEIggxcvteaQscf
         aocM/J1jHM6E2LEIuazE00cRJC5AgZs7MhR18ILxIsMdo6bZRMZ7W7K89V8fbgxncvXN
         72ICQsqfYxFSWyTlv3BszScm70i6u55VffwbA2Wmr1ijxF8gEM0q+57Qc22NA7uAxAYn
         lcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUobgEHOZq0glqSDRgqUQwoazpyOLdmWDFbUaU93XqacgovWqIurT6H12zxar+8w55wC+S2Ele6n5j6zS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ66LdcSC98e5azVVmVpFEdctDo8WcSYHxh9TC7ImFfp8lD0WK
	0di+oZKICtB8ocWebboWJdN0FJJkRZ/9A1FtqCS1ogekStRvim5QrXLQqPXMvYsd2J5cLH9xM1d
	gQBeT3HDtBWFq1OXJj5FkW5IU64NCJz3yHUVIJBAoF6/YYbJzQY8Tz9o=
X-Google-Smtp-Source: AGHT+IEmMEp8gqNAkg1FW3VGCfSSdDQYvCVYgLK7RmSVhogPIsfFu1NBNyfokndo7/24tME2RlO5RSfTPUC/TdocFe/Q5fr/8JjA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1485:b0:3a3:9792:e9f5 with SMTP id
 e9e14a558f8ab-3a4d592f369mr75279975ab.5.1729794603541; Thu, 24 Oct 2024
 11:30:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:30:03 -0700
In-Reply-To: <411d4343-0a1f-4629-9c81-56f7c2e363da@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a922b.050a0220.381c35.0001.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1203665f980000


