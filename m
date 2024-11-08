Return-Path: <linux-kernel+bounces-401293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F19C1859
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0417285BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07451E0DD6;
	Fri,  8 Nov 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAzQa9g7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E71DED5A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055718; cv=none; b=nwlJYCecl08qydDtvXAod9EAPc8NIgH+SGYUJOx7wbimpXpO3oP7I7cBq7A8jvi06IiuRS4+NaHfRzdWdJyhqWfZFbwY3Et423Hvhak9OGyi56sMCQRgkjPWWwWqldYCEQvDgNaMNKYapogYurlzhj7J2QFP5IhJsjxlx6Rw5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055718; c=relaxed/simple;
	bh=QUMslSd5+7vmPhBvFqJFbLH0QvtylNmBG3Rd0BiAc18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC+0W2gpnCJgmy0p2/YZ8xHZ9PONOhdwZ/u4svQ5I0LnXEWw3lI4L9kZRC+K50xD/FFMjZEQxzbMd+LgRYwvflzz1ARi2LlVIj01lA8xO7FupdIGxso/jklRUrcuGRc4TAqKHFRG73gCIKjhBqcKMF01FQLjEDQ4wo2qEeLm1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAzQa9g7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731055715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYHTkptT6ou5l6p02xIsQwxrcvbgxf99D1myY1C6iho=;
	b=hAzQa9g7wc3zuW+73/GqvjLVL4JG1D84K7gQlIKWa4KVeN6zEmbd6ucJBDnqT/WrtKvkIU
	TvLhAdk73r2KC1UHTIXDP2NTxizbuBCQT65GmcZyqjmG6w2/Qi07zYxu8nM5DwevTzDZYQ
	FD6z3S0wrpuUTldfUFZB/Mb6OtTV5Mk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-rJkRRUvWNwytAkI0F3kZFg-1; Fri, 08 Nov 2024 03:48:31 -0500
X-MC-Unique: rJkRRUvWNwytAkI0F3kZFg-1
X-Mimecast-MFC-AGG-ID: rJkRRUvWNwytAkI0F3kZFg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4317391101aso13577245e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055711; x=1731660511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYHTkptT6ou5l6p02xIsQwxrcvbgxf99D1myY1C6iho=;
        b=Tus1W8dxGHGpxEjVXVdKbYpcoX5cCK/94pVED6Sa9o08g+XYkrV16zOBAVt6QQ0pGk
         fE0L6P43j4fq2Xm+QM1QNU0O6r1g0Sj9+GnoRckQH/4lcTy4uQ5xVQlF+G+Cgd4FQsGW
         9NSMXo21uUZzUCpPYb+59QXc60PKdOQlxOmo9TNWe2mIrmjCexp57xNTk5EDAlui66M0
         MYGCLTJBT0wG+xVoHqx+I2E9FecTNU+OwT28p1yOzXJiVzAy6HX3wSxTSSZ6JDaAgD0n
         FNTbA1FH6KJ+u+08R/IUVQ3klfU56kL+VJCtgwoYcVJwMkWdluB9jm0Jf4az/V28gjHk
         KHbA==
X-Forwarded-Encrypted: i=1; AJvYcCXvWts6g/MRi4tMBnY2HiP2M5pMGsgpMQXZ2DRlFCrsZJAYW/bhrcxEI7hdC+c8D98mXvgfXtjzLYbmfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCh1cem23dhvLvC7rlW18szJYLTshk0pnvGJL9L1qInH11MMi
	s6DIApeh5NRyPOcy3HxnhoacKx0/zduG75S3OAIRjPBSx62Bmy9d3kwlBIkDJRgVbC2MSV8BBCA
	xgtAUpRejnXlLZ4AfvAWdUk22iW0jkui7RZy3vATL0lQvDVTxX+I4UJ3uiKyyyg==
X-Received: by 2002:a05:6000:1548:b0:381:eb8a:7ddd with SMTP id ffacd0b85a97d-381f1866989mr1759288f8f.15.1731055710710;
        Fri, 08 Nov 2024 00:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIaAbzDhaCkwg/UVIfjicTfoiBdfShUzYxSOC6+qJlzAeZo1U91jzrukrCO0X0SBMgRzrjVg==
X-Received: by 2002:a05:6000:1548:b0:381:eb8a:7ddd with SMTP id ffacd0b85a97d-381f1866989mr1759271f8f.15.1731055710387;
        Fri, 08 Nov 2024 00:48:30 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8f0asm4046400f8f.79.2024.11.08.00.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 00:48:29 -0800 (PST)
Message-ID: <54bbccb2-6633-4638-9dce-14683b4e320b@redhat.com>
Date: Fri, 8 Nov 2024 09:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ppp: remove ppp->closing check
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104092434.2677-1-dqfext@gmail.com>
 <7e0df321-e297-4d32-aac5-a885de906ad5@redhat.com>
 <CALW65jaKn7HQth6oYYHWYvg7CTZJj2QH66nHyo41BNjAA15Y7g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALW65jaKn7HQth6oYYHWYvg7CTZJj2QH66nHyo41BNjAA15Y7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/8/24 07:09, Qingfang Deng wrote:
> On Thu, Nov 7, 2024 at 8:08 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/4/24 10:24, Qingfang Deng wrote:
>>> ppp->closing was used to test if an interface is closing down. But upon
>>> .ndo_uninit() where ppp->closing is set to 1, dev_close() is already
>>> called to bring down an interface and a synchronize_net() guarantees
>>> that no pending TX/RX can take place, so the check is unnecessary.
>>> Remove the check.
>>
>> I'm unsure we can remote such check. The TX callback can be triggered
>> even from a write on the controlling file, and it looks like such file
>> will be untouched by uninit.
> 
> ppp_release (when the file is closed) calls unregister_netdevice, and
> no more writes can happen after that.

AFAICS the device can be deleted even without closing the file, via
netlink or deleting the namespace. In such cases, AFAICS, the file is
still alive.

In any case we need a more solid explanation describing why the change
is safe (and possibly a test-case deleting the device in different ways).

/P


