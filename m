Return-Path: <linux-kernel+bounces-531902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA17A44681
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226A7172440
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6557F1624DA;
	Tue, 25 Feb 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X70Fbqhc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7C19A28D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501493; cv=none; b=eoU1SPuU+kd3pryf7EV4hKOc1Kezg1fu2+b6f67gWUjsZ97sdH7q1SIU6sV5eUuIrnVopRSihKyUtLgP1EOlxdYth/PZEUn1RYXc5jGYqY1lv1UoATxFQ4ttxUDMaaLz60EIkNXgJfaKTaeLjCDFZPOtz1eNJGBFcc3Vkg6OyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501493; c=relaxed/simple;
	bh=ffqXUVO4r2Rd42jh6DWGeVqd33e+qddFH3kH1x24sA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6JmccVMFKIacnS3f9rt4uxlVKhwgjpg3P8MtHVM0hFydhvzdw2rJSnwwHaMLfoMLEYdNgfzuOx9cjJJ97ssayZkb9xAKEj/uUeP19/FasK9HUjVJ8cnQiCq2/WR6O0IYpy3manDNx5bTEmbo9GXO1MyANG4Fm4H/YogUZAXexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X70Fbqhc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=deHG3kMqc4H+yY3J+VmhJp18IRiomtpSS2OVfJI4Mrw=;
	b=X70FbqhcO3locN/J4fR+/pYdQODptwl2ehsBMyFzwvXp9JunGhPP32tQIxL+Wkh6lOTQ5h
	eAqBt4j6iDscjjzyPlLk3UlKOxMaB7x691r8pqUYwYbJFSTp9LjgKzeHWJqjaeA1D5Pb2u
	r70VnIMdT4Cj1rtEs8VY7jYUMpIxs1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-PQ3ewo2NOZSCfW4PZDzxqg-1; Tue, 25 Feb 2025 11:38:09 -0500
X-MC-Unique: PQ3ewo2NOZSCfW4PZDzxqg-1
X-Mimecast-MFC-AGG-ID: PQ3ewo2NOZSCfW4PZDzxqg_1740501488
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947a0919aso55231845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501488; x=1741106288;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=deHG3kMqc4H+yY3J+VmhJp18IRiomtpSS2OVfJI4Mrw=;
        b=s6/RyJpdyfx6Yj8z+q2D0sWo0aUHfYWmAmCIbYuX6xUVeqKtL7AHfVI1FTwxRyHoFA
         9GVKJFhje2Ts9HjKfDVsj1Hbz0DPNa0kdpw3roZal/zfKXXehyuXsyTnlSZYTF05RwsX
         mH1Qkg+gU13x1aXsR4hWKwAeggJihiy0T9yiu1glveb+OtHFy7C7wUT2QeJXBh9p4l/+
         UOVVgRW4lv+e+MwDltLQpEiNxUiU9/5fA/H8AqVRB1Al4nPz+IFNKCLyEaNQGcLXylx3
         jGyAERIw+YOLFdQQVQ6TqEZ61wGhH9ds7XZRy4Pb7xEg5XyERvzv354q1GIpTdmiUMeS
         xZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6BVgtjTBeE8OjdzDhCj3v8YTTgY0RNIEx+f6PJTi9Gx07toftWiaIoGC/HC48n2qRbYWR3+jEkdA65M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/jClg4KBtiTJck9wSD7ssvxyuCko6t9c39by770/Xe0ma2l0
	Huz9bGSxefA/FCLk2CUqzuHTuof1fUufQY66RmOA/5Oi7tivFlyAAAEx+kc6PyrHzTYUj8Houwt
	8RcINmDWjp9Ep1JNXGaJP76rr0Do0p2EM729ThXAy5RHQD7lOfq4HF5X7gidtaQ==
X-Gm-Gg: ASbGnct5HSQgh+NaPjJmrfVByTS2xrJBPunZQI5qeqmMwjPRr5s5sthAzBpVyTo0ZTQ
	KUUpxt8wjhHvGJj7LOPDz+oQWYInRJDwSpWhbfK5muG1UXAbrE+HAuB6n2VwzeW+h09XR3cA800
	nS7mJBMZREU2IyEgLtltNnMV4mK1tjPne7/YiK/u1DPot3f4WxDnegoy41I1tSOxIGVJyvbAlsJ
	Lhr3Ndzlmh7NLq4l+P3HHb3Wi+Eti+MVJhENXtLBSrOnagTUzxSUl2DCjfAMyAUH6Ysn/+HnIQ2
	KYeD8RIvZrIZmWOpVkOJFraVQHudA1kAa/ym6zw2Fbpi24pYOUZCqcV6lNYTEkKq1k+tu4pENlm
	gyV/EJ1oFwXbvhna9dbUR+7BWxYXftOLvXthnUNrkaMQ=
X-Received: by 2002:a05:600c:3114:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43ab0f255a3mr46306445e9.5.1740501488304;
        Tue, 25 Feb 2025 08:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbswXdzscRbkD7zoGe8jnXtMfHylGoBuMvn2dyPISdvs79CV5Ni259ksaKK8Uy0oi/po9mYw==
X-Received: by 2002:a05:600c:3114:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43ab0f255a3mr46306135e9.5.1740501487978;
        Tue, 25 Feb 2025 08:38:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155eba2sm33154155e9.27.2025.02.25.08.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:38:07 -0800 (PST)
Message-ID: <6b9f6679-8655-44cb-8a0a-16d4032a89bc@redhat.com>
Date: Tue, 25 Feb 2025 17:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: page_ext: make lookup_page_ext() public
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <fb46436ec9ef892b6f40b9e48d40237b9855ac16.1740434344.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fb46436ec9ef892b6f40b9e48d40237b9855ac16.1740434344.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:59, Luiz Capitulino wrote:
> The next commit will use it.

This should likely be squashed into the next patch, where people also 
have the context why this is required.


-- 
Cheers,

David / dhildenb


