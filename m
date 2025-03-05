Return-Path: <linux-kernel+bounces-546277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A6A4F8A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7088116FF2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58A1FC0E5;
	Wed,  5 Mar 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="A2bhTYH2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581221F582D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162899; cv=none; b=VegDeBSqGtOB3p6k6M3tsBpPjicX/UWara9WePCkXeoxTwNLZJecYQ6KTwgkjIxKZJmarrZhURQsr0t9iCDBqv4u6KjZZVjvw6akbRSnwtvyejJ4GEfWtQqBctWNm3EKOVdZvZaWqReWLxGA6cYVEXwM+QXQTsnazDx5fOP2Gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162899; c=relaxed/simple;
	bh=Dd3fU7x3Zyy9J91IPT2gBtr3RmiUZhQvAeaOmlAbIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BC5aSKoJy8cKh2xdLgWb+z5yTK65w3txHlOakHfo4as8kNPLZWbRUHd4TUJYYE0onreBNKRhCQiF3f9BVTHa80oi2QOpLQeVwpFyqkrzuCqhTnkjeA77Vmh46WjYafFmGQgKKfOiHY3ddBeoLBs1/RPqjACb96dafpr7mEE9JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=A2bhTYH2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso431720166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162896; x=1741767696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=A2bhTYH2IUKPMamHYkFV5kaQY8j11XM1Rkzkh8OksbViihKIHdIyYaOl68RIpO6mJ9
         0hS5ZGLixOaBzMhOI+yG6WhYFTQ4GvqL9Nc/G3etuoWG7vQVXGzS+zuwOJPAXifC/UTl
         XF/kDOlaCo9md4uupo/S3HQC0igucI4fKqBDm52qzqnPbGZwkujc/SsZj7uw3a/yqdsK
         R2R5d+LjtiqUYkiv8EgQiG4rLJm21gZmemC1eIyLxXGlwhxKO3jmhAf8UIXj0PwCpkfj
         sGTOddwdQTN5kI4jOrmHFMWg2zZHCLBhrGM/Fzp0lRv+M3RkPsvVT00gLuCjUT+aoHAy
         Qp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162896; x=1741767696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=YxioI+UAoxoIZbtnK5vRtTfSdUlJQOHIZdz4Jv1bxzULYpzw/6GUOamRHa24Ht0Bz8
         Utta0x792Gl+nIOO16BcMZ+zRSULdkIOfQtygGUzEg80KI7ELZ4IG0CsYZtJE5qml0LN
         Btt7NOyBtLn7jlUjUrwfVuixgIA255nhGAtuawmw67JzfEbYBo3g0fp8BX9RIK/a7Wbz
         zC6BWS6+LG/Wfap1Gec2VNiCqsuq3PS8YQSAgdckwXgGk1k9fImR+Djf/FOdZMxHYIxP
         DS3bmnWuXW6n8bJKvLRgXg9dUAe530kP2Vkmt81tZdytAUg/TKL4r1RVvV1/BRGMyCWN
         7lvg==
X-Forwarded-Encrypted: i=1; AJvYcCXvAggnwCpQ/OYn5dHVnHhUhqng8NGuiKNMV8HOwjgnV+Wii/EbWJa4Gk8svKs6F+YR+SZeqkIXVK8x2sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxr3L7+hyf6+AZe0ACvnGN1ykCmN0RdjGz6A5/qqIXVdsxTZRj
	w3dk3p03mLVB+oLTXysx3BE60LI9NmctGY/vbsXqNK4HY7wCYYHUwlLD+OM+Z1w=
X-Gm-Gg: ASbGncu3U6dLzpWdkdWFtG3ThDDxZO4a2kyxMkfQv8MB7rK6rPFWSA8y0OqUvCEae4j
	LwjReEaKSY9cHAZMnDyfYDLTKESvVtceEqURkin48kuAVv0KhRjPQsaHvuLa1lAYWMrovym/hYp
	HfyHl1sbfSZeU8ohNycv5xMsG/uAFbLq1P6I7GkaNxvHOPe2fYuL3pwUpaZQ/YlWBUbonUPqL6C
	ZgPGR/a0Te2j6VKoDe3ksJpEBufyXAnE39Dt4sEXK9eiAtSG5yWuzFFK3X2eA98EiYSO4W8gsGL
	CqlQua3cSSJ40vQFnu5/BMr/f+IyOSdVsnXzYprTHDd4KUHB9OVjMbtawm/UrMSfwmO3eCV/r6X
	r
X-Google-Smtp-Source: AGHT+IGaoXnq3lSxzaaUwAuVfK+jenlYaXFrv+TPSgSHSnmbmoUQLeCI462sahYSphebEzq/qYnUHQ==
X-Received: by 2002:a17:907:7f0b:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac20d925048mr217259766b.27.1741162895402;
        Wed, 05 Mar 2025 00:21:35 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58804b49sm693744066b.26.2025.03.05.00.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:21:34 -0800 (PST)
Message-ID: <b3b5418c-65d5-48bf-8868-2d9abcb4f758@blackwall.org>
Date: Wed, 5 Mar 2025 10:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
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
 <20250228201533.23836-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> It doesn't like that hdr has a zero-length array which overlaps proto.
> The kernel code doesn't currently need those arrays.
> 
> PPPoE connection is functional after applying this patch.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c       | 2 +-
>  include/uapi/linux/if_pppox.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


