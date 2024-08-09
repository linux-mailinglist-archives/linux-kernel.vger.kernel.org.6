Return-Path: <linux-kernel+bounces-280506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0214094CB77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67791F22EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC4176FA0;
	Fri,  9 Aug 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BpiwhSN/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2F12FB34
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188827; cv=none; b=loYGGuUtQj6JgQaepwjtFlzQYZdnHMA4G1LRPOJGf6DAJPUIPb6uOIBN9FSfgCGR+r/yu+Kutuk2kp6tkrBvhyAUSdSgWIYwy+7K30PibyOCzkMPf26BNuLAdjjKQCuXGPaiFUSkbNoTIoTpGyVOA10jCio/6mfEfhLPk0BnwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188827; c=relaxed/simple;
	bh=Q1mcjuLONqfG7Z4yG6maXMM/vZq+kT84tDgsoE76ncM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhaY3tCsn4COIEhWzLKiqfOxWyrpPswZ4uIB5lRnllGDoiyhuJW1wYFNuGa82WZBZiOPrbAOPnh1zunQh94netoc7KRmc/khiWASkzHNkBqXo+2z64wR7TZgkbRmIKIEApJIbNqPfxLTAIZXBDz6nOHJUV7c9aHuZQCs/aq6sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BpiwhSN/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so1607933a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723188823; x=1723793623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SGsldqp+hDlVL8D57BpMZOsCk6Ojm6sVxq8GpmZQ/w=;
        b=BpiwhSN/kz3fDHSkwMfssgDYimhkz0I0/dYS+bU0Go3ZTYi2eqEKvoEVFWFX2OMMSM
         NRyWZAie6FGi8w0yC6klz8yXocNoPosTi0+ZRJGtagjS5mqL0hA8frQEvWdOOM3Kze0z
         jQOgUumghEXKHoYZBMvvF56MX0ASRvsecqQtJEP2nd3maIfNzfRBwePsTfvsTlXos00Z
         RMfKAByM5MJJ45FJciTtiQwy3spiF3QAH3ykFmuy3TjO3zZplMNrYPV6tUOUWrvd5RXK
         amp3BuJtnvrcU6JH1pN6d13JqVMpAHo6f+UkCJUmCnSwRDAkxUIRn2GfWBE1u5JQG1uA
         VTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188823; x=1723793623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SGsldqp+hDlVL8D57BpMZOsCk6Ojm6sVxq8GpmZQ/w=;
        b=HlntMx/zK16vEcWAO/Ir+waIhtFe7NzH71/BLRr1b5MV/DwTcgOUfhBdSham67A6Fb
         +C+w15Md+erKP/JZwKMvoox9OWBM7nkxUAy6yfDzZk+Tsl7IP5RKqXAjCjTqrbZKXM1u
         /xRlBKXvDbAdEScGy7DVOT/d37wN3ez5VreutY5ds9SGArmRB/1E9yFBGv6TIjz+8ZaB
         hdrxo3ZZp4K0mgUsP8ji4k48LxoNnKscnyoU+0qkJwOCCTfZkmNOiHTzBq35Z4FmoOJQ
         bBm8eErXAjX67I4v8MS2VLkPDNl1AiZbtU58R4ZR1LtKO4uhICtKHYUIhDXhhrpqqrF9
         zFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPS9lOBR8OO3AOMUW9CLa2MD3Q82WErxYcjPrsfqPIJl6j0rtm5EUEy0sNFNo6Xfjdr78M96yy8H8p/Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0sdo8FCwIaL7h2o3vUMYyzJFRd3+IdioBGQe8QAX/1gxfXcX
	YNBxqQBPhUpInxxCoji5Ho4hFKwuaH/vgMqjs9aG3xUP1G2At2L9Rpp20xNgdqY=
X-Google-Smtp-Source: AGHT+IELDFmoH9CY6TfEHd5HnEe1eK9/Z/OJypNEf5K4kh+1tYHH0J0ihVr3o6pUtepvwBsIlOXlUQ==
X-Received: by 2002:a05:6402:34c4:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5bd0a5bde68mr563842a12.18.1723188822374;
        Fri, 09 Aug 2024 00:33:42 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d34a69sm1293037a12.70.2024.08.09.00.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:33:42 -0700 (PDT)
Message-ID: <4345f70a-4d82-42b5-a607-d93db02ffb9a@suse.com>
Date: Fri, 9 Aug 2024 09:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: cdc_ether: don't spew notifications
To: zhangxiangqian <zhangxiangqian@kylinos.cn>, oliver@neukum.org
Cc: davem@davemloft.net, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1723109985-11996-1-git-send-email-zhangxiangqian@kylinos.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <1723109985-11996-1-git-send-email-zhangxiangqian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08.08.24 11:39, zhangxiangqian wrote:
> The usbnet_link_change function is not called, if the link has not changed.
> 
> ...
> [16913.807393][ 3] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
> [16913.822266][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
> [16913.826296][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 11 may have been dropped
> ...
> 
> kevent 11 is scheduled too frequently and may affect other event schedules.
> 
> Signed-off-by: zhangxiangqian <zhangxiangqian@kylinos.cn>
Acked-by: Oliver Neukum <oneukum@suse.com>

