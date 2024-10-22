Return-Path: <linux-kernel+bounces-376474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3619AB222
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5C52836AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFA1A01DD;
	Tue, 22 Oct 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDlZFpzY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8A13D61B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611039; cv=none; b=BFSbqfLabVGSkDX4EsO2GLgPpbtYCSsJwQIiZtM6dHSNsYqrsm5RqydZoM0P2J7ll5Axq3nergj/JCVKAwVosv1hRR/+B2iXksLv1sELF7DdGY9oO6ONtHMO/R8uhjFf5ySnlrqc1LitDulsaAM+5jurU67pw8c8YCkWZAtsSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611039; c=relaxed/simple;
	bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7TZZhbBS3OwK7J+EC8WZScFEZqaezhPiC4JQbAWOw6yEE8w40IqttAIV+/6e7i0EJ5/ecsl26ZshqISyHUqKCx9pncc/i7GuXxJngBXiXdoWGMrAKgIATgqG15ejbUkzuEP2RhHypQdNHmJ/ggdmnfB7D+ZkgyJeP5cFj2CRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDlZFpzY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729611036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
	b=gDlZFpzYQe3Z58C4y3KkEW6DzaszyPnx91LJQ9JJWLgIaNVR0jozIkI1qTzj9cKmUH8XWc
	/t2pARxhFXIZusIyzr6VZrHM7sCmsnG9TsDyY5nRxXu1ZbOydUthmHDJVBRJwMfm/b/TSB
	4bYV3WpgqJXJylVLYENLfAVmvPwNPB0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-d-yjCpn9NQOeGUVdOsBA5g-1; Tue, 22 Oct 2024 11:30:35 -0400
X-MC-Unique: d-yjCpn9NQOeGUVdOsBA5g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d45f1e935so2701350f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611034; x=1730215834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
        b=K1fV5ZfrqAdcikk9XwERB9wq6qjAk+PIqdAjypRHNuuDyVgkNo/1vb2EweP6aW3wGA
         DYl5mRggm3O+o5Lq7dfOSS49PFVLpwVqr+4Wuwbz7/w2agFKgV+cOCocP8rmgbYBGi39
         u9GQR/SqAaDsmHHHQUoz438hp0397yPr2WNotDww/7njELxD3TEw5Bm/7nqfmWRIoNs+
         52bgeYs9Vqv/2dKpzjYdGiz9sRVdspofx0nzjqSCg6S6m6E08ED+B4PozA0EaBXmesh/
         I4hJxtvK2C9MWYbTvbFV+RzK7fC5Wgak82CZWm/6/eh4UFBMkk/tDgLwtYEk4eiA/hFO
         s6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUrul0yIUsxllmY8R/xnVmZSdcp7qsMEwTHxr9Tls0qITfyPPY7wvQX9IBObrr3wpXid709EgP+noGDnio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg24JRtVIAnl6BVmxF70ZHCNSjRGNnDiw6eZOIufsK0PIAn2P/
	pGqed8dW7BeN3o5EpxlEK25Q1ikV8RXqo+h/AU8wyG9gsh4TtBV5Zjpe6aTLzDQuAHuJu7YVOGS
	0YoihSTlH9j5WQBsKOubkUkgIXTeoN/hOgzzdh3z/E2VU9XgzcAQQ6Tda+c9auw==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr10229412f8f.9.1729611034104;
        Tue, 22 Oct 2024 08:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zz73eNEgDwtK6KpTgteNC4JY1ou4UN+CqrAjVjAKfCV29EIzHazgxXKj9Qr93aNf7MnbxA==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr10229386f8f.9.1729611033728;
        Tue, 22 Oct 2024 08:30:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a488edsm6862221f8f.31.2024.10.22.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:30:33 -0700 (PDT)
Message-ID: <0b779b4d-d2d3-499e-abf9-4eae4806316b@redhat.com>
Date: Tue, 22 Oct 2024 17:30:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
To: Daniel Yang <danielyangkang@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
 <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 03:37, Daniel Yang wrote:
> Are there any possible unexpected issues that can be caused by this?

This patch is apparently the cause of BPF self-tests failures:

test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress]: actual -34 != expected 0
test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress
[redirect_egress] 0 nsec
test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_egress]: actual -34 != expected 1

Before submitting an eventual next revision, please very that BPF
self-tests are happy.

Thanks,

Paolo


