Return-Path: <linux-kernel+bounces-262104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD993C0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59591C208E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A501991D9;
	Thu, 25 Jul 2024 11:28:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7231991C1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906886; cv=none; b=DJQ3Ucr3mWWdwrfUTZa1nm1aCw1oA0+C1wZnuS4GblNG0Ls/uxHrTq1gZGnJXOUxUyzwoiqfnOgo2mgRJLbyd1G5jkkWWvyS57fRxRfd7LUaAk12eWpFPQw9v9nqj4lKIwzAd6JNSEags8z3IYEz6nOo/73B3wZrCqMSHBneT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906886; c=relaxed/simple;
	bh=vzQ2IqNBQJ+JUKHdYC+DIqc/FEIuje8LQJBE+nuKW0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HicbPcYI7HzPO3MRhQkD86JharXjkEDcteeBekmAgiZzrzlStzGJe5BwfhZbIylrwPEGo2/G745r+b3ghRYObFHqXc+D+9AeelAxP3a8bNRPDPg7PMXdg/iNNDLoBWv8nW/3H7S5pVlxovce0MFlj3sXtek1lIIWehOWC4uzpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39827d07ca7so7260125ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906884; x=1722511684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccHCl9xDupwTctiCM3VYLlhIQbiWMMjPQB0T7cFH8Hk=;
        b=KNLVC5jBvjBcUrk0Rg/LCoOLgbv2DkL2NUEjyoT/9FjZs6/m8HUmK7cQ6r0ZrrsmDq
         etgqldWn2smLgnXGcbZiyEh7TSUKjBp7BdT3zdjayTIGsQRtJMQTPtKB/wgu0Va2XzJO
         dqHQXtbAxKL1ORE2Oaxtm8xnUJ8ackmNtK5gUXRU05KDWh8aQHjHBhJjYDKbCq/zTB5G
         Paw2v1/9jSZ4sFEa8FX13jgxCSf+XMduimAFBbMolD1Mx2qpmlxdm6sR/IjFPzaocRiY
         CDamwd3ximHcH2TwCnLpQD6T8Zsf+B1guKSMksuZbOwEVM6YMkeFhOwH5Rj6kYu0WbgU
         NhLQ==
X-Gm-Message-State: AOJu0Yz61IQm7XAKd266X/urNJdDtdPPC74EmQk2bYmNZSkA5YV3G67W
	IhqY/pWPQxDiLU4wzHpTcaLkMiKVznmTKphC50p7vRU2/+GpTOGEH9SX6hmEvfjQ5Z80VplO+io
	pyPkaDdl7ZejUPt7ppcLOpgOmrWVfNBpjd9hZBQ51sZJ46fyu7CKXiJc=
X-Google-Smtp-Source: AGHT+IG+lopujKEDuB/L3BEYrxYHS2x2FEpjQVstILqkpeyrhFCxywRsrM8U9Svu7T0MVKTUTKZ6pVm6PrGLVFPUhfJfHf3jcjqr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39a24029745mr1179135ab.5.1721906884697; Thu, 25 Jul 2024
 04:28:04 -0700 (PDT)
Date: Thu, 25 Jul 2024 04:28:04 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032f335061e10b021@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..a741000c81d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5150,6 +5150,8 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
+		
+		bpf_net_ctx_clear(bpf_net_ctx);
 	}
 	return XDP_PASS;
 out_redir:
--

