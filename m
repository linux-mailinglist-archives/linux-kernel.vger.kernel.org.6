Return-Path: <linux-kernel+bounces-342913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45499894BC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C541F219B3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7AE14F136;
	Sun, 29 Sep 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCsPtIFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1B14BF86
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727604729; cv=none; b=S4IiIhtX9DqXfmkaBumrcJ7BgH/FD1hDHtW7mV4ahU7l+HUBqbYuCyhiDaTzofZ6rZawTSjBnHD9DPAbpinXjP90FM/IVVZSY4ldREBmxJVWbRQ3iY+vT2iUoWiePKBmCaMcVRtGR8zIOkxv29cox89ZAFa4TxwTXR3Kno82s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727604729; c=relaxed/simple;
	bh=PD/wUvhd5RtqXGebqHIFkTMlN+ZQxuSc5lwqKI4WJx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSAT1GzSXdoIT8e47AKuf5D7OWYyc65XkaCeERqv932FJj3Br6U33u0SCF3aO70bh2eWNrZNpIXBwTkMGxmEEctNyQprtYvbUL3eLQ4X4hWy8fyyLyB5Hg1Ih3NCePwjjIBS/PjCVk3Q5O1PQ/YQ6wgwE5jObZ3mbUGu2OvkKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCsPtIFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727604726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hbn6R/wffDTxkOWzespuChECA71mJuqPKKL3RbCfxc=;
	b=HCsPtIFea8x/hXfjClxfepu5nyn4GORFz3qCCmygCdO+Qee1XEchZIwYdriQTgNBaz2skT
	KN6+VQAkYwQMEJBcD+yiwt2PoBvi4isBzOHfj8a9T7SZEft6ZKzVZD6v8OqBRsQU2j+zqL
	rBwHGbcDTADIxoesIQTelKA6+zq6UZM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-5RtshlRgPNuXRw8oEjufNQ-1; Sun, 29 Sep 2024 06:12:05 -0400
X-MC-Unique: 5RtshlRgPNuXRw8oEjufNQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a6fee3ab1so319889666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727604724; x=1728209524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hbn6R/wffDTxkOWzespuChECA71mJuqPKKL3RbCfxc=;
        b=XwMG/6hCS+Wxu5EjeQo3IxUFx/NTqmapD4d6Ff4K5e4gPhUg5LiqDSeENBc9UoUGYa
         HKME0XtdxglYcCjTbLHV2HvId2sA70i1GvSlrMVmAehorHcBY1x3Omd4x3pxrc8RAzgK
         SUlakXroFyvNDbPJRCGxwZHlLP+WyWcEFDnkWgkVMEmGFlRRQO7AUS7uzUJCFcM4W4gd
         i/5RIS6rDL2HBxulx2sV03ZScmm0QkMX+yZwdrbxw4vrLL+YrzNPJBXeY/YL8duhbM0c
         bOjPmX+c6WWs0v1A/hjZO6JCHCgK2j+jUE9MNDnC3c7cwUy8Nh4CJOKvQwupe9xNw/iB
         yQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7u6GzmfCNyQmNZEYuyhVPe+8gqdhjTmK+9CMF4oqyM8XfIxWjZagd7zG0elJQREdUr61SQ7m70wjIN78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyevy6pmJIX9jakG/cwaGac+l6d/M/v57wjXreAtPidgwOSlxsE
	K/N1SMvCHGs9dNDpTdi3FsOijib7ibKU+uXM7X8eZ/rivnEpOuWykPI3X9iXB3CpdvlsSTsScXu
	4xrJPjWMqQAWvdM0r14dnMeqp+0ejp00DeDGuRtfBksuz/HNvopqACbmGDGuqzw==
X-Received: by 2002:a17:907:74d:b0:a90:1904:9a87 with SMTP id a640c23a62f3a-a93c4ac93b6mr870278466b.60.1727604723936;
        Sun, 29 Sep 2024 03:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIVe1CoS+Np/bi1eBSQa9JiEn2gOIbEIp3CNeaqFELO6zcmPAIfDfETMnh+zjLSJSkW5mVpA==
X-Received: by 2002:a17:907:74d:b0:a90:1904:9a87 with SMTP id a640c23a62f3a-a93c4ac93b6mr870276466b.60.1727604723541;
        Sun, 29 Sep 2024 03:12:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cb2sm354410966b.197.2024.09.29.03.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 03:12:02 -0700 (PDT)
Message-ID: <59a4f18b-0d8d-4429-a353-0f0a8a38fc68@redhat.com>
Date: Sun, 29 Sep 2024 12:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH v3] platform/x86/intel/pmt: Correct the typo
 'ACCCESS_LOCAL'
To: WangYuli <wangyuli@uniontech.com>, david.e.box@linux.intel.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 tzimmermann@suse.de, lee.jones@linaro.org, lee@kernel.org,
 guanwentao@uniontech.com, zhanjun@uniontech.com
References: <0F3CB9A22C53A581+20240929092302.1039036-1-wangyuli@uniontech.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0F3CB9A22C53A581+20240929092302.1039036-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi WangYuli,

On 29-Sep-24 11:23 AM, WangYuli wrote:
> There is a spelling mistake of 'ACCCESS_LOCAL' which should be
> 'ACCESS_LOCAL'.
> 
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

You send your v3 patch just add the start of the 6.12 merge window,
so nothing will happen until 6.12-rc1 is out (sometime today).

As such there is no need for this resend.

Next time please wait a bit longer before posting a resend,
especially during the merge window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/pmt/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index c04bb7f97a4d..7680474c4f96 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -207,7 +207,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  		/*
>  		 * Some hardware use a different calculation for the base address
>  		 * when access_type == ACCESS_LOCAL. On the these systems
> -		 * ACCCESS_LOCAL refers to an address in the same BAR as the
> +		 * ACCESS_LOCAL refers to an address in the same BAR as the
>  		 * header but at a fixed offset. But as the header address was
>  		 * supplied to the driver, we don't know which BAR it was in.
>  		 * So search for the bar whose range includes the header address.


