Return-Path: <linux-kernel+bounces-369904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8259A2441
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DBA1F225A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CE1DE3AA;
	Thu, 17 Oct 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idlEASvI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC1C147
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173050; cv=none; b=rUjYUQlWiVfs7QHl7KGJnjUdbUwfHeHKwQKkCdWuBRfRXF/k9Z2WjX1bFHBpDqx15YgYcUmbHATLnZ0RZJ2hVAI7EbaIkmjT3+zb1A3W9mTGYv32hxueGB8w6ps5IGM6ndwMcTxfD2SpBhA/892U1SPLQ9NYyHPpJGEmgmEZDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173050; c=relaxed/simple;
	bh=0kiMruivn5sR1S/hdNpt+B1SgIh69J+y0aPNpogB6hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTL8MOVPL6f85KTnhPsfg8DH9VEyfGu5TGNL9ekhlhtfTW2ImPCdzvQnCN5TxhxmcML2edLJH/833mxtuLIumxOtrXRx+53RKRh4Ica4mqtMfOq1o6rjVr84sWR4JriXf4p9aCL0T5wPNna+WgYYkjN6X4aOZFUcSTga4AUBkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idlEASvI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729173047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUoCw7O+udpupZ1krJqWVivBS1P10uWZSnJENIxNC7E=;
	b=idlEASvIl+6JA5C+WvGw5ZdGAJfis5UrojRTG3cO3H7cVEUCmTYCTjuoUCMJu2mDjlfS95
	f1b9voFiqylZzt5fINFcBj1IaD4+TCK0DQ/s0FB0jHp/c8qnc55v7mkI0f0VTzp+EqwOPE
	B8XiRLL0gvFSOloKhfV1VwqUsiBaBDQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-rKf4tIWlM7G1ot6fBzZo-Q-1; Thu, 17 Oct 2024 09:50:46 -0400
X-MC-Unique: rKf4tIWlM7G1ot6fBzZo-Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d458087c0so1164954f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173045; x=1729777845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUoCw7O+udpupZ1krJqWVivBS1P10uWZSnJENIxNC7E=;
        b=R9Ux9PuXH1v4xSgaEZXhs5bOkYvm6GJyTNiI3dRFTOtDYLtQ/mgSZrYja6N/AK8elK
         BaD33ACeeGR35heM2lEa90w9fzo7FJcq3zRNtKY9xHrtqe4uG1OdMUllepu9QQQpu/6t
         2Zp1/ixV6rnqQh5+9S8tTaUWKUwOJ3+43nhPaOF14f8vI3uzzUzI8JWPZlFUiJYrLjrV
         vG2k3hVjtBiVgP50PF2n1oilOb8BS1xMF13TxPriMIkowMrLalNNXGdiCnGKGASxJgqz
         JuNaDVkwGTgvQ0N1QBnOC5eq29CfWukHzz+MhZSN5Fw3jKACb9r7VWDNG/5MsVSjyZeZ
         oBsg==
X-Forwarded-Encrypted: i=1; AJvYcCXv07gTVkV+upXtd8AR4E7mQLBeVkTvhqU0HW3a5aeRnOqaHkA/bpkjwnXxyOu5xoROvm0Jjt7fXsF/Uw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgkYeSfoC6DO4d7c5bQIn40xYKpF9M1Y9MX+i3r38f1SP/gIz
	pZ7XBsSadFFNfOxBpfVIDxKrH5TOkd+1NGXUC4cvvxasfe87DbfdIdscHO+5n9tkru85AEjYQSX
	gGMUREi4ol60yVCJmglRUzW2nefTRxQ+r3L72hVkTmW5QWT10YukUHK67+mGbCw==
X-Received: by 2002:a5d:4523:0:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-37d93d6f846mr2282200f8f.7.1729173044745;
        Thu, 17 Oct 2024 06:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhGd0kmB84bPm5BGxcvF542yrzYCKZzHl6MB1HTiiAw/bvvCW1oEQoI5ipr7eV0aM69D5MIw==
X-Received: by 2002:a5d:4523:0:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-37d93d6f846mr2282172f8f.7.1729173044377;
        Thu, 17 Oct 2024 06:50:44 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c38397sm27155905e9.5.2024.10.17.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 06:50:43 -0700 (PDT)
Message-ID: <d0fa8332-aeef-4d33-9167-b9716b050594@redhat.com>
Date: Thu, 17 Oct 2024 15:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb
 reallocation
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com, Pavel Begunkov <asml.silence@gmail.com>,
 Mina Almasry <almasrymina@google.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <20241014135015.3506392-1-leitao@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241014135015.3506392-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 15:50, Breno Leitao wrote:
> Introduce a fault injection mechanism to force skb reallocation. The
> primary goal is to catch bugs related to pointer invalidation after
> potential skb reallocation.
> 
> The fault injection mechanism aims to identify scenarios where callers
> retain pointers to various headers in the skb but fail to reload these
> pointers after calling a function that may reallocate the data. This
> type of bug can lead to memory corruption or crashes if the old,
> now-invalid pointers are used.
> 
> By forcing reallocation through fault injection, we can stress-test code
> paths and ensure proper pointer management after potential skb
> reallocations.
> 
> Add a hook for fault injection in the following functions:
> 
>   * pskb_trim_rcsum()
>   * pskb_may_pull_reason()
>   * pskb_trim()
> 
> As the other fault injection mechanism, protect it under a debug Kconfig
> called CONFIG_FAIL_SKB_FORCE_REALLOC.
> 
> This patch was *heavily* inspired by Jakub's proposal from:
> https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
> 
> CC: Akinobu Mita <akinobu.mita@gmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

I'm sorry to nit-pick, but checkpatch laments that the new command line 
argument lacks documentation in 
Documentation/admin-guide/kernel-parameters.txt, and I feel that could 
be actually useful.

With that, feel free to include my ack in the next revision,

Thanks!

Paolo


