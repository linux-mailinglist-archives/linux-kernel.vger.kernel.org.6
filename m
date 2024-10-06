Return-Path: <linux-kernel+bounces-352343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB9991DDB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA30B21BC5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481CF166F34;
	Sun,  6 Oct 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyInaoA8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA47F6
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210620; cv=none; b=LXwRwj+7HdzPfK4KT8yfR9R3T4Dtwaz/7yFZzb3+AAkiq99pT0YZcQtDqQOZLUcJ7YbDpVvLXVJxvhD7SJIaVOHPFqMl9zLWprvGubtUlLRtqPupe/ufRlCYgcZ7tA86LnNAiKaRwoFrOpshseAA8wIJGuQ+Q+CcSJpcLlKzGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210620; c=relaxed/simple;
	bh=/q5RSB3zXrOdqleEci0EsSo9N+y89Zu89ixbYXFAuuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsE31bLmWq6DsNdPbY+lWMADbSpNi7TotRaljSU9sq/B/J8Wzitf7kMH7itTByLRA5B4M4oll5/xSkxNOUiBoF0SlWW56dq10W1Gn4i+NWOql8dvcT8KvIMJqMRMN1tV4YMDjghRks1nKFU4qiYUpGzF/lhKuu7j79efICD9yqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyInaoA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728210617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oulXyoLt0WKZ+UskwJ8Ah+v4BDE4agdwTAaApYR5Sz8=;
	b=iyInaoA8UHv6rPfvhkPCvgBYQ76VGScfdHYreo3U4ZF5sG9+cFp4Wv6DtaFMhPGhcpu7xe
	nvhyJKK7nFeripJlfTnpvdBMZMLUxxOt97IsHMNzjzsUoGFNbmokd8ozmLad78u2+9pjxn
	S9LtqQsKdQt4YwLewKwlbIAmZgauWr4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ydslgbkkMWiEM3HboxXqxQ-1; Sun, 06 Oct 2024 06:30:16 -0400
X-MC-Unique: ydslgbkkMWiEM3HboxXqxQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a993dc3d6e2so146195366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 03:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728210615; x=1728815415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oulXyoLt0WKZ+UskwJ8Ah+v4BDE4agdwTAaApYR5Sz8=;
        b=QQ/QDntrCAWkksWX/CnT562IEfgmZ834ntYIJMKqLvd/8WmvL8OCNT3THh8vAmSET/
         4dStRMgljOWWx2vJIEcd+g4oimpzwvmQ+SI2taQBF0Byp+hVeRt5bWdenaMhYDp9o/dg
         uF+9xz3TD8s82sR3plQFxiZIgu1iCYORAPZY1wvAeHHKFe7lvqicnq/1wKeaduRmI/3q
         tL1bWf5YD49E52Hwtd5KGRsVLaZioO/0adtBQxfvycAT1FqBiiSH98i1aeMH5sqNB2O0
         YPmKnNTcaM30QZ2qX5hymJ0utZIzjuA1ucYBQByOeQZFHI5PcYWAG/MCtLtVfh/ZclqX
         7aEg==
X-Gm-Message-State: AOJu0YzkN/n+SDMOBdIsXXQIyW2ekPntTiYgKWXgZJiz4vIIqOdQEKxA
	HWh7LGsyXQQKleTcKOkiiomHDUguBNYGzLOnxVYC2Ciiwqtx5NQlKqXtIkHBd5kzHQJTNnSe6TQ
	I3tJV+wtGNor95N6vFA++Y/aCYJHfoH4birxPgdtWdEWA9laiI8osCURsTGl69w==
X-Received: by 2002:a17:907:6d0b:b0:a99:5466:2556 with SMTP id a640c23a62f3a-a9954662964mr4888866b.61.1728210615399;
        Sun, 06 Oct 2024 03:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnspp1E51AID6UCwdFUYpbPtxjCzqz37ev9d/qB4+LC3pOdnudHEGJ+3lO8dzYGqI5hAlS1g==
X-Received: by 2002:a17:907:6d0b:b0:a99:5466:2556 with SMTP id a640c23a62f3a-a9954662964mr4886666b.61.1728210614886;
        Sun, 06 Oct 2024 03:30:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7860cbsm238402766b.120.2024.10.06.03.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:30:14 -0700 (PDT)
Message-ID: <00f59e1b-0f43-457b-a7e0-6865934c4752@redhat.com>
Date: Sun, 6 Oct 2024 12:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Intel In Field Scan(IFS) entry
To: Jithu Joseph <jithu.joseph@intel.com>, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 tony.luck@intel.com, ashok.raj.linux@gmail.com
References: <20241001170808.203970-1-jithu.joseph@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241001170808.203970-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1-Oct-24 7:08 PM, Jithu Joseph wrote:
> Ashok is no longer with Intel and his e-mail address will start bouncing
> soon.  Update his email address to the new one he provided to ensure
> correct contact details in the MAINTAINERS file.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..89fb731384ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11496,7 +11496,7 @@ F:	include/uapi/linux/idxd.h
>  
>  INTEL IN FIELD SCAN (IFS) DEVICE
>  M:	Jithu Joseph <jithu.joseph@intel.com>
> -R:	Ashok Raj <ashok.raj@intel.com>
> +R:	Ashok Raj <ashok.raj.linux@gmail.com>
>  R:	Tony Luck <tony.luck@intel.com>
>  S:	Maintained
>  F:	drivers/platform/x86/intel/ifs
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc


