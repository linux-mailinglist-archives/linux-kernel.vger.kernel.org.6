Return-Path: <linux-kernel+bounces-536169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BBA47C59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F429188A1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74A22B8B6;
	Thu, 27 Feb 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vks2NUrX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D05229B0D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656153; cv=none; b=UDWW91LLaAgy4NeEvnHOEUoFj3BBeUz4+B3HcB+zYOFaOLu+Cd4SHmyxHEeD7XdiIgJG5o0MbvrI+6X+le3x8iQknVUFo5LfHFi3k9qSUfbhvSRpUpTHHtxdHl8sT6O285empdL1kEaqhCIXKrxnzlqiN719W0Xk/73eUadSryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656153; c=relaxed/simple;
	bh=yiZAFGownciFW9C8pYdbOaOuIKjDlNJ3Cuf1SO9ZFMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEaAJaEWyASFp+P3p9TaCGQtWnUlsqhjJEf9g0cVUU3ITxppNTYlci18qQnBtbXFwST1FNF2DhcqEMT2LAXiZ6Wpn9wS/LPsLrCoZsamHoO1vOTie18jlEpej1bszcn7yC1SmhSVS/r73hA9u5MGgTYu/hbgSgtPQ2zTnp3lBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vks2NUrX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740656150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khbGFvja+UbsW5FBuBru9EkjceryEbMlLSZuTH5f8gQ=;
	b=Vks2NUrXHNm1J+sZty8SW8VDFsIVfdcSqOoAfaa4uwOe2MjnwcoVvWq2sQUsmF1yipXemz
	wuGR9+fEZkIXIvx6OjXmvmOXpQOZNsk/sxnH3SKwsRwVq/GWyj74GKOvTCg04mnDsRVBQP
	dkfveYa5suNHO8robko2S5oAMt5CGTs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-RoA9eiekPT-pI2iMGRgO0Q-1; Thu, 27 Feb 2025 06:35:48 -0500
X-MC-Unique: RoA9eiekPT-pI2iMGRgO0Q-1
X-Mimecast-MFC-AGG-ID: RoA9eiekPT-pI2iMGRgO0Q_1740656148
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso4253525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656147; x=1741260947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khbGFvja+UbsW5FBuBru9EkjceryEbMlLSZuTH5f8gQ=;
        b=FEKQoFT6Mfl9qmoOLgMbqKSlUtaDP5E4kzHsA6SqzvfVpJuAHTTMzkw4FBHmao9vCy
         nJVe7oWH7MrDyY8lhnSJCanSYxuVST/D9Uz8oheKtaa3G4TImzuuNMhs+FdEES1alw0Z
         Kc8V6TvBeuj4p/h3HNecaVSGZ0bkk8hV1hcQvetO/OnqwZfxlx2eE4mQLnqMOMQ9BeLf
         sTn9hzvFDtWLc1QYAxml7oBaHOcrQnav5BI2CSh/WM/DD+YYjpEwC/w2+EtSrBo9tmRg
         lW3cmDaiznFDXUNGjOF5t/0KNxE74mm7CTkzn3XYlMlWI29IU8H5ccJxNBg6rQfi+rHJ
         4u2A==
X-Forwarded-Encrypted: i=1; AJvYcCWh9Ljt7jRZrR6ypoc/q189f+Bu20PRzmjHyxd0UVFg+c6aYxKY/GPIyMYPJk7YmJtM7Zdma1PxUkSolG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8y3blOHFk64NPX+ApjHb2cDAR5AccoElCYdWo7DV2YUgi/tRq
	x/lPDiojJLb6CBjss7Fmg8rCmT/ssOVlcGXihmlSAE/kp4+tVxBc/iICSzmpe4fl0UdC/zZcEaG
	6I6UpIRfv+kaKmfhGUo3yhOxdbTg1ucSYHT7HahnLv9DG6obFMd3et5fm5ZXsIQ==
