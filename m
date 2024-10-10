Return-Path: <linux-kernel+bounces-358652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB289981FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EC21F21AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22851BD512;
	Thu, 10 Oct 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWkEQ6Lk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076C1BD026
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552015; cv=none; b=FJzD5Y+fiSkiX7JFkQujGio7lSeD1ZmRlfuwbbJIju+lNZPEF+H9GhuwCpV3IYEmO/niMdnKEdINm66RgqiS7KEMrctcs/RS1OD0uLp8W/Vp1B81rIeBC30klxL2OIwAFMt8X/RolRbU+UmTvzsOrEb1uHE/KhibfGd25k4m2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552015; c=relaxed/simple;
	bh=gt2Q8i+/uL6SnPG+SqIIUvv4iq2wBJWCilwcTB+uC2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rChjLezqwvPdNEPFTn5/OszYvNsP4BhgSg2gCnz5HEJ9sPGQ2WmHo/t2OSnB6TBAPigQu+wcw6q5AmaCQnMIxOKiL8rcWs4MBURD79u83xVtU8pue1obsGogO0+HYmKtHTcNWsD/5Af0zdIuku1f7W9Yipo2QeG4W7HkKCnzoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWkEQ6Lk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728552012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2EUHF55AVEM97e3j7jFpqy1lpH47XxEwMg8191duf8=;
	b=PWkEQ6Lkwcz2bAvCklPepqYMReNZYxMDtaJiaj1lNY2wM51muQaw1yE20JOrr3X5h6X/uA
	mtBEDXh3+rvYIAnllXQWiBOZPzoE+FrIg5C++9Nh9zEtxuCi6fsuCaBhkv7HSyo99aduJL
	NFnki2PqFB1I5cF6en6ZsEQTOJh/2J0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-KQi6t3NcMKmlHW-rZIAGxw-1; Thu, 10 Oct 2024 05:20:09 -0400
X-MC-Unique: KQi6t3NcMKmlHW-rZIAGxw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d325e2b47so348421f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728552008; x=1729156808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2EUHF55AVEM97e3j7jFpqy1lpH47XxEwMg8191duf8=;
        b=vv0nLX5K/SxfzlNaNfVZUngTkC9l5504lRKtRI39/AqVYChwpUywFNAuqvW46JdypD
         XQyVYUDddr3D/LytHBWVQ+gjc4N3uNOYl9OxXPXoXl7NkJQmHmGWzVikY3pN0FedSwwU
         QBt3dlYF64ABOKcyIBlQQfhCg1RlchGny5eP7G7+KJzP1wrU/jwRyTSAB7Or/JRUpHSU
         VXdlDloB9oxbpXiq8iqWGD8AXhzjpFFtOmWHZvAzf5Xz3V3q6LUd8emPGMD2OiPltSPB
         Aj2lk61Y7qm0x9kWJIgurwKhL2AkKROCew/blGI6qK0i4U+29YYgH3JNe6jkVMlv/jNd
         MJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQbqFvWAm1Wvy2GZVSt6kdsW1PHdthWQhMtEbMPDx1/CkIEiVQwdPdFwSgrcsTclmX99N57147AVBz1Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVOlJZFABZvNzco1P36IiRN0AO/1obk+/yK9PMFFI2FCAqjFC
	KYiYjKfgn9YXKkEpf2uc4EpgFYAQkmQ2pYxWV5r7wOciq6JVR2yPmaY4/Oc5eCf0ePsxneKrKfv
	qIe92X9oEZNnGLrdQA80sV2XbNDkhthfoIqbzPDHXo9WUmdy8NaPd9kin+vj2yg==
X-Received: by 2002:a5d:6908:0:b0:374:b71f:72c9 with SMTP id ffacd0b85a97d-37d47e9d085mr2387102f8f.16.1728552008548;
        Thu, 10 Oct 2024 02:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdzmtcngiF6R3pU93/9HaNeh0a1Th7Q3WQBAnseARGFC78C7arTlWMQzmNNCWluBuGpiZQJg==
X-Received: by 2002:a5d:6908:0:b0:374:b71f:72c9 with SMTP id ffacd0b85a97d-37d47e9d085mr2387085f8f.16.1728552008187;
        Thu, 10 Oct 2024 02:20:08 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa3bsm974757f8f.78.2024.10.10.02.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:20:07 -0700 (PDT)
Message-ID: <822f5875-5ec0-46e1-83f8-66ec1e31f0f2@redhat.com>
Date: Thu, 10 Oct 2024 11:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Implement fault injection forcing skb
 reallocation
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com, kuniyu@amazon.com, asml.silence@gmail.com,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <20241008111358.1691157-1-leitao@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241008111358.1691157-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 13:13, Breno Leitao wrote:
> +void skb_might_realloc(struct sk_buff *skb)
> +{
> +	struct net_device *net = skb->dev;
> +
> +	if (skb_realloc.filtered &&
> +	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
> +		/* device name filter set, but names do not match */
> +		return;
> +
> +	if (!should_fail(&skb_realloc.attr, 1))
> +		return;

if you wraps the above 2 statement in an helper() taking an skb 
argument, you could wrap it with the ALLOW_ERROR_INJECTION() macro, for 
added flexibility, i.e. look at the existing should_failslab().

Cheers,

Paolo


