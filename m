Return-Path: <linux-kernel+bounces-244495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA592A504
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AC61F22220
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AAC13FD9C;
	Mon,  8 Jul 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgZ0EFau"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298E1411E7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449973; cv=none; b=HCCDxZ3uSHtO8ZwjTMk46CseQ1F8OxkcI0vzer4dJhPZFQxUZl8puy6BlV/8BRPkD5Of3oUmjm4NTBY4DKRYJVOaIKXCPlyV+AvPt3jgZEo0tsDNiUjaemBb8cBqPBEuBZBDWHyKZ8yEcml5RSpPABgXVz9wFDpzWqRivWRgB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449973; c=relaxed/simple;
	bh=vxyvFviWFMzdQXkmA/FIp3YzReSch2WXezG5G5z+UXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YbmPf5x20ehFsMZ2nWj4dlvJoQ3vlEcEU9aS092wX2ObEFpd/r3FCig5ynVmnpXO1k1dUlLmgZ9Kk786fhRimKx7artywmTF/QueucG4ErkrPnIqp+U4J9o+A4Vn9mRxoSyoKXTE2RE62i0jRdr0Qi7cvML+EAQf5pu1vLfV7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xgZ0EFau; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70368b53cc0so892707a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720449971; x=1721054771; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjwJEbtyvDrUjV2HV+RIgx9GLehaO/ifBmLUE3mP+44=;
        b=xgZ0EFauDk5iDoIr/NYfW/VNRXYoOjkZOoFFRV2J096U7J+TnagGGFzhKu/0RihNyE
         5pKz6quKNQv9mzXXmGvCkCfSyXJHJP2USx+3U5G4buJbf+dDC0ohUv4az216S0g8AigM
         alFLRlyJv7rn+jG5CMQBdxlytgqnPb673r+xcNlLif84OM1wGSCnIvFw0NNDM+SDRqPB
         yiCrFqscnk+kWhSkctStZS5aFXQlnSi6r2j/H8RwsDEwEv4oyweBGP2vonbGVxpjhdPI
         qGiSArKBEVwoGD5H89cYFh9XSKxXiYblchOn1DKwubJy9YUFxvtg6OOtEsO+mjE9GYPd
         33iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449971; x=1721054771;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjwJEbtyvDrUjV2HV+RIgx9GLehaO/ifBmLUE3mP+44=;
        b=b27uOwMnbApMHGPY5dObpwHBm3JeBSFE3JE97o60hOU7wQKfDt4eOw9jl35yXfN/vR
         vbSKZVnyz/0+HLeu6RZMvzexVmcBptakYM9Mzu/9HcQ+isghoNwp6t337uVdQ9uQ6NQy
         b/BmYukIHgx31hPTaJhKqP6cnt7xzOAyXgYckp8duKZRad4XRpm5CNqZXLoOdsdX7Ckj
         LW96EwoRlOROdtGZE9pG4DisOlpbGAUsYQZv1EpU53HQqVwcswOapTKD24RSmIdJHPSi
         cUw2UyQdQNUJJ5qKr/myGLqJndRPHNGjT6NS0MTPdNTcF6qGlcxUstHSuw8/WopmrDJN
         UHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUotBsaDiIBB3/+gRQOjScV7MmYpenFJA9Msqba4g+K+Tkap1BJdMZ38h7/SRYBPFLnhxHhgJ9w4IoimZNDQ+f52RtOa1Eip+xHsHEq
X-Gm-Message-State: AOJu0YwLFKvxRodlyaihJK7S0IlbLC08qCg4uw3xJdWTI9v3tRKJRnmN
	y3om2du/X/jy2yCxELf3bHTB7YiWUMy6RpGIUutpf4evzositTRYjslGhFsjog==
X-Google-Smtp-Source: AGHT+IGMCL1iRgwqXTdZTTit88ovRe9lrZHPjnWJmD37C9x+zcdkRU7GOewgdpnAIWilaxW6DcEicg==
X-Received: by 2002:a9d:7f0d:0:b0:703:668f:321c with SMTP id 46e09a7af769-703668f3360mr6007303a34.20.1720449970807;
        Mon, 08 Jul 2024 07:46:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f88ef8sm16133a34.46.2024.07.08.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:46:10 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:46:00 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sagi Grimberg <sagi@grimberg.me>
cc: Hugh Dickins <hughd@google.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: fix rc7's __skb_datagram_iter()
In-Reply-To: <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
Message-ID: <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com>
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com> <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

X would not start in my old 32-bit partition (and the "n"-handling looks
just as wrong on 64-bit, but for whatever reason did not show up there):
"n" must be accumulated over all pages before it's added to "offset" and
compared with "copy", immediately after the skb_frag_foreach_page() loop.

Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: moved the "n = 0" down, per Sagi: no functional change.

 net/core/datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e9ba4c7b449d..e72dd78471a6 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -423,11 +423,12 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 
+			n = 0;
 			skb_frag_foreach_page(frag,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_local_page(p);
-				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				n += INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + p_off, p_len, data, to);
 				kunmap_local(vaddr);
 			}
-- 
2.35.3

