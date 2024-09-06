Return-Path: <linux-kernel+bounces-318387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B02996ED0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279DE1C23451
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1CC157A72;
	Fri,  6 Sep 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NF8C7DWD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82415530C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609705; cv=none; b=FCu7VXAsNYivWK9hlM/sDByTWVOWDRsB9BhaSLg94uA+wKoUZ0MHmahsu73WYG2HaSQ7Z3Vw5yxxb8hSuPVI87arBLj0fekzmpet/v2UUx+Q4jiqh85FCyC82tv/jG8RPs/Vfalxaf7NhfPuCjzBscJ17kmhj7DaoANXQVLhjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609705; c=relaxed/simple;
	bh=SbmM5uhbcnL1olHSU93fypGNtH3znpt3dWvOUJqzD04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LChrOmZRlYNFIcxm7hzw/I5DY+X89HDfVsDxIkoekcCGojEnr7ZGSU5+iEGGrt+gg7nXK+uwyHCh09usQRXag9jzxeZP4rhGPwSKr5D+tZeaXRL2lAMQ5My5h8wkOPwjH65Mu0ZbJ3CoEvf70i46/b23MDFhbej0vN2q6Ode1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NF8C7DWD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725609702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3w8BEgArxnjLRVy3qsubm87vN0Pe8HekCRHq10oOa7w=;
	b=NF8C7DWDSba7cnf/tdVxwp3sTk8ZuJYhUZzPesOHGts5q8xgFZ0oErmZB446X7jqSDyL99
	HA1NqCuwHMeAvr3WVnX9QYziIh7q8RRrT3+hLrwFLa4DdegUu4a7dkPnMM+ReM6lhr/xez
	IySl85/mJu6iikEDp+T0P0v+Bjc7pgI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-nKNZTWVNMt2kR383ZUvZTA-1; Fri, 06 Sep 2024 04:01:41 -0400
X-MC-Unique: nKNZTWVNMt2kR383ZUvZTA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53654420f0cso1540519e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725609700; x=1726214500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3w8BEgArxnjLRVy3qsubm87vN0Pe8HekCRHq10oOa7w=;
        b=CWOwaTM2p6QmS3Rdsr8ZGMjF8hikGfkCvrv3MxtuS835ptkZt1UGecPHvhGxP/WkdO
         TjeZsQBa4UJHJt6TtGgnAnlFOn8l1zdoF+dK+E8obxYrTYP/gEIKwsmaq1tR9fzNrsoV
         cjlXY/SFIDgw5XnmnIyqg+AXAZxrVtl/k1ttMALMd8hsPh2DPB98H0994ebE7huwN5Mp
         ChaQqoNZOQ4K05dsk5iktzn/oVBVfUjgVzb4UnVBLAdXyFIo/fzY7iHllpNqPQkM4oIY
         YoTidjRdsfS8WJrzVjqLO40eZEWHhIpf61DjkLs/G1wlaYl+to6uxtLLWm7MECstxkXx
         uu+g==
X-Forwarded-Encrypted: i=1; AJvYcCUpIzMQo8FJy2BBEOd+2XA0sD1Edxb2r4Jg9LyABJXXw/pikJTgNNysKz9WkbP+a9WSpYUJp0gMH8Fx//Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZ1ScrIitt/P3hLHdy80dAg6ENG/t1xcR1kn4PjjhNO1R4lfg
	OuYWwQ75VmikKS0nN5jmu0aCvp8jdly9GQ8niGGQmzZGEU/e9K0mGOB77z2PEWIKn6NRyqs/0GB
	5fnvQ8CK04a0sY/snJ5ZBQyxFwBCfvKN67VEUckgTkCP+KtVqu5k6Q32VvFTK2w==
X-Received: by 2002:a05:6512:3a83:b0:52c:952a:67da with SMTP id 2adb3069b0e04-53658809ffamr1126523e87.55.1725609699486;
        Fri, 06 Sep 2024 01:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp6YUa7kCokg8ObVcxyPBkjN1eJGchaQwvf9zGEui7SeGHmklIylF/+N4KkS1IWFbzJ8ZWJA==
