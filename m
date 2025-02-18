Return-Path: <linux-kernel+bounces-519411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF57A39C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D64188D24F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A472627FD;
	Tue, 18 Feb 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLfjMyzu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5B2475E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883202; cv=none; b=kCyssWUvyUgpEADk5bOba8BJtHkfAbWf3Vie7P71TnI5CdB0gZWWsJ9FYk+IcbBKCLGxAPjWQiaXw0JrDHm9Fcf8mBCMe3WGyDPwu2hq4KQDsAP7SiMN1JTW46oIJH4DhV8NHh4ElxtcfjlxVhEsbVR/FFz+WTif/1lm726X+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883202; c=relaxed/simple;
	bh=B6rcI33jR0AkhpRZXIBj9cKrGXC+Z78I+ZFwTdFFfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snOeQTU1epxlqeuOUUcJ33VytD7SiqPp4kH31jbfzuSHboWi1uTBifBeg6f4GMxz6pCZa5wqwKi9hYA35zlpmlWRnvDnIwh5mquuvODTkd6kUV36HUPDKMpq7CoPFObzgEhifYZU1txrDNeA59bK+VCUYXYnd9cvzBZbNPKmX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLfjMyzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739883200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
	b=bLfjMyzupBokMg6T0V531JCTQy8yJ1D/BgzB1u1XWgn5PDVtq/5ze5kMeaGJ6MKXy8ZZvW
	8gA2chY4xOcTgpGe3hjAuv8ULtLzH2gPY1vt6UtRkvCovxEweQ6GNe5DYCMWVYNXH815mj
	N8IU79g/kaKIXCCec4mY76Wpb8E7J5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-6bkAfMv5PV63bV3mxs702w-1; Tue, 18 Feb 2025 07:53:18 -0500
X-MC-Unique: 6bkAfMv5PV63bV3mxs702w-1
X-Mimecast-MFC-AGG-ID: 6bkAfMv5PV63bV3mxs702w_1739883197
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933bdcce0so45714895e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883197; x=1740487997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
        b=Yw1vkeWf6W8eFc54tFuIPKy6X6UcFdeBNoDsHw2j98te+ZIkGLgNohssZ8hKgxTVCU
         6x3SUN2nBUSwGf1sivqdCSMY8BFlBmyP3zdELlch8CJke3jtjkBU7pjGmrj4I6BFCqTI
         K0MxgjgzvrksOc55TronJx5SCfz6XA3AGIU7DsP/6DTeEmDprZzyTwb/S1KYjGU3+0zg
         JrkTo9D4dTpQxcnMTxYpqzRGWp6XmJ37hC2vB5E1Hbe3zPuexJzWs6eHbFHsAC+LNhfo
         1eAKwRDJ9AjKjDz5Skgu/FdFusF/e0WfMZFqOGDnD8qiZ+PfUVGHKnAoTt8gpm1pc3qw
         9OVA==
X-Forwarded-Encrypted: i=1; AJvYcCWnyhozvhPvpSvyMYTH4OwMnlKTUsI+tsu35t/h9Uos5g0c7Zl4OpP0/d65z7+OYH6eeP1eeNMHwj1UWe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8kooMJnaaaFn2Rlx9wXyx2y0upKKEbPobgJhhm9yJDhC+CPd
	BtlH2EiQCF8uYJ7HBR/r7ELmymhFQod8yAO0S9F6arBcXeMa7Mt3ZAbSi0lVch9U3zAGkzQlN31
	E+/4bSfVqSE0fXCTmuXPPCu/Z0iuPQR6jxtVgVlBpbykEhfKNZ7b2IqiPRzX6zw==
X-Gm-Gg: ASbGncvYFixaUmbkgZ+5UtZJaq1/vYVRXJr/bi3ZpPCkHoiIu2DDAZm/Mg2Cpid9FEX
	qEd8A/HgCPMVFB3t40LmVMfCRcJ8/9D5tNdiiiqtmT3VNyC30LxMpRNuIa8bgAvYOWic0RhE3SN
	AtiVKsY2KruxslDHFtUEKyjS+Br+vXOdwLTJ7PUKz4+yJk8TmDuPQGF7CsDpdmdczcvT/EuaomX
	5a5uQKO4pP1GLoHs4iebBWYFcI57QRai2MnlnbzqYlV3O9LcqN53w0bOstJVIGlH4kBLhl9pigh
	8YlQ2HeB/JHQ44Oj9ICCRbE3AFBGH9+tq4g=
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321375f8f.18.1739883197494;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmuOBQoBPGkm0apcXujpsKNRJknLqhiWdlArj2xmAH10Rv73rZHl5OqE/4YMT5tnZCWC0Bzw==
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321354f8f.18.1739883197088;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm15132973f8f.32.2025.02.18.04.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:53:16 -0800 (PST)
Message-ID: <cc84f98f-d3d6-499e-9d2f-47eaeb56aad3@redhat.com>
Date: Tue, 18 Feb 2025 13:53:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/14/25 6:07 PM, Breno Leitao wrote:
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
> 
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
> 
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
> 
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
> 
> 	rawtracepoint:tcp_cwnd_reduction_tp {
> 		....
> 	}
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> ---
> Changes in v2:
> - Close the parenthesis in a new line to honor the tcp.h format (Jakub).
> - Add the bpftrace example in the commit message (Jakub)
> - Link to v1: https://lore.kernel.org/r/20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org

For future similar situations, note that it's expected to carry-on the
tag already collected in the previous versions, since the delta is only
cosmetic.

No further actions required on your side.

Cheers,

Paolo


