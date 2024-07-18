Return-Path: <linux-kernel+bounces-256140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E685F9349A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55231C22C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222587B3E1;
	Thu, 18 Jul 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg2PNIcp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF17711F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290335; cv=none; b=N6PHrtfPNJpaKAGQCgjoMpNUDrnE1eDmuDlImD7P/UQ+06auOm9/e4A4pavn6gGXBjkIovFKNfgo4N3uota7S8nn/XTLe3dosqUwOPSMxE9cYoX2UijcG3g6d/70hF9It07YnJK+0Y7LWdsMEdh/CKzYN9wM8IV0ESjkggSok7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290335; c=relaxed/simple;
	bh=NRTQo8ILUpl8MmArK13XX07qcKlygom/cOhL5iHDl/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnPZ2XC6GE3QV2Anwqszy7ZBc+bndGJ2aPPWpTjoGD6oLRWJ8W/2o/XFybvd+mjUlsevFOCh+dDTWhyu+Uh1dEajM0qIkkJalWfwp3KYRccDVRB6Z31ZlTHxzz+EOvBtZ3dyczcMqpMVk02ctrT4dYdPfFAlhZ1SRTTzd21p204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg2PNIcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721290332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHwHwCnpQ+alZdnTfgigFFSHVcRZeANUFwuVGxc+7PU=;
	b=Wg2PNIcpZtfteQWbG0ObRJCOqeRM5F+KXFpT9g3YgwaS+fTEHn+W8vY8OVedjW7dv0Xvjs
	ALGy8CCj7SxCYguWexZM6yHibZQTEgpBY2GrP5D49v4q5cIZ5Qc5Yas9+1VmGdiE0zv0SE
	BF4aPbi5mzktQbVTqfrMm+fPoas5NIM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-C43z4PuUOYS4OVXmHtZ-0w-1; Thu, 18 Jul 2024 04:12:10 -0400
X-MC-Unique: C43z4PuUOYS4OVXmHtZ-0w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36865706f5eso77299f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290329; x=1721895129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHwHwCnpQ+alZdnTfgigFFSHVcRZeANUFwuVGxc+7PU=;
        b=CpkOVlYAInSKzidDmCUfGuWfyKzCVJai4y4MjdYa3kDPKkWC5PY81PRC1GlRqB10PE
         pzBcYKKF8N8t+Jz+jo3q4qgclbWXCKZF3FnbehUFG6H1jLG9RZVWBn0AioIUVnbaBZlc
         SjtkrZjAGJm84M3x/IxyPYm5IcKzXmt4CLlF8zQiwO4pTeY8atlI0RZFxcNW/+3NWKpc
         7eNj6ZDjdtR2zQcg0FYQJQ4oH4Nrbgke0xkRIgmuxFwrZyioe1GWywGbWEZqkAznKyD0
         46AeBpIKoQhJRNNJwFDDP+gDv0BrLvLlNTT3SBruzNThkjK/4cw3k/djNfJbLWSF6PSp
         U/iw==
X-Forwarded-Encrypted: i=1; AJvYcCVCxXUr667OEwNOVtQCZiKnwKSkLsP4GGCRn8KoxG/cWn5/w5vb+sbGoRL7cLeM4iOPGU8R78AqfgFG2m57FuATcr8ebrsv39fqeBi0
X-Gm-Message-State: AOJu0YySLjW4MyotvWRR9kJ54MV0VZ7wUzZ3B3sBkcM4mQwS66AZL/K/
	i1BjPYhNqUVBAEjEnA0+47RoA0lD6uESiX8w7ZVe2/Qtf38BV5jg7jGg+50YSFGUwAp8+qT50/Y
	ZZV7Uq9tl3DJv3trZB0y1QgkmjVKHpW3ZN0v85TAht79V73uT4YLL5p39bq/8bw==
X-Received: by 2002:a5d:64e6:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-36831738d5emr3110623f8f.46.1721290329340;
        Thu, 18 Jul 2024 01:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSuJdIL5ugjM/EkJXXLU6+RCg00EXSasDKJSd6pH58ocj7HqEoXGV16ErsC+vYYWRzVdwOIA==
X-Received: by 2002:a5d:64e6:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-36831738d5emr3110606f8f.46.1721290329004;
        Thu, 18 Jul 2024 01:12:09 -0700 (PDT)
Received: from [172.18.228.53] (ip-185-104-138-47.ptr.icomera.net. [185.104.138.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3cd1sm13574006f8f.22.2024.07.18.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:12:08 -0700 (PDT)
Message-ID: <53b247e1-62cf-4289-8ad6-2138a1757e06@redhat.com>
Date: Thu, 18 Jul 2024 10:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Gergo Koteles <soyer@irl.hu>
Cc: Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <cover.1721258854.git.soyer@irl.hu>
 <70d3957b315815085cdd8cb04b002cdb4a372ddc.1721258854.git.soyer@irl.hu>
 <06e44cdc-b984-23ea-2d89-b4489bce2c27@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <06e44cdc-b984-23ea-2d89-b4489bce2c27@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/18/24 10:06 AM, Ilpo Järvinen wrote:
> On Thu, 18 Jul 2024, Gergo Koteles wrote:
> 
>> Calling VPC commands consists of several VPCW and VPCR ACPI calls.
>> These calls and their results can get mixed up if they are called
>> simultaneously from different threads, like acpi notify handler,
>> sysfs, debugfs, notification chain.
>>
>> Add a mutex to synchronize VPC commands.
>>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
> 
>> @@ -2027,6 +2053,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>>  	priv->adev = adev;
>>  	priv->platform_device = pdev;
>>  
>> +	mutex_init(&priv->vpc_mutex);
>> +
>>  	ideapad_check_features(priv);
>>  
>>  	err = ideapad_sysfs_init(priv);
> 
> mutex_destroy() missing from rollback and ideapad_acpi_remove().

Right, note the easiest way to fix this is to use the new devm_mutex_init()
instead of plain mutex_init() that will also take care of destroying the mutex
on any exit-on-error cases from probe().

Regards,

Hans


