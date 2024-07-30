Return-Path: <linux-kernel+bounces-267617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F094136C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C7328255D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80531A0706;
	Tue, 30 Jul 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQsMyG2t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8F19FA77
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347015; cv=none; b=IdsTaTNKfc8+w3pgAOkVYxShSLrJX0lMRMo1dNKnZZLu4uFhlpA3mE86mNe5M9w7xZSWAWcWpDeEgEWRErPGl5lkM1yw2Twa3PFagoZEcYoTU6gd+6RapqtNchdX9rU4QqKHRTZ0TsaRAR5kCeeei8DxSbwezA73oYVPSrNMlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347015; c=relaxed/simple;
	bh=fEeMyQpbe7hW1c3kPn8049ViTcs11muKc2j6GTTlrFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qbpy7rd8+UoOfBuTdv/Zdt+72Y4K7dUrZsrT/skoJpsJYQFIiG1RAFZsGCTGYT+mj0oQeET7M1GumIs27CnhoOeGe7YewUjr/0mc5WwkrNjE62Qhvcvo81TFLquWe+Uo7Hm0Er6itOlFqSvORBDqVU08KisJodHo241H5WVVtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQsMyG2t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722347012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIKQ8Grre4gzjcjmQf4lltrimuZ0xoo96Uhzmgo74TQ=;
	b=iQsMyG2tHlBvU7HTuBcEUcdHxKMHYmk8nIEYzX+KNfJMwNdBJKVSNOVXSk94X8Gtj0rnGs
	+LRJkpgUmLDB9qqEqYWsldtjS6WSo5RbJieJ1S9IcbWrdSKEHdMldXTHs8KeeJNX929zLp
	3MVGr0mtnRlse5pX0G5fiIBHk+ezcsQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-U1oEnSsmOrS9U4NkSJhiZQ-1; Tue, 30 Jul 2024 09:43:31 -0400
X-MC-Unique: U1oEnSsmOrS9U4NkSJhiZQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a83fad218so363530566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722347010; x=1722951810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIKQ8Grre4gzjcjmQf4lltrimuZ0xoo96Uhzmgo74TQ=;
        b=AbWKHYKg/+e9sloqt+gB6Xl01X0yQ948y/psdkmS+lNvNcLhqzxYeLdEHL1IhDgn43
         6TQ7Vy3KtLn0XBffIO113YX/HAhGNDceRAQh1HuDsk8KYQlg6+BoeSmdFVXc1lwAc9gT
         RUgPwzG6G2ynuQi3ZqrjIgymU9Vxz9jlFt+FyKgoyoem/1dAzit8HWxS0Gs2NnGW9HMT
         UA0CChHNm3+EKsvivx6Uuy1aZ+vH9yc7ixCFUGl7+PUX/B/kwtplWTfOYhoSXyaP8lsn
         AWuWRk3NmWYvRl7zbrTCFzD33hLX5wpfbA1jAe1PsF1TXeDwbiWlUzVgIv+wS3od7JeP
         cD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWzhVCtdmyJLNITuBT9c+nVP2Pyl4w/QN24yEZUc85ljB8fnS6WobMfZ6TFr5ie0zRUpPs3AFXeid3ivbMNYO5qz9ork5PeXNVk7vM
X-Gm-Message-State: AOJu0Yx+MVBgdXMPoPxn8wwvLkjF2Qomx+shhR6h2lDRz05F6Dd0YKau
	mnlNByAtsyBIWK+mm9S0qkel928CBWgXj2poWFZt4bVOBy9yay3CH4sVIxnvQvpvu3+MQbThs08
	T0SY5xSfK7tPLgG5jKaP2Gk0HeYJz7X9sF0u4Hf4QzFzfWWAYVkOUvCqvEBwUSi5Vpvaq6kHp
X-Received: by 2002:a17:907:d8e:b0:a72:b4d6:ec6c with SMTP id a640c23a62f3a-a7d400bb2c0mr810840266b.33.1722347009692;
        Tue, 30 Jul 2024 06:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2bhyq9b3mRAXR4ScB9mSPQa/VqSDPkEyk7KB6VJG2Hb0KepNOOSVf8hvsqrlqQD3F5QpPg==
X-Received: by 2002:a17:907:d8e:b0:a72:b4d6:ec6c with SMTP id a640c23a62f3a-a7d400bb2c0mr810838166b.33.1722347009227;
        Tue, 30 Jul 2024 06:43:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab5151csm642601266b.74.2024.07.30.06.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 06:43:28 -0700 (PDT)
Message-ID: <389396f9-2b07-4d7f-a609-747f3abd4864@redhat.com>
Date: Tue, 30 Jul 2024 15:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8723bs: remove space after pointer
To: Kartik Kulkarni <kartik.koolks@gmail.com>, mchehab@kernel.org,
 akari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
References: <20240730134155.37784-1-kartik.koolks@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240730134155.37784-1-kartik.koolks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/30/24 3:41 PM, Kartik Kulkarni wrote:
> Fix checkpatch error "foo * bar" should be "foo *bar"
> in osdep_service.h:105
> 
> Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/include/osdep_service.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
> index cf96b5f7a..d6d651342 100644
> --- a/drivers/staging/rtl8723bs/include/osdep_service.h
> +++ b/drivers/staging/rtl8723bs/include/osdep_service.h
> @@ -102,7 +102,7 @@ static inline int rtw_bug_check(void *parg1, void *parg2, void *parg3, void *par
>  #define MAC_ARG(x) (x)
>  #endif
>  
> -extern void rtw_free_netdev(struct net_device * netdev);
> +extern void rtw_free_netdev(struct net_device *netdev);
>  
>  /* Macros for handling unaligned memory accesses */
>  