X-Gm-Gg: ASbGnct8ZkZupWaHzX3ma/33+rS8ieEzpzdG9Pr/7AYBag2TJigBVDLosfy5A/y1vyR
	DJz9hcA1Xoy4rJWZ0iDi1vix2crkCxSNsFQFGA++csVLVKWnwn0kBWuE0lSlpQGXyEmMF3sdWqR
	Rx/7Sc66ZtZmGPdR+16QStAARd+5rDpMrw02JGl8YWT6tDSGeTEytYVOr0gXbNh7OUYOtNh1XNm
	uccVvjI3R9t/NyxHXk3kjME/vpyzURW1bzrf4hZ8ze47jdUI64+8UjjdKH/ffWuCPrjXwovb4vD
	zrsiM9CGc+fUUT0MYdkaeqs7bQINSaZ4CjUZEk1c2XueOQ==
X-Received: by 2002:a05:600c:a01:b0:439:84d3:f7ee with SMTP id 5b1f17b1804b1-43ab0f65f98mr78685635e9.24.1740656147650;
        Thu, 27 Feb 2025 03:35:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS/GgREoVIsUdOyYK2cmbUIpaE7GHf2AINeRnbw4WbKOlcNHC8lrdKq5StwbJ13XcfnPtkzg==
X-Received: by 2002:a05:600c:a01:b0:439:84d3:f7ee with SMTP id 5b1f17b1804b1-43ab0f65f98mr78685375e9.24.1740656147261;
        Thu, 27 Feb 2025 03:35:47 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b75esm19348065e9.34.2025.02.27.03.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:35:46 -0800 (PST)
Message-ID: <4c260b13-3b08-409d-a88a-e5bbb3c18e03@redhat.com>
Date: Thu, 27 Feb 2025 12:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
To: Peter Seiderer <ps.report@gmx.net>, Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225085722.469868-1-arnd@kernel.org>
 <20250226191723.7891b393@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250226191723.7891b393@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 7:17 PM, Peter Seiderer wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>> When extra warnings are enable, there are configurations that build
>> pktgen without CONFIG_XFRM, which leaves a static const variable unused:
>>
>> net/core/pktgen.c:213:1: error: unused variable 'F_IPSEC' [-Werror,-Wunused-const-variable]
>>   213 | PKT_FLAGS
>>       | ^~~~~~~~~
>> net/core/pktgen.c:197:2: note: expanded from macro 'PKT_FLAGS'
>>   197 |         pf(IPSEC)               /* ipsec on for flows */                \
>>       |         ^~~~~~~~~
>>
>> This could be marked as __maybe_unused, or by making the one use visible
>> to the compiler by slightly rearranging the #ifdef blocks. The second
>> variant looks slightly nicer here, so use that.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  net/core/pktgen.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
>> index 55064713223e..402e01a2ce19 100644
>> --- a/net/core/pktgen.c
>> +++ b/net/core/pktgen.c
>> @@ -158,9 +158,7 @@
>>  #include <net/udp.h>
>>  #include <net/ip6_checksum.h>
>>  #include <net/addrconf.h>
>> -#ifdef CONFIG_XFRM
>>  #include <net/xfrm.h>
>> -#endif
> 
> This ifdef/endif can be kept (as the xfrm stuff is still not used)...

FTR, I think dropping unneeded #ifdef is preferable in c files: only
such file build time is affected, and the code is more readable.

> 
>>  #include <net/netns/generic.h>
>>  #include <asm/byteorder.h>
>>  #include <linux/rcupdate.h>
>> @@ -2363,13 +2361,13 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
>>  }
>>
>>
>> -#ifdef CONFIG_XFRM
>>  /* If there was already an IPSEC SA, we keep it as is, else
>>   * we go look for it ...
>>  */
>>  #define DUMMY_MARK 0
> 
> A now unused define...
> 
>>  static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
>>  {
>> +#ifdef CONFIG_XFRM
>>  	struct xfrm_state *x = pkt_dev->flows[flow].x;
>>  	struct pktgen_net *pn = net_generic(dev_net(pkt_dev->odev), pg_net_id);
> 
> Maybe better this way here?

I think the unused define is preferable; I think pre-processor defines
are cheaper than static const.

Thanks,

Paolo


