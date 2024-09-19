Return-Path: <linux-kernel+bounces-333222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146297C592
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B0F1C22CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593F198A34;
	Thu, 19 Sep 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZPwgmMD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39F190664
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733429; cv=none; b=hSB61+zjeuP0GJq2qQrfn3/45rEcEBgx6ju7H+YG2Fsg57CTJargygm/uZu3OaqzNl1HidN1n/T3bWO7iQqnLs6q+yVjxAUlmIpxsQ9kbgyClPLhsofUpmF9UYxCGHs9XsLzIlsJBvKdTxqBF028/uGZiQ3A7P24Ql4dH8o8Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733429; c=relaxed/simple;
	bh=IMr2sDS7aX2NzKbeHBTrELWlyEAyJZIdbUt1cIwyPF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeXZQMgT8OLhYnNy6+ynYex1buyn3T3d42BeKvd0OH7lulp3HoRtbZQ8q7Zi3wRGfhuMPzFymuxEdFoK1qKGQlWcBNFOZwuDBdSIYh9Ce0qtnH1QKOnooCTMoDPmHJ6xhJV2g+qdq8Bb/PhQwXAA8JHHI84eLU8YEmu8xFxrGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZPwgmMD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
	b=cZPwgmMDBBrua0inyGjOCt1maSquCTV28OQ9vJyXKXT7fyXqeDdgSYsj/MRNxYTS4YhpvA
	aJhff2zlG9HmYG1hAAB0aEcJoMmj9qNjOcsUfs0xDD7u/5yXe+/6fjTIrCz92mGz593LtG
	3bDba00MxSozS9D5JMJx42lWFAOezFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-9dPSlJo_O5O224_AnfDNLg-1; Thu, 19 Sep 2024 04:10:25 -0400
X-MC-Unique: 9dPSlJo_O5O224_AnfDNLg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso3861945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733424; x=1727338224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
        b=dkA1eMqpsLMQ2Nq50KGt7Bc/RQM802hwJTwxhIGaKw5FW5d3OFHMMxMnAmgMHu2gW6
         KKSUH7n+lqy6nyQEwbWD27DrxktTVFbLiXt9pWI2g8aVAUj03whhUjB0wzWzn7lGuCK4
         nHOzfXk8AsGN5D1bjJiZx5jRQzHjtVr5aZytHiWtelW1Aw4EgmvgOxeul8LwP34sC2bk
         cyYaVP1tW3nrbx179EoC1tA56tW9IR6dhHc85PxUF2SG5xLnGu2iWAqZvCdg2p3ScK8m
         bx+tMQ2LAtRO6t1OiuVI6SizOm5Qa40lygxr2f3DgLwaQiySTIlkUSgRGxvs3F2K+84T
         mdKA==
X-Forwarded-Encrypted: i=1; AJvYcCW49kS/xAIDmirOGwGQ8y4ZPC2XklyY2laExCN9HibkFpyPXYdwqYuvDH1w+J1SJetq5EGRnl3MmhpUkP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMJjSolc/kau5VonDohvZ7Aaib1YOCy1hmdnQeyIEfhZotaU0
	cyrGkS2aGci+3ex2auy/yFU1U+GE5C1niaOqjHSxqAQzUTqzUclh6EMtVGXY+MZSXic1xvCfo9q
	lPNXvzM+5Q0RjgwshmR4lr/1VNYV5phskSohrNqoDgrhMdG8dDVclipXNTEHIwg==
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203453105e9.28.1726733424215;
        Thu, 19 Sep 2024 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGT0SwgVzRIkY/MUx4n23L9SMHSHNhM8DLpk/EIjcBzZveCWuxQ4pMW0o7cv6mXWtvyMK74A==
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203452865e9.28.1726733423826;
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75408abasm15477015e9.6.2024.09.19.01.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Message-ID: <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Date: Thu, 19 Sep 2024 10:10:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 V4] selftests: net: improve missing modules error
 message
To: David Hunter <david.hunter.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 18:00, David Hunter wrote:
> The error message describing the required modules is inaccurate.
> Currently, only  "SKIP: Need act_mirred module" is printed when any of
> the modules are missing. As a result, users might only include that
> module; however, three modules are required.
> 
> Fix the error message to show any/all modules needed for the script file
> to properly execute.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


