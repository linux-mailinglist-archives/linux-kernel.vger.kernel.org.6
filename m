Return-Path: <linux-kernel+bounces-253807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6761932749
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72829283936
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A519AD65;
	Tue, 16 Jul 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwHb91dz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36C4D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135845; cv=none; b=U7bWDr9L8ciSERtFKDlfCiGCJEkMey3SU3qlqYmZnutNjO4YXLVLrIDNvs5tBOiCLeRRt7O3furMoTGsVQawMNKbAdWzdkqVsMbiYMBSr3eIZdMt8R2Ys+lgiFv0N0FMx6MjqkphhA3RmJEvWXdqkpANmg6DDjG8COWLmow00xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135845; c=relaxed/simple;
	bh=Eg/lftqubvyEX5Bd60Ucs7ETOpklpI3/xFJ3osyU9aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3LOFSCFwZSxnhk5KpA2meCaK6j/kbnPmqYHzcUs/2XDiz+Jn7sdmCURGYphmvnVtVagnEqEQE5B1MyLuGViJElhwXi8m/M+NqaAv2wM6/7N9VfbxTo6kAmnUuUs0zlDDJYIe4iltlCL5UsAyUJMd+UUXW6EfxGiE1PVK92l9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwHb91dz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeViZGApj3eElsFuZdKIKlgTMa1oEImto5Da5j+IQyc=;
	b=YwHb91dzTKu0wXjDrHVdSLAhMkoHwucctngwrZ8/PCDbzDbp/rzaQvoFbwmNnamLAWn5cs
	24cCX3PWn/G1bWcd0y2FFimbrVEx94GPbq267Njsg2YUqo/53YPXkb9+NViZvptjChmDIB
	Y13rbgxOZlapLfsd0MsKH6HCqSPPa+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-MiShNjCjMkyph6f9eY92YA-1; Tue, 16 Jul 2024 09:17:21 -0400
X-MC-Unique: MiShNjCjMkyph6f9eY92YA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367916e42d1so104251f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135839; x=1721740639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeViZGApj3eElsFuZdKIKlgTMa1oEImto5Da5j+IQyc=;
        b=BR+rk8SungBJG9ltEsXXIhEOoqlSWJqHYAuXIKQWbQ7B+VmFLLx3i/XxY5BkKPqvaa
         zKZthMGXvoKzoMISuIK1SwNEkIU6VRLXub+hmpbqzXfA02UMp+QOV72BrUDABWQ9uxuN
         UvqbC9c+9eMgBYDRigQHwf5Lcb/KTysebxJNTa8jHTcjhB7/JeMHrYnl3HfYPXs6/dPO
         xbM6xYpNG1ByucG8aZC1KAet+YxgCAUoTjmbvVip+Jo1DYrbhFH7LcwfRbafMJKuTnVv
         lABxPhMbWZ5fG22C05iEITGow+esd1NcJxE7LIV5MVh63KaEzFvZbE0vNYfCytc/VJY/
         c3tA==
X-Forwarded-Encrypted: i=1; AJvYcCWCqV8OlBDVJKNsm/aB8/Cwsf+sC2Y/+FGkKbhopcdhJJDoz5F/MJ+dV5c6Z3I+ed1lBik2mrx6cHLbTBY56ACzkOoBWFi8p6BEVBXZ
X-Gm-Message-State: AOJu0YzG4Oo0fxHD4fkTNvG8Kn5aIocyB8V+vfETtvN10yc2oJH43EEl
	1K9vE7igVnenyH3kvdIEf5cAWdHKDoykCojXD8wpkOWfSGMUp65IpO1K4UB8H/S2BymMZwYcvyV
	qLVKLvuCHchko8o4GLNQ0ddVv6Ax9jFg00HPzDk89H42Q7qhHBgtwkqIyPxBiEQ==
X-Received: by 2002:a05:6000:2a4:b0:368:4c5:af4 with SMTP id ffacd0b85a97d-368240cee04mr1382612f8f.9.1721135839666;
        Tue, 16 Jul 2024 06:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElLoSdJ+xIm3/ZPGhjV3ZWalyIbR92kQEiDTKB7VrzFAGFDpH1fCFbmAZ+FYNryODygsdaFw==
X-Received: by 2002:a05:6000:2a4:b0:368:4c5:af4 with SMTP id ffacd0b85a97d-368240cee04mr1382598f8f.9.1721135839228;
        Tue, 16 Jul 2024 06:17:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210::f71? ([2a0d:3344:1738:5210::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db049f6sm8947213f8f.113.2024.07.16.06.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:17:18 -0700 (PDT)
Message-ID: <5f5f9d5e-6c2f-496a-b795-bc609cd1137b@redhat.com>
Date: Tue, 16 Jul 2024 15:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch, horms@kernel.org,
 hkallweit1@gmail.com, richardcochran@gmail.com, rdunlap@infradead.org,
 linux@armlinux.org.uk, bryan.whitehead@microchip.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 13:33, Raju Lakkaraju wrote:
> This is the follow-up patch series of
> https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> 
> Divide the PHYLINK adaptation and SFP modifications into two separate patch
> series.
> 
> The current patch series focuses on transitioning the LAN743x driver's PHY
> support from phylib to phylink.
> 
> Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1

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


