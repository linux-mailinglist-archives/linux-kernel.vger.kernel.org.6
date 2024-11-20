Return-Path: <linux-kernel+bounces-415532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6229D37E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F77B2AF99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69519CCFA;
	Wed, 20 Nov 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhG5jRu5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD19171E76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096460; cv=none; b=RSMXJdLeS6nQnLjacMIdZTKGb+rG1RkM2DEnN/p53b/7DQerammu12Mm79laWHgkdGqboWlvEAzJpifqYP7HkXSYY/skoIG2YXp+hx8BqEONy4SMqKIaQWUdauJ/AboTV1hWlDn9PMJCJ92OskjkGTYgQkL6HGUBAgqXfiWWcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096460; c=relaxed/simple;
	bh=6+kSYwM46iXgBfi4BIO36+knYfu6qPvrCtDgL0vuI08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t9UiZxjXMLmlIKp/ItBfXyylK9umHMzjwJ20CBFQq2uDF/InP9HrVyH0D0jDxji1A0C7SMayUnEnpE+myQqYUzspQRtFTzAW4317HFbvglyZlUGxdZSRv5nlmq4DUJNgmNxurNgViDBTQ7+tnpax+nm5i9DQBVt6yUmn5Q6h2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhG5jRu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732096458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbiOLUeOow1OwHuAIeVM/vyiCjsuUl/cJgPqAb9nzdw=;
	b=LhG5jRu5xtanKZvhUPWZrVPqLLKNe+TKaFoIq4EGRmFxFds8Mv5wvl65luAjNicImPsaPY
	Jdi6HcJ4LPGX/jPlpXUwammCJC+7GyoYV07KUqoLns3YQJW5mE57IR+koEYpZn/rmDQifI
	qakAOtKS8HlqK9GAJeQQqIU47Kfv7tQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ciRsxny1NT2IhU-FsPKr_g-1; Wed, 20 Nov 2024 04:54:16 -0500
X-MC-Unique: ciRsxny1NT2IhU-FsPKr_g-1
X-Mimecast-MFC-AGG-ID: ciRsxny1NT2IhU-FsPKr_g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315af466d9so30151725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096455; x=1732701255;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbiOLUeOow1OwHuAIeVM/vyiCjsuUl/cJgPqAb9nzdw=;
        b=WMh5JsykUVa120Yxhn4f2CJCJxpVKsmLTyQciLv7KwWOIrEkfdHrc/JZtbNyN/1bTn
         mUrOhjV6gG97zU2YEZF7PbNs4oMDZICgUGQyXdvGO/iZap8Jx7Tl0szncOe+lvsn0Ear
         ucmG814qgM3A7DYfdD3l4RorIGSV6oeW7QRmWTTuj7m0ZhW/yY/8KnD15kMSdBHdpHhG
         DFFjpzrGNv684XrNlSfczjev0s6ba3EjY03RPSoSjMcLB/pco+yLEewoHWMnF0shX2Nl
         ISnlc0GPdgM5CJBj8a9VLqLcyn4EIUSxaOXqJMZj+vw4w3ZNmMcHiybeLoVgx1S18jns
         EeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyyoY9VHHiRbDbn+ZoMaz1rP2WQjU1NjXz0BdNqkmhIVWVFVY9L+SNgoh71/zdRCZGUksIgKnnMA9FEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ag7ndwQGvjvx4n1alS498hkrzpt3OpDAhsJQIwGRwpR/zeQ8
	DOl8SLuYrJ7hF69JO688KK4XdRj0+zzP5MDkn/za+3bpdovtOyWR5Pl0E35oUwdZMDTpE82niwd
	/pTpADZy7fUo7160KjlMpWPkeZdGH/DOX7+VC0ZRvi54DluqL23uYOV9jLmdkPg==
X-Received: by 2002:a05:600c:35ce:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-433489814afmr18009625e9.4.1732096454917;
        Wed, 20 Nov 2024 01:54:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXMulEZ4fyzBXzlnp2Ga9PLAXAG7RNZVj/xsBGVFnmcRkjlWgLt0bBoAjxJ8oiDKgVuh2ZcQ==
X-Received: by 2002:a05:600c:35ce:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-433489814afmr18009375e9.4.1732096454430;
        Wed, 20 Nov 2024 01:54:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab6csm13344535e9.35.2024.11.20.01.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 01:54:13 -0800 (PST)
Message-ID: <7003f775-7389-41ed-95e5-1e0e07f3f6fb@redhat.com>
Date: Wed, 20 Nov 2024 10:54:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
 <20241114-ancient-piquant-ibex-28a70b@leitao>
 <20241114070308.79021413@kernel.org>
 <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
 <20241115080031.6e6e15ff@kernel.org>
 <9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
 <9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
Content-Language: en-US
In-Reply-To: <9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 17:55, Paolo Abeni wrote:
> On 11/15/24 17:07, Stefan Wiehler wrote:
>>> On Fri, 15 Nov 2024 01:16:27 -0800 Breno Leitao wrote:
>>>> This one seems to be discussed in the following thread already.
>>>>
>>>> https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/
>>>
>>> That's why it rung a bell..
>>> Stefan, are you planning to continue with the series?
>>
>> Yes, sorry for the delay, went on vacation and was busy with other tasks, but
>> next week I plan to continue (i.e. refactor using refcount_t).
> 
> I forgot about that series and spent a little time investigating the
> scenario.
> 
> I think we don't need a refcount: the tables are freed only at netns
> cleanup time, so the netns refcount is enough to guarantee that the
> tables are not deleted when escaping the RCU section.
> 
> Some debug assertions could help clarify, document and make the schema
> more robust to later change.
> 
> Side note, I think we need to drop the RCU lock moved by:
> 
> https://lore.kernel.org/all/20241017174109.85717-2-stefan.wiehler@nokia.com/
> 
> as the seqfile core can call blocking functions - alloc(GFP_KERNEL) -
> between ->start() and ->stop().
> 
> The issue is pre-existent to that patch, and even to the patch
> introducing the original RCU() - the old read_lock() created an illegal
> atomic scope - but I think we should address it while touching this code.

@Stefan: are you ok if I go ahead with this work, or do you prefer
finish it yourself?

Thanks,

Paolo


