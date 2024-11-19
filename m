Return-Path: <linux-kernel+bounces-414165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72FC9D23F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46241B24500
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5311C4A00;
	Tue, 19 Nov 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzWPrHsn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596111C4617
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013524; cv=none; b=c2Pu4MjmMKmAMuAASMpXiZCgiMMz2vqsYSIg5KD6Ova2Q6FnftqKJEAyyXiyT7OZ6E76rxxu7oIfUDQOBkW7PdDFRY5nCq7RDn++8JMGTczx1SFpKqtP8uWjfSfYwJR1Vl9rmT4HoQB4UhgDh4zU3DAj8/+ON6b1fE6fplfSjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013524; c=relaxed/simple;
	bh=hLLJbtoq4usZ8DQwEYJWjvTAZqWoe6mvoTy2U+weHIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTkCi3kfKKGubZGFh3dPZ33dZ9CgvABsKDBCugDvBgLtjT6rZmIgt9tCBQ9DKhSLl6A5xlWhfuUbqujKRHa48CXuQnkd9Ky8YeXG4I6GjYVaE0zWNilR4+uUHc/f1Cb9FnKNtJU6VE/6ewLDkzKmwTYoGRnj9Q/2qbQ+PnXoW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzWPrHsn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732013521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y81IMujErJUfbaKhEYW3qiziAM0qahIoRyTbCf9p3vY=;
	b=YzWPrHsnJYz5MXM4Xxdd9bWlKsy47ic10u0H31RpJcSz0buhs5a+wpB15NHKcuoncO5KBL
	ZuejCrLw39OnyW6MkZD9Ydtg+894aYybso2PDuBxgITSxARjChxUeIf03vN3h7mPY9SNDU
	FstSjx0w/Yet7xPiEPG3Py0OijXD12s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Vod5wg2yMHmhuMoykfFxow-1; Tue, 19 Nov 2024 05:51:59 -0500
X-MC-Unique: Vod5wg2yMHmhuMoykfFxow-1
X-Mimecast-MFC-AGG-ID: Vod5wg2yMHmhuMoykfFxow
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38231e6b4cbso2519400f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732013519; x=1732618319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y81IMujErJUfbaKhEYW3qiziAM0qahIoRyTbCf9p3vY=;
        b=FjTAap4t3eAkPdmd43Zs7qPS+xXl2SdwZnkN9rs0STuTBUgS0Qlfby0j5obh3MKM6l
         H14QIvsY5vIALU11UwNEoRHOLH8uS27HPLJbNn97Mq5XXUfiLeaTLXV1BXcI5TIR9GP5
         MQXdUCDneQfPyoFEVol4QIhtK0IIXDaq5oweqpgZKfT8TIxKvtVJYdPikOkdUBZjAwsV
         I5whYS+6/5AJSWqiHsGes764NN8q1kM1fk3EwzZE9An2nacq8fed0+kAw0HdyqWchvet
         0vnByNK3eMFmRF7v6uW080SgeKcsSMmh2LCMP9wGux4gyVK4lrA2tMPKemv8M8TvxjkQ
         RamQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI2p1Qj6TrJTChBstiAsHTk42nvYxlyhZWtfAmppQBGp+QuvWgYP+/5zQDK7n8zeL09WTAAZ1u5S4lq6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6WTgvB8uw52M0T0YZkqN2nArsYG8sZG+0L3uYGF9AuUX9jpF
	CK+zBW83QOFqoYtiX0fJ0aY+1dHo+oDy68XyLIfSovF1P9woVelh4Hm2l3e8A56IkY45fKk18L5
	be15svZOcvKDHTROpSV9f9Lb7VICfzkTWs1bcysQn3wZg+QvN7oL2gBy+fAidCg==
X-Received: by 2002:a05:6000:788:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-38225ab76e7mr14040299f8f.41.1732013518785;
        Tue, 19 Nov 2024 02:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIHjGWkZEON2R3W6W39hILTmAYF+lwi0WIxVEzV2PccsKxFzKoK54PnsNqNYxKcc03cG0XAg==
X-Received: by 2002:a05:6000:788:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-38225ab76e7mr14040280f8f.41.1732013518410;
        Tue, 19 Nov 2024 02:51:58 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382388d1d00sm9474699f8f.29.2024.11.19.02.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:51:57 -0800 (PST)
Message-ID: <d772d47e-5dc0-4295-a302-e17e75ca8dd1@redhat.com>
Date: Tue, 19 Nov 2024 11:51:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: fix group permission check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, agx@sigxcpu.org,
 jdike@linux.intel.com
References: <20241117090514.9386-1-stsp2@yandex.ru>
 <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
 <673bb45c6f64b_200fa9294ee@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <673bb45c6f64b_200fa9294ee@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 22:40, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> Stas Sergeev wrote:
>>> Currently tun checks the group permission even if the user have matched.
>>> Besides going against the usual permission semantic, this has a
>>> very interesting implication: if the tun group is not among the
>>> supplementary groups of the tun user, then effectively no one can
>>> access the tun device. CAP_SYS_ADMIN still can, but its the same as
>>> not setting the tun ownership.
>>>
>>> This patch relaxes the group checking so that either the user match
>>> or the group match is enough. This avoids the situation when no one
>>> can access the device even though the ownership is properly set.
>>>
>>> Also I simplified the logic by removing the redundant inversions:
>>> tun_not_capable() --> !tun_capable()
>>>
>>> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>>
>> This behavior goes back through many patches to commit 8c644623fe7e:
>>
>>     [NET]: Allow group ownership of TUN/TAP devices.
>>
>>     Introduce a new syscall TUNSETGROUP for group ownership setting of tap
>>     devices. The user now is allowed to send packages if either his euid or
>>     his egid matches the one specified via tunctl (via -u or -g
>>     respecitvely). If both, gid and uid, are set via tunctl, both have to
>>     match.
>>
>> The choice evidently was on purpose. Even if indeed non-standard.
> 
> I should clarify that I'm not against bringing this file in line with
> normal user/group behavior.
> 
> Just want to give anyone a chance to speak up if they disagree and/or
> recall why the code was originally written as it is.

I think we can't accept a behaviour changing patch this late in the
cycle. If an agreement is reached it should be reposted after the merge
window.

/P


