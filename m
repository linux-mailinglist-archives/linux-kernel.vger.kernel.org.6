Return-Path: <linux-kernel+bounces-256200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12357934AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7092830BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947380C04;
	Thu, 18 Jul 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx/hG498"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872F78C7E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293286; cv=none; b=JxrA0CFbziaqXahGV8ZXAkfx18l+GoC6+R5HwdtCVyisBpihEB6q6QURC3EoTgvC4fC2Cd0LoVc4wezNQd7jAacL4uXh3X1CEs1hwEyualbLQliCOW+T/Y5OCfPTjm3juyGMS07xq8VBAiR4FPRusVRcnDPwBlBU/GNPAW72oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293286; c=relaxed/simple;
	bh=sABxMmNsYg19B+G5KtmKl+azR4q/y8D4JhhSOKAiMOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAuWT+1iNbUe6V3dwCdQKGqaGTnidKr4m73mkxRTedVSnkDUPHAgRI87QFvEssuSP3YXJnhwFqxDnSeB0aBzfl2KHiD3mR1J/DglKUAyysWbQChk6d4A6hqrz1JvR7rG3cncq6s5z/5qylKrVvazPofZfDPEgYqfl3Q6wLDa554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx/hG498; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yie/yOPeCOEZe4pgd0jO5B9KM3jk6U/SxwutSwJGrIQ=;
	b=Gx/hG498ZUmtvf1hwz5HGsZ7I3rRHS0pnuKSiiK7hkcPsDcgegkX5CMTDCBWNO5LGBU+ab
	afI0mPvjgDCZjoaG3KAfCGS0MShfjc7iKC+SdExp08G++yZitzC8R91yuzTZWXOrzk2M3A
	KRV9dff6EYaRMFAq4Ai2KgHKOpLNzBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-1YMOdmhaO9Wr6hieIutjfA-1; Thu, 18 Jul 2024 05:01:21 -0400
X-MC-Unique: 1YMOdmhaO9Wr6hieIutjfA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42660e2e147so120645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721293280; x=1721898080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yie/yOPeCOEZe4pgd0jO5B9KM3jk6U/SxwutSwJGrIQ=;
        b=pXNHf8hibeuzvChlMB2ng6eHoBvewJMVZhUuj+T4YQCQULpl/hj0qcveybD+uV7DqL
         FuxRMjnoLityzTMSuyHrgoWlLW3twJ8ao8LreLAnqs8ZDWaqjVi6w79TF6ePX5uHoZGu
         qubkGPAKpdySvGeDaHhTUy0aH0KMQtjXW9ATiKBkM+C/NX0F2cnCsAezsSLPTM4kGzG1
         YgfYo2URoq0VdHb2zDA1Ols0nWrlQt71KMYGGZU0Up/03IYpi6uWT5fHb3+j97b7vuPu
         I+kc7nU/vTLBvDAFsrf0nwpsp1EcXIm8tV+YZV0V90Badbu4Sx+YKbNqaKd22zb+h0ev
         l7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXEHhNXqIIbZDhKytpEREcOEvUvEiTTvLqPaev5+KGT76v6BXUfoL79Of5C4x9Lypk6kw75NW2CLn8nGYDpXGRrcfbtjbeO22Yr2bTX
X-Gm-Message-State: AOJu0YweLeuHVR4S+pFmzuyb18OtzvNhkFx5BdSrNZOC8e3NOjzIhVeP
	jiUciQDE0MLXsZphjBZTi1S4eK8mX1APryR9VHZliT/Wn1RreC3WSssctRemYgik96nt8jchTwH
	tiTyaHBQhIvdl8SWBAgk+S4CBh5676vzsZ0rZtewc5pkPkj7Ta8ER9XHhaimCWg==
X-Received: by 2002:a05:6000:1fae:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-368315efe80mr1934500f8f.2.1721293279848;
        Thu, 18 Jul 2024 02:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtYI/GyodVGbyEP/KFt3fmdILyEQ4jaMdMonokpSjhlCn0kFlCEsFld7xD18stFs9oM5OONw==
X-Received: by 2002:a05:6000:1fae:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-368315efe80mr1934479f8f.2.1721293279378;
        Thu, 18 Jul 2024 02:01:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3684e96033dsm1184069f8f.23.2024.07.18.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:01:18 -0700 (PDT)
Message-ID: <a1428b73-4f4c-4733-9f23-57e4346e4765@redhat.com>
Date: Thu, 18 Jul 2024 11:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: vsc73xx: make RGMII delays
 configurable
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717212732.1775267-1-paweldembicki@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240717212732.1775267-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 23:27, Pawel Dembicki wrote:
> This patch switches hardcoded RGMII transmit/receive delay to
> a configurable value. Delay values are taken from the properties of
> the CPU port: 'tx-internal-delay-ps' and 'rx-internal-delay-ps'.
> 
> The default value is configured to 2.0 ns to maintain backward
> compatibility with existing code.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


