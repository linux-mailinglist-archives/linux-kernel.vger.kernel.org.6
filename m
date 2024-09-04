Return-Path: <linux-kernel+bounces-315689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4AB96C5D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432112851D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A61E1A17;
	Wed,  4 Sep 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5pGhe+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B091E1A09
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472516; cv=none; b=gh3a2AsA3UDaclimJ5AauH4Ut4qC15NT7ido6YnVYa1r4mw2XpJyeQfDUvoym2PEt4Hl8sV6mDKz8J39FedaDCq2swy4WTHHl8yrC6Gr7lpcLfM6EqGuNQ/EsYv+/eRmVzi8QwpInNkFvwxqclPEykwlKaNzrEVjQtyWhXAG+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472516; c=relaxed/simple;
	bh=VWzM6EtUmeeVBM+CvbOkVNtoVZCunbQNZn5u3JdbtV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/MEaeSifZLJPg4I23+lilm7QxviOnuAtXxdxQmJzcDuHM7RHeu0bX2wnGXuEPKidUeWvyXqh/NQjifEMWw8e7sUB+OSjk92rx6kQelfzXv/079rhSitk5kJOom1U9QfJr2s16x+RYe+dZXcMg00SQ7ETghSEuJEwhIWi1hDEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5pGhe+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725472513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpULzeoOquLLnjVucbF5xnPEVwj274syMFrmrkoRAMM=;
	b=F5pGhe+c3y66yUw6CB2t9ELKaUs6lE+1kevbciOJi8+V5707VcLXnpGekuv6hqNELkbWDN
	LBNDN++DQtX+ZjZfpjWBoWQ7c9VWOB6yXbIY9giQdoWfqVq4V1IUxNqrr7vAv/P6u2TOIg
	LG8Bq9QNT/UD0yw14z7NzlIgE0L6+7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-YvxzJSVFPvOSWZMVZfuArw-1; Wed, 04 Sep 2024 13:55:10 -0400
X-MC-Unique: YvxzJSVFPvOSWZMVZfuArw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a869b31d816so505515466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472509; x=1726077309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpULzeoOquLLnjVucbF5xnPEVwj274syMFrmrkoRAMM=;
        b=anDTwWG5xnPlnaEw1znWEl5K0UW4bat0dmL94JJpNYaLOZa2PtJJml03j0z9B6Pb/m
         NE5vuaf8bfp9DmFmQJBAfGJ4zTxUydy7gcD+sa37RXxlviPKyy3lWJ7c6NkHNnNFI4VI
         Ma9mxpwJP6DhS9SmMgNm3L4polE83eO+D3+h/AMNf1MW1xqx5daI15lJDJOFFVn5SG8E
         UIk1chfF7MpeGnmh62v3ZKGBfZE/Hk5fx9Zewl46aCZ3VZY6556udB35Lqo3wy34ZX2Z
         9tTioFWUeF686ljh0zNBTTYbnCUG7MwYHXabwwWSDzaL2Z7Xwf9BN4ceW3IfjcZ8Hpuo
         8lXw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSGOc/g5Z9Ex+NCgjEdk0SZhOP+CeyCaKR2PT7dFQi3vdWwamsUno7IRlSLDvdcjZcBDocrohQXLR2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1nMxTAbjNX+92Q/iDkEj4qO+ctyfnUiK/+EWMKcHIhShDagr
	symo4dvGNtSqJGghjgaYGaEossj/8cDUbxMkfe7CgUwaksp2XZK9bncBLRFQDRedNTneTMAzt2Q
	gBFPZBg6ZkfGBpW/L/90M97FeBsNfzz+FulRFlW5d2iZWGMVhe8b0iqh7ykN3Sw==
X-Received: by 2002:a17:907:948f:b0:a86:a417:72d2 with SMTP id a640c23a62f3a-a8a1d32689cmr535400766b.35.1725472509358;
        Wed, 04 Sep 2024 10:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2LPU0ING+4KbER6sgAUpEBU4Mq4znqdOnm47Qu/gv2s5OprciWuiK45hfXxAt/jYUlq4jbQ==
X-Received: by 2002:a17:907:948f:b0:a86:a417:72d2 with SMTP id a640c23a62f3a-a8a1d32689cmr535397266b.35.1725472508858;
        Wed, 04 Sep 2024 10:55:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623c2b00sm18489466b.162.2024.09.04.10.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 10:55:08 -0700 (PDT)
Message-ID: <bf7910d7-395a-4d01-960e-46789d836da4@redhat.com>
Date: Wed, 4 Sep 2024 19:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
To: Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
 luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, rafael@kernel.org,
 lenb@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240901031055.3030-1-W_Armin@gmx.de>
 <20240901031055.3030-2-W_Armin@gmx.de>
 <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e90b40e9-b3a5-4228-8f12-b02a77b7789d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 9/2/24 4:28 PM, Guenter Roeck wrote:
> On Sun, Sep 01, 2024 at 05:10:51AM +0200, Armin Wolf wrote:
>> The BIOS can choose to return no event data in response to a
>> WMI event, so the ACPI object passed to the WMI notify handler
>> can be NULL.
>>
>> Check for such a situation and ignore the event in such a case.
>>
>> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Applied.

Thank you.

Unfortunately patch 2/5 touches the same part of the file,
so I cannot apply the rest of the series without first
bringing this patch into platform-drivers-x86/for-next .

Guenter, can you provide an immutable branch/tag with
this patch on it; or drop this patch that I merge
the entire series through platform-drivers-x86/for-next ?

Regards,

Hans



