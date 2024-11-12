Return-Path: <linux-kernel+bounces-405987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D649C5A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09136B28496
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00D1FCF73;
	Tue, 12 Nov 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Qx07Rzdf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D51FBF56
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419687; cv=none; b=tC29EdxMh4L2qbtJwTL6x4y/8fN2Ve4arKFco6Ztr/Wk3cZK0agp7qbUcH75qsIjkhiyrKdAnvM1IkaFELw9JsX0SyTO9WI3ZqjYt9L/vCQU/sCn9nS2tP9gH/xKdrT6ZnOTjU9pawWl5xY0rNlSj26BzV7woeDovNbSX4ER5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419687; c=relaxed/simple;
	bh=ZMZvb5eenEVlVAK7NU4MVaoQzq+e9qO5UVHMkRNB0/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7HafA10/I4W7qcYm+Tf/BDB4DFO8Qcs8Nha3zX/oXoNtGIEO7tuSBWH2PnZAtnXP9C5wbDr/IWw2yF1bnHjh2vIxWiaIdKzg3NcJNh6uLRfbeuwtAgJI7qFosJ2Ax032oncHzcEZ4HuDFiITByyuKjECMugi/nEq4m8vGt4k6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Qx07Rzdf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53d8c08cfc4so3068175e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419684; x=1732024484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUPoYpaoCY5bSjD0hnfsMZTVX9qf6LhLIXWg4kEQyTg=;
        b=Qx07RzdfyWUncdyZxQe77f6f4M/45hXLSGlC1jEtUPCThooCDRUDsPSV8x9S2KI91u
         HMjUTXZgsxDU3TUX4f/BKiMFj3F4P1swKr3g7IN2THzGaTOiYgJxB3IHZyWsYXF91Y+K
         99rtNyxpJLatmnuxWAjbi9L5oRe2Nlo08DS5ij4EpVmMvE8Lj0X0elReQFCVGvTPpqTH
         VMl+WH9aq2plBidXJ7nwywJQsRcjWWKap/ZBrrweSfzysSKGexIOEoAdP6vh5z3piiXA
         3yhdWJ7mA6wrJSVsrZtcRTWyzWdufZNaYj8LYdPb2jG07w4zy7KyRVA3uhrwBUatqCIb
         l4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419684; x=1732024484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUPoYpaoCY5bSjD0hnfsMZTVX9qf6LhLIXWg4kEQyTg=;
        b=dYwz/2qFlATg6Z2/YGYof8YFvjdj2i4MJy8vx1wj7eRhFY83fTck6008aP04ErZmTm
         NvSBme0iVE5I9RZ3hhhLNPAms+eRpK2i8gh0hm2JBBj2sa1jKBqrH0V3lTiaHjJy2RRu
         TI9nqqD4TsifZhLUx8tYHwiuh99A1N0qFXsvch4TnCrHxHxAxxkzrsacTk4iYWtURpag
         Av+fvcJh8YLAixSRcDwh4GH3aRF4ZZp5W0xIdWkIUC/zhCvHG8T6SFbkiFWHmtRJS94u
         ieiLWZWTFzX+vdhHm75GZjeQDOjXjt4n7+Z/eEfA4jQ4ME8hxlJtesdzwz+7gL5t/Kgh
         Fr6g==
X-Forwarded-Encrypted: i=1; AJvYcCWe0YVYcbwCOWaHYKSZ93gm6Ho/CVZZodcBjF4W9EpadUh8fkY3wn8vwoW030DD8PXC+6dHaYPQ0/Htrog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqbOdsRr4qFgUDK3cJ/dR7p7Z2ZdhJT+bbIbLH5A5d98eyVCz
	w9RN0u4sdagZJuop/IHeS79m3iLJMOwseERyoS9NgBIvdZ+9O4UJAKMIFkfogkc=
X-Google-Smtp-Source: AGHT+IEhJNZNZNvtBRMcGOMn8NUVkxM0JofSVjyfWKKZ4cgz9r7+pCoK0OrkP82htIthEFTSnrGdYw==
X-Received: by 2002:a05:6512:3f12:b0:539:9867:eed7 with SMTP id 2adb3069b0e04-53d862d40e4mr7957329e87.24.1731419683866;
        Tue, 12 Nov 2024 05:54:43 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d9d229988sm123169e87.64.2024.11.12.05.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:54:41 -0800 (PST)
Message-ID: <8ef7f9ea-dd5e-48fd-a20c-13bc6b1e1505@blackwall.org>
Date: Tue, 12 Nov 2024 15:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net 1/2] bonding: add ns target multicast address to
 slave device
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20241111101650.27685-1-liuhangbin@gmail.com>
 <20241111101650.27685-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241111101650.27685-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 12:16, Hangbin Liu wrote:
> Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
> tried to resolve the issue where backup slaves couldn't be brought up when
> receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
> worked for drivers that receive all multicast messages, such as the veth
> interface.
> 
> For standard drivers, the NS multicast message is silently dropped because
> the slave device is not a member of the NS target multicast group.
> 
> To address this, we need to make the slave device join the NS target
> multicast group, ensuring it can receive these IPv6 NS messages to validate
> the slave’s status properly.
> 
> There are three policies before joining the multicast group:
> 1. All settings must be under active-backup mode (alb and tlb do not support
>    arp_validate), with backup slaves and slaves supporting multicast.
> 2. We can add or remove multicast groups when arp_validate changes.
> 3. Other operations, such as enslaving, releasing, or setting NS targets,
>    need to be guarded by arp_validate.
> 
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c    | 16 +++++-
>  drivers/net/bonding/bond_options.c | 82 +++++++++++++++++++++++++++++-
>  include/net/bond_options.h         |  2 +
>  3 files changed, 98 insertions(+), 2 deletions(-)
> 

Looks good to me,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



