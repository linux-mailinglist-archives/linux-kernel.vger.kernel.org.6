Return-Path: <linux-kernel+bounces-525573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F70A3F191
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3573BC856
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B46204F62;
	Fri, 21 Feb 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SZz6YHn5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93533204C37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132820; cv=none; b=LnpfIOeLQxEePCf5ORNdXmf/e793wQCR2W0Cbyfwv5khBH7XoQS8yhkffJh+mhBTV3JLJNCfpgVZ/6wx+ukvdg7IF34eRhVl50FXYewelGmp4ar4APWZFv1kD4Oh7cHQCTVB3/Xz4/69k5D2+r+tLAN8i9fA3nfIh4s7S+C2eAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132820; c=relaxed/simple;
	bh=nr5kJWhpCk/uCZ14BjEdkNFr7R+i3EPr+TWyKqi1BDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9H1NPDmwrRcr1W54+asxOoRSaa+89lf0l4/rABOH/DiJHITDyhsFtteCDgDHIiSQawE57j387TzzXg7WXdl5YBkIxodufPt8XPukebu6siDr6+Y4esChnBJSZ+LUt6emRjrLig+06bgw/wOWof5eNK2lZefvw4rqkEe3Ko5kFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SZz6YHn5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38c62ef85daso166704f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740132817; x=1740737617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UQQWiZCCYCChMS1t+rH0U+Cvy3EWJF3uRAMtMyoybGg=;
        b=SZz6YHn536951oywpGeOGAUSnhSmADgeZh6sUVlNwIwUPBcdGlxqDqabI/Xcdr8WYw
         eZaTpzRWA8ZCqmn9wCPCY4j8YcLKV/aEof5yPr7qJ5naC7mJSCMylWi4Suy0kCZHnZCQ
         xh7VXk0zBShGs7GCOFnxxOvS7iya1Y/DsHGUFhjtTMuRmw139ptBkhxZK7G/gp/JLVb9
         X7oYxbpkhyKRFjuVKTmGnZZt3JjmSp97Xf5ubG7/Oq1BJ2+dZrGBOMa7rrNVP62BZvDB
         LQiSSDJ/cVw5j4Zztf5JLesW4Tu4QuIzaRP7d/jvgNDBMYWOv+/enPyQPRniAPCz9Aqg
         dNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132817; x=1740737617;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQQWiZCCYCChMS1t+rH0U+Cvy3EWJF3uRAMtMyoybGg=;
        b=dFy1JbxwTv9TSpPpj78as5/f6CkgZekJFe8LfYQimDO8QuX8X5qxki5bNKswBHqvPm
         MqZPQaLZwMS/pCkFZeYTX4IZFQ1eEmJLkp0phVFFuPtMZXRJ3TNxC/5DtX2NcUBabzC0
         tvx92nica1vkpg79hHxzuhw70iL2BxuxXQb/YzuPLZdIzZieyx5RRjaHXu5MHQs7Ew+A
         XByia7Be3JJpaiLzYnsUoLDG8PZJbNRuUG/ukbbuMHmdI77BGITvNyqAiuW4mDQUDUTq
         Ck/1dQck46S+9NfsAd9k33z3afhfgmEhntTCOdoVZvyXlSj1xL1GurvinUQvhFUPcg8l
         mQXw==
X-Forwarded-Encrypted: i=1; AJvYcCXC2N2D0FFZIWWMBwfnpetUgkloPvZnOor+xc6SQQdRc5LuogHDmC3C6+bUMdHHa4jipIes5v/RBJ6k7ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39PB2V718XlhznOk/d58dLCEykLf60aFS3Y14YYkCFIRcrKis
	qRGrgiDmK8U622WtuOvDOFbLrt2HtcRS5PtFlAzsCLfur40YHSqAicfD5AEMzQ0=
X-Gm-Gg: ASbGnctQ2TtXmEcvTmXN5ojcrw92NhkBX0kpDeMEKV0Maqwry5vfcCePTyrTDEEQUL+
	CAx0VhpImAcFja3WTDeCt/5SA7n+ZtrTOdiMclhjTWWWd/47ZF6fCaiMTokbyGrsaxwGkSvYBOf
	djzCjyzLymbTw5GeVO+3TyAq0Ck4+10G8EKCKY8Q81ytQRjrJgzbG1djotO9+2pQr2gEWE9kOpp
	hodKmAnihFR67LucaBiGB1AKiymmPk5oHY72PcIxNIEr+FC25dO5PQ03QouWFBOQcmVlGNLVxdb
	fs+SBMofrbFGDCC9AinF/ZBpDPw1vv9bdgmYdNL++gfAkkzIeMMfU8IewtnRm07Pk3QKt/N58A8
	Ov4c=
X-Google-Smtp-Source: AGHT+IFF0hqJbw0BkCdH9ok2JHMRD4EHl6xOSx0rPM/EYkiGqsgM9af9DHGXWwV6BsQS5eWQsKFFGw==
X-Received: by 2002:a05:6000:4103:b0:382:4e5c:5c96 with SMTP id ffacd0b85a97d-38f6f09aa94mr656909f8f.8.1740132816833;
        Fri, 21 Feb 2025 02:13:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddba7sm23288242f8f.38.2025.02.21.02.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:13:36 -0800 (PST)
Message-ID: <6202010a-412f-4d63-92a5-d78ba216c65e@6wind.com>
Date: Fri, 21 Feb 2025 11:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ipvs: Always clear ipvs_property flag in
 skb_scrub_packet()
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, asml.silence@gmail.com,
 willemb@google.com, almasrymina@google.com, chopps@labn.net,
 aleksander.lobakin@intel.com, dust.li@linux.alibaba.com, hustcat@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Julian Anastasov <ja@ssi.bg>
References: <20250221013648.35716-1-lulie@linux.alibaba.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250221013648.35716-1-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/02/2025 à 02:36, Philo Lu a écrit :
> We found an issue when using bpf_redirect with ipvs NAT mode after
> commit ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> the same name space"). Particularly, we use bpf_redirect to return
> the skb directly back to the netif it comes from, i.e., xnet is
> false in skb_scrub_packet(), and then ipvs_property is preserved
> and SNAT is skipped in the rx path.
> 
> ipvs_property has been already cleared when netns is changed in
> commit 2b5ec1a5f973 ("netfilter/ipvs: clear ipvs_property flag when
> SKB net namespace changed"). This patch just clears it in spite of
> netns.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
> This is in fact a fix patch, and the issue was found after commit
> ff70202b2d1a ("dev_forward_skb: do not scrub skb mark within
> the same name space"). But I'm not sure if a "Fixes" tag should be
> added to that commit.
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7b03b64fdcb2..b1c81687e9d8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6033,11 +6033,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	skb->offload_fwd_mark = 0;
>  	skb->offload_l3_fwd_mark = 0;
>  #endif
> +	ipvs_reset(skb);
>  
>  	if (!xnet)
>  		return;
>  
> -	ipvs_reset(skb);
I don't know IPVS, but I wonder if this patch will not introduce a regression
for other users. skb_scrub_packet() is used by a lot of tunnels, it's not
specific to bpf_redirect().


Regards,
Nicolas

