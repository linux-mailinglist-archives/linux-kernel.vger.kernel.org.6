Return-Path: <linux-kernel+bounces-315492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6E96C347
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752982841FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393D1DC72A;
	Wed,  4 Sep 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVbz+NEn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95773FC1D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465698; cv=none; b=em1xd6UJT4LinvcMWoe7ERdNJZeBkQVcNEXj8yHxsl+11NKzDN8SN3gAZzRjylRASgvvijhpm5Xxv2UfifXQbLOtLRbrR2eoQAQEQJatw2umspnurIiaNcREr8bhJO9iGq62f4SLVilcMf85RPCtuj4kNSkrCLcf6CeU5h2rOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465698; c=relaxed/simple;
	bh=p4eZFHggB5aNhAZn/MFpGw7ziZIRrPGeWmUFhN+0szg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIlqW4LLxIwbOnHYuNDslF/RU2skm+YeO711xEHW8GGOoyIei++4XIpUzRm1gLQT2lznM+TEM33aq1PgwSfwGxUlOoRXpoGGxcV1d2fJGu5PWgku2UgVIg038WWajifnQWXu0MNJUY2Xvzjpclqu9y1Et93YNmIZGepWJCa+DnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVbz+NEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725465695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OetSPmWJm5A1BGVzI2Vh7JHG4DaICCY18tkvYSPZK9c=;
	b=AVbz+NEnJkS+6hYPezAU/9SjEJWcftD4GDPNbI6AqDIx74PE3OU8BUPpw9iHa5XtS7n/Og
	XU2ok+tCNrgfa2MFYDfqEPMBJ8ysy7SwUewaSxu+oIKOP4WyViDL9a7y2ri470Enb75OOc
	vplzNHtKpMngtFeTGnPSW5DqlAWiotc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-ba1JQPxKNrq1p1qr6bo9xQ-1; Wed, 04 Sep 2024 12:01:34 -0400
X-MC-Unique: ba1JQPxKNrq1p1qr6bo9xQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a86884df270so491479166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465693; x=1726070493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OetSPmWJm5A1BGVzI2Vh7JHG4DaICCY18tkvYSPZK9c=;
        b=EQSdDKLynLq4jys29MfRmuRKfkJsd0i4zxDl4XxO2kYk1cfW9rcOyvBEGFnVB7aO0l
         jbIMdk7QvGpwJhDhOCoaRlUd4fHknGRg3MT1W8mBswsD6NBLylZWgINVAHpJHi5xlDdJ
         Z0frmNSpXMg6rHe8gWRMqAr0BE2rRMiEjXZGrBZnuQtZ9fQT+TvEsNNXG/709Hk8K05d
         t7DmoMTHSj8S8RbrlSgpqRv2LMTGRtelvgAyyxcK39mOTcDi/HnqUtOkN0JyYyQVL4h3
         UuKjkjhT8BikwQNM0Nlx/E3CRlvS9HnJiBsYPqpmGduInGxoIdvzxhw7742oqOCMLsac
         h8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUHGYq7NB24PYav1nYJM3+4msJo0REmNRDkR65OjGtiCMwhYCKkBBafRcVBHg80BOzt6MRiFsoeJCzJ/xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YiaKmcEeSO8SMwrlEI4tZbYSv2qPcEyoluoyzX4+U2+rdbjv
	aLjxb2Zy3FmF+iqElnqs4zQg6/zxslvAa6KG6AA8azDndNTFiZhBSJsZINiyoVK0Kj3SrRV/IE2
	i6JHgChOnjvLNzCaqa4gOtnCjyK3WBFgJQH0IVQgT2E6wQrX5P1QK/NaXObY5pg==
X-Received: by 2002:a17:907:970f:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a89d8ab4ac9mr961474566b.58.1725465692391;
        Wed, 04 Sep 2024 09:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHNpTnFowFyZyjcnUwsK+oDNcuAEQELz84cvCvvgVrDb+AXFs3JWhSwanQmYxEM6yQLIJnlg==
X-Received: by 2002:a17:907:970f:b0:a86:7199:af37 with SMTP id a640c23a62f3a-a89d8ab4ac9mr961470066b.58.1725465691804;
        Wed, 04 Sep 2024 09:01:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e3298sm7903866b.213.2024.09.04.09.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:01:31 -0700 (PDT)
Message-ID: <57bbca66-4d84-46c1-a638-1347ee6a222a@redhat.com>
Date: Wed, 4 Sep 2024 18:01:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
To: Borislav Petkov <bp@alien8.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Gross <mgross@linux.intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-geode@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>
 <20240904132104.GDZthewNjCZ4iLgEoD@fat_crate.local>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904132104.GDZthewNjCZ4iLgEoD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/4/24 3:21 PM, Borislav Petkov wrote:
> On Wed, Sep 04, 2024 at 03:02:17PM +0200, Hans de Goede wrote:
>> Or I can merge it through platform-drivers-x86.git/for-next
>> with an ack from one of the x86 maintainers.
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>


Thank you.

I've applied this patch to my review-hans branch now:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



