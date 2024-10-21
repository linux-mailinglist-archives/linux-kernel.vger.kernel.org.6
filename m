Return-Path: <linux-kernel+bounces-373961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3969A5FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C291281B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4811E103B;
	Mon, 21 Oct 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiQhv01N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F461E1C0F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502632; cv=none; b=JcfAbGJzHS4vdfLpatMwQAIzTlBROLa3Yy152d7oDspi6ErrOzBjSbwtF5HxMHc09DwlCmAgbC5OLr5Ajey5qlcc7lG86iQAeDx9boiE/6Rx9C6pfgsexxfuZkEVCEAPwGD0/vea5mH3rRrwaXNUDZjprNdQXEZPhpEJNuGdQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502632; c=relaxed/simple;
	bh=XAazZYLkwAGGoZZOx7JUiyLm2ipHe+8hLTq1JrfcDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQKD565e+fW2US3Orzh4rWllmUF6PYGAkjyM0wq5JgyW+yRJvdwqfWkyJ/YNl9U8Fbzg5Ak+kut7VxnYTiAF1XSl04Q69aARdcLJKwbGQjmnh5DkrDwk08VAMUa9KIZjeKQYWWjvAiJaCldgIJlCCu5CwWsON5RqwCdRnP0B+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiQhv01N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729502629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOPzM8nTUFqwLn8ohf0g1jVEfJikuSPUMDsCZxkKDsM=;
	b=TiQhv01NdZ+2MEt9Icgs6dt73xDtBCYCSodeuEA9tn0R+DS97Pe1Wb/4J05WVJrNmuFH36
	2EC2CUX1rO8OQzA9f3HyGNv5LB8qT6FL/U0wESyWE/J6R8D6K9pzAiNUkQD59DDxCOWHLv
	zaWwLCaEMtQRc1C6o5wyWwM8dfvSGYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Ks_bXxOQM5-IhCrQCCwbFQ-1; Mon, 21 Oct 2024 05:23:40 -0400
X-MC-Unique: Ks_bXxOQM5-IhCrQCCwbFQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4cf04bcfso1845797f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502619; x=1730107419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOPzM8nTUFqwLn8ohf0g1jVEfJikuSPUMDsCZxkKDsM=;
        b=iTkD+D0B7rRywKOqds+GKNkZ2uo0tHd2I3BNQIj6nWg/210pfw5LKjj+0K6p3cJY/B
         fHWSE1ZSPWNQ+g5b+DG5zr+S0r++yAIzpaD2KL/yWyeWD2cQMnOnsARgDhR8Q5/f5/sv
         bEloJirpafvhpA2dAa784anD02PUWX1IdSUG5Mq7VByxvdcPpUHW4JN5sKpq4kngiBIh
         HbfSFwXw/rUdzquLQYZhFDagFxwJ0XAYfeYUplNPtjBzYkXVww9hV7D00ov8oXMRnmyz
         /pfX53TvkCximrdnqLBPakwnTgL0PBy9p+HHXtzv319QciHQzjYLr9g5YH3tGt3Ho5tA
         e9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWw+fOCzFReWvbyEfmyRME8PMHCwZgcY8wmTrIM48KHHAtoQ3Dq+W+x9QeuofzFX1EpqOLcO0D/tMEzSvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoY1MZ4Y0yDzSDW4W4n8Y1GAzyqDkph6V07EOpXdUrtgfQ0ZJ0
	cFsBLgG7gXpsBqzBzo4KibzhsVnjcj3QcjGLP7xs0v0zo8JLIwzRm8I1VTyS0nLeMKG5PgLYaoj
	B8o7kanJaI0v26Zt5xx/ThS1gs6nUd7oFNLX5TomGT2gQeUvTkDDuUxNAZYm8aw==
X-Received: by 2002:adf:f591:0:b0:37d:39df:8658 with SMTP id ffacd0b85a97d-37eab72a94dmr6219404f8f.58.1729502619022;
        Mon, 21 Oct 2024 02:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysyLKLLu8ecA+EiDeIyFSZdEdGbiDbJIKLmvhlv8Jpyw7lbNkChKbBAKP5wBfWcUaSVANmA==
X-Received: by 2002:adf:f591:0:b0:37d:39df:8658 with SMTP id ffacd0b85a97d-37eab72a94dmr6219383f8f.58.1729502618678;
        Mon, 21 Oct 2024 02:23:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cbe7dsm51045765e9.39.2024.10.21.02.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:23:38 -0700 (PDT)
Message-ID: <6b95c3c9-3b8b-4db3-b755-a3652c1a59cc@redhat.com>
Date: Mon, 21 Oct 2024 11:23:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: ethernet: mtk_eth_soc: optimize dma
 ring address/index calculation
To: Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241015110940.63702-1-nbd@nbd.name>
 <20241015110940.63702-4-nbd@nbd.name>
 <e67883e3-b278-4052-849c-8a9a8ef145f0@lunn.ch>
 <695421bb-6f31-4bae-8c8c-6d4fccf1b497@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <695421bb-6f31-4bae-8c8c-6d4fccf1b497@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 15:07, Felix Fietkau wrote:
> On 15.10.24 14:54, Andrew Lunn wrote:
>> On Tue, Oct 15, 2024 at 01:09:38PM +0200, Felix Fietkau wrote:
>>> Since DMA descriptor sizes are all power of 2, we can avoid costly integer
>>> division in favor or simple shifts.
>>
>> Could a BUILD_BUG_ON() be added to validate this?
> 
> Not sure if that would be useful. I can't put the BUILD_BUG_ON in the 
> initializer macro, so I could only add it for the individual dma 
> descriptor structs.
> Since the size of those structs will not be changed (otherwise it would 
> immediately visibly break with existing hw), the remaining possibility 
> would be adding new structs that violate this expectation. However, 
> those would then not be covered by the BUILD_BUG_ON.
> 
>> Do you have some benchmark data for this series? It would be good to
>> add to a patch 0/4.
> 
> No, I just ran basic tests that everything still works well and looked 
> at the assembly diff to ensure that the generated code seems sane.

Since this series is about performances, some related quick figures
would be really a plus.

At least we need a cover-letter to try to keep the git log history
clean. Otherwise cooking the net-next PR at the end of the cycle will be
a 10w worth task;)

Please re-send with a cover letter.
Thanks,

Paolo


