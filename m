Return-Path: <linux-kernel+bounces-563607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF768A6453C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F5E18873FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE821D5B7;
	Mon, 17 Mar 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3H1ktej"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362C21C173
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199831; cv=none; b=mFTe/k+6Jda9Kzq7OtYzo4OlaTf87Mnv8Eg1HfZUq5P88W0mUI88iHMBPNDCpMtuJIHnCN5YLkzGVFTM5ySufGZ2gHli+kUPZk1q7HMnISkKYNT88Zd4bHmXO+U/xQGvH4ShyoVoUobJbkqEF2pdiXo6nFfDwBH9o3g4ssFudM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199831; c=relaxed/simple;
	bh=6F6vk/bCuTRFj9sHasYFtzBPnP8c9sLQfBUMl+1ThkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxm19oixBTVRHJWeqt9h94liHPAOJsIW/e9QmPeGUpx8RxTzFmon1roD+GSBoxEXsFUFTiEDhHU2PTzrtZUWgAgu+rvpmp6s/Imd8xOEEGWwvLisNITVHRjet7AA360fbasXKloScgt+0KT0tzw7kz7qcoMEJjWTvHUgts4OjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3H1ktej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
	b=T3H1ktejRD0Vh4sK7aDZUzpjaMS6nV/QZlHsgMGOhKwzEOcZyEmPPXxLsqEWE0kvvJNao1
	GQjq2qyskoAOvH0vUjUQdkF6YA/l7stQRNnnNv9H1Ucs+EBRVN4tNaYlBz5nZELtZiDJ61
	VGj5psdB1Ws2uXfqA6vvTstPhiMrijU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-HF9zv-rhMM-GB9zniK0ZDA-1; Mon, 17 Mar 2025 04:23:46 -0400
X-MC-Unique: HF9zv-rhMM-GB9zniK0ZDA-1
X-Mimecast-MFC-AGG-ID: HF9zv-rhMM-GB9zniK0ZDA_1742199825
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947979ce8so8328505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199825; x=1742804625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
        b=vgG/w+X9E2vF+/wc99mjnIYmYJDdURtCsa6RojQ1B7/czOXr7Wz+UAMKjuV14DP4hw
         SY4E+gLhObUfKV9HMpArXb4FyWbKKTTxvgqE1d3+bP6XXkkovYR9GEcwa8O3HoVXi0wX
         YztJOeB0hDPL9agBcctDH5luzKZ02VwvkPAlNuSV0LVWiJM8qVH5lpiyeycsxm3zV9M9
         7gxo/N3VONDvm3L7TLH3JvPsnZOT6jg/k4yGsHkeLcIkXOCF0ZMZHxVgkdfdXkq2Tnn7
         qbrBXakas65yTBwJqelIQJdtDUDEDC80uzQ8ZAP+0/7oNVH+/Wd1B+2xqm03xjkDn4gV
         dgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKP5hTmK0bWft+l7K7gsX9m7hA+mlatoJBBe/aLoK26QmITE0ZJNiO9EozojdOUMBLjUiycSwdMrZQyEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKluovBJZNqQvrW/Cezn+kojIMWh4g17fNNslo1uBJ7371lN4t
	Vav7wW+W7l9gfhyitUF9ibsGkTkXwWTGSl3CFIRNyiUETMrw8UhnWcq7AGemDU7ylL5HbFejw16
	4ig+w94V0PJnrt87kYku2MWza2Uxgv6xzMUBvaDhQBBHD2z87Mw1eQW5b+RTXXQ==
X-Gm-Gg: ASbGncv8shjnGlDfXnjj7i3J2t85xIJXXnZ3XBlTuMgez+Qizar3Ownr7nE9gIrMzzJ
	J1jd+7tAj6hsy1R08oX5KnVzVu/rcjLRjuv67vw47xEHMhqX44sq4PBkR/w/ji9QzhKbvrusYRZ
	ZgSX4zBZnVh4YUNdC9mMkRlnerKmAFaXM56WAw/fn8U3FIApwUtZ+aKuR8lywukE6F53p3wL4dp
	kXskC9z13GLEznjZ5d81tjPrJm1K+vzOFmB95CkjUEh+cvlOPZxQZwqzOH0qCPnpLyI9gSrkk9G
	8mXhgyNMGdyRKJ/RCwwi+TKGy0k+A6HPF9lxSLdNREO7yg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892915e9.28.1742199825098;
        Mon, 17 Mar 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXGGv6tXY3ajGLLrOXr011xmJAYRLTHi8JZasNx5okT9lH6f9KisDDn8lGridr/hz5ZTMqg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892625e9.28.1742199824734;
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm96734785e9.33.2025.03.17.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Message-ID: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Date: Mon, 17 Mar 2025 09:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:45 PM, Michal Luczaj wrote:
> Racing signal-interrupted connect() and sockmap update may result in an
> unconnected (and missing vsock transport) socket in a sockmap.
> 
> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>   if signal_pending
>     state = SS_UNCONNECTED
> 
> connect
>   transport = NULL
>                                 vsock_bpf_recvmsg
>                                   WARN_ON_ONCE(!vsk->transport)
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This is apparently causing some bpf self-test failure. (Timeout? the
self-test failure output is not clear to me.)

Could you please have a look?

Thanks!

Paolo


