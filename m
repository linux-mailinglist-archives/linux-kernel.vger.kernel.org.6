Return-Path: <linux-kernel+bounces-568517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C7A696AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6625517C568
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0721361;
	Wed, 19 Mar 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpmxryDy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CD1DF747
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405937; cv=none; b=KeSUUZSv8jSAuIHY6rtt0l6NB0LL1n9zx0f345sKsFRKr853nPHNJALW1mVDwyFpV5/Xh79Yifg5y+rA4cJvSjVgZQOkIKRflxqvZ6GH43gcAZBmD+0WV4glrf8ZTxyl+pmfE+zsLG1o5ssy1fWn/FaYD+bFwbOgMkbVv6h+HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405937; c=relaxed/simple;
	bh=OS750zsOhsm0zRWuj41DPLa6HTkZm4qf9YADRneYMmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUFXA1XhC4Zo0ymBcpjvfVQrotv2PEg4JL7m2lh0rn71WweVqCQQdbgKvR1zyxwJ+yX0GCw/eyLyK7BgE90iyuNIZSnILhlJXjz/ywqSkQDQo7PPh8opMLdw2jgWnWcjNru+gcNegOlpLJhe9kqIsT9xqRH6olt4o9Wt0eB060A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpmxryDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742405934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOucbCH8053ol58iaNfOQldT2PnQaQ3dzjaib8K+1rk=;
	b=PpmxryDykFPh6Q/JSVXSXWH0L8DFwGBsEnTJkkuU46TXikTvbj7OS8PFLY3ax4/SXYpGC5
	q3NBdgEmuy4tqJvJVbRihyxpECxrNUcf8viYgIES7PJVon58ulBjH9VjVvjbSQIzzvXRdh
	lIWecXKIU0NC8hbZ07wm1c7PlXJIESQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-NDU9JvXUMcmLq97uPNkoCg-1; Wed, 19 Mar 2025 13:38:52 -0400
X-MC-Unique: NDU9JvXUMcmLq97uPNkoCg-1
X-Mimecast-MFC-AGG-ID: NDU9JvXUMcmLq97uPNkoCg_1742405931
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso56509925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405931; x=1743010731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOucbCH8053ol58iaNfOQldT2PnQaQ3dzjaib8K+1rk=;
        b=jXKCA0qbMAcZQQihHwVQOjYPFunFD4Xq8cZ9ybxWSFy0uihzOtp73p/dgOk26HkY7t
         MExdZX7yTEMV7md9nFEi6Vyl3Z+m8P5Wa756bWdr8PDYdnjZL6/Ntd3chLFE07uqKpRx
         DbMuUW2SZw4VUVR5ALVj4e5AfbISXquyibOj7n45X9Ev6uz0QC5MqDcZKtlx6zqXY1EB
         q84LSu6Zry6vyeU79h4hgMSTspEjvViP/WMBLmFK/nI0J63yNpz9dqnfEP8UfVdtsx1p
         MY7acAlMR8DGCjS/3uEB9Q7tb4CXYx3rfEtsUx39Q6+PmIzaNa3lN3TLKEaMCHotFL1l
         n1xA==
X-Forwarded-Encrypted: i=1; AJvYcCW7n9BaIjaWzwW1EZQx0KiHqGjZN1hZIPZRI+S0/s4QAu7kMwuyr4JwuJeOiNzKORz98WjMAMW7DentWys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNIbOVzib+vqTVxUBgX5GTg0t8ljb8FCXXoXIVNsFmq4chZXQ
	EM6DC1FQ1OEXB2ZRTPcHYdGg2yCTbcyHvVW3gDhKfx0jhoTATrepfI0lx6/tT1hcCnwph8v23gq
	5h2WpjVeWHB/3+UesEAhGh9tLGg7jDdRkx2udNDDdrymHOLonDwUtnBb75FX3ew==
X-Gm-Gg: ASbGncupIktPQtjFF/gFV2GhrxaO4ehqy7qg7Cj4Z1Yv8JTeceibPQXVXX8VlFphigr
	Yx9+y8d2oNLg1wP2T2BQhOnNPcGoPZEoVaZ9eQ+iXYrhfAEJLNNGSwYxYbeIa3qB2Rjk9B2LxeS
	J6KmPiAcppYskzeRUDCGLDt3xpNpKcmfABqkzLgWpkYq0AQTx7aHQrk/KlmU542VO7alNYbnFhu
	uA3Sq5bqUsa1koDWbYkQyECopHYaunJKP5WEXgG++lS1nSfqvpV96HCmSKMExEefirw4oVvHkZf
	KG0rLbzFH4xED/yKji/lLO1aFfL+4Lm5e0ZIJow5WXv+sA==
X-Received: by 2002:a5d:5f84:0:b0:391:46a6:f0db with SMTP id ffacd0b85a97d-399795df888mr243968f8f.37.1742405931388;
        Wed, 19 Mar 2025 10:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHG5Tm2aTbhmmrCTzYClNAc5qOmeImMeQaQKe4i+YdSRkAsvTNxuFmNMQxghPMgkdbjpxDPA==
X-Received: by 2002:a5d:5f84:0:b0:391:46a6:f0db with SMTP id ffacd0b85a97d-399795df888mr243952f8f.37.1742405930965;
        Wed, 19 Mar 2025 10:38:50 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm21081012f8f.85.2025.03.19.10.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:38:50 -0700 (PDT)
Message-ID: <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>
Date: Wed, 19 Mar 2025 18:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 6:21 PM, Dan Carpenter wrote:
> This NULL check is unnecessary and can be removed.  It confuses
> Smatch static analysis tool because it makes Smatch think that
> xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> it creates a lot of false positives.  Remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I have wanted to remove this NULL check for a long time.  Someone
> said it could be done safely.  But please, please, review this
> carefully.

I think it's better if this patch goes first into the ipsec/xfrm tree,
so that hopefully it gets some serious testing before landing into net-next.

@Steffen, @Herber: could you please take this in your tree?

Thanks,

Paolo


