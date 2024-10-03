Return-Path: <linux-kernel+bounces-348794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CEC98EBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FEA285B50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3E13E04C;
	Thu,  3 Oct 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIRWbWF7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCD12C465
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945754; cv=none; b=gBie6jWmMa0bS4MmxPb03IzfU4OeDczR4AWk3ckdk7hXybvomuoTakAjb35rRzgukOhscyNR/QdYWYTZF3viOtf+9Ax0ccErhd2fcURcb6ecx43w2P2ovg91jvLYy2vcuZpONnD6mx+e49Ccy8zf7Hsn4aoltDve2bhprZFxlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945754; c=relaxed/simple;
	bh=/ls+Usjj0lpRKVwE40z6h46uE7yUpqkPPHw9jtcK6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT7JLv5PSc8MkME+rvQvJhlQSqUxvddjWLTXf6Xybq4Ajds/RuEBdbgFdGsazIjN0TlS0o34ubo5tYnDUxFa7dMLGksetMLWkw5Dhx19ZBkFgNy6cEHTRZFi1tVE8CIpLejm8oMUymLLQ4BekAdrBXssLr76FjHqZhlry2mYXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIRWbWF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727945752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNyleeSBIrkoz+o+G4sN8Sg53/W0Jp8BT6862q5Zags=;
	b=CIRWbWF79J2p9X8rq4t1BEuMTEE1H2imxqNLhKV4GF9p2RGydj5hrW4cJA8pNabwfTXgeK
	UjLyW1DetIkNbSLpTSyj3qYgvx1bHoIgacRaz27qltQ25UwLJxiMys2VpVcS2XDHuDqNHA
	yYBWmeDOmeEIEoHxA6E5RUPSBj14HKM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-Dd2XS6IoNDuZQ7mBjsLVHA-1; Thu, 03 Oct 2024 04:55:50 -0400
X-MC-Unique: Dd2XS6IoNDuZQ7mBjsLVHA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53987fc3625so411427e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945749; x=1728550549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNyleeSBIrkoz+o+G4sN8Sg53/W0Jp8BT6862q5Zags=;
        b=ILm194iYU+koQb+90xhSnn17Hg6Ja/n1TVcmDI6lrny2GAqe836SOKSPR/YmX1Uuwu
         TfXF71g1KEC9qcEBMC8JcYYPTpqK+Lo2jfdFNPKon2Qu+4F/n1Cbj5URkGsQcwe6X8EA
         3KckZXrHuZ+3wZgGpdUIX0IvhjSpofNvVQr1w2rnT2hc6T1SmULKF3YOg2P26Uu73gzs
         CQIFRaAGREnytN+dkTSkHdQWWgrceltv5w6T+EmEmPXzHZie/25jWzjl3g53yhy2uDxi
         02UdrkpQTFCEQiyQ/9Re8yiCFU3fFdaTcExgpB7wiviEY3rdQQoSbEy9MKLRmn2VoTji
         X9gA==
X-Forwarded-Encrypted: i=1; AJvYcCXsO8nsmhG45cjf9Ffnpws2R88fP3hmuB7UKldqD74bGh4eZtA3thY/i0fHHmi5cYGlEQvnwLNtxTaWxXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZuf/gSwxk73nPn8W3O2P3ZJhc033ZFcLikVqHRzcpksdvbCT
	kD8QzuYlSCI0LTTLQ43ComIVbBkpbK8MzjrXyZn4Ah6vLAl1jbgWZ2dbgo6I3Fi2O7TKTsFVyqf
	cr3zJoGB/kTxSCRt5o9p4LsPEQTYglbgRxC2jSE1hApoAL7GCKqSOlt0SXAhw/w==
X-Received: by 2002:a05:6512:1054:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-539a079f5e5mr3663104e87.42.1727945749288;
        Thu, 03 Oct 2024 01:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7QwxJ8KaZj1SiIC8+qvQzggg+ESKlt1wUj9pnPdfIIZHMWzpqbpbEcdhtk92ID+wFhtG63Q==
X-Received: by 2002:a05:6512:1054:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-539a079f5e5mr3663091e87.42.1727945748883;
        Thu, 03 Oct 2024 01:55:48 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0476sm10011435e9.35.2024.10.03.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:55:48 -0700 (PDT)
Message-ID: <a9d896a4-b279-41f6-a492-980340e125ac@redhat.com>
Date: Thu, 3 Oct 2024 10:55:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: retain NOCARRIER on protodown interfaces
To: Volodymyr Boyko <boyko.cxx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927073331.80425-1-boyko.cxx@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240927073331.80425-1-boyko.cxx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 09:33, Volodymyr Boyko wrote:
> Make interface with enabled protodown to retain NOCARRIER state during
> transfer of operstate from its lower device.
> 
> Signed-off-by: Volodymyr Boyko <boyko.cxx@gmail.com>
> ---
> Currently bringing up lower device enables carrier on upper devices
> ignoring the protodown flag.
> 
> Steps to reproduce:
> ```
> ip l a test0 up type dummy
> ip l a test0.mv0 up link test0 type macvlan mode bridge
> ip l s test0.mv0 protodown on
> sleep 1
> printf 'before flap:\n'
> ip -o l show | grep test0
> ip l set down test0 && ip l set up test0
> printf 'after flap:\n'
> ip -o l show | grep test0
> ip l del test0
> ```
> 
> output without this change:
> ```
> before flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	 state LOWERLAYERDOWN protodown on
> after flap:
> 28: test0.mv0@test0: <BROADCAST,MULTICAST,UP,LOWER_UP>
> 	 state UP protodown on
> ```
> 
> output with this change:
> ```
> before flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	state DOWN protodown on
> after flap:
> 28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
> 	state DOWN protodown on
> ```

I'm unsure we can accept this change of behavior: existing user-space 
application may rely on the existing one. I tend to stay on the safe side.

Paolo


