Return-Path: <linux-kernel+bounces-448035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8389F3A23
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAAD16C733
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4820C471;
	Mon, 16 Dec 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWBNz/i/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6920C486
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378427; cv=none; b=lBu4qtLWgYWAuTkn8sN7jFjekOoXmG68lLvLTU5nvD85OBDQYvvs9IDM/HGIx0k7CTA/gCvjXIK4T3pk8zoh0F7XwsqFjfzTHwgZsKci5Ud+IH7HDXYobPRXxMrmnW+VddiHZNcWyiI7lsOK9mxSEzOo6PZ3E3/RZx0CiSXcFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378427; c=relaxed/simple;
	bh=raCkinJQGxA0uA4MCVcfsShss+K8IRx4YhrVbMYa8Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Owd50pxS10BeqSIkKxTor/0fJ9n02+FwQIotCB3dFUkNYVZO2XibEw3S2gdbDkvABh+FHhLUkms71e5bCVxGozTIXaoW9hQNBUKGvYff1O5mR/3fDPiePLEKyQV+bfYbgMhlFp2vdo/NbWbVT14Yxk1C6JV/TXMjsbZGWK9f58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWBNz/i/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734378424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWtbYIolgfrDHNCI0pGmWklAYAhRyKp9JwnJD3qNZJo=;
	b=hWBNz/i/+1JmJTdJC+niUu34xtbXvCsTvt6AwgtyXvBjFCJ+wNDH+4gxYHKQUSYOLdEyay
	xTaJggV1+4Q3vhWLQ6260PVij1NZE5OeQpqILByjUqOVnveon6MQugv2GW/NlA87+0/c5V
	2MInONQ3bt6LJsG/ItPeqCA6KH0DtTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-oYX5wj4zOM2Xp4bwUkKRNg-1; Mon, 16 Dec 2024 14:47:01 -0500
X-MC-Unique: oYX5wj4zOM2Xp4bwUkKRNg-1
X-Mimecast-MFC-AGG-ID: oYX5wj4zOM2Xp4bwUkKRNg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so18798105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378420; x=1734983220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWtbYIolgfrDHNCI0pGmWklAYAhRyKp9JwnJD3qNZJo=;
        b=wOi4EPzplgLOaznMk7jOaW+d5CmhuoUS1Gef+GH8SEYn27p9jMLxgB3Ajpm5htf9Si
         OU6IUpp0A8nufitJZ4ys3umBMY3L3k8n1c6AU5KtPcSeybFhDSYI1iGDsl0jg1Ak0FD6
         CV2iBualfknVdS5UXXPVY37k1hMUKEmV87+z5vzkuv+4uPaKNqkL6nGUYmQd922n0gnv
         ZaRCguehyiI1UQdxFppj1JNXGgIcv3IqWpKpjkcC9D1VZL7Bh56kEYlb+UaAo55CtV+U
         LTN/e97c8Y8e2/9DvcDXUmGFC9hFO8uUNiM52hfZnoQ/Vrhh6Bgnk52kOUfxYZp+GX7w
         B7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgodRO4iTprX84ySCLfEY0wHYZfNhpvc4AvPKAeYZw/xHUdY/HURMW8x6HUVv36jMrOyBaTYZiLPR+U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrx6SsF10ZFVSnLt7VPsgVoTfuGG3eMLPrHPZPjqrnmenNTH0M
	OpW6ZT7WrYUUzRjk8PCCHhqmB37tZVAkJM6qDEaCTV03tgfOel5W5sEDaDQGTtEn0QZoVwHoSN4
	23JpWrLDAuRaWCBVyalQWNInDCZE33V+VeykR4yVhXrNCoRovIHT6y536a1Mdeg==
X-Gm-Gg: ASbGncv6xeY9c44DDc2nEV2JrKakgkGCZWUSZsoBhXpixD2Ros7nY7MZXWrPP2jlSzz
	HsRx/cDq0ngnwtzwnaCu7reiwQ07Y4fcnDE/nDn3G6fR7DBvAP8dEzo/jQ5uuNw+4IjPTMs4qnU
	oVHU5kGFw1WOA+u0L3zfK6mELFvZtmXC7vItB8NR3MoIx1PR86+XFSE+ZwghEEx1GOgN/MobcQG
	qId335smWMtJWPRB2RSuNYhQRIVyrRdWqAbYILB04hI0v354l6r0voXjAT/6zahs6hbh5FF28Mz
	XiJWVj5kY8p+gY6c1kgB
X-Received: by 2002:a05:600c:4e51:b0:434:ff9d:a3a1 with SMTP id 5b1f17b1804b1-4362aa2e2c5mr137548195e9.2.1734378420165;
        Mon, 16 Dec 2024 11:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqjR3H3gwgGPNEFWph3WLlX/KvsKACkTobIpdFheAU0MtIGufaN8S69UyWpw4i5vWzSPk7Xw==
X-Received: by 2002:a05:600c:4e51:b0:434:ff9d:a3a1 with SMTP id 5b1f17b1804b1-4362aa2e2c5mr137548005e9.2.1734378419768;
        Mon, 16 Dec 2024 11:46:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550518sm149270845e9.5.2024.12.16.11.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 11:46:58 -0800 (PST)
Message-ID: <cc9253fa-9d5f-460b-9841-94948fb6580c@redhat.com>
Date: Mon, 16 Dec 2024 20:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the rust tree
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241216162512.064724b9@canb.auug.org.au>
 <CANiq72kv-bjeHtnom2xLqMD92xfogd1hm6yFGg16wpqjhJWMGw@mail.gmail.com>
 <06f34e34-116d-48de-88f2-c029877f41e8@redhat.com>
 <CANiq72nqM6Ncz7pP4jfyBENK936QXqd0KP-9BQdbHwVU8zX=Xg@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72nqM6Ncz7pP4jfyBENK936QXqd0KP-9BQdbHwVU8zX=Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/12/2024 17:24, Miguel Ojeda wrote:
> On Mon, Dec 16, 2024 at 11:59 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> Yes, I'm fine with that change, thanks for the fix!
> 
> Thanks for the quick reply!
> 
> May I transform your reply into an Acked-by?

Sure, please do.
> 
> By the way, if you want it as an independent fix that can go to stable
> too, I am happy to split it into its own (previous) commit and tag it
> as such. I am not sure if it should be considered a fix, though, since
> one could argue nothing is "broken" (apart from the type not being the
> optimal choice).

Don't spend more time on this trivial fix, it probably won't need to be 
backported.
> 
> I am also happy to split it without marking it as a fix, in case you
> may want to backport it independently as a prerequisite at some point
> or similar.
> 
> Cheers,
> Miguel
> 

Thanks,

--

Jocelyn


