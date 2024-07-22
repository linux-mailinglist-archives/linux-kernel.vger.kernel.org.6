Return-Path: <linux-kernel+bounces-258722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92F938C22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BA281BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63E16B74D;
	Mon, 22 Jul 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flhU0mGp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9726ADB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640886; cv=none; b=EJIDYq5CQtQlXB3/2/h5ZQ+az/nZ89rLdEOQaG03YF51EVGh9O7aquh5Pd5LLlWTSz0y+bDNv3nOROuSTNUNApHjkR1aHzS3lr/FlTF53RY09bUhQnHsvuR1l9MwMSTBeiknR0FmmMPwvAjQ4qXMO4sEzujivv6iy/8dN1xzGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640886; c=relaxed/simple;
	bh=OQRaeMlPcv9n0Jmv5qRp52hta0vb6hNp7s5zqboxAlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXT38lCPDANCf88aVwYHKCrOoNFHmzFp64mJNtj2H/w2UA7T4ki/guWm+qu6bHqzSm+cr1QgXkAn1Ip0lhtU+zptod61sW3bqMzsFXPb6GlJCVAoaaeolCiRaeX59oJvl+oRhEy2/hepm2mudCZSUxKVh+U8ojUBxX+DAaOCpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flhU0mGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721640883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PIxkIT2TF/Ku+pkavCK9epuXbnsPwDtAKR6pZfQEoak=;
	b=flhU0mGpvNaheCv/7hYbhYWSI2xhwPrd/pxVJf9WDoJx23WZhJ4yiUpNzEWB4S6TaV7dk0
	w4LyvHdvs6KdDZdtRa5TSRo0rMarvxOHaOF7QW68Hh5OJzDt0dNQ2yylzKzCvpyPLebB/m
	SrMjCblJYCjWuPHrg5/e5J0F0jK5lGk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-vDJj2xxKMxGrbmjNwP5GNg-1; Mon, 22 Jul 2024 05:34:41 -0400
X-MC-Unique: vDJj2xxKMxGrbmjNwP5GNg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4279c75c44dso29666375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721640880; x=1722245680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIxkIT2TF/Ku+pkavCK9epuXbnsPwDtAKR6pZfQEoak=;
        b=m/u7jXRM7uaeQez2yZfddjkxz7L5Wyoej+AWJSq1ugSispiAUQVASN5mEe15pWhCpZ
         bBQXU+QoNwX7lJi8sBbbGiVE10oJuObP26r+kclppdPsKCo6JHsjgeeA2uKJUlX6AN1O
         hAv6E4uywG1xx61eeYpD/OAcz5pmF6q2GFo2PwKQ0x6/jDFWL3rDhuXLkTHXJrMntdeB
         8TPhVRIbFIa6uVifOmK83mnpLoBDpR5yqrM91JxM6wflSvVH5w5Gvpz2WCj9xJziTh6R
         r5od1nOehxXQB+ezrloiLFWepicXj9LNLCh6NHYqXIHI1suKTtN2FmtvcfkoOvIS4g+s
         7zfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoHB6MujEZgv/AOdvbmjQub1MmttRXvuwcRXA1uDibBXl68u+rHstIPtpdck8gmYXy9QNmq9jsYLnBjB3wk1qfL1U9CT9glXhGb/uT
X-Gm-Message-State: AOJu0YyVBSsZ1IPmWMBzwZLmUU4uxFzjZeKIgV+kt10NC9h+wSPwSrdz
	1wfSMqnPXcgLCFz7jgYT7owB/mAqSFVGMV/P7whFQnpIHNtoVy0EnFFHh1UrskA7bN4yuGQ9Gvy
	jKbp5+rKjljChluNOnKWQk9uIrGTrIp7pTdCHyTGVrZJLgE6UiBSYia84UawaFw==
X-Received: by 2002:a05:600c:500f:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-427df7a7828mr35456455e9.29.1721640880696;
        Mon, 22 Jul 2024 02:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz+NOJNgyDYoXsGDySiH4/9n/3dmzi5P2XkqaEVVcnOjq2B6MM+4hmGRpT7TiTrlP2jEfR/Q==
X-Received: by 2002:a05:600c:500f:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-427df7a7828mr35456295e9.29.1721640880309;
        Mon, 22 Jul 2024 02:34:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9? (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de. [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a947fasm146985145e9.43.2024.07.22.02.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 02:34:39 -0700 (PDT)
Message-ID: <e680918a-e25b-40c1-b181-9b0882a994b5@redhat.com>
Date: Mon, 22 Jul 2024 11:34:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
References: <20240722021059.1076399-1-lizhijian@fujitsu.com>
 <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
 <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e33a6c42-b7be-46a0-839e-736e8f61102f@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.24 11:15, Zhijian Li (Fujitsu) wrote:
> Hi David
> 
> Thanks for you quickly reply.

Heh, Vlasimil replied but I agree with his feedback :)

-- 
Cheers,

David / dhildenb


