Return-Path: <linux-kernel+bounces-296056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FC95A4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F351F2249E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF29166F02;
	Wed, 21 Aug 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCUxOkjC"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7314C596;
	Wed, 21 Aug 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267064; cv=none; b=Aj2RTkja4WskX9rd3IMbgEjKatOovCJCew7gYBVYyK9nPepqCc4k1AvmMFcO4BAXQSawCNzTuUBgB+2EulqZiM7cM+t4wgJ4GiBVdfgV9+dlcoANjrP1j9n3Nf5rh2vhIwk23pZwJZE9tWPEZidxir1KulAK7ByvT70lGDhfJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267064; c=relaxed/simple;
	bh=MWzes1/7Zp+t2YqEWvl59k4BEIMijUDPMacJ9+y8uhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PafFbsqQ/flG8rbMG76tzBha9akMcphmN5txIpI+WDS6wg7nM1DMfg3EiVn8KETA2YYy8tv8NYdeNYAStQ2/bryav8qKLS5UJRpu2U4M6dDw1trRECwOrLyh/j8kq8aGCKtAJZ59fuKaZQ7Nau+rnCjf4Odkwls8JRuG/nWwUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCUxOkjC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff398cefcso505701cf.0;
        Wed, 21 Aug 2024 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724267062; x=1724871862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlOwlk8hP9msr2v10zFYxMpLaznhCxWKuZOactnyfGw=;
        b=aCUxOkjCPvbpTKu20NDCWSXXihtISBqqmiBeRtVu699r7Y10hlNZxrEDTZtaN218U2
         m+OGVhFOvXAhV7MeioXdKzyatDKpuOHuMTAVI9zKmfhSZNhnQc//M2qUrSbbYbfISrUB
         1YrGeYtfMuOwR84PamAJMcLZnu/q2sRqsFSDXX+Y6FUCZPHyrvmBe6GYUb7Q4RTfYmpA
         HFD2cLckbFcxTJSp5zoIprB3MEHiJ8tS490jKd/1Y4LY80N+VKrNf2snD0Teu+8HZ2vE
         B3zzg3HRpR6HtI7FE9w692EFgAX55U9cogj17VMgqXvIl0gqlpZbELoAEkza8xikCMtg
         ugog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267062; x=1724871862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlOwlk8hP9msr2v10zFYxMpLaznhCxWKuZOactnyfGw=;
        b=iggd8KcUpT6M4SHFgWY6n7A5PJQtNI32YCGnYSjDII6KLJatKE3XgY7ENYUV0e5Klk
         EH1X5hVVDccRy6+hGj6XB2LztMFHyXH9qtotGEOScN0cpT/A2ommTEPBjeD+dNPdCQQN
         aO8N5qS4ZU0Hjpzm+HveyLezisBxwR4mUXyPydz6ztcGOqR9fPpsRhiB8COVsYUmyXyL
         2m9t4sWDBmBjBotfNtkON5GcXSMCY4E1GkOXtgz9aWLPW4LioJOUAI/kQ8JWX7WhVOrz
         jHPI9HNSFzY6FEsYzxizCsZv+Dh3Tcqz61b6P3lLqWgOa/FUTXyygGWu4KM/aAlb8P3J
         fIlw==
X-Forwarded-Encrypted: i=1; AJvYcCUHXP1If0zgE+f1OBdL9gRwAp0+gBETwR7wageu7TMWznYa2FOpGyqApGOBL+WkTtjfdW18l0KUOF0=@vger.kernel.org, AJvYcCXZLxSjfsIe+EG3uAiGgu9HQHqBNXIKnooLvLPsH7VTtHRtyaN3a9LwFjkF0nfarXc3vkdlVOO9I0+D3zBV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KDLBKEnBI6pUIfNnYQ0sk6vNb0R2niITEhf7vgZFineED7PO
	/iXsMR8qsteoneRkN/l/zSu4UY8KvDMP645KJaWoWnR+jg7WsuEp
X-Google-Smtp-Source: AGHT+IGgdIrW0miOc5mOoAB9vHOcOoYF2dK20gbT3T0c6Av9Pm0JfbuFlLgTi2ug4nvnskac1D0xAQ==
X-Received: by 2002:a05:622a:2619:b0:440:572f:391c with SMTP id d75a77b69052e-454f2215460mr35300741cf.24.1724267061738;
        Wed, 21 Aug 2024 12:04:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:d08d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff35c3sm62019671cf.33.2024.08.21.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 12:04:21 -0700 (PDT)
Message-ID: <5ed479c9-21eb-4bc8-8c17-79e1b6081355@gmail.com>
Date: Wed, 21 Aug 2024 15:04:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com>
 <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
 <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
 <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
 <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
 <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
 <CAGsJ_4y49c8-hDgjNuqMZnNWfUT-ktxeqkfX0EQz4-Pu3x9-Dg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4y49c8-hDgjNuqMZnNWfUT-ktxeqkfX0EQz4-Pu3x9-Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/08/2024 17:30, Barry Song wrote:

> Hi Usama,
> thanks! I can't judge if we need this partially_mapped flag. but if we
> need, the code
> looks correct to me. I'd like to leave this to David and other experts to ack.
> 

Thanks for the reviews!

> an alternative approach might be two lists? one for entirely_mapped,
> the other one
> for split_deferred. also seems ugly ?
> 

That was my very first prototype! I shifted to using a bool which I sent in v1, and then a bit in _flags_1 as David suggested. I believe a bit in _flags_1 is the best way forward, as it leaves the most space in folio for future work.

> On the other hand, when we want to extend your patchset to mTHP other than PMD-
> order, will the only deferred_list create huge lock contention while
> adding or removing
> folios from it?
> 

Yes, I would imagine so. the deferred_split_queue is per memcg/node, so that helps.

Also, this work is tied to khugepaged. So would need some thought when doing it for mTHP.

I would imagine doing underused shrinker for mTHP would be less beneficial compared to doing it for 2M THP. But probably needs experimentation.

Thanks



