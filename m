Return-Path: <linux-kernel+bounces-571577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A2A6BF07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DB07A979B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E2221DA1;
	Fri, 21 Mar 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiujNw3b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E423BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573117; cv=none; b=Aq3I9MvNv7XCKee+kQNRRaZGgSK3KP1uzFQsS9KBGURFLru9omMue0v5si1pBS2Vr3LS5Qs19kbnxwF/DDxZ3qT96+e5+QemVXuUyR3C5+2OW4moAyLsf797mnaJi4JJb+DJ0IlhfunmI3icNluMNjkaJ8LSt4mYegc4fDOnlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573117; c=relaxed/simple;
	bh=jwkfakE1DANkUqJuTwsNFFdjoRqqoxIpJ6eThYSheqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9bLWd+tMOHK1BsaGSMSCloqlqKN7jGoWZQHI5AOZ6VlIGAsUh729G2GeQ5yW4kfR6Px/4aguj5t5YHSfTVJi1HeElrZt+pbhfaG+sUdC2FL7FST5MYSh8tUDT72au5WJ537KRUeQ55PH9kb7YDdDUkM71Ync8izTbesVpNwI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiujNw3b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQs45VA5fWWnDDs/npKdUUvsMmoPlZhByWdxbH6ndSA=;
	b=TiujNw3bdpfMa+599HnvE939NA+nKTjc5pwlNDxOjIaoqceUJaHqFvL0HevRBgjJYQ1qb3
	1x9NcjRxE7W21ms/xKkU9A9vRflimnXZj37IQ73XhlMVo1li4YEbcargIsKUbwlEl7KLH8
	FDVH3p91073HPi7ZDkSn5KDFtsph0Gk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-hrDe2uZ2MS6x2eihuirPWA-1; Fri, 21 Mar 2025 12:05:12 -0400
X-MC-Unique: hrDe2uZ2MS6x2eihuirPWA-1
X-Mimecast-MFC-AGG-ID: hrDe2uZ2MS6x2eihuirPWA_1742573111
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39126c3469fso966591f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573111; x=1743177911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQs45VA5fWWnDDs/npKdUUvsMmoPlZhByWdxbH6ndSA=;
        b=G3nadA2b9q1KlrrB+QgG4RpOKjPsC9IIefmPri8a9aTnAtVNl0EdTEKzCF1gLML4UJ
         dUyiq/2S1srkNBqKDoFUGkyWLsGNWkmFbkPhmZIScH4i5AS+761WbpDB+d0TTwLgJ7rZ
         Ndlsp4yOVvsnK21nnlfyzStoInMpCM1LT6uUvn+2f5KVQhpeQ0Cf/tCASSVhUuwaCvJM
         Ii1vTM0/rtonmBYd7tj2QXpZ9JnWUtRo5Mc/0iL8OzKLF7oBAiKKgBFj1C+/L72qJOqg
         Is65yS0lGIdJI2q1MI0G5/+7AiphhwMzmHR6zmYhZoZpYHq2+PX3qvMLBuO102wV6zWg
         mLug==
X-Forwarded-Encrypted: i=1; AJvYcCUt2Zt1PJDqIK3ezLIm1MjFCtpJNJdGbFCbniCE01XQmZdAdYDgAYORd3bp1Uli3tW5vJNgmzTcVyMlz6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5U/AWGzyP73Dx419z0lHA+VzSAJfL5ZPElmaGa4bSBjeoFa/2
	t0HNmgcnC9qVYRiPpbUgfRvD6mjOguSyr8vjX8i1nZmpyvrGDpn+aGnKyZ77INl+/A8gNVws2Ma
	+dI+NeeKrC1RYI62OwJbYFcqRamEl4r03y5XaspVmtxQX2GplxwId3RHfMv5nqg==
X-Gm-Gg: ASbGnct5LZzj3TKBcBO/P2sQn5ftpGO1apLBWVmnRQ3OsP3PzO2fOuOC6TSl6LnBXzh
	+bJjXkDpTolkGMnB8BIfJHqBTIVVHF7ihwUgosKc5S4FkKtXqJLskTvXC/rliGb55Ep/pRyyEbr
	q+F8wq3YNoQ72WUaUUuutEgBMlVOokoWkkDONWxLvWi0fjwMdoV+9NSWQofxQ3gAVqPgyYNgl5j
	IO6OMhD5ipp6zdopaiv4j/NwwSb29+4KIX+dsn2qUxH7wZffbgI8+JmWzbuQtFstCqjhroX2ENL
	n7fWTFBk/7UBCNM7Vhk81OJg/8n5EODfjUc0+rItDM+HRw==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr2910927f8f.42.1742573110942;
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv3TecOdXmFWBmFPlb9ypBRevwbrid5djH7Ctu3Ye4XmZRGvPpKB+zPMx70FJNmpZ1uxRAAg==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr2910895f8f.42.1742573110537;
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4d9sm81992925e9.33.2025.03.21.09.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
Message-ID: <08d9509a-3291-4856-8129-1e440df10b29@redhat.com>
Date: Fri, 21 Mar 2025 17:05:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 4:30 PM, Maxime Chevallier wrote:
> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I'd like to have Jakub on-board here. He should be back soonish, so
let's keep this patch around a little more

Note that MAINTAINER changes go via the 'net' tree.

/P


