Return-Path: <linux-kernel+bounces-248680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03C92E089
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F05281C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E012FF71;
	Thu, 11 Jul 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBti8U23"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30A12EBC2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681635; cv=none; b=jJ7k1xz0VDGPd3RgWlcrzmaz9SxjOF3umzRJzS2SG15HX9C9QJVA37BsQQOhGdZvtYfw/JV0mHGxEvbneGc1fuI/j35Ci3BDSwBNNCei9xLJk+Yi/98XUkT6spHpaMNlI7CYKnvh8ki5xxJtVAY77W/4phyycKgZuCOI8XGsVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681635; c=relaxed/simple;
	bh=M6Q4Y54tcX2mSlvfFlPj/ernw6oyX4Le4JdM01IEiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2SRpK5G5N66Ux9kH5AzpSauURV75ja2BxCrF7tL2eVsJImQSyd8YEu1Aj7ikiFnMSjbNwdAduOU4iCcQS6sc8vgx7da7yxIbGeCp/2UJQ3zV7nxBzYmBKG8W7IpRtZMJXWkJ9GfArmRI6pNwAo331m/Bc1ohdGupHm+8WY7T4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBti8U23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720681632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
	b=GBti8U23ek7MzY9bvNQfPUrqYsEvk9zTvD8B0NMm/vam8YG8G067G9IqjjP5nhur7OZZEt
	8MqwtDpXpsF19l30rqER5NH1bln41sNM57Dpxhw/wW4Z6OPELFfiJx+VzHs9Ce1sXBFGHs
	S0Kx95y/6mYPsOcDrEm5sK+0iKN5ct4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-1L8Hvf5DNCmiKI8FiwzbGg-1; Thu, 11 Jul 2024 03:07:11 -0400
X-MC-Unique: 1L8Hvf5DNCmiKI8FiwzbGg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77f5dd71a4so64435566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681630; x=1721286430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
        b=jXjS7IHrpUmi7LBrKbKoBIt+XjctcU7aAeeu+KHe8UC0v/VmWW8oVnmo64g2ClKv1r
         mvz27v4RqLt9UYdJ6DPc7u9nxHSQWPjxPVo+gRsmnQeVGAjr4OywfJM2BWkHKdxiW9l0
         28QKK5bwN65QLmDk7pyto8RQU9mIo/lTzA8Xw28JlfzXAlg7sxWn7gSxQ2y8xgRcnbXt
         0dflotdv98LQjCawAks6Vxm1gzIZXYkrjNQp3imdppjuHmMFQMELAYa1i0AxzV/cEkdh
         kG5z7tnPoEqJdf4kz5Mesehs7hjYZRvSW021GdbeHfjbU7JxVVm9wAOJEEeODjJRgiJy
         R6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV10GxfL6yHxpn1oyQRo9q/S4YaZkQL0pcsK6IsZtq0Q9zYvkQTuN+OuH1LmkWgEYtiGoXqU9BerKT9aXGvqpe8UODDtkOp1qJyHG+o
X-Gm-Message-State: AOJu0YzYGM1SLaA8T3hETW8Iu6Ed2w6Wlxg6tj66tzONJvLSIDFRB9eK
	h0K+1tIp0wFJAXLCDXdCqXrjlujiSwOllcM5v4L3q/+NV8ek7Te+ikC+MOsaQMW9ESHu87YH8Q3
	ADLyMFZ/R2fe25StB/ETUvxgRaNWmzMb+WomXVkvJXIpIuZIAQehWXM29WNLgHw==
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673479766b.2.1720681629838;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6fcNSUdwOXzcVw0nvIFIjlIr5dl9NwMN5RYz968tXKLEx4Zbt1Hmp7deL2qMOfvVI3bkxJg==
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673476166b.2.1720681629127;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fef92sm230972466b.125.2024.07.11.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:07:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:07:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, stefanha@redhat.com
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710190059.06f01a4c@kernel.org>

CCing Stefan.

On Wed, Jul 10, 2024 at 07:00:59PM GMT, Jakub Kicinski wrote:
>On Wed, 10 Jul 2024 13:58:39 +0200 Stefano Garzarella wrote:
>> There is a comment there:
>>
>>      # Avoid changing the rest of the logic here and lib.mk.
>>
>> Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.
>>
>> IIUC they re-used INSTALL_PATH, just to avoid too many changes in that
>> file and in tools/testing/selftests/lib.mk
>>
>> So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH if
>> you don't want to conflict with INSTALL_PATH.
>
>Any reason why vsock isn't part of selftests in the first place?
>

Usually vsock tests test both the driver (virtio-vsock) in the guest and 
the device in the host kernel (vhost-vsock). So I usually run the tests 
in 2 nested VMs to test the latest changes for both the guest and the 
host.

I don't know enough selftests, but do you think it is possible to 
integrate them?

CCing Stefan who is the original author and may remember more reasons 
about this choice.

Thanks,
Stefano


