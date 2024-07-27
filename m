Return-Path: <linux-kernel+bounces-264206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4793E02E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0601F212EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570918562A;
	Sat, 27 Jul 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lyA3PFmd"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D295579F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098194; cv=none; b=LVI66CMSNsP3M9D243ZmJOlzyoho4XIZmH0kOC5sqYyWXTEXVT5I810Q73v/VcQYw5/cEx141VPp4D4t9GHSH1WOQYe+V4mNW1TDP806E6BAvk5sCqYBGAc0NfXBaJUPHx5tGWYWMirrSR1Pbkqteo99qy4fIEtLInd1sTQml2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098194; c=relaxed/simple;
	bh=1O13lm5woVEqKb7absRUzWS0sv8haRllHjDoPepZuTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZaj2tRWX3cB3dLIv/g69Wk3hQ7lEIOZ9OsBQf0iImigl7o4QEk5/6dELDMLUs/+YQiJxiEvHTWEu7RDajGsjZP56qe6Elqwp1ujGbCJyUXeTa6yETYT16hCF4xiQumQSA1Fw7WutYaRRe7gAH5/BS11Oe5ThXOM/0LCD+XvFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lyA3PFmd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2c0ee69fso147382b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722098193; x=1722702993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxkmnElLQNAUxcM/BklF2G68AwDNEOmWYd3cOJQHM1E=;
        b=lyA3PFmdz9YhTiUtyYRMAISaKe3aYH/vWsDkGZbL6xgvvK03/oZa9fvgiNqP8QVXVk
         ajVg78EIubS9j3YQ12yEfSSX8ZfaYuDAqH76zcKZliw2m2Gw+n36aCKNuu2DCQBCM9kb
         Vn3MHb6KNAOiS7KJSXfvTdbBVTSMssUgC/fjZDYaIs7+mW2jffO8uTwFLMXnYAHTojuK
         /YVaGXQeQKgnGpcCf5ROCn90S2UbahUs68AMxP/D0IEEt0WO8NkCulcnHMEWaiNxIg2g
         lDePbj/JSpJKgGkdH4aFaTDuebUUy9ldBV1o1uVVdQONt8XZ7S+6w4ksb+k+bTPDOh+K
         cYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722098193; x=1722702993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxkmnElLQNAUxcM/BklF2G68AwDNEOmWYd3cOJQHM1E=;
        b=IWeT0QuWFjnpSDO9FafFiwBZCdSLAHfctpiH7ItaAkJElJ1z7D5aiXyvhBkHm/iqB4
         kLd8cXBei4mLXLVVWG0yd7PjG74fNwMK8FZNObcEwe7Y/XZedNnY7jWwKLdEK0FqzBfL
         KTkwUC8hJLp7FKfvDp9GUg2SrNJblFCEKzY5gCdj6dhU2ahruUE0jI2d59PmuwGg8M+Q
         vMuzwkb+Gr5O5DBzPR/pyr8aifoXy1qijGZNFJ0OCfpjfq5YaWAC9vPgk5+LNkpOYED9
         ufYYOsWI6D4Qt2dBI7q8A1pKdvbweMtpiBUk/atEmS0Kwocfnv1S9OXKJby4K34FJ3iX
         8LFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkmrVWIp+CgLE60UmblEBUizM0sZFQ7xff3ZHx+Nyr6Wwsgye199HYv3HBe4MOQvF1DfwTXQn3UM7EWdqX+PpAieuhvuluTfkM2179
X-Gm-Message-State: AOJu0YzQwX7kV9DmjSoCIyEWhyj307fc1XbZAwJsewL+7YdzBZpA9YhU
	cO8dXCIF/xWCO9dvHOrCPA81HV4PkunNE9/N3sn/BlQLCBwJOYK8V3oyPMYeMKA=
X-Google-Smtp-Source: AGHT+IExI3R0n0QHE0jtAqL/Yk9xbr0ZwA+xrUYiD53HeD7oHnBP+YhFXxSn3WWhyJHf/YtMIkYrMA==
X-Received: by 2002:a05:6a00:8596:b0:70e:a06f:7057 with SMTP id d2e1a72fcca58-70eaca93f4amr6442119b3a.4.1722098192618;
        Sat, 27 Jul 2024 09:36:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f836c845sm4614192a12.37.2024.07.27.09.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 09:36:32 -0700 (PDT)
Message-ID: <0c5b8177-3602-4840-8956-6196a6175c04@kernel.dk>
Date: Sat, 27 Jul 2024 10:36:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
 <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 10:31 AM, Lorenzo Stoakes wrote:
> On Sat, Jul 27, 2024 at 09:38:54AM GMT, Jens Axboe wrote:
>> On 7/27/24 9:30 AM, Jens Axboe wrote:
>>> On 7/26/24 4:48 PM, Linus Torvalds wrote:
>>>> I didn't even look at what the issue was with the
>>>> bio_for_each_segment() expansion, in the hope that Jens will make that
>>>> one look better.
>>>
>>> I did take a quick look, pretty obviously bvec_iter_bvec() which makes
>>> it horrible, which came from Kent's immutable work quite a while ago.
>>> Not sure yet what to do about it, will spend some time on this next
>>> week.
>>
>> Maybe something like this, totally untested...
>>
>> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
>> index f41c7f0ef91e..9ccccddadde2 100644
>> --- a/include/linux/bvec.h
>> +++ b/include/linux/bvec.h
>> @@ -130,12 +130,15 @@ struct bvec_iter_all {
>>  	(mp_bvec_iter_page((bvec), (iter)) +			\
>>  	 mp_bvec_iter_page_idx((bvec), (iter)))
>>
>> -#define bvec_iter_bvec(bvec, iter)				\
>> -((struct bio_vec) {						\
>> -	.bv_page	= bvec_iter_page((bvec), (iter)),	\
>> -	.bv_len		= bvec_iter_len((bvec), (iter)),	\
>> -	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
>> -})
>> +static inline struct bio_vec bvec_iter_bvec(struct bio_vec *bv,
>> +					    struct bvec_iter iter)
>> +{
>> +	return (struct bio_vec) {
>> +		.bv_page	= bvec_iter_page(bv, iter),
>> +		.bv_len		= bvec_iter_len(bv, iter),
>> +		.bv_offset	= bvec_iter_offset(bv, iter)
>> +	};
>> +}
>>
>>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>>  		struct bvec_iter *iter, unsigned bytes)
>>
>> --
>> Jens Axboe
>>
> 
> I tried this patch, doesn't seem to make a huge difference, going from
> 3,958,564 bytes with longest line of 82 kB to 3,943,824 bytes with a
> longest line of 77kB.
> 
> It seems that the .bv_len = ... expansion is what's doing it, so I tried
> patching mp_bvec_iter_len() as well to do a silly ?: thing (sorry), which
> takes us down to 3,880,309 with longest line of 20kB.

Right, I did compile it after the fact and applied the same thing to
mp_bvec_iter_len().

> This is starting to feel like whack-a-mole isn't it? I looked at the next
> longest line, which originates from include/linux/pid_namespace.h believe
> it or not where some compiler cleverness + a loop is resulting in _another_
> combinatorial explosion.

Oh it's certainly whack-a-mole, doesn't mean it's not worth doing for
the low hanging stuff :-)

> Patch attached including Jens's change + mine.

bvec side matches what I have here, fwiw, except I also did
mp_bvec_iter_len(). Didn't see big expansion there, but might as well
keep them consistent.

-- 
Jens Axboe


