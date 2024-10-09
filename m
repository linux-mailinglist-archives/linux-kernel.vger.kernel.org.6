Return-Path: <linux-kernel+bounces-357908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB79977B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B4E283E99
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD81E2839;
	Wed,  9 Oct 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WofvFC0n"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8B1A0AFA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510149; cv=none; b=a/3k7sNccmjOg7hPyymXml5mSfSTJJggN0+FGMYxl3Qk463KeUWcTnSvCtpJMVU9/GtJ8tDAeGm9aMbe4jg0yJQJ4hrVybyRPMBRJtAYYSWdw2djDPWH/IqHTzEEneUJdQ3dg/YoVBHBklsgLMxVyN3AW9712whf6YWPnwoM6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510149; c=relaxed/simple;
	bh=ppflntTAWpe6pyrUulRN0IEktwLeGX9dBx/Bry9CEiQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db1d12mYoUHN4mD67b2DRftmAETcZlGO7ZOxVjFQqWTE6Ds8kmXdLFQCCDEZLNPB+k19mXOfo0oLTVfTgGEKJ1StL3hzJmnE+E2cGfcRoQWRKUP1dHE8aaRSZWovAw0WYLDpZ5Bq4th1toJBju6Ux+nCWaVuoH6eNQFMOGUlnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WofvFC0n; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so870274b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728510146; x=1729114946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=as6o/zgw0W0ImJI8bO9wBqO654a1TD8C3ivRXpJtgxI=;
        b=WofvFC0nP9g3lZrryZK7bwxUrX4VRSDcSAMfLaqOj4T07U+2Ukxp4B4s/eMy4Zke6q
         EcfQUEmqOMT9W6fW07+lRaEQYsnhvJ2530Ge8Mj/08lgXzeq705y++Sv3u1CkA01IiqA
         qIvG5IjYBhmz0CaWvUWtNP/th+2dHQMK6JZCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510146; x=1729114946;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as6o/zgw0W0ImJI8bO9wBqO654a1TD8C3ivRXpJtgxI=;
        b=r1fjIJ3nvOixkmNbgKvTol87pMsMkCEeZgayhpdd2Ej+fpLx2yAES2w9U5futrKd7j
         aW5LhWUz9iJWQWWs6gqHLYG9MF51MwLUypVhNpr/AqXfN/hg9GKbw5STRE4XbP8MThI0
         Zuz/FHnqZOImbNzrZdHZxB6lkqQDMXFo/w4jqujRCTJ/0uiefO0rxgzTa/8FdGl7aBwq
         dqOAHB9hcsfzXbVygJc6irx/F4Jo8wPXMiLWCd+cim2NrvPXU34dEp2NYbaBGM0N3M79
         KnbgiBDZ0e0Ieo+QQclGN7XQnam6xRAKCCWsBRczwnjV5PfUbDVpuXI8E8HmAnsnPn7a
         4nSw==
X-Forwarded-Encrypted: i=1; AJvYcCXA8EzbX8+vt9RvqFAwoycImm1QVbCU6rrIFmPyLwlcTHHMCj1qS40jbNK2zO02WJ/5mwAPrkFVGJSvtlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoke/uyBUq6Hq/nWrw0aYvJkXIkqRiB9XCOWS0AR5csiWXLX4X
	Gvc2np+6EdXbc26EN+y//LzCGuNTRzwm6RLiPlyE3Dg6o0Sz4JQHklo5jZGYFHs=
X-Google-Smtp-Source: AGHT+IGqLj43orHfRVrzKFauhS+4NPdIZ/yjJUa0XH7LCnLtPQ+KHfsPGcffCRXh0Js5Dgc3Kmpt1Q==
X-Received: by 2002:a05:6a21:1192:b0:1cf:2d22:3ec4 with SMTP id adf61e73a8af0-1d8ae11eb83mr1271564637.25.1728510146591;
        Wed, 09 Oct 2024 14:42:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc4b9sm8503914b3a.17.2024.10.09.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:42:26 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:42:22 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
Message-ID: <Zwb4vlznjquet3DT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-8-shaojijie@huawei.com>
 <Zwb3PvG_EjwqMT4v@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwb3PvG_EjwqMT4v@LQ3V64L9R2>

On Wed, Oct 09, 2024 at 02:35:58PM -0700, Joe Damato wrote:
> On Tue, Oct 08, 2024 at 10:23:55AM +0800, Jijie Shao wrote:
> > Implement rx_poll function to read the rx descriptor after
> > receiving the rx interrupt. Adjust the skb based on the
> > descriptor to complete the reception of the packet.
> > 
> > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]
> 
> > +
> > +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
> > +{
> 
> [...]
> 
> > +
> > +	if (likely(packet_done < budget &&
> > +		   napi_complete_done(napi, packet_done)))
> > +		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);
> 
> I am not sure this is correct.
> 
> napi_complete_done might return false if napi_defer_hard_irqs is
> being used [1].
> 
> In that case you'd probably want to avoid re-enabling IRQs even
> though (packet_done < budget) is true.

Err, sorry. I read the code wrong. The implementation you have looks
right to me, my mistake.

