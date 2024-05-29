Return-Path: <linux-kernel+bounces-194378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29018D3B42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A828A21C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB1181CE1;
	Wed, 29 May 2024 15:43:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AD1B947
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997385; cv=none; b=C2d8E8YkA3BoT1B8qYyCnGyZQ/bUIO2tRE4DFkgwzpxA9hrTPKXgHRxmOcVOvc21bZ6pMaHb2eXKfGL6HdvYD477c4dKPXjJhQPXfq7bfUZBY4CZrBKdwUknhts+c8/M5ELjmhxtKVTlIuv0SMMIgo1TAnYBz0RB5l6T9dPU+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997385; c=relaxed/simple;
	bh=Tpqf4bdpz3oMCSpv1spt76OidEKz7BlTEJl5nQNyJeU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VF9m6OOOvCcUjMP4Q16zBkk1dhcD02oow5uann5QXMNx1ita2zhPC7TNdP8bgWANNNllLYEwcsn+fFFBSUjvhikQYtWxH2c5oHUAfeRA2hlLvTC2MwEtwYsaNIDOIyBr9JP2f614kuZzzP1HPqIm+ntBIrVrKdagWO4GF2qSMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ead3d6a782so196431139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997383; x=1717602183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpI8iKy7icmSl+K75JXmBzMscWe3lxcEvx7d28ejJsI=;
        b=fIOv5dMXDAEw1sVEc5tghcVrWfUgEMcuPrVIgqeZYGgDevpHSxcEBxPw9AQVzrukYA
         WkgPq6Qo3TOlRDO15c/wZqQsN/hMJFHODfUtmXq8NPMw1vY3nJxoeitpMspu2I+gZsPA
         XUSTeExSSBnXBqEBquKgVOT2UaHrqljHjQsAA1TiIgKGyX6D1ifLD89RD+OEo2hI7Q8D
         Ini1FzUtQFpEPizCQd/3Qz0FE0TwRpzHDQb0o484aeqOvlOU7651pYXVWw1Il1GfDjmS
         zHRhCogjUN3t9G8FNSVk/KYPb9s/96t7bpnYUfd6gDJr5moIZFdclIwbXwIUbQW9hm69
         Kfgw==
X-Forwarded-Encrypted: i=1; AJvYcCWUga2UT168AhM2iGPOuxLoR8FCDP9EW7I8eNtPr92juUWt7Z+ev7UeMh08uGS+zuzxLMUkVmcJXrWlEH0p8WRK90c8h2vCRoBMWfBV
X-Gm-Message-State: AOJu0YzUGafmHIP8QbVCurPzXFhjj9Rd5lo5I2878z/n/JS+pPhYedp1
	ua1Q2C3b5pRcADMW7RsfT3kW0owiNvhczKRfEiTyJ9mcFp/wcWdmbiRjy0gC9KnygFV5dG7JGOH
	ABit0FWqvSFScd5GDYN4CVfhbwyAM7PzpGPdn+bnFCEBhOg0x6yLXJK8=
X-Google-Smtp-Source: AGHT+IGw1QZeoyZccPKLhLHbLjCRhb5oUTLfVWpEsrgABoGFBx1LHSkJqJr4IdXkXSS3GIJg5nDwMjxaB9oSRV64kGo3Ck1XQn7M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1601:b0:7da:19cb:1c7f with SMTP id
 ca18e2360f4ac-7e8c1adbec3mr54742139f.0.1716997383400; Wed, 29 May 2024
 08:43:03 -0700 (PDT)
Date: Wed, 29 May 2024 08:43:03 -0700
In-Reply-To: <2afuizvfwythsdbwfiz7hdcpi73znr354bcuoy2hjux6et4u5p@mustf2czcn2x>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e3fec0619999bbd@google.com>
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in try_to_shrink_lruvec
From: syzbot <syzbot+17416257cb95200cba44@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com

Tested on:

commit:         9d99040b Add linux-next specific files for 20240529
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1530a9d2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735e953fee00ec19
dashboard link: https://syzkaller.appspot.com/bug?extid=17416257cb95200cba44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a1650c980000

Note: testing is done by a robot and is best-effort only.

