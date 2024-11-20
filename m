Return-Path: <linux-kernel+bounces-415822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B329D3CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E58B287AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3F1A2544;
	Wed, 20 Nov 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCvwgmog"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54212746D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111368; cv=none; b=UIyu3+juFKga/nvevXhXIJKp6wE+8i/bUy27tXC4vZroEleeqeQ5Fmr5Nk8g8/jmx5SK72N6SWwBCDEuEaLEhnFPZCxFkRAddos0UXsmgR0smQbg43SpbuqE/HLgaOoGjkrmsmxWpQs/ght3o3MhQvAPKZLrUrqSfQdtGkq3Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111368; c=relaxed/simple;
	bh=L6norxvsedVHyx0V470ZEYFx5pbzSA8qhraI6KpAcSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnOjtDkA6nnZPeyB5P0xmyjAEx/YscrgbC8uKPf+WDRwg3S0AdCk/cTEqBNIBJAyyjhy5jCiaq8AexF4ykMnLtyjshH8TaWNIigp0WKcHBbfr/Jm/Y/xa6yt/wZ3Fs+KNmLUr7lGu08+7ovbcyRiAoa0tYLNe6kltcCPpgQtd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCvwgmog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCQDIRpYT793Ke5WKf9r4TZHzM/jKIPDSlM5UFXB15k=;
	b=ZCvwgmogk3SW4kptdiQbI6Qxtj0Js8QfAiNx9euK3ek++NryNvt9MS53NXsAOpbu56+BQj
	NH0nwDDD0SYW2bZtQho2OgqOYY82/KIeWA8HZBn7PNYbxK4I5j/RVHnuDjU8HXepRlL7D8
	k8HcFvTJ8pEdIlw8h+v2AxqLgozoXfo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-jKNVDd4GOsGqtezNquJ3UA-1; Wed, 20 Nov 2024 09:02:43 -0500
X-MC-Unique: jKNVDd4GOsGqtezNquJ3UA-1
X-Mimecast-MFC-AGG-ID: jKNVDd4GOsGqtezNquJ3UA
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53da2737de5so4184052e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732111357; x=1732716157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCQDIRpYT793Ke5WKf9r4TZHzM/jKIPDSlM5UFXB15k=;
        b=A2rnFPqMHWQvA7Bf5oaGVbQ4ZJ1e1QUN09bTA1vWDSO9ZfMOEtvsLwYDO/Pw6Te3ff
         CtWzIAt28pR9axwu0+krbw2q3J9CL7nwnkWAh35YssJV6vWM0+dD6CRdcw7Hmuj5bGLq
         YQOd8GNPlIifV2QT/4nTpCmjNsfqbmVTVWyGDysgLpukgTtIWthjcDnQz+1bF8S4EiIh
         MbOl3GgjfIrqeasCFYSJx9NKJbrTWa2SejW4vLOqQNBXX4Ed8LLWjCSPgYqxDk3jo7uB
         vnF9LjvnwD7m65gL1feXRa/7ttx1WoCuVUVVO+QJyioKQcAcfwf0fApwdlzrLqAsSHYD
         Zc7Q==
X-Gm-Message-State: AOJu0YxDIJUoh3zVb2ZPW1sKpB9OFtDislP50omqP134ebAwVz7o2IAa
	wl5zNGty7U1hcREaa2IsgwCxLGz2FBCzsjdJRvTIb9O+Br6YXcZfRBmo3bcx5HfE7nFOvnB/Fxv
	QaRTxmL+H8+cw9JztzCy6a6pW09Ej0qEbxhJhpOkAeHHBd0aY8yPsRLM8YS7F1qEywUqMHA==
X-Received: by 2002:a05:6512:5d8:b0:53d:c48f:f77a with SMTP id 2adb3069b0e04-53dc48ff7aamr582216e87.9.1732111356589;
        Wed, 20 Nov 2024 06:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoTW49AdHGAuSz642dKFqInekie1bqZvYlTGtchvLZEQYZQAstM+v4wP83npsnlknjtAuY/A==
X-Received: by 2002:a05:6512:5d8:b0:53d:c48f:f77a with SMTP id 2adb3069b0e04-53dc48ff7aamr582158e87.9.1732111355945;
        Wed, 20 Nov 2024 06:02:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44dea2bsm831632a12.13.2024.11.20.06.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:02:35 -0800 (PST)
Message-ID: <4ad0f4f7-417d-4668-a0d8-ceef13814483@redhat.com>
Date: Wed, 20 Nov 2024 15:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Gross <markgross@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241119080658.7d0866a0@canb.auug.org.au>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241119080658.7d0866a0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 10:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   c6a2b4fcec5f ("platform/x86: p2sb: Cache correct PCI bar for P2SB on Gemini Lake")
> 
> Fixes tag
> 
>   Fixes: 2841631a0365 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: b28ff7a7c324 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")

Sorry I don't know where that wrong hash came from.

The suggested replacement hash is correct.

But I see that Ilpo has already tagged things and send out
a pull-request so I'm afraid it is too late to fix this one.

Regards,

Hans



