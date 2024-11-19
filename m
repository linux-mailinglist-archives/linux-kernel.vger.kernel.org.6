Return-Path: <linux-kernel+bounces-414179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A339D2459
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10569281870
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AE1C0DCB;
	Tue, 19 Nov 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnr5z4/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126833998
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014101; cv=none; b=hPTvLRx7IsrQXFZwbwaTvO2qgEVTIgLUR20alF9Ky/qfZpQQN8SEAvRIgEgpAAvwI2DkH3R9VUwIvJKVV9MhZHnGJ4NLg7r7BWznKm+2fIWDyb/EaVcXXclNfCXoX+0dxZEiImi6gJ6C42bSZ5W6L4H/XsYeMdWP4DpU3XjUrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014101; c=relaxed/simple;
	bh=dbMltewUQlMW0Sem8DhCaaHZBlr9ohwY1znjXghpqK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMEoTPemDkywqi9waDGUhcFQqovbax12aZvx1DLLx+cy5L9Y4zQGIpjFr6ez2fj7XNtxfxfZUqxPE0ANpY0gWYu6gvHML9XX0F+bGFmyqXbsYQKR1kyVjK5zmpXyank2GAHQytGepT7c9U/gL1LaF2uDrJMeLJXS6tzPEt7sdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnr5z4/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732014098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5x1zAmftlOxErhov99kYFrr4C3ad6y3JktV/UxDbWo=;
	b=hnr5z4/uy6qo1sd10GXNk4qcAwMxlP7ZVC/qk8J0F3P5FZce4qa36MENTCd+auImfBc7iV
	DSoWA8BowGQbmiHzL7GOJVYKqwfX7nbA/F/5uizXwaSmmfjlEesBwPlgYl8gVMYAnlt0FX
	sLvxDCqLNHARA/ulrcbMOTcZJGRqsBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-OYL0KfZ0OKeGvl7jQqEqyg-1; Tue, 19 Nov 2024 06:01:37 -0500
X-MC-Unique: OYL0KfZ0OKeGvl7jQqEqyg-1
X-Mimecast-MFC-AGG-ID: OYL0KfZ0OKeGvl7jQqEqyg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-432d04b3d40so33470535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732014096; x=1732618896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5x1zAmftlOxErhov99kYFrr4C3ad6y3JktV/UxDbWo=;
        b=K+b0e8jvnco7PM0Hb0tboJu+ttjfHA1/H7vhWkAhXqM2iaWHDCwaEhT4fiyAmoEser
         HViU5LtYnYblLsyvhh11iEGwD9rgpPsc8/rnGCYUfG0qTaw9IrEGIf4j8EN+PLApyKvG
         1foAwgVmIXflirqRU+qDWIXb2CPxcUoUr/1DIx1KOy6u/6Cuav2LPSyV78+6PapOaNxm
         UpR5Yf9PhWz16CUZEQLg83MJHXty1tsYjq/hduanpGsG5WCkJUTXKIwLf5JGnAEQa3GR
         N/eezJFy+y0gCYsHDM8WdH4NBvM3snKVNzUgeRpVA3g9JwZ7QiTF6R88l8lBybfP9ZkX
         /ymg==
X-Forwarded-Encrypted: i=1; AJvYcCULZzlDLdtF8177KeRWr3cDU/seWts/uY264k67noQECRvImSXRJQ7vTZBj/3djUmgdVLOLqwcT0uL4fg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaX1UuR0tdHgL7noCIf7/HmLMT05g9+85Nx42QHCFRvrLZZob+
	zPhZDiIki+upjoQ2Sp2iEsqbYqIZnFB57IzIebMVkwL0uyAO9zxqQHe7WSpTXiNaLNSjoelgFdZ
	yJkE7BlUquVKroXB5fHfGjWNkId9l/vPefzaDBLN5aANXE+mp/+ONJyndUBwHgA==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr120186465e9.33.1732014096351;
        Tue, 19 Nov 2024 03:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUgk3hoEITcm/fHjPQY0HbLJGUt2q30yrEQzJiBHczy6KT7QlivIFvtIT5gOta2ObouSh3gg==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr120186245e9.33.1732014096054;
        Tue, 19 Nov 2024 03:01:36 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21a15sm187619345e9.38.2024.11.19.03.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:01:35 -0800 (PST)
Message-ID: <de23f3cd-833a-44c0-91bc-5a013458a05f@redhat.com>
Date: Tue, 19 Nov 2024 12:01:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty
 ifr_name
To: Song Chen <chensong_2000@189.cn>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, kory.maincent@bootlin.com,
 aleksander.lobakin@intel.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241117045512.111515-1-chensong_2000@189.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241117045512.111515-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/24 05:55, Song Chen wrote:
> dev_ioctl handles requests from user space if a process calls
> ioctl(sockfd, SIOCGIFINDEX, &ifr). However, if this user space
> process doesn't have interface name well specified, dev_ioctl
> doesn't give it an essential check, as a result, dev_load will
> invoke modprobe with a nonsense module name if the user happens
> to be sys admin or root, see following code in dev_load:
> 
>     no_module = !dev;
>     if (no_module && capable(CAP_NET_ADMIN))
>         no_module = request_module("netdev-%s", name);
>     if (no_module && capable(CAP_SYS_MODULE))
>         request_module("%s", name);
> 
> This patch checks if ifr_name is empty at the beginning, reduces
> the overhead of calling modprobe.

AFAICS technically this optimize a slow path (bad input from the
user-space) at the expense of the more usual path (additional unneeded
conditional) and still AFAICS, there are no functional issues addressed
here.

Note that even the latter more usual path is not a fast path, still the
optimization is not worthy.

/P


