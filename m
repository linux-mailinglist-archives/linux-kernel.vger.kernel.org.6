Return-Path: <linux-kernel+bounces-437830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F189E994E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B05162551
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5F1BEF95;
	Mon,  9 Dec 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKx5m0S4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C41B042A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755582; cv=none; b=GYyV8CxJftbaEeGilgorDIyHiFDDwoQfq7rwsJuhLIkHKVVoOIuUiEQpFcbflAKwuuqmEOy1jvEJNczUKOlI02KE+WPSp7UyXWhGWfNsiEWAudDnILTKr0WnctiOCkbSMKQJLSt13ld3P6+CxuUPEhmJjMws4YKJgIoHXz+7mcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755582; c=relaxed/simple;
	bh=jMxAFVMnGAQPLKMOmGNmLSjbzP+BQHuzViq38Tz1Hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Axt3NJ4yWvrpc74kB3RuC+vZ4xh8VguR7F142uzYne++X8iYKJRe3udlPlT3GpaYx6XkB1npn1rQgu7LCuaRzbWL51/zR9INyWElnbYmwncemhOog2UuNwkRTgJ6WJBaupn+ypWoWx+/HqH+qoc/+ELApo7tNRdxMUp4l8Z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKx5m0S4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1oTVwgyT1vrg2qoxh3tmhZlAJlYTIeB9WpByoV0XmeM=;
	b=MKx5m0S4+QgaIxiFxUfrl2UMXaDGQlqWBNMiNh4Ikn5qrAF4HOv0PzvzmPL19BdNdBFIrY
	VmwCkzi55NcvIQYkXi2O+W39wqrshkmvt5aXqasGinkHz9K7MrzPMgW0MWvcg5wVXQfKiR
	DVIwEitIvB8FjtqM37wJjqgVv/sCV80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Fyt1GYqSMD62pDXEj2feqQ-1; Mon, 09 Dec 2024 09:46:18 -0500
X-MC-Unique: Fyt1GYqSMD62pDXEj2feqQ-1
X-Mimecast-MFC-AGG-ID: Fyt1GYqSMD62pDXEj2feqQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f4e9b73dso11036825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755576; x=1734360376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1oTVwgyT1vrg2qoxh3tmhZlAJlYTIeB9WpByoV0XmeM=;
        b=TIo498woGASqg8lxQSI5Tul+QRo03bHZEk6Jq1KzvXU1o5sR6kRDZBSQ6C9jaUnWfS
         dInod7HoQ2aQwA/7ItZxhKTntVu1t8u2T3M7xC31CTGSibhEpo5SRTqX3QdOpfKaCCgQ
         9kO+fkQH3QY0k319wuEh5GNDERntttzgKFjVzDse5167hGl3ZzwA+7T/fw8otFCwlEAO
         dR0unMhMeNkTwv4dMk41MxHcyrLAXfNzksL3tZ4fTHaszgme8orMoiOuTNfyibU0VDqA
         EJQJ9Nm8oj4YMAMKLaE+OvIRN6Iq39ndiptV5D3HDtda7OFxnXcbrnQPi7ixlyCp33sF
         MoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU65Fchd1ZTuVGDiErT9dR1uP2FUQlQ4yBpumwG6dC0ZSpT5bUIXfwYZEiprL4ZxpYDJKDpP3rMAbDHHt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxt95PujT3kq4nvvGbeQHpZN6NSIllUy4DMt08Byw5TPs6qgoL
	VZNxoqA7f6HzlbHjNivaTt+dJ6BuFc4Cg6YUr67KXI0lZQnADobfeiX7J4y6n+n8c1FQZfGazX5
	wmQsmES9h8D91/PfeXoUM/6BEh+ASTkL38Og6YW+3iC1PdS9rQ8UjQdQpQjrl2g==
