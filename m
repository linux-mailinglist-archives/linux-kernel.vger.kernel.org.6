Return-Path: <linux-kernel+bounces-235684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F191D858
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8618D1F228DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D365914A;
	Mon,  1 Jul 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDvbNNZh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113956742
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816927; cv=none; b=qTQlqLFkiQIdc6Ig6m8CvQaofrWtoGFBNVaoBDoEuXPEBT3TM303+N1IuTe/Uvws9nPtsZAf7iRsBP17f8rGB0YCRvGK0k8ZgO1wpf5zVdpYN05TfxIT+dbK47CtQq7X/b5al3KqLfQp0JrvsXN1DRhTGbS+xrH8WvXrRHOoKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816927; c=relaxed/simple;
	bh=xJyo4h3Dg3hv+dVSKDPQ6YZFfSv9+w2tqtR043zGUHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQJWMhGjozae0dTpAR715hkqKv0qxMUAkPxjuvgItg2Qwz/g5yh7PtC4cZP/JVcErfpuOxY2Omh7LK1UH4JN4QWgdcExf+PTF3jih5fBw34xY/BWeKz29iTz2OTP/BearuGXJU/yZnDajiFSYXsy0K3lp7Tm29/FnYMYRYDRv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDvbNNZh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719816924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=glgtNTPZcrTMFuvFQHUSkgAknMIfGdNGOQVZXr6adxg=;
	b=XDvbNNZhxTBtEWDs3qkAbuwYZ0L83hPMi/ATC0z42XlOzUcdNlr0kHDchQNKcix32XOZnE
	MRYxqyPSEGkEEE8m+e21PZQG+d4HKd3rcIi/nn1nqx4l7Dgj7mfaJuuj7h0snKFneQmJqr
	JYWyzfMyQwKZLL07UNJDjQVu6g/tS5Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ADfsLud4Pye0qugmg2o8UA-1; Mon, 01 Jul 2024 02:55:23 -0400
X-MC-Unique: ADfsLud4Pye0qugmg2o8UA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-366e84fbd4bso2094084f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 23:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719816922; x=1720421722;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glgtNTPZcrTMFuvFQHUSkgAknMIfGdNGOQVZXr6adxg=;
        b=ki82U47ujWM6rgF9Jjmt+fv72EqplQn1XIpp1Xl/D9MLm/Xz/b21b5UCmwi9LI6re/
         2cHjVdPHHRPGj63UBfcg+DBeu4r5+vJvKGWNFg2SUFdnnMzqnvvgAFXkN6uVezdYGxcE
         9YWg40RaRpCVuWfqWMGpst5tRdqFZWJSE6TC5m8YKn40xm0Ae9LbKiek8U4DcOZCt1Pc
         cmzHuukWcyBRp5IK4wW3sms/9IiG60imx7lz0fyq4Mgcq4PtZtof0j7lQ0bheDWmSkCl
         m/p7xtMElbiZnNOU/bZl/o716jja2Dubv4SzRQq1sZWBxl1MPkLyKSNGcd0O+/EHYx0r
         MADg==
X-Forwarded-Encrypted: i=1; AJvYcCU2aAlVPQnl9F4Gy/kunWx2QruEKZXlZF/PhZm0QxlYK0FU5J17KWEi6HzcTyNM50EAhk0frYUynT6PMOTrO0ycrWz42iXvKbc2LJTN
X-Gm-Message-State: AOJu0YxMr64n61/Fmvo1x16hjcqGkcGLjpHyOC2gS5hYADbHBz1k5Qm/
	hNKTc4+qA61Xai4N4o/dF8vIVT1BijZvYbRxw2uQ8xLE1p5d5H5We5mSaxWKu2rip2drDYklidV
	1ZDh99zmg3s+xSmSTt+f70VbAX+/HqfYj6G1cRtIbXR9F9jVxlDiV2gTtaoEJYujruwOwAg==
X-Received: by 2002:a5d:49cc:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-367757200admr3792696f8f.46.1719816922627;
        Sun, 30 Jun 2024 23:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkSIOwyPwj10OkfDwrxar2pmbAtcFWuP/RXX1gb5+VDZxBO5ZaenQJMxc8kF5JWScZzFwu9A==
X-Received: by 2002:a5d:49cc:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-367757200admr3792683f8f.46.1719816922219;
        Sun, 30 Jun 2024 23:55:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:2200:7ed7:c239:d423:3b31? (p200300cbc72e22007ed7c239d4233b31.dip0.t-ipconnect.de. [2003:cb:c72e:2200:7ed7:c239:d423:3b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb9absm9187238f8f.80.2024.06.30.23.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 23:55:21 -0700 (PDT)
Message-ID: <2972d75a-ab26-4da7-88fa-81bed955cf52@redhat.com>
Date: Mon, 1 Jul 2024 08:55:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Bang Li <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <21cnbao@gmail.com>
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <b2e6fac2-7c23-4a92-8d89-ff29b8566967@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b2e6fac2-7c23-4a92-8d89-ff29b8566967@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 08:47, Baolin Wang wrote:
> CC Barry.
> 
> On 2024/6/28 18:49, Bang Li wrote:
>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>> anonymous shmem"), we can configure different policies through
>> the multi-size THP sysfs interface for anonymous shmem. But
>> currently "THPeligible" indicates only whether the mapping is
>> eligible for allocating THP-pages as well as the THP is PMD
>> mappable or not for anonymous shmem, we need to support semantics
>> for mTHP with anonymous shmem similar to those for mTHP with
>> anonymous memory.
> 
> I did not see a consensus that "THP*" related statistics should contain
> mTHP in previous discussion [1].
> 
> In addition, if we all agree that "THPeligible" should include mTHP
> statistics, you should update the corresponding documentation to keep
> consistency.
> 
> [1]
> https://lore.kernel.org/linux-mm/202406262300.iAURISyJ-lkp@intel.com/T/#md7a77056110cebcc2a9b3cd7e4a8d682667f6ba5
> 

Fortunately, documentation (Documentation/filesystems/proc.rst) says:

"THPeligible" indicates whether the mapping is eligible for allocating 
naturally aligned THP pages of any currently enabled size. 1 if true, 0 
otherwise."

So that documentation is already pretty clear (we just have to make sure 
the other ones are properly documented, for example as raised in reply 
to [1]).

-- 
Cheers,

David / dhildenb


