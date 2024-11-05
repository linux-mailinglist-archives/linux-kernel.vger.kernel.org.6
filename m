Return-Path: <linux-kernel+bounces-397019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027269BD5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727CD1F232C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9321EBA04;
	Tue,  5 Nov 2024 19:12:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF71E2007
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833925; cv=none; b=AgUT6bTTyGNX26G4xzoWIwBwQuUjkdE0Lo1XrgnVYUGu7Ev14CodOc2L2PfS/fMXpkIdx2e22olFm8nc9d3hJkNqsQyn2cH+yAxyTQI0Uw7Ln5/CFYILAUjOXWYMSNChrYwSWUFOP67uaGreh2lo/LPwu+swzvANt9ni8hhiwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833925; c=relaxed/simple;
	bh=rhZld6Mh3x6nslIO5nVr2zkPeOxN4sKoCX5nfTRPjY4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LDOr7mQDRnBNO2jvLjrowRdc3keQ5elNsijDeAuAGnDY8Isn+/rrQJ4JeV6IGtBCgLMPJCsW9rWYrvLSAItHJOTcqHjBmUQcbYR2RWkG8nGqTDFQBm2VSLO9gF80Gic9y4AeHVdGb47vGK1XvAAIH+YCN4I6NpLpS8/yOH481Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so63840205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 11:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833923; x=1731438723;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhX9qykCs7O0Td+0duSHWZ/6DCGnaMr+ZVBNhlnkAeU=;
        b=r7sd9oYn2xcqRP6M7J7HU8aRdXKJ5lJ0DvTkijmVZENfi13fE1pNUaOnMvuVBUeWXS
         n0608bQXNtmSntL30IaTvx7VXCZqUQCpbYovSCUU3Lhe3B6JORXz5/CpGFfmUkLEaofp
         H9c9jujOHU6uPodDOt9vjtDB2VDchl+uaG4AA9yKClewABkqrHgq8AzX0u/1rBRiw9Yb
         idog3C40eKoykShp3p+Jw0KRq1+q3mnDVSV3MXtlP763sKj5vix6ltexIcJADnsUBFM2
         DuMQywGKVnhi4dBbaG7tv92mrx8IWNCdIWKQzr/7EeJBl7Svb99oLZxg2KKk1h/pYdYj
         rMng==
X-Forwarded-Encrypted: i=1; AJvYcCUT+a+CXMgeVwf9YilGMnGrPE/36s7/MrC6HLON1b0s2S3znDGtp/kdDRi8AazQOdUgxBPd9SNGDTbvXGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxUIHm/qSKIQk5uAaqU4J4AJyQBM2qopn436c50tTpw6te3K7
	Lm995unFT9hA0D4kWYQHdR7ZCCFDLHcoVcAdbNkFOFlJj809OO4sikl+ARTSwipPMla6fbhgdbG
	ZdAPhSaEOSmzVelkktlTxYXT1ACysnf5422cSwlfnAOSxJspfqDkRzmg=
X-Google-Smtp-Source: AGHT+IG2Ewtq37y0D6eeenbNTOad+Nva2dLGt09354SlhmYY6DBel2RtfK7wRugzZ5sfJ7IYDw+A+dka5tyCB9Ghif3a5lc6t3GE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a4ed2de690mr388935165ab.19.1730833923430; Tue, 05 Nov 2024
 11:12:03 -0800 (PST)
Date: Tue, 05 Nov 2024 11:12:03 -0800
In-Reply-To: <20241105191156.99327-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a6e03.050a0220.2a847.154d.GAE@google.com>
Subject: Re: [PATCH] rxrpc: Initialize sockaddr_rxrpc directly
From: syzbot <syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com>
To: zoo868e@gmail.com
Cc: zoo868e@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> In rxrpc_lookup_peer_local_rcu(), removed the redundant memset call
> that zeros out the sockaddr_rxrpc structure before setting its fields.
> Instead, initialize the sockaddr_rxrpc structure directly in
> rxrpc_input_error().
>
> This change simplifies the code and ensures that the sockaddr_rxrpc
> structure is properly zero-initialized.
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> ---
>  net/rxrpc/peer_event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
> index 552ba84a255c..c86b432201fd 100644
> --- a/net/rxrpc/peer_event.c
> +++ b/net/rxrpc/peer_event.c
> @@ -33,7 +33,6 @@ static struct rxrpc_peer *rxrpc_lookup_peer_local_rcu(struct rxrpc_local *local,
>  
>  	_enter("");
>  
> -	memset(srx, 0, sizeof(*srx));
>  	srx->transport_type = local->srx.transport_type;
>  	srx->transport_len = local->srx.transport_len;
>  	srx->transport.family = local->srx.transport.family;
> @@ -134,7 +133,7 @@ static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
>  void rxrpc_input_error(struct rxrpc_local *local, struct sk_buff *skb)
>  {
>  	struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
> -	struct sockaddr_rxrpc srx;
> +	struct sockaddr_rxrpc srx = {};
>  	struct rxrpc_peer *peer = NULL;
>  
>  	_enter("L=%x", local->debug_id);
> -- 
> 2.25.1
>

