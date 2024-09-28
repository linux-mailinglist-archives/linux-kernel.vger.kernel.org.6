Return-Path: <linux-kernel+bounces-342401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2047988E81
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE88F1C20F84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786919DF73;
	Sat, 28 Sep 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PA7++lXo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF715A8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512245; cv=none; b=YR8NIaUIMy0pbbiu+3npJZvJ3FLitOSXvDd2KYj5M4zXj1bw9chZwotvijJXFf5K9XsWE1jeqwsYkezv4HM7BtilIdzky/au3ehEA7nsPCzP8wnQ61Ua/kxGjrlP5lryltJCqjLP8zgJYBm7bbEFpAkc7pbIbJb+H17O34sgkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512245; c=relaxed/simple;
	bh=QqNhkoFyDZmOSk4Wf4LAtMRK616LkEeK66qGy/F7myE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsHPGoEFvNXVrxGXDlIhmQDx4H3ewIgfCZs/A+Iq2SOFzRuEeqNhCtl9zzjOUo3WfhV7Y40TPevkd2jZhQN1y/ItHEXiC9BW8eoSqH4syMMrp7ZLuWyh9dChhr5hS/wE2RpZgeuNpcKc2LpZRhca/WcIknnenkNv+ylbkptejCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PA7++lXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727512242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6MtfPrXde4k6As3sOXmempTShtj2NTBqegTwc4NvZng=;
	b=PA7++lXoP3A/Q+b01Cl+ndaCmBMK4514T0+zHC2sgDAlpk+YJ7KjEaJv2BcrH+UsOS7wlM
	CfA75CGDLVKSMBkJWekzzLsRpvul7vmS71G+lV0dv2qtdyak4Ro1if8yjTbqxQ9rca1n6n
	8q2QpaUAOmgzpOc5cSXpTuYR8+0QPPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-PKwimIlBNWCLZEINKPUWEw-1; Sat, 28 Sep 2024 04:30:40 -0400
X-MC-Unique: PKwimIlBNWCLZEINKPUWEw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso17192125e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727512239; x=1728117039;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MtfPrXde4k6As3sOXmempTShtj2NTBqegTwc4NvZng=;
        b=own8WQ2bvgK9tsShdNAJGaxkeQRtvyYVzKnn9LWT4HVUuQUsug2acVsBSewTcvkllx
         9zM8bNonbsADdao72DnJd3qwnH7Qhrb3NR4T1Zyt2Fq/IGbhV/eZO7GUAfozm6t9TWNW
         8g9VMQxOzXIaz2yd3IUFJeIikU+bJTNdTBd18pgs4pTk3gCbz/dTlUm2cEJI30jDdIKA
         vD3U5AMt3nbSkU7E20KiYSSHuLEnuKhyi9jter7DTHZzJQ8nJOvk9kI44bNEySQ5khut
         d6xLkBDBGayUJ/cVMw+IHcuHjTG0N5A+Y9sna7KQ+qm4vIRP6YoURujZnvCo4ytUzZcQ
         2KJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV52z1rcnpUmmavepijp50ltPt+S6SsIASXMBZP+eaDB2eh6cu9S13khw+jsDEDZ5UbfVbKsUAa4C0aH7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksKTowuW3+38rYruDuyFHSm3/8LdD+Vp40R5+/dR59x3COrY8
	RaMmkWYRvU6dr4gkaFe3NnLW6lbixmTxhd0m5DIqwAONInHwi6O1+gBg05iBwM5eGO6sFUqoZNh
	J0S22iicvA3X1YO8N70nQk6A86BJHyvQlzCOu+64VyyvY5AkJGZYtL+9eU2vdRg==
X-Received: by 2002:a05:600c:4515:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42f584160b6mr40600965e9.14.1727512239637;
        Sat, 28 Sep 2024 01:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQJbVfptR3Vy+1UwSr2b5rpKTnlPPphO7ri1HCA+nDF3hvArCM0+X/IlR1uvUELwZ30tVAg==
X-Received: by 2002:a05:600c:4515:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42f584160b6mr40600765e9.14.1727512239268;
        Sat, 28 Sep 2024 01:30:39 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2399b.dip0.t-ipconnect.de. [79.242.57.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f1fe4sm94707095e9.14.2024.09.28.01.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 01:30:38 -0700 (PDT)
Message-ID: <a1111029-336a-48cc-91cd-b2c1e28563f5@redhat.com>
Date: Sat, 28 Sep 2024 10:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSF0gbW0v?=
 =?UTF-8?Q?cma=3A_print_total_and_used_count_in_cma=5Falloc=28=29?=
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
 Xiang Gao <gxxa03070307@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240926120049.321514-1-gxxa03070307@gmail.com>
 <755ff53a-2727-4993-92b4-95be668f3b67@redhat.com>
 <6e7bc1dfb59d4ee39bbb6a6bb7ed8808@xiaomi.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6e7bc1dfb59d4ee39bbb6a6bb7ed8808@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.09.24 03:04, 高翔 wrote:
> I see. I think adding "pages" is better.
 > > Do I need to send a new email with a new patch?

Yes. Also, please avoid top-posting.

For the new version, use versioning like "[PATCH v2]", which can be 
achieved using "git format-patch -1 -v2" for V2


-- 
Cheers,

David / dhildenb


