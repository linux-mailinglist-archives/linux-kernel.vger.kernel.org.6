Return-Path: <linux-kernel+bounces-404084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899769C3EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430111F220CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE319CD0E;
	Mon, 11 Nov 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyMO2xeb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4701AAE1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329687; cv=none; b=dCRWI2Z7yBBEq//VZzZE1dI2ZoMOsAM0302OcYXrJhI+mHq8fIh35o+3crPqNG/Ivwn4Lf/gAb1l9cz7Mja6r3O+FLOHxaQgU8bzlw8xVw8Mfn9kozz1Bwe8hYeotJc5/20ee11VIaUPX+YXJWLFbX3m7izheD3qWu3nMdTvjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329687; c=relaxed/simple;
	bh=5kiJXTpUS3rRhAxb8abDU7E+24cj7yxt2y8v3LwYboA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COHs063yQrnDaTskqMC/dJEyEKXRwJ4hN8Ev4OI9lJmu1LljatL6AHfl3I2gfFoYdWpPH8JkkKh9R8mWvlsO0sfEVjPAV23ugCKXFjficAVt1616Tew087V05ZjeoXzlFaLQRNtKASYRenOhNhUYKn5BqHOIpUBi+MAawQJzLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyMO2xeb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731329684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGJIY1Mn9wrThRttTnQjyrZIyuqbBWl/0J3QrLc0f7s=;
	b=KyMO2xebSoNMDzC96GwMRcps2fc4PMezA1Oo1GDLpwnS9DFYsrpksfY866KwJW4dbHfZ3c
	v1YTbCzR60E0OorPqh7dcYJ0Ob4LZqdKdevkLt/8l/PNmhOxfnT84ObQ6gzYwnw2k1Nx0v
	7qpXDgS833VaIteD7YjWKciuuP6ur1s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-nMHxyRQkNJmsyCxQigVGkA-1; Mon, 11 Nov 2024 07:54:43 -0500
X-MC-Unique: nMHxyRQkNJmsyCxQigVGkA-1
X-Mimecast-MFC-AGG-ID: nMHxyRQkNJmsyCxQigVGkA
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb60277fb2so25752361fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731329682; x=1731934482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGJIY1Mn9wrThRttTnQjyrZIyuqbBWl/0J3QrLc0f7s=;
        b=FrNBK6VcpyCh10f9daKHlyXs00HLgJdaQN3XBVmquinGJoy0bDDb1laP6okTurl5Lh
         ltEfa4+SD7pbdav5rnkOSq1LM+szbneAzXSJRIAftSrQLwbwz/hin3mLJSlmj/NHNuS/
         nnZ6Vmk7ALfOw9EGV8Z65378mKOuD/PbqijzTl7ydMgS+0MpqZ6uOCBSSqjXZWH0Kb98
         qC/1NuahLQG2L2SqAsrKMYSCY9wSDGY4fyGTDnzmji4GFxtvEaw6NdhW2Oao2oP8MkFf
         euFWHxSPOolZLViUBpve2oR5Vw3S/60YCPVnFthUM8eXKANcKfCmjYRKrkXUEcRgEDsz
         gYVA==
X-Forwarded-Encrypted: i=1; AJvYcCXlaagA+41dyWMhFGyUGDddlJAiDLjGFE+GkfuDcDN3/2lUSVysyJEmN8pVdL5a4vtsPvhCl13qhS6oilI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nFBCPnWc2FD3Kl3iTCZPtgiD4lmHMW0ONvY6uIzv71o3uOIw
	xheAJoLv7aGiayP7MwGozwDj8R4MTZ8lvO9JVjp+5iyzEyv5QJEF5pfbPq+MXAxnLUfFA59eImW
	azBafEkT54t0UNRyf9SI6P93prIdYTz801xr8ru63TYrHMVJe4dlnJ/lSCX08VA==
X-Received: by 2002:a2e:be10:0:b0:2fb:5a7e:5046 with SMTP id 38308e7fff4ca-2ff2021ed2amr57814461fa.9.1731329682111;
        Mon, 11 Nov 2024 04:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3gvsEZP1OVMvi0JGBENB8sCvLn6IS0ADa1To719q3AyqjQGL+gSn21IXi9REjcUewzTIIkg==
X-Received: by 2002:a2e:be10:0:b0:2fb:5a7e:5046 with SMTP id 38308e7fff4ca-2ff2021ed2amr57814291fa.9.1731329681690;
        Mon, 11 Nov 2024 04:54:41 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178e03f6sm16496331fa.12.2024.11.11.04.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 04:54:41 -0800 (PST)
Message-ID: <d1859acb-de5d-4068-9704-9e3df405e9c7@redhat.com>
Date: Mon, 11 Nov 2024 14:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add dma coherent allocator abstraction
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dakr@redhat.com, airlied@redhat.com, miguel.ojeda.sandonis@gmail.com,
 wedsonaf@gmail.com
References: <gOYx0SWgtHGMFdeca-cxwYWFvr0hwCWCLCyLndrSSh8p9dU1wFSDL3ssAL-zaCfEbUyQ49dpsn8XaGfSamF-Sw==@protonmail.internalid>
 <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
 <874j4et1af.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel@redhat.com>
In-Reply-To: <874j4et1af.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/11/2024 14:14, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
>> This series adds support for the dma coherent allocator. This is based
>> on code developed by Andreas Hindborg for the rnvme driver.
> 
> I was not the original author, I just rebased the patches for a few years. I
> believe Wedson was the original author. I also did not add my signed-off-by to
> this.
> 

My apologies for the mix-up, but thanks for the clarification. Will fix 
this in next iteration.

Kind regards,
Abdiel




