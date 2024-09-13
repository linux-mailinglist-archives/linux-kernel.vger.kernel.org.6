Return-Path: <linux-kernel+bounces-327500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28F9776CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7394285462
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88503130A7D;
	Fri, 13 Sep 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th+EwgMl"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF2F4EE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193927; cv=none; b=UPvIVzeN26/nQTYUtjqjt/jv7JDVJ1eZY9/aKl1PIC6MjKwGu3R3Ace+gbm4kavmrhY2GGtUePthU2trbYe0h83y17sRJ7zAkUiuAX+ptVAqXOqUMLcuhVBQR4TFrB1e8acorJcZIN+YglCKWE37f/6FvGZDx6VzNMpX+r6GREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193927; c=relaxed/simple;
	bh=Gaqva7sbLtAJAwesf1cytcOZ/V+sdx8hrnWg+Lxz4l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoNt3Xaek7/2366xQLSn3b/ugEN4SGJa6u+DaGnkNVk/kUe7+si0gZeROtR2Ata+LK/zARMqFrBNv93C4Z6lq7lQEKZSjfm9GHQMVrgpruRLevM3uHlO6F4jOJv7arcNU+sB+Z9Klxg1HBpsjnoKGToWieHDt2oRj+s5tIvlp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th+EwgMl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d871bd95ffso257676a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726193925; x=1726798725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WiAUOJol0H/8Zg9tIhphVBTbRJpyNgrQTkY0dFH5yY=;
        b=Th+EwgMlnaapYBeBW4fgJAJNH4emR0EHO09y0PSRym7ZtDrYu7uqC1cXkCHIdwg014
         8LWw7+O+p8cEWhlEqsqJPZ8Or5VbiTTCCJBgLwfR97TvVYxJSbsN+HPM4/3vySmtZkQL
         Dt6zyS8/k/uM/zQauy0/fKf7pjSRMyuaL7FnGvTH3Xv0HabGPAPJarJPwwbPcd/qmOm0
         drU4tN2h+3rFsnn7Nqp4pNOi/r1m1ognwpoMGR5umBpMWftSXmMH9ilQC8OAIMyxKzvp
         e492BmoOdtielq7co1Xz9uKUIl49sBXImONoEEvFK5bMNVhX6Y8kiteiqmHYJmuuoo63
         +afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726193925; x=1726798725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WiAUOJol0H/8Zg9tIhphVBTbRJpyNgrQTkY0dFH5yY=;
        b=nOdcymM8Day9gnW1bDBQ6qzLiq5pHIrwIFarKIzxno5Lvj7+ox2AnsKJkHpWvK6YJb
         XIHbsIiOVqEeXMyXdoks4J/tLUMJIkfk2m4d2L1o8KWV2RU7a2VFhT/4veDzWJP1x9Xc
         /8zhujLKwuR990cPFcf60p06+3h+MYM4uKumGGi0LI76Fl6De2PQMxfiv8CXBUvbjsEQ
         QzR1VCmapVy0x9lAgRrvNRN8XHCUhKG+zSTB9vxt4lJG9pz2ykGJQA6GH+PBJZSKPIKW
         y5S35jvHNLUrdU1prNVaY0U6Tq5spdyxtOqKEUDeDqjn87xQhQFJZUtmqP3cm7h0hV+v
         SH0w==
X-Forwarded-Encrypted: i=1; AJvYcCWYPiv6d+y4ryl8Y24zAUEIcd+Nq3FJ4gG8zz1Xwm3ogcZ/eShEn5e/Ldzn92jnLuUfh/Q7t2hWxHs6wQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFdvJbjMFc1NAhKCW7vtXmGAuwlZV2Fh6mGMiJx5Lp5QSb8fg
	B770VrkBUtSQjsXU7IcSCo4flvpYswEHOMrQ9zvMZBnw1Ak9AHD1
X-Google-Smtp-Source: AGHT+IHdtO8+cxbhbeqI3tP7JHLgV5iEvjTj4rxH+AkHVwfb6JRLwpN4Fv3w0alSftU+SsX6SGovWg==
X-Received: by 2002:a17:90b:1043:b0:2da:a6d4:fd5d with SMTP id 98e67ed59e1d1-2db9ffa200bmr2311583a91.1.1726193924807;
        Thu, 12 Sep 2024 19:18:44 -0700 (PDT)
Received: from [10.89.64.12] (mail.misaka4e21.science. [198.181.38.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ad527asm455230a91.0.2024.09.12.19.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 19:18:44 -0700 (PDT)
Message-ID: <57fa3e1e-0b15-4dc9-a4ab-f7c4a1af57cb@gmail.com>
Date: Fri, 13 Sep 2024 10:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Force ns info updates on validation if NID is bogus
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20240910095006.41027-1-xyh1996@gmail.com>
 <20240912094020.GB13465@lst.de>
Content-Language: en-US
From: Yihan Xin <xyh1996@gmail.com>
In-Reply-To: <20240912094020.GB13465@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Christoph and others,

I mean that, for example, there is nsid 1 on the device,
the kernel discovers it as nvme0n1. When the device
had been reconnected (in my scenario, after resuming
from an s2idle), the kernel would recognize the namespace
as nsid 2, although it is still nsid 1 on the device,
which makes the block device not found.

As Hannes said, it shall be myself misunderstood the
reason that leads to this situation.
I will try looking into the real reason. Maybe there is
something wrong in the controller?

I am sorry for the inconvenience causing to you all.
(Please forgive my poor misunderstanding, I'm very new
to kernel development.)

Best regards,
Yihan Xin

Christoph Hellwig 於 2024/9/12 17:40 寫道:
> On Tue, Sep 10, 2024 at 05:50:06PM +0800, Yihan Xin wrote:
>> When validating a namespace, nvme_update_ns_info()
>> would be skipped if nsid changed. However, this
>> happens everytime the in-use controller is
>> reattached if NID is bogus, causing nsid not being
>> restored to the previous one, eg /dev/nvme0n2 ->
>> /dev/nvme0n1.
> 
> What do you mean with restoring the nsid?
> 

