Return-Path: <linux-kernel+bounces-576756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D5A71409
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC23B479C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC411AF0AE;
	Wed, 26 Mar 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EslX+LhK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E31A2398
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982375; cv=none; b=hase3oNb5zoX8ss+dWA5m7nkDDhynT1RgfDj/LoyVWLadvBh/XWR1bEZp3/1KlbqZ8MdXreRNwSApr3Kk2bcDQcCzNB5MN7jShGEmRIzNGpC1012Ja84tJOYLaBrgpaWMd4s5KH9KIU+1YlL1/z1Dv+XOT+ahjLZV0T8KI77KPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982375; c=relaxed/simple;
	bh=gJIYGQR+RiGM0XJWCm7NWAzwfhYCn3x9TxE2VX287jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBoZG5WWhsuaO6WCtCbFzi3AexqnJp+lMEJw/JhlP63tWWK8f3AZHc6R+RC5JwXHnakDaNGy3si5v+E+6tprZ6Mwqjo+K9adNH5qtTQJqOF3hcBgK1Ws8yl7L6vHxUlzlJL4wmUWr3+jy3Hf/m9EFxjaYHX4Lx8y8rOtDZImLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EslX+LhK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so919132366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742982371; x=1743587171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/kXXpYh2KweuiB5zHwjY0q/TjqrU3OfimILMTsVvAo=;
        b=EslX+LhKXdrPfZT36eafoi5lnJKtuJIdH0X+vutYf208eI3Um4drcmiL/leOFxKuQ/
         iHL7RHrVkkP6ecOsOAdixpOJn3plizjTP9ohyiHn+vi1HM5ivMEvAysv2FQ1ScXwN3DX
         7cCi+qk7ab5XAQhORW96if/0RQBjIw1cctobq22k+tHJtuipVFOkO3J5jszdeMgF27Gb
         qfEDy79uih87UjqXP1DDo3OON4eFuUumqTd60iWzdBKoPoG/kut6F7XSn39M208dMsS5
         fj5vmRMMk9BR5FleJ6cFPoH/YN8/ZoIE4L/JXG+oDEv1UhdPikKJdOzeulFav8a5GJlT
         U+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982371; x=1743587171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/kXXpYh2KweuiB5zHwjY0q/TjqrU3OfimILMTsVvAo=;
        b=ejp+57zJKthE4A+C6QphCVy+0yOkv+Bz+uNHomyUo9XGXzq1PpFm75r6RCwV0DN2Te
         1f/deIzUOwDWsb5tbLhXeJx62FhZJUDNjQrlDBbLkk5KAS1Uip+06A0PeuEQa8l83T6d
         0JrNdv+ISI1DQ1+UXZt4C5XXz4b5dohqLnLRXNwICoaAvNF9mi4LrxNdSR7Ys+P3ZN1l
         9SYEQmBxjfVB+07SJpW187U2mpCkB8JfCE+7l84nB7CMOAlyU8Sa9TFGkGjl1wijdLrT
         L58xUdVQEIWp2DwbBlLoOsG0C5zKb9zlvRCJvJWk9G58ZsVfde0soPC6cvSnpvB5SRwI
         SRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP/uSryLA7OAZvotkqioZUFGrx67qy/9AEJhsiSwx9KseISaNdwre8a7/7PCTnROvDw11K9aAtqad5x9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bvIrNEmiA0gy8PAsgXxkJKdquC0tHR1R+I86J2fZVR7DTofF
	Vzh10kTMZci5FxksmcZkTUUzCLXHacOJTVWjWlxZZ9Sc58rc0fjicPg9B2ZzeZU=
X-Gm-Gg: ASbGncs1nUqIV0k77hNMAy7u2VhtdxTmRtAX2MOqXwDvuIVA8dVzPZJ/rfD3XlXw342
	2H14Oyfn2z6Q+rDkauhqSWyz2XCVkojRGJ++7h4DEujdVODrZargCh0u55nncGa2n6Vm5fVlxdZ
	CfaWPt7H8WHCHmoMO2CDuqkbCfG/nJKmpXx3W85IFQUVfIM13OsRlWe5sQh4JxcXudLDGEwcvPB
	hvpCYX4V+YpwC1XDq8V9fJ5R5cXLi58zPFUGggCAgAoQ+oKMgdNqHtynxFb5xja77gWLkMhTrrj
	I8pnusGCoHit4/9XFxwrGjlasR+q/9yg3hAs3cN6RdjNiEp0/dB2klArV6V4kJPc+vpa1ODphVR
	hmjrmOLfJJFzG
X-Google-Smtp-Source: AGHT+IHx/kCnyQhbohYhyZQ+ypuL87ESt4h+TC7om1KV6AWAGl0sRqBA5fm81htRzwYvpmm4nlJCag==
X-Received: by 2002:a17:907:3dab:b0:ac3:3cfc:a59a with SMTP id a640c23a62f3a-ac3f26b18e4mr1876478266b.45.1742982371410;
        Wed, 26 Mar 2025 02:46:11 -0700 (PDT)
Received: from ?IPV6:2a02:3033:273:9b44:1f61:c513:306b:cf0e? ([2a02:3033:273:9b44:1f61:c513:306b:cf0e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdca5dsm997614466b.137.2025.03.26.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:46:11 -0700 (PDT)
Message-ID: <59f34bce-1069-446f-92ee-934cbad3d7ac@suse.com>
Date: Wed, 26 Mar 2025 10:46:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ahmed Naseef <naseefkm@gmail.com>
References: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.03.25 09:32, Dominique Martinet wrote:
> commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
> that local addresses always came from the kernel, but some devices hand
> out local mac addresses so we ended up with point-to-point devices with
> a mac set by the driver, renaming to eth%d when they used to be named
> usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.
> 
> (some USB LTE modems are known to hand out a stable mac from the locally
> administered range; that mac appears to be random (different for
> mulitple devices) and can be reset with device-specific commands, so
> while such devices would benefit from getting a OUI reserved, we have
> to deal with these and might as well preserve the existing behavior
> to avoid breaking fragile openwrt configurations and such on upgrade.)
> 
> Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
> Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
> Cc: stable@vger.kernel.org
> Tested-by: Ahmed Naseef <naseefkm@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

