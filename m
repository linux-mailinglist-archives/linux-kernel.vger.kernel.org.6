Return-Path: <linux-kernel+bounces-565793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7883A66F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595D619A2D85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18422054F1;
	Tue, 18 Mar 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCBrm/XU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8C42AB4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288550; cv=none; b=fiYKe2REgAu+G0ysAnKORhT4XdyLr3ry8rL1lqfrqRDA4z8eEayfVljtaZx5Uhr8y0VoOf59Mcprw4QSAQNKgcrdJ2SZbVc4hcvMXOe0oOfsBBZ7pXtNX/wapLSHGwBQTvdcRFSFp+0DGY2v+KCznVzAr4jheBNiSrm/0icxUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288550; c=relaxed/simple;
	bh=d+iu5R0bIqWiBL+2PYzliZdZopVRCw5pTpDMAQQCfBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTU/IXLfEuxtPFNAfC1TOT31A1y78b68Yf5Q2S6a5gLbI2gCRCwoxkmQNRDbQIcNCNW4MZfjkBV9vGVGyB4RrAT7pjuRY1zRt3N1cYyQK61OqjN+hCLJIAewgmyYZnC+y8Bs4l1RGCMuWGflrNvgL6Cc7ssGxg42ng5E3M6K3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCBrm/XU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742288544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZHjSj6IIBOV2oO1qsgTstoal0zFQK2lDaOtzns/K7o=;
	b=FCBrm/XUDuu+1RIgk5EwfhohDVTdfsqRURwRvP0tptdEmQ/asc8DJ5j0RljBqG7TmmSOTu
	eoBcanbzpgamqytjJau1bJI1at6c5xRmT+SpB1+p7N4RcN0NpcRmy28PTjDOsJGrx0Y6uF
	JaTqfq2eizrgeZYtyQ01218ztu0uf9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-KtQePgNoPT6su6od1dsrQw-1; Tue, 18 Mar 2025 05:02:22 -0400
X-MC-Unique: KtQePgNoPT6su6od1dsrQw-1
X-Mimecast-MFC-AGG-ID: KtQePgNoPT6su6od1dsrQw_1742288541
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so16026305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288541; x=1742893341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZHjSj6IIBOV2oO1qsgTstoal0zFQK2lDaOtzns/K7o=;
        b=IGn/BDy9UvB5vVgZugEm5hTlUVb4vFUqFVXjFFHUz88LNoQP6O+k3b4wnFJgZXbDHN
         ilD3JAfTvKLb907Fet+IUOF3G4X+wbvfFPEPJ13RvfiEGWco0vBHZ1N3V9rwpagEM/7q
         rrdfUQmRaTLBqng7EOpX5hSwrccEzQNJKe3xb/6mfCSKl7g0bXEw20Z6Yhb2p+oOlmjp
         amHGKwN+hghRTGXRJK+Q42cclVEsyN3FX+trEKapxtSMoUdBMUhmZnpRqK8zI7hix8Wo
         GzDDyXdl3KpIVH+OsJ2ER4vTjW2hhEuTHgt1qaGGRQtSTlXmzOe26k2VAJ9xXQa6oxIh
         6RQA==
X-Forwarded-Encrypted: i=1; AJvYcCVoV9oPoDy6Z7REYYPhMX3IbTsFIYVzpGrHYEb5sS9IHaEat4dMRyAmz+qoZkWYjVnI/t1F6GWAIi8viO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4/XWS6AM0KTAEaqHwuajXo00hy8WafcQto1hOxliQIIv+JDV
	KiEWXrx+2YNDFlnnHF9VQ42xdV2P1uEsmMC/Wm+3Ds6BGx18iyknm/3UZL6rJj0N7eSwZL2D3JU
	2Cv2YnEqHFzYnba5HzLYOEFa6JLu6pWTn/AtAOxyMsysD/Vveas+cRc/uOuwe4Q==
