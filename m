Return-Path: <linux-kernel+bounces-444985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982319F0F83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B0A165609
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229ED1E1C26;
	Fri, 13 Dec 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kDvcqnxz"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD71E0B7F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101401; cv=none; b=MdZQ0qcbgWOwn06ke7cbmpZ+T5Ale/3B9n2qal/HmOdM+4P4jFyKiRc7NxhIXv+Yxey6BikmdQ0oupO8vDmRk/b437Spgq21Z+R17LD4PHDo6vlyP4tlWYG2b/fLTx6mQINl/IwtvNmFd2lkMF5oIAh8FipGnCVL8FIgVFnMzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101401; c=relaxed/simple;
	bh=5bPp8E+MpuFVxKboQhNt6/M7Z4iZDMHxwXj86tG/o2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulAr3PwJAfCUGqTG66pP59dEbq5n0pmyaqNVDKVOE14yzE32JlinwxoLD4CkyJ/ToLIFl3kwC+MxTqLGFONe1917umNTyzX7b+RHBoPs2M4bmWHU8oP4+WLN1FPXANqzEn8BUiZuhTIYv8o41PHwvrMpy6up9ORAb+FsYDQeqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kDvcqnxz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so136818839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734101398; x=1734706198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOWXs7WdzCpqTexnYKxKuVH/hJEpRnVT9ooHNt2C+JE=;
        b=kDvcqnxzdkJsgsK8mKEIz+2trfYuorJuxsVF+3028F4/MKSzbw2ojj6RAbix4nuapO
         5mZtXLK8gAxBC2nI5DwA4Rx/g8SmX6lGZrgA/GcbeYoR11kJcwJczS7SBF8xJzqPvKlG
         YTwXI4+1leAlZoMYwXxh6ijsE43lXKxkdBUe/v9eGEaDYQgxHMHQmI+/arTnLZE6g0R3
         M4SicChY3FDGIQ1y2pGOQXc59AUPEy96JQcLiM2JZDY8RuiRT5vVHhhQ2wcuuvqG/h8p
         SAxL/ofquxNyIQezn8fsMuwbYn1nQVPhkJ+zbPpLyeiRdH4khSDfe2RBNyvjRQ/QB/1h
         rkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101398; x=1734706198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOWXs7WdzCpqTexnYKxKuVH/hJEpRnVT9ooHNt2C+JE=;
        b=q4JqyWlV4BwTyUTTaXTGIs5GFG1Afy6UCkAMjpLbsUdCudUo4taRR6+qnX7hgMFTNp
         tDCZLf9kSQ+T67KnJkiSwppWC2VLrqt8vnOBDgSLcONxWYi/t18138WrNceJXfnci0Z7
         GG8FsxXE/ZItXTFcHmummYq2vYIQz8ASdVcP7XJNEkI/rl9wFYE1ejlRo2Rl/ShR6aof
         UBjlKbVzudffmjzlM13EzqPUNpX/V+ls72cZ+Ks7985OI/PCiHIKLzynB66XsoUfhoNP
         RzufcqXCYxLUg5Jur4zpyyGgeflHqeyKMh54Msf74I1mBQQUz7ZVLvMCvoauJPkFnNA6
         yKmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKAOK9EaBMMxad20giHgyaU+BNDfO9NlKZgx019TmnHApVA8EkWxwQXP7rVTs/VoluWEnvNmvlf9KlReg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxovtgZYznmRA3fOq/smiNAJQksQHHBQsJfUV/ShElJye9T1X1E
	PM7U7gSSjbNSSbQRet+DcBwdj1iG3g7g31PZVcciK3BWWHB1nKselpIm85w4I7s=
X-Gm-Gg: ASbGncumr4RREz/VKsjOTRzarAb5bTvQyjR4ep2SOc6lBVMMqFhbVw6n12LO5MdnNgG
	fXEWVnKwnvD45dhb0LtZDQ3l4g30yCjxQ+In7xs25CpozvzIWKm+J04eU9Rj8YunRKpmdfJWuSi
	RLSJqzbL+ktsKbRuMsr8mA+U/AJwsBst4laI5aCIUSVeTKei65Ed491EbRqaQI3PPk6r13txs6I
	uHaPEWBqUpWxr2yXMMntdhdMzbWzKebfu3qlPgQTzWyLVsI7r3a
X-Google-Smtp-Source: AGHT+IGsjDcO7D5hn5oYhsVNjMXWk3wpIBqgOl1uenYRJsHT0MAGmNQD50mPAs2+sstojpGB6TLDNA==
X-Received: by 2002:a05:6602:15ca:b0:841:a9d3:3b39 with SMTP id ca18e2360f4ac-844e87ed998mr438455939f.5.1734101398302;
        Fri, 13 Dec 2024 06:49:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ca9c3f89sm2154129173.0.2024.12.13.06.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:49:57 -0800 (PST)
Message-ID: <3c85accb-69cd-46c2-bfb5-1074cedfeccd@kernel.dk>
Date: Fri, 13 Dec 2024 07:49:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
 <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
 <Z1s7AGxZKhK1V4qv@casper.infradead.org> <20241213050410.GA7054@cmpxchg.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241213050410.GA7054@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 10:04 PM, Johannes Weiner wrote:
> On Thu, Dec 12, 2024 at 07:35:28PM +0000, Matthew Wilcox wrote:
>> On Thu, Dec 12, 2024 at 12:14:23PM -0700, Jens Axboe wrote:
>>> Like I mentioned earlier, the fact that it's cached for the duration of
>>> the operation is more of an implementation detail that developers need
>>> not worry about. What's important is that it's not cached AFTER. I still
>>> feel UNCACHED is the best description, but I'll change it to DONTCACHE
>>> for the next version just to avoid the overlap with other in-kernel
>>> uses.
>>
>> Regardless of the user API name, I like PG_streaming for the folio
>> flag name.
> 
> If we're throwing names in the ring, I'm partial to PG_dropbehind.
> 
> It's a term I think has been used to describe this type of behavior
> before; it juxtaposes nicely with readahead; it plainly names the
> action of what will happen to the page after the current IO operation
> against it has completed (i.e. pairs up with PG_reclaim).

True, I do think that's a good name for the folio flag. streaming isn't
bad, but it's not fully descriptive as the IO may not be streaming at
all, depending on the use case. I do remember when we used dropbehind
naming in the vm, probably 20 some years ago?

If there are no objections to this, I'll change the folio flag to
dropbehind. Also looks nicer with the bit operations on the folio, when
you have:

if (flags & RWF_DONTCACHE)
	folio_set_dropbehind(folio);

rather than:

if (flags & RWF_DONTCACHE)
	folio_set_streaming(folio);

and so forth, as the former just intuitively makes sense.

-- 
Jens Axboe