X-Received: by 2002:a05:6512:3a83:b0:52c:952a:67da with SMTP id 2adb3069b0e04-53658809ffamr1126482e87.55.1725609698865;
        Fri, 06 Sep 2024 01:01:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6e1b7e4csm191617466b.14.2024.09.06.01.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 01:01:38 -0700 (PDT)
Message-ID: <813ec28a-a88a-4ba1-976a-578fed314733@redhat.com>
Date: Fri, 6 Sep 2024 10:01:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atomisp: Use clamp_t() in
 ia_css_eed1_8_vmem_encode()
To: David Laight <David.Laight@ACULAB.COM>,
 'Mauro Carvalho Chehab' <mchehab+huawei@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
References: <155aba6ab759e98f66349e6bb4f69e2410486c09.1722084704.git.christophe.jaillet@wanadoo.fr>
 <20240906081542.5cb0c142@foz.lan>
 <8c8b5727abf44e429727b70365cc3048@AcuMS.aculab.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8c8b5727abf44e429727b70365cc3048@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 9/6/24 9:56 AM, David Laight wrote:
> From: Mauro Carvalho Chehab
>> Sent: 06 September 2024 07:16
>>
>> Em Sat, 27 Jul 2024 14:51:56 +0200
>> Christophe JAILLET <christophe.jaillet@wanadoo.fr> escreveu:
>>
>>> Using clamp_t() instead of min_t(max_t()) is easier to read.
>>>
>>> It also reduces the size of the preprocessed files by ~ 193 ko.
>>> (see [1] for a discussion about it)
>>>
>>> $ ls -l ia_css_eed1_8.host*.i
>>>  4829993 27 juil. 14:36 ia_css_eed1_8.host.old.i
>>>  4636649 27 juil. 14:42 ia_css_eed1_8.host.new.i
>>>
>>> [1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com/
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>  .../isp/kernels/eed1_8/ia_css_eed1_8.host.c   | 24 +++++++++----------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c
>> b/drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c
>>> index e4fc90f88e24..96c13ebc4331 100644
>>> --- a/drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c
>>> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c
>>> @@ -172,25 +172,25 @@ ia_css_eed1_8_vmem_encode(
>>>  		base = shuffle_block * i;
>>>
>>>  		for (j = 0; j < IA_CSS_NUMBER_OF_DEW_ENHANCE_SEGMENTS; j++) {
>>> -			to->e_dew_enh_x[0][base + j] = min_t(int, max_t(int,
>>> -							     from->dew_enhance_seg_x[j], 0),
>>> -							     8191);
>>> -			to->e_dew_enh_y[0][base + j] = min_t(int, max_t(int,
>>> -							     from->dew_enhance_seg_y[j], -8192),
>>> -							     8191);
>>> +			to->e_dew_enh_x[0][base + j] = clamp_t(int,
>>> +							       from->dew_enhance_seg_x[j],
>>> +							       0, 8191);
>>> +			to->e_dew_enh_y[0][base + j] = clamp_t(int,
>>> +							       from->dew_enhance_seg_y[j],
>>> +							       -8192, 8191);
>>
>> Such change introduces two warnings on smatch:
>>
>> drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c:
>> drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c:177
>> ia_css_eed1_8_vmem_encode() warn: assigning (-8192) to unsigned variable 'to->e_dew_enh_y[0][base +
>> j]'
>> drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c:
>> drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c:182
>> ia_css_eed1_8_vmem_encode() warn: assigning (-8192) to unsigned variable 'to->e_dew_enh_a[0][base +
>> j]'
>>
>> Should dew_enhance_seg_x and dew_enhance_seg_y be converted to signed?
> 
> Someone clearly needs to read the code and work out what it is doing.

Ack, I'm looking into this now.

> First stage is to use clamp() (not clamp_t) to get warnings from the
> compiler for the RHS.

I already changed this to plain clamp() when merging it, that does not
cause any changes since the clamp-s are doing clamp(s32, -8192, 8192)

Regards,

Hans


