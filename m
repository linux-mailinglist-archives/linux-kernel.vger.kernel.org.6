Return-Path: <linux-kernel+bounces-256191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC4934A74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C1AB242AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E27F486;
	Thu, 18 Jul 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHg093T5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761681FA3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292707; cv=none; b=pUS+biZRX+0ZsN7cf4zZQKzAk9fpicj09nZuBszC25Jub5qHMNoZJKhaOOcRDtsAcmhrDl8aOqUl6CeRt2bYXNBuI7fkehLXlYX5R6I1bLygghZhk1Tdtzeqqat6Xoh14bjg3MpqtOZOgNaEX331uVN71qD2YO3obiX9zXrxPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292707; c=relaxed/simple;
	bh=MdeHswIBPPTtwRUeCgb+BphChAYeCJhMEXm/d0726Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8lJFAIBDiYF9wZwx4GJWYOz3djeiG6V74h5GcUgSWN5I5sJpMWTzHJbn1jaBpD8BjfdPieIO8NuBBr6ZEM4T415BE+JhMpE7WFFILp8qAiSs5H/4iKq1iE/JTNUnc1fhX43Z9OSwh1jySmQ8bkDPMbY4q6QZobSBIo5e6MnEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHg093T5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721292704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20Tnlq0OUegCOEQmFC5wwha5OhmQWY424U+1skg1sa8=;
	b=hHg093T5abzsCIJ8izR9KWbMPrvrFs81tZnc9eSlENVdC1KugRRCGblQoZbWTAjLgEnkiJ
	9ipwg4Cr710Wvdgr0WfchmVlcBc3IzVjifWZty1vFW1dAotrKmygsljJynD/qsfFyGKElf
	sgT5s5SwSwF/e6o3p5uXsqFbFAJx/AU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-htaVqCLsNAKrdTkRZ3GIUQ-1; Thu, 18 Jul 2024 04:51:42 -0400
X-MC-Unique: htaVqCLsNAKrdTkRZ3GIUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266c859c64so47875e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292701; x=1721897501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20Tnlq0OUegCOEQmFC5wwha5OhmQWY424U+1skg1sa8=;
        b=wdm1/DSzyFq0mmODM9LZXh1euI+SIm/NE5c1cLJrAjQdBzSRRnqGa7A/r2mvAODQ4y
         I8GIz2fu6KMMhaNfLrOb+48uaDLOenYM3wYAO5OHQEQ8CCXhtNQg7ZenGjd+M353YWdF
         T5/qBPT1ED7m2yOrrfVOHLwLgei3scaptOQODue8eU+RArSyUSTHl/nYUjoiHa6b8zhB
         ZMDInXntq088oj2OxYzoJPPn3j6X66rL+8fyDpCNEeVO4yQSfH/i+Xp5BNaz2wPT+Z/d
         We+7Pqx12+q8ZQfPghxKfcAbMuyJcNFNb/6JV2GOueLCHpo/rnoNO9wszg18299hIPbO
         U4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA0CrtRLWwtnH6cNeB1K9zix5tZgvebpiyMesAb3mLYhb5dXtOq8kFHLhY0nIDA/yghm24V4pgQ10ROIRG+gXKz41uu5dv6v/zVwN+
X-Gm-Message-State: AOJu0YyVlj2Sh3l/15o9JHfXwpmCPe1aVrICJQqkaYE1pGpcWYOWrs+G
	7UwFOY3DuTfIiF6D6KxCYSyktELz6pGIr4fJq8F6NMG4JdMJ1/wj4H/X2KUSa686x9QI0qFOxnr
	nhXmyzrwzFBxbWZRRtB0tWW08iFRqRLB8MH+O1TBx9sB9vh3aG/xvXDHq6QFiTg==
X-Received: by 2002:a05:600c:1ca9:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427d2aa0b2dmr877435e9.3.1721292700849;
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxtLbmObFnfSZwe9VmhP6oYhoC+mtRhM6m+a7WDr+smmx4B7pfpnsPJJZX3d4B15Kuce/eLw==
X-Received: by 2002:a05:600c:1ca9:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427d2aa0b2dmr877365e9.3.1721292700497;
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b317f1sm1589565e9.45.2024.07.18.01.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:51:40 -0700 (PDT)
Message-ID: <f026cd7a-d461-40eb-9e30-1bd76684b7af@redhat.com>
Date: Thu, 18 Jul 2024 10:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 horatiu.vultur@microchip.com, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
References: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 13:16, Raju Lakkaraju wrote:
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register
> 
> Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

@Andrew, @Heiner: the patch LGTM, any feedback on your side?

thanks,

Paolo


