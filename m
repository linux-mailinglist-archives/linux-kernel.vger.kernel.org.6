Return-Path: <linux-kernel+bounces-257091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBA937510
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C241C22025
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9436F2F1;
	Fri, 19 Jul 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3gYQDIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64E208BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377766; cv=none; b=FNRtCbdnI6xXRw1AuZ5eepDTXREUJWsVLTurSQb4bBUX7mq+mTaOkJbs2vF1F+L7Nmyq6k5QyCDR/t8axb+DA18fPad2qrwbAA7nJ94IulKkFsK8fy9z9PpssYCqbah5MJKlTEqwTCEsaU23OQUQU0nqOGozMZgcfGz6qSpMqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377766; c=relaxed/simple;
	bh=Cp5bBf8m9F904HyJxdJVtsAKSI/kT9VMOTCn7szFO0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkcTM/PcyyPHkUnpLitPzp0hoovBk0ur1zYAES2PTw+IWA+F6PFJGh6mkiUpaiQN1GFuNQQx3badwvsl4r+gxMhocqF++Hsj+uOamLfcFXnyICIdyBed6dlJuM1Rzu0lm9RVoJsiKOmY/XbSMq7h5GYpu+xLBtXih8zzDa5bkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3gYQDIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721377763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mEvURRuXIQlOojLd3hkXa2g29GkpFSOYGY/bvxncEiI=;
	b=P3gYQDIsUILwEUr77zY7FRWEEc4ReX/wQ4WbdUyVBOk2LcDOMGatNB6u6qhUJHyFjEireX
	/6aTRmn0mYjmf05HcuYouzhBI/yEKCx3WnUSHHBvaOWbHPkLLiI7pKn1CF70nPwVVhOa7u
	HO0S09UEKARykDUw2dEIfO1gdO5Yoz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-f4x7dTE-PhOhgq_kdcwtFg-1; Fri, 19 Jul 2024 04:29:21 -0400
X-MC-Unique: f4x7dTE-PhOhgq_kdcwtFg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4272718b9b0so10727425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377760; x=1721982560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEvURRuXIQlOojLd3hkXa2g29GkpFSOYGY/bvxncEiI=;
        b=N9YTlh8VXSoS9laqDmmhk9c+NOQegaFhKAXJGza+sLPb9TDkZp/jnlYk/9fQnGRFgh
         HpKz7Epx/gPLl4HTMkjSljxbJaHVgnK3M00Y7ioEjS9DOpUBVMnG9M4R20NETKHP5EM2
         u2YN4G3DdfZEEQxWPKyEVhuRJx/EKbfZyRme/vHxHpapoPjTC88CJ6rsONM3gglWytQM
         9DwEw2BHLSS1G3NWeIyZW78AonO828Ufd2s6Ipa4D/NEPUJaz4RSbA2Txin3iGXA0mCb
         EMN4I29oOMhcGPpfUuTkXLhTvkC3sXPzhskwnuJMZJgzrv9Z0YDjfCsvbHguNvNFp0e4
         m4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDV2LnCpHZoy2rSQ6kDhY0NamY0tJAEd6RKtlgmiVHwQNc0HcRdFYOyzc/ASdSKpxJ5M1KdT6W5hxTfM6waTequz0RM5EnCbpBgJgS
X-Gm-Message-State: AOJu0YwPGAhxqF9HC5q++4g1F4a6pmtU/ZB0VCxoEr3vYou4TQukRZWT
	NXyy7A2+5CA4LiF3nojTnx4dYIU9dhfSTLKONeng9qNXBwPF6u5/G3ul9f79Ztq0PurFC/RnjK+
	EsHNNO+kIOJWMv0yRJ6r7xZVsxmf+2rO2DJft0u37+kx7v1xgInKR9/kItXnOKHfnmXLVjg==
X-Received: by 2002:a05:600c:310c:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-427c2d0bfccmr55859505e9.34.1721377760450;
        Fri, 19 Jul 2024 01:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1edBeEIkR/q4EqHK7aqXX0vmgXSP/PkUzbHsdU4iz0wEMQf6PafOjyNLNtMF8SP4cU7eyJw==
X-Received: by 2002:a05:600c:310c:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-427c2d0bfccmr55859385e9.34.1721377760041;
        Fri, 19 Jul 2024 01:29:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1000:c4af:a24f:b8ba:8bbc? (p200300cbc7051000c4afa24fb8ba8bbc.dip0.t-ipconnect.de. [2003:cb:c705:1000:c4af:a24f:b8ba:8bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936e1esm15687055e9.44.2024.07.19.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 01:29:19 -0700 (PDT)
Message-ID: <3551520d-d81d-40d7-8651-f55e642d24dc@redhat.com>
Date: Fri, 19 Jul 2024 10:29:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm: Override mTHP "enabled" defaults at kernel
 cmdline
To: Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <20240717071257.4141363-4-ryan.roberts@arm.com>
 <CAGsJ_4wiZRP9siEk9WpAYRjj-gehxptGY9XWC8k3N4QHBppAhQ@mail.gmail.com>
 <fa5bd4cb-6d5c-4cb7-bb41-3c277e291cd6@arm.com>
 <CAGsJ_4xSDc8pX+-vOUcXtV_ivt0Jc-LECiC=tto9oxYeOtU38Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xSDc8pX+-vOUcXtV_ivt0Jc-LECiC=tto9oxYeOtU38Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.07.24 09:52, Barry Song wrote:
> On Fri, Jul 19, 2024 at 7:48 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 19/07/2024 01:46, Barry Song wrote:
>>> On Wed, Jul 17, 2024 at 7:13 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Add thp_anon= cmdline parameter to allow specifying the default
>>>> enablement of each supported anon THP size. The parameter accepts the
>>>> following format and can be provided multiple times to configure each
>>>> size:
>>>>
>>>> thp_anon=<size>[KMG]:<value>
>>>>
>>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>>>
>>>> Configuring the defaults at boot time is useful to allow early user
>>>> space to take advantage of mTHP before its been configured through
>>>> sysfs.
>>>
>>> This is exactly what I need and want to implement, as the current behavior
>>> is problematic. We need to boot up the system and reach the point where
>>> we can set up the sys interfaces to enable mTHP. Many processes miss the
>>> opportunity to use mTHP.
>>>
>>> On the other hand, userspace might have been tuned to detect that mTHP
>>> is enabled, such as a .so library. However, it turns out we have had
>>> inconsistent settings between the two stages - before and after setting
>>> mTHP enabled by sys interfaces.
>>
>> Good feedback - sounds like I should separate out this patch from the rest of
>> the series to get it reviewed and merged faster?
> 
> +1

Agreed, this is reasonable to have.

-- 
Cheers,

David / dhildenb


