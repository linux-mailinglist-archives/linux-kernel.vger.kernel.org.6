Return-Path: <linux-kernel+bounces-198615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADDC8D7B07
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE31F21911
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6D219E8;
	Mon,  3 Jun 2024 05:42:47 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7736AF2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393366; cv=none; b=lbRQhkyYn+qj7Hvdp5QSFbz1wPKaIdS/B01Yw5dKovgJfLSkfvoDM09Rg+B5Vyf9xxm2WR28ZxMIt1K9SZJBcGZSohyo2tymVANucKC95GDToIrjc66ZboRHAsbu8ww7LfC/PoHqJTzP+gRupBmgUoWxX/Splhwv5pneAAS4UA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393366; c=relaxed/simple;
	bh=61ixqgz3TnH85wNXtukmWpuOwKhxoFWTmei/1VVi39A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oqze5Xy/pw+OBTtFK4ukiaU9CeOhE/ppJI55gGa4kZtvwqKlhwWeYALZFS+I3YpElbYfm1tSWq8seO+7SfgWZFYFhOWnArEJp5Z2T//yfSNXR8w8LLOMLru3qc4S2WQFbZPS7VGT0nt57ra0/8XUX7DwChgabNRCdDdrkvQZV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so534163639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 22:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717393364; x=1717998164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPn5AQnCCjUUvOrlZSBRdqFWxupWhkgajfe/IMHh0YA=;
        b=Y3AdaMOwglb4gBiGY9towsB+mdRiILuzZVK6mh4HTAm1kZKvk8xT2fRZuODtS0rrHx
         b9pu/UfdEMPbL1P01wAyoiEC8ScsW4XUr8/PtLXjooIZI+VxUG/sc9Q3eY3OhLtkewK3
         bN35CssbriEBDBpGKl3PMDj5nkTd48rlv7ZBVzQIeJEOLpV2YnlB2mo1zQe95WlubA0r
         CobZVBkUic2n3VzLhSB99FbJc+N7vLnh787Q4KSgm+9OrU+Pz1KnRxmSwhWCcpYThDhZ
         9zAd2T5gZ90ZpM+7kmnXXifoNs90dOdBiLaUEQ2ynmcFNulVNzjheX+G+twJKbeimztO
         EU2Q==
X-Gm-Message-State: AOJu0YwTFzgDgbuAZ/1S1FMf/PqClC8dQ040GYjIambGHCv9GEM5dwDb
	/PLcxkmyFKBtLQYaDoLIPuRekf3Ump1TGEQsRqCXYIWyU6+HEMdnsqnG0LHZdTf+LbrTi6Yctck
	+EbW+h0Pfqv8/9s6qerek58EA9Dmro9oe6HMlAV2bMNeXGxpsFLSqUFA=
X-Google-Smtp-Source: AGHT+IETHfCcMvQ+3IUvj/Tl2pcQEUqPED5RYZb3jJ66UsTNw7v4P+1Uyxi8TXZmxRQAkLM6RbwDWdqVSCaavPH1aL7oD1PNgOVN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1a:b0:7ea:ffcd:c856 with SMTP id
 ca18e2360f4ac-7eaffeffeaamr35844339f.2.1717393364518; Sun, 02 Jun 2024
 22:42:44 -0700 (PDT)
Date: Sun, 02 Jun 2024 22:42:44 -0700
In-Reply-To: <000000000000a82e6e0619e9c192@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e98250619f5cd99@google.com>
Subject: Re: [syzbot] Fix use-after-free in udmabuf_create
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Fix use-after-free in udmabuf_create
Author: nightu.pwn@gmail.com

please test file uaf in udmabuf_create

#syz test
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
0e1980c40b6e

--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -382,6 +382,7 @@ static long udmabuf_create(struct miscdevice *device,

                kfree(folios);
                fput(memfd);
+               memfd = NULL;
        }

        flags = head->flags & UDMABUF_FLAGS_CLOEXEC ? O_CLOEXEC : 0;

