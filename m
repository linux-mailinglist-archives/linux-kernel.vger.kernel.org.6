Return-Path: <linux-kernel+bounces-367472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB09A02C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000C11C23ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64891BAEDC;
	Wed, 16 Oct 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dFq3s+j5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CE1B85EC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064293; cv=none; b=Uc8LJD4rvitzvsQ7U9f2R0OjQUW3AceUA1pBH9KvDSLiyNESvZjsb4lbxDTAeUV0GSRwrGmzY7jcXfBTx16nq45zTu2eLGdRw4EEn/e807pBFYzIrsVw9/sq+0R2EaVP2S7zfls2/EAzryojQwX3AArtwAtQ+mJmZeA2ZHtogKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064293; c=relaxed/simple;
	bh=mpY4WNBJdwr0rbv/zBkoBWXD2Yhr/UefAopc/FUGOdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkscMFuCaHZBKA51Ov8cBWoVicmxmSQGYbJSt/DtbTARIYdPXV7V5M8h+ZffRLStgTbcBOtp1BEWou6GT3mb3rB39rWXZq5kV4dH78ko1pvz6zE8nZADXo6NRJaApaqVsR5fCw3mr8vUEk3BNjVfnDTu7E1dQs/53acwfp94n9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dFq3s+j5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e1543ab8so7658040e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729064290; x=1729669090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=dFq3s+j5AbeZB3kTOPlIh7d1CKPwwQsAynNEdQUFhzvjWB1Vf4aLeJCBP/eTWydbUh
         8EgxilAFXpzNEeP3IiT8q+APpQmw/jK+4udkiL8f0gf9HgCKQj8seOaqFnuZgLwYMD8n
         L1ydcs8WGODNAbkQRZH2G3NIl1ZqKPKut5hhGBtN1B0wa39zdEuLuVYsL98LrkZI3wD/
         aW7FPnN3v6+PCBdKCngopqhF6vyTvgYbED4v5ToA3ud85bMJosnu9TK3/uJJeSc27FsS
         knYySknWCpU4VhQUvXy+E2cA31e3COLGTXs32bhjcYjVCiYOXgv1WPZoBIjNtm/CHyHW
         OewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064290; x=1729669090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=NJDl6O9VpnYzp1E+UEM7AqdbLfJPfavXkhitbPtsdL0lFhWZiLNbAVtOlY+RfGN5mo
         laSE10GWf5L5n9YL8MxoM1jSjffryHYdVKkJKBGLWL5QuCmQ+RjgfoUT24FqEVWTz2nt
         bSdfqs65V7Xz+rifI96vpfXlG24qDuzQtv3cUdbGsoTGaZ0piYbqURPbmoKrzQ6VEcsL
         +qzjs6OFj8XFS512Ihtqtb/tmA1Cgn1EtBWDzXac7xhQkG+nn5m+yDpJBh6t0GhASRz3
         iutxMuvmsVZkmnKNIur6uEkkFI/b0i+7DolvXuD2LdcL5VhBOLBJI3bFsvHk/9l1an+T
         428w==
X-Forwarded-Encrypted: i=1; AJvYcCUc31zFtZEBeyVjGNX0ec7k7c0hsQ+3wMAGXF2lekll91pvIfN97HfNBkMrSFakm6Z8fhskjFAdEPLVP6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoKibggdMhrtOoN22VS9VRNqZ8GK52DqYuogmMk2ZXYP50/s9
	4IyCFVRN975m38xd0M2kT+07iOjj25VlGM37DxVIGQ5VW9qq9vGGvbOZGFJ2NIU=
X-Google-Smtp-Source: AGHT+IGCME5bXQdd/nD2M5Nvzzk42p7bqXT/x7isn5M/JA6Mx4W4hpR+wBn+KqEPTJVK6wGHonihpw==
X-Received: by 2002:ac2:5684:0:b0:53a:64:6818 with SMTP id 2adb3069b0e04-53a00646940mr4607931e87.47.1729064287257;
        Wed, 16 Oct 2024 00:38:07 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29819afbsm148221566b.104.2024.10.16.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:38:06 -0700 (PDT)
Message-ID: <1e489737-fdd8-43a7-9abc-65599e1cfae1@blackwall.org>
Date: Wed, 16 Oct 2024 10:38:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] Documentation: bonding: add XDP support
 explanation
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241016031649.880-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 06:16, Hangbin Liu wrote:
> Add document about which modes have native XDP support.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index e774b48de9f5..6a1a6293dd3a 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
>  then restore the MAC addresses that the slaves had before they were
>  enslaved.
>  
> +9.  What modes does bonding have native XDP support?
TBH this sounds strange and to be correct it probably needs
to end with "for" (What modes does bonding have native XDP support for), but
how about something straight-forward like:

 What bonding modes have native XDP support?

or

 What bonding modes support native XDP?

> +----------------------------------------------------
> +
> +Currently, native XDP is supported only in the following bonding modes:
> +  * balance-rr (0)
> +  * active-backup (1)
> +  * balance-xor (2)
> +  * 802.3ad (4)
> +
> +Note that the vlan+srcmac hash policy is not supported with native XDP.
> +For other bonding modes, the XDP program must be loaded in generic mode.
> +
>  16. Resources and Links
>  =======================
>  


