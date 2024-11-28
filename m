Return-Path: <linux-kernel+bounces-424230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA749DB1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C1AB22200
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986D12C7FD;
	Thu, 28 Nov 2024 03:23:11 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAA433B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764191; cv=none; b=khAiT3k1zf912L9IM3reqIxs0QHBs6lx2lqe4RjL8nqrmNaH8izAI3GiI3a3+okWyLLLPxPgs8tZekTXxHbUbq/eKKCkbS2w01npjEMxIKnnjENOeeuh432NX7ybgBBnrKeUFQTvxnLQHTV0M77/fp8ZZSeVtQMfd8jX/LldI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764191; c=relaxed/simple;
	bh=hb2PBBvwufkpWR9fveOWwse8C73X3fPGYWIm3h+Z4Zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kZPVfK5M3OOjNE0smHKeDziWf6GF9CKlFUPnIveYtrXCgfhcAwvrD/faDdTyKO1xuVcqjCz1eijFUw1vYTujeVx+nYoVg7kUAeRCKWFKwt13ordcHcvkMVZVy0Pg1RospMRtwBvjMl1qzGPJfzPTUXLcZca8sejxTAVp372zEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77a808c27so4469555ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732764189; x=1733368989;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OfYs7iW05qw4f6R/a4MpnNi731f3XkcedW7Ckf6N0=;
        b=KRJwicnYoR0Lc5V2GSqrAvwz5Gj902ZWH0cPgfiBXvQgT9A86NioXdHoskcrnx+251
         mhksq7K43VAeAPApSkh/cPn0/s4pQP5v1LXmLzg+AkTVmfGikp0zi4W4HSf4mLejM6AF
         B05Y0x3izubkwMusijQpQNbO09u7Od9RxyxSxGIpWTzq5JwDuw8Uf7UqpLdgU57Uk6UB
         Kq0t0wa9Tj/Jrf8VyeXuV3lEmMNmPFDB+psmjUkwpgZ8RQ8aRF5xD5EJZFSi+jO+Ypvn
         8xWPB0JsmQ1z+9u480zGoerU5g3F+aNk44CqOWtxz9NVZAGOW5cctpjBY8KdP2BtauAD
         m42g==
X-Gm-Message-State: AOJu0YwVZOLJCBtAukhU2MByhE9oBQH5oEQhazF0Kg+pnT+5mD+KzORN
	5hHtDn9V4+S0yN2TrR4OrU6cgDL5WAYxWm9iIcpfImC4BVrfWxJWOisjgaiFwzqxaeL7fJ4nfwt
	WdndUUtvL9C9t1XYJCLoOn/FAhff31h74Q8qg3snj8Pwgy5Mu5mf1t1c=
X-Google-Smtp-Source: AGHT+IE6o2r20teD3KYnGr3dr/eI6V4eg2ts7Zp38x6QQKlZpYL+RGwmunf4NyrXJop/omDXo/Ywk2mPfaOtQVjLHGlKg7dp3rd7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3882:b0:3a7:c5cb:8bf3 with SMTP id
 e9e14a558f8ab-3a7c5cb8c56mr55168265ab.9.1732764188980; Wed, 27 Nov 2024
 19:23:08 -0800 (PST)
Date: Wed, 27 Nov 2024 19:23:08 -0800
In-Reply-To: <67447b76.050a0220.1cc393.0087.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747e21c.050a0220.253251.006a.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+3bd0834534ada7200422@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Guard against journal seq overflow

