Return-Path: <linux-kernel+bounces-546291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E09A4F8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E763A45D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AC1FC0F1;
	Wed,  5 Mar 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C/AInHnP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5A1F09B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163380; cv=none; b=oWoQixIlN2/L6dCo+X/yZ944+X5mNqlTh/YJpiupmaWRqZzIEtk3ekVVGNN08PfkxbUa2H5CTbu9gCjdwURb/jrWpcQozmacjRAojp6j/q5WRu64M6O/XVxwzCVXhXzuZ9RHJjukAMSFhcMBeoMwOdVWP5iD7C+Z1D3rRWB5kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163380; c=relaxed/simple;
	bh=BIb8PPjZHUval8yQxPaR2VI3OQirSDX4w545WCXSCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNEh3aIMRTTjN8Md70w0zfDv9cRhPD9lOykS8oOxZ96d0fmVNpqH2+7yU6HlDrTsBYRhV6FsN+N+9/pmJJLq1myh3Oh8j9CaCwVOfQxgNjVCKXrfqPD+RWZSIa9dna9Nko4xPfGuEeOuFHRPfsuvUZGM8bztZTO9eImjHz03d/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C/AInHnP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf5f4e82caso685305966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163377; x=1741768177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=C/AInHnPu6QEjteXzTU/Y+8cXSDnlwTkiooAJDKunOxZzuyXInimEwnJpecJbpBo3o
         S0UwivWB0GwvIyxeMHaN7kHTe8v9oWO8YEWbnI+3h9H+r6sM9huilXAF30fpcyuJxNry
         vQHWkiNk5GpMBotSLwAx8VmIyzmnw31+gj2/wYmyQ9aohqYul/YubmdUtV1YULJ3ueUf
         FZSqkMhgWVa4aibkSIeJZkFHujC/3ywr1mpvpJ70ptJ9X3Voog5WLOfvXh2hdfwIEPpk
         cvKKZhVCj0ZGtNxECF8jjfftN1S7xScxZbWrwuJLw1Zf9y0aK/TKDnTgPwJSsBEVb3Ez
         mWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163377; x=1741768177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=G9mnUvOjNuy1HiZg+irS4f32aaOgNy2YxnFTf0+6QVBCfVT9hE6P0AyPYDDt0P0oZ6
         fLb3jO/msjKsd77bOT1ct7LtA2Sh3xWO8rxT7bKbZf3iMVSARdwd5U2cQ6YkuIK0VFG4
         lOm/Dz399q1EjZNQ6s4nwIwLlrBirqqxQw0Ru2qwDmUzbddme7uDJhKVTCvNNYHhiPvM
         NZ35RG11DZnBe4j3CnxHCLPLg6bsiEYnoomuwQoEn1DRlKUGTHmQf7xKzurtSvouu2nT
         1OBBKKwxTlX5O7m7t2tBg98qpTWd9Mc5bdPPlhGYYHJyHbhneasSRhIqmoVzq/N+EuRq
         fAfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJnTRBcBktdS5m0sMytGT670x2bVvO2JL8WJSqpVrGp5ZfhgcgAiSCaVuylK6Cf63oinRkYwzZtluwcJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6Odb9eG2URMkTT/OWpB8lfo/Gd3Bwhw9jUUTwC0rRZZhNSY8
	NXvtn1btmQ3ZooHmy/mY/fOuAhAN2YNzEsndx/Q9zt28rRZlqjJVNpheLkNnji0=
X-Gm-Gg: ASbGncu/yVK6Irt5IoepRQ1NSLV0v4/9CZt7zJiSXmdF+VUfP0Pg8Nx5jrresDBhVRI
	yx+XA5DnYmBLcMGBkz/KpV88tUf5C/af690mI4K8+ChT57GgrwxUG6ASfuAcDF3QLxS+cMwSis8
	M+NOnXJW+HHl4qilc/h0lmZMUYYn5vv9aRvmBa1cbH+glw5WL+8vM3Bf+5KCZBgW88wOoX07CSr
	2Zzb+gfTN7VrUpWnnII2vZR+UdtbfyjV3n1j4QMFGY1q75wUqNhK2aYNvBbihOsDBVykvPJelqA
	4jlgMlj5/R04zgWGg3/Q0dWb6CpMT55lcdB/pmp1rtx5nIJ1gJs315v2+UR+Dd59DoFchp2m92Y
	e
X-Google-Smtp-Source: AGHT+IEjj5zOJcj1/OsRfe5VF46uWo7cJGLTZaHw0tlhP7T8cxub/kFHcc4MiHV1iodJ3D5MAmAOeQ==
X-Received: by 2002:a17:907:9446:b0:ac2:b73:db3d with SMTP id a640c23a62f3a-ac20da4c87fmr226467166b.4.1741163376857;
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abfa393dd6dsm453290666b.96.2025.03.05.00.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Message-ID: <1975f2a1-9461-400d-8b3f-f40e8b94be80@blackwall.org>
Date: Wed, 5 Mar 2025 10:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 15/15] netfilter: nft_flow_offload: Add
 bridgeflow to nft_flow_offload_eval()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-16-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-16-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
> the nft bridge family.
> 
> Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
> nft_dev_fill_bridge_path() in each direction.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 142 +++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