X-Gm-Gg: ASbGncuRa/QigcsBrV7vsdMORRMgJSXkDqRC1+fP3LtYNT5jRc8fFJtFwSEKDWFNdL4
	/MJyz2LiNBieKTtAVTBZ0gl4uRwV1qxcglP48VQL8KZfquamZEAWIDNSFt75lSs4XP+4nyy2/Wn
	/uYS1xlt0EWZaJH/5QyQ9XLV8E3+9q8SFQZT2ZEefOWWOultpkVUrbZSKgRj0YuzM7KcEiQZzxP
	JpPkwGfzuDIaGtdDL9XTfEW85q6cuU0CzdxHSum5tXb8WNW/Iing/mYlaRxi3EJzOM2JZu0dby9
	py1QtjMP
X-Received: by 2002:a05:6000:1846:b0:385:e0d6:fb6e with SMTP id ffacd0b85a97d-3862b3d0a4amr10494505f8f.37.1733755576177;
        Mon, 09 Dec 2024 06:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHERhLEGcrQflDYoAfqN4JlTNdUC2cS7xApvTw6znkncMbQBC9wCcixe+iyRMtiqLVqCskS3A==
X-Received: by 2002:a05:6000:1846:b0:385:e0d6:fb6e with SMTP id ffacd0b85a97d-3862b3d0a4amr10494485f8f.37.1733755575827;
        Mon, 09 Dec 2024 06:46:15 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4087sm13575665f8f.5.2024.12.09.06.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:46:15 -0800 (PST)
Message-ID: <eedb527e-34f6-4982-a258-cc27db933371@redhat.com>
Date: Mon, 9 Dec 2024 15:46:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in
 page_ref_add_unless
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241207082931.1707465-1-mjguzik@gmail.com>
 <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
 <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
 <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com>
 <CAGudoHFLTet0ZpOkDMFBh0yBDhJ47st-aRrCLZojdrCgQKznUQ@mail.gmail.com>
 <f5a65bf5-5105-4376-9c1c-164a15a4ab79@redhat.com>
 <CAGudoHGUwS_zY1KWStMtKoy=eogLigy7ucpEQXzTZGANU=35Jw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGudoHGUwS_zY1KWStMtKoy=eogLigy7ucpEQXzTZGANU=35Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.12.24 15:30, Mateusz Guzik wrote:
> On Mon, Dec 9, 2024 at 3:22 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.12.24 13:33, Mateusz Guzik wrote:
>>> That is to say I think this thread just about exhausted the time
>>> warranted by this patch. No hard feelz if it gets dropped, but then I
>>> do strongly suggest adding a justification to the extra load.
>>
>> Maybe it's sufficient for now to simply do your change with a comment:
>>
>> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
>> index 8c236c651d1d6..1efc992ad5687 100644
>> --- a/include/linux/page_ref.h
>> +++ b/include/linux/page_ref.h
>> @@ -234,7 +234,13 @@ static inline bool page_ref_add_unless(struct page *page, int nr, int u)
>>
>>           rcu_read_lock();
>>           /* avoid writing to the vmemmap area being remapped */
>> -       if (!page_is_fake_head(page) && page_ref_count(page) != u)
>> +       if (!page_is_fake_head(page))
>> +               /*
>> +                * atomic_add_unless() will currently never modify the value
>> +                * if it already is u. If that ever changes, we'd have to have
>> +                * a separate check here, such that we won't be writing to
>> +                * write-protected vmemmap areas.
>> +                */
>>                   ret = atomic_add_unless(&page->_refcount, nr, u);
>>           rcu_read_unlock();
>>
>>
>> It would bail out during testing ... hopefully, such that we can detect any such change.
>>
> 
> Not my call to make, but looks good. ;)
> 
> fwiw I don't need any credit and I would be more than happy if you
> just submitted the thing as your own without me being mentioned. *No*
> cc would also be appreciated.

Likely Andrew can add the comment as a fixup.

-- 
Cheers,

David / dhildenb