X-Gm-Gg: ASbGncu8O/G7vy8JgZPbuebUblLwOXSHUcq+uD7MnDJEAzsFAItpqwnQwgETlA9ISdh
	qhco4DA/IroBbyFS0s8kgdJCeMJdUDK+otW0TpMcXCWyCzTYFu5+4rxpjJyj2k/76bGMofS+iNd
	uWZ807Q5mYDf08W4LXZ/DKl7E4Z9kElFLcgg/qAGfBIbS2qXdbXBmRcMOTlHELPW5IFVHSlxoPb
	2xMX9t9ouJq6ITKGj6egm9UO6lXxOkmSnldpOEfknSVtHGkM+Ftl+q8m0VacXP/mHx8WvjEBMJV
	MS/UBh0/oj9iPVa6jyzldM3E4LMiYhWQc9T4R+qKxOduJQ==
X-Received: by 2002:a05:600c:1d2a:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d3b9a3068mr14573755e9.16.1742288541407;
        Tue, 18 Mar 2025 02:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3MoVj2rFNREk2X3PyaxgWZ0vjggNG2HOk3QYwZwwTPXtRls/v5wq6NIwPPvIM1+s13Yb09g==
X-Received: by 2002:a05:600c:1d2a:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d3b9a3068mr14573205e9.16.1742288540915;
        Tue, 18 Mar 2025 02:02:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d21d67819sm122107795e9.21.2025.03.18.02.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:02:20 -0700 (PDT)
Message-ID: <aa21376c-18de-402e-bb0c-aef2eb7610cf@redhat.com>
Date: Tue, 18 Mar 2025 10:02:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] ipv6: sr: reject unsupported SR HMAC algos with
 -ENOENT
To: Nicolai Stange <nstange@suse.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310165857.3584612-1-nstange@suse.de>
 <20250310165857.3584612-2-nstange@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310165857.3584612-2-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 5:58 PM, Nicolai Stange wrote:
> The IPv6 SR HMAC implementation supports sha1 and sha256, but would
> silently accept any other value configured for the ->alg_id -- it just
> would fail to create such an HMAC then.
> 
> That's certainly fine, as users attempting to configure random ->alg_ids
> don't deserve any better.
> 
> However, a subsequent patch will enable a scenario where the instantiation
> of a supported HMAC algorithm may fail, namely with SHA1 when booted in
> FIPS mode.
> 
> As such an instantiation failure would depend on the system configuration,
> i.e. whether FIPS mode is enabled or not, it would be better to report a
> proper error back at configuration time rather than to e.g. silently drop
> packets during operation.
> 
> Make __hmac_get_algo() to filter algos with ->tfms == NULL, indicating
> an instantiation failure. Note that this cannot happen yet at this very
> moment, as the IPv6 SR HMAC __init code would have failed then. As said,
> it's a scenario enabled only with a subsequent patch.
> 
> Make seg6_hmac_info_add() to return -ENOENT to the user in case
> __hmac_get_algo() fails to find a matching algo.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Please specify the target tree inside the subj prefix, in this case
'net-next'.

> ---
>  net/ipv6/seg6_hmac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index bbf5b84a70fc..77bdb41d3b82 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -108,7 +108,7 @@ static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
>  	alg_count = ARRAY_SIZE(hmac_algos);
>  	for (i = 0; i < alg_count; i++) {
>  		algo = &hmac_algos[i];
> -		if (algo->alg_id == alg_id)
> +		if (algo->alg_id == alg_id && algo->tfms)
>  			return algo;
>  	}
>  
> @@ -293,8 +293,13 @@ EXPORT_SYMBOL(seg6_hmac_info_lookup);
>  int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
>  {
>  	struct seg6_pernet_data *sdata = seg6_pernet(net);
> +	struct seg6_hmac_algo *algo;
>  	int err;
>  
> +	algo = __hmac_get_algo(hinfo->alg_id);
> +	if (!algo || !algo->tfms)

The above check '!algo->tfms' looks redundant with the previous one.

Thanks,

Paolo


