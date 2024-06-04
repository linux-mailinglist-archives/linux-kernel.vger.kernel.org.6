Return-Path: <linux-kernel+bounces-200890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1B8FB612
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33965287864
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082214F137;
	Tue,  4 Jun 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCr3CgbG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97F14A4DE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512142; cv=none; b=qZWAuw3GDlgbe17kXSqOqT5qEa1tFxqaUYYK8CtXWdzss/urLDWq/3fnCp3YIHX8l0VxXtY8Y2Mvu8A9pTLMH1WSAanQjU1+Zh+iUn6N1M/80jxMriZ6/FzAJ6IS1nK6khWT4aUZsTSHHUGMXCLT51ZF8J3zD5vqXebGrIidKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512142; c=relaxed/simple;
	bh=Ghqj7sm86kY0ZfjVRuy7AMU0AJWf5Kbzzfiaeeu4Smc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INjkLYnXD0OXOw17+sO6uOSNK1htFMRnc1KH6P2BJGiTAFHr0XpF0PqEymmNN/FXISek/8sHdprZy5sshUwrS4UzxBrQk9xGSxTgmhhm3h6XZwhSrEfQlhmyPopgvQp9azlu0DVtlKsrbM2ke7S/1tKBxtWJ5Rk+T2SdcisIw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCr3CgbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717512138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSKZn5YJoJ3kMztNbh4Ff0sh8p7A+Y7W7uSyuwooK8=;
	b=GCr3CgbGFtppbFBknp5GHAFYpN3skru48lJfzrg7+r9ZcCjhPDtx79mUh0VY238EMQd+jD
	PPK4FjKBAWuCBtjfXqJDUJevEGy4PDuS+UjiGsVZN5UYOfNL7s5EXkKQLpGHHqwe8nBzU8
	LkTjgKDx2ETeYGFQer2pBfwJETkGxNM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-MGrYLXmCP9S3pm1nWD1f7A-1; Tue, 04 Jun 2024 10:42:16 -0400
X-MC-Unique: MGrYLXmCP9S3pm1nWD1f7A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57a1c680aa8so474166a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512135; x=1718116935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GSKZn5YJoJ3kMztNbh4Ff0sh8p7A+Y7W7uSyuwooK8=;
        b=Q0p8B8/0zWe7NhOtNFOrDdxH28EehryjG3qCP2CroVNxsNYRWHq1gwFT9mBGVFXR6Z
         aA5dfGU4s0cflYs7ELRp226Zn+JLjojT0Yy0fi0P09a9M98aHNM0B7E2VX40RMxbc0xM
         7TWT7egW+sK8awe3pXoy5mJQMKnGm+uWx8KbX3wr73SXlI+5sSFazbHIaay8Xr3XYPVg
         FeYx96fdSY8gBBkZ0gKzeYrtGcocJX/u7VFfJDKNKRjmDxHJh95l3Z+xXuHRTbIXDjQx
         UDdtHGvTJZQLMX3wxWw0EC5MNCeuYRnSRYSjbK2qgjnDafdt2rCwS3wD7YP/OP+qr08J
         MhcA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/u4XxnINx0bDI0pbyNFghveynpBNZOPycYFAnJ2VF2Q6utXvQnCst4rXrgnIJ+/AHzByN0XkiHepITlxhdwkcTN1OabDq0IXe3Gj
X-Gm-Message-State: AOJu0YxPb7OlpY75PkGI8cJInsBmONxoFb7U9za8OEga9jiX3XtnP+uT
	a2FFRSgT6i7MvRSbFlo1TIgJ1plnefjiGZnl3XtQB2la/xRm4YohnkmA1BvHpXIiQt0dU87vq56
	u3W/HrpQVyj6ZD022gnNSJaXhlp16ewHPkhN6v+k6B1Gh5uGV7BjlQUUl2qePkw==
X-Received: by 2002:a17:906:a946:b0:a65:d7f7:f3f2 with SMTP id a640c23a62f3a-a6820be934fmr797485966b.36.1717512135501;
        Tue, 04 Jun 2024 07:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdDULiev1oH5nT3hJB3si4jO9YRCWfF0/Nqzsz2PAZuFe5bOc8WIqL7WohgMsV7xNUgCC15g==
X-Received: by 2002:a17:906:a946:b0:a65:d7f7:f3f2 with SMTP id a640c23a62f3a-a6820be934fmr797484566b.36.1717512135073;
        Tue, 04 Jun 2024 07:42:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e940ed6asm411617666b.22.2024.06.04.07.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:42:14 -0700 (PDT)
Message-ID: <ad6c1af5-b0bb-430a-9d6f-0cdb1d2d8904@redhat.com>
Date: Tue, 4 Jun 2024 16:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240604-md-hid-lg-g15-v1-1-265b094db089@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240604-md-hid-lg-g15-v1-1-265b094db089@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/4/24 4:33 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lg-g15.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/hid/hid-lg-g15.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index acbec1dcf196..53e7b90f9cc3 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -954,4 +954,5 @@ static struct hid_driver lg_g15_driver = {
>  module_hid_driver(lg_g15_driver);
>  
>  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("HID driver for gaming keys on Logitech gaming keyboards");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240604-md-hid-lg-g15-e4a106ba126b
> 


