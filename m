Return-Path: <linux-kernel+bounces-330387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A543F979DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4D28279E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36EDDA6;
	Mon, 16 Sep 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXw7vNY0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E113C8E8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477263; cv=none; b=t6mQzdQH5BKdqbRlZdByf0GnJtVGQEd5n4mphrXSRgKR86ZlXFGqiAAOM/7d6U4WAXxfoakHqlLKqe9WaaV/r3i9YjEPUeJPB5771Qe5ep0uwOyG4SfDk8khzdJjF3QFXu0PcGo8WteGVXdovjnD6pDXoovTLlmhGPd2te3e2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477263; c=relaxed/simple;
	bh=RlzNN3EME2TPwm/2pHEAPRLP+oXrJgxIfTnPbz/mqIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPeda9wo695xgVsF9dvBes9imcf0eg3CV4ShMJxVUnwh3MHGNHA3g1ZtLZ6O+b8L+fAwTuAk8UuL/eNo1xVRvpXHZFTqfizH9lzAFuwvCou8OjbriUB86UbTio8lWtb4UFQLswX5POaOndk+XcZLHr886eMHwtTC5p0wqp6ZhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXw7vNY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726477260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLNH/X0H0xMIBSoqA2tqYNdEPPa781MoYQSido4al4A=;
	b=CXw7vNY0tQdDqMiarLuCcYNTJor7o9JRb70d4BJcKxp88Es9z7uUXOuRU132ytahCyoU0D
	G2gxd6mGW21BAZCrG/0KKiymPiggnZksxHS9FJYLZTzFC/ZM7jwOYV+2ywlK81ZgXzxIJW
	WSByw2UDxQVJBtOe3mghBM8fbYJu/xQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-1Exh8Wh1PpqvmikcbBlc7w-1; Mon, 16 Sep 2024 05:00:59 -0400
X-MC-Unique: 1Exh8Wh1PpqvmikcbBlc7w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5356d0f6cdcso1997219e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726477257; x=1727082057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLNH/X0H0xMIBSoqA2tqYNdEPPa781MoYQSido4al4A=;
        b=MZjIsRkf/EtfpTRtkJ6CwPERqZas+fxFSDo+5S9h3LjRtfTff2rg1N3TbQZ8jXhmzT
         gGEXlQz3ndD98CoSg6VUIEkmM1MRWVDE/OrhJmpNpL1FZp7gGrvpa9MZeUbIfO9jo1kZ
         C5u11iz15mtoYPEhaMQlYDILy4uiiU0aPomeGA3NuB9gy8Wuu5KBVq2/wZjAu0ZGwEYt
         YAs1IMIyF1ohvhCDZT0i0jkbnbSlHPOgpF/75355BnBEwdKxpZkxnN35xooTI/t51W+I
         2oXilGTni+hmZo1qOHjMryouW15NoDuZKBaDtA3fXCuX2zCldIweWnCnLyiQRBR49e8d
         OdCA==
X-Forwarded-Encrypted: i=1; AJvYcCU95E6wwzPu1QMb5z/+nWSVl76qvjd3bEgypdCExCplgrqo1luIdpXxEpKPqTc5E/DbywJRWOQgWASqCsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWWT9AjlsxLxOHbbhrnlFQc3j9v3rhQdkboacpxmymHnhY8c3
	BkorWdRJmpEd9WLh/b9HxDpvfeD7ttuOdVR9uMUtjwIlbRMQoRFhJ9uTVwrAp1ttV+oNkRcHp2d
	A9skt0lbsIKkK+26ymentyfiohz9g1m4P7PXaAZkUGcK7cH6czUUl8j3xfi4rQ0qSNJ6UhA==
X-Received: by 2002:a05:6512:3e29:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-5367fec8cb1mr7025181e87.16.1726477256468;
        Mon, 16 Sep 2024 02:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYxVPYV4JqtcRfYK3Rnb6iTuT4+622b/En3plfCa6pqPPnb6cP0SiE961lUDyLwqBuQOpvCA==
X-Received: by 2002:a05:6512:3e29:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-5367fec8cb1mr7025137e87.16.1726477255786;
        Mon, 16 Sep 2024 02:00:55 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966ccsm284209966b.45.2024.09.16.02.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 02:00:55 -0700 (PDT)
Message-ID: <ea2522e2-0f64-4caa-aae2-3057f4d1cd95@redhat.com>
Date: Mon, 16 Sep 2024 11:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: atomisp-libmsrlisthelper.c
To: "Dr. David Alan Gilbert" <linux@treblig.org>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZuXOWjvVYa64c1-5@gallifrey>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZuXOWjvVYa64c1-5@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/14/24 7:56 PM, Dr. David Alan Gilbert wrote:
> Hi,
>   As far as I can tell none of the functions in atomisp-libmsrlisthelper.c
> are called in the tree any more; I think:
> 
> commit 3a81c7660f8021967dccd52624fa1a6fcf117000
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Wed Sep 27 14:24:56 2017 -0400
> 
>     media: staging: atomisp: Remove IMX sensor support
> 
> removed the last users of it.
> 
> Would it make sense just to remove that?

Ah I was under the mistaken impression that the MT9M114 was using
this, but you are right. I'll submit a patch upstream dropping this,
thank you.

Regards,

Hans


