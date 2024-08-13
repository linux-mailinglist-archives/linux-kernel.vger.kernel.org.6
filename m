Return-Path: <linux-kernel+bounces-284626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADE950340
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3235AB26E99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCB198A2F;
	Tue, 13 Aug 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsRBCUMj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DE17A583
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547183; cv=none; b=OKii+K9mWRyjnk1vbE3mRNX11C++XDLSDOvX7Huq5QDAWoaHKsrySEIL0ZyKnncOPEtY5IrZPFgh9qlCGMMKvbKeYlhdw+riaYwuxt/jR4cgPGiuRuPgq3ZKVgGrE+i8F8gvMqJsQp0EJG3UYzW5+EjBMvlp9ycsyvJQEtthxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547183; c=relaxed/simple;
	bh=bkhqbZYWYWSZvsQl29u3Z23IpM9oWQsNayuAc+Nsvbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0LxyNETgss1Uu5b/3IJn5cM66ysS5vCNP7b7N+GlCeYPGoOjTwn/AZBMIjMNH6mZW+8YJ81qKsHmAsK9m5RAPBpD36zZHWTd2cbBOPrHEdObl1+naI2Z/8GV82WVCpK38MLBtqC3bHljS/YLZ63QnLFx2fil7yaoDB2OvDBwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsRBCUMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723547181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2NdeYI2y6Sud7cQVQ4w+JoVN5gbV8B7m8JMtP5JxuA=;
	b=TsRBCUMjFSgKArNRL+c5D/5noXlqn/rHZn53FAHMwurUFzLj/8U7XBwL6iG5JJMpZZohYw
	uxsEd6q/rjZJyzirEQMh1rrjWmdCzPc6/U6JIBZNI+X4iVSqBhlB8Sebji3mzRWCC0vpl7
	Nh18d+R+RjmcE9tgBsh/TyxhucLXayw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Kq7MVmywPca4zZ6E0w534A-1; Tue, 13 Aug 2024 07:06:20 -0400
X-MC-Unique: Kq7MVmywPca4zZ6E0w534A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281d62be91so10408035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723547178; x=1724151978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2NdeYI2y6Sud7cQVQ4w+JoVN5gbV8B7m8JMtP5JxuA=;
        b=gS5jAiadqSx+z8G7WwPqqXWo43wMOZWmpKXx0IAhWvADS5pKdeKhbWZCyZ0rthTpQg
         pvoYaFpQkrcjXjc3M9qwBEbmFSfRxaGSvmTqEYKQeUefjBBYPjPpS8dC0QhARJH7Un9E
         1H0e/UZeqakl2FpKlMhDVr7WrmuExqgoPpH+hYEUgbjtQEz9g/21sQ9jjIszsy3AGySZ
         U+Ok7ZqwLM8+s4M70qPlkjCkcmfgrOvrtThlnPaLw7rgoTtUDsEEkGZ9b6RdZbGbrJbM
         nNlTU0zj/anBhOJxIBJEezBKw0feD5ezw8Angl8/lsQbEhfMKCUTbaunuS1fXzHtV0Vh
         88eg==
X-Forwarded-Encrypted: i=1; AJvYcCVqxBy5esgp6XtnpDK6LU3G8FQWshhgel4Tr375XTLBQhoiEh7DkL8WdKEXU5xwbLmp7xJRON3I6qiwTGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O7RsUTcQnlJBIk8LTNPUZDI74ahxd/4VgQ9A45m51c/VOb56
	5fSP/BLC7H8AGaqZHgcDCnmz27OwiL3ilX9ovTBiF8VkebtgSHJG98DfleiGBfBdhEfJorOb9yF
	qOV1xkU8s56sFKZYNEOfYv3oR4BF75EbCOToZwc7WqQGgrhqbdtNeFrNXjSp5uQ==
X-Received: by 2002:a5d:6d82:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-3716fc78f67mr732475f8f.7.1723547177673;
        Tue, 13 Aug 2024 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7Vi7jbvh74+IcXC90KHicELNDDcvYfv7kh0HQ3hv001MY6PHY4Uwx5U6i85VLvRvhb37Nw==
X-Received: by 2002:a5d:6d82:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-3716fc78f67mr732456f8f.7.1723547177128;
        Tue, 13 Aug 2024 04:06:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfef6fasm9961156f8f.60.2024.08.13.04.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:06:16 -0700 (PDT)
Message-ID: <8fe01ef6-2c85-4843-b686-8cb43cc1f454@redhat.com>
Date: Tue, 13 Aug 2024 13:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ipv6: ioam6: new feature tunsrc
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20240809123915.27812-1-justin.iurman@uliege.be>
 <20240809123915.27812-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809123915.27812-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 14:39, Justin Iurman wrote:
> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
> "encap") mode of ioam6. Just like seg6 already does, except it is
> attached to a route. The "tunsrc" is optional: when not provided (by
> default), the automatic resolution is applied. Using "tunsrc" when
> possible has a benefit: performance.

It's customary to include performances figures in performance related 
changeset ;)

> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   include/uapi/linux/ioam6_iptunnel.h |  7 +++++
>   net/ipv6/ioam6_iptunnel.c           | 48 ++++++++++++++++++++++++++---
>   2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
> index 38f6a8fdfd34..6cdbd0da7ad8 100644
> --- a/include/uapi/linux/ioam6_iptunnel.h
> +++ b/include/uapi/linux/ioam6_iptunnel.h
> @@ -50,6 +50,13 @@ enum {
>   	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
>   	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
>   
> +	/* Tunnel src address.
> +	 * For encap,auto modes.
> +	 * Optional (automatic if
> +	 * not provided).
> +	 */
> +	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
> +
>   	__IOAM6_IPTUNNEL_MAX,
>   };
>   
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cd2522f04edf..e0e73faf9969 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -42,6 +42,8 @@ struct ioam6_lwt {
>   	struct ioam6_lwt_freq freq;
>   	atomic_t pkt_cnt;
>   	u8 mode;
> +	bool has_tunsrc;
> +	struct in6_addr tunsrc;
>   	struct in6_addr tundst;
>   	struct ioam6_lwt_encap tuninfo;
>   };
> @@ -72,6 +74,7 @@ static const struct nla_policy ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
>   	[IOAM6_IPTUNNEL_MODE]	= NLA_POLICY_RANGE(NLA_U8,
>   						   IOAM6_IPTUNNEL_MODE_MIN,
>   						   IOAM6_IPTUNNEL_MODE_MAX),
> +	[IOAM6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[IOAM6_IPTUNNEL_DST]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(
>   					sizeof(struct ioam6_trace_hdr)),
> @@ -144,6 +147,11 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>   	else
>   		mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
>   
> +	if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
> +		NL_SET_ERR_MSG(extack, "no tunnel source expected in this mode");
> +		return -EINVAL;
> +	}

when mode is IOAM6_IPTUNNEL_MODE_AUTO, the data path could still add the 
encapsulation for forwarded packets, why explicitly preventing this 
optimization in such scenario?

> +
>   	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE) {
>   		NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
>   		return -EINVAL;
> @@ -178,6 +186,14 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>   	ilwt->freq.n = freq_n;
>   
>   	ilwt->mode = mode;
> +
> +	if (!tb[IOAM6_IPTUNNEL_SRC]) {
> +		ilwt->has_tunsrc = false;
> +	} else {
> +		ilwt->has_tunsrc = true;
> +		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);

Since you are going to use the source address only if != ANY, I think it 
would be cleaner to refuse such addresses here. That will avoid an 
additional check in the datapath.

Cheers,

Paolo


