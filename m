Return-Path: <linux-kernel+bounces-422196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8087B9D95B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4097D2831FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAB1C878E;
	Tue, 26 Nov 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbEw++6G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6271B6CE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617707; cv=none; b=cby3WzafIE+ZIDV0aj7GK4USr0ztTIJYtwjRI+lzvFB3NAgyceyMbLNBcSYyMlTgY5HMBSjo6tqX1t1GOEh8BUiSfRBXPdMPjrN85JRxbeQ1bMiee7dBdIdqN2p2S/790R0jkPM8p+ga11bIt+ZqedaJ2ZdjPin1heHhZr+g/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617707; c=relaxed/simple;
	bh=SB9RVzpPrIASoDg3bpjPyfTi6AefWnYI0OM14bBB/fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV41E191pxBQ85T28FuLh7lcIgNc7cTlNbpcXcmWk34yHgJ5OFzhaYGUaC3C5/Z1+/h5VrU82noQ/KQIsHo8JOl/utn+Bu/L7C51cK4hMTTi0BQc9Zvwgntbfhy85cErq7g4HHm1JvAUUitJ95O/xNGblOWDjItV7lMu6o7wCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbEw++6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732617704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c10oVoNw574UgZa8BPhDkAjnTCWOGhdZy0d+349O0RI=;
	b=CbEw++6GfCNUNg0hBsfhibcJ1UFW09b/ND7GeAtrPsgZS/RQgtNBCdV84oKScIraKjmcVY
	hfw8YAtEEnucaxrE74VN0b2466404HV3ONkmvY2udGGfUMUjzVdYctWvsMt9AmGADy4atw
	nKtnqcv6XAAu8Hq/os4xz7ottzxaUqs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-TMn25tl0N4-cJVVzXZSb8A-1; Tue, 26 Nov 2024 05:41:42 -0500
X-MC-Unique: TMn25tl0N4-cJVVzXZSb8A-1
X-Mimecast-MFC-AGG-ID: TMn25tl0N4-cJVVzXZSb8A
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382341057e6so2735699f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617701; x=1733222501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c10oVoNw574UgZa8BPhDkAjnTCWOGhdZy0d+349O0RI=;
        b=GsA5sk1ca4Mx4JVE7Nyc8ZUciDrYt4lOHdSKDXuK8p+SksuAScaqAXobbma3OYgpw8
         gT2IDokuFwjzIPP4enLlPJqGmzirSavc2bWObR5TJV44pQQbt9AahG3GXNHC16l0y4iO
         7XIQRfPJCvg0I+TaTuUg6iWC05kZD+1/VW4ilzRDbJztV4Cw06VwQvHGN03SxBi1L0Gz
         G4WNZduZBBTOsdbtoSk3/WwioEcjfKjex5/OPgIfikdAdF5FO5tpX8rPjD2f8xxfeRBg
         yjsRYZ4VcgAZ8gq+rtGpkg1cXYyCH3siBxDHXlDdBq478vFLVzDoW1zlsYMd4B1KN07Y
         KGlw==
X-Forwarded-Encrypted: i=1; AJvYcCX7+DR4Jb/zcXdQt9RdDHVIUwwLyuurlSU/RD9eOoMs2B8jz4ckSBZKrc7ES8f8WiqUdF371nvaK3aEYfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpP84ayyPdfW9F8nzID/kwQgnFYqwEfNvL1sU1q374iLojsd1Q
	v+uBQ27v+0KT0yG4WphdeYo2L3EXRyVYxK+uWhgIhxSWcT+9SzqaUvh7/o9zFkuSMEXmcKwTpqw
	G8sHB4U8fsYRkpaO0lrRnyMq1fID52MZhrrOxlxmNWFiHPjl0AMKhkEoSBhYl/g==
X-Gm-Gg: ASbGncu2ho+kvHnu8n3VkBCBNenEmWfdQ8soj2CtLyWGE+DAeV5GE8PMa+CY8Jy7Cds
	Cyqydl7t81UjtPSSZCu7VMDnc3ALOSmrqNGv0vF6EM6ttsrgti6uPTpk7raIZ7VByaBk/8UfVDj
	zJlmqwHKULC2BRPcpwtnc71S6998MvNNkyg4ZUG/R+tTtvDd+YJg86GqeZczHpjhttUEtvUzS7W
	9NN6URuoqKoZb1pMeK6POeveZyxQKYF8ilWBYfIfd/6w3qHFI28/NsuQypNyQyke1ZYa/wzCB0c
X-Received: by 2002:a5d:5f4b:0:b0:382:4a1b:16de with SMTP id ffacd0b85a97d-38260b6b627mr14762631f8f.21.1732617701356;
        Tue, 26 Nov 2024 02:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb5Dbp1esF0ba97VSbOBzEQDfodzxC6H9YqoKX1VC2tWE64+bs74QfkZMoN9Is771saUdIEg==
X-Received: by 2002:a5d:5f4b:0:b0:382:4a1b:16de with SMTP id ffacd0b85a97d-38260b6b627mr14762614f8f.21.1732617701055;
        Tue, 26 Nov 2024 02:41:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a0c889c5sm54013395e9.2.2024.11.26.02.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:41:40 -0800 (PST)
Message-ID: <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
Date: Tue, 26 Nov 2024 11:41:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/22/24 11:21, Parthiban Veerasooran wrote:
> There are two skb pointers to manage tx skb's enqueued from n/w stack.
> waiting_tx_skb pointer points to the tx skb which needs to be processed
> and ongoing_tx_skb pointer points to the tx skb which is being processed.
> 
> SPI thread prepares the tx data chunks from the tx skb pointed by the
> ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
> processed, the tx skb pointed by the waiting_tx_skb is assigned to
> ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
> Whenever there is a new tx skb from n/w stack, it will be assigned to
> waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
> handled in two different threads.
> 
> Consider a scenario where the SPI thread processed an ongoing_tx_skb and
> it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
> without doing any NULL check. At this time, if the waiting_tx_skb pointer
> is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
> that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
> stack and there is a chance to overwrite the tx skb pointer with NULL in
> the SPI thread. Finally one of the tx skb will be left as unhandled,
> resulting packet missing and memory leak.
> To overcome the above issue, protect the moving of tx skb reference from
> waiting_tx_skb pointer to ongoing_tx_skb pointer so that the other thread
> can't access the waiting_tx_skb pointer until the current thread completes
> moving the tx skb reference safely.

A mutex looks overkill. Why don't you use a spinlock? why locking only
one side (the writer) would be enough?

Could you please report the exact sequence of events in a time diagram
leading to the bug, something alike the following?

CPU0					CPU1
oa_tc6_start_xmit
 ...
					oa_tc6_spi_thread_handler
					 ...

Thanks,

Paolo


