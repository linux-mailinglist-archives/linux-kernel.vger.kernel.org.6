Return-Path: <linux-kernel+bounces-409875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A159C92C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CD2B297D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4A1AB528;
	Thu, 14 Nov 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YthmldjE"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F431A265B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614373; cv=none; b=qDciGSlFy6JmFlV8bXuuovGc1l+6iyX4AVam2Yd3w+j1Lh+fJJ0IKCDfdxCZXi81Fn12V/s8gb0ppQW4HE2uQQW0Byxf7Npx7o+M1cR/tGCr9pPlYaWPYFsNgabk6flXEs6rUUvcH0asDMGoLd9q9v0gXwbqlYllaTz1rIm6gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614373; c=relaxed/simple;
	bh=H287lDYthdc77qSw5Z5/Phmq0rtxNLmCcq1CkVNWHj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdPdLBrRhkKzzg9o8j8xfpmXxks9IvKqDrZRJgnH35mMfk+frGat0EkHscffUcB9KKj7NA/qA5YtKWO9Ae5KDdQzzujYAb0qEK7YqM53Tkh2+KLTLXU3UkfGN3LHhFGSEzGTdopRt4TjjM8zFLdOSUZgJr+8PltxUg89Pru2XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YthmldjE; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5edf76cd843so541389eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731614370; x=1732219170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkFjS2wPJFkqdQm4cnKrH9Ovi0c7v3pS/9u3vIqGMDM=;
        b=YthmldjE8fcn/KsTGQ1YDd2SXqNgZmzwg2dBUE4WaE5zizJ5eqVzSxjFa/QOCTn9Nl
         nM1AADWYnpr9+7x5NfO2tCxUQhsD8QRw2Vu5dfcEMht4GQon/29upkszLwQ1ifZswegL
         RVBN7hKXW9+OnAaVbM9qAezsfl09aqiNTVD0ejensa4phB1H2WJ5lfrhWCKrRblgQpQS
         RsyhzmmRO/veIUlZMaxnSJcwDmOdBX2X35ycJ5f8JnTq/PAhFl2L4fkEn22ECyXgtuDF
         35kldiYBRw+Lzh0rupQ23kNQ9YsT9ktU09v+zVSSUSLeaup1CvxnKHgjWLBxDVbIj0Vj
         /21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614370; x=1732219170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkFjS2wPJFkqdQm4cnKrH9Ovi0c7v3pS/9u3vIqGMDM=;
        b=aFQhsgD8tIrXDhDJn1UGYBocOpI1DgG3nSciaXAx2lMp7CTlVlczMsYyahz6mqWo/h
         he591yH7E3Ro6cdSBQ2Qg25S06Z2EFq7LSlHReWkrxkD59q6KbE0Zr2Wyr5EKKb59RrK
         v2eBbaNlHycf07E8hiR71wv58AaHUnfq+LwIrTB3VaUgFjZ+mtpW+vjmU2iLKz6RVfW0
         QCSueMW2lFKd0Bl8czhcFd2KebejmDbLsVjTbrqOtvhWGo67qne3tnrBLUrMSDf3vab0
         2rh38ObyRC8Tq90KWbbMyQF63Y4izqQXpxBfMitJvp/TNEcmeAGf5nA97WAFmtYRB/c0
         qdJA==
X-Forwarded-Encrypted: i=1; AJvYcCVi91EjXI7V6nkTz/ljFG++LQpiFJIblJvmKnUPiyCC/f0BZkd9jqTsB2EFR00y0v+sGpSlmjiQ6wOHxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkv/67O9qXGiVE/sT4eiH3Dtk2gc1KKhsMK7wddaII1tuDs9T
	1vM4Jfur52VRYh1fDkrFkg5kUhxkHifnQdKiQLZV74qK2jIuCWe9TnEEYI5fWbNdQ/3qJlIzJSO
	tRpE=
X-Google-Smtp-Source: AGHT+IGYhSYu010tZ5icXn0iop521N+VU/nDnRxmg9olvNYFuvdTUYp7rwb3W1+U+IQY2nDuJqyK5w==
X-Received: by 2002:a05:6820:3107:b0:5eb:8488:c80b with SMTP id 006d021491bc7-5eeab4d76a1mr159546eaf.6.1731614369724;
        Thu, 14 Nov 2024 11:59:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea0120029sm586318eaf.16.2024.11.14.11.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 11:59:28 -0800 (PST)
Message-ID: <4ee9df47-c84e-44ca-9ab6-f655bfda7481@kernel.dk>
Date: Thu, 14 Nov 2024 12:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add larger order folio instead of pages for
 passthrough I/O
To: Christoph Hellwig <hch@lst.de>, Chinmay Gameti <c.gameti@samsung.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com, kundan.kumar@samsung.com, gost.dev@samsung.com
References: <CGME20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410@epcas5p3.samsung.com>
 <20241114135335.21327-1-c.gameti@samsung.com> <20241114161744.GA2078@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114161744.GA2078@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 9:17 AM, Christoph Hellwig wrote:
>> @@ -313,21 +314,35 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>  		if (unlikely(offs & queue_dma_alignment(rq->q)))
>>  			j = 0;
>>  		else {
>> -			for (j = 0; j < npages; j++) {
>> +			for (j = 0; j < npages; j += num_pages) {
>>  				struct page *page = pages[j];
>> -				unsigned int n = PAGE_SIZE - offs;
>> +				struct folio *folio = page_folio(page);
>>  				bool same_page = false;
>>  
>> -				if (n > bytes)
>> -					n = bytes;
>>  
>> -				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
>> -						     max_sectors, &same_page))
>> +				folio_offset = ((size_t)folio_page_idx(folio,
>> +						page) << PAGE_SHIFT) + offs;
> 
> I'm not sure if Jens want to rush something like this in for 6.13, but if
> we're aiming for the next merge window I actually have a 3/4 done series
> that rips out bio_add_hw_page and all the passthrough special casing by
> simply running the 'do we need to split the bio' helper on the free-form
> bio and return an error if we do.  That means all this code will go away,
> and you'll automatically get all the work done for the normal path for
> passthrough as well.

I'd rather it simmer a bit first, so I'd say we have time since 6.13 is
coming up really soon.

-- 
Jens Axboe

