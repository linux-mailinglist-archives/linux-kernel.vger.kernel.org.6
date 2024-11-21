Return-Path: <linux-kernel+bounces-416706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658A9D490A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C09282CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE031953AD;
	Thu, 21 Nov 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW88O+cf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D113BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178507; cv=none; b=QHB7vgJUrDECL/DmPgcgIol0fjXnIzVkZ+9Ui4HH/mQjzhrXaZzphChPO/cD9bxqxfv+dv/hJBHdk6kgE/6XFjLrzmR81hd0XVFGpudlkabrNf63B/aF3MCW8Q/Oz1RzbcYbMJ1Q65Y6SYExotE6C2c14O6kyzWwqg6wGeeAccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178507; c=relaxed/simple;
	bh=OakpjTtQorQ2BeUpm+/i89nPTw9w4eLYabvPpcRfSGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gHueb7GeXG2bEwSQ+ueBN4TQ+eAgKi0Yddan9NpJsXvhyIG6jmpvryUub+ADb02HmtqUjvAXjgEBlVAbOrQU0QwWBArT1EaerTC6V+x0cOgkJZH6MABjbkclPetIXTE0/qQc+aT7JlP2ByQu/eWc3obJGM7DehxP3kvd196ZArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW88O+cf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732178504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EfxJ3fmdocd7gaMUfcoBEkyZJYyM0opLmf/LIX4Ouc=;
	b=XW88O+cfxBIJe05Yavc4gJMFg4NBU0bq0njcGMb9OonvcST29M8SZHvELoDOiKaRNX7fQF
	hLytolIz42zBUrC2tjfqfZVY7N9Jm+BmgAmEOvo0PEY5eF88ldCxRP0Dlv/u2ZS0jqNmpS
	QPyjGK47D5bHBz9Tsf+5dC/dNn3TutE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-mQAmkqG6NQaj2BA5qsmW6Q-1; Thu, 21 Nov 2024 03:41:43 -0500
X-MC-Unique: mQAmkqG6NQaj2BA5qsmW6Q-1
X-Mimecast-MFC-AGG-ID: mQAmkqG6NQaj2BA5qsmW6Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38242a78f3eso368987f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178502; x=1732783302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EfxJ3fmdocd7gaMUfcoBEkyZJYyM0opLmf/LIX4Ouc=;
        b=HdE/n+aJjTn5kK3ljNl/YawVqaK7JZOYZCwtHBUEVaEegR9waGU+1LbDQ6/eB8srSb
         7cyQEXV48fBNgCXB15MrdDubnVLiAGmqLTaO/rMdWDqGVGdvS1D+aa/zNJ23vksHKn4b
         CfxZJY5vWFOh1SDWI+Dkh3AJwyEJKSnxllYIBcVlauBreoYrA3hK2tLYw0HvNiM9C6DO
         vjfXKRpcl1qKfZ+n5zdXDkVhjTn1rMdWLRDrW9XSg/j6w5MKn7batf0/0+qB7Yfb9dQe
         WfC2VBjG5fqQGkZsjuJ++RhM9glknBkwkZZvL7ZEv19yNf2FuFhKhkXXQo5TyMD0wozd
         cbLg==
X-Forwarded-Encrypted: i=1; AJvYcCVe3UpXkWoAl6zRyfpImZnuzztvsiB/RuhIh38AmiJm3Y+GKRURqBCxeE4KSzrm1MOWu1CPLVWmiIiMcLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypT0qCBe4lErOs9n7OcGZrulWrjDji9eT3iuzWyrQE2kDt87h7
	nemm9Or/O2vmmQpnM6sZeFAdDFLsFFwurFtKsp46Lfk3Vw+A+JWgb/A2BcgNt11WSzKRG9FXQDK
	p3+1WxkgAb1Yii4fhDLLs30q9X8XVLxGZvktIXA823o9IIdOD8/iQP00pKLiQtg==
X-Gm-Gg: ASbGnctCpSjMntLoqoUiGRWOgx2WWTqapcng5IhGQ2KwyB7vJ+ob4TCVdyQmT+3y0JF
	+4iPUyD14yBIbjS4qwfXI26w8ZBgFU+2hT0kYLvCjMxOvF4O9FM29T9jpAtp6xbDopd5AjhNuEK
	ZYyZSUDBEaXlPccjpdlND4K363VnUvevtk4VBWilMillgS4fgGjdBL9EBNCaF80Mtx/1qr2Q33s
	DkhI+wx+y/pbZcA+W+JYl22UMNm4I5NoUe1o6Tvg7zHZ0P0fEyWnQdBR7+gVYLmwbQVaqtPlQ==
X-Received: by 2002:a5d:5f54:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38254b2905fmr5006758f8f.48.1732178501994;
        Thu, 21 Nov 2024 00:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWXza0JZ2QIRJ4eZp5svlyv9eMdR/9gHUUjPVmepznkQmbAhjCmDV1VegOdet0I40IWemEKw==
X-Received: by 2002:a5d:5f54:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38254b2905fmr5006743f8f.48.1732178501624;
        Thu, 21 Nov 2024 00:41:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea2bsm4297621f8f.87.2024.11.21.00.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:41:41 -0800 (PST)
Message-ID: <13a81556-d28c-46d0-85d6-d2fb1620d24e@redhat.com>
Date: Thu, 21 Nov 2024 09:41:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] Add Aspeed G7 FTGMAC100 support
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 08:50, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three FTGMAC100.
> The main difference from the previous generation is that the
> FTGMAC100 adds support for 64-bit DMA capability. Another change
> is that the RMII/RGMII pin strap configuration is changed to be set
> in the bit 20 fo register 0x50.
> 
> Jacky Chou (7):
>   dt-bindings: net: ftgmac100: support for AST2700
>   net: faraday: Add ARM64 in FTGMAC100 for AST2700
>   net: ftgmac100: Add reset toggling for Aspeed SOCs
>   net: ftgmac100: Add support for AST2700
>   net: ftgmac100: add pin strap configuration for AST2700
>   net: ftgmac100: Add 64-bit DMA support for AST2700
>   net: ftgmac100: remove extra newline symbols
> 
>  .../bindings/net/faraday,ftgmac100.yaml       |  3 +-
>  drivers/net/ethernet/faraday/Kconfig          |  5 +-
>  drivers/net/ethernet/faraday/ftgmac100.c      | 77 +++++++++++++++----
>  drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
>  4 files changed, 75 insertions(+), 20 deletions(-)

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle










