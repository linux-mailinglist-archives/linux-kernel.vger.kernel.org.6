Return-Path: <linux-kernel+bounces-426490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1F9DF3D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54715162FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC041AAE2C;
	Sat, 30 Nov 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFizW8xa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5778289
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008906; cv=none; b=Rja5jRUKm/r2BW3r/eZzeq8Ffpkmv4t78BtMSY9lSlX1e7NSz8KsW1/652rhNDVXB7RpA72uhGg0kB/Wm6FCFO8qhphjHENetQtdQPt9DBWEepP84XhRmH4ZEo6NmIal1vvaSPYcXeqdpcIRqWIhWZhAxWZp96wYWuBqFV774b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008906; c=relaxed/simple;
	bh=8qB/gmqVZ04MId/qsFa9qdHqFl//TKB2lKYZlFiCTLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbvJLlE+G7kwsc5sA01QlrKH3Q/WCYqLiIJgm98svuryv4g8UKBVGqp3YJ5n4UzEeeD1+oNwNjbFlmdwePfvyFu+0lVC72CJbDsaqIQ5edGt5yF02zPWKDYnCHFQnByaNQeBr5pg4uX4chFn+0vHThhScFJ5/AaJxu8po4nASP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFizW8xa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733008903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wzVZqTMFhFEzY9bf6AOt8Ea0D/566t7bongwceA62HM=;
	b=OFizW8xafsUjqLmA8JsOH08KBrrej0OzqTJu0IOMXybuqjz29Vf9Pj4UK/CTqMdDmvxvyR
	JR48wrM6tSSGvMYEOX4Tv6ZHw0aQinh0ZoD8hBQS1KsZdJ0kWU81G+sdhcixqrZ3SZZHPD
	zLgFu2TuBvP5EfMeM75rxPnkgZfKxfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-rVRNqHLOPFmaiUvKCjoj5A-1; Sat, 30 Nov 2024 18:21:41 -0500
X-MC-Unique: rVRNqHLOPFmaiUvKCjoj5A-1
X-Mimecast-MFC-AGG-ID: rVRNqHLOPFmaiUvKCjoj5A
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a467e970so21452185e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733008900; x=1733613700;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzVZqTMFhFEzY9bf6AOt8Ea0D/566t7bongwceA62HM=;
        b=EgEjbq+TG/o7k1IuZg4WOGGPdJ7Vf/+rhyh3Uf1Py67pAxF9vnWVPPk9JhGw4MdMKG
         3nYctUIYZpHWOk0rSLnYI53znekBXpny1hs5Q/+KdqKCXY0tE9AvuOt465xZQawOMUei
         SLCSH6Eyxl+BuohbZ7URS73HjXOUhOPRggsORrgFA5ttJTkBR9F36xn4E0kZoowTjU3v
         6wKnqwBb+zWaizZQT0slHeCkrW9aupLdDlTJKNZLx63HiT4RzwMLQ65bQr7zEVCqHT9p
         0mzKikUxEGWwbt75alInKiA1tbUtF3q3gnvfDPF7anVzmVw65dfdPeWooJe0oNpoS8Hq
         WFjA==
X-Gm-Message-State: AOJu0YwoNBJhYSSkzDBCIAsfUud0P3xUgrDjnEsFmPQ4rx4GYHQdaIR6
	CWMCOL35MWhjg+nscSYNWpDSgL8/v7NVlozDUBu9HFZZiiyxbQb8gnolCrbN9Bs7GehHA/3ni9x
	jMU82ntaFTaBBennG196Ratv/hXDoPzFuCgegXmQIH3bCWc++Qa5LYe9xgDDiEw==
X-Gm-Gg: ASbGncs9+TM+1ojLJXrQHrDHVLvoF8wSiPPFTH0VRL9/2vmBBizmDPkjomQyVf5qSQs
	54StB+nZBoMhKFAd8csE5Q41ko68MIBamJsWmEmVAPvE997D+MCi+2+cAo1T/RoPPha8UOp7rq6
	bT9xjJTf7C9a+Zhf4ZZIvvrWaz+ypXarSA7DYAWN2sufKXz+E7kI30TgFQ6KeIKxspqq0+sO/jV
	ST+/VzI/m02DNAeftfwDdA1oBa1/CCFd6O6ZvhmZtCcNMJOVlAkjQ==
X-Received: by 2002:a05:600c:354c:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-434a9dc54d4mr169440675e9.14.1733008900391;
        Sat, 30 Nov 2024 15:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAhtuA1KiUlWyi3nWbJKZ+t4jnSpKRM1YYCqCRZRMs/nGqIyKIjSpzJvlgnqQqmDsDwCPYcQ==
X-Received: by 2002:a05:600c:354c:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-434a9dc54d4mr169440605e9.14.1733008899976;
        Sat, 30 Nov 2024 15:21:39 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa77d01esm132993445e9.22.2024.11.30.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 15:21:39 -0800 (PST)
Message-ID: <c43676a2-8db6-4ff1-b519-3fd3aa290e4b@redhat.com>
Date: Sun, 1 Dec 2024 00:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20241129231841.139239-1-pbonzini@redhat.com>
 <CAHk-=wjP5pBmMLpGtb=G7wUed5+CXSSAa0vfc-ZKgLHPvDpUqg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAHk-=wjP5pBmMLpGtb=G7wUed5+CXSSAa0vfc-ZKgLHPvDpUqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/24 00:11, Linus Torvalds wrote:
> On Fri, 29 Nov 2024 at 15:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> This was acked on the mailing list by the RISC-V maintainer, see
>>    https://patchew.org/linux/20240726084931.28924-1-yongxuan.wang@sifive.com/
> 
> Please don't use random links. Maybe patchew will stay around. Maybe
> it won't. This is the first I ever see of it.

I'm not surprised. :)  I'm going to launch into a full comparison of 
lore/patchwork/patchew---but the reason why I used patchew this time, is 
that I wanted to make sure that the one that was acked and included was 
the most recent submission for this series (see for example the top of 
https://patchew.org/linux/20240712083850.4242-1-yongxuan.wang@sifive.com/, 
which was a previous version and has a link to the newest).

> It seems to be maintained by Red Hat, and yes, at least it contains
> the email message ID as part of the URL.
> 
> But when I tried to go to patchew.org and then click on lkml.org, I
> get " https://patchew.org/lkml.org/" and a big "Not found" page.
> 
> And when I clicked on "Linux", I get a working page, I can't even see
> the raw messages without downloading some "patch mbox".
> 
> So "maintained" is perhaps too strong a word.

Fair enough. :) I can certainly stick to lore links if you prefer that.

Paolo


