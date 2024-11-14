Return-Path: <linux-kernel+bounces-408973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7369C85E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978711F2141B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F431DED72;
	Thu, 14 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufg2BNRA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16517DFEC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575868; cv=none; b=PqP3DSKKxgYoLTerf0O4zEg63kCM4DaLNBrFgu08rHeCP7VFf5i7pUYCXGHP8SkxNi+YkYLdvfG7Rl0T9cNiA/uRcM9gGHRHXLIDfdXn6HsBXGJAOyc5ChHp2iepOMEoWzkF76JsyfzCukWMQEamxUyThUmALVxdp3MZgWmBZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575868; c=relaxed/simple;
	bh=2l1upWdLGnHpQBTsx9xJ7gWW3a/Of3mHuYaCwbe2cPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7CjFsQsMs3CjIf89PYUvgf94Z0aA4W6aKTdNSgdEEUhl0/Hc2Bn4kaG6y3bT1x0/ZJ/0e23dRsgFgJgDIb/OICXfpeAT+9Rzr0IdA0PvjeIxcmHtZ15NJJC1HH+Gmsb6dlEmrQ2YlPCCkKrRQMxFndlljQeElAeyc+O1NMq6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ufg2BNRA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731575865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YTMof52wjObhgZR9ofRlLiT7bLjMKTtBkm72KHuyEs=;
	b=Ufg2BNRAw0+1d/OBPsgbFjYzL9VGJglxNia+HX1o6As2tsRgSq3sE9G9jJWJlPtRHA9O5K
	ogmk+rLBUUYSP+MIbwVm0yu7KH1wgrmWWfvyKxCagEmC3xGVdROsm+ErZI241opqPpgMJU
	CUi6W53G41RVIPp8xKMiC6cLu9eyrcE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-pq6hxKAjMbe8Pdu6WZwBOw-1; Thu, 14 Nov 2024 04:17:44 -0500
X-MC-Unique: pq6hxKAjMbe8Pdu6WZwBOw-1
X-Mimecast-MFC-AGG-ID: pq6hxKAjMbe8Pdu6WZwBOw
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ea90b6ee2fso8958417b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575863; x=1732180663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YTMof52wjObhgZR9ofRlLiT7bLjMKTtBkm72KHuyEs=;
        b=P4gX3a8xby5Krt9zizvLMa7dMvwM8TP9hvyXOHtRKQf1k1mWzUUx2YEszZ3c0P/UPm
         vKRfAoX4qbwK7c0Jw++5BEbmzf+/wGET5SL5ZFu1+oSDL28ID3LCHpcVNd06r6vfZx8c
         j4ynMf36pVODjCUz0YZejE/Hr478kkSLpjZ5uqhMeITvnsNX4S87/RKlCdVwSoddwXbh
         o7fn49xmclzddHtYHBiTmk9f0FXYwTtD1VHHqIFgjhh5mbSLkEl0LKIM38YgbnZOUkN/
         rtOgxWKI/ox7hQ7l3s1SeMJDlChaebPFd22OKxtDkjJ7zzpNnW8Vz5c2qCBvUIObeEgH
         PYew==
X-Forwarded-Encrypted: i=1; AJvYcCUM+DQq3MWVP1kl9yg+I9quc6L/N5lEP7PIS4dlOUwlUccJVQEebgDw+tXVoWcEofwYfE0WZtmZ1fB2uDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHo8IFioOQgoJGuof8Qta/jIj9EqeDG/YP7GISY7mi4VmXQH/
	8Sutr5QovETIj75e18S4SkR7msZHgyiv6B0y+bSKmlWXdYXqr8u3ZH428M7bshO41qMJUl5+Fub
	yXlZeb3YXf7d7F+WLnQaa5SiV+4QCDcUiGigr0f5P5Kcpx32VXCUeW0B/b0LOpQ==
X-Received: by 2002:a05:690c:3504:b0:6ee:40f0:dda8 with SMTP id 00721157ae682-6ee40f0e2cfmr16971187b3.30.1731575863545;
        Thu, 14 Nov 2024 01:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsiQSf8ZdEH6QnDVrnxq7SyDxajgrhb5FvkPicA2hLnRMRhzQMJ0Rdc+FgVp0To67bMvJMyw==
X-Received: by 2002:a05:690c:3504:b0:6ee:40f0:dda8 with SMTP id 00721157ae682-6ee40f0e2cfmr16971077b3.30.1731575863247;
        Thu, 14 Nov 2024 01:17:43 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9eefd0sm3301361cf.27.2024.11.14.01.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:17:35 -0800 (PST)
Message-ID: <9e64f1ca-844f-47ec-8555-4ac1e409ec16@redhat.com>
Date: Thu, 14 Nov 2024 10:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/core/net-procfs: use seq_put_decimal_ull_width() for
 decimal values in /proc/net/dev
To: David Wang <00107082@163.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241110045221.4959-1-00107082@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241110045221.4959-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/24 05:52, David Wang wrote:
> seq_printf() is costy, when reading /proc/net/dev, profiling indicates
> about 13% samples of seq_printf():
> 	dev_seq_show(98.350% 428046/435229)
> 	    dev_seq_printf_stats(99.777% 427092/428046)
> 		dev_get_stats(86.121% 367814/427092)
> 		    rtl8169_get_stats64(98.519% 362365/367814)
> 		    dev_fetch_sw_netstats(0.554% 2038/367814)
> 		    loopback_get_stats64(0.250% 919/367814)
> 		    dev_get_tstats64(0.077% 284/367814)
> 		    netdev_stats_to_stats64(0.051% 189/367814)
> 		    _find_next_bit(0.029% 106/367814)
> 		seq_printf(13.719% 58594/427092)
> And on a system with one wireless interface, timing for 1 million rounds of
> stress reading /proc/net/dev:
> 	real	0m51.828s
> 	user	0m0.225s
> 	sys	0m51.671s
> On average, reading /proc/net/dev takes ~0.051ms
> 
> With this patch, extra costs parsing format string by seq_printf() can be
> optimized out, and the timing for 1 million rounds of read is:
> 	real	0m49.127s
> 	user	0m0.295s
> 	sys	0m48.552s
> On average, ~0.048ms reading /proc/net/dev, a ~6% improvement.
> 
> Even though dev_get_stats() takes up the majority of the reading process,
> the improvement is still significant;
> And the improvement may vary with the physical interface on the system.
> 
> Signed-off-by: David Wang <00107082@163.com>

If the user-space is concerned with performances, it must use netlink.
Optimizing a legacy interface gives IMHO a very wrong message.

I'm sorry, I think we should not accept this change.

/P


