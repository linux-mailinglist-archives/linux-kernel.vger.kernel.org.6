Return-Path: <linux-kernel+bounces-262102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC793C0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB7A282BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438B1991CF;
	Thu, 25 Jul 2024 11:27:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61F481A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906859; cv=none; b=beMvQjSjv8Yda9Sb/p+KPXTX6Vt9hrCG4TMdswMhDhG1pBRZH8he6kByuwQGpiCBT+VgS04DkSvtksBG+D4Q/qFfS7b7KNGeWMK8UuKagjz/VezSBcXLgtZzSx7jyCVK36p2pxk6N6vztxs2BtvjQNZJjBJIV0gHTrRF9DIDkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906859; c=relaxed/simple;
	bh=q/ysU9cg8jYRm+8hfANGwFbsQq7VFjX2FCB0xvE+4iY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M3ob/ZxuEzdNOAbq88FAcwauieIx3+deCnER+XJNbLxnyq5m1gPQ6KhduoFppVLR6E+itmBGFCBKn9YMBFfHF1c19dW0ON8KFc/I2krBwPsbcrFOYJLwwG7U8ScSY9n5Gm+6WrKEjsxJjB/8PFd+SS3LEo4dMfL7hD6P+MUKfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39696c3f2d6so5685695ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906857; x=1722511657;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd/d5Ug6swLIb4pf47yLWm9uS9LlD3WeYFnzvWtTcKg=;
        b=GI/3ugiGzNR+zS3nwbpnthVL2dgqLa4FRwIRf8O/C/bd0uKFNCn4BVaaRBTUUEOlyP
         JhJ3S+lpTEHk5Ez3dycj8NYqSLcHzNPagkZ5oWUjIJuOHhm+3YDiVMghoeNzea5B0+To
         DdXnweuj9AYkFCqix1T65DclK6FJDs9sRmya7BTc9OvJeSw6q8nycW7llJcet5TjSa2h
         E94NScgwtEjmMpiCRVbxgcifvqJjv2rPMutOQPuoNRuiJXFuAO4S86YiH+AiX9Ge2SJL
         5pT8UGoNSjNQ5E3I1U3gTGv4JOhgJ56H+Og8gpgdH9erhbBg6ToSOzyiXNUP8+72Z4bq
         Zynw==
X-Gm-Message-State: AOJu0YyGNe6zN1o9vDqd/nmSAg6FIP87/Aoq8/rUxkWIYx+Os7Rg0J+X
	0dQlu42nS8E7NXrRzKfrDEw7g17ojGWJ3xg3Ta6hEzPkSLR4d+aJ8ooyYTGi/Ytu25b++RZ4a6Q
	aLGchM3AIc0M8crna9r0OBrSlVR0pxEUWVVQGvmDMbJehfOV43UgMnnY=
X-Google-Smtp-Source: AGHT+IE2v+sGRVJQbZ+UFCsiWmgjAw5aDoiw86ecOW2pHGQ3fDHb1LqQfEiOdOBkJhf9nDkMjkgA3RUnZFtSJmY9OGlQzbN9dkZ9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:396:a820:a62d with SMTP id
 e9e14a558f8ab-39a24039b06mr1587425ab.6.1721906857359; Thu, 25 Jul 2024
 04:27:37 -0700 (PDT)
Date: Thu, 25 Jul 2024 04:27:37 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091ce4d061e10aecb@google.com>
Subject: Re: [syzbot] Re: [PATCH net] tun: Remove nested call to
 bpf_net_ctx_set() in do_xdp_generic()
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in do_xdp_generic()
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

