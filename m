Return-Path: <linux-kernel+bounces-333296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BED97C68B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755C31C22E47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF2E199921;
	Thu, 19 Sep 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G77X70fw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F9199253
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736758; cv=none; b=phGYXVUHq/iXHdyEpRQ2TDNQFkXxCzanaehDz+4Y2Z5fvGPg8nA+YB9t3e5Ei68551ZYDOVaEt0OJmphFFvAFvJMoUDIeXGYXr+A7VGm1xyxGnflb+rNckbLoVq0TIH1U4adXvrXWl1D/95CR17vE9YGAg/oauAKoj9vHXJH3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736758; c=relaxed/simple;
	bh=VWWBTcxk4hORGaLkX+0fM//HV8ZJSc6yfLE5/ZxEq80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsXTYWIoq8XxZqzjk4BYcATYra68icA0NrT+znLnQKMRzHyBu310nawu3zg6w1dxIZfZDgDlynyP66+D5GKSVUiOhs1A6IKxyf7cfgAZqTtHjzoYqOfbtcArNq+SgheVMXxkjx8+nS7APDrBVAFNy5yGxyJpiCZGd6MDm0Du95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G77X70fw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726736755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnex9kdS8NwvyPRASviDUdMuudMC1PvpZvkVEh7NFiQ=;
	b=G77X70fw1ZBdLXOQuqT2yRDDz+2ZHNw+pwIJISNQbF6uLlUibLXH0Pp9LqxprOsi3qkHs8
	gBGOH7roApUfKQBoBnP9ewtPbzSYa/xkD0k+Cnb+yrb7q4h4LE3VKmJ13CUXgtUrfWzSlM
	Xpy1C7YvmAqA8jiItyqjD6TgpqGz0R8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-8yAM-TXvP0Gh2AqEJeRYaQ-1; Thu, 19 Sep 2024 05:05:54 -0400
X-MC-Unique: 8yAM-TXvP0Gh2AqEJeRYaQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c54e188dso837882f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736753; x=1727341553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnex9kdS8NwvyPRASviDUdMuudMC1PvpZvkVEh7NFiQ=;
        b=S528aqef2RSEt4+qCrFJP/4Co4XQIp/VTnA5K9pYtdc065VzWWsxDiTGARq+BYLYDV
         BTc6PalTuHc70VE9DwbjpQKBY3Aa022H633YXEu3JjtY+8VTlYiYuz37tnQ23BAgmfeE
         1KZB8zdOpnUty/OjvhQKFZCJI4tuNrO8KEDJVlceZ8/QVORw4p5UJM0rg9qrvn42CJL8
         myOyGjRbd3Ox9ptZdFY4RQwwX63leppVCz01vI6EANvHK01wFpiG0k47d+1Rm70VCc7S
         qT8+tIS4UkrqqLdKjK0CPQci636cclHruRdCWsNTYYoS2vlhBbMiffSVSd03hqW3tZ/I
         /hYA==
X-Gm-Message-State: AOJu0YxMUoijuPTqqBxQOUuMp4tQ4N0qUv4TQVNxLtf+Ba0NSMdXsBrP
	CX0uh32B4SKaEAAW3HDbZqEJuwAKFuCvpJjgqsWPT+1SQ9///+6GMKTEtSF8N+L0lvWDpcHF0rL
	DuKZcHkMNNfXy3700KiZg8wtr6B/vGbtDZ7H/4IO+A8zaQhhn47jA+GnFpnPrZg==
X-Received: by 2002:adf:f94a:0:b0:374:ba78:9013 with SMTP id ffacd0b85a97d-379a8600601mr1235064f8f.9.1726736752929;
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiXJ8EJ3vg1Ccjo7Mce+fhOayPgntM0rtjBpNHJcnp36weYWGzu7OgB6+gevN/ScNecv4iQA==
X-Received: by 2002:adf:f94a:0:b0:374:ba78:9013 with SMTP id ffacd0b85a97d-379a8600601mr1235046f8f.9.1726736752518;
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm14456762f8f.30.2024.09.19.02.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 02:05:52 -0700 (PDT)
Message-ID: <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
Date: Thu, 19 Sep 2024 11:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org
References: <20240910190822.2407606-1-johunt@akamai.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240910190822.2407606-1-johunt@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 21:08, Josh Hunt wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..196c148fce8a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
>   {
>   	const struct sk_buff *skb = tcp_rtx_queue_head(sk);
>   	u32 rto = inet_csk(sk)->icsk_rto;
> -	u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
>   
> -	return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +	if (likely(skb)) {
> +		u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
> +
> +		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +	} else {
> +		WARN_ONCE(1,
> +			"rtx queue emtpy: "
> +			"out:%u sacked:%u lost:%u retrans:%u "
> +			"tlp_high_seq:%u sk_state:%u ca_state:%u "
> +			"advmss:%u mss_cache:%u pmtu:%u\n",
> +			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> +			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> +			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> +			inet_csk(sk)->icsk_ca_state,
> +			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> +			inet_csk(sk)->icsk_pmtu_cookie);

As the underlying issue here share the same root cause as the one 
covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if it 
would make sense do move the info dumping in a common helper, so that we 
get the verbose warning on either cases.

Thanks,

Paolo


