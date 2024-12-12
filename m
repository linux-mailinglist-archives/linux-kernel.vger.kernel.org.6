Return-Path: <linux-kernel+bounces-443196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834569EE8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83422823B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA162144A8;
	Thu, 12 Dec 2024 14:22:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A218837
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013323; cv=none; b=lQDTY1jb27XKpdwz/hCQBQZESkU4mteegZaEHvwpZhg1KqKctvNWNPsSGf92ZGDYHzoWHU/XckvmaE7zS816UUvt8WyuxE8h+P7ui8VlqzjjuYaJth5Ztvq6smBIg4/pu+MCu51mDd+JPgQzcIk3GrvMT+f/e6G2EvpODSNFh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013323; c=relaxed/simple;
	bh=y0SkwYIznhv3Mq2XafEAYNFe9fbKL+Xg9cvPntz5wR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uHgYxdyPJLfii9zrWFsmHO+UUA9N6aewLti3O7zs2cUmB1solBB5wyaUE55VHnNSPu63E4D3ZavzucyPBTrWiJpXX1LksR5RT7W7+DeeezdoJvKiILvSxeALq0JqAVB0hcOLjZSa+aHzeUpWk/9Ri15T3SdO5KjBiPq+rq0vpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a812f562bbso12406345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013321; x=1734618121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krPpWBOb1KKBcGCv6wZypBjV8TjcNfSoywJVoZ3tyY0=;
        b=NchSx35bmnFiOrM5llt3yEHlMFawm0yldjxIavaimLKyzwVFOxfy3DH88PP7hV3O6t
         iupqUzqfKq2dp6Uy8viCvx1Inv2VtR3l2O4v6EedBhsYzZa1vpeuMMKvmGKPqd2pa629
         5jfcsOEXjCx9n5I/zjkIO8qtgK0HYGNVjqrhVoQewH3PNnsgjnpKJh+by7DiEm4q1u2S
         CQN9Rrp05qmnPtya2ZYJ/tjLxiReh7m2hyN9/SrczioHJ02hf2a6KTZz/gx5yA2jIR1A
         HFL4VVHKTlqJCLLMXA4h7gJOtKaRJMYnoYXB7F1I3QymwX0fimefho2T1ueUj4HbPwrf
         k3ag==
X-Gm-Message-State: AOJu0YxOoQ4uz46HgBmGLOEf8XkYCm2r+QKzeCtC9JKrLccYIdwEdNzA
	h9XRFsaMRceHvPYA7EqUylrMCE5FwkC1parUiPRAZybtIjxKO+6dqLP/uVB450r/NQ/ucytsctU
	gNckyDddi3OgLgMotUNHcFbX8kENR8XcuiSBxeADXpTa+vwVuefhLSOo=
X-Google-Smtp-Source: AGHT+IFQYoc/8SAeNj2sEia0H3aN12W4oo7M/QY+sNuCiOeFrHz5EzsDYQyQ/m6VbXhHNqfkwGctdsbM2MDAqZ7l9OgPFzH0PJUx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3a7:c5ff:e5e2 with SMTP id
 e9e14a558f8ab-3ae4f5bb7abmr4886125ab.0.1734013321741; Thu, 12 Dec 2024
 06:22:01 -0800 (PST)
Date: Thu, 12 Dec 2024 06:22:01 -0800
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675af189.050a0220.60f0a.0036.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
Author: lizhi.xu@windriver.com


#syz test

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 4974b5accafa..4f5c1b0d9260 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -328,8 +328,8 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		if (tq) {
 			trace_rxrpc_tq(call, tq, seq, rxrpc_tq_rotate_and_free);
 			kfree(tq);
-			call->tx_queue = NULL;
 		}
+		call->tx_queue = NULL;
 	}
 
 	_debug("%x,%x,%x,%d", to, call->tx_bottom, call->tx_top, rot_last);

