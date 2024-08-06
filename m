Return-Path: <linux-kernel+bounces-275923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B2948BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D9E28693E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B021BD50A;
	Tue,  6 Aug 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTKPC9SB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BF1B9B4E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935580; cv=none; b=j3fe5lL/SLRgfFuqABBbT0cUPhLxep5svXsWPq+9qKolXFOMI77rc7AXmaLRCalQ1RGHjuw5aZXquwEanR/9+NYuIqjo29eGo7vbuafy2KBbjxU8PtbWtNRlZqiX7Zf2K8x+vZoERCxjlFHC3J6wQMW/fDvh7Php/ep69PNHB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935580; c=relaxed/simple;
	bh=zq7kFPN0uTZZCcpqckGUq70FPm3c5WOpLEYGVbF4eb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADs9EvOWY9G2Xqvum2i8cCjND3t3gCh1Y3Zi4CQae7AtLQspi7Bhgrg/B5a52KvL1fbDoq9LROvqWpRwULHPx1eH0dc5YgABxN4wwzTXAnsZh5a0jbP2f20bQ0KuEkSuLVQsB0SXiQQ44kfWVuoci/69zT5IIVONN2z0fG6OECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTKPC9SB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722935577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/lfJgrSWKWbjRxr+WslEUzWg5lU4B6E1b6f6UsWxKzQ=;
	b=KTKPC9SBIGNZvhwU9AabnVuFJz/+v5Civ2dPa7LJJLl5aux5T2iunm9JuXmI1f06jwtfGd
	I7G0ZKI6rBvy0lV09cna1AFbj5cGNyvlOWp4i/3iziDedUEOydJE0srUGKvd6HkbjqwPFM
	l5HqO3JZjWtvWxQfUSR3nPRxYl+0hcg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-qg_Nh9pWMeKPVfkeZ5hlCg-1; Tue, 06 Aug 2024 05:12:54 -0400
X-MC-Unique: qg_Nh9pWMeKPVfkeZ5hlCg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281f8994adso3096515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722935573; x=1723540373;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lfJgrSWKWbjRxr+WslEUzWg5lU4B6E1b6f6UsWxKzQ=;
        b=QZsxcJnmkF9xN4mM4Twgj5X4pgVGc+Rwko4AuaMtmB2kPFkG6JGmXKBRBUMIOZ5aSH
         qWTAYwx43YQ5AaOLsyiBVf3NE5vFuiYCZ0Uqdw4YTYDSmEWLTSlfMSsL0bQEsf8Zu4i+
         fDlh93qMhBXYa/qAJFmbm+fWe4tAdZNt0LW6aR8gtE4v2ie73s2XyYh2tmaX8LCiI3eS
         i3NpZgQx/Elyoiio5LTDWL12pyYrU3sGaqZCgvYBU2TfN+i7JR/8aMqdbCU3fWx9TpmZ
         4Tr5URg8ZAPkyg73vWsAs/gqgZE3yjXEKMRiop80Bl4Jr+oCdpQwEpBcBbEhAqlyw7fQ
         Kq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0Z4iTt9r6mJlLmSsD1ipfZDorIQkoQYUq21cIoN5dOrAg3B1YeJju+JoQpIq/DhtRQxcft/+EoQmUj2kWdzGIk5vimyLzyFPt6YPs
X-Gm-Message-State: AOJu0YytxUO1C/MUYbbDPeVz6XqF8aQyiuX3mvAFwsf3Alb9rcJZu34L
	9k+ZZSp0Yk5x6l+arzhBSK00sEqKsZWWLbs+xW9YS5Ic/9cYIy3WzWUMMHAI2uPqtYF8m/NHg/h
	MsLBfXuSClp8Z8AQdyDCV8+ywn/7KIj8ZMd2enwKfAd0qRv8+6oaGsEe9VAJHng==
X-Received: by 2002:a05:600c:3b92:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-428e6f88ab5mr108831115e9.1.1722935573121;
        Tue, 06 Aug 2024 02:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz4CyfbAAZQkhoC1wgEvzKNF6Rx7SFbNIZonf/EA7Io7uTPUsj76yKnyL8N6vgx9G44W9/9g==
X-Received: by 2002:a05:600c:3b92:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-428e6f88ab5mr108830885e9.1.1722935572584;
        Tue, 06 Aug 2024 02:12:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01619csm12403076f8f.36.2024.08.06.02.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 02:12:52 -0700 (PDT)
Message-ID: <04bff7a7-3901-4adc-9f6a-466627cc1a21@redhat.com>
Date: Tue, 6 Aug 2024 11:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] arm64: use IPIs to pause/resume remote CPUs
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>,
 Douglas Anderson <dianders@chromium.org>,
 Frank van der Linden <fvdl@google.com>, Mark Rutland <mark.rutland@arm.com>,
 Muchun Song <muchun.song@linux.dev>, Nanyong Sun <sunnanyong@huawei.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240806022114.3320543-1-yuzhao@google.com>
 <20240806022114.3320543-3-yuzhao@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806022114.3320543-3-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

> +
> +void resume_remote_cpus(void)
> +{
> +	cpumask_t cpus_to_resume;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_preemption_disabled();
> +
> +	cpumask_copy(&cpus_to_resume, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &cpus_to_resume);
> +
> +	spin_lock(&cpu_pause_lock);
> +
> +	cpumask_setall(&resumed_cpus);
> +	/* A typical example for sleep and wake-up functions. */
> +	smp_mb();
> +	while (cpumask_intersects(&cpus_to_resume, &paused_cpus)) {
> +		sev();
> +		cpu_relax();
> +		barrier();
> +	}
>

I'm curious, is there a fundamental reason why we wait for paused CPUs 
to actually start running, or is it simply easier to get the 
implementation race-free, in particular when we have two 
pause_remote_cpus() calls shortly after each other and another remote 
CPU might still be on its way out of pause_local_cpu() from the first pause.

-- 
Cheers,

David / dhildenb


