Return-Path: <linux-kernel+bounces-345714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109798BA20
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF050281750
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE551BCA15;
	Tue,  1 Oct 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd4QyEhQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD061A0BC2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779993; cv=none; b=D5ToVbvxj/Wv74MEsF5gMJ3XiH0PEWDlleB09L/W6qKleQSQdU8B6a5sXTR6kDFsr/PnDFiDoPHm6CHs7fCncO1m/3W8ruDJPEDkAqDRFtP6JSccl4V03bp7KxnK0dKrZxbaJxhPdx9r0WeteVa192CGXdBCq15xIF12+5zhTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779993; c=relaxed/simple;
	bh=XuyIIsC0q2Rih/ZhD5fZ31RnR+EEe/FthAZjvjlGG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSoA5XZJSaypv+ccHDzMsoZd49OiLkPY2M16hAOcr9GnGbGmpw6Cai/v2kZ3C+AjzsB2BuJ8PGWKTl0T4BWA358V0gvDeLD+2WrVM3Wr63xJO95j3e5+c3C8CKt5ZUHdcV2/4PqubHTssRwibuLSbfTsxmZoWw62tbnQTUSGUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd4QyEhQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727779990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pQ1AlhU9UokTGuUARDQY2eHTDfm42za/gYP56k6yH4=;
	b=fd4QyEhQoWsOQMyOwoBwRsxqCJ1CTW3qVIBXai3wPpvkOyXGlJwFS5DZMAsMLurcE7nYwg
	/zj2gIOwwe97Es5sxpHQk+Ot13vZoFztw5JAUkQ3fzXh7xXmmsIewC5l21RaRCl7eHvnvt
	nG1tr1k5djiZrss/rvzWmzgxt6niVHI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-p0295PW7MtGyunGikutftg-1; Tue, 01 Oct 2024 06:53:08 -0400
X-MC-Unique: p0295PW7MtGyunGikutftg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cdd84aa87so1761454f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779987; x=1728384787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQ1AlhU9UokTGuUARDQY2eHTDfm42za/gYP56k6yH4=;
        b=l4J+MRyntYMM2xVjjJ3w98Lwi9sXACaK+gxiYPehIYtPugUY5cOUXLZdyy88h99dzR
         L9fyQqP/2OmDOId3EMGJLw3NanE/N7wXYe2suIZu4PIB0UaVs6/4BG1pKp3zKFjI/1NE
         fyQL4DBJmrPaYwaVZrzJ90CHkgQFdixKp8cWRXMmWH75b+GIubAfqUw3oI8l/XPMe2RH
         7PKHIBDIlKIly/H7RyUZujhi+xJRcLB6OINkgIbj5QD9z1lyYwWMzPQGiKzcct/cbF8l
         Tp7XRJSvWIl9x26TMB+aKSTNemR8e5cz04h2lZMdWjyBbiXm3IzYiVjH+CTKalSC4J2V
         xB0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+b1K9PVHHRRo19JNSZ1cAaFxiUKDx387H5X8e7pYqMM5YZ9KCa8rGoC/LPwQZiNEuHZ18z89YY4+jnlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmAjMdelY/EpAXtGEn0RKItWZocao+reIrmvSmBdvodeqmlf3
	V0Xf49B78B7nAJhdabvfkM3dGIWMFT+F/WToDbNsLmJO34hu+cFzTL0tONsMXzgAz6CH955Ni+U
	3OUh/ud99hmOGhk26dN7XBaMyb31AQo5AVf4OOV0U5Q2kRLTQjDv2093M+3v7hA==
X-Received: by 2002:adf:efc9:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cd5b10563mr8454561f8f.59.1727779987428;
        Tue, 01 Oct 2024 03:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe7VXlUFT1uvkGozmj7C17mw/rd7IWAi+X8MHmH71Qeo99+VxBECVGlI+0PEUHMu78OItrkA==
X-Received: by 2002:adf:efc9:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cd5b10563mr8454539f8f.59.1727779986977;
        Tue, 01 Oct 2024 03:53:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec19bsm131519495e9.26.2024.10.01.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 03:53:06 -0700 (PDT)
Message-ID: <53c7fc83-7599-451f-91ff-309e55defd48@redhat.com>
Date: Tue, 1 Oct 2024 12:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rxrpc: Fix a race between socket set up and I/O
 thread creation
To: Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, yuxuanzhe@outlook.com,
 Marc Dionne <marc.dionne@auristor.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1210177.1727215681@warthog.procyon.org.uk>
 <20240925183327.GW4029621@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240925183327.GW4029621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/24 20:33, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 11:08:01PM +0100, David Howells wrote:
>> In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
>> thread that will handle it.  This is a problem, however, as there's a gap
>> between the two phases in which a packet may come into rxrpc_encap_rcv()
>> from the UDP packet but we oops when trying to wake the not-yet created I/O
>> thread.
>>
>> As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
>> no I/O thread yet.
>>
>> A better, but more intrusive fix would perhaps be to rearrange things such
>> that the socket creation is done by the I/O thread.
>>
>> Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue and I/O thread")
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> ...:wq
> 
>> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
>> index 0300baa9afcd..5c0a5374d51a 100644
>> --- a/net/rxrpc/io_thread.c
>> +++ b/net/rxrpc/io_thread.c
>> @@ -27,8 +27,9 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>>   {
>>   	struct sk_buff_head *rx_queue;
>>   	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
>> +	struct task_struct *io_thread = READ_ONCE(local->io_thread);
> 
> Hi David,
> 
> The line above dereferences local.
> But the line below assumes that it may be NULL.
> This seems inconsistent.

sk->sk_user_data is cleared just before io_thread by rxrpc_io_thread(), 
I think accessing a NULL 'local' here should be possible.

@David, could you please respin addressing the above?

Thanks!

Paolo


