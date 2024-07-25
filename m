Return-Path: <linux-kernel+bounces-262066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF593C046
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348481F25219
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8A1990CD;
	Thu, 25 Jul 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXJjTL62"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18014D457
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904275; cv=none; b=NAl+2HtpEiq0jSfHrGlhcGlahgNYnRVyIESL9nQVeufo6Z1FbP6z80+EWDkritZrGYkwO3r+dMiky5u8fLe7YKzCCv6A32DIkOC0TjMjhpbhQj+LFH+EmD4vP+3QDlHAIcYIdMLcUCIq77FHskGZnNTd2Miapxkh5MtBk522I+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904275; c=relaxed/simple;
	bh=0vq0rDUT6bKO2W9H+6WFqSg/9iuDLDwHFDr3lWX1Za4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQCAU84Ce2OBBi+MSd+bk9yqmciHIYXs40yCRCXd5YL5wiJh3Qj6+bW8V4QTmqwY66l0dVie8GiYBxlJfrgCrbFOTGQS2ElwX3WQ0+nLZoN+ujoxylL8hwXMES5mgliIMcu3xEp1IyzpRvsDxeXB0+txeg6VFWPSynFigmLkyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXJjTL62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721904273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
	b=TXJjTL623oUtRoATckil8p/mgqxgcjZKb7iptAQh1fbk9zRCinr9taPYTToGFrECwQV30v
	YrBGrMW0N5HgbAOHVZU7RCxPawJMb+WWNtJjMvpSboVfsB1igiox9yS0T6gT/MX4h2Xya5
	q1xRQEufY+qS7nmu3hVBRYnbNxSGwxI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-aH2IqjYiNhKDsaOtuuuX5Q-1; Thu, 25 Jul 2024 06:44:32 -0400
X-MC-Unique: aH2IqjYiNhKDsaOtuuuX5Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef185db2b4so2371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904270; x=1722509070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
        b=Sp5S3zLpvt/lKm3JmE6YD2gCYTRuPPK5lyhrRBUra7vitYLQgLBe0Qlfd+LKTrWyle
         LInL1/7M14YrOejDuFD3okULIbVnqkklnHi1no7nAnIqmhxkHISVB2USPY+1pC4sUBs7
         d2issybtL4d7a2WPvT5cNXap+xHSuBqGjlZZzH0Kqw7BOSroZkbW5q4t0xaQ7jVpoHaw
         flvkjRdK6R6tRW/34LqkTBQYpFUegupRsdKionoDEv3dUyld674mcBoQVY5GfFqCxIn0
         ooRAirqg9ey8kkjW4+e1jf+Qh1WssmNpxGNoI9OMu0cip+QatiOSkdN458yOLVDq0sGr
         z14A==
X-Forwarded-Encrypted: i=1; AJvYcCVN2v22iQdGjqIqDkjdjI8EfVXRQCSqUHKsaUQkiT0X4MRUcFmqwSzF0AGHDQ5GcaC4nBGoC1cYr2BM3rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmBSNsbDgBGTPhWp4p1X95BluM8Jh3bFBuLJUIR56FBXof5DG
	ySKcBLcHaGWViK41tNVeBTa0hyiQqvl/YBjdBc67eHSgb6DHO27Ij0iMbuiIW6eSE4eMJ/G9xH9
	RCE/vJltxNXCi+uyz/0k7XKmn3kpUqOEYnh+l+7DJtm/BOcEUfMbfb0bxupWRTw==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282281fa.9.1721904270475;
        Thu, 25 Jul 2024 03:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUBK6W2GUS8+jtAqWZDWCnsmj9yGfBQkRTr8Yb+Fe36zV0LVzufyszMXt+QAvJPZG2mpdWvg==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282221fa.9.1721904269873;
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9386b87sm67279135e9.19.2024.07.25.03.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Message-ID: <e263f723-0b9c-4059-982d-2bb4b5636759@redhat.com>
Date: Thu, 25 Jul 2024 12:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in
 do_xdp_generic()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jeongjun Park <aha310510@gmail.com>, jasowang@redhat.com
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000949a14061dcd3b05@google.com>
 <20240724152149.11003-1-aha310510@gmail.com>
 <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 04:43, Willem de Bruijn wrote:
> Jeongjun Park wrote:
>> In the previous commit, bpf_net_context handling was added to
>> tun_sendmsg() and do_xdp_generic(), but if you write code like this,
>> bpf_net_context overlaps in the call trace below, causing various
>> memory corruptions.
> 
> I'm no expert on this code, but commit 401cb7dae813 that introduced
> bpf_net_ctx_set explicitly states that nested calls are allowed.
> 
> And the function does imply that:
> 
> static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> {
>          struct task_struct *tsk = current;
> 
>          if (tsk->bpf_net_context != NULL)
>                  return NULL;
>          bpf_net_ctx->ri.kern_flags = 0;
> 
>          tsk->bpf_net_context = bpf_net_ctx;
>          return bpf_net_ctx;
> }

I agree with Willem, the ctx nesting looks legit generally speaking. 
@Jeongjun: you need to track down more accurately the issue root cause 
and include such info into the commit message.

Skimming over the code I *think* do_xdp_generic() is not cleaning the 
nested context in all the paths before return and that could cause the 
reported issue.

Thanks,

Paolo


