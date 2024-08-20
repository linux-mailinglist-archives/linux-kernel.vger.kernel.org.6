Return-Path: <linux-kernel+bounces-293743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C29583E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E811F20631
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212018CBE2;
	Tue, 20 Aug 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCC8nAg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFA188CC5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148926; cv=none; b=YnDjikMzBQoF9H+kCr4rcgQCVukE/SeYBwR5atjrNbyiVflPo6qwVl7GlaTLkuFgatPyv+towliMu0df57QJQhE9LuNc5Hf+01Xhfpg+aToQu3mNF5TBXczeL2WbegwvkoJKI9FRoorXvlKLd8nAbuuJKDJJLDvQNZmlEYeLDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148926; c=relaxed/simple;
	bh=MRYIGSOSbqWcGCpS7eeweY5sPDyQjSsVn9evAIxkLXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ef0UmIQw+Ye4Z+AA2c5mwtkbtc6JW/PKct22qaW/Y2V5Bxz6VK2da0kcDq7zvap9vdbrUTUW0VRoi6+8fBOY0bgCujqX6XiwnxoX5TPtdGrEPPGQqjbALwZmtcaer1w+EQLpwffzriZ05gRRPb+OdDXPC71yg1d0cq+SfnKX3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCC8nAg3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724148924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOG9ybdUE74HfT0xY/KZ29V4lJHlpnppytRZwc0Rs94=;
	b=fCC8nAg3i9q4ZnlVwRgYc9nSiDCetpSeRyrPa2OhnOXaFHSJsN2NG9QH90iLPHYYsvlr6Q
	16vWcuSN+OCWWU8Ax+aH/jFXHA4uEfqcCoGQCiDeMXZ7qw9keSALoT0/4UfOGMYU/bOYyi
	eOAK/exXQdCshtbMQpCDA+/4p6ZlZy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-XOwAy3wQPjSOtx9i8ixXTw-1; Tue, 20 Aug 2024 06:15:22 -0400
X-MC-Unique: XOwAy3wQPjSOtx9i8ixXTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428fb085cc3so10014685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148921; x=1724753721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOG9ybdUE74HfT0xY/KZ29V4lJHlpnppytRZwc0Rs94=;
        b=TLltFv2pO0DSyI73P2Sbw52AbyApb1tc0OCsCUoDkrGlk7+Zv3CkyRBE6jQN0jv2oU
         GlONwqLab803sydApTr6pLo9heY5+H3kMbknoF4ffD82FHTShPXnTxYrocQHT5CZV3Ih
         TtEMxLVzMGpg6uMLC4Gs0Dvt5lKwaQQ5hZmOLrLvhV2I9ENHU2nJIrSxxxk5R2tvuA9F
         1TxpojF+e2tqY4ARqYImIFAFKeH4hpeiNvwjmvaEhk6VQF0vyMschtCDXlJ2klm8sSDf
         QkK6GcUESyHHN091U9687omtpka71kJ2q+aXH4/rzzTRehoBgaBqgXD96AJmXnHGRd1l
         mvaw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJIg4Q7AiKepeQExdlloRHtwYD6C6SKyCXYpb3vZdswClbgib9PAzDEyGNbFLM1nkOw4Z5kte7c27u8Qi02SGNg/3Pb/CDZQeUsyr
X-Gm-Message-State: AOJu0YwiR/vTqVfGQs57J8y0RKfLEZbtLyX4AWD2i0l2dh3eM7kWj3Sq
	nUO146sm+dsu/GutJLKuN2cwCbdXsJJG5Znc8evb/rwM2e8aBsDkj6KkKWj2lwvNbTsSPDYxSVh
	YVfxQjje3vPY15SxFj6AH/NN+sX107BIM6zcDF+1Aut0zUF2hY1nQa6i8jmuStA==
X-Received: by 2002:a05:6000:400f:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371943282f6mr5858748f8f.3.1724148921612;
        Tue, 20 Aug 2024 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEYIGr0mleZL/s18kcq9OFPn2+MExIhTUkOVRIv8PYk+G6iWCJWI1P+1g+0WfYxZmzwoWWIw==
X-Received: by 2002:a05:6000:400f:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371943282f6mr5858737f8f.3.1724148921161;
        Tue, 20 Aug 2024 03:15:21 -0700 (PDT)
Received: from [192.168.1.25] ([145.224.103.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2e2sm12752383f8f.16.2024.08.20.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:15:20 -0700 (PDT)
Message-ID: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
Date: Tue, 20 Aug 2024 12:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
From: Paolo Abeni <pabeni@redhat.com>
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
 <20240815022014.55275-3-Tristram.Ha@microchip.com>
 <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Content-Language: en-US
In-Reply-To: <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/24 12:08, Paolo Abeni wrote:
> On 8/15/24 04:20, Tristram.Ha@microchip.com wrote:
>> From: Tristram Ha <tristram.ha@microchip.com>
>>
>> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
>> shares some registers and functions in those switches already
>> implemented in the KSZ DSA driver.
>>
>> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> 
> I usually wait for an explicit ack from the DSA crew on this kind of
> patches, but this one and it really looks really unlikely to indroduce
> any regression for the already supported chips and it's lingering since
> a bit, so I'm applying it now.

Unfortunatelly does not apply cleanly anymore since commit
fd250fed1f8856c37caa7b9a5e6015ad6f5011e5.

Please rebase and re-send.

Thanks,

Paolo


