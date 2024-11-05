Return-Path: <linux-kernel+bounces-396324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB89BCB99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4511C229B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A21D414E;
	Tue,  5 Nov 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxC3rNLZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9171D362B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805765; cv=none; b=Gjvv50LWNQb5QPci7BCkEr9Bp6INNIEXftHrmqcqT3VycuMc+ZLSxRe/f75yR/9H2Avjz3DlGbGJQgyVp8tjKHkUh5X5TxndMLdnC3knyzhjONlw3u7TQsw8/5UmhoFXhN1TjRsA5KnCftyFA7Da05X8F1w3Z51SrOTxm0LFYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805765; c=relaxed/simple;
	bh=DREiJ3+9uPmoBRjO+WZh8yLPw0vGXk6MYVHENj4AzFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDg3DDyybxpwc+b7xGfnCAgNJOvMHfFD+xYFLbGuB5fmJzfvyx3O3UfJQ5Jpt1VP4ULPeVIsG2QVMnbpFky1WpOEfV7F+wJ3dpp+hApKpPkgZtwoE4JsFrLqtHfWwSJigN5RDMbbeuJjwrxJoh97/tvIhfQP5LrDHeyZSVci6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxC3rNLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w4cqL75qypebxW4II7sYIZNVtJj6dqkjoh3JctPnZs=;
	b=UxC3rNLZRLKbE/zRFbUlPXagAo0Fbzr+6/miF+wk/OowqzrCtsGKhBi4fZyo1KjwVmudot
	ImObGztQpt/R/fretnrjSPwm2V8+ehJLIOIlAxiP1VuHxyOrjkwVOaqtncEJOiJGZOXOl6
	jXJqMs0iWd5W2UY06pEVF5ikUBBXWDw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-b4JUS1NIM5mk7Ue0egjpkw-1; Tue, 05 Nov 2024 06:22:40 -0500
X-MC-Unique: b4JUS1NIM5mk7Ue0egjpkw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539f7ed336bso3361543e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805759; x=1731410559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w4cqL75qypebxW4II7sYIZNVtJj6dqkjoh3JctPnZs=;
        b=hV20Aye951iCckHfP77uSCcdNmH1oRBOoobafo7Z+MZoDzQtdieZWDdBbaOWBtY/tP
         TIlN+pR/RawKaDkFp2P6MPTBirmc5Wwjyj9jmIrVPikkTaVngi6GcHf6Lv5JsEr7Ew40
         fZUZRXUETZyDgS7hZ0j0P3EwDPRausQj+zVOkydZWyiiEAklkXb2aeowRUcK1PnOGWKd
         MYjjBxBgys75rbBCD0K+ZpK86k9GX/ktVUvvOxKFMYsPWOt7w3yRkoBW2BI81ODqYLwK
         ZiQZiriYPlBaKmd62SWJaj8Tjr67Ubik5IG/bKuHeW1QmaAVTSgVl+dK7PCGVcPH+pNO
         wbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9b4k3eWdSpzzikLUxv0Nz4OBbRvyuUNCx4dwDTOM/GH4uU0vBICEvxnsM3Zplt8oonsNy3UoFA97QrpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvqfPdd5dzZhkscKpqiWiC3pmBxDpzVhO5ZaVcQCxGiablT+X
	uZfiP8t2kiWNTt6nypkbIAuZ5RnCB5a7Yl0l8Y6XpIyPEzv41LCa9G3zf1W3Tih3k1ZetCMVNyo
	HHVwerZtgYO7VPIFzL9LUZD4hTpV2lb8Bk74CsuRqmGyFs2Tidb5BU7fJ5Ui6Jw==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id 2adb3069b0e04-53b348ee5c3mr17252889e87.33.1730805758679;
        Tue, 05 Nov 2024 03:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkZhLSHmVvI05Xa7tNeYy4VrWo47n8S+oU5OPC7haYZemC98IoPNLINInGw/qiJ6rXUQ23dg==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id 2adb3069b0e04-53b348ee5c3mr17252853e87.33.1730805758231;
        Tue, 05 Nov 2024 03:22:38 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7365sm15705047f8f.54.2024.11.05.03.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:22:37 -0800 (PST)
Message-ID: <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
Date: Tue, 5 Nov 2024 12:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 6/9] net: ip: make
 ip_route_input_noref() return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org,
 idosch@nvidia.com, dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-7-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030014145.1409628-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/30/24 02:41, Menglong Dong wrote:
> @@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
>  
>  	/* skb has no dst, perform route lookup again */
>  	iph = ip_hdr(head);
> -	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
> -				   head->dev);
> -	if (err)
> +	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
> +				      ip4h_dscp(iph), head->dev);
> +	if (reason)
>  		goto out;
> +	else
> +		reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;

I think the else branch above is confusing - and unneeded.

Please move the assignment after the comment below, so it's clear why we
get a TIMEOUT drop reason.

Thanks,

Paolo


