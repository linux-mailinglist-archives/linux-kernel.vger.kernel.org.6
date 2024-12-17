Return-Path: <linux-kernel+bounces-448949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41039F4790
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC2C161712
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E051BE854;
	Tue, 17 Dec 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWHJ/Ox+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0F3D69
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427833; cv=none; b=dHIC2mbptzg8zMWSv+Jf7GjmaHztgBeSIeYEBcg5llO6EzPCWeA6TVfRMBtR7e4IVK7/uPLk/Wc13S2sWNmlGSLe4adTViSym4Cexaxl3tJ0huILwoc66I8bQfOvjbnPkmL8emL4jyEZOoVb7G1YsRe4+6oNatcYHeSP0Uxil2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427833; c=relaxed/simple;
	bh=hTrcB06ROVLWkiWKP9EGt8merZ0Vmsr2aoLLJZ0qYro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEhMX55BoAaIGYCP6b9q271K/Zxu2L2D8zlWwhYEheC0cwsd+R/nqnMOGWnALCA4GewQd9VyCT8/qGrxW2Gnj2Adog1CqI6BhhWt4PRkYRuisy1jBmnqpXvO+uzs4yCI9ZahCHfXS6tZYfMU4j3/g937BcPGPs5tZUSliy/U8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWHJ/Ox+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734427831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsZWLwNN3Dj8vY9Jgz0ZZvXQlClGHa97ZSTKANn10HM=;
	b=SWHJ/Ox+4B3pNll7+Yj8KTQoQ4uDiUCINokXmXCTvUhzjDip2Oio9gnTHH5Lim1DafcbwY
	8NxE3j6PVxZtybV+eI942RldL2k+lo72IjMszwPfcw7dLTdWzlL6i8B3uTi52XML3luo4o
	In9iatf156Izl07n9uKRbc84xBdcyUI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-BV8UfdEJPa6Zs3RH561-8A-1; Tue, 17 Dec 2024 04:30:29 -0500
X-MC-Unique: BV8UfdEJPa6Zs3RH561-8A-1
X-Mimecast-MFC-AGG-ID: BV8UfdEJPa6Zs3RH561-8A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e9c698e7so2599281f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427828; x=1735032628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsZWLwNN3Dj8vY9Jgz0ZZvXQlClGHa97ZSTKANn10HM=;
        b=UNNaX+l5EJXGgb8l/NyK9Fdv8M9bd+BxrLYXmwLMdaxOkRk/xJtcZyw7xB254qynQW
         N5pbGT1OxCcNzP9Cf3g0WdJY9gRwagXLz0HEZeFpeYcX16yzetzm/CA9NB6LYpp4sJUM
         dC7nxlYblLtGmxDiVN/qf0mM5yd7jd/2UX0zj0+JruAsKoMzlTXcVxeJByqCeT3BbF9I
         eOhc6AWCGS+VLSuvJQ5BI4kwpw70w7crht6eJpT+BZiFp/U0IiPKlTD+bjy1/v2K2HJ6
         ZniLOwlZIHfa53O1NGFmJxjCO94rH+E1gZrwemjgPCHsBD79q6rVANBpLm4N4GJM4kZt
         MlTg==
X-Forwarded-Encrypted: i=1; AJvYcCUBPg/04SA2ZQzHPkoNV2n2wGIxVoYhdD+yFld7C/n/SI073xueyx4T/WjankTdYmHkMAo8cCrlHlqd3ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDy33qaMdaMiSJfDUk2T9EyP26r56kuBoEFON/tCcxPnT1CJqL
	2y97Shy+envDkC76RSCsxXrvby3nOB/Aj8Lzs2EkbGJE2rXej7z7+SDWl3e6+KyjFTynzqkBt4c
	dbBcQxBNaTQKZ13T+y2GD/igkCKCFsbQ+pnWnL0VJLFqnTOvm2oF2SWlPOX0/Cg==
X-Gm-Gg: ASbGncvHP7fpUvG28ibTVDAkHImLDIIgIJ3tp6d5OADlJGTL8U1wIrlPuYbzwWF854S
	OcLV9ezS5xxlXb0KtwUafpz+0fjKANZjVLcotMI9/r2D1p9FE1ay2+UljEKTZY0x+w46n0t281I
	hbQ4lQPvPE+3gK/1xEXTL4fR8sYTHl8IWco3gtkWWeFPU0lwzcxUvA7LZvbBAowUkKxduaja6Nj
	fg0LIRnU3Q6f+ZeGPn3wOli/KBFFotCEINBPJQt2dTnTrJU9DhHVl3tz13WnPp4TL0XVQLuADTg
	NEcAAXYrqQ==
X-Received: by 2002:a5d:6d8e:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-388db23b794mr2025559f8f.7.1734427828127;
        Tue, 17 Dec 2024 01:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGfqm8yOmdd4TkH9Nm5un+/9BqyR43RiXrtTTnaPexsrsZBcqLS0wyDa2ydDNBgCgdLmOg5Q==
X-Received: by 2002:a5d:6d8e:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-388db23b794mr2025421f8f.7.1734427826252;
        Tue, 17 Dec 2024 01:30:26 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c805d489sm10688171f8f.88.2024.12.17.01.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:30:25 -0800 (PST)
Message-ID: <9d0722fe-1547-4b44-8a4a-69a8756bdb39@redhat.com>
Date: Tue, 17 Dec 2024 10:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of
 DMA descriptor allocations
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <20241213030006.337695-1-0x1207@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213030006.337695-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 04:00, Furong Xu wrote:
> The DMA AXI address width of DWMAC cores can be configured to
> 32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
> get a little different between 32-bit and 40-bit/48-bit.
> Current driver code checks priv->dma_cap.addr64 to use certain format
> with certain configuration.
> 
> This patch converts the format of DMA transmit descriptors on platforms
> that the DMA AXI address width is configured to 32-bit (as described by
> function comments of stmmac_tso_xmit() in current code) to a more generic
> format (see the updated function comments after this patch) which is
> actually already used on 40-bit/48-bit platforms to provide better
> compatibility and make code flow cleaner.
> 
> Tested and verified on:
> DWMAC CORE 5.10a with 32-bit DMA AXI address width
> DWXGMAC CORE 3.20a with 40-bit DMA AXI address width
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Makes sense to me.

Since this could potentially impact multiple versions, it would be great
if we could have a little more 3rd parties testing.

Thanks,

Paolo


