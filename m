Return-Path: <linux-kernel+bounces-512844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD675A33E59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703807A37FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183021D3F8;
	Thu, 13 Feb 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROMyeEFg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280421D3CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447111; cv=none; b=Xu3DyV3W0ZL8FmfJX2QtqY5wN+KtHOmWpQLB5t9bvOGw6Isr9kiLJ+UraG+m7725eaCVU/aDigXKJtvgUBGCVazPHtIbZLgxX+T/FRkxhA9uUwSlyLPGad/06xsH1HnWvXVapJjcPWqjmzW8i7grqv4TryABjiHRZjbxufNa0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447111; c=relaxed/simple;
	bh=z4FzBPhL+KmxxVmJsJ8LIv/mETG7bxy17DamwT8n4wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNc7aNsBNnfLahoTnrkuDBlJVbXJNM3fJk6KHCdX0wMacFutzAu4c8D02IMnRi8Xy5aAt0KiGMephVGlnAJynRavv5JokYvwLdpNsR8QojD3tHQUH9/2FYhbeTKwJx2l2WFLm3s6QT6aAH5z/i+H6RbNwSR+gb5bl0pvq2xRVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROMyeEFg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739447106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ail4YrUpEYkDWqUc8Ez27id76e/8NDgaGRJNAbGRmo=;
	b=ROMyeEFgkZi945VUofvcCt9ti1yiYBpu0PevTjFx3w/rdNE+GFBJKnvyMbBx0uxk7InI85
	Lor7WdCEd0RZPPbqrt+97cdwnOfMoH5ef2G+k/zc375ZIDXaH9rZ3JKDZMsrEKflfZf5hO
	GCmkpmqY1+o16UxE5/Qh+JUIIp9m/3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-H386ZK1aMSGQQOEDbJxSpg-1; Thu, 13 Feb 2025 06:45:05 -0500
X-MC-Unique: H386ZK1aMSGQQOEDbJxSpg-1
X-Mimecast-MFC-AGG-ID: H386ZK1aMSGQQOEDbJxSpg_1739447103
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439622e9113so3849605e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447103; x=1740051903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ail4YrUpEYkDWqUc8Ez27id76e/8NDgaGRJNAbGRmo=;
        b=D9QOR5qqzCKCrcGSSXNyPMt7DOXsM6EVB182y6jY/lrdBHH8IKM8zp+BIfaoqXP+sa
         5VPtDUCGVBYQBTdKBjrg4ad33Sz1D6gTxpu6ORmJUNWCT8PdkJk6QWl4GIV2BULALLPg
         YvQcBGu6fmfi0ai3Zo6+DoZirTH6iLm+r8hg7VfsytMZidWAOv8ny472+DqfWCSqj4YF
         Pz0jTEpuXniIzOeU8s4TFulbuTJEKw33RWgpbC7ZaXp71umXRZgCS3uXrbRp5C/V9cue
         83jZKLrwaLfIVBWswy5uUZo24tDW9zhAZfEwXHyQCTx6PSCLp6I3rudZHhEAqS5Agk6S
         pyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbm5uSW9i9PJuhkc7HWccNYjd2bwuply5ldE0E3VFDkfT76mVVN5fqbLTQtQRnevVqxmvhFaBoEiB/u3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRT2iq3nlMv9umLHSSWhf58sZWsdcof0Kp0hswk/FV2G+m4l3
	C/mh2GmrzsdiK/eGxgzmGe2oPfD9VRPbFAw5XVbQ9GBksddbkHnOmGwXlEcUimOqlMpHAwWYVPD
	oYsuFBI9SzKUBN9FWGmBL+Ff2Wvp1UvWmVetQeu6gsWelbCXUOLH6cEmxW0ws8Q==
X-Gm-Gg: ASbGncu5pYTG1vixiwWjKQQpswn+1cH7PhA8etWcZTQoxYW5up3LuwBR4Vl+IvNBDaj
	V8dCWOP8992v0t0ts5IpI0mVPqU4jbeMQdK9lEH6tAywCH5GmG1K9+iSDCTE4Nu5Wi2UB0VDUvb
	pZ479/aw9RdSaDftEBs9wVhfmJmcGVHckPD8HyiNaYeDHdfz/YVQUMCLtAdZGJhhQQTaMvOwHTE
	/y+ozPoP4oCyl8FPxjP/h1cSvgfPPT+iUuG0YdCevT6HVA1z9ZcbK99lt121AGzvfHjQIkuzmP8
	XgokVo6gxOkJH2Wit8Kb6FLSCvrbZTVNfGk=
X-Received: by 2002:a05:600c:3ba8:b0:439:4832:325f with SMTP id 5b1f17b1804b1-43958160560mr57564825e9.1.1739447103150;
        Thu, 13 Feb 2025 03:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsSaO9nwngXTwOiOIOnC4gfeygnFqnmDRDuBNDDrC1cNijFS2fay3xrPf6j87eCOO52vmu/Q==
X-Received: by 2002:a05:600c:3ba8:b0:439:4832:325f with SMTP id 5b1f17b1804b1-43958160560mr57564445e9.1.1739447102713;
        Thu, 13 Feb 2025 03:45:02 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da91asm15645415e9.2.2025.02.13.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:45:02 -0800 (PST)
Message-ID: <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
Date: Thu, 13 Feb 2025 12:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
 ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 9:06 PM, Joe Damato wrote:
> Document the existence of persistent per-NAPI configuration space and
> the API that drivers can opt into.
> 
> Update stale documentation which suggested that NAPI IDs cannot be
> queried from userspace.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Reword the Persistent Napi config section using some suggestions
>      from Jakub.
> 
>  Documentation/networking/napi.rst | 33 ++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/napi.rst
> b/Documentation/networking/napi.rst
> index f970a2be271a..d0e3953cae6a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> of a given type. For example,

It looks like your client mangled the patch; the above lines are
corrupted (there should be no line split)

Please respin

/P


