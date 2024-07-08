Return-Path: <linux-kernel+bounces-244666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679092A794
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB921C20ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB79146A77;
	Mon,  8 Jul 2024 16:49:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2F1D69E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457344; cv=none; b=bzpieWTH9P4g4PpxLKLNvk+W5lQFSRFeW9vYWES3TRSY0MNlAnEuhPJIq/H6/n6gGvc00sKCY8ymWDnBU+AD5fXP42SS8tJTDRAFAycQ+VV0bfa9pJowG65bTr6Z/QL6pzkwX+h7i+v4RX9NZax2ITqCHQF6wNNTmogZ2d4gFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457344; c=relaxed/simple;
	bh=wxbintdwPXGpmWvSpfQattq8f4fcjNnZYqBXJAqT6vo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VzLUENye4FNFw9Lw+MQifxbwb36ZpSrAMCF8hS4B6UsM+ViDX+BpSlkOraHCCKW31hGBHCCSMw4f/0XrdUmWYMB0RdffOF2EXWhAg+upwNSNQCg+8+bgP78v6vBOya2NO6c83VuyhVkppZJb0Chkxys/LDzSNZyQ7pFlwpm+azY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f639551768so520888739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457342; x=1721062142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo4eRAmAZGnFdF/C2Zm+pUi5KIWTp2C57QMYUt3tGfE=;
        b=IUAJQPKUCvjeDBLXmyV81PhO1OSXw2nI/OZYsaV4o9Li32OPuIK2BB1hNiSSGqC6om
         un/OstGNejOLO6inn6jub6BNWp6GvxJbb0L+ug7OKLRsIE1pr5DMflRKTBroluL2f9CK
         JZd3k4l9IpkA6AvgsLvpjI45QT4NrjrwT9GICKaOfJMv9AO/dd2obmGr+Db22om+LKC2
         06S1n5f0einlb+kGgy1qEY1DvolwYedEyEU/Fg3RTgaLyCVKlysbsUtPJSCzgtxITn06
         382uKj8MdOAmwvTlFs7i7fTTo9c2XolpycyPe9zvN6D8RXwT1n9elK3ISAmcVfKAOEE/
         pHLg==
X-Gm-Message-State: AOJu0YwFjTUwkHGMImeQgiIZmQweZqxPOQk0vRNEIYKXuxgr8ZP3rUr2
	dcA7cgCaAFCqhTqXumUnUy4XIz3xUR2PWOWGh/iB/Kl9AhaJJbs2q/HATXf6wzy/5l1lRF/aH6s
	CqBzfSlvXnV4MJyXfRqXVqgoaIPtFczV/KZlRn4If96ZGdv49upIbRFM=
X-Google-Smtp-Source: AGHT+IEYjyDIKydf/cF74jp71sEB4MB250/6efwvzKmZJtghjQGayc6bGf1EFLKhlbNZYY5gl1snmiy7MYIe99NIUV8+4faqFluL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1548:b0:7f9:90c5:410b with SMTP id
 ca18e2360f4ac-7ffffe2284cmr912539f.1.1720457342044; Mon, 08 Jul 2024 09:49:02
 -0700 (PDT)
Date: Mon, 08 Jul 2024 09:49:02 -0700
In-Reply-To: <20240708160329.1868842-1-michal.switala@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b95d41061cbf302a@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
From: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, michal.switala@infogain.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com

Tested on:

commit:         83c36e7c docs: networking: devlink: capitalise length ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16870566980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcd1b5bf2c3bc3ac
dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d5d87e980000

Note: testing is done by a robot and is best-effort only.

