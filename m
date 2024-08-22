Return-Path: <linux-kernel+bounces-297119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646EE95B369
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21994283EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA9183CB5;
	Thu, 22 Aug 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW3ljmRa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E005183063
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324560; cv=none; b=SkmIY2Edpae1qqeXOdExJzF1GjGzkbunkbk2ig9GUPhR1rkwctXvQ9vHCHAEgXbUxQkQJ2kNIi1D0Cm5f5QSqclQvPzXMmYSSc9wlY5jJi/VYp1zdmKbQB4ERGK1AFYEtDIzORwBCoSHz7UfJiWrR3X/Wykh1dDbDhwD+VJnF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324560; c=relaxed/simple;
	bh=2nODh978mMzK3j0GjNsmpF8YNFjkBxrPTFe2CgovZbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq1T+24i/6ys2ArH1k+0wbqEqC5UHoJUM5gvxOBks3tP/jzBHnyZV7NKPLOYhVztmn6XVoI2NQqpJqTi9yMaHH29BOWPLJvXGSy4gTqguRND3F2PSGZtXdxIRm53La95MB6FDe/EzGt6fYgFXETn8GkprDZMhF/uv0fr7NfLimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW3ljmRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724324558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkldUBIK7FYjS/3cQzFqhh6w3aGsW6ya31tCj3iSXs8=;
	b=DW3ljmRaH8QxP+hH9B4IOryfeM9X0ymQ59winFouWK5uUNamV6tyIo1PQPT5budb90x0Mu
	Vrnlws27JFFB6KrlBuYEq2k3RHEdpq/JyPkcr/ZBxCv9cjmsP5vMPnJWoib6k/SNhrE1bH
	9JMhv/nVOrLZi1/7irSfHl8TYhHTPy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-zNaQLyDVOG2peX81Ofaiww-1; Thu, 22 Aug 2024 07:02:34 -0400
X-MC-Unique: zNaQLyDVOG2peX81Ofaiww-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428e0d30911so5479085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324553; x=1724929353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkldUBIK7FYjS/3cQzFqhh6w3aGsW6ya31tCj3iSXs8=;
        b=HwXqB8f/ob/0POIP9N1rccf5JS2aiFDVV8RnfwuT8An9T1mH7LXaZ7k3ym3uObvBK/
         M7UNdYfKfA8qs9SZz0ywwuaGwE4QUMLBH9EzCZNFR6tTd2Wx63/OJwiOMRHBauynXe9/
         WGQHBjKYQhTodEVjtNsnWa+wGDlmniMgAQlnmlFXbbGE5769u9B67Yd0+YiX7iS/7vTF
         mbmEc1gNrha1owLXPstvPAUsmxWzIBxQRnIdzuUBE2W9006a8Ez58CHS2+hQ9ph/o8ys
         p6IFAtncZEO6sv8AH0mQ/rBGf62uRJrGS0nzBsdmqJPqITL1t+3RmTav6SGI9S6eyvB6
         smZg==
X-Forwarded-Encrypted: i=1; AJvYcCX7kJ0MqOk8dqGvdyZjoXhU2ZY/8DqmFV2PjN+U2XSZxeCKSTZWE2uis3Xtcd1mbI/Nn4tHl+p26Jt7y+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGxVdfR/oo6CHXpXVxmDTqq3Eg2B/UxaC9A1YntyzWzNEm8I9
	WGwi3VvPct1iXbed2Vi/d8Rh0MSABewUPNNZMirnHVPBaMlrwF9/n82CXyXBH7w88hUlnQScZZc
	h43+pXeP1TG0OtiXDIBxzQneAUssSaK3d5m2oi189rtAuhkn+CnUp9DDNwir09g==
X-Received: by 2002:a05:600c:524e:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-42abf0a9948mr35751365e9.34.1724324552984;
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBnjCtefwrwoXOwIfy4zozQekcOrOC3c7UFCnsmdTFsHXi5VMk8GxYOLmUniZcLdcFxziotQ==
X-Received: by 2002:a05:600c:524e:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-42abf0a9948mr35751095e9.34.1724324552430;
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
Received: from [192.168.1.25] ([145.224.103.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac624bb23sm15992425e9.32.2024.08.22.04.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
Message-ID: <313e8573-6c84-473a-90ee-ef98b553dd3d@redhat.com>
Date: Thu, 22 Aug 2024 13:02:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Fix setting of PHY LEDs Mode B bit on
 RTL8211F
To: Sava Jakovljev <sjakovljev@outlook.com>
Cc: savaj@meyersound.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/24 04:16, Sava Jakovljev wrote:
> From: Sava Jakovljev <savaj@meyersound.com>
> 
> The current implementation incorrectly sets the mode bit of the PHY chip.
> Bit 15 (RTL8211F_LEDCR_MODE) should not be shifted together with the
> configuration nibble of a LED- it should be set independently of the
> index of the LED being configured.
> As a consequence, the RTL8211F LED control is actually operating in Mode A.
> Fix the error by or-ing final register value to write with a const-value of
> RTL8211F_LEDCR_MODE, thus setting Mode bit explicitly.
> 
> Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")

Please, do not insert blank lines in the tag area i.e. between the fixes 
and sob tags.

I'll one-off fix this while applying the patch,

No need to resent

Cheers,

Paolo


