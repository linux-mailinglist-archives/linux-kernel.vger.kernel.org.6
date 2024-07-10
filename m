Return-Path: <linux-kernel+bounces-246923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03A92C8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B78B215A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538821A28D;
	Wed, 10 Jul 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnJXQTpQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B62B9BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580965; cv=none; b=YX9c93JOd9TgWNnZ9FI/jXtTOCIVIwLFEI73HAG76mkLEVxji6hLosm1PlVv8xxBgM/2xwwBAUj+N875vz42bMSsR0JUSqADcZJ3MzH86D1IR4umftcGgcdzLGZKatN1flp7b6+2lsA3Pc+FN70jMYjRDtB4Zgs5oyGqaBROO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580965; c=relaxed/simple;
	bh=26gBruSBpeCgUF9Sm8+oWOZwNiq1eIfUddKRhgNrBWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwq80ZCK99O1q2Ro4dhAYZvP2tXicojEUF6YSg1n1QQXXAfUUoFFA762fIt6LBsnS3fyrHnxEtz9a+VfYUxUZTYf4p4JFmcrbjMK6HtnbRQijhQvzn2DTI8PryOPJ/jOhnqY6a/HP4QjW+jZpegHC4cbv5RriSwlsrQVe8dV++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnJXQTpQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720580962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bv2xFwWZiqYfC7hgVNeDQEU5j+2mV1NWeIy7UmxfeZM=;
	b=bnJXQTpQuc9lBnTQkecz8uWAHA1hEgLwdTIHzYg/xrS0cOckR1xy0ExfktBnopOrxYlyj5
	Hs9DzZb9t68wpVxKB2Hzcs4EFI98T9XZ38jI5LpjxyssJ4djhb7503Bjf62GpVB+LmnKC9
	i410RAryWd+BFD1c+OzVK+TjcNZpfso=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-URnYZhAaOAWUo1YhyDG_qQ-1; Tue, 09 Jul 2024 23:09:20 -0400
X-MC-Unique: URnYZhAaOAWUo1YhyDG_qQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70af524f6b9so3765664b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580959; x=1721185759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv2xFwWZiqYfC7hgVNeDQEU5j+2mV1NWeIy7UmxfeZM=;
        b=IwCngzGPvGi58TuP+gqhTfKMQkYR1Mjp2BF2xmyRrcAsHGQVskp6H+2NLV3H+gA8EE
         n7nGcrHELjJGu33ijIeoyZm2pXkFwwthlpdkxWoZXmIHP7Y2SCtkiTQ7aIPAO2hUtZxV
         kUCchzyzC8V3mc9DURAyzcROKRGez7dbX4+8GPL7gD9O6CDvtXVLVq3Ni4bUa7fAO5lt
         FOWKLDqERDmO8AqH79+uT9cxZj4cgTtDq4JOfXjsaCT8dMIceXNrQ4gnjpwi/q89W5XN
         ZCnIwrqzx6w2I6ft2nrE9Drov/rR41ZwiN+6FVhwnH/bLIWNRirpP3byskQ2L+kylDwt
         D8OA==
X-Gm-Message-State: AOJu0Yzkty8ZNNE+I5A8jgZ3ET4r5T5xILoyx+1sT1hzkKmW+cZ3kMMg
	jaLXVlN2NUvEKcocqWMF78bGGprdKViAqOrx+cfGq/qZYUXyy1u7aU9xQ1H8rq02e7qybbH4JAH
	Y+OFnJ0fV04Up4SIFq4W877ZHyNV4JLW+Efi5zhB8NjTRtxbYbqZQXVfBRVO4aw==
X-Received: by 2002:a05:6a00:198c:b0:70a:9fea:71a2 with SMTP id d2e1a72fcca58-70b4353b11amr5378841b3a.9.1720580959417;
        Tue, 09 Jul 2024 20:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxs+osbLpy1vst4qqJsgwR4NxW2BZOW+RzXxsXpImVu1ySUmFPpVlWaGS9VapnyTIeKZNWFg==
X-Received: by 2002:a05:6a00:198c:b0:70a:9fea:71a2 with SMTP id d2e1a72fcca58-70b4353b11amr5378818b3a.9.1720580958873;
        Tue, 09 Jul 2024 20:09:18 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439673d3sm2574244b3a.130.2024.07.09.20.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:09:18 -0700 (PDT)
Message-ID: <df74b121-c0fd-41e1-b42f-64dd73ace352@redhat.com>
Date: Wed, 10 Jul 2024 05:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-balloon: make it spec compliant
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <cover.1720173841.git.mst@redhat.com>
 <dc0a5a70-d691-4d54-ae00-0beb74f4c399@redhat.com>
 <20240705061647-mutt-send-email-mst@kernel.org>
 <77ba077a-a7a0-49b0-b14a-954cb24901e6@redhat.com>
 <20240705073122-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240705073122-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late reply!

>> I understand that concern, IIUC it would imply that:
>>
>> a) In case of a hypervisor, we never ran with a Linux guest
>> b) In case of a guest, we never ran under QEMU
> 
> Or maybe VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.

Right, in which case it would be according to the spec.

>> It's certainly possible, although I would assume that most other
>> implementation candidates (e.g., cloud-hypervisor) would have complained by
>> now about Linux issues.
> 
> They either set VIRTIO_BALLOON_F_FREE_PAGE_HINT or followed linux bug to
> work around.

Okay, in the latter case it would be the unofficial way of doing it.

>> What's your experience: if someone would actually implement it according to
>> the spec, would they watch out on the virtio mailing lists for changes (or
>> even be able to vote) and would be able to comment that adjusting the spec
>> to the real first implementation is wrong?
> 
> Unfortunately my experience is that it's not that likely :(

That's what I thought, unfortunately.

> 
> 
> Whatever we do, we need to take existing setups into account.
> 
> How would we do it in the spec without breaking working setups?  I guess
> we could say that both behaviours are legal.  That would still mean we
> need the qemu and linux patches, right?

That makes sense to me. Let me take a look at the patches.

-- 
Cheers,

David / dhildenb


